Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6561024E3
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 13:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKSMwb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 07:52:31 -0500
Received: from smtpbguseast2.qq.com ([54.204.34.130]:38423 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfKSMwb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Nov 2019 07:52:31 -0500
X-QQ-mid: bizesmtp27t1574167934tocw35lh
Received: from lzy-H3050.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Tue, 19 Nov 2019 20:52:10 +0800 (CST)
X-QQ-SSF: 01400000002000I0ZG41000A0000000
X-QQ-FEAT: UlIMmi8EwCIoIIVbJRZHzbUGVlG7bBWGI45M4xQ4ho+YLAzy1bfLtEDG1pfsB
        s9DS3xHtVehuaI0u391kVMaYsB8MYHv/jT9rvoYXV23KAb6LRP4uyVgklk6MeJxKyaDSb7P
        h6FC9V1gFT++VJI3gwJoCzyGhyodUAJsnwEFk9eFr2eRJ0FlLCW9SBjckg7iLkyU+wEmwzt
        u8Zjog7YDxAC/kcCg3YTcaehcJF17Ap8lRnY8xNBdMvYu5l7b8u4NBAMfLPytrl84PUs15m
        rZ0pCtloNAuTbed7oYnxvVQbvoI0sGbUGPCMCc05Vc5/ApZjSk9RqrC7mOiGbebilX4a45l
        8FVlsLDMMaZXQjnX8o=
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     rafael.j.wysocki@intel.com, robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, lv.zheng@intel.com
Subject: [PATCH] tools/acpi: fix compilation error
Date:   Tue, 19 Nov 2019 20:52:09 +0800
Message-Id: <1574167929-11244-1-git-send-email-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: liuzhengyuan <liuzhengyuan@kylinos.com.cn>

If we compile tools/acpi target in the top source directory, we'd get a
compilation error showing as bellow:

	# make tools/acpi
	  DESCEND  power/acpi
	  DESCEND  tools/acpidbg
	  CC       tools/acpidbg/acpidbg.o
	Assembler messages:
	Fatal error: can't create /home/lzy/kernel-upstream/linux-linus-ubuntu/power\
			/acpi/tools/acpidbg/acpidbg.o: No such file or directory
	../../Makefile.rules:26: recipe for target '/home/lzy/kernel-upstream/linux-\
			linus-ubuntu/power/acpi/tools/acpidbg/acpidbg.o' failed
	make[3]: *** [/home/lzy/kernel-upstream/linux-linus-ubuntu/power/acpi/tools/\
			acpidbg/acpidbg.o] Error 1
	Makefile:19: recipe for target 'acpidbg' failed
	make[2]: *** [acpidbg] Error 2
	Makefile:54: recipe for target 'acpi' failed
	make[1]: *** [acpi] Error 2
	Makefile:1607: recipe for target 'tools/acpi' failed
	make: *** [tools/acpi] Error 2

Fixes: d5a4b1a540b ("tools/power/acpi: Remove direct kernel source include reference")
Signed-off-by: liuzhengyuan <liuzhengyuan@kylinos.com.cn>
---
 tools/power/acpi/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
index 0111d24..54a2857 100644
--- a/tools/power/acpi/Makefile.config
+++ b/tools/power/acpi/Makefile.config
@@ -15,7 +15,7 @@ include $(srctree)/../../scripts/Makefile.include
 
 OUTPUT=$(srctree)/
 ifeq ("$(origin O)", "command line")
-	OUTPUT := $(O)/power/acpi/
+	OUTPUT := $(O)/tools/power/acpi/
 endif
 #$(info Determined 'OUTPUT' to be $(OUTPUT))
 
-- 
2.7.4



