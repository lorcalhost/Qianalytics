import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final _key = {
  "type": "service_account",
  "project_id": "contabroad",
  "private_key_id": "357031933ef0f6c4f4c8922fb1163f28fe837362",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCftb+zrVgMPbdG\nx20pjdlB1yj27sw0GUIt+YrilmWY3Fahq05xHpxdJ0oitC8yezJXNCHbJ2MMehLH\nK/VUBNQAxnOQx4x7lJbxpCc6prO5xRMLbDpxCDn0s9dH1pobfxVm1ibhiKORjav/\nkJU7P8mcV3eOhesOx4hIbAVz9Ag7M+Idqnzd2VqG9wTkt85fsnOSKR0s6MSQNG+x\nrF6WZkYrLKDpHZMkJgGIWeooNOwt7Cp1zixkE4BU5gdF44WywooCj7eonvwwAFm6\nSw4QmOBZ7RP78sNXRLEteG7xILt7Ohuoe00GKR69bq0l72GEjswjzb7pMm10dPSc\n9B/aVuoBAgMBAAECggEACH/pNbxGISdQWjV3Lfd3y6+85TYR6xHkZO2mF7yuUoN4\nyX4u8gk8LsmjrJN5/DifQLyBssKhXFgg02BtBtgs74+gNeEmLQDcRFGaqYiWrGPR\nyXwB443EW9gNtIE2JBF63PANE1gCGyx22Lvj8p/ImzKdJm93x4pp9S9pM4xrZbnI\ndfvQPaUZ6YlTkHSikpgYILsnYctmqYYSDRQtFNIvkjlqvmgFLEbY6eIuLKGp17dp\nuhYcoUkeyvaRR7mYwdCzEM7VbTscplnDCoiEx7q0wDpIjpPfE61poH8bDJ0ifMOR\nAnbHQmtte1ckJwxxfrLEFVVgBsot/4Nhw9us3CQ8ywKBgQDKRshELStjCVS1NfnS\nAI2Vk+Am0Mz9MMmtmSX5zmWi6P1KqUFseSGv5CnMJUZXMT9KBjhPbfPHa1zPFiQL\n3Shmfkf2sakiIkk7SKgwMGw+vUyp8tZBwLUXOw8O8KU51TqMyoFItTCMtYkjPRw4\nyGz4cu8mc3NS9ueRAtxNuIEOdwKBgQDKIMZ8KIBL+VdQyY3x2+JHZLc46T6MVF2j\nkEHUBCHuf4KC7NPTqFYbZUEnT2NMhwxoilBpqSKwbbxu9OduIkT+WjGkzLFIRpGM\nDeut0YhOjfsvx66qv6Pfofyucr/n7HsagSsOBukwRP3PO3CCToefGy1mCSB1AB+5\naToCH5oRRwKBgAmKSxnEE57JKuCdGhpIgmUCo3jRMkniyjBQ39SnYm3LlV63GunV\n0LvuA/an72hfXz/LiU5dvjiynJ77yVlx5dznqdc9y99bRJ7yL1SOhBx1ay88z9Qs\nFZ5x36Txvqk6oFdRmcVnHlIUodIyqKkY8uLI8PScT10jXgqd2uwjfprDAoGAZ4YN\n4r1jqIXWYLw6hStXY7WD2hQsQvda1lEmRg6vylVoZOIjQ/6ty246xoV0mFd61Xgx\n40wLRk2N+05X0iKfL57GWl+0VQ4/sXnXwbjVlVZG1pvxK+bnabyvjDGddI28J0EM\n6ixD9sL/M8p/v121PJpQ0DfQddxQY0gvu7Kv2DUCgYAgmndKvfYyA1CJQQD/vCOC\nYSSKclp22vQPOqWIPJr52KcuKxkGpdWlrEI2YZten63VorYiScbZ0orTXgGYZtuI\nl43XXofn7UqfkG9Ot0rMEvCyHmc4Ik50gDNCMqoLVHnadmItY+lRLVKJZmiYIVKI\nAB3RORBLaADTsBtFq1pPxg==\n-----END PRIVATE KEY-----\n",
  "client_email": "qianalytics@contabroad.iam.gserviceaccount.com",
  "client_id": "117509789833121272017",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/qianalytics%40contabroad.iam.gserviceaccount.com"
};
String b = '';
//const scopes = const [StorageApi.DevstorageFullControlScope];
//const scopes = const ["https://accounts.google.com/ https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/drive.file https://www.googleapis.com/auth/drive.resource https://www.googleapis.com/auth/spreadsheets https://spreadsheets.google.com/feeds https://spreadsheets.google.com/feeds/ http://spreadsheets.google.com/feeds http://spreadsheets.google.com/feeds/ https://spreadsheets.google.com/feeds/spreadsheets https://spreadsheets.google.com/feeds/spreadsheets/private/full http://spreadsheets.google.com/feeds/spreadsheets/private/full https://spreadsheets.google.com/feeds/worksheets/ https://spreadsheets.google.com/tq https://spreadsheets.google.com/feeds/list/ https://spreadsheets.google.com/feeds/worksheet/ https://spreadsheets.google.com/feeds/cell/"];
const scopes = const [SheetsApi.SpreadsheetsScope];

class LoginClass {

  static login() async {
    obtainAccessCredentialsViaServiceAccount(
            ServiceAccountCredentials.fromJson(_key), scopes, http.Client())
        .then((AccessCredentials cred) {
      AuthClient client = authenticatedClient(http.Client(), cred);
      client.put("https://sheets.googleapis.com/v4/spreadsheets/13KtcL_MLSnnwDxGXGCn5k43fbKdAO-Rd8fsU1JIC6XU/values/72019!A1:D5?valueInputOption=USER_ENTERED");
      SheetsApi api = new SheetsApi(client);
      var a = api.spreadsheets.get('13KtcL_MLSnnwDxGXGCn5k43fbKdAO-Rd8fsU1JIC6XU');
      
      b = api.spreadsheets.values.get('13KtcL_MLSnnwDxGXGCn5k43fbKdAO-Rd8fsU1JIC6XU', 'A1').toString();
      
      ValueRange vr = new ValueRange.fromJson({
        "values": [
          [
            // fields A - J
            "15/02/2019", "via API 3", "5", "3", "3", "3", "3", "3", "3", "3"
          ]
        ]
      });
      print('about to append');
      /*api.spreadsheets.values
          .append(vr, '13KtcL_MLSnnwDxGXGCn5k43fbKdAO-Rd8fsU1JIC6XU', 'A:J',
              valueInputOption: 'USER_ENTERED')
          .then((AppendValuesResponse r) {
        print('append completed.');
        client.close();
      });*/

      /*clientViaServiceAccount(_key, _SCOPES).then((http_client) {
      var storage = new StorageApi(http_client);
      SheetsApi api = SheetsApi(http_client);
      api.spreadsheets.values.get('13KtcL_MLSnnwDxGXGCn5k43fbKdAO-Rd8fsU1JIC6XU', 'A1');*/
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sheets', b);
  }
}
