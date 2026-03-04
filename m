Return-Path: <linux-acpi+bounces-21351-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ChCCmF+qGmYvAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21351-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:48:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A202069E7
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 111A53026A78
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31FE3DA5A8;
	Wed,  4 Mar 2026 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUia4e3Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4AB3D6CA4;
	Wed,  4 Mar 2026 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650005; cv=none; b=ri8fz0OzKUW+KSrieJD46CmpaxbdudW4zEbtwXZ3rE9VfclwaeaY6m9KXHjeJtXQ+maO3VarRmmZxG41saUvvyBFr17wjV9WEmPRq8nZ8n4bKXYccgBnRgupYRd26IUNOgDFJtOzAGtGRiB1mRp5iKa7AJtpYTtuEgK8M3v1e0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650005; c=relaxed/simple;
	bh=pDKiwwoC293ukKLCEm2OubWvL1AdbWE0oxFNVRmKlOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDynX4DRGZETbSezGmIxSzWot9fhl8JO9wkXQ+s2syoQNyakXRw24w4XcWEtFNPLcaVbk9MrNc+SqzK2NZhEH41kwF6mSUhz7GCdJ0OKgyDDmexD1vPaArYhk5G41RinmSM3fTdv8Q+WqhDtUlWTsQfQQZMPbb7O6COl/l37sdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUia4e3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1239EC2BC9E;
	Wed,  4 Mar 2026 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772650005;
	bh=pDKiwwoC293ukKLCEm2OubWvL1AdbWE0oxFNVRmKlOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUia4e3ZhLUZ6fpTsmWjj6YBgNYBwH+NYXlosh4NF63raWGPxn3OUAHJMJMqvqOHO
	 075x6u/+5VNgAWMdsVofAlC0J6kfiAkIAAYNFNlI3TTJwOJJtSsXBlGo4bFtzNGjUU
	 tChpdLVi1gnfuEcpMrR16spCUrDfZQZd3rJ2GNJyLMtXoijhfMVUgo8cjo3qHVx69K
	 6LyaH8x+Ml5o7lyngYrJrIqesPTEvGCf5EgWUiPu5HLCW6XGNglbKvxPy+yp3SFKV5
	 qvCoLWKqvUnMSpRTxLnrWAhkJSbh6eqQHzaZx3RiyGFPc0O+KLWQgOGX0QDpszUT2N
	 bcPxjpcoDdplw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: chrome-platform@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject:
 [PATCH v1 1/6] platform/chrome: Convert ChromeOS privacy-screen driver to
 platform
Date: Wed, 04 Mar 2026 19:42:25 +0100
Message-ID: <3883856.MHq7AAxBmi@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2274474.Mh6RI2rZIc@rafael.j.wysocki>
References: <2274474.Mh6RI2rZIc@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C4A202069E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21351-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the ChromeOS privacy-screen ACPI driver
to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 .../platform/chrome/chromeos_privacy_screen.c | 41 ++++++++-----------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_privacy_screen.c b/drivers/platform/chrome/chromeos_privacy_screen.c
index bb74ddf9af4a..abc5d189a389 100644
--- a/drivers/platform/chrome/chromeos_privacy_screen.c
+++ b/drivers/platform/chrome/chromeos_privacy_screen.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 #include <drm/drm_privacy_screen_driver.h>
 
 /*
@@ -32,11 +33,10 @@ chromeos_privacy_screen_get_hw_state(struct drm_privacy_screen
 				     *drm_privacy_screen)
 {
 	union acpi_object *obj;
-	acpi_handle handle;
 	struct device *privacy_screen =
 		drm_privacy_screen_get_drvdata(drm_privacy_screen);
+	acpi_handle handle = ACPI_HANDLE(privacy_screen);
 
-	handle = acpi_device_handle(to_acpi_device(privacy_screen));
 	obj = acpi_evaluate_dsm(handle, &chromeos_privacy_screen_dsm_guid,
 				PRIV_SCRN_DSM_REVID,
 				PRIV_SCRN_DSM_FN_GET_STATUS, NULL);
@@ -65,11 +65,9 @@ chromeos_privacy_screen_set_sw_state(struct drm_privacy_screen
 				     enum drm_privacy_screen_status state)
 {
 	union acpi_object *obj = NULL;
-	acpi_handle handle;
 	struct device *privacy_screen =
 		drm_privacy_screen_get_drvdata(drm_privacy_screen);
-
-	handle = acpi_device_handle(to_acpi_device(privacy_screen));
+	acpi_handle handle = ACPI_HANDLE(privacy_screen);
 
 	if (state == PRIVACY_SCREEN_DISABLED) {
 		obj = acpi_evaluate_dsm(handle,
@@ -104,30 +102,28 @@ static const struct drm_privacy_screen_ops chromeos_privacy_screen_ops = {
 	.set_sw_state = chromeos_privacy_screen_set_sw_state,
 };
 
-static int chromeos_privacy_screen_add(struct acpi_device *adev)
+static int chromeos_privacy_screen_probe(struct platform_device *pdev)
 {
 	struct drm_privacy_screen *drm_privacy_screen =
-		drm_privacy_screen_register(&adev->dev,
+		drm_privacy_screen_register(&pdev->dev,
 					    &chromeos_privacy_screen_ops,
-					    &adev->dev);
+					    &pdev->dev);
 
 	if (IS_ERR(drm_privacy_screen)) {
-		dev_err(&adev->dev, "Error registering privacy-screen\n");
+		dev_err(&pdev->dev, "Error registering privacy-screen\n");
 		return PTR_ERR(drm_privacy_screen);
 	}
 
-	adev->driver_data = drm_privacy_screen;
-	dev_info(&adev->dev, "registered privacy-screen '%s'\n",
+	platform_set_drvdata(pdev, drm_privacy_screen);
+	dev_info(&pdev->dev, "registered privacy-screen '%s'\n",
 		 dev_name(&drm_privacy_screen->dev));
 
 	return 0;
 }
 
-static void chromeos_privacy_screen_remove(struct acpi_device *adev)
+static void chromeos_privacy_screen_remove(struct platform_device *pdev)
 {
-	struct drm_privacy_screen *drm_privacy_screen =	acpi_driver_data(adev);
-
-	drm_privacy_screen_unregister(drm_privacy_screen);
+	drm_privacy_screen_unregister(platform_get_drvdata(pdev));
 }
 
 static const struct acpi_device_id chromeos_privacy_screen_device_ids[] = {
@@ -136,17 +132,16 @@ static const struct acpi_device_id chromeos_privacy_screen_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, chromeos_privacy_screen_device_ids);
 
-static struct acpi_driver chromeos_privacy_screen_driver = {
-	.name = "chromeos_privacy_screen_driver",
-	.class = "ChromeOS",
-	.ids = chromeos_privacy_screen_device_ids,
-	.ops = {
-		.add = chromeos_privacy_screen_add,
-		.remove = chromeos_privacy_screen_remove,
+static struct platform_driver chromeos_privacy_screen_driver = {
+	.probe = chromeos_privacy_screen_probe,
+	.remove = chromeos_privacy_screen_remove,
+	.driver = {
+		.name = "chromeos_privacy_screen_driver",
+		.acpi_match_table = chromeos_privacy_screen_device_ids,
 	},
 };
 
-module_acpi_driver(chromeos_privacy_screen_driver);
+module_platform_driver(chromeos_privacy_screen_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("ChromeOS ACPI Privacy Screen driver");
 MODULE_AUTHOR("Rajat Jain <rajatja@google.com>");
-- 
2.51.0





