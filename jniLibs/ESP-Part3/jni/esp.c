#include <stdio.h>
#include <stdlib.h>
#include <math.h>

struct Task {
    int id;     // task id
    int C;      // execution time
    int D;      // deadline
    int T;      // period
};

/**
  * Function: EDD_schedule
  * -------------------------
  * schedules given tasks using Earliest Dealine Due algorithm
  *
  * id: array of task id
  * C: array of task execution time
  * D: array of task deadline
  * nTasks: number of tasks
  * result: address to store the schedule
  * nResults: address to store number of results
  *
  * returns: 1 if schedulalbe 0 otherwise.
  */
int EDD_schedule(int id[], int C[], int D[], int nTasks, int result[], int *nResults) {
    struct Task task[nTasks];
    int i, j;

    for (i = 0; i < nTasks; i++) {
        task[i].id = id[i];
        task[i].C = C[i];
        task[i].D = D[i];
    }

    // sorts tasks ascending order by deadline
    for (i = 0; i < nTasks - 1; i++) {
        for (j = i + 1; j < nTasks; j++) {
            if(task[i].D > task[j].D) {
                struct Task temp = task[i];
                task[i] = task[j];
                task[j] = temp;
            }
        }
    }

    // checks if tasks are schedulable
    int C_accumulator = 0;
    for (i = 0; i < nTasks; i++) {
        C_accumulator += task[i].C;
        if (C_accumulator > task[i].D) {
            return 0;
        }
    }

    // schedules
    *nResults = C_accumulator;

    int index = 0;
    for (i = 0; i < nTasks; i++) {
        for (j = 0; j < task[i].C; j++) {
            result[index++] = task[i].id;
        }
    }
    return 1;
}

/**
  * Function: gcd
  * -------------------------
  *
  * returns: greatest common divisor of a and b.
  */
int gcd(int a, int b) {
    int c;
    while (a != 0) {
        c = a; a = b%a;  b = c;
    }
    return b;
}

/**
  * Function: RM_schedule
  * -------------------------
  * schedules given tasks using Rate-Monotonic algorithm
  *
  * id: array of task id
  * C: array of task execution time
  * T: array of task period
  * nTasks: number of tasks
  * result: address to store the schedule
  * nResults: address to store number of results
  *
  * returns: 1 if schedulalbe 0 otherwise.
  */
int RM_schedule(int id[], int C[], int T[], int nTasks, int result[], int *nResults) {
    struct Task task[nTasks];
    int i, j;
    double U = 0;    // CPU utilization of a task set
    for(i = 0; i < nTasks; i++) {
        task[i].id = id[i];
        task[i].C = C[i];
        task[i].T = T[i];
        U += C[i]/T[i];
    }

    // checks if tasks are schedulable
    double B = nTasks * (pow(2, 1/nTasks) - 1);
    if (U > B) {
        return 0;
    }

    // sorts tasks ascending order by period T
    for(i = 0; i < nTasks; i++) {
        for(j = i + 1; j < nTasks; j++) {
            if(task[i].T > task[j].T) {
                struct Task temp = task[i];
                task[i] = task[j];
                task[j] = temp;
            }
        }
    }

    *nResults = 1;     // least common multiple of all periods
    // computes nResult
    for (i = 0; i < nTasks; i++) {
        int divisor = gcd(*nResults, task[i].T);
        *nResults = (*nResults * task[i].T) / divisor;
    }

    // initializes
    for (i = 0; i < *nResults; i++) {
        result[i] = -1;
    }

    for (i = 0; i < nTasks; i++) {
        int current = 0;
        while (current < *nResults) {
            int j = 0;
            int count = 0;
            while ((current + j < *nResults) && (count < task[i].C) && (count < current + task[i].T)) {
                // if there is no task at current + j
                if (result[current + j] == -1) {
                    result[current + j] = task[i].id;
                    count++;
                }
                j++;
            }
            current += task[i].T;
        }
    }
    return 1;
}