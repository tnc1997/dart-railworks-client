import 'package:railworks_client/railworks_client.dart';
import 'package:test/test.dart';

void main() {
  group(
    'RailWorksBlobDecoder',
    () {
      group(
        'convert',
        () {
          test(
            'should return a string that contains 2 characters when the input contains 1 element',
            () {
              expect(
                const RailWorksBlobDecoder().convert(
                  List.generate(
                    1,
                    (index) {
                      return index;
                    },
                  ),
                ),
                equals(
                  '00',
                ),
              );
            },
          );

          test(
            'should return a string that contains 32 characters and 1 space character when the input contains 16 elements',
            () {
              expect(
                const RailWorksBlobDecoder().convert(
                  List.generate(
                    16,
                    (index) {
                      return index;
                    },
                  ),
                ),
                equals(
                  '0001020304050607 08090a0b0c0d0e0f',
                ),
              );
            },
          );

          test(
            'should return a string that contains 128 characters and 6 space characters and 1 line feed character when the input contains 64 elements',
            () {
              expect(
                const RailWorksBlobDecoder().convert(
                  List.generate(
                    64,
                    (index) {
                      return index;
                    },
                  ),
                ),
                equals(
                  '0001020304050607 08090a0b0c0d0e0f 1011121314151617 18191a1b1c1d1e1f\n2021222324252627 28292a2b2c2d2e2f 3031323334353637 38393a3b3c3d3e3f',
                ),
              );
            },
          );
        },
      );
    },
  );
}
