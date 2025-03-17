Return-Path: <linux-acpi+bounces-12287-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0220A64934
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 11:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C2188ED72
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7523909E;
	Mon, 17 Mar 2025 10:14:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C308023645D;
	Mon, 17 Mar 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206444; cv=none; b=VwtZsrif7XxfJB8npXMybk11/b5kiTC/4wFH+9vUTrZKYlkvXCW388LrDxqP37U3lRwxhWiID9BeJ8hkFhn6tAPArKpO4Uc5e4tbzjUCK5AhhkAx1RAMLGaA3Dbo72ffVzgILQGBDVCUrAEeeoOtNGoR6lNas/ArALrHgltCDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206444; c=relaxed/simple;
	bh=ywFI/S2i8yTE8gFcovtkn//B6t4qpEs2iVleL9VM4zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jdUZGv6p0mL1Cp5Ri8ltFEMYb8N2pi9OqAQmMnTTpgyRxtGH89HQvXUXAM8tlVlHwJzuqZWiEipledErZ4v1af2lkJoEePijOt0LUDjaWh5DGotAtz+M3ieN8zxQlwatNvCQeEn7l9vKKBQBVedXbgTM7KTiGAsKyP8rIZPW19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 797142573;
	Mon, 17 Mar 2025 03:14:11 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 638563F7B4;
	Mon, 17 Mar 2025 03:14:01 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Mar 2025 10:13:20 +0000
Subject: [PATCH 8/9] ACPI: APEI: EINJ: Transition to the faux device
 interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-plat2faux_dev-v1-8-5fe67c085ad5@arm.com>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
In-Reply-To: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 linux-acpi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3336; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=ywFI/S2i8yTE8gFcovtkn//B6t4qpEs2iVleL9VM4zs=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn1/XbxK02iKuh6vcw6iAjehSa3S6UMiG+96MsM
 zJXFbdf1/qJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9f12wAKCRAAQbq8MX7i
 mB37D/4ovEInkPK8eY+oQASeTRDXRzeQzFPmc3cvH2vvGwTUh6fkSHbcNhowbmb+kePLcPvoLvO
 za89HLvSPZ+m/BklTEmqUBaTPtPcW6uNYuOHzH8jr/7ewAFnszg9UNhZnnug1gZVByE1O7cWOXy
 SumTbvEeSlKFRhT2RbcvSxpSmZLg1xwIvBT2i8YhCbd8xQhcR8d7/YVveToZxTT9PvkGWcSEx7x
 jwaN1N2uAvnftBcSBBTYnoP11p9o7lQJCdIahs+LErslMC4c+pW0e8c/Aw434Em0c+Ii3nHYvn3
 vGY0aEvpdyYur+RC113iuutTbE90ooZaVwFvp7Lu5JE0DFqRSynNbchnB46R1mz12n6jq2eecLE
 WZbPu1u1anOGpYJC5lcwh7ZF7do061cx1FBrHHyBiT0Ee9iq5lxijmDRllLp1mKYQ1L/ttaAQCS
 VG8Rjn7vd15DuaOQ3zWCTZX/ANnF19nb1bjMCdosB0osj/f6Un31v4Ou9V+mVN64DzywR+6bPu0
 jNv9rAyjMDrNEQIMZIlffF8GPYN1EEXmYpcAIS6ids37wsYGpCeGOsu0/O/OZ478Dpaye10Wqqw
 mSZGwkURhSCiUoJGU3RGRGBtq+PVQS2vW53wsbvQolxO4w2uZ9dnm6pCHI3lkr4FchNX6Azv5W7
 tCzC6UZeeGPtTzw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The APEI error injection driver does not require the creation of a
platform device. Originally, this approach was chosen for simplicity
when the driver was first implemented.

With the introduction of the lightweight faux device interface, we now
have a more appropriate alternative. Migrate the driver to utilize the
faux bus, given that the platform device it previously created was not
a real one anyway. This will simplify the code, reducing its footprint
while maintaining functionality.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/apei/einj-core.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 04731a5b01faaba534bad853d0acc4c8a873a53b..7ff334422899e757de918107202507dd171d61da 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -21,7 +21,7 @@
 #include <linux/nmi.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
-#include <linux/platform_device.h>
+#include <linux/device/faux.h>
 #include <linux/unaligned.h>
 
 #include "apei-internal.h"
@@ -749,7 +749,7 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
-static int __init einj_probe(struct platform_device *pdev)
+static int __init einj_probe(struct faux_device *fdev)
 {
 	int rc;
 	acpi_status status;
@@ -851,7 +851,7 @@ static int __init einj_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static void __exit einj_remove(struct platform_device *pdev)
+static void __exit einj_remove(struct faux_device *fdev)
 {
 	struct apei_exec_context ctx;
 
@@ -872,34 +872,25 @@ static void __exit einj_remove(struct platform_device *pdev)
 	acpi_put_table((struct acpi_table_header *)einj_tab);
 }
 
-static struct platform_device *einj_dev;
+static struct faux_device *einj_dev;
 /*
  * einj_remove() lives in .exit.text. For drivers registered via
  * platform_driver_probe() this is ok because they cannot get unbound at
  * runtime. So mark the driver struct with __refdata to prevent modpost
  * triggering a section mismatch warning.
  */
-static struct platform_driver einj_driver __refdata = {
+static struct faux_device_ops einj_device_ops __refdata = {
+	.probe = einj_probe,
 	.remove = __exit_p(einj_remove),
-	.driver = {
-		.name = "acpi-einj",
-	},
 };
 
 static int __init einj_init(void)
 {
-	struct platform_device_info einj_dev_info = {
-		.name = "acpi-einj",
-		.id = -1,
-	};
-	int rc;
-
-	einj_dev = platform_device_register_full(&einj_dev_info);
-	if (IS_ERR(einj_dev))
-		return PTR_ERR(einj_dev);
+	einj_dev = faux_device_create("acpi-einj", NULL, &einj_device_ops);
+	if (!einj_dev)
+		return -ENODEV;
 
-	rc = platform_driver_probe(&einj_driver, einj_probe);
-	einj_initialized = rc == 0;
+	einj_initialized = true;
 
 	return 0;
 }
@@ -907,9 +898,8 @@ static int __init einj_init(void)
 static void __exit einj_exit(void)
 {
 	if (einj_initialized)
-		platform_driver_unregister(&einj_driver);
+		faux_device_destroy(einj_dev);
 
-	platform_device_unregister(einj_dev);
 }
 
 module_init(einj_init);

-- 
2.34.1


