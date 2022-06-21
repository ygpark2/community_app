import 'dart:io';
import 'package:flutter/services.dart';
import 'package:commune_app/app/modules/web_home/interfaces/local_storage.dart';
import 'package:commune_app/app/modules/web_home/models/board_store.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/app/modules/web_home/services/board_api_service.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../web_home_controller.dart';

part 'home_controller.g.dart';


@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  
  final ILocalStorage _storage = Modular.get();
  final BoardApiService boardApiService = Modular.get<BoardApiService>();
  final WebHomeController webHomeController;

  _HomeControllerBase(this.webHomeController) {
      print("!!!!!!!!!!!!!!!!!!!!!!!1 list controller !!!!!!!!!!!!!!!!!!!!!!!1");

      _init();
  }

  _init() async {

    print('----- HMAC SHA-256 ------');
    hs256();
    print('-------------------------\n');

    print('----- RSA SHA-256 -----');
    // rs256();
    print('-----------------------\n');

    print('----- ECDSA SHA-256 -----');
    es256();
    print('-------------------------');

    var localBoards = await _storage.getAllBoards();

    print("localboards => $localBoards");

    if (localBoards == null) {
      webHomeController.boards = <BoardStore>[].asObservable();
    } else {
      webHomeController.boards = localBoards.asObservable();
    }

    print("-------------------------------------------------------");

    final nodeInfo = await boardApiService.getNodes();
    print(nodeInfo);
    /*
    final shops = await boardApiService.getShops();

    print("=================================");
    print(shops);
    print(shops.hits!);
    // print(value.body.hits.total);
    print(shops.hits!);
    shops.hits!.hits!.forEach((element) {
      print("authors => " + element.source!.authors!);
      print("description => " + element.source!.description!);
      print("publisher => " + element.source!.publisher!);
      print("categories => " + element.source!.categories!);
      print("geoLoc => " + element.source!.geoLoc.toString());
    });
     */
    print("=================================");

    print("++++++++++++++++++++ end api call +++++++++++++++++++++");

  }


// HMAC SHA-256 algorithm
  void hs256() {
    String token;

    /* Sign */ {
      // Create a json web token
      final jwt = JWT(
        {
          'id': 123,
          'server': {
            'id': '3e4fc296',
            'loc': 'euw-2',
          }
        },
        issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
      );

      // Sign it
      token = jwt.sign(SecretKey('secret passphrase'));

      print('Signed token: $token\n');
    }

    /* Verify */ {
      try {
        // Verify a token
        final jwt = JWT.verify(token, SecretKey('secret passphrase'));

        print('Payload: ${jwt.payload}');
      } on JWTExpiredError {
        print('jwt expired');
      } on JWTError catch (ex) {
        print(ex.message); // ex: invalid signature
      }
    }
  }

// RSA SHA-256 algorithm
  void rs256() {
    String token;

    /* Sign */ {
      // Create a json web token
      final jwt = JWT(
        {
          'id': 123,
          'server': {
            'id': '3e4fc296',
            'loc': 'euw-2',
          }
        },
        issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
      );

      // Sign it
      final pem = File('./example/rsa_private.pem').readAsStringSync();
      final key = RSAPrivateKey(pem);

      token = jwt.sign(key, algorithm: JWTAlgorithm.RS256);

      print('Signed token: $token\n');
    }

    /* Verify */ {
      try {
        // Verify a token
        final pem = File('./example/rsa_public.pem').readAsStringSync();
        final key = RSAPublicKey(pem);

        final jwt = JWT.verify(token, key);

        print('Payload: ${jwt.payload}');
      } on JWTExpiredError {
        print('jwt expired');
      } on JWTError catch (ex) {
        print(ex.message); // ex: invalid signature
      }
    }
  }

  // ECDSA SHA-256 algorithm
  void es256() async {
    String token;

    /* Sign */ {
      // Create a json web token
      /*
      "roles": ["admin", "all_access"],
        "iss": "https://localhost",
        "sub": "admin",
        "exp": datetime.utcnow() + timedelta(seconds=3600),
        "iat": datetime.utcnow()
       */
      final jwt = JWT(
        {
          "roles": ["admin", "all_access"],
          "exp": DateTime.now().add( Duration(days: 1) ).millisecondsSinceEpoch,
          "iat": DateTime.now().millisecondsSinceEpoch
        },
        subject: "admin",
        issuer: 'https://localhost',
      );

      // Sign it
      String privateKey = await rootBundle.loadString('keys/id_ecdsa');
      print(privateKey);
      print("--------------------------------------------------");
      final key = ECPrivateKey(privateKey);

      token = jwt.sign(key, algorithm: JWTAlgorithm.ES256);

      print('Signed token: $token\n');
    }

    /* Verify */ {
      try {
        // Verify a token
        String publicKey = await rootBundle.loadString('keys/id_ecdsa.pub');
        final key = ECPublicKey(publicKey);

        final jwt = JWT.verify(token, key);

        print('Payload: ${jwt.payload}, Subject: ${jwt.subject}');
      } on JWTExpiredError {
        print('jwt expired');
      } on JWTError catch (ex) {
        print(ex.message); // ex: invalid signature
      }
    }
  }

  @observable
  ObservableList<int> listBoardToDelete = <int>[].asObservable();

  @observable
  bool isDelete = false;

  @action
  void setIsDelete(bool value) => isDelete = value;

  @action
  void selectToDelete(int idPass) {
    if (!listBoardToDelete.contains(idPass)) {
      listBoardToDelete.add(idPass);
      setIsDelete(true);
    }
  }

  @action
  void removeToDelete(int idPass) {
    listBoardToDelete.remove(idPass);

    if (listBoardToDelete.length == 0) {
      setIsDelete(false);
    }
  }

  /// 
  /// Deleta os gastos
  /// 
  @action
  Future deletePasswordsSelecteds() async {
    webHomeController.boards = webHomeController.boards.where((pass) {
      return !listBoardToDelete.contains(pass.id);
    }).toList().asObservable();

    await _storage.delete(listBoardToDelete.join(','));

    listBoardToDelete = <int>[].asObservable();
    setIsDelete(false);
  }
}
