#include <stdio.h>

int main() {
    int triples;
    int value_1, value_2, value_3;
    int i;

    printf("data:\n");
    scanf("%d", &triples);

    int array[triples];

    for (i = 0; i < triples; i++) {
        scanf("%d %d %d", &value_1, &value_2, &value_3);
        if (value_1 < value_2) {
            if (value_1 < value_3) {
                array[i] = value_1;
            } else {
                array[i] = value_3;
            }
        } else {
            if (value_2 < value_3) {
                array[i] = value_2;
            } else {
                array[i] = value_3;
            }
        }
    }

    printf("\n");
    printf("answer:\n");

    for (i = 0; i < triples; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
}
