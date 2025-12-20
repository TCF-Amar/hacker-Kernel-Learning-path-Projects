import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/src/models/blog_model.dart';

class FirebaseBlogServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collectionName = "blogs";

  Future<List<BlogModel>> getAllBlogs() async {
    final snapshot = await _db
        .collection(collectionName)
        // .orderBy("createdAt")
        .get();
    return snapshot.docs
        .map((doc) => BlogModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<BlogModel>> getMyBlogs(String uid) async {
    final snapshot = await _db
        .collection(collectionName)
        .where('authorId', isEqualTo: uid)
        // .orderBy('crea/**/tedAt')
        .get();
    return snapshot.docs
        .map((doc) => BlogModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> createBlog(String uid, BlogModel blog) async {
    await _db.collection(collectionName).doc().set(blog.toMap());
  }

  Future<void> updateBlog(String uid, BlogModel blog) async {
    await _db.collection(collectionName).doc(uid).update(blog.toMap());
  }

  Future<void> deleteBlog(String uid) async {
    await _db.collection(collectionName).doc(uid).delete();
  }
}
