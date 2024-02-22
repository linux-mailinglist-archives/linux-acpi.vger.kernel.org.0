Return-Path: <linux-acpi+bounces-3874-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AE38601FF
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 19:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5592A1C25DF4
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 18:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70A1EA95;
	Thu, 22 Feb 2024 18:52:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509E13793D
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627976; cv=none; b=mf0v0zYd9dHvEIVhwK5x2AIO+LmZphkx2MkTjeOJpw+CZPEiLgCe+/c8GLal/nqXCTBsmgLfo0l/U9o66ImGvEkzI1B60ve1m2fW62g30uksxQpfbYkQ6VQkATH3QPsVxEKYOAD3+Vf+epW+fgTzu5zZPVRgshvYAM6JR5Kz5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627976; c=relaxed/simple;
	bh=e/BnsPbUNcAHFTR9McwzEhuDJgjW1zHEVsVkDj6jMYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyO/JbSnFPAfOTjER6h1xoPQT6S6iMJBqHgCfuHHpV0wKRMmpBbYr66HHW9ITwjCLIg8enkbKxlTLN6j82Z04qXIythncXI0FeKYllnBN2ZsZCdqyFedvyE2oVi0Ze5Z1ZJb5fBGZUNm9Huu3DqRpBs5jjpNxcBhvRLXPqv0ddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBb-0003P7-Ua; Thu, 22 Feb 2024 19:52:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBb-002HZ3-HU; Thu, 22 Feb 2024 19:52:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBb-009dAh-1U;
	Thu, 22 Feb 2024 19:52:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 7/7] ACPI: pfr_update: Convert to platform remove callback returning void
Date: Thu, 22 Feb 2024 19:52:39 +0100
Message-ID:  <322bdb682c4bbcdbe14fef0689851466b631f752.1708627599.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=e/BnsPbUNcAHFTR9McwzEhuDJgjW1zHEVsVkDj6jMYI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl15f6FB00xcRSZGODhMUaoDneUf2wvkgDfVI72 ai7+yYZn5eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdeX+gAKCRCPgPtYfRL+ ThXuB/wP/WK+2qGfjwoyQWpHBO5KHg5iICW2S1ODbHBI8TJs8ooyS+4GdJy6K5Y2v2S/WMiUSc7 N3hsBlFJpOzmmpqD+sybf0OcrTYn+u8lczfJnH+FaM4pb2vxv/zAgoHM60624WMefeM1Sag6713 04B7uUEGEliFGs9JNNJWVTsDTgMjdM8Pkf90UpPX/pQQl0ph2x/wt1pwEw2Cg+CETTky5V6IJB8 UprPPncSAoS3AOMD5J2QtBs7JrAAfA0xoFhLeMvyWIsVbbIqMAuKQd35areCNt+iyJGbrKs77Uo eaqJmq/WAUEarxXSwna7sp1yH7x5mBJDsptvLA4+uQKh2DQF
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
 drivers/acpi/pfr_update.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 98267f163e2b..8b2910995fc1 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -489,13 +489,11 @@ static const struct file_operations acpi_pfru_fops = {
 	.llseek		= noop_llseek,
 };
 
-static int acpi_pfru_remove(struct platform_device *pdev)
+static void acpi_pfru_remove(struct platform_device *pdev)
 {
 	struct pfru_device *pfru_dev = platform_get_drvdata(pdev);
 
 	misc_deregister(&pfru_dev->miscdev);
-
-	return 0;
 }
 
 static void pfru_put_idx(void *data)
@@ -567,7 +565,7 @@ static struct platform_driver acpi_pfru_driver = {
 		.acpi_match_table = acpi_pfru_ids,
 	},
 	.probe = acpi_pfru_probe,
-	.remove = acpi_pfru_remove,
+	.remove_new = acpi_pfru_remove,
 };
 module_platform_driver(acpi_pfru_driver);
 
-- 
2.43.0


