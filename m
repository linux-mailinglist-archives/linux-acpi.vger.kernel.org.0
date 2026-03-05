Return-Path: <linux-acpi+bounces-21438-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE8jBIzeqWm4GgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21438-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 20:50:36 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6971F217C8B
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 20:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8270131412AD
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 19:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6C43D5674;
	Thu,  5 Mar 2026 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbelGDBp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE443A7F4F;
	Thu,  5 Mar 2026 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740096; cv=none; b=QYywvdLovRcnZ9T2N77i8QhW96yTY9Um81AHg9K8dTXxn21DqXDX5bC0onwLDJbiUYx1xO98Hx7gzIh8DVwz4FurzhZGfc/hSoyE1PxSizoQnc+w+aninFwG23yRF3ga8GnJhDLspZYjkO4/PuBCeJyJWUYNzaXXdWjIHb0O8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740096; c=relaxed/simple;
	bh=9yJer96MzJXuZvdxv6mJybxoA3s/Seq/8IaWNJOiWZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYOt4c59mL5P9YDCjfEjL54Hjt+C629VdwX28ifWDe6pdA96F7BK9x185Bmedo+rsmMtIeGBXbMHeScrG94uflKn2L3UZ6G41zz0GrLFzWj42DDxJGA+YA2J3IpwNPRErimK5UGDkMk+E6aqXZjlLh3SDjHYt7nwCOYdR2WSr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbelGDBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F6BC2BC9E;
	Thu,  5 Mar 2026 19:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772740095;
	bh=9yJer96MzJXuZvdxv6mJybxoA3s/Seq/8IaWNJOiWZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbelGDBp3wkzHB3rzx8aJe4OKMR54PPB267ejld2fr6/Hq9mD2OSCq9qFOsthSjzF
	 lrdaJ1yV4XPDOc9W/bHIZdcc03l9l2ArfgsEFVbe9xTnKObXi574LdkmI1pcJAJRc1
	 HTKfBgAaJwONrGDBNpQvPDVgQ0+Dq0LfEJGUWe9VC3rW0RZ3hkujVwN6G65qnlzTZx
	 FjzLA9miFdGIo6FchoVOOgsUui3Q2SgVOVfLcMfel5Ecgt3SkQhqJpXDaFRdUcPMVp
	 E4E25/di3sSMHBGX6/52wpC0gC02QG277qytx7izDDE99kq4FX+0qY+feyVodh7lEI
	 W2oZENK/UfRCA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject:
 [PATCH v2 4/6] platform/chrome: chromeos_tbmc: Convert to a platform driver
Date: Thu, 05 Mar 2026 20:42:25 +0100
Message-ID: <10827297.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6259948.lOV4Wx5bFT@rafael.j.wysocki>
References: <6259948.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6971F217C8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21438-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the ChromeOS tablet mode change (TBMC) ACPI
driver to a platform one.

After this change, the subordinate input device and wakeup source class
device will be registered under the platform device used for driver
binding instead of its ACPI companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Pass dev to acpi_pm_wakeup_event() in chromeos_tbmc_notify() (Tzung-Bi Shih)
   * Pass ACPI_COMPANION(dev) directly to chromeos_tbmc_query_switch in
     chromeos_tbmc_notify()

---
 drivers/platform/chrome/chromeos_tbmc.c | 47 ++++++++++++-------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
index 9c988e697d09..5133806b2d95 100644
--- a/drivers/platform/chrome/chromeos_tbmc.c
+++ b/drivers/platform/chrome/chromeos_tbmc.c
@@ -16,6 +16,7 @@
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/printk.h>
 
 #define DRV_NAME "chromeos_tbmc"
@@ -40,22 +41,20 @@ static int chromeos_tbmc_query_switch(struct acpi_device *adev,
 
 static __maybe_unused int chromeos_tbmc_resume(struct device *dev)
 {
-	struct acpi_device *adev = to_acpi_device(dev);
-
-	return chromeos_tbmc_query_switch(adev, adev->driver_data);
+	return chromeos_tbmc_query_switch(ACPI_COMPANION(dev), dev_get_drvdata(dev));
 }
 
 static void chromeos_tbmc_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *adev = data;
+	struct device *dev = data;
 
-	acpi_pm_wakeup_event(&adev->dev);
+	acpi_pm_wakeup_event(dev);
 	switch (event) {
 	case 0x80:
-		chromeos_tbmc_query_switch(adev, adev->driver_data);
+		chromeos_tbmc_query_switch(ACPI_COMPANION(dev), dev_get_drvdata(dev));
 		break;
 	default:
-		dev_err(&adev->dev, "Unexpected event: 0x%08X\n", event);
+		dev_err(dev, "Unexpected event: 0x%08X\n", event);
 	}
 }
 
@@ -66,10 +65,11 @@ static int chromeos_tbmc_open(struct input_dev *idev)
 	return chromeos_tbmc_query_switch(adev, idev);
 }
 
-static int chromeos_tbmc_add(struct acpi_device *adev)
+static int chromeos_tbmc_probe(struct platform_device *pdev)
 {
 	struct input_dev *idev;
-	struct device *dev = &adev->dev;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	int ret;
 
 	idev = devm_input_allocate_device(dev);
@@ -85,7 +85,7 @@ static int chromeos_tbmc_add(struct acpi_device *adev)
 	idev->open = chromeos_tbmc_open;
 
 	input_set_drvdata(idev, adev);
-	adev->driver_data = idev;
+	platform_set_drvdata(pdev, idev);
 
 	input_set_capability(idev, EV_SW, SW_TABLET_MODE);
 	ret = input_register_device(idev);
@@ -96,7 +96,7 @@ static int chromeos_tbmc_add(struct acpi_device *adev)
 	device_init_wakeup(dev, true);
 
 	ret = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-					      chromeos_tbmc_notify, adev);
+					      chromeos_tbmc_notify, dev);
 	if (ret) {
 		dev_err(dev, "cannot install ACPI notify handler\n");
 		device_init_wakeup(dev, false);
@@ -106,11 +106,11 @@ static int chromeos_tbmc_add(struct acpi_device *adev)
 	return 0;
 }
 
-static void chromeos_tbmc_remove(struct acpi_device *adev)
+static void chromeos_tbmc_remove(struct platform_device *pdev)
 {
-	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-				       chromeos_tbmc_notify);
-	device_init_wakeup(&adev->dev, false);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, chromeos_tbmc_notify);
+	device_init_wakeup(&pdev->dev, false);
 }
 
 static const struct acpi_device_id chromeos_tbmc_acpi_device_ids[] = {
@@ -122,18 +122,17 @@ MODULE_DEVICE_TABLE(acpi, chromeos_tbmc_acpi_device_ids);
 static SIMPLE_DEV_PM_OPS(chromeos_tbmc_pm_ops, NULL,
 		chromeos_tbmc_resume);
 
-static struct acpi_driver chromeos_tbmc_driver = {
-	.name = DRV_NAME,
-	.class = DRV_NAME,
-	.ids = chromeos_tbmc_acpi_device_ids,
-	.ops = {
-		.add = chromeos_tbmc_add,
-		.remove = chromeos_tbmc_remove,
+static struct platform_driver chromeos_tbmc_driver = {
+	.probe = chromeos_tbmc_probe,
+	.remove = chromeos_tbmc_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.acpi_match_table = chromeos_tbmc_acpi_device_ids,
+		.pm = &chromeos_tbmc_pm_ops,
 	},
-	.drv.pm = &chromeos_tbmc_pm_ops,
 };
 
-module_acpi_driver(chromeos_tbmc_driver);
+module_platform_driver(chromeos_tbmc_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("ChromeOS ACPI tablet switch driver");
-- 
2.51.0





