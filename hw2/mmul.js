// Basic matrix multiplication using pure JS as example

const m1 = [[1,2], [3,4]]
const m2 = [[5,6], [7,8]]
const result = [[0,0],[0,0]]

for (let i = 0; i < m1.length; i++) {    
    for (let j = 0; j < m1.length; j++) {
        let temp = 0
        for (let k = 0; k < m1.length; k++) {
            temp += m1[i][k] * m2[k][j]
        }        
        result[i][j] = temp
    }
}

console.log(result)