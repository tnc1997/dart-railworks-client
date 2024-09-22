import 'package:railworks_client/railworks_client.dart';
import 'package:test/test.dart';

void main() {
  group(
    'RailWorksBlobEncoder',
    () {
      group(
        'convert',
        () {
          test(
            'should return a list that contains 1 element when the input contains 2 characters',
            () {
              expect(
                const RailWorksBlobEncoder().convert(
                  '00',
                ),
                equals(
                  [
                    0x0,
                  ],
                ),
              );
            },
          );

          test(
            'should return a list that contains 2 elements when the input contains 4 characters and 1 carriage return character',
            () {
              expect(
                const RailWorksBlobEncoder().convert(
                  '00\r01',
                ),
                equals(
                  [
                    0x0,
                    0x1,
                  ],
                ),
              );
            },
          );

          test(
            'should return a list that contains 2 elements when the input contains 4 characters and 1 carriage return character and 1 line feed character',
            () {
              expect(
                const RailWorksBlobEncoder().convert(
                  '00\r\n01',
                ),
                equals(
                  [
                    0x0,
                    0x1,
                  ],
                ),
              );
            },
          );

          test(
            'should return a list that contains 2 elements when the input contains 4 characters and 1 line feed character',
            () {
              expect(
                const RailWorksBlobEncoder().convert(
                  '00\n01',
                ),
                equals(
                  [
                    0x0,
                    0x1,
                  ],
                ),
              );
            },
          );

          test(
            'should return a list that contains 2 elements when the input contains 4 characters and 1 space character',
            () {
              expect(
                const RailWorksBlobEncoder().convert(
                  '00 01',
                ),
                equals(
                  [
                    0x0,
                    0x1,
                  ],
                ),
              );
            },
          );

          test(
            'should return a list that contains 0 elements when the input contains 0 characters',
            () {
              expect(
                const RailWorksBlobEncoder().convert(
                  '',
                ),
                equals(
                  [],
                ),
              );
            },
          );

          test(
            'should throw a blob invalid exception when the input contains an invalid character',
            () {
              expect(
                () {
                  const RailWorksBlobEncoder().convert(
                    'zz',
                  );
                },
                throwsA(
                  isA<RailWorksBlobInvalidException>(),
                ),
              );
            },
          );

          test(
            'should throw a blob invalid exception when the input contains an odd number of characters',
            () {
              expect(
                () {
                  const RailWorksBlobEncoder().convert(
                    '0',
                  );
                },
                throwsA(
                  isA<RailWorksBlobInvalidException>(),
                ),
              );
            },
          );
        },
      );
    },
  );
}
