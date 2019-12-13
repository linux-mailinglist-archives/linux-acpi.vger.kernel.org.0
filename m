Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A237611E84F
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 17:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfLMQ1d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 11:27:33 -0500
Received: from smtpbgeu1.qq.com ([52.59.177.22]:44035 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfLMQ1d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Dec 2019 11:27:33 -0500
X-QQ-mid: bizesmtp19t1576254446t4w4lfrp
Received: from localhost.localdomain (unknown [222.247.17.206])
        by esmtp10.qq.com (ESMTP) with 
        id ; Sat, 14 Dec 2019 00:27:13 +0800 (CST)
X-QQ-SSF: 01400000002000I0ZH40B00A0000000
X-QQ-FEAT: uPKj8ga2w7H42ViRRlqzB4gBZaNosQzD/7Xdyx1ZPrXPzQL+3Z0s4JLvhQ1KL
        dgqqHhV+n15pdGI39XOPU5+8TFqri+0zS7J3mmW5IiCncpnYA9y+7hkR22gTHthmbKHkLOc
        oD3h2uEGK4+ddtETyKvGyP9IcsHgn/z0V31cllKTzavTxigN35sOdMOEmzO+O7VDBPXQYxp
        KtZjk+AaQt5hyiVMEyIeVQVjXweTT/NbxJbhzbk7/xhAve/7GKabjgMPEaM+sts5DQtzT5E
        dm1wPW2sXbm1nGZ2l5CPB43+esc7nmmHzPEFbNTofcP6CS3nCSOvNzDzAZfeEhd/hOkw==
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org
Subject: [PATCH v2] tools/acpi: fix compilation error
Date:   Sat, 14 Dec 2019 00:27:12 +0800
Message-Id: <20191213162712.6208-1-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If we compile tools/acpi target in the top source directory, we'd get a
compilation error showing as bellow:

	# make tools/acpi
	  DESCEND  power/acpi
	  DESCEND  tools/acpidbg
	  CC       tools/acpidbg/acpidbg.o
	Assembler messages:
	Fatal error: can't create /home/lzy/kernel-upstream/power/acpi/\
			tools/acpidbg/acpidbg.o: No such file or directory
	../../Makefile.rules:26: recipe for target '/home/lzy/kernel-upstream/\
			power/acpi/tools/acpidbg/acpidbg.o' failed
	make[3]: *** [/home/lzy/kernel-upstream//power/acpi/tools/acpidbg/\
			acpidbg.o] Error 1
	Makefile:19: recipe for target 'acpidbg' failed
	make[2]: *** [acpidbg] Error 2
	Makefile:54: recipe for target 'acpi' failed
	make[1]: *** [acpi] Error 2
	Makefile:1607: recipe for target 'tools/acpi' failed
	make: *** [tools/acpi] Error 2

Fixes: d5a4b1a540b ("tools/power/acpi: Remove direct kernel source include reference")
Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 tools/power/acpi/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
index 0111d246d1ca..54a2857c2510 100644
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
2.20.1



