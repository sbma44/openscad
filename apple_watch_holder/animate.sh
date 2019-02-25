set -eu -o pipefail
for f in frame00*.png; do
	gm convert -crop 778x490 $f $(basename $f .png)-c.png
done
ffmpeg -r 30 -f image2 -s 778x490 -i frame%05d-c.png -vcodec libx264 -crf 25  -pix_fmt yuv420p test.mp4