// // ignore_for_file: avoid_redundant_argument_values
// import 'dart:io';

// import 'package:test/test.dart';
// import 'package:todos_api/stories_api.dart';

// void main() {
//   group('Story', () {
//     Story createSubject(
//         {String? id = '1',
//         List<String>? tags = const [],
//         File? file = File('123'),}) {
//       return Story(
//         id: id,
//         title: title,
//         description: description,
//         isCompleted: isCompleted,
//       );
//     }

//     group('constructor', () {
//       test('works correctly', () {
//         expect(
//           createSubject,
//           returnsNormally,
//         );
//       });

//       test('throws AssertionError when id is empty', () {
//         expect(
//           () => createSubject(id: ''),
//           throwsA(isA<AssertionError>()),
//         );
//       });

//       test('sets id if not provided', () {
//         expect(
//           createSubject(id: null).id,
//           isNotEmpty,
//         );
//       });
//     });

//     test('supports value equality', () {
//       expect(
//         createSubject(),
//         equals(createSubject()),
//       );
//     });

//     test('props are correct', () {
//       expect(
//         createSubject().props,
//         equals([
//           '1', // id
//           'title', // title
//           'description', // description
//           true, // isCompleted
//         ]),
//       );
//     });

//     group('copyWith', () {
//       test('returns the same object if not arguments are provided', () {
//         expect(
//           createSubject().copyWith(),
//           equals(createSubject()),
//         );
//       });

//       test('retains the old value for every parameter if null is provided', () {
//         expect(
//           createSubject().copyWith(
//             id: null,
//             title: null,
//             description: null,
//             isCompleted: null,
//           ),
//           equals(createSubject()),
//         );
//       });

//       test('replaces every non-null parameter', () {
//         expect(
//           createSubject().copyWith(
//             id: '2',
//             title: 'new title',
//             description: 'new description',
//             isCompleted: false,
//           ),
//           equals(
//             createSubject(
//               id: '2',
//               title: 'new title',
//               description: 'new description',
//               isCompleted: false,
//             ),
//           ),
//         );
//       });
//     });

//     group('fromJson', () {
//       test('works correctly', () {
//         expect(
//           Story.fromJson(<String, dynamic>{
//             'id': '1',
//             'title': 'title',
//             'description': 'description',
//             'isCompleted': true,
//           }),
//           equals(createSubject()),
//         );
//       });
//     });

//     group('toJson', () {
//       test('works correctly', () {
//         expect(
//           createSubject().toJson(),
//           equals(<String, dynamic>{
//             'id': '1',
//             'title': 'title',
//             'description': 'description',
//             'isCompleted': true,
//           }),
//         );
//       });
//     });
//   });
// }
