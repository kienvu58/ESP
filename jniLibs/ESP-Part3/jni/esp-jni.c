#include <stdio.h>
#include <stdlib.h>
#include <jni.h>

jint Java_com_nhom1_esp_esppart3_EDDActivity_eddScheduleJNI(JNIEnv* env, jobject object,
        jintArray id, jintArray C, jintArray D, jint nTasks, jintArray result, jintArray nResults) {

    jint *id_, *C_, *D_, *result_, *nResults_;
    id_ = (*env)->GetIntArrayElements(env, id, NULL);
    C_ = (*env)->GetIntArrayElements(env, C, NULL);
    D_ = (*env)->GetIntArrayElements(env, D, NULL);
    result_ = (*env)->GetIntArrayElements(env, result, NULL);
    nResults_ = (*env)->GetIntArrayElements(env, nResults, NULL);

    jint isSchedulable = (jint) EDD_schedule(id_, C_, D_, nTasks, result_, nResults_);
    return isSchedulable;
}

jint Java_com_nhom1_esp_esppart3_RMActivity_rmScheduleJNI(JNIEnv* env, jobject object,
        jintArray id, jintArray C, jintArray T, jint nTasks, jintArray result, jintArray nResults) {

    jint *id_, *C_, *T_, *result_, *nResults_;
    id_ = (*env)->GetIntArrayElements(env, id, NULL);
    C_ = (*env)->GetIntArrayElements(env, C, NULL);
    T_ = (*env)->GetIntArrayElements(env, T, NULL);
    result_ = (*env)->GetIntArrayElements(env, result, NULL);
    nResults_ = (*env)->GetIntArrayElements(env, nResults, NULL);

    jint isSchedulable = (jint) RM_schedule(id_, C_, T_, nTasks, result_, nResults_);
    return isSchedulable;
}