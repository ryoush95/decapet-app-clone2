import 'package:decapet/models/dto/review_dto.dart';

class AccessTokenFailed {
  AccessTokenFailed();
}

class ChangeInoculation {
  String type = "";
  String date = "";
  String drugName = "";
  int drugUid = 0;
  int petUid = 0;

  ChangeInoculation(this.type, this.date, this.drugUid, this.drugName, this.petUid);
}

class ChangeRecord {
  ChangeRecord();
}

class ChangeReview {
  int recordUid = 0;
  ChangeReview(this.recordUid);
}

class ReserveCancelled {
  ReserveCancelled();
}

class ReviewUpdated {
  int reviewUid;
  ReviewDto review;
  ReviewUpdated(this.reviewUid, this.review);
}

class ReviewWrite {
  int medicalUid;
  ReviewWrite(this.medicalUid);
}

class LikeHospital {
  int hospitalUid;
  String likeYn;
  LikeHospital(this.hospitalUid, this.likeYn);
}

class ReviewDeleted {
  int reviewUid;
  ReviewDeleted(this.reviewUid);
}

class payFinish {
  payFinish();
}

class pointReview {
  pointReview();
}
