Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C4103C5E
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2019 14:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbfKTNnO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Nov 2019 08:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbfKTNnO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Nov 2019 08:43:14 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B79422506;
        Wed, 20 Nov 2019 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257393;
        bh=U5rZPbPZ06Wr1xpfX9hE1Lt089G3VG/uwLT0YaauyMI=;
        h=From:To:Cc:Subject:Date:From;
        b=All4vmt4XaozM7KmU8JRULhH+IEuEGDnD6Eep9R64lSP0D4rK7JZmQW6rdl/DMSsF
         FJdIck8vJHCBQKnsUrzVHqweNWhtFN8FVUSUtcILaj2Sb83WzKaDFs38iJXpQSCCDE
         1l9EbVXXlnvmYnaYURIBUr0CJ9IRMZDD9KkoreN0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH] acpi: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:43:10 +0800
Message-Id: <20191120134310.16355-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/acpi/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 4fb97511a16f..002838d23b86 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -104,9 +104,9 @@ config ACPI_PROCFS_POWER
 	depends on X86 && PROC_FS
 	help
 	  For backwards compatibility, this option allows
-          deprecated power /proc/acpi/ directories to exist, even when
-          they have been replaced by functions in /sys.
-          The deprecated directories (and their replacements) include:
+	  deprecated power /proc/acpi/ directories to exist, even when
+	  they have been replaced by functions in /sys.
+	  The deprecated directories (and their replacements) include:
 	  /proc/acpi/battery/* (/sys/class/power_supply/*) and
 	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*).
 	  This option has no effect on /proc/acpi/ directories
@@ -448,7 +448,7 @@ config ACPI_CUSTOM_METHOD
 config ACPI_BGRT
 	bool "Boottime Graphics Resource Table support"
 	depends on EFI && (X86 || ARM64)
-        help
+	help
 	  This driver adds support for exposing the ACPI Boottime Graphics
 	  Resource Table, which allows the operating system to obtain
 	  data from the firmware boot splash. It will appear under
-- 
2.17.1

