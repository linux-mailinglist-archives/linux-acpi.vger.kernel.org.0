Return-Path: <linux-acpi+bounces-21440-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II+vIxHeqWm4GgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21440-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 20:48:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9678D217BDE
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 20:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5726300B9CA
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434AB3A7F4F;
	Thu,  5 Mar 2026 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNta+q2z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203241FBCA7;
	Thu,  5 Mar 2026 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740104; cv=none; b=C2ikiNMD9m+qBs8n6WsKsP/s3Mi3JDNoWxImn1xv5GShepkbSNh2TfLQuC5/yv5sDVpNcheGHggKBKMMOXMMLuVFryweuaIoM55saPbEu/+24hiy58v1XI8HYeqVTgyqBA50q5ItszOoNmaXMCRkjbAzVhVfa5lw1nogawrzSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740104; c=relaxed/simple;
	bh=ArBEjEEehMlFNLpth2XtCfGINxTQbnR6YRcCNjwC3KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlsG0mAZmLGysm6s6gUjRhszSTSFZNFG3x6M+02s4CIcfJ3hjGirO3MGtGoExCgc9LiZDvGwkBSXefwViqMzpfMtTzxsHI4ymNCkKRgpKomJ1E4YMasYW4rMqAurdqtEQBoJw6x+bw9Nm3JtvMQwu5RpTdbbZPP4L7UXniLYgiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNta+q2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F05C19422;
	Thu,  5 Mar 2026 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772740103;
	bh=ArBEjEEehMlFNLpth2XtCfGINxTQbnR6YRcCNjwC3KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TNta+q2zL8jzsX8hPgYBS3VLfKhWRwpp+tQzdsdLXftUZdiLZjWQNsAb1R6v9TufA
	 zyDo8mRwL8rQXEeGaIhlPW+clySTAnpJVUSbD8ns95eaFmDC1TEQyVrUJULqEKQXXI
	 pfBxaR2gDZcmCeJM2lmFnEBGwB95QEVBtvnYoa6VeyWebb/FfCsnCI+jLVeqtw8YX+
	 4QcSWerm5fwltz3P+m+ovZjrgtdQy1rPuTVz5336Xm5QR4IiR7b+2x1dtxawnBUwlb
	 CB4margG6aPMMwmZUBAY3ekc9hgbmuG9t07Fl75HNLOp66a3p8iI6IpTjftty4+Szy
	 9FzjsSfwYpurA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject:
 [PATCH v2 1/6] platform/chrome: Convert ChromeOS privacy-screen driver to
 platform
Date: Thu, 05 Mar 2026 20:37:54 +0100
Message-ID: <1963835.tdWV9SEqCh@rafael.j.wysocki>
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
X-Rspamd-Queue-Id: 9678D217BDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21440-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
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

v1 -> v2: No changes

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





