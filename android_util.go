// +build android

package main

/*
#include <android/api-level.h>
#include <android/fdsan.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <string.h>

#define SDK_INT android_get_device_api_level()

void disableFdSan(){
	if (SDK_INT >= 29){
        void *lib_handle = dlopen("libc.so", RTLD_LAZY);
        if (lib_handle) {
            void (*set_fdsan_error_level)(enum android_fdsan_error_level newlevel) = dlsym(lib_handle, "android_fdsan_set_error_level");
            if (set_fdsan_error_level) {
                set_fdsan_error_level(ANDROID_FDSAN_ERROR_LEVEL_DISABLED);
            }
            dlclose(lib_handle);
        }
	}
}
*/
import "C"

func disableSanitazer() {
	C.disableFdSan()
}