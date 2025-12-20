import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_project/services/firebase/firestore/firebase_blog_services.dart';
import 'package:my_project/src/controllers/firebase_auth_controller.dart';
import 'package:my_project/src/models/blog_model.dart';

class BlogController extends GetxController {
  final FirebaseBlogServices _blogServices = FirebaseBlogServices();
  final RxList<BlogModel> _blogs = <BlogModel>[].obs;
  final RxList<BlogModel> _myBlogs = <BlogModel>[].obs;
  final FirebaseAuthController _auth = Get.find<FirebaseAuthController>();
  RxBool isLoading = false.obs;
  List<String> blogCategories = [
    "Technology",
    "Business",
    "Education",
    "Lifestyle",
    "Health",
    "Travel",
    "Finance",
    "Flutter",
    "Firebase",
  ];

  List<BlogModel> get blogs => _blogs;
  List<BlogModel> get myBlogs => _myBlogs;


  @override
  void onInit() {
    super.onInit();
    getAllBlogs();
    // if (_auth.firebaseUser.value != null) {
    //   getMyBlogs(_auth.firebaseUser.value!.uid);
    // }
    ever(_auth.firebaseUser, (user){
      if(user != null){
        getMyBlogs(user.uid);
      }else{
        _myBlogs.clear();
      }
    });
  }

  Future<void> getAllBlogs() async {
    try {
      isLoading(true);
      final blogs = await _blogServices.getAllBlogs();
      _blogs.assignAll(blogs);
    } on FirebaseException catch (e) {
      print(e.message);
    } finally {
      isLoading(false);
    }
  }

  Future<void> getMyBlogs(String uid) async {
    try {
      isLoading(true);
      final blogs = await _blogServices.getMyBlogs(uid);
      _myBlogs.assignAll(blogs);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading(false);
    }
  }

  Future<void> createBlog(BlogModel blog, String uid) async {
    try {
      isLoading(true);
      await _blogServices.createBlog(uid, blog);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading(false);
      getAllBlogs();
      getMyBlogs(uid);
    }
  }

  Future<void> updateBlog(BlogModel blog, String uid) async {
    try {
      isLoading(true);
      await _blogServices.updateBlog(uid, blog);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading(false);
      getAllBlogs();
      getMyBlogs(uid);
    }
  }

  Future<void> deleteBlog(String uid) async {
    try {
      isLoading(true);
      await _blogServices.deleteBlog(uid);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading(false);
      getAllBlogs();
      getMyBlogs(uid);
    }
  }
}
