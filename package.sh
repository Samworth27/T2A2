cp docs ../ -r
cp README.md ../README.md
cd ../..

zip -r  SamMitchell_T2A2.zip SamMitchell_T2A2 -x '*.git*' -x '*cache*'