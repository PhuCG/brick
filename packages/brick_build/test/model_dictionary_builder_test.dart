import 'package:brick_build/src/builders/model_dictionary_builder.dart';
import 'package:test/test.dart';

void main() {
  group('ModelDictionaryBuilder.classDeclaration', () {
    final pattern = ModelDictionaryBuilder.classDeclaration('Post');

    test('matches a single-line declaration', () {
      expect('class Post extends OfflineFirstModel {}', contains(pattern));
    });

    test('matches a line break after the class name', () {
      expect('class Post\n    extends OfflineFirstModel {}', contains(pattern));
    });

    test('matches a line break after `class`', () {
      expect('class\n  Post extends OfflineFirstModel {}', contains(pattern));
    });

    test('matches type parameters directly after the class name', () {
      expect('class Post<T> extends OfflineFirstModel {}', contains(pattern));
    });

    test('does not match a class that only starts with the name', () {
      expect('class PostDraft extends OfflineFirstModel {}', isNot(contains(pattern)));
    });

    test('does not match an unrelated class', () {
      expect('class Comment extends OfflineFirstModel {}', isNot(contains(pattern)));
    });

    test('escapes regex characters in the class name', () {
      final dollar = ModelDictionaryBuilder.classDeclaration(r'Post$');
      expect(r'class Post$ extends OfflineFirstModel {}', contains(dollar));
      expect('class Post extends OfflineFirstModel {}', isNot(contains(dollar)));
    });
  });
}
