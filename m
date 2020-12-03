Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6A42CDCA8
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 18:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgLCRr0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 12:47:26 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:33771 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgLCRr0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 12:47:26 -0500
Received: from orion.localdomain ([95.118.71.13]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N79ly-1k6NSs0f5Y-017V2z; Thu, 03 Dec 2020 18:44:54 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org
Subject: [PATCH] drivers: acpi: add opt-out of Apple-specific property parsing
Date:   Thu,  3 Dec 2020 18:44:53 +0100
Message-Id: <20201203174453.12084-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:LvjuyA2u5eCtPPbEeuvjQ0IX4ORlQhvyN6V9Z3iNHsVxtOMeRF+
 ihOt8bi5Z8R4JrbzQasJMijNrgT3MiU/cfRQY015uV/sDMtDsQSSGXnv7PDRxa23jaPHGtp
 bMY2BiTtGjxUyadvuzdOSKhQUBjOoX8mXuNdbz4T3Tp0HUMm16Paiqfa3zd/zEKsSQvUEuI
 lrGEGef1IZweZVHxtiCaw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kJR+McMam84=:xjk6yLz3jJfMAu/OtaR5B7
 oVcoKONx0vrXLqQhiB17Fle6pMnmd/Ibb0gjxNA5E3ef5LdKU766Q5ytdpGzQJP0C0eQPmNcT
 t36TmRMYEakHYTqYUgSRdgt3JpdWTcdcWpLy5ZDqYZZWtw8Od6d4K9fyAuH6NMsHdmxib1kNu
 oVHDDiEFMM8myZuq9n0wLD+T8ggR3fxS0lloiXsw6Pi+MaplO7FpFqcNGqNztfmFN57VeVS1p
 GgEmhtfhnl4EZELmFuc2LGZRGhTgupJ16dGJEKr5d3nLcCY80BiEzaMhN851j5/gLZTBAdfz1
 1LK+5EGKJrK2xjS30Ha67nqZvqNAAFWiC8IdxnA5Lke3V5q2P5cwP16ViyGvVX0hmhpbvNwjX
 jR1JFYBsmBQd8dqrKh89wMpJWRy06S8LATl5C262OnuvABKurXXE3b71kfVHu
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
index edf1558c1105..cc47de4f2b18 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -79,6 +79,15 @@ config ACPI_DEBUGGER_USER
 
 endif
 
+config ACPI_APPLE
+	bool "Apple ACPI properties support"
+	default y if X86
+	help
+	  Extraction of Apple-specific ACPI properties.
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

