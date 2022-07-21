#include <iostream>
#include "opencv2/cudaimgproc.hpp"
#include <string>
#include <time.h>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp> // for imshow
#include <cmath>
#include <vector>
using namespace std;
using namespace cv;

int main() {
	for (int p = 0; p < 6; p++) {
		Mat origin_image = imread("./Fig9a/"+to_string(p)+".tif");
		Mat gray = Mat(origin_image.size(), CV_8UC1);
		cv::cvtColor(origin_image, gray, CV_RGB2GRAY);

		int width = gray.cols;
		int height = gray.rows;
		float sum = 0;
		int dx;
		int dy;
		float ds;
		int error = 0;
		for (int i = 1; i < height - 1; i++) {
			for (int j = 1; j < width - 1; j++) {

				if (gray.at<uchar>(Point2i(j + 1, i)) ==0 || gray.at<uchar>(Point2i(j - 1, i)) == 0 || gray.at<uchar>(Point2i(j, i+1)) == 0 || gray.at<uchar>(Point2i(j, i-1)) == 0) {
					error++;
					continue;
				}
				else {
					dx = (gray.at<uchar>(Point2i(j + 1, i)) - gray.at<uchar>(Point2i(j - 1, i)));

					dy = (gray.at<uchar>(Point2i(j, i + 1)) - gray.at<uchar>(Point2i(j, i - 1)));
					ds = sqrt((dx*dx) + (dy*dy) / 2);
					sum += ds;
				}
			}
		}

		float AG = sum / (width*height-error);
		cout << AG << endl;
		
	}getchar();
	return 0;
}