Return-Path: <linux-acpi+bounces-3875-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1AC860200
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 19:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EC31F293EF
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BA813793A;
	Thu, 22 Feb 2024 18:52:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC49137935
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627976; cv=none; b=Vd0RG9TmsP/SKQkPHTIlWPWpC7XKq5XsMNU51i/F+p5MkD8+h5zE+A9X65KriE91ZZH08wmxCcaLPDZhb2RP2kya2UPRBGaySaw5ue77CxD3AxqmFXONqGTpLThjCjmDnG2NBqdrg+n05A+iCBEFYaokpI2GIKlV2r6ileV/4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627976; c=relaxed/simple;
	bh=kbRu6kiuAFSJGLp4ReWSVVO3wGX4hp7Hs+F7Mr1LU+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIXjIhj41N75Fzl8VclxH9mFShZNkcnDpglc3uI3IT+fQ19cp3RUzwb6+nViL/ORYNRVcDk5i/1ZIwxG+2Tc5XBtfnekQN6Y91OcCNSAUuki8u3vNxewxgjC95rkW1tQ7NaxVI9sLprkReXk4QVzZLF+dDI09shyBHgAFuUk+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBb-0003Oq-Dp; Thu, 22 Feb 2024 19:52:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBb-002HYv-0u; Thu, 22 Feb 2024 19:52:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBa-009dAZ-33;
	Thu, 22 Feb 2024 19:52:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 5/7] ACPI: fan: Convert to platform remove callback returning void
Date: Thu, 22 Feb 2024 19:52:37 +0100
Message-ID:  <6d0f053791a30817a5c41d561f955abbed1a3ea5.1708627599.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708627599.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708627599.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=kbRu6kiuAFSJGLp4ReWSVVO3wGX4hp7Hs+F7Mr1LU+4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl15f4DsGFYqS3bMZwts/ySguVFfF8mAqMPCbfT 9silfL+YD2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdeX+AAKCRCPgPtYfRL+ TqpZB/4qLFWL4idjGu0OqWvBO5D92KW0TQr5ME2blUaahUFyii2MwsJKXlsbpk8HPH0Lzs9T7Te X2Eboam5Eac7nz0G1AwWoIpQmjM+YF4KO++YbGSl6oO0KbksUh/JnrbeoK7jtw8bbzBxDoyI4PW 46REin5DSu3eERVx3R2MMV5O5QmQToypZoXc8bsgT2MAoJuHbiIRDM7B5tFjhdTf8dUEiw3BIhF JTMkzirBhfkxCvqnZW/HtT92A1NGv5/CGg2VwZ3BfiCeE8N6xw2gDoJfS7g2nVTAkHWIisQq8jS p2QdKG5hEz8U9gPwqphqZDiInRTeWhbB+Hv7Rw9cBgThlqmI
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/acpi/fan_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 9dccbae9e8ea..ff72e4ef8738 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -387,7 +387,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	return result;
 }
 
-static int acpi_fan_remove(struct platform_device *pdev)
+static void acpi_fan_remove(struct platform_device *pdev)
 {
 	struct acpi_fan *fan = platform_get_drvdata(pdev);
 
@@ -399,8 +399,6 @@ static int acpi_fan_remove(struct platform_device *pdev)
 	sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
 	sysfs_remove_link(&fan->cdev->device.kobj, "device");
 	thermal_cooling_device_unregister(fan->cdev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -446,7 +444,7 @@ static const struct dev_pm_ops acpi_fan_pm = {
 
 static struct platform_driver acpi_fan_driver = {
 	.probe = acpi_fan_probe,
-	.remove = acpi_fan_remove,
+	.remove_new = acpi_fan_remove,
 	.driver = {
 		.name = "acpi-fan",
 		.acpi_match_table = fan_device_ids,
-- 
2.43.0


