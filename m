Return-Path: <linux-acpi+bounces-3873-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BD78601FD
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 19:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E851C25E00
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06E1137936;
	Thu, 22 Feb 2024 18:52:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055E137939
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627975; cv=none; b=YZ2rJibJVXT5/1kl484uOeaNzwEN9mGOUuoM6p4acEIasDo7yfFJhHdSiPaq5VO6hASqcRo3g2wVt5sQVreeYogsXwjQXBipqkMzBRYy6e7jTTcJE5Ar6bMDzxOHpCFQKWww3YkFiRML/SSUKR6OO/RmbEssuTK6pBIfnwZGu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627975; c=relaxed/simple;
	bh=iAty85YzmBCgpuoI4cy8fKArgv5cR+MKTyWvQ6yRLE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9IlzXgsKYIuJx+p215GpIvoyLlK5VLr4Rrx37P29fMvkheXXOtmCpRslutthqs3JXz1xMugtr9OK0OiUQlcNG87pHSs6svkFdGJuhKNcI1sb7e2yanZpKhEZgO5bd+s2vhNwpsHWCXNl16yJRgiMFIM1iobOaP2D7u8CEtHvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBa-0003OW-Ti; Thu, 22 Feb 2024 19:52:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBa-002HYn-H0; Thu, 22 Feb 2024 19:52:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBa-009dAR-1R;
	Thu, 22 Feb 2024 19:52:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 3/7] ACPI: DPTF: Convert to platform remove callback returning void
Date: Thu, 22 Feb 2024 19:52:35 +0100
Message-ID:  <f5b571224ab49acf42ac2f8264194970ae824d89.1708627599.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2904; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=iAty85YzmBCgpuoI4cy8fKArgv5cR+MKTyWvQ6yRLE4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl15f1101qH7LGpki/dgEN/6L4ozhp3WL0xuGf5 kpU+i/KrW6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdeX9QAKCRCPgPtYfRL+ TqjFB/9R5hPf4si3ygdPou2rbo+9XvhLG5fBtjj0fpA5/x8Y/Yq5f1wiWxMJpDLecKjeJQ5IJRf 1Of1IWofLu8o29tZzjO873qBD5KR40Q21cikh4wWPpwb7lR7QcsRdihBJsnmRPOzrC3T7gySLaZ iP9T53Axz3aXi9dkJb7fnGy2gRKNVD2li0r4lP8g/eYkmYRAbAm7fj9JwyFPlsn6647wGUaLTU6 vILdnBwj48pmuUrNG3BgXZQFT1Y9A2jkicT/CYKMCp3PZzBGmCddVhpZJbPHYvuwZXyaW9tRPEs c2Fqe9SbRP/QcApnJ3ExF6ALnSLaJlUCySFkukerV1Tx3E9g
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

Trivially convert these two drivers from always returning zero in the
remove callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/acpi/dptf/dptf_pch_fivr.c | 6 ++----
 drivers/acpi/dptf/dptf_power.c    | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index 4919e7abe93f..654aaa53c67f 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -141,11 +141,9 @@ static int pch_fivr_add(struct platform_device *pdev)
 	return 0;
 }
 
-static int pch_fivr_remove(struct platform_device *pdev)
+static void pch_fivr_remove(struct platform_device *pdev)
 {
 	sysfs_remove_group(&pdev->dev.kobj, &pch_fivr_attribute_group);
-
-	return 0;
 }
 
 static const struct acpi_device_id pch_fivr_device_ids[] = {
@@ -159,7 +157,7 @@ MODULE_DEVICE_TABLE(acpi, pch_fivr_device_ids);
 
 static struct platform_driver pch_fivr_driver = {
 	.probe = pch_fivr_add,
-	.remove = pch_fivr_remove,
+	.remove_new = pch_fivr_remove,
 	.driver = {
 		.name = "dptf_pch_fivr",
 		.acpi_match_table = pch_fivr_device_ids,
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index 86561eda939f..b8187babbbbb 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -209,7 +209,7 @@ static int dptf_power_add(struct platform_device *pdev)
 	return 0;
 }
 
-static int dptf_power_remove(struct platform_device *pdev)
+static void dptf_power_remove(struct platform_device *pdev)
 {
 	struct acpi_device *acpi_dev = platform_get_drvdata(pdev);
 
@@ -221,8 +221,6 @@ static int dptf_power_remove(struct platform_device *pdev)
 		sysfs_remove_group(&pdev->dev.kobj, &dptf_battery_attribute_group);
 	else
 		sysfs_remove_group(&pdev->dev.kobj, &dptf_power_attribute_group);
-
-	return 0;
 }
 
 static const struct acpi_device_id int3407_device_ids[] = {
@@ -242,7 +240,7 @@ MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
 
 static struct platform_driver dptf_power_driver = {
 	.probe = dptf_power_add,
-	.remove = dptf_power_remove,
+	.remove_new = dptf_power_remove,
 	.driver = {
 		.name = "dptf_power",
 		.acpi_match_table = int3407_device_ids,
-- 
2.43.0


