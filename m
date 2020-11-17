Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A72B6FE9
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Nov 2020 21:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKQUSz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Nov 2020 15:18:55 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:34221 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgKQUS2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2020 15:18:28 -0500
Received: from orion.localdomain ([95.118.38.12]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McYTD-1k7RqJ0FQ5-00cx1k; Tue, 17 Nov 2020 21:18:26 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org
Subject: [PATCH] drivers: acpi: add opt-out of apple specific property parsing
Date:   Tue, 17 Nov 2020 21:18:25 +0100
Message-Id: <20201117201825.5407-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:PMKVWnJzeGOzbtZcmilemO9rWYAtnvu8yK2MXEFiwWeIQJ83dpH
 Lv5/UDcVr4VFBItZJmXSS47xTQ+6/Q+jXLtVFsY2OUbd/4ntzZ2hioMGQusfmy/cbmZVZS9
 oRM69xBrICKCK33uD1vPU5aPeFmTpuVUmnxCsNSu9EM1tu63087zTaXKLx5g91kgAFQDCEU
 LFTq9ukHHs7hb7s3pyBjg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JGnAKppJWHg=:vTneKqHMki2b90zYBacWrH
 E50DSBZ74t5iIUl3anzBC8xGQPdGPdKrsqHdO2/mP4ySq9hFQsxP+ozBurFjiu1DMlBQNONDE
 Y6tcK9Y/nuthm5zyNt1mgyhOs+kr8aMFw81j+Jr/Mx16tf9ZURn6z7gmnNUvyl62nRCGoO5nE
 hM6oPhvC4KDISpJOxFfRX0b9s1KMvXOXWZ8khYGiHEvfYaigJGHPPO9ATj0tGFmGwSzlS+d1v
 yoza1AdbBvX0Cl8ghc1rS0O7MeexNrGfXqTP6/Xmyb92mXkC+5Nd8Nlf40dbGBmyRzPF+kVN8
 8vb1j9t1SJFB3I9BV7YsFsP5NcPw0r0SGUkHZ9KbqiP0DJWGrtF6qDiYI3wJq/wJ+sVvspQea
 S+nS8N8g/tLXWLhnl8Xn8K/zPICLp9dCV9uc84YI/sly6d8wwXweV105gVgDN
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Most x86 machines aren't Apple machines, especially VMs.
Therefore allow opt-out, making the kernel a few KBs smaller,
eg. for embedded or high-density VMs.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/acpi/Kconfig    | 9 +++++++++
 drivers/acpi/Makefile   | 2 +-
 drivers/acpi/internal.h | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index edf1558c1105..398a9ae73705 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -79,6 +79,15 @@ config ACPI_DEBUGGER_USER
 
 endif
 
+config ACPI_APPLE
+	bool "Apple ACPI properties support"
+	default y if X86
+	help
+	  Extraction of apple specific ACPI properties.
+
+	  Say N if you're sure the kernel won't be used on an Apple machine
+	  and wanna save a few kb of memory. (embedded or hi-density VMs)
+
 config ACPI_SPCR_TABLE
 	bool "ACPI Serial Port Console Redirection Support"
 	default y if X86
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 44e412506317..ed1f4405c90a 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -52,7 +52,7 @@ acpi-y				+= evged.o
 acpi-y				+= sysfs.o
 acpi-y				+= property.o
 acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
-acpi-$(CONFIG_X86)		+= x86/apple.o
+acpi-$(CONFIG_ACPI_APPLE)	+= x86/apple.o
 acpi-$(CONFIG_X86)		+= x86/utils.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-y				+= acpi_lpat.o
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index e3638bafb941..fa1b6ef7829a 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -239,7 +239,7 @@ static inline void suspend_nvs_restore(void) {}
 void acpi_init_properties(struct acpi_device *adev);
 void acpi_free_properties(struct acpi_device *adev);
 
-#ifdef CONFIG_X86
+#ifdef CONFIG_ACPI_APPLE
 void acpi_extract_apple_properties(struct acpi_device *adev);
 #else
 static inline void acpi_extract_apple_properties(struct acpi_device *adev) {}
-- 
2.11.0

