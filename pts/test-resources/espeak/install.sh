#!/bin/sh

tar -xvf gutenberg-science.tar.gz
unzip -o espeak-1.40.02-source.zip
cd espeak-1.40.02-source/src/
sed -i -e "s|/usr|$HOME/espeak_|g" Makefile
sed -i -e "s|/usr|$HOME/espeak_|g" speech.h
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
make install
cd ../..
rm -rf espeak-1.40.02-source/

echo "#!/bin/sh
cd espeak_/bin/
\$TIMER_START
LD_LIBRARY_PATH=$THIS_DIR/espeak_/lib/:\$LD_LIBRARY_PATH ./espeak -f ~/gutenberg-science.txt -w /dev/null 2>&1
echo \$? > ~/test-exit-status
\$TIMER_STOP" > espeak
chmod +x espeak
