   CREATE OR REPLACE PACKAGE FS_PKG AS 
      PROCEDURE login(lv_userId_txt       IN FS_USER.user_id%TYPE,
                     lv_password_txt     IN FS_USER.password%TYPE,
                     lv_email_txt        OUT FS_USER.user_email%TYPE,
                     lv_isAdmin_num      OUT NUMBER,
                     lv_isAuthUser_num   OUT NUMBER,
                     lv_isManagement_num OUT NUMBER,
                     lv_isItSupport_num  OUT NUMBER,
                     lv_errorCode_num    OUT NUMBER,
                     lv_errorText_txt    OUT VARCHAR2); 
      
      PROCEDURE create_user(lv_userId_txt       IN FS_USER.user_id%TYPE,
                           lv_password_txt     IN FS_USER.password%TYPE,
                           lv_email_txt        IN FS_USER.user_email%TYPE,
                           lv_isAdmin_txt      IN FS_USER.is_admin%TYPE,
                           lv_isAuthUser_txt   IN FS_USER.is_auth_user%TYPE,
                           lv_isManagement_txt IN FS_USER.is_management%TYPE,
                           lv_isItSupport_txt  IN FS_USER.is_it_support%TYPE,
                           lv_errorCode_num    OUT NUMBER,
                           lv_errorText_txt    OUT VARCHAR2); 
                           
      PROCEDURE add_facility(lv_facilityType_txt       IN FS_FACILITY.facility_type%TYPE,
                              lv_facilityLoc_txt        IN FS_FACILITY.facility_loc%TYPE,
                              lv_seatNum_txt            IN FS_FACILITY.seat_num%TYPE,
                              lv_roomNum_txt            IN FS_FACILITY.room_num%TYPE,
                              lv_facilityCap_num        IN FS_FACILITY.facility_cap%TYPE,
                              lv_computerQty_num        IN FS_FACILITY.computer_qty%TYPE,
                              lv_screenQty_num          IN FS_FACILITY.screen_qty%TYPE,
                              lv_phoneQty_num           IN FS_FACILITY.phone_qty%TYPE,
                              lv_projectorQty_num       IN FS_FACILITY.projector_qty%TYPE,
                              lv_printerQty_num         IN FS_FACILITY.printer_qty%TYPE,
                              lv_scannerQty_num         IN FS_FACILITY.scanner_qty%TYPE,
                              lv_whiteboardQty_num      IN FS_FACILITY.whiteboard_qty%TYPE,
                              lv_errorCode_num          OUT NUMBER,
                              lv_errorText_txt          OUT VARCHAR2);
      
      PROCEDURE modify_facility(lv_facilityId_txt         IN FS_FACILITY.facility_id%TYPE,
                                 lv_facilityType_txt       IN FS_FACILITY.facility_type%TYPE,
                                 lv_facilityLoc_txt        IN FS_FACILITY.facility_loc%TYPE,
                                 lv_seatNum_txt            IN FS_FACILITY.seat_num%TYPE,
                                 lv_roomNum_txt            IN FS_FACILITY.room_num%TYPE,
                                 lv_facilityCap_num        IN FS_FACILITY.facility_cap%TYPE,
                                 lv_computerQty_num        IN FS_FACILITY.computer_qty%TYPE,
                                 lv_screenQty_num          IN FS_FACILITY.screen_qty%TYPE,
                                 lv_phoneQty_num           IN FS_FACILITY.phone_qty%TYPE,
                                 lv_projectorQty_num       IN FS_FACILITY.projector_qty%TYPE,
                                 lv_printerQty_num         IN FS_FACILITY.printer_qty%TYPE,
                                 lv_scannerQty_num         IN FS_FACILITY.scanner_qty%TYPE,
                                 lv_whiteboardQty_num      IN FS_FACILITY.whiteboard_qty%TYPE,
                                 lv_errorCode_num          OUT NUMBER,
                                 lv_errorText_txt          OUT VARCHAR2);

      PROCEDURE delete_facility(lv_facilityId_txt         IN FS_FACILITY.facility_id%TYPE,
                                 lv_errorCode_num          OUT NUMBER,
                                 lv_errorText_txt          OUT VARCHAR2);
      
      PROCEDURE get_facilities(lv_facilities_cur         OUT SYS_REFCURSOR,
                              lv_errorCode_num          OUT NUMBER,
                              lv_errorText_txt          OUT VARCHAR2);
      
      PROCEDURE reserve(lv_userId_txt     IN FS_RESERVE.user_id%TYPE,
                        lv_facilityId_txt IN FS_RESERVE.facility_id%TYPE,
                        lv_startTime_date IN VARCHAR2,
                        lv_endTime_date   IN VARCHAR2,
                        lv_timeFormat_txt IN VARCHAR2,
                        lv_resStatus_txt  IN FS_RESERVE.res_status%TYPE,
                        lv_addComment_txt IN FS_RESERVE.add_comment%TYPE,
                        lv_errorCode_num  OUT NUMBER,
                        lv_errorText_txt  OUT VARCHAR2);
      
      PROCEDURE get_reservation(lv_userId_txt     IN FS_RESERVE.user_id%TYPE,
                                 lv_facilityId_txt IN FS_RESERVE.facility_id%TYPE,
                                 lv_startTime_date IN VARCHAR2,
                                 lv_endTime_date   IN VARCHAR2,
                                 lv_timeFormat_txt IN VARCHAR2, 
                                 lv_resStatus_txt  IN FS_RESERVE.res_status%TYPE,
                                 lv_result_cur     OUT SYS_REFCURSOR,
                                 lv_errorCode_num  OUT NUMBER,
                                 lv_errorText_txt  OUT VARCHAR2);
      
      PROCEDURE modify_reservation(lv_reserveId_num  IN FS_RESERVE.reserve_id%TYPE,
                                   lv_userId_txt     IN FS_RESERVE.user_id%TYPE,
                                   lv_facilityId_txt IN FS_RESERVE.facility_id%TYPE,
                                   lv_startTime_date IN VARCHAR2,
                                   lv_endTime_date   IN VARCHAR2,
                                   lv_timeFormat_txt IN VARCHAR2,
                                   lv_resStatus_txt  IN FS_RESERVE.res_status%TYPE,
                                   lv_addComment_txt IN FS_RESERVE.add_comment%TYPE,
                                   lv_errorCode_num  OUT NUMBER,
                                   lv_errorText_txt  OUT VARCHAR2);

   END FS_PKG; 
   /

   CREATE OR REPLACE PACKAGE BODY FS_PKG AS

   PROCEDURE login(lv_userId_txt       IN FS_USER.user_id%TYPE,
                     lv_password_txt     IN FS_USER.password%TYPE,
                     lv_email_txt        OUT FS_USER.user_email%TYPE,
                     lv_isAdmin_num      OUT NUMBER,
                     lv_isAuthUser_num   OUT NUMBER,
                     lv_isManagement_num OUT NUMBER,
                     lv_isItSupport_num  OUT NUMBER,
                     lv_errorCode_num    OUT NUMBER,
                     lv_errorText_txt    OUT VARCHAR2) IS
   BEGIN
   
      lv_isAdmin_num      :=0;
      lv_isAuthUser_num   :=0;
      lv_isManagement_num :=0;
      lv_isItSupport_num  :=0;
      lv_errorCode_num    :=0;
      lv_errorText_txt    :='';
      
      BEGIN 
         SELECT user_email, DECODE(NVL(is_admin,'N'),'Y',1,0), DECODE(NVL(is_auth_user,'N'),'Y',1,0), 
               DECODE(NVL(is_management,'N'),'Y',1,0), DECODE(NVL(is_it_SUPPORT,'N'),'Y',1,0)
         INTO lv_email_txt, lv_isAdmin_num, lv_isAuthUser_num, 
               lv_isManagement_num, lv_isItSupport_num
         FROM FS_USER
         WHERE user_id = lv_userId_txt
         AND password = lv_password_txt;
      EXCEPTION WHEN no_data_found THEN
         lv_errorCode_num :=-1;
         lv_errorText_txt :='User Id and Password do not match';
                  WHEN others THEN
         lv_errorCode_num :=-1;
         lv_errorText_txt :='An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM;
      END;
   END;

   PROCEDURE create_user(lv_userId_txt        IN FS_USER.user_id%TYPE,
                           lv_password_txt     IN FS_USER.password%TYPE,
                           lv_email_txt        IN FS_USER.user_email%TYPE,
                           lv_isAdmin_txt      IN FS_USER.is_admin%TYPE,
                           lv_isAuthUser_txt   IN FS_USER.is_auth_user%TYPE,
                           lv_isManagement_txt IN FS_USER.is_management%TYPE,
                           lv_isItSupport_txt  IN FS_USER.is_it_support%TYPE,
                           lv_errorCode_num    OUT NUMBER,
                           lv_errorText_txt    OUT VARCHAR2) IS
                           lv_count_num        NUMBER;
      BEGIN

         lv_errorCode_num :=0;
         lv_errorText_txt :='';

         SELECT COUNT(*)
         INTO lv_count_num
         FROM FS_USER 
         WHERE user_id = lv_userId_txt;

         IF lv_count_num > 0 THEN
            lv_errorCode_num :=-1;
            lv_errorText_txt :='User Id already exists';
         ELSE 
            INSERT INTO FS_USER(user_id, password, user_email, is_admin, is_auth_user, is_management, is_it_support)
            VALUES(lv_userId_txt, lv_password_txt, lv_email_txt, lv_isAdmin_txt, lv_isAuthUser_txt, lv_isManagement_txt, lv_isItSupport_txt);
         END IF;

      EXCEPTION WHEN others THEN
         lv_errorCode_num :=-1;
         lv_errorText_txt :='An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM;
      END;
      
      PROCEDURE add_facility(lv_facilityType_txt       IN FS_FACILITY.facility_type%TYPE,
                           lv_facilityLoc_txt        IN FS_FACILITY.facility_loc%TYPE,
                           lv_seatNum_txt            IN FS_FACILITY.seat_num%TYPE,
                           lv_roomNum_txt            IN FS_FACILITY.room_num%TYPE,
                           lv_facilityCap_num        IN FS_FACILITY.facility_cap%TYPE,
                           lv_computerQty_num        IN FS_FACILITY.computer_qty%TYPE,
                           lv_screenQty_num          IN FS_FACILITY.screen_qty%TYPE,
                           lv_phoneQty_num           IN FS_FACILITY.phone_qty%TYPE,
                           lv_projectorQty_num       IN FS_FACILITY.projector_qty%TYPE,
                           lv_printerQty_num         IN FS_FACILITY.printer_qty%TYPE,
                           lv_scannerQty_num         IN FS_FACILITY.scanner_qty%TYPE,
                           lv_whiteboardQty_num      IN FS_FACILITY.whiteboard_qty%TYPE,
                           lv_errorCode_num          OUT NUMBER,
                           lv_errorText_txt          OUT VARCHAR2) IS
                           lv_facilityId_txt         VARCHAR2(20);
      BEGIN

         lv_errorCode_num :=0;
         lv_errorText_txt :='';

         SELECT lv_facilityLoc_txt||'-'||LPAD(FS_FACILITY_SEQ.NEXTVAL,5,'0')
         INTO lv_facilityId_txt
         FROM DUAL;

         INSERT INTO FS_FACILITY(facility_id, facility_type, facility_loc, seat_num, room_num, facility_cap,
                                 computer_qty, screen_qty, phone_qty, projector_qty, printer_qty, scanner_qty, whiteboard_qty)
         VALUES(lv_facilityId_txt, lv_facilityType_txt, lv_facilityLoc_txt, lv_seatNum_txt, lv_roomNum_txt, lv_facilityCap_num,
               lv_computerQty_num, lv_screenQty_num, lv_phoneQty_num, lv_projectorQty_num, lv_printerQty_num, lv_scannerQty_num, lv_whiteboardQty_num);
         

      EXCEPTION WHEN others THEN
         lv_errorCode_num :=-1;
         lv_errorText_txt :='An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM;
      END;               

      PROCEDURE modify_facility(lv_facilityId_txt         IN FS_FACILITY.facility_id%TYPE,
                              lv_facilityType_txt       IN FS_FACILITY.facility_type%TYPE,
                              lv_facilityLoc_txt        IN FS_FACILITY.facility_loc%TYPE,
                              lv_seatNum_txt            IN FS_FACILITY.seat_num%TYPE,
                              lv_roomNum_txt            IN FS_FACILITY.room_num%TYPE,
                              lv_facilityCap_num        IN FS_FACILITY.facility_cap%TYPE,
                              lv_computerQty_num        IN FS_FACILITY.computer_qty%TYPE,
                              lv_screenQty_num          IN FS_FACILITY.screen_qty%TYPE,
                              lv_phoneQty_num           IN FS_FACILITY.phone_qty%TYPE,
                              lv_projectorQty_num       IN FS_FACILITY.projector_qty%TYPE,
                              lv_printerQty_num         IN FS_FACILITY.printer_qty%TYPE,
                              lv_scannerQty_num         IN FS_FACILITY.scanner_qty%TYPE,
                              lv_whiteboardQty_num      IN FS_FACILITY.whiteboard_qty%TYPE,
                              lv_errorCode_num          OUT NUMBER,
                              lv_errorText_txt          OUT VARCHAR2) IS
                              lv_count_num              NUMBER;
      BEGIN

         lv_errorCode_num :=0;
         lv_errorText_txt :='';
         
         UPDATE FS_FACILITY 
         SET facility_type = lv_facilityType_txt, facility_loc = lv_facilityLoc_txt, seat_num = lv_seatNum_txt, room_num = lv_roomNum_txt, 
            facility_cap = lv_facilityCap_num, computer_qty = lv_computerQty_num, screen_qty = lv_screenQty_num, phone_qty = lv_phoneQty_num,
            projector_qty = lv_projectorQty_num, printer_qty = lv_printerQty_num, scanner_qty = lv_scannerQty_num, whiteboard_qty = lv_whiteboardQty_num
         WHERE facility_id = lv_facilityId_txt;
         lv_count_num := SQL%rowcount; 
         
         IF lv_count_num = 0 THEN 
            lv_errorCode_num :=-1;
            lv_errorText_txt :='Facility does not exist';
         ELSIF lv_count_num > 1 THEN
            lv_errorCode_num :=-1;
            lv_errorText_txt :='Facility exists more than once';
         END IF;

      EXCEPTION WHEN others THEN
         lv_errorCode_num :=-1;
         lv_errorText_txt :='An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM;
      END;     

      PROCEDURE delete_facility(lv_facilityId_txt         IN FS_FACILITY.facility_id%TYPE,
                              lv_errorCode_num          OUT NUMBER,
                              lv_errorText_txt          OUT VARCHAR2) IS
                              lv_count_num              NUMBER;
      BEGIN

         lv_errorCode_num :=0;
         lv_errorText_txt :='';

         DELETE FS_FACILITY 
         WHERE facility_id = lv_facilityId_txt;
         lv_count_num := SQL%rowcount; 
         
         IF lv_count_num = 0 THEN 
            lv_errorCode_num :=-1;
            lv_errorText_txt :='Facility does not exist';
         ELSIF lv_count_num > 1 THEN
            lv_errorCode_num :=-1;
            lv_errorText_txt :='Facility exists more than once';
         END IF;

      EXCEPTION WHEN others THEN
         lv_errorCode_num :=-1;
         lv_errorText_txt :='An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM;
      END;  

      PROCEDURE get_facilities(lv_facilities_cur         OUT SYS_REFCURSOR,
                              lv_errorCode_num          OUT NUMBER,
                              lv_errorText_txt          OUT VARCHAR2) IS
      
      BEGIN
         lv_errorCode_num :=0;
         lv_errorText_txt :='';

         OPEN lv_facilities_cur FOR
            SELECT facility_id, facility_type, facility_loc, seat_num, room_num, facility_cap, computer_qty, 
                  screen_qty, phone_qty, projector_qty, printer_qty, scanner_qty, whiteboard_qty
            FROM FS_FACILITY;

      EXCEPTION WHEN others THEN
         lv_errorCode_num :=-1;
         lv_errorText_txt :='An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM;
      END;  

      PROCEDURE reserve(lv_userId_txt     IN FS_RESERVE.user_id%TYPE,
                        lv_facilityId_txt IN FS_RESERVE.facility_id%TYPE,
                        lv_startTime_date IN VARCHAR2,
                        lv_endTime_date   IN VARCHAR2,
                        lv_timeFormat_txt IN VARCHAR2, 
                        lv_resStatus_txt  IN FS_RESERVE.res_status%TYPE,
                        lv_addComment_txt IN FS_RESERVE.add_comment%TYPE,
                        lv_errorCode_num  OUT NUMBER,
                        lv_errorText_txt  OUT VARCHAR2) IS
      BEGIN
         lv_errorCode_num :=0;
         lv_errorText_txt :='';

         INSERT INTO FS_RESERVE(reserve_id, user_id, facility_id, start_time, end_time, res_status, add_comment)
         VALUES(FS_RESERVE_SEQ.NEXTVAL, lv_userId_txt, lv_facilityId_txt, TO_DATE(lv_startTime_date, lv_timeFormat_txt), TO_DATE(lv_endTime_date,lv_timeFormat_txt), lv_resStatus_txt, lv_addComment_txt);

      EXCEPTION WHEN others THEN
         lv_errorCode_num :=-1;
         lv_errorText_txt :='An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM;
      END;        

      PROCEDURE get_reservation(lv_userId_txt     IN  FS_RESERVE.user_id%TYPE,
                              lv_facilityId_txt IN  FS_RESERVE.facility_id%TYPE,
                              lv_startTime_date IN  VARCHAR2,
                              lv_endTime_date   IN  VARCHAR2,
                              lv_timeFormat_txt IN  VARCHAR2, 
                              lv_resStatus_txt  IN  FS_RESERVE.res_status%TYPE,
                              lv_result_cur     OUT SYS_REFCURSOR,
                              lv_errorCode_num  OUT NUMBER,
                              lv_errorText_txt  OUT VARCHAR2) IS
                              lv_sqlStr_txt     VARCHAR2(300);
      BEGIN
         lv_errorCode_num :=0;
         lv_errorText_txt :='';
         lv_sqlStr_txt    :='SELECT reserve_id, user_id, facility_id, start_time, end_time, res_status, add_comment FROM FS_RESERVE WHERE 1=1 ';

         IF lv_userId_txt IS NOT NULL AND TRIM(lv_userId_txt) IS NOT NULL THEN
            lv_sqlStr_txt := lv_sqlStr_txt||' AND user_id = '''||lv_userId_txt||'''';
         END IF;

         IF lv_facilityId_txt IS NOT NULL AND TRIM(lv_facilityId_txt) IS NOT NULL THEN
            lv_sqlStr_txt := lv_sqlStr_txt||' AND facility_id = '''||lv_facilityId_txt||'''';
         END IF;

         IF lv_startTime_date IS NOT NULL AND TRIM(lv_startTime_date) IS NOT NULL THEN
            lv_sqlStr_txt := lv_sqlStr_txt||' AND TRUNC(start_time) >= TRUNC(TO_DATE('''||lv_startTime_date||''','''||lv_timeFormat_txt||'''))';
         END IF;

         IF lv_endTime_date IS NOT NULL AND TRIM(lv_endTime_date) IS NOT NULL THEN
            lv_sqlStr_txt := lv_sqlStr_txt||' AND TRUNC(end_time) <= TRUNC(TO_DATE('''||lv_endTime_date||''','''||lv_timeFormat_txt||'''))';
         END IF;

         IF lv_resStatus_txt IS NOT NULL AND TRIM(lv_resStatus_txt) IS NOT NULL THEN
            lv_sqlStr_txt := lv_sqlStr_txt||' AND res_status = '''||lv_resStatus_txt||'''';
         END IF;

         OPEN lv_result_cur FOR lv_sqlStr_txt;

      EXCEPTION WHEN others THEN
         lv_errorCode_num :=-1;
         lv_errorText_txt :='An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM;
      END;         

      PROCEDURE modify_reservation(lv_reserveId_num  IN FS_RESERVE.reserve_id%TYPE,
                                   lv_userId_txt     IN FS_RESERVE.user_id%TYPE,
                                   lv_facilityId_txt IN FS_RESERVE.facility_id%TYPE,
                                   lv_startTime_date IN VARCHAR2,
                                   lv_endTime_date   IN VARCHAR2,
                                   lv_timeFormat_txt IN VARCHAR2,
                                   lv_resStatus_txt  IN FS_RESERVE.res_status%TYPE,
                                   lv_addComment_txt IN FS_RESERVE.add_comment%TYPE,
                                   lv_errorCode_num  OUT NUMBER,
                                   lv_errorText_txt  OUT VARCHAR2) IS    
                                   lv_update_count   NUMBER;
      BEGIN
         lv_errorCode_num :=0;
         lv_errorText_txt :='';

         UPDATE FS_RESERVE
         SET res_status = lv_resStatus_txt, add_comment = lv_addComment_txt, user_id = lv_userId_txt,
             facility_id = lv_facilityId_txt, start_time = TO_DATE(lv_startTime_date, lv_timeFormat_txt),
             end_time = TO_DATE(lv_endTime_date,lv_timeFormat_txt)
         WHERE reserve_id = lv_reserveId_num;
         lv_update_count := SQL%rowcount;

         IF lv_update_count <> 1 THEN
            lv_errorCode_num :=-2;
            lv_errorText_txt :='Cannot update the record';
         END IF;

      EXCEPTION WHEN others THEN
         lv_errorCode_num :=-1;
         lv_errorText_txt :='An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM;
      END;               

   END FS_PKG;
   /


   