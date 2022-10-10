param(
    [string]$method_name
)
$jni_libs_path = "../src/main/jniLibs/"
$NDK_ROOT = $Env:ANDROID_NDK_HOME+"\23.1.7779620\toolchains\llvm\prebuilt\windows-x86_64\bin"

$PACKAGE_NAME = "github.com/p4gefau1t/trojan-go"
$VERSION = git describe --tag --abbrev=0
$COMMIT = git rev-parse HEAD
$VAR_SETTING = "-X $PACKAGE_NAME/constant.Version=$VERSION -X $PACKAGE_NAME/constant.Commit=$COMMIT"

function linux_386{
    $path = $jni_libs_path+"x86"
    New-Item -ItemType Directory -Force -Path $path
    go env -u GOARM
    go env -w CGO_ENABLED=1 GOARCH=386 GOOS=android CC=$NDK_ROOT\i686-linux-android21-clang
    go build -v -tags "full" -trimpath -ldflags="-s -w -buildid= $VAR_SETTING" -o $path/libtrojango.so
}

function linux_amd64{
    $path = $jni_libs_path+"x86_64"
    New-Item -ItemType Directory -Force -Path $path
    go env -u GOARM
    go env -w CGO_ENABLED=1 GOARCH=amd64 GOOS=android CC=$NDK_ROOT\x86_64-linux-android21-clang
    go build -v -tags "full" -trimpath -ldflags="-s -w -buildid= $VAR_SETTING" -o $path/libtrojango.so
}
function linux_armv7{
    $path = $jni_libs_path+"armeabi-v7a"
    New-Item -ItemType Directory -Force -Path $path
    go env -w CGO_ENABLED=1 GOARCH=arm GOOS=android GOARM=7 CC=$NDK_ROOT\armv7a-linux-androideabi21-clang
    go build -v -tags "full" -trimpath -ldflags="-s -w -buildid= $VAR_SETTING" -o $path/libtrojango.so
}

function linux_armv8{
    $path = $jni_libs_path+"arm64-v8a"
    New-Item -ItemType Directory -Force -Path $path
    go env -u GOARM
    go env -w CGO_ENABLED=1 GOARCH=arm64 GOOS=android CC=$NDK_ROOT\aarch64-linux-android21-clang
    go build -v -tags "full" -trimpath -ldflags="-s -w -buildid= $VAR_SETTING" -o $path/libtrojango.so
}

function win_386{
    $path = "out/386"
    New-Item -ItemType Directory -Force -Path $path
    go env -u GOARM
    go env -w CGO_ENABLED=0 GOARCH=386 GOOS=windows
    go build -v -tags "full" -trimpath -ldflags="-s -w -buildid= $VAR_SETTING" -o $path/trojango.exe
}

function win_amd64{
    $path = "out/amd64"
    New-Item -ItemType Directory -Force -Path $path
    go env -u GOARM
    go env -w CGO_ENABLED=0 GOARCH=amd64 GOOS=windows
    go build -v -tags "full" -trimpath -ldflags="-s -w -buildid= $VAR_SETTING" -o $path/trojango.exe
}

if ($method_name -eq "linux_386"){
   linux_386
}elseif ($method_name -eq "linux_amd64"){
    linux_amd64
}elseif ($method_name -eq "linux_armv7"){
   linux_armv7
}elseif ($method_name -eq "linux_armv8"){
   linux_armv8
}elseif ($method_name -eq "linux_all"){
    linux_386
    linux_amd64
    linux_armv7
    linux_armv8
}elseif ($method_name -eq "win_386"){
    win_386
}elseif ($method_name -eq "win_amd64"){
    win_amd64
}elseif ($method_name -eq "win_all"){
    win_386
    win_amd64
}