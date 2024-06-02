const oracledb = require('oracledb');
Facility = require('../models/facility');
Reservation = require('../models/reservation');

const dbPassword = `${process.env.DB_PASSWORD}`;
const dbUser = `${process.env.DB_USER}`;
const connectionString = `${process.env.CONNECTION_STRING}`;

async function getConnection(){
  try {
    const connection = await oracledb.getConnection({
      user: dbUser,
      password: dbPassword,
      connectString: connectionString
    });
    return connection;
  } catch (err) {
    console.error(err.message);
  }
  return null;
}

async function logIn(userName, password) {
    const connection = await getConnection();
    try {
      if (connection){
        const binds = { 
          userName: userName,
          password: password,
          userEmail : { dir: oracledb.BIND_OUT, type: oracledb.STRING },
          isAdmin : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER },
          isAuthUser : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER},
          isManagement : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER},
          isItSupport : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER},
          errorCode : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER},
          errorText : { dir: oracledb.BIND_OUT, type: oracledb.STRING }
        };
        const result = await connection.execute(
          `BEGIN
              FS_PKG.LOGIN(:userName, :password, :userEmail, :isAdmin, :isAuthUser,
                           :isManagement, :isItSupport, :errorCode, :errorText);
          END;`,
          binds
        );
        return result.outBinds;
      }
      return "Error....";
    } catch (err) {
      console.error(err.message);
    } finally {
      if (connection) {
        try {
          await connection.close(); 
        } catch (err) {
          console.error(err.message);
        }
      }
    }
}

async function createUser(user) {
  const connection = await getConnection();
  try {
    if (connection){
      const binds = { 
        userName: user.userName,
        password: user.password,
        userEmail : user.userEmail,
        isAdmin : user.isAdmin ? "Y" : "N",
        isAuthUser : user.isAuthUser ? "Y" : "N",
        isManagement : user.isManagement ? "Y" : "N",
        isItSupport : user.isItSupport ? "Y" : "N",
        errorCode : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER},
        errorText : { dir: oracledb.BIND_OUT, type: oracledb.STRING }
      };
      const result = await connection.execute(
        `BEGIN
            FS_PKG.CREATE_USER(:userName, :password, :userEmail, :isAdmin, :isAuthUser,
                               :isManagement, :isItSupport, :errorCode, :errorText);
        END;`,
        binds
      );
      if (result.outBinds.errorCode === 0 ){
        connection.commit();
      }
      return result.outBinds;
    }
    return "Error....";
  } catch (err) {
    console.error(err.message);
  } finally {
    if (connection) {
      try {
        await connection.close(); 
      } catch (err) {
        console.error(err.message);
      }
    }
  }
}

async function addFacility(facility) {
  const connection = await getConnection();
  try {
    if (connection){
      const binds = { 
        facilityType: facility.facilityType,
        facilityLoc : facility.facilityLoc,
        seatNum : facility.seatNum,
        roomNum : facility.roomNum,
        facilityCap : facility.facilityCap,
        computerQty : facility.computerQty, 
        screenQty : facility.screenQty,
        phoneQty : facility.phoneQty,
        projectorQty : facility.projectorQty,
        printerQty : facility.printerQty,
        scannerQty : facility.scannerQty,
        whiteboardQty : facility.whiteboardQty,
        errorCode : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER},
        errorText : { dir: oracledb.BIND_OUT, type: oracledb.STRING }
      };
      const result = await connection.execute(
        `BEGIN
            FS_PKG.ADD_FACILITY(:facilityType, :facilityLoc, :seatNum, :roomNum, 
                                :facilityCap, :computerQty, :screenQty, :phoneQty,
                                :projectorQty, :printerQty, :scannerQty, :whiteboardQty,
                                :errorCode, :errorText);
        END;`,
        binds
      );
      if (result.outBinds.errorCode === 0 ){
        connection.commit();
      }
      return result.outBinds;
    }
    return "Error....";
  } catch (err) {
    console.error(err.message);
  } finally {
    if (connection) {
      try {
        await connection.close(); 
      } catch (err) {
        console.error(err.message);
      }
    }
  }
}

async function modifyFacility(facility) {
  const connection = await getConnection();
  try {
    if (connection){
      const binds = { 
        facilityId : facility.facilityId,
        facilityType: facility.facilityType,
        facilityLoc : facility.facilityLoc,
        seatNum : facility.seatNum,
        roomNum : facility.roomNum,
        facilityCap : facility.facilityCap,
        computerQty : facility.computerQty, 
        screenQty : facility.screenQty,
        phoneQty : facility.phoneQty,
        projectorQty : facility.projectorQty,
        printerQty : facility.printerQty,
        scannerQty : facility.scannerQty,
        whiteboardQty : facility.whiteboardQty,
        errorCode : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER},
        errorText : { dir: oracledb.BIND_OUT, type: oracledb.STRING }
      };
      const result = await connection.execute(
        `BEGIN
            FS_PKG.MODIFY_FACILITY(:facilityId, :facilityType, :facilityLoc, :seatNum, :roomNum, 
                                   :facilityCap, :computerQty, :screenQty, :phoneQty,
                                   :projectorQty, :printerQty, :scannerQty, :whiteboardQty,
                                   :errorCode, :errorText);
        END;`,
        binds
      );
      if (result.outBinds.errorCode === 0 ){
        connection.commit();
      }
      return result.outBinds;
    }
    return "Error....";
  } catch (err) {
    console.error(err.message);
  } finally {
    if (connection) {
      try {
        await connection.close(); 
      } catch (err) {
        console.error(err.message);
      }
    }
  }
}
  
async function deleteFacility(facility) {
  const connection = await getConnection();
  try {
    if (connection){
      const binds = { 
        facilityId : facility.facilityId,
        errorCode : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER},
        errorText : { dir: oracledb.BIND_OUT, type: oracledb.STRING }
      };
      const result = await connection.execute(
        `BEGIN
            FS_PKG.DELETE_FACILITY(:facilityId, :errorCode, :errorText);
        END;`,
        binds
      );
      if (result.outBinds.errorCode === 0 ){
        connection.commit();
      }
      return result.outBinds;
    }
    return "Error....";
  } catch (err) {
    console.error(err.message);
  } finally {
    if (connection) {
      try {
        await connection.close(); 
      } catch (err) {
        console.error(err.message);
      }
    }
  }
}

async function getFacilities() {
  const connection = await getConnection();
  try {
    if (connection){
      const binds = { 
        cursor: { dir: oracledb.BIND_OUT, type: oracledb.CURSOR },
        errorCode : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER},
        errorText : { dir: oracledb.BIND_OUT, type: oracledb.STRING }
      };
      const result = await connection.execute(
        `BEGIN
            FS_PKG.GET_FACILITIES(:cursor, :errorCode, :errorText);
        END;`,
        binds
      );
      const facilities = [];
      const cursor = result.outBinds.cursor;

      while ((row = await cursor.getRow())) {
        const facility = new Facility(row[0],row[1],row[2],row[3],row[4],row[5],
                                      row[6],row[7],row[8],row[9],row[10],row[11], row[12]);
        facilities.push(facility);
      }

      await cursor.close();
      
      return {facilities: facilities, errorCode: result.outBinds.errorCode, errorText: result.outBinds.errorText};
    }
    return "Error....";
  } catch (err) {
    console.error(err.message);
  } finally {
    if (connection) {
      try {
        await connection.close(); 
      } catch (err) {
        console.error(err.message);
      }
    }
  }
}

async function reserve(reservation, timeFormat) {
  const connection = await getConnection();
  try {
    if (connection){
      const binds = { 
        userId : reservation.userId,
        facilityId : reservation.facilityId, 
        startTime : reservation.startTime, 
        endTime : reservation.endTime, 
        timeFormat : timeFormat,
        resStatus : reservation.resStatus, 
        addComment : reservation.addComment,
        errorCode : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER},
        errorText : { dir: oracledb.BIND_OUT, type: oracledb.STRING }
      };
      const result = await connection.execute(
        `BEGIN
            FS_PKG.RESERVE(:userId, :facilityId, :startTime, :endTime, :timeFormat,
                           :resStatus, :addComment, :errorCode, :errorText);
        END;`,
        binds
      );
      
      if (result.outBinds.errorCode === 0 ){
        connection.commit();
      }
      return result.outBinds;
    }
    return "Error...";
  } catch (err) {
    console.error(err.message);
  } finally {
    if (connection) {
      try {
        await connection.close(); 
      } catch (err) {
        console.error(err.message);
      }
    }
  }
}

async function getReservations(reserve, timeFormat) {
  const connection = await getConnection();
  try {
    if (connection){
      const binds = { 
        userId      : reserve.userId ? reserve.userId : null,
        facilityId  : reserve.facilityId ? reserve.facilityId : null,
        startTime   : reserve.startTime ? reserve.startTime : null,
        endTime     : reserve.endTime ? reserve.endTime : null,
        timeFormat  : timeFormat,
        resStatus   : reserve.resStatus ? reserve.resStatus : null,
        cursor      : { dir: oracledb.BIND_OUT, type: oracledb.CURSOR },
        errorCode   : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER},
        errorText   : { dir: oracledb.BIND_OUT, type: oracledb.STRING }
      };
      const result = await connection.execute(
        `BEGIN
            FS_PKG.GET_RESERVATION(:userId, :facilityId, :startTime, :endTime, :timeFormat,
                                   :resStatus, :cursor, :errorCode, :errorText);
        END;`,
        binds
      );
      const reservations = [];
      const cursor = result.outBinds.cursor;
      console.log(cursor);

      while ((row = await cursor.getRow())) {
        const reservation = new Reservation(row[0],row[1],row[2],row[3],row[4],row[5], row[6]);
        reservations.push(reservation);
      }

      await cursor.close();
      
      return {reservations: reservations, errorCode: result.outBinds.errorCode, errorText: result.outBinds.errorText};
    }
    return "Error....";
  } catch (err) {
    console.error(err.message);
  } finally {
    if (connection) {
      try {
        await connection.close(); 
      } catch (err) {
        console.error(err.message);
      }
    }
  }
}

async function modifyReservations(reservation, timeFormat) {
  const connection = await getConnection();
  try {
    if (connection){
      const binds = { 
        reserveId : reservation.reserveId,
        userId : reservation.userId,
        facilityId : reservation.facilityId, 
        startTime : reservation.startTime, 
        endTime : reservation.endTime, 
        timeFormat : timeFormat,
        resStatus : reservation.resStatus, 
        addComment : reservation.addComment,
        errorCode : { dir: oracledb.BIND_OUT, type: oracledb.DB_TYPE_NUMBER},
        errorText : { dir: oracledb.BIND_OUT, type: oracledb.STRING }
      };
      const result = await connection.execute(
        `BEGIN
            FS_PKG.MODIFY_RESERVATION(:reserveId, :userId, :facilityId, :startTime, :endTime, :timeFormat,
                                      :resStatus, :addComment, :errorCode, :errorText);
        END;`,
        binds
      );
      
      if (result.outBinds.errorCode === 0 ){
        connection.commit();
      }
      return result.outBinds;
    }
    return "Error...";
  } catch (err) {
    console.error(err.message);
  } finally {
    if (connection) {
      try {
        await connection.close(); 
      } catch (err) {
        console.error(err.message);
      }
    }
  }
}

module.exports.logIn = logIn;
module.exports.createUser = createUser;
module.exports.addFacility = addFacility;
module.exports.modifyFacility = modifyFacility;
module.exports.deleteFacility = deleteFacility;
module.exports.getFacilities = getFacilities;
module.exports.reserve = reserve;
module.exports.getReservations = getReservations;
module.exports.modifyReservations = modifyReservations;