import '../iterators/circular_buffer_iterator.dart';

class CircularBuffer<E> extends Iterable<E> {
  final List<E?> _buffer;
  int _start;
  int _end;
  int _length;

  CircularBuffer(
    int length,
  )   : _buffer = List<E?>.filled(length, null),
        _start = 0,
        _end = 0,
        _length = 0;

  @override
  E get first {
    return this[_start];
  }

  void set first(
    E element,
  ) {
    _buffer[_start] = element;
  }

  bool get isFull {
    return _length == _buffer.length;
  }

  bool get isNotFull {
    return !isFull;
  }

  @override
  Iterator<E> get iterator {
    return CircularBufferIterator(this);
  }

  @override
  E get last {
    return this[_end];
  }

  void set last(
    E element,
  ) {
    _buffer[_end] = element;
  }

  @override
  int get length {
    return _length;
  }

  E operator [](
    int index,
  ) {
    index = _convertIndex(index);

    final element = _buffer[index];

    if (element is! E) {
      throw RangeError.index(index, this);
    }

    return element;
  }

  void operator []=(
    int index,
    E element,
  ) {
    index = _convertIndex(index);

    _buffer[index] = element;
  }

  void add(
    E element,
  ) {
    addLast(element);
  }

  void addFirst(
    E element,
  ) {
    _start = _decrementIndex(_start);

    _buffer[_start] = element;

    if (isFull) {
      _end = _start;
    } else {
      _length += 1;
    }
  }

  void addLast(
    E element,
  ) {
    _buffer[_end] = element;

    _end = _incrementIndex(_end);

    if (isFull) {
      _start = _end;
    } else {
      _length += 1;
    }
  }

  E removeFirst() {
    final element = this[_start];

    _buffer[_start] = null;

    _start = _incrementIndex(_start);

    _length -= 1;

    return element;
  }

  E removeLast() {
    _end = _decrementIndex(_end);

    final element = this[_end];

    _buffer[_end] = null;

    _length -= 1;

    return element;
  }

  int _convertIndex(
    int index,
  ) {
    return _start + (index < (_length - _start) ? index : index - _length);
  }

  int _decrementIndex(
    int index,
  ) {
    if (index == 0) {
      index = _length;
    }

    return index--;
  }

  int _incrementIndex(
    int index,
  ) {
    if (++index == _length) {
      index = 0;
    }

    return index;
  }
}
