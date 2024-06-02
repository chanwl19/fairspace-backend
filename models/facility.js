class Facility {
    constructor(facilityId, facilityType, facilityLoc, seatNum, roomNum, facilityCap, computerQty, 
                screenQty, phoneQty, projectorQty, printerQty, scannerQty, whiteboardQty) {
      this.facilityId = facilityId;
      this.facilityType = facilityType;
      this.facilityLoc = facilityLoc;
      this.seatNum = seatNum;
      this.roomNum = roomNum;
      this.facilityCap = facilityCap;
      this.computerQty = computerQty;
      this.screenQty = screenQty;
      this.phoneQty = phoneQty;
      this.projectorQty = projectorQty;
      this.printerQty = printerQty;
      this.scannerQty = scannerQty;
      this.whiteboardQty = whiteboardQty;
    }
  }
  
module.exports = Facility;
