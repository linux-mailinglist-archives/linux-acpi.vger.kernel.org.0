Return-Path: <linux-acpi+bounces-5798-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5387E8C4F43
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 12:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779891C2113D
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9929413DDD8;
	Tue, 14 May 2024 10:10:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from isrv.corpit.ru (isrv.corpit.ru [86.62.121.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82C168C7;
	Tue, 14 May 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=86.62.121.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681425; cv=none; b=BCokygStNRxjjppZfZJ9hM5YV/URHcbQv8x1SL3fCMEykzB/HKzLHZb4wQbUKA+PrMH707a/OidfGH7/PlJLF4rMemrgMj5+fU4kqa9PUSweQwJxE7fKZ0Uj10V4OVG1J7SBLDDNffZ7cQU1VHc5WOl1NIjR5WtmkKW4d5C2Pyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681425; c=relaxed/simple;
	bh=mQ4j8DX0pdzmtd3n4jRgJ6RT+qOBApB+mJhv5bHU10g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XjaUwIuM615zyhh4wSWqCL82SC7Kd63i5nd5OrJDRe3zsq4CjuKvtGXkjjkTe1DYQdJlhenr0eCGUZ4E6C6CkCAlS2gnqgRmlQRPMXZQOg4qiaRPamKkVe0b6hp+51MhyjLKtKMYpncQuq/I7Bf/OY3omAcYuO+E4VwJz9nrxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru; spf=pass smtp.mailfrom=tls.msk.ru; arc=none smtp.client-ip=86.62.121.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id 30C7566924;
	Tue, 14 May 2024 13:10:30 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
	by tsrv.corpit.ru (Postfix) with ESMTP id AB948CE535;
	Tue, 14 May 2024 13:10:20 +0300 (MSK)
Message-ID: <0060cbfc-738a-44a8-8b39-b190fcc5076a@tls.msk.ru>
Date: Tue, 14 May 2024 13:10:20 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: kernel null-ptr deref after hibernation on thinkpad t495s -
 acpi_cpufreq failure
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I'm trying to debug a resume-from-hibernation issue on an AMD-based (AMD Ryzen 5 PRO 3500U)
Thinkpad 495s laptop.  So far, it works mostly okay with 'shutdown' mode but not with
'platform', giving an OOPS at resume.  'shutdown' mode has its own issues though, which
basically prevents it from being useful (namely, thinkpad_acpi module fails to enable
power button after resume), so I'm trying to get `platform' mode to work.

The OOPS at resume is like this: http://www.corpit.ru/mjt/tmp/screendump_2024-05-14_11-32-37.jpg
Unfortunately it's a picture (taken with my cellphone), not in a text form.

This is when the system is fully booted (without the graphics driver).  It turned out
I can use another way to trigger the same OOPS, namely:

  - boot into initrd, with minimal set of modules, and do hibernate/resume cycle in there
  - let it boot further
  - once it tries to load acpi_cpufreq module, it gets the same OOPS.

So it looks like hibernate/resume cycle changes something in ACPI and makes acpi_cpufreq
module confused - either when it's already loaded (happens at resume), or when it gets
loaded for the first time *after* the resume.  I think some ACPI table dump (before-after)
might be needed here, which one?

Here's the whole dmesg (including OOPs) from this one: http://www.corpit.ru/mjt/tmp/dmesg-oops.txt

The OOPs part:

[  267.784456] acpi_cpufreq: overriding BIOS provided _PSD data
[  267.787251] ACPI: button: Power Button [PWRB]
[  267.790096] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input101
[  267.791742] ACPI Error: Null stack entry at 00000000bc5560e1 (20220331/exresop-139)
[  267.792943] ACPI Error: AE_AML_INTERNAL, While resolving operands for [OpcodeName unavailable] (20220331/dswexec-431)
[  267.794270] ACPI Error: Aborting method \_PR.C003._PPC due to previous error (AE_AML_INTERNAL) (20220331/psparse-529)
[  267.795403] ACPI: \_PR_.C003: _PPC evaluation failed: AE_AML_INTERNAL
[  267.796803] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  267.797993] #PF: supervisor read access in kernel mode
[  267.799224] #PF: error_code(0x0000) - not-present page
[  267.800323] PGD 0 P4D 0
[  267.801382] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  267.802551] CPU: 1 PID: 351 Comm: (udev-worker) Not tainted 6.1.0-21-amd64 #1  Debian 6.1.90-1
[  267.803753] Hardware name: LENOVO 20QKS0EQ0N/20QKS0EQ0N, BIOS R13ET56W(1.30 ) 03/01/2024
[  267.804806] RIP: 0010:acpi_ex_resolve_multiple+0x2d/0x2c0
[  267.805923] Code: 00 00 41 56 49 89 fe 41 55 49 89 d5 41 54 49 89 cc 55 53 48 89 f3 48 83 ec 18 65 48 8b 04 25 28 00 00 00 48 89 44 24 10 31 c0 
<0f> b6 46 08 48 89 34 24 48 89 74 24 08 3c 0e 0f 84 28 01 00 00 3c
[  267.807081] RSP: 0018:ffffb5ae41147958 EFLAGS: 00010246
[  267.808016] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffb5ae411479a8
[  267.808978] RDX: ffffb5ae411479a4 RSI: 0000000000000000 RDI: ffff8eb084d9e800
[  267.809953] RBP: 0000000000000000 R08: ffffb5ae411479a8 R09: ffff8eb08591beb0
[  267.810071] ACPI: button: Lid Switch [LID]
[  267.811148] R10: 000000000000000f R11: ffffb5ae41147a00 R12: ffffb5ae411479a8
[  267.811151] R13: ffffb5ae411479a4 R14: ffff8eb084d9e800 R15: ffffd5ae3fb35f48
[  267.811154] FS:  00007f64c7196900(0000) GS:ffff8eb330a40000(0000) knlGS:0000000000000000
[  267.815792] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  267.816957] CR2: 0000000000000008 CR3: 0000000100d46000 CR4: 00000000003506e0
[  267.818133] Call Trace:
[  267.819255]  <TASK>
[  267.820397]  ? __die_body.cold+0x1a/0x1f
[  267.821538]  ? page_fault_oops+0xd2/0x2b0
[  267.822434]  ? __alloc_pages+0x1dc/0x330
[  267.823514]  ? exc_page_fault+0x70/0x170
[  267.824577]  ? asm_exc_page_fault+0x22/0x30
[  267.826045]  ? acpi_ex_resolve_multiple+0x2d/0x2c0
[  267.827495]  acpi_ex_opcode_1A_0T_1R+0x241/0x5a0
[  267.828655]  acpi_ds_exec_end_op+0x27e/0x510
[  267.829865]  acpi_ps_complete_final_op+0xa4/0x190
[  267.831062]  acpi_ps_parse_loop+0x2ed/0x6a0
[  267.832320]  acpi_ps_parse_aml+0x7c/0x3d0
[  267.833382]  acpi_ps_execute_method+0x13b/0x270
[  267.834435]  acpi_ns_evaluate+0x1ee/0x2d0
[  267.835479]  acpi_evaluate_object+0x149/0x2f0
[  267.836517]  acpi_evaluate_integer+0x6b/0xf0
[  267.837544]  acpi_processor_get_platform_limit+0x43/0x140
[  267.838564]  acpi_processor_register_performance+0x5d/0xd0
[  267.839566]  acpi_cpufreq_cpu_init+0x13c/0x8e0 [acpi_cpufreq]
[  267.840562]  ? srso_return_thunk+0x5/0x10
[  267.841540]  ? __kmalloc_node+0x4c/0x150
[  267.842516]  cpufreq_online+0x36a/0xa40
[  267.843480]  cpufreq_add_dev+0x77/0x90
[  267.844427]  subsys_interface_register+0x162/0x170
[  267.845366]  ? srso_return_thunk+0x5/0x10
[  267.846296]  cpufreq_register_driver+0x161/0x2c0
[  267.847230]  acpi_cpufreq_init+0x285/0x1000 [acpi_cpufreq]
[  267.848173]  ? 0xffffffffc08e1000
[  267.849101]  do_one_initcall+0x59/0x220
[  267.850029]  do_init_module+0x4a/0x1f0
[  267.850942]  __do_sys_finit_module+0xac/0x120
[  267.851862]  do_syscall_64+0x55/0xb0
[  267.852768]  ? srso_return_thunk+0x5/0x10
[  267.853662]  ? do_user_addr_fault+0x1b0/0x580
[  267.854564]  ? srso_return_thunk+0x5/0x10
[  267.855315]  ? exit_to_user_mode_prepare+0x44/0x1f0
[  267.856050]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  267.856776] RIP: 0033:0x7f64c7421719
[  267.857538] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
[  267.858475] RSP: 002b:00007fff3dc0e5a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  267.859383] RAX: ffffffffffffffda RBX: 00005555866ba500 RCX: 00007f64c7421719
[  267.860190] RDX: 0000000000000000 RSI: 00007f64c7552efd RDI: 0000000000000006
[  267.861013] RBP: 00007f64c7552efd R08: 0000000000000000 R09: 00005555865deff0
[  267.861836] R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
[  267.862680] R13: 0000000000000000 R14: 00005555866b6de0 R15: 00007fff3dc0e810
[  267.863523]  </TASK>

The acpi-related stack trace is exactly the same as on the picture.

This is current debian bookworm kernel, with debug symbols at
http://deb.debian.org/debian/pool/main/l/linux/linux-image-6.1.0-21-amd64-dbg_6.1.90-1_amd64.deb
and actual source at
http://deb.debian.org/debian/pool/main/l/linux/linux-source-6.1_6.1.90-1_all.deb

I tried multiple kernels starting at 4.19.0 and up to 6.7, - all behave in a similar way.
I'll try current 6.8 kernel next and see if that also shows the issue.

Here's the key points (hopefully) from the OOPs:

(gdb) l *acpi_ex_opcode_1A_0T_1R+0x241
0xffffffff8160d241 is in acpi_ex_opcode_1A_0T_1R (drivers/acpi/acpica/exoparg1.c:710).
705			 * get the associated object, not its value.
706			 */
707	
708			/* Get the base object */
709	
710			status =
711			    acpi_ex_resolve_multiple(walk_state, operand[0], &type,
712						     &temp_desc);
713			if (ACPI_FAILURE(status)) {
714				goto cleanup;

(gdb) l *acpi_ex_resolve_multiple+0x2d
0xffffffff8160f04d is in acpi_ex_resolve_multiple (drivers/acpi/acpica/exresolv.c:307).
302	acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
303				 union acpi_operand_object *operand,
304				 acpi_object_type *return_type,
305				 union acpi_operand_object **return_desc)
306	{
307		union acpi_operand_object *obj_desc = ACPI_CAST_PTR(void, operand);  <== BOOM
308		struct acpi_namespace_node *node =
309		    ACPI_CAST_PTR(struct acpi_namespace_node, operand);
310		acpi_object_type type;
311		acpi_status status;

Please help with further debugging/fixing this.  I have almost no experience in this field.

Thanks, and please excuse me for a somewhat long(ish) post, -
hopefully it's mostly to the point anyway :)

/mjt
-- 
GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D98 ECDF 2C8E
Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0A0 8044 65C5
Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt

