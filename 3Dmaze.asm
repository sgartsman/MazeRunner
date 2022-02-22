IDEAL
;/-------------------------\
;===========================
;===========================
;	  	 	notes
;===========================
;===========================
;\-------------------------/

;written by:
;	Shiran Gartsman
;date: 27/05/2021

;A 3D and 2D maze game

;/-------------------------\
;===========================
;===========================
;	  	 initiation
;===========================
;===========================
;\-------------------------/

MODEL small
STACK 100h
DATASEG

;/-------------------------\
;===========================
;===========================
;	  	Static Data
;===========================
;===========================
;\-------------------------/


BB db 'See you next time!$'

;Table to get Sin(x) and Cos(x) of Angle
sin_table 	db 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12
			db 12, 12, 12, 12, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 14, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19, 19, 19, 19, 19, 19, 20, 20, 20, 20, 20, 20, 20, 20
			db 20, 20, 21, 21, 21, 21, 21, 21, 21, 21, 21, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 28, 28, 28, 28, 28
			db 28, 28, 28, 28, 28, 28, 28, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 34, 34, 34, 34, 34, 34
			db 34, 34, 34, 34, 34, 34, 34, 34, 34, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38
			db 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40
			db 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40
			db 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37
			db 37, 37, 37, 37, 37, 37, 37, 37, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 32, 32, 32, 32, 32
			db 32, 32, 32, 32, 32, 32, 32, 32, 32, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26
			db 26, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 20, 20, 20, 20, 20, 20, 20, 20, 20, 19, 19, 19, 19, 19, 19, 19, 19, 19, 18, 18, 18, 18, 18, 18, 18, 18, 18
			db 17, 17, 17, 17, 17, 17, 17, 17, 17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 14, 14, 14, 14, 14, 14, 14, 14, 14, 13, 13, 13, 13, 13, 13, 13, 13, 12, 12, 12, 12, 12, 12, 12, 12, 12, 11, 11, 11, 11, 11, 11, 11, 11, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9, 9, 9, 9, 9, 9, 9, 9, 8, 8, 8
			db 8, 8, 8, 8, 8, 8, 7, 7, 7, 7, 7, 7, 7, 7, 6, 6, 6, 6, 6, 6, 6, 6, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1, -1, -1, -1, -2, -2, -2, -2, -2, -2, -2, -2, -3, -3, -3, -3, -3, -3, -3, -3, -3
			db -4, -4, -4, -4, -4, -4, -4, -4, -5, -5, -5, -5, -5, -5, -5, -5, -6, -6, -6, -6, -6, -6, -6, -6, -7, -7, -7, -7, -7, -7, -7, -7, -8, -8, -8, -8, -8, -8, -8, -8, -8, -9, -9, -9, -9, -9, -9, -9, -9, -10, -10, -10, -10, -10, -10, -10, -10, -10, -11, -11, -11, -11, -11, -11, -11, -11, -12, -12, -12, -12, -12, -12, -12
			db -12, -12, -13, -13, -13, -13, -13, -13, -13, -13, -14, -14, -14, -14, -14, -14, -14, -14, -14, -15, -15, -15, -15, -15, -15, -15, -15, -15, -16, -16, -16, -16, -16, -16, -16, -16, -16, -17, -17, -17, -17, -17, -17, -17, -17, -17, -18, -18, -18, -18, -18, -18, -18, -18, -18, -19, -19, -19, -19, -19, -19, -19, -19
			db -19, -20, -20, -20, -20, -20, -20, -20, -20, -20, -21, -21, -21, -21, -21, -21, -21, -21, -21, -21, -22, -22, -22, -22, -22, -22, -22, -22, -22, -22, -23, -23, -23, -23, -23, -23, -23, -23, -23, -23, -24, -24, -24, -24, -24, -24, -24, -24, -24, -24, -25, -25, -25, -25, -25, -25, -25, -25, -25, -25, -26, -26, -26
			db -26, -26, -26, -26, -26, -26, -26, -26, -27, -27, -27, -27, -27, -27, -27, -27, -27, -27, -27, -28, -28, -28, -28, -28, -28, -28, -28, -28, -28, -28, -29, -29, -29, -29, -29, -29, -29, -29, -29, -29, -29, -29, -30, -30, -30, -30, -30, -30, -30, -30, -30, -30, -30, -30, -30, -31, -31, -31, -31, -31, -31, -31, -31
			db -31, -31, -31, -31, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -33, -33, -33, -33, -33, -33, -33, -33, -33, -33, -33, -33, -33, -33, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -35, -35, -35, -35, -35, -35, -35, -35, -35, -35, -35, -35, -35, -35, -35
			db -35, -35, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38
			db -38, -38, -38, -38, -38, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40
			db -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40
			db -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -40, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -39, -38, -38, -38, -38, -38
			db -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -38, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -37, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -36, -35
			db -35, -35, -35, -35, -35, -35, -35, -35, -35, -35, -35, -35, -35, -35, -35, -35, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -34, -33, -33, -33, -33, -33, -33, -33, -33, -33, -33, -33, -33, -33, -33, -33, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -31, -31, -31, -31
			db -31, -31, -31, -31, -31, -31, -31, -31, -31, -30, -30, -30, -30, -30, -30, -30, -30, -30, -30, -30, -30, -29, -29, -29, -29, -29, -29, -29, -29, -29, -29, -29, -29, -28, -28, -28, -28, -28, -28, -28, -28, -28, -28, -28, -28, -27, -27, -27, -27, -27, -27, -27, -27, -27, -27, -27, -26, -26, -26, -26, -26, -26, -26
			db -26, -26, -26, -25, -25, -25, -25, -25, -25, -25, -25, -25, -25, -25, -24, -24, -24, -24, -24, -24, -24, -24, -24, -24, -23, -23, -23, -23, -23, -23, -23, -23, -23, -23, -22, -22, -22, -22, -22, -22, -22, -22, -22, -22, -21, -21, -21, -21, -21, -21, -21, -21, -21, -20, -20, -20, -20, -20, -20, -20, -20, -20, -20
			db -19, -19, -19, -19, -19, -19, -19, -19, -19, -18, -18, -18, -18, -18, -18, -18, -18, -18, -17, -17, -17, -17, -17, -17, -17, -17, -17, -16, -16, -16, -16, -16, -16, -16, -16, -16, -15, -15, -15, -15, -15, -15, -15, -15, -15, -14, -14, -14, -14, -14, -14, -14, -14, -13, -13, -13, -13, -13, -13, -13, -13, -13, -12
			db -12, -12, -12, -12, -12, -12, -12, -11, -11, -11, -11, -11, -11, -11, -11, -11, -10, -10, -10, -10, -10, -10, -10, -10, -9, -9, -9, -9, -9, -9, -9, -9, -9, -8, -8, -8, -8, -8, -8, -8, -8, -7, -7, -7, -7, -7, -7, -7, -7, -6, -6, -6, -6, -6, -6, -6, -6, -6, -5, -5, -5, -5, -5, -5, -5, -5, -4, -4, -4, -4, -4, -4, -4
			db -4, -3, -3, -3, -3, -3, -3, -3, -3, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -1, -1, -1, -1, -1, -1, 0, 0, 0, 0, 0 	
;end of sin_table

MAP2	dw 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
		dw 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
		dw 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
		dw 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1
		dw 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1
		dw 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
		dw 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
		dw 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1
		dw 1, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1
		dw 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1
		dw 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1
		dw 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

MAP3	dw 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0ah
		dw 8, 0, 0, 15, 15, 15, 0, 15, 15, 15, 0, 0, 0, 0, 0eh, 0eh, 0, 0, 0, 8
		dw 8, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0eh, 0, 0, 0, 8
		dw 8, 0, 0, 15, 0, 0eh, 0, 0eh, 0eh, 0, 0, 15, 0, 0, 0, 0eh, 0, 0, 0, 8
		dw 8, 0, 0, 15, 0, 0eh, 0, 0, 0eh, 0, 0, 15, 0, 0, 0eh, 0eh, 0, 0, 0, 8
		dw 8, 0, 0, 0, 0, 0eh, 0, 0, 0eh, 0eh, 0eh, 0eh, 0eh, 0eh, 0eh, 0, 0, 0, 0, 8
		dw 8, 0, 0, 0, 0, 0eh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8, 0, 0, 0, 0, 0eh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8
		
MAP4	dw 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8
		dw 8, 0, 0, 0,15, 0, 0, 0, 0, 0, 0, 0, 0,15, 0, 0, 0, 0, 0, 8
		dw 8, 0, 0, 0,15, 0, 0, 0, 0, 0, 0, 0, 0,15, 0,14,14,14, 0, 0ah
		dw 8, 0, 0, 0,15, 0,15, 0,15,15, 0,14,14,15, 0,14, 0,15, 0, 8
		dw 8, 0, 0, 0,15, 0,15, 0, 0, 0, 0,14, 0, 0, 0,14, 0,15, 0, 8
		dw 8, 0, 0, 0, 0, 0,15,15, 7, 7, 7,14, 0,15, 0, 0, 0,15, 0, 8
		dw 8, 0, 0, 0,15, 0, 0, 0, 0, 0, 0, 0, 0,15, 0,15, 0,15, 14, 8
		dw 8,14, 0,15,15, 0,14,14,14,14, 0,15,15,15, 0,15,15,15, 0, 8
		dw 8,14, 0, 0, 0, 0, 0, 0,15,15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8,14,14,14,14,14,14, 0, 0, 0, 0,15, 0, 0, 0,15, 0, 0, 0, 8
		dw 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8
		
MAP5	dw 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0,15, 0, 0, 0, 0, 0, 0,15,15,15, 8
		dw 8, 0, 0, 0, 0,15, 0,14,15,15, 0, 0,15,15,15, 0, 0,15, 0, 0ah
		dw 8, 0, 0, 0, 0,14, 0,14, 0, 0, 0, 0,14, 0,15,15, 0,15, 0, 8
		dw 8,15,15,15, 0,14, 0,14, 0, 0, 0, 0,14, 0, 0, 0, 0, 0, 0, 8
		dw 8, 0, 0, 0, 0,14, 0,14, 0, 0, 0, 0,14, 0, 0, 0,15,15,15, 8
		dw 8, 0,15, 0, 0,14, 0,14, 0,14, 0, 0,14, 0,14, 0, 0,14, 0, 8
		dw 8, 0,15, 0, 0,14, 0, 0, 0,14,14, 0,14, 0,14, 0, 0,14, 0, 8
		dw 8, 0,15, 0, 0,14,15,15,14,14, 0, 0, 0, 0,14,14,14,14, 0, 8
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8
		
MAP6	dw 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0ah
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8
		dw 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8
		

;/-------------------------\
;===========================
;===========================
;	  	Dynamic Data
;===========================
;===========================
;\-------------------------/

;gamemode
gamemode db 1
map dw offset MAP3

;player position
playerPositionX dw 1500
playerPositionY dw 1500
playerRotation dw 1000
playerDeltaX db ?
playerDeltaY db ?

;rays
rayY dw ?
rayX dw ?
rayDeltaX db ?
rayDeltaY db ?

;for proc pixel
pointX dw ? 
pointY dw ?
Color db 5

;/-------------------------\
;===========================
;===========================
;	  	 	Code
;===========================
;===========================
;\-------------------------/

CODESEG
start:
	mov ax, @data
	mov ds, ax
	call SetGraphic
	call flipDisplay
	call update
exit:
	

	
 	mov ah,0
	int 16h
	
	mov ah,7 ;silent input
	int 21h
	
	mov ax,2  ; back to mode text 
	int 10h

	mov dx, offset BB
	mov ah,9
	int 21h

	
	mov ax, 4c00h
	int 21h
	

;/-------------------------\
;===========================
;===========================
;	  	 procedures
;===========================
;===========================
;\-------------------------/

;===========================
;	Proc Init
;	draws the maze 2D
;	input:
;	[map] = map (by ref)
;	draws map on the screen
;	uses all registers without restoring
;===========================
proc Init
	
;	cx  = x		           
; 	dx = y	
; 	si = length  	    
;	Color = al
;   di = ref to next tile color

	mov di, [map]

	mov cx, 0
	mov dx, 0

initallrows:
	mov si, 16
	mov ax, [di]
	add di, 2 ;word array
	call DrawTile

	add cx, 16
	cmp cx, 320 ;if cx>=315 we are done with the row
	jb initallrows
	mov cx, 0
	add dx, 16
	cmp dx, 175
	jb initallrows

ret
endp Init


;===========================
;	Proc Update
;	main game loop
;	no input, no output.
;	uses all registers without restoring
;===========================
proc Update
	call UpdateDelta 
	@UpdateStart:
	
	;update the scene
	call GetInput
	
	;delay
    mov     cx, 0000H
    mov     dx, 0F00H
    mov     ah, 86h
    mov     al, 0
    int     15h
	
	jmp @UpdateStart
ret
endp Update

;===========================
;	Proc guideLine
;	output: 
;		draws a line (2d) where player is looking
;===========================
proc guideLine

	;ray position = player position
	mov ax, [playerPositionX]
	mov [rayX], ax
	mov ax, [playerPositionY]
	mov [rayY], ax
	mov al, [playerDeltaX]
	mov [rayDeltaX], al
	mov al, [playerDeltaY]
	mov [rayDeltaY], al
	
	mov cx, 15
		@Step:
	
		;add ray delta to ray position
			xor ah, ah
			mov al, [rayDeltaX]
			cmp al, 0
			jng @DeltaXA
	
			;rayDeltax is positive
			add [rayX], ax
			jmp @DeltaXB
	
			;rayDeltax is negative
			@DeltaXA:
			neg al
			sub [rayX], ax
			@DeltaXB:
			
			mov al, [rayDeltaY]
			cmp al, 0
			jng @DeltaYA
	
			;rayDeltax is positive
			add [rayY], ax
			jmp @DeltaYB
	
			;rayDeltax is negative
			@DeltaYA:
			neg al
			sub [rayY], ax
			@DeltaYB:
		;check for collision
		mov bx, [rayY]
		shr bx, 6

		shr bx, 4; get the exact square y
		mov ax, bx ; next few line: bx = bx*20
		shl bx, 4
		shl ax, 2
		add bx, ax ; now bx = ax * 20
		mov ax, [rayX]
		shr ax, 10
		add bx, ax
		
		shl bx, 1 ;maps are in words, not bytes
		
		add bx, [map]
		cmp [word ptr bx], 0
		jne @StepDone
		
		mov ax, [rayX]
		shr ax, 6
		mov [pointX], ax
		mov ax, [rayY]
		shr ax, 6
		mov [pointY], ax
		
		push cx
		call PIXEL
		pop cx
		
		;cant use loop cos too far, need to implement with unconditional jump
		cmp cx, 0
		je @StepDone
		dec cx
		jmp @Step
	
	@StepDone:

ret
endp guideLine

;===========================
;	Proc flipDisplay
;	input:
;		[map] = refferance to map
;	output: 
;		draws next frame on screen
;===========================
proc flipDisplay
	;check collisions before updating
	call collision

	cmp [gamemode], 0
	jne FirstPerson
	
	
;IF 2D:
	call init
	
	;show where player is looking
	call guideLine
	
	;darw player
	mov dx, [playerPositionY]
	shr dx, 6
	mov cx, [playerPositionX]
	shr cx, 6
	mov al, 12
	mov ah,0ch	
	int 10h    ; put pixel  cx=x dx=y al = color	
	
	jmp flipped
;IF 3D:
	FirstPerson:
		;cast 160 rays from 240 to -240
		mov cx, 319
		mov si, -160
		@flipDisplayRays:
		;first erase previouse line

		;now draw new line
		push si ;1 copy of si
		push cx ;2 copies of cx in memor
		
		call castRay ;si = ray length
		;now si = ray length, ax = color
		push ax
		
		
		
		xor dx, dx
		mov ax, 3200 ;window size Y = 200; cube size = 16; 3200=16*200
		cmp si, 0
		je flipped
		div si
		xor ah, ah
		mov si, ax
		mov dx, 200
		sub dx, si
		shr dx, 1
		
		pop ax
		pop cx
		call DrawVerticalLine

		mov dx, 200
		sub dx, si
		shr dx, 1
		xchg dx, si
		mov bx, dx
		mov dx, 0
		mov ax, 3
		call DrawVerticalLine
		
		add dx, si
		add dx, bx
		mov ax, 4
		call DrawVerticalLine
		
		pop si
		inc si
		;like loop but also does it for 0
		cmp cx, 0
		jl @flipDisplayDelay
		dec cx
		jmp @flipDisplayRays
		
		@flipDisplayDelay:
		
flipped:
		
	ret
endp flipDisplay


;===========================
;	Proc SetGraphic
;	called once when program starts
;	no input, output - new display.
;	uses AX without restoring
;===========================
proc  SetGraphic
	; http://stanislavs.org/helppc/int_10-0.html

	mov ax,13h   ; 320 X 200 
	;Mode 13h is an IBM VGA BIOS mode. It is the specific standard 256-color mode 
	int 10h
	ret
endp 	SetGraphic


;===========================
;	Proc castRay
;	called to ray trace
;	input si = rayAngle, output - CX length
;===========================
proc castRay
	;ray position = player position
	mov ax, [playerPositionX]
	mov [rayX], ax
	mov ax, [playerPositionY]
	mov [rayY], ax
	
	;bx = player rotation + si
	mov bx, [playerRotation]
	;add bx, si
		cmp si, 0
		jng @castRaySIA
	
		;rayDeltax is positive
		add bx, si
		jmp @castRaySIB
	
		;rayDeltax is negative
		@castRaySIA:
		neg si
		sub bx, si
		@castRaySIB:
	
	;calcualte movement of ray for each step
	call UpdateDeltaRay
	
	mov cx, 600
	@castRayStep:
	
		;add ray delta to ray position
			xor ah, ah
			mov al, [rayDeltaX]
			cmp al, 0
			jng @castRayDeltaXA
	
			;rayDeltax is positive
			add [rayX], ax
			jmp @castRayDeltaXB
	
			;rayDeltax is negative
			@castRayDeltaXA:
			neg al
			sub [rayX], ax
			@castRayDeltaXB:
			
			mov al, [rayDeltaY]
			cmp al, 0
			jng @castRayDeltaYA
	
			;rayDeltax is positive
			add [rayY], ax
			jmp @castRayDeltaYB
	
			;rayDeltax is negative
			@castRayDeltaYA:
			neg al
			sub [rayY], ax
			@castRayDeltaYB:
			
		;check for collision
		mov bx, [rayY]
		shr bx, 6

		shr bx, 4; get the exact square y
		mov ax, bx ; next few line: bx = bx*20
		shl bx, 4
		shl ax, 2
		add bx, ax ; now bx = ax * 20
		mov ax, [rayX]
		shr ax, 10
		add bx, ax
		
		shl bx, 1 ;maps are in words, not bytes
		
		add bx, [map]
		cmp [word ptr bx], 0
		jne @castRayStepDone
		
		;mov ax, [rayX]
		;shr ax, 6
		;mov [pointX], ax
		;mov ax, [rayY]
		;shr ax, 6
		;mov [pointY], ax
		
		;push cx
		;call PIXEL
		;pop cx
		
		;cant use loop cos too far, need to implement with unconditional jump
		cmp cx, 0
		je @castRayStepDone
		dec cx
		jmp @castRayStep
	
	@castRayStepDone:
	;si = ray length = 200-cx
	;shr cx, 1
	mov si, 600
	sub si, cx
	
	;al = color
	mov ax, [word ptr bx]
ret
endp castRay


;===========================
;	Proc DrawTile
;	input:
; 	ax = next color
;	dx = y
;	cx = x
;	output:	draws desired tile at desired location
;	uses AX without restoring
;===========================
proc DrawTile
;	cx  = x		           
; 	dx = y	
; 	si = length  	    
;	Color = al
	push cx
	push bx
	
	mov si, 16 ;constant hight of tile

	mov bx, cx ;bx stores original cx value
	mov cx, 16 ;loop 16 times

	tileloop:
	add cx, bx
	dec cx ;fixes a bug for some reason so i left it ¯\_(ツ)_/¯
	call DrawVerticalLine
	inc cx
	sub cx, bx
	loop tileloop

	pop bx
	pop cx
	
ret
endp DrawTile



;===========================
;	Proc GetInput
;	updates level according to the input
;	input: keyboard.
;	output: memory.
;	uses AX without restoring
;===========================
proc  GetInput
	
	;Get Keypress info from DOS
	mov ah, 6
	mov dl, 0ffh
	int 21h
	
	;see what is the key and act accordingly
	
	;case "W"
	@GetInputKeyW:
	cmp al, 'w' ;code for "W"
	jne @GetInputKeyA
	
	xor ah, ah
	mov al, [playerDeltaX]
	cmp al, 0
	jng @GetInputSinNeg
	
		;deltax is positive
		add [playerPositionX], ax
		jmp @GetInputCos
	
		;deltax is negative
	@GetInputSinNeg:
		neg al
		sub [playerPositionX], ax
		
	@GetInputCos:
	mov al, [playerDeltaY]
	cmp al, 0
	jng @GetInputCosNeg
	
		;deltay is positive
		add [playerPositionY], ax
		call flipDisplay
		jmp @GetInputRet
	
		;deltay is negative
	@GetInputCosNeg:
		neg al
		sub [playerPositionY], ax
		
	;update the display
	call flipDisplay
	
	jmp @GetInputRet
	
	
	
	;case "A"
	@GetInputKeyA:
	cmp al, 'a' ;code for "A"
	jne @GetInputKeyS
	add [playerRotation], 17
	
	call UpdateDelta
	
	;update the display
	call flipDisplay
	
	jmp @GetInputRet
	
	;case "S"
	@GetInputKeyS:
	cmp al, 's' ;code for "S"
	jne @GetInputKeyD
	
	xor ah, ah
	mov al, [playerDeltaX]
	cmp al, 0
	jng @GetInputSinNegs
	
		;deltax is positive
		sub [playerPositionX], ax
		jmp @GetInputCoss
	
		;deltax is negative
	@GetInputSinNegs:
		neg al
		add [playerPositionX], ax
		
	@GetInputCoss:
	mov al, [playerDeltaY]
	cmp al, 0
	jng @GetInputCosNegs
	
		;deltay is positive
		sub [playerPositionY], ax
		call flipDisplay
		jmp @GetInputRet
	
		;deltay is negative
	@GetInputCosNegs:
		neg al
		add [playerPositionY], ax
	
	;update the display
	call flipDisplay
	
	jmp @GetInputRet
	
	;case "D"
	@GetInputKeyD:
	cmp al, 'd' ;code for "D"
	jne @GetInputKey2
	sub [playerRotation], 17
	
	call UpdateDelta
	
	;update the display
	call flipDisplay
	
	jmp @GetInputRet
	
	;case "2"
	@GetInputKey2:
	cmp al, 'r' ;code for "2"
	jne @GetInputKey3
	mov [gamemode], 0
	jmp @GetInputRet
	
	;case "3"
	@GetInputKey3:
	cmp al, 't' ;code for "3"
	jne @GetInputKeySpace
	mov [gamemode], 1
	jmp @GetInputRet
	
	@GetInputKeySpace:
	cmp al, 'q' ;code for "q"
	jne @GetInputRet
	pop dx
	jmp exit

	@GetInputRet:
	ret
endp GetInput


;===========================
;	Proc get_sin
;	returns sin of an angle
;	input:
;		si = angle 0-255
;	output: 
;		al
;===========================
proc get_sin
	push si
	mov bx, offset sin_table
	and si, 7ffh
	mov ah, 0
	mov al, [bx + si]
	;cbw
	pop si
	ret
endp get_sin


;===========================
;	Proc get_cos
;	returns cosin of an angle
;	input:
;		si = angle 0-255
;	output: 
;		al = cos(si)
;===========================
proc get_cos
	push si
	mov bx, offset sin_table
	sub si, 512
	and si, 7ffh
	mov ah, 0
	mov al, [bx + si]
	;cbw
	pop si
	ret
endp get_cos


;===========================
;	Proc UpdateDelta
;	updates delta of rotation for player movement
;	input:
;		[playerRotation]
;	output: 
;		[playerDeltaX], [playerDeltaY]
;===========================
proc UpdateDelta

	;si = playerRotation
	mov ax, [playerRotation]
	mov si, ax
	
	;update [playerDeltaY]
	call get_sin
	mov [playerDeltaY], al
	
	;update [playerDeltaX]
	call get_cos
	mov [playerDeltaX], al
	
	ret	
endp UpdateDelta

;===========================
;	Proc collision
;	checks if player is in a wall
;	input:
;		[playerRotation], [map]
;	output: 
;		might change [map], might change player position/rotation
;===========================
proc collision

;check for collision
		mov bx, [playerPositionY]
		shr bx, 6

		shr bx, 4; get the exact square y
		mov ax, bx ; next few line: bx = bx*20
		shl bx, 4
		shl ax, 2
		add bx, ax ; now bx = ax * 20
		mov ax, [playerPositionX]
		shr ax, 10
		add bx, ax
		
		shl bx, 1 ;maps are in words, not bytes
		add bx, [map]
		cmp [word ptr bx], 0
		je @@ret
;if need to restart position (not green wall)
cmp [word ptr bx], 0ah
je @green

call resetPosition

jmp @@ret
;if green wall (next level)
@green:
;[map] = next maze
add [map], 440
;if its the last maze, dont keep going forward
mov bx, [map]
cmp bx, offset MAP6
jb dontsub
mov [map], bx
dontsub:
call resetPosition

@@ret:
ret
endp collision

;===========================
;	Proc resetPosition
;	resets player position and rotation
;	output: 
;		player position and rotation
;===========================
proc resetPosition

mov [playerPositionX], 1500
mov [playerPositionY], 1500
mov [playerRotation], 1000
call flipDisplay

ret
endp resetPosition
;===========================
;	Proc UpdateDeltaRay
;	updates delta of rotation for player movement
;	input:
;		bx = ray rotation
;	output: 
;		[tayDeltaX], [rayDeltaY]
;===========================
proc UpdateDeltaRay
	push si
	;si = rayRotation
	mov si, bx
	;update [rayDeltaY]
	call get_sin
	mov [rayDeltaY], al
	
	;update [playerDeltaX]
	call get_cos
	mov [rayDeltaX], al
	
	pop si
	ret	
endp UpdateDeltaRay


;---------------------------------------------;
; case: DeltaX is bigger than DeltaY		  ;
; input: p1X p1Y,		            		  ;
; 		 p2X p2Y,		           		      ;
;		 Color -> variable                    ;
; output: line on the screen                  ;
;---------------------------------------------;

PROC PIXEL
	mov bh,0h
	mov cx,[pointX]
	mov dx,[pointY]
	mov al,[Color]
	mov ah,0Ch
	int 10h
	ret
ENDP PIXEL
 
;---------------------------------------------;
; Proc DrawVerticalLine		  				  ;
; input: cx  = x		            		  ;
; 		 dx = y								  ;
; 		 si = length  	        		      ;
;		 Color = al          	 	      	  ;
; output: line on the screen                  ;
;---------------------------------------------;
proc DrawVerticalLine
	push si
	push dx
	push cx
DrawVertical:
	cmp si,0
	jz @@ExitDrawLine	
	 
    mov ah,0ch	
	int 10h    ; put pixel
	
	 
	
	inc dx
	dec si
	jmp DrawVertical
	
	
@@ExitDrawLine:
	pop cx
	pop dx
    pop si
	ret
endp DrawVerticalLine







;/-------------------------\
;===========================
;===========================
;	 		tables
;===========================
;===========================
;\-------------------------/

;there were some tables here. this section is empty now but it remains for possible future tables.



END start



