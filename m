Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70462CBCE9
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 13:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgLBMX4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 07:23:56 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:37389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbgLBMX4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 07:23:56 -0500
Received: from orion.localdomain ([77.7.48.174]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Moex5-1kQHoj0zRx-00p8QN; Wed, 02 Dec 2020 13:21:24 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org
Subject: [PATCH v2] drivers: acpi: add opt-out of apple-specific property parsing
Date:   Wed,  2 Dec 2020 13:21:23 +0100
Message-Id: <20201202122123.10229-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:W3Iutmi7LBFpSyCo5rZCCS/c5K8FL0WvJChVOC6nWMFtMYtXI2K
 i/q0G/CTMcYTu5+Ooq0wvNDXf5Ibd1TFeHlMgWk8Lz9/eYxAPB3M23s2kRNdP8PudJQmuC9
 +vHwOHD47KyIZrpypB3LO36+ZtTSWVZgsWXQ0LgNdb2TXl1KwIbWUKblr7/XyAmuztGh+xW
 yAwBKl09y5ZinWBgsXtoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tV5PEq4x9YY=:mM6j4bsRX9vrs1qwd0PqHF
 9Keo9sC3RXo/wxvM8eU7PKOUJ3KKJDDH2+Nd5XDslZZbZ+lOrgsNsTiOBEcbSp0hDKxiq311R
 QEXJkq/ms6Cr6/zr2mMS1gTbXl7JxktuC37spVw6herTbTep7K6Ax9l5Ytl3LYxWjHwdvvNbm
 qMFbc7Vb/6lxi1YfVtuW9285AYUngh0pTHlSM6OY8SFGjxWYLxUGlx1aZBkxVvIOnJSKDPckr
 yHkSnx3/mkXPzgvKwcJ8VEUDJMdR3HDz7DfHTRPdngbDhJAr4qJ1EFsioUposnHTTe8mJ7T8M
 g/BILce4mWo/aXx6vPVfbx63rLV+GXt0hryDQjEOFgoTjdvGnH2VduiGHkFW0EqBQPhZ90ecM
 yOlNPiKv7RuAl5YXyANGHdL4XBG9bJi4KTXaSzkWfq/7AtGdbsSX07g1mzxzK
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Most x86 machines aren't Apple machines, especially VMs.
Therefore allow opt-out, making the kernel a few KBs smaller,
eg. for embedded or high-density VMs.

v2: fixed spelling

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/acpi/Kconfig    | 9 +++++++++
 drivers/acpi/Makefile   | 2 +-
 drivers/acpi/internal.h | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index edf1558c1105..fc37a9a5c2a8 100644
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
+	  and wanna save a few kb of memory. (embedded or high-density VMs)
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

