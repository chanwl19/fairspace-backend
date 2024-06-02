class Reservation {
    constructor(reserveId, userId, facilityId, startTime, endTime, resStatus, addComment) {
      this.reserveId = reserveId;
      this.userId = userId;
      this.facilityId = facilityId;
      this.startTime = startTime;
      this.endTime = endTime;
      this.resStatus = resStatus;
      this.addComment = addComment;
    }
  }
  
module.exports = Reservation;
