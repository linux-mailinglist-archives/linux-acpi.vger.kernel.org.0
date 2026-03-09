Return-Path: <linux-acpi+bounces-21562-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNFVJJYAr2kLLgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21562-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:17:10 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 008B923D866
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59940304A308
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 17:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9F13E9584;
	Mon,  9 Mar 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDoME29N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572C73E715E;
	Mon,  9 Mar 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076302; cv=none; b=U7hx/92fGZW6zYuJR4n5CA3I3kEug4xLwg9JZZd1vo2azLt3ewoi4QrTavx5fK4TN6NyiHTKdMDdkGf13jKg8nTi1Pq0KK14KrrfT0Z9LftmCbZmJUDqzQazISRjK7efvyd3+e435VOD/+Za/sjYyFPIJMzf1tFg+EZGTqSMqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076302; c=relaxed/simple;
	bh=jsiZ72dH4C7CJpXRgfCL0JKV94O6etWwx7WY1HmnX90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJoI9xtmD/hX+5gmzkGK0/lp649wuCfimQzguOTsKxg5urMzQgOObp/yHhMEJnH1ZKhM5Z4iFMOfvCGzAZasLnC4Khj1MKjhA3Qi624XspRZWxl8Z/3Yo10L4WiZxFO+g/220WpGsIcMDuPGF6FHHWN0Ys3FA2g+xdHbh+KcUrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDoME29N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487C3C4CEF7;
	Mon,  9 Mar 2026 17:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773076302;
	bh=jsiZ72dH4C7CJpXRgfCL0JKV94O6etWwx7WY1HmnX90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDoME29NKgsYmu22hndzrcXkxRMq6Sjc5OJuiO+uR+lgpui8foY9gMiAqJeqfk1aj
	 3tr1+3YwM+8Ua9+NotAF25zqzESig/B/LNbdGn0ZClVd+Hz+GlgFii3HRmmVzVfn+m
	 uMfOKmbutbi3YVNuMSVL6y4QCvG9NXKyHivuefxaUS5IBng/yeINAG3a7N2oj2Qmzf
	 ifn6jLYVzdeCXgjrKThCz7AgsNR07WZWpaFjjbcVL+Vl8ErG6M2C2sz2VNY/O9yple
	 GDD+OoIBBuYPVdvw4nU8Bg+bYIZhW5LLgTQhtGBFZdPIn3knziblsngFwU2Gq9Chdt
	 ZoyArvZy1cljQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 [PATCH v2 1/5] platform/x86: fujitsu-tablet: Convert ACPI driver to a
 platform one
Date: Mon, 09 Mar 2026 18:04:15 +0100
Message-ID: <6257931.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12863082.O9o76ZdvQC@rafael.j.wysocki>
References: <12863082.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 008B923D866
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,vger.kernel.org,just42.net];
	TAGGED_FROM(0.00)[bounces-21562-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rafael.j.wysocki:mid,intel.com:email]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the fujitsu-tablet ACPI driver to a platform
one.

After this change, the subordinate input device will be registered under
the platform device used for driver binding instead of its ACPI companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/platform/x86/fujitsu-tablet.c | 30 +++++++++++++--------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-tablet.c b/drivers/platform/x86/fujitsu-tablet.c
index 17f08ce7552d..8319df28e9b8 100644
--- a/drivers/platform/x86/fujitsu-tablet.c
+++ b/drivers/platform/x86/fujitsu-tablet.c
@@ -18,6 +18,7 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
+#include <linux/platform_device.h>
 
 #define MODULENAME "fujitsu-tablet"
 
@@ -442,14 +443,12 @@ static acpi_status fujitsu_walk_resources(struct acpi_resource *res, void *data)
 	}
 }
 
-static int acpi_fujitsu_add(struct acpi_device *adev)
+static int acpi_fujitsu_probe(struct platform_device *pdev)
 {
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 	int error;
 
-	if (!adev)
-		return -EINVAL;
-
 	status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
 			fujitsu_walk_resources, NULL);
 	if (ACPI_FAILURE(status) || !fujitsu.irq || !fujitsu.io_base)
@@ -461,7 +460,7 @@ static int acpi_fujitsu_add(struct acpi_device *adev)
 	snprintf(fujitsu.phys, sizeof(fujitsu.phys),
 			"%s/input0", acpi_device_hid(adev));
 
-	error = input_fujitsu_setup(&adev->dev,
+	error = input_fujitsu_setup(&pdev->dev,
 		acpi_device_name(adev), fujitsu.phys);
 	if (error)
 		return error;
@@ -484,7 +483,7 @@ static int acpi_fujitsu_add(struct acpi_device *adev)
 	return 0;
 }
 
-static void acpi_fujitsu_remove(struct acpi_device *adev)
+static void acpi_fujitsu_remove(struct platform_device *pdev)
 {
 	free_irq(fujitsu.irq, fujitsu_interrupt);
 	release_region(fujitsu.io_base, fujitsu.io_length);
@@ -501,15 +500,14 @@ static int acpi_fujitsu_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(acpi_fujitsu_pm, NULL, acpi_fujitsu_resume);
 
-static struct acpi_driver acpi_fujitsu_driver = {
-	.name  = MODULENAME,
-	.class = "hotkey",
-	.ids   = fujitsu_ids,
-	.ops   = {
-		.add    = acpi_fujitsu_add,
-		.remove	= acpi_fujitsu_remove,
+static struct platform_driver acpi_fujitsu_driver = {
+	.probe = acpi_fujitsu_probe,
+	.remove = acpi_fujitsu_remove,
+	.driver = {
+		.name = MODULENAME,
+		.acpi_match_table = fujitsu_ids,
+		.pm = &acpi_fujitsu_pm,
 	},
-	.drv.pm = &acpi_fujitsu_pm,
 };
 
 static int __init fujitsu_module_init(void)
@@ -518,7 +516,7 @@ static int __init fujitsu_module_init(void)
 
 	dmi_check_system(dmi_ids);
 
-	error = acpi_bus_register_driver(&acpi_fujitsu_driver);
+	error = platform_driver_register(&acpi_fujitsu_driver);
 	if (error)
 		return error;
 
@@ -527,7 +525,7 @@ static int __init fujitsu_module_init(void)
 
 static void __exit fujitsu_module_exit(void)
 {
-	acpi_bus_unregister_driver(&acpi_fujitsu_driver);
+	platform_driver_unregister(&acpi_fujitsu_driver);
 }
 
 module_init(fujitsu_module_init);
-- 
2.51.0





