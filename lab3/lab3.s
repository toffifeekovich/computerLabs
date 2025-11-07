
a.out:     формат файла elf64-x86-64


Дизассемблирование раздела .init:

0000000000001000 <_init>:
    1000:	f3 0f 1e fa          	endbr64
    1004:	48 83 ec 08          	sub    rsp,0x8
    1008:	48 8b 05 d9 2f 00 00 	mov    rax,QWORD PTR [rip+0x2fd9]        # 3fe8 <__gmon_start__@Base>
    100f:	48 85 c0             	test   rax,rax
    1012:	74 02                	je     1016 <_init+0x16>
    1014:	ff d0                	call   rax
    1016:	48 83 c4 08          	add    rsp,0x8
    101a:	c3                   	ret

Дизассемблирование раздела .plt:

0000000000001020 <.plt>:
    1020:	ff 35 92 2f 00 00    	push   QWORD PTR [rip+0x2f92]        # 3fb8 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	ff 25 94 2f 00 00    	jmp    QWORD PTR [rip+0x2f94]        # 3fc0 <_GLOBAL_OFFSET_TABLE_+0x10>
    102c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1030:	f3 0f 1e fa          	endbr64
    1034:	68 00 00 00 00       	push   0x0
    1039:	e9 e2 ff ff ff       	jmp    1020 <_init+0x20>
    103e:	66 90                	xchg   ax,ax
    1040:	f3 0f 1e fa          	endbr64
    1044:	68 01 00 00 00       	push   0x1
    1049:	e9 d2 ff ff ff       	jmp    1020 <_init+0x20>
    104e:	66 90                	xchg   ax,ax

Дизассемблирование раздела .plt.got:

0000000000001050 <__cxa_finalize@plt>:
    1050:	f3 0f 1e fa          	endbr64
    1054:	ff 25 9e 2f 00 00    	jmp    QWORD PTR [rip+0x2f9e]        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    105a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]

Дизассемблирование раздела .plt.sec:

0000000000001060 <sin@plt>:
    1060:	f3 0f 1e fa          	endbr64
    1064:	ff 25 5e 2f 00 00    	jmp    QWORD PTR [rip+0x2f5e]        # 3fc8 <sin@GLIBC_2.2.5>
    106a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]

0000000000001070 <exp@plt>:
    1070:	f3 0f 1e fa          	endbr64
    1074:	ff 25 56 2f 00 00    	jmp    QWORD PTR [rip+0x2f56]        # 3fd0 <exp@GLIBC_2.29>
    107a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]

Дизассемблирование раздела .text:

0000000000001080 <_start>:
    1080:	f3 0f 1e fa          	endbr64
    1084:	31 ed                	xor    ebp,ebp
    1086:	49 89 d1             	mov    r9,rdx
    1089:	5e                   	pop    rsi
    108a:	48 89 e2             	mov    rdx,rsp
    108d:	48 83 e4 f0          	and    rsp,0xfffffffffffffff0
    1091:	50                   	push   rax
    1092:	54                   	push   rsp
    1093:	45 31 c0             	xor    r8d,r8d
    1096:	31 c9                	xor    ecx,ecx
    1098:	48 8d 3d e6 01 00 00 	lea    rdi,[rip+0x1e6]        # 1285 <main>
    109f:	ff 15 33 2f 00 00    	call   QWORD PTR [rip+0x2f33]        # 3fd8 <__libc_start_main@GLIBC_2.34>
    10a5:	f4                   	hlt
    10a6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    10ad:	00 00 00 

00000000000010b0 <deregister_tm_clones>:
    10b0:	48 8d 3d 59 2f 00 00 	lea    rdi,[rip+0x2f59]        # 4010 <__TMC_END__>
    10b7:	48 8d 05 52 2f 00 00 	lea    rax,[rip+0x2f52]        # 4010 <__TMC_END__>
    10be:	48 39 f8             	cmp    rax,rdi
    10c1:	74 15                	je     10d8 <deregister_tm_clones+0x28>
    10c3:	48 8b 05 16 2f 00 00 	mov    rax,QWORD PTR [rip+0x2f16]        # 3fe0 <_ITM_deregisterTMCloneTable@Base>
    10ca:	48 85 c0             	test   rax,rax
    10cd:	74 09                	je     10d8 <deregister_tm_clones+0x28>
    10cf:	ff e0                	jmp    rax
    10d1:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    10d8:	c3                   	ret
    10d9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]

00000000000010e0 <register_tm_clones>:
    10e0:	48 8d 3d 29 2f 00 00 	lea    rdi,[rip+0x2f29]        # 4010 <__TMC_END__>
    10e7:	48 8d 35 22 2f 00 00 	lea    rsi,[rip+0x2f22]        # 4010 <__TMC_END__>
    10ee:	48 29 fe             	sub    rsi,rdi
    10f1:	48 89 f0             	mov    rax,rsi
    10f4:	48 c1 ee 3f          	shr    rsi,0x3f
    10f8:	48 c1 f8 03          	sar    rax,0x3
    10fc:	48 01 c6             	add    rsi,rax
    10ff:	48 d1 fe             	sar    rsi,1
    1102:	74 14                	je     1118 <register_tm_clones+0x38>
    1104:	48 8b 05 e5 2e 00 00 	mov    rax,QWORD PTR [rip+0x2ee5]        # 3ff0 <_ITM_registerTMCloneTable@Base>
    110b:	48 85 c0             	test   rax,rax
    110e:	74 08                	je     1118 <register_tm_clones+0x38>
    1110:	ff e0                	jmp    rax
    1112:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1118:	c3                   	ret
    1119:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]

0000000000001120 <__do_global_dtors_aux>:
    1120:	f3 0f 1e fa          	endbr64
    1124:	80 3d e5 2e 00 00 00 	cmp    BYTE PTR [rip+0x2ee5],0x0        # 4010 <__TMC_END__>
    112b:	75 2b                	jne    1158 <__do_global_dtors_aux+0x38>
    112d:	55                   	push   rbp
    112e:	48 83 3d c2 2e 00 00 	cmp    QWORD PTR [rip+0x2ec2],0x0        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    1135:	00 
    1136:	48 89 e5             	mov    rbp,rsp
    1139:	74 0c                	je     1147 <__do_global_dtors_aux+0x27>
    113b:	48 8b 3d c6 2e 00 00 	mov    rdi,QWORD PTR [rip+0x2ec6]        # 4008 <__dso_handle>
    1142:	e8 09 ff ff ff       	call   1050 <__cxa_finalize@plt>
    1147:	e8 64 ff ff ff       	call   10b0 <deregister_tm_clones>
    114c:	c6 05 bd 2e 00 00 01 	mov    BYTE PTR [rip+0x2ebd],0x1        # 4010 <__TMC_END__>
    1153:	5d                   	pop    rbp
    1154:	c3                   	ret
    1155:	0f 1f 00             	nop    DWORD PTR [rax]
    1158:	c3                   	ret
    1159:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]

0000000000001160 <frame_dummy>:
    1160:	f3 0f 1e fa          	endbr64
    1164:	e9 77 ff ff ff       	jmp    10e0 <register_tm_clones>

0000000000001169 <f>:
    1169:	f3 0f 1e fa          	endbr64
    116d:	55                   	push   rbp
    116e:	48 89 e5             	mov    rbp,rsp
    1171:	48 83 ec 10          	sub    rsp,0x10
    1175:	f2 0f 11 45 f8       	movsd  QWORD PTR [rbp-0x8],xmm0
    117a:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    117e:	66 48 0f 6e c0       	movq   xmm0,rax
    1183:	e8 d8 fe ff ff       	call   1060 <sin@plt>
    1188:	f2 0f 11 45 f0       	movsd  QWORD PTR [rbp-0x10],xmm0
    118d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1191:	66 48 0f 6e c0       	movq   xmm0,rax
    1196:	e8 d5 fe ff ff       	call   1070 <exp@plt>
    119b:	f2 0f 59 45 f0       	mulsd  xmm0,QWORD PTR [rbp-0x10]
    11a0:	c9                   	leave
    11a1:	c3                   	ret

00000000000011a2 <integral>:
    11a2:	f3 0f 1e fa          	endbr64
    11a6:	55                   	push   rbp
    11a7:	48 89 e5             	mov    rbp,rsp
    11aa:	48 83 ec 50          	sub    rsp,0x50
    11ae:	f2 0f 11 45 c8       	movsd  QWORD PTR [rbp-0x38],xmm0
    11b3:	f2 0f 11 4d c0       	movsd  QWORD PTR [rbp-0x40],xmm1
    11b8:	89 7d bc             	mov    DWORD PTR [rbp-0x44],edi
    11bb:	f2 0f 10 45 c0       	movsd  xmm0,QWORD PTR [rbp-0x40]
    11c0:	f2 0f 5c 45 c8       	subsd  xmm0,QWORD PTR [rbp-0x38]
    11c5:	66 0f ef c9          	pxor   xmm1,xmm1
    11c9:	f2 0f 2a 4d bc       	cvtsi2sd xmm1,DWORD PTR [rbp-0x44]
    11ce:	f2 0f 5e c1          	divsd  xmm0,xmm1
    11d2:	f2 0f 11 45 e8       	movsd  QWORD PTR [rbp-0x18],xmm0
    11d7:	66 0f ef c0          	pxor   xmm0,xmm0
    11db:	f2 0f 11 45 e0       	movsd  QWORD PTR [rbp-0x20],xmm0
    11e0:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [rbp-0x24],0x0
    11e7:	e9 81 00 00 00       	jmp    126d <integral+0xcb>
    11ec:	66 0f ef c0          	pxor   xmm0,xmm0
    11f0:	f2 0f 2a 45 dc       	cvtsi2sd xmm0,DWORD PTR [rbp-0x24]
    11f5:	f2 0f 59 45 e8       	mulsd  xmm0,QWORD PTR [rbp-0x18]
    11fa:	f2 0f 10 4d c8       	movsd  xmm1,QWORD PTR [rbp-0x38]
    11ff:	f2 0f 58 c1          	addsd  xmm0,xmm1
    1203:	f2 0f 11 45 f0       	movsd  QWORD PTR [rbp-0x10],xmm0
    1208:	8b 45 dc             	mov    eax,DWORD PTR [rbp-0x24]
    120b:	83 c0 01             	add    eax,0x1
    120e:	66 0f ef c0          	pxor   xmm0,xmm0
    1212:	f2 0f 2a c0          	cvtsi2sd xmm0,eax
    1216:	f2 0f 59 45 e8       	mulsd  xmm0,QWORD PTR [rbp-0x18]
    121b:	f2 0f 10 4d c8       	movsd  xmm1,QWORD PTR [rbp-0x38]
    1220:	f2 0f 58 c1          	addsd  xmm0,xmm1
    1224:	f2 0f 11 45 f8       	movsd  QWORD PTR [rbp-0x8],xmm0
    1229:	48 8b 45 f0          	mov    rax,QWORD PTR [rbp-0x10]
    122d:	66 48 0f 6e c0       	movq   xmm0,rax
    1232:	e8 32 ff ff ff       	call   1169 <f>
    1237:	f2 0f 11 45 b0       	movsd  QWORD PTR [rbp-0x50],xmm0
    123c:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    1240:	66 48 0f 6e c0       	movq   xmm0,rax
    1245:	e8 1f ff ff ff       	call   1169 <f>
    124a:	f2 0f 58 45 b0       	addsd  xmm0,QWORD PTR [rbp-0x50]
    124f:	f2 0f 10 0d b1 0d 00 	movsd  xmm1,QWORD PTR [rip+0xdb1]        # 2008 <_IO_stdin_used+0x8>
    1256:	00 
    1257:	f2 0f 5e c1          	divsd  xmm0,xmm1
    125b:	f2 0f 10 4d e0       	movsd  xmm1,QWORD PTR [rbp-0x20]
    1260:	f2 0f 58 c1          	addsd  xmm0,xmm1
    1264:	f2 0f 11 45 e0       	movsd  QWORD PTR [rbp-0x20],xmm0
    1269:	83 45 dc 01          	add    DWORD PTR [rbp-0x24],0x1
    126d:	8b 45 bc             	mov    eax,DWORD PTR [rbp-0x44]
    1270:	3b 45 dc             	cmp    eax,DWORD PTR [rbp-0x24]
    1273:	0f 8f 73 ff ff ff    	jg     11ec <integral+0x4a>
    1279:	f2 0f 10 45 e0       	movsd  xmm0,QWORD PTR [rbp-0x20]
    127e:	f2 0f 59 45 e8       	mulsd  xmm0,QWORD PTR [rbp-0x18]
    1283:	c9                   	leave
    1284:	c3                   	ret

0000000000001285 <main>:
    1285:	f3 0f 1e fa          	endbr64
    1289:	55                   	push   rbp
    128a:	48 89 e5             	mov    rbp,rsp
    128d:	48 83 ec 20          	sub    rsp,0x20
    1291:	66 0f ef c0          	pxor   xmm0,xmm0
    1295:	f2 0f 11 45 e8       	movsd  QWORD PTR [rbp-0x18],xmm0
    129a:	f2 0f 10 05 6e 0d 00 	movsd  xmm0,QWORD PTR [rip+0xd6e]        # 2010 <_IO_stdin_used+0x10>
    12a1:	00 
    12a2:	f2 0f 11 45 f0       	movsd  QWORD PTR [rbp-0x10],xmm0
    12a7:	c7 45 e4 80 d1 f0 08 	mov    DWORD PTR [rbp-0x1c],0x8f0d180
    12ae:	8b 55 e4             	mov    edx,DWORD PTR [rbp-0x1c]
    12b1:	f2 0f 10 45 f0       	movsd  xmm0,QWORD PTR [rbp-0x10]
    12b6:	48 8b 45 e8          	mov    rax,QWORD PTR [rbp-0x18]
    12ba:	89 d7                	mov    edi,edx
    12bc:	66 0f 28 c8          	movapd xmm1,xmm0
    12c0:	66 48 0f 6e c0       	movq   xmm0,rax
    12c5:	e8 d8 fe ff ff       	call   11a2 <integral>
    12ca:	66 48 0f 7e c0       	movq   rax,xmm0
    12cf:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    12d3:	b8 00 00 00 00       	mov    eax,0x0
    12d8:	c9                   	leave
    12d9:	c3                   	ret

Дизассемблирование раздела .fini:

00000000000012dc <_fini>:
    12dc:	f3 0f 1e fa          	endbr64
    12e0:	48 83 ec 08          	sub    rsp,0x8
    12e4:	48 83 c4 08          	add    rsp,0x8
    12e8:	c3                   	ret
