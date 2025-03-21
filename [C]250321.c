#include <stdio.h>
#include <stdlib.h>
#include <oci.h>

void check_error(OCIError* errhp) {
    text errbuf[512];
    sb4 errcode = 0;
    OCIErrorGet(errhp, 1, NULL, &errcode, errbuf, sizeof(errbuf), OCI_HTYPE_ERROR);
    printf("Oracle Error: %s\n", errbuf);
}

int main() {
    OCIEnv* envhp;
    OCIError* errhp;
    OCISvcCtx* svchp;
    OCISession* usrhp;
    OCIServer* srvhp;
    OCIStmt* stmthp;
    OCIDefine* def1 = NULL, * def2 = NULL;
    OCIBind* bnd1 = NULL, * bnd2 = NULL;
    sword status;

    // DB 로그인 정보
    char* username = "C##DEV";
    char* password = "1234"; //오라클 비밀번호는 각자 것으로 쓰세요.
    char* dbname = "localhost:1521/xe";

    // 환경 핸들 초기화
    OCIEnvCreate(&envhp, OCI_DEFAULT, NULL, NULL, NULL, NULL, 0, NULL);
    OCIHandleAlloc(envhp, (void**)&errhp, OCI_HTYPE_ERROR, 0, NULL);
    OCIHandleAlloc(envhp, (void**)&srvhp, OCI_HTYPE_SERVER, 0, NULL);
    OCIServerAttach(srvhp, errhp, (OraText*)dbname, strlen(dbname), OCI_DEFAULT);
    OCIHandleAlloc(envhp, (void**)&svchp, OCI_HTYPE_SVCCTX, 0, NULL);
    OCIAttrSet(svchp, OCI_HTYPE_SVCCTX, srvhp, 0, OCI_ATTR_SERVER, errhp);
    OCIHandleAlloc(envhp, (void**)&usrhp, OCI_HTYPE_SESSION, 0, NULL);
    OCIAttrSet(usrhp, OCI_HTYPE_SESSION, username, strlen(username), OCI_ATTR_USERNAME, errhp);
    OCIAttrSet(usrhp, OCI_HTYPE_SESSION, password, strlen(password), OCI_ATTR_PASSWORD, errhp);
    OCISessionBegin(svchp, errhp, usrhp, OCI_CRED_RDBMS, OCI_DEFAULT);
    OCIAttrSet(svchp, OCI_HTYPE_SVCCTX, usrhp, 0, OCI_ATTR_SESSION, errhp);

    printf("✅ Oracle DB 연결 성공!\n");

    /*** 데이터 삽입 (INSERT) ***/
    char* insert_sql = "INSERT INTO test_table (ID, NAME) VALUES (:1, :2)";
    OCIHandleAlloc(envhp, (void**)&stmthp, OCI_HTYPE_STMT, 0, NULL);
    OCIStmtPrepare(stmthp, errhp, (text*)insert_sql, strlen(insert_sql), OCI_NTV_SYNTAX, OCI_DEFAULT);

    int insert_id = 2;
    char insert_name[50] = "John";

    OCIBindByPos(stmthp, &bnd1, errhp, 1, &insert_id, sizeof(insert_id), SQLT_INT, NULL, NULL, NULL, 0, NULL, OCI_DEFAULT);
    OCIBindByPos(stmthp, &bnd2, errhp, 2, insert_name, sizeof(insert_name), SQLT_STR, NULL, NULL, NULL, 0, NULL, OCI_DEFAULT);

    if (OCIStmtExecute(svchp, stmthp, errhp, 1, 0, NULL, NULL, OCI_COMMIT_ON_SUCCESS) != OCI_SUCCESS) {
        check_error(errhp);
    }
    else {
        printf("✅ 데이터 삽입 완료!\n");
    }

    /*** 데이터 조회 (SELECT) ***/
    char* select_sql = "SELECT ID, NAME FROM test_table";
    OCIHandleAlloc(envhp, (void**)&stmthp, OCI_HTYPE_STMT, 0, NULL);
    OCIStmtPrepare(stmthp, errhp, (text*)select_sql, strlen(select_sql), OCI_NTV_SYNTAX, OCI_DEFAULT);
    OCIStmtExecute(svchp, stmthp, errhp, 0, 0, NULL, NULL, OCI_DEFAULT);

    int id;
    char name[50];

    OCIDefineByPos(stmthp, &def1, errhp, 1, &id, sizeof(id), SQLT_INT, NULL, NULL, NULL, OCI_DEFAULT);
    OCIDefineByPos(stmthp, &def2, errhp, 2, name, sizeof(name), SQLT_STR, NULL, NULL, NULL, OCI_DEFAULT);

    printf("✅ 테이블 조회 결과:\n");
    printf("-----------------------------\n");
    printf("|  ID  |        NAME        |\n");
    printf("-----------------------------\n");

    while ((status = OCIStmtFetch2(stmthp, errhp, 1, OCI_DEFAULT, 0, OCI_DEFAULT)) == OCI_SUCCESS || status == OCI_SUCCESS_WITH_INFO) {
        printf("| %4d | %-18s |\n", id, name);
    }
    printf("-----------------------------\n");

    /*** 데이터 수정 (UPDATE) ***/
    char* update_sql = "UPDATE test_table SET ID = :1 WHERE NAME = :2";
    OCIHandleAlloc(envhp, (void**)&stmthp, OCI_HTYPE_STMT, 0, NULL);
    OCIStmtPrepare(stmthp, errhp, (text*)update_sql, strlen(update_sql), OCI_NTV_SYNTAX, OCI_DEFAULT);

    int update_id = 3;
    char update_where_name[50] = "John";

    OCIBindByPos(stmthp, &bnd1, errhp, 1, &update_id, sizeof(update_id), SQLT_INT, NULL, NULL, NULL, 0, NULL, OCI_DEFAULT);
    OCIBindByPos(stmthp, &bnd2, errhp, 2, update_where_name, sizeof(update_where_name), SQLT_STR, NULL, NULL, NULL, 0, NULL, OCI_DEFAULT);
    printf("실행할 SQL: %s\n", update_sql);

    if (OCIStmtExecute(svchp, stmthp, errhp, 1, 0, NULL, NULL, OCI_COMMIT_ON_SUCCESS) != OCI_SUCCESS) {
        check_error(errhp);
    }
    else {
        printf("✅ 데이터 수정 완료!\n");
    }

    /*** 데이터 삭제 (DELETE) ***/
    char* delete_sql = "DELETE FROM test_table where ID = :1";
    OCIHandleAlloc(envhp, (void**)&stmthp, OCI_HTYPE_STMT, 0, NULL);
    OCIStmtPrepare(stmthp, errhp, (text*)delete_sql, strlen(delete_sql), OCI_NTV_SYNTAX, OCI_DEFAULT);

    int delete_id = 3;

    OCIBindByPos(stmthp, &bnd1, errhp, 1, &delete_id, sizeof(delete_id), SQLT_INT, NULL, NULL, NULL, 0, NULL, OCI_DEFAULT);

    if (OCIStmtExecute(svchp, stmthp, errhp, 1, 0, NULL, NULL, OCI_COMMIT_ON_SUCCESS) != OCI_SUCCESS) {
        check_error(errhp);
    }
    else {
        printf("✅ 데이터 삭제 완료!\n");
    }




    /*** 연결 종료 및 리소스 해제 ***/
    OCIHandleFree(stmthp, OCI_HTYPE_STMT);
    OCISessionEnd(svchp, errhp, usrhp, OCI_DEFAULT);
    OCIServerDetach(srvhp, errhp, OCI_DEFAULT);
    OCIHandleFree(usrhp, OCI_HTYPE_SESSION);
    OCIHandleFree(svchp, OCI_HTYPE_SVCCTX);
    OCIHandleFree(srvhp, OCI_HTYPE_SERVER);
    OCIHandleFree(errhp, OCI_HTYPE_ERROR);
    OCIHandleFree(envhp, OCI_HTYPE_ENV);

    printf("✅ 연결 종료\n");
    return 0;
}
