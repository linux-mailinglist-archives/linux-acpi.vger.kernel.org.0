Return-Path: <linux-acpi+bounces-12328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5BBA67A47
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 18:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284771887559
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E582135D1;
	Tue, 18 Mar 2025 17:02:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96734213232;
	Tue, 18 Mar 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317361; cv=none; b=L7aq1FWMemg8ytgzPphSWU0bfE8YFrHo9UGjXqMz+JxgHmBvZLwuXxXijkzFzzSXD3BlrQ7xMVN6JObjzxGUHcI7WZ7MmXB7+o5Ryh4IqhueMslfmbGFK/0PGOLygQ495ohNG1VA/93/HkShPV103FWk4mKuQhPS81wsd6H17T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317361; c=relaxed/simple;
	bh=/bAirk6rBlMWq+httm7PTGquFnI6pduDOeCYwyFLe+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NH/7R0HsAw8lj4KFXR077NhocUkEpBH9h5IDSk6yEDO8YFGZl3/DdF9OUCHNAdbEaN0kk9XjFGPCK7VnUzmtsCKtbMbzxC66guma+EaMZudCyjOh118q4AOsKQltfqc/TsTtFc/os1fPa4HufjwHAC1Dw5lFaxG8U1v84tNMDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D293A16F3;
	Tue, 18 Mar 2025 10:02:47 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E5BC3F673;
	Tue, 18 Mar 2025 10:02:38 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 18 Mar 2025 17:01:45 +0000
Subject: [PATCH v2 7/8] ACPI: APEI: EINJ: Transition to the faux device
 interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-plat2faux_dev-v2-7-e6cc73f78478@arm.com>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
In-Reply-To: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 linux-acpi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3381; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=/bAirk6rBlMWq+httm7PTGquFnI6pduDOeCYwyFLe+o=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn2aci6wpndPy+2NHMogIGoHzkxDmoWhUU/C4rZ
 xszYf2K0ZGJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9mnIgAKCRAAQbq8MX7i
 mLRsEAC0afJOZaEhOmva14LMUcOyvGqu9EFoBmReJtr6LdbtgE7iwmLqhF8jhvAmgSOd3R00z+T
 tLfNTvnytWkGDrfiZTbLcN0mmrqa3ItEkbmZYaSBV6V1d8gnINlM4SEbz2L+gkofPub9FFYdJ/6
 ZK4b37Ry54UybijpKkLEkZBqr4otPfuBHUa2yH5paO1wAlqrXvpj+dteOJt/J9nTmV2rOuY/Tlf
 +io4pUh0KPxNyzxBVHJaKbd3pyKmILIBnl/V0baEdHGMIJsf3tyeEwfJ0qGp41tMLDHdsFTBbWH
 SmbPzjLDMCCOCgVa6lYeGVHxnLYipq0l0PkeQkxhaZ1UfO3INutwhTNvCrYc8oYGareB1XbfUBJ
 9uXibFM5PCVbw9ziRJ6fXZxqgBsVc6rk4j3Yie/Z0er3oQgJZY867tBXYup/APxliWfkMd5uB2x
 s7PVefCoJ6WgZUa5I5KgMOwx+pTXiylRAYAY2m+BCOE/0T1bdiP4vsNib9D5OAkhi5TNNeTwaWo
 Lh1HWEY/BhoIBHYMMrp+9Lb+bim+XJDzmWqAque7xAePnuDo/VILviDrVIDTbnrPE3QoW5SZqTA
 g3qCT6ELO5/AJGvgmqAdNRN5CVVkdDYZPtOZ8SCwVrcWadnDpwrUAEGhnQOisiYW1nj4lLYdj/3
 4zxxywqt8RvqiMA==
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
 drivers/acpi/apei/einj-core.c | 51 +++++--------------------------------------
 1 file changed, 6 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 04731a5b01faaba534bad853d0acc4c8a873a53b..5fddd01074bafab2f7b23fd7ef9f863c0856637b 100644
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
@@ -838,6 +838,8 @@ static int __init einj_probe(struct platform_device *pdev)
 
 	pr_info("Error INJection is initialized.\n");
 
+	einj_initialized = true;
+
 	return 0;
 
 err_release:
@@ -851,7 +853,7 @@ static int __init einj_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static void __exit einj_remove(struct platform_device *pdev)
+static void __exit einj_remove(struct faux_device *fdev)
 {
 	struct apei_exec_context ctx;
 
@@ -872,48 +874,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 	acpi_put_table((struct acpi_table_header *)einj_tab);
 }
 
-static struct platform_device *einj_dev;
-/*
- * einj_remove() lives in .exit.text. For drivers registered via
- * platform_driver_probe() this is ok because they cannot get unbound at
- * runtime. So mark the driver struct with __refdata to prevent modpost
- * triggering a section mismatch warning.
- */
-static struct platform_driver einj_driver __refdata = {
-	.remove = __exit_p(einj_remove),
-	.driver = {
-		.name = "acpi-einj",
-	},
-};
-
-static int __init einj_init(void)
-{
-	struct platform_device_info einj_dev_info = {
-		.name = "acpi-einj",
-		.id = -1,
-	};
-	int rc;
-
-	einj_dev = platform_device_register_full(&einj_dev_info);
-	if (IS_ERR(einj_dev))
-		return PTR_ERR(einj_dev);
-
-	rc = platform_driver_probe(&einj_driver, einj_probe);
-	einj_initialized = rc == 0;
-
-	return 0;
-}
-
-static void __exit einj_exit(void)
-{
-	if (einj_initialized)
-		platform_driver_unregister(&einj_driver);
-
-	platform_device_unregister(einj_dev);
-}
-
-module_init(einj_init);
-module_exit(einj_exit);
+module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remove), true);
 
 MODULE_AUTHOR("Huang Ying");
 MODULE_DESCRIPTION("APEI Error INJection support");

-- 
2.34.1


