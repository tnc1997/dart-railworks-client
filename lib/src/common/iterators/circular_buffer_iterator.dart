import '../iterables/circular_buffer.dart';

class CircularBufferIterator<E> implements Iterator<E> {
  final CircularBuffer _buffer;
  int _position;

  CircularBufferIterator(
    CircularBuffer buffer,
  )   : _buffer = buffer,
        _position = -1;

  @override
  E get current {
    return _buffer[_position];
  }

  @override
  bool moveNext() {
    return ++_position < _buffer.length;
  }
}
