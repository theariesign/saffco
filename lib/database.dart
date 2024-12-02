// import 'package:mysql1/mysql1.dart';
//
// class MySQLDatabase {
//   static final _settings = ConnectionSettings(
//     host: 'localhost',       // Ganti dengan host MySQL Anda
//     port: 3306,              // Port default MySQL
//     user: 'root',            // Ganti dengan user MySQL Anda
//     password: 'password',    // Ganti dengan password MySQL Anda
//     db: 'database_name',     // Ganti dengan nama database Anda
//   );
//
//   static Future<MySqlConnection> connect() async {
//     return await MySqlConnection.connect(_settings);
//   }
//
//   // Fungsi untuk Create (Insert)
//   static Future<void> insertUser(String username, String password) async {
//     var db = await connect();
//     await db.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, password]);
//     await db.close();
//   }
//
//   // Fungsi untuk Read (Select)
//   static Future<List<Map<String, dynamic>>> getUsers() async {
//     var db = await connect();
//     var results = await db.query('SELECT * FROM users');
//     var users = results.map((row) => row.fields).toList();
//     await db.close();
//     return users;
//   }
//
//   // Fungsi untuk Update
//   static Future<void> updateUser(int id, String username, String password) async {
//     var db = await connect();
//     await db.query('UPDATE users SET username = ?, password = ? WHERE id = ?', [username, password, id]);
//     await db.close();
//   }
//
//   // Fungsi untuk Delete
//   static Future<void> deleteUser(int id) async {
//     var db = await connect();
//     await db.query('DELETE FROM users WHERE id = ?', [id]);
//     await db.close();
//   }
// }
