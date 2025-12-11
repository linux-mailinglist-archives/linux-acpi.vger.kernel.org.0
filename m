Return-Path: <linux-acpi+bounces-19550-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D84CCB62C7
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 15:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F36C3010A97
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F27253340;
	Thu, 11 Dec 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fssdghVQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7924A05D;
	Thu, 11 Dec 2025 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462930; cv=none; b=jg6Ar9XPsD55VbRaeYKpfQAl9BeIJF3IMlEN5xsQ/Nuan9WEg0gdoxV8yscDS/fhkrSmSj5OqgU4V8TSCvifTWJ/Dt6Whpp6BoXIzihTh+ebMnEFZ/Y0hKs0wTyl0Og29cxlmX/U9vwOSt9YptomvHNLepw4Tejw10HSBxgw0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462930; c=relaxed/simple;
	bh=wo7OI8uOaxRflEssZX4egi7ehSYDFXojYA+F+vTiuas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNpnhB6AnDh84u+FkhWYTJsXjWqLL4JpuN5P2WSHS894F1xqgHjXfv12ldYyoIV2NJ39N8OvheXvTeP+jZbPa15a2k6nQdXpXAtWMXW8sRrN7MUzVri9muSB3LJFXMmi1f117VRqGiHCsERsvCOdsLdwZzVacrSqwDXdWaUhnEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fssdghVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B962C4CEF7;
	Thu, 11 Dec 2025 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765462930;
	bh=wo7OI8uOaxRflEssZX4egi7ehSYDFXojYA+F+vTiuas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fssdghVQOIbfuasOMt556uIlYgAOZ2oDlgm21RhBbl9B3xO2FBNR5/AOuXqSWVV6J
	 IlqxLXUEpgp3LQGhTlCj14ugf6QaXZx9SIsOkPq8SgLrDSFq29/zkQFevwvKdesGev
	 9rlCilC0D1O5HfNcmsTDDjMg4i0sctGCoFGo/AzvUPKkkSfD79xiqj/GJabGbutpTK
	 +4QkGCI2h22WmhcphOhtfd0GU7+0hM+VxZWJu/yHkriQtzatQ081vMzjAobNIAu7pD
	 ccVlhochPXP4JnXneK5Ukz8xuj9xzlXxbZ0C7chYEYw4ig1Jz+olZ6PgCitFWqW1hd
	 oEZxkxNwut65A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev
Subject:
 [RFT][PATCH v1 6/6] ACPI: NFIT: core: Convert the driver to a platform one
Date: Thu, 11 Dec 2025 15:22:00 +0100
Message-ID: <2028345.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5066996.31r3eYUQgx@rafael.j.wysocki>
References: <5066996.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

While binding drivers directly to struct acpi_device objects allows
basic functionality to be provided, at least in the majority of cases,
there are some problems with it, related to general consistency, sysfs
layout, power management operation ordering, and code cleanliness.

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the ACPI NFIT core driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

This change was mostly developed by Michal Wilczynski [1].

Linu: https://lore.kernel.org/linux-acpi/20231011083334.3987477-6-michal.wilczynski@intel.com/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/nfit/core.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2,6 +2,7 @@
 /*
  * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
  */
+#include <linux/platform_device.h>
 #include <linux/list_sort.h>
 #include <linux/libnvdimm.h>
 #include <linux/module.h>
@@ -98,7 +99,7 @@ static struct acpi_device *to_acpi_dev(s
 			|| strcmp(nd_desc->provider_name, "ACPI.NFIT") != 0)
 		return NULL;
 
-	return to_acpi_device(acpi_desc->dev);
+	return ACPI_COMPANION(acpi_desc->dev);
 }
 
 static int xlat_bus_status(void *buf, unsigned int cmd, u32 status)
@@ -3283,11 +3284,11 @@ static void acpi_nfit_put_table(void *ta
 
 static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *adev = data;
+	struct device *dev = data;
 
-	device_lock(&adev->dev);
-	__acpi_nfit_notify(&adev->dev, handle, event);
-	device_unlock(&adev->dev);
+	device_lock(dev);
+	__acpi_nfit_notify(dev, handle, event);
+	device_unlock(dev);
 }
 
 static void acpi_nfit_remove_notify_handler(void *data)
@@ -3328,18 +3329,19 @@ void acpi_nfit_shutdown(void *data)
 }
 EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
 
-static int acpi_nfit_add(struct acpi_device *adev)
+static int acpi_nfit_probe(struct platform_device *pdev)
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_nfit_desc *acpi_desc;
-	struct device *dev = &adev->dev;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpi_table_header *tbl;
 	acpi_status status = AE_OK;
 	acpi_size sz;
 	int rc = 0;
 
 	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-					     acpi_nfit_notify, adev);
+					     acpi_nfit_notify, dev);
 	if (rc)
 		return rc;
 
@@ -3369,7 +3371,7 @@ static int acpi_nfit_add(struct acpi_dev
 	acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
 	if (!acpi_desc)
 		return -ENOMEM;
-	acpi_nfit_desc_init(acpi_desc, &adev->dev);
+	acpi_nfit_desc_init(acpi_desc, dev);
 
 	/* Save the acpi header for exporting the revision via sysfs */
 	acpi_desc->acpi_header = *tbl;
@@ -3474,11 +3476,11 @@ static const struct acpi_device_id acpi_
 };
 MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
 
-static struct acpi_driver acpi_nfit_driver = {
-	.name = KBUILD_MODNAME,
-	.ids = acpi_nfit_ids,
-	.ops = {
-		.add = acpi_nfit_add,
+static struct platform_driver acpi_nfit_driver = {
+	.probe = acpi_nfit_probe,
+	.driver = {
+		.name = "acpi-nfit",
+		.acpi_match_table = acpi_nfit_ids,
 	},
 };
 
@@ -3516,7 +3518,7 @@ static __init int nfit_init(void)
 		return -ENOMEM;
 
 	nfit_mce_register();
-	ret = acpi_bus_register_driver(&acpi_nfit_driver);
+	ret = platform_driver_register(&acpi_nfit_driver);
 	if (ret) {
 		nfit_mce_unregister();
 		destroy_workqueue(nfit_wq);
@@ -3529,7 +3531,7 @@ static __init int nfit_init(void)
 static __exit void nfit_exit(void)
 {
 	nfit_mce_unregister();
-	acpi_bus_unregister_driver(&acpi_nfit_driver);
+	platform_driver_unregister(&acpi_nfit_driver);
 	destroy_workqueue(nfit_wq);
 	WARN_ON(!list_empty(&acpi_descs));
 }




