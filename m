Return-Path: <linux-acpi+bounces-21257-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFSMFGgIo2m/9AQAu9opvQ
	(envelope-from <linux-acpi+bounces-21257-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:23:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A9E1C3E1F
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83A65309FBB3
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BDB478873;
	Sat, 28 Feb 2026 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqmlCoQ5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CE47886F;
	Sat, 28 Feb 2026 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292196; cv=none; b=S1T2m/Kq9Ag4td3+mCPvFrIl6NfBFpU+oOmojRe+AXqDdQEmVUscixdSBPWTsARxmYQ9wqeLwZK41uJ7A3E+XMJxDd8Pao6mJWg5p9rdzZbCmveox+ZCVGUVR9q2zcQHjp9oZNkz/+f4nK+Gc5/C6Y7DfGxBa6JszIBc4AJf5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292196; c=relaxed/simple;
	bh=27G9CaD5VzPScTm1yyVmEAsqi6Ii4PfqkqV3NlV/OCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/aIkdt3tk//JtX9JfWD671YeECpGQG4F1mfnpwPH30EC1rV01O1aq0YYjswd6ePAs0jl0gb4aFj6kRKxgoAQTYyl/9LeK5VpcNds0kfYMhERswcRJsGbzJyvPpPuSX8+cTFlTi+DVG9TmtJ3q2RxjoyguZfpixon0/qa9S/X4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqmlCoQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A2BC116D0;
	Sat, 28 Feb 2026 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772292196;
	bh=27G9CaD5VzPScTm1yyVmEAsqi6Ii4PfqkqV3NlV/OCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tqmlCoQ5abpyj5/aTeYcag5HRexRcZEpX1nWMddMyGBIWkJeOSShfMhu4qI5sPtuw
	 fHCjAt2zszFs/H9KUAzYhPoB1QBA8+SrPayRW17NNDEM5QF+mkwODUvkf3/HCJ7od4
	 va7xO5FcWreqMyj+iQlAzd0RLa/jB6Ql9G+7pyTq1qa4qP9lTyhaUcBRK/38j7tCKl
	 bkqsYbdVrJI1sJrH/5vS5JaaNscj8Oq1K1zM/OlXsJ7EBTApandS+Jucc0/R32yqWh
	 52ryC1xtyuC3EnHUnfQ9aZtwJ4lXMLkZ0m6l5BE4vevm0TzGCFvrk4SmuFZxUiXIcI
	 IKNYdDG6d0K9Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <benato.denis96@gmail.com>
Subject:
 [PATCH v1 2/2] platform/x86: eeepc-laptop: Convert ACPI driver to a platform
 one
Date: Sat, 28 Feb 2026 16:22:54 +0100
Message-ID: <3329436.5fSG56mABF@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <7916328.EvYhyI6sBW@rafael.j.wysocki>
References: <7916328.EvYhyI6sBW@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21257-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,ljones.dev];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: C3A9E1C3E1F
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the EEEPC laptop ACPI driver to a platform
one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c | 32 +++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 626a99a71fce..02a71095920e 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1361,8 +1361,9 @@ static void eeepc_enable_camera(struct eeepc_laptop *eeepc)
 
 static bool eeepc_device_present;
 
-static int eeepc_acpi_add(struct acpi_device *device)
+static int eeepc_acpi_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct eeepc_laptop *eeepc;
 	int result;
 
@@ -1373,9 +1374,10 @@ static int eeepc_acpi_add(struct acpi_device *device)
 	eeepc->handle = device->handle;
 	strscpy(acpi_device_name(device), EEEPC_ACPI_DEVICE_NAME);
 	strscpy(acpi_device_class(device), EEEPC_ACPI_CLASS);
-	device->driver_data = eeepc;
 	eeepc->device = device;
 
+	platform_set_drvdata(pdev, eeepc);
+
 	eeepc->hotplug_disabled = hotplug_disabled;
 
 	eeepc_dmi_check(eeepc);
@@ -1448,11 +1450,12 @@ static int eeepc_acpi_add(struct acpi_device *device)
 	return result;
 }
 
-static void eeepc_acpi_remove(struct acpi_device *device)
+static void eeepc_acpi_remove(struct platform_device *pdev)
 {
-	struct eeepc_laptop *eeepc = acpi_driver_data(device);
+	struct eeepc_laptop *eeepc = platform_get_drvdata(pdev);
 
-	acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY, eeepc_acpi_notify);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_ALL_NOTIFY, eeepc_acpi_notify);
 	eeepc_backlight_exit(eeepc);
 	eeepc_rfkill_exit(eeepc);
 	eeepc_input_exit(eeepc);
@@ -1469,13 +1472,12 @@ static const struct acpi_device_id eeepc_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, eeepc_device_ids);
 
-static struct acpi_driver eeepc_acpi_driver = {
-	.name = EEEPC_LAPTOP_NAME,
-	.class = EEEPC_ACPI_CLASS,
-	.ids = eeepc_device_ids,
-	.ops = {
-		.add = eeepc_acpi_add,
-		.remove = eeepc_acpi_remove,
+static struct platform_driver eeepc_acpi_driver = {
+	.probe = eeepc_acpi_probe,
+	.remove = eeepc_acpi_remove,
+	.driver = {
+		.name = EEEPC_LAPTOP_NAME,
+		.acpi_match_table = eeepc_device_ids,
 	},
 };
 
@@ -1488,7 +1490,7 @@ static int __init eeepc_laptop_init(void)
 	if (result < 0)
 		return result;
 
-	result = acpi_bus_register_driver(&eeepc_acpi_driver);
+	result = platform_driver_register(&eeepc_acpi_driver);
 	if (result < 0)
 		goto fail_acpi_driver;
 
@@ -1500,7 +1502,7 @@ static int __init eeepc_laptop_init(void)
 	return 0;
 
 fail_no_device:
-	acpi_bus_unregister_driver(&eeepc_acpi_driver);
+	platform_driver_unregister(&eeepc_acpi_driver);
 fail_acpi_driver:
 	platform_driver_unregister(&platform_driver);
 	return result;
@@ -1508,7 +1510,7 @@ static int __init eeepc_laptop_init(void)
 
 static void __exit eeepc_laptop_exit(void)
 {
-	acpi_bus_unregister_driver(&eeepc_acpi_driver);
+	platform_driver_unregister(&eeepc_acpi_driver);
 	platform_driver_unregister(&platform_driver);
 }
 
-- 
2.51.0





