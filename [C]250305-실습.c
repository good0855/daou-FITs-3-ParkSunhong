#include <stdio.h>

int main() {
	
	// 실습 4
	// 4.1 문자열 출력
	printf("실습4번\n\n");
	printf("문자열 :%s\n", "예시 문자열");
	printf("정수형 :%d\n", 4);
	printf("실수형 :%lf\n\n", 5.554);

	// 실습 5
	printf("실습5번\n\n");
	int std_no, kor, world, math;
	double ave;

	std_no = 2013901;
	kor = 89;
	world = 100;
	math = 95;

	ave = (kor + world + math) / 3.0;

	
	printf("%-6s: %d \n", "학번", std_no);
	printf("=======================\n");
	printf("%-6s: %4d(점) \n", "국어", kor);
	printf("%-6s: %4d(점) \n", "세계사", kor);
	printf("%-6s: %4d(점) \n", "수학", kor);
	printf("=======================\n");
	printf("%-6s: %7.2lf \n", "평균", ave);


	return 0;
}
