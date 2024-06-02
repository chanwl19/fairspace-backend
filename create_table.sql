DROP TABLE FS_USER;
DROP TABLE FS_RESERVE;
DROP TABLE FS_FACILITY;
DROP TABLE FS_EQUIPMENT;
DROP TABLE FS_REPORT;
DROP TABLE FS_SUPPORT;
DROP SEQUENCE FS_FACILITY_SEQ;
DROP SEQUENCE FS_RESERVE_SEQ;

CREATE TABLE FS_USER (
    user_id       VARCHAR2(9),
    password      VARCHAR2(20),
    user_email    VARCHAR2(50),
    is_admin      VARCHAR2(1),
    is_auth_user  VARCHAR2(1),
    is_management VARCHAR2(1),
    is_it_support VARCHAR2(1)
);

CREATE TABLE FS_RESERVE (
    reserve_id    NUMBER,
    user_id       VARCHAR2(9),
    facility_id   VARCHAR2(9),
    start_time    TIMESTAMP,
    end_time      TIMESTAMP,
    res_status    VARCHAR2(1),
    add_comment   VARCHAR2(500)
);

CREATE TABLE FS_FACILITY (
    facility_id    VARCHAR2(9),
    facility_type  VARCHAR2(1),
    facility_loc   VARCHAR2(5),
    seat_num       VARCHAR2(10),
    room_num       VARCHAR2(10),
    facility_cap   NUMBER(3),
    computer_qty   NUMBER(2),
    screen_qty     NUMBER(2),
    phone_qty      NUMBER(2),
    projector_qty  NUMBER(2),
    printer_qty    NUMBER(2),
    scanner_qty    NUMBER(2),
    whiteboard_qty NUMBER(2)
);

CREATE TABLE FS_REPORT (
    report_id    VARCHAR2(9),
    user_id      VARCHAR2(9),
    gen_date     DATE,
    report_type  VARCHAR2(2)
);

CREATE TABLE FS_SUPPORT (
    case_id         VARCHAR2(9),
    user_id         VARCHAR2(9),
    follow_user_id  VARCHAR2(9),
    open_time       DATE,
    reslove_time    DATE,
    close_time      DATE
);

CREATE SEQUENCE FS_FACILITY_SEQ
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE FS_RESERVE_SEQ
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

INSERT INTO FS_USER VALUES ('301325509','1234','wchan194@my.centennialcollege.ca','Y','N','N','N');   