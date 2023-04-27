package main

import "C"

//export IntSum32
func IntSum32(x, y int32) C.int {
	// 传入 int32 返回 int32
	return C.int(x + y)
}

func main() {
}
