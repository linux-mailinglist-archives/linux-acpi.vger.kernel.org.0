Return-Path: <linux-acpi+bounces-3872-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAEC8601FE
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 19:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033371F290E3
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AF113BAC2;
	Thu, 22 Feb 2024 18:52:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D6137936
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627975; cv=none; b=jx1iQf2tlvDElbH2QdidKLxvCSJzQ4sQNMEn6ndA7GyGDraTIYynT0dcsMid7nBVX4j6UIgBDqgYpvGuvgzmq4sTE1w0DTq6pruWWwl4ey9IwMBN1ZccAle6rJFR9gN5pTRGxQwCVSjCM4qErBA0Sc3uQsAUiFLcyJNJC1yN+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627975; c=relaxed/simple;
	bh=zkXscEoH0Q82iZztdZMS8EwIjD1KMwTzAjbBuxTWu1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1VaVcuovniHPLr9//ELqrBsb3DM/URs+onXNTVoo8iDxvJGGXstXCOWTzlIqcOPZ9PCLPGf4QgIpd5SC8it0GQghZJGuDIGW3cVzVsHX2Xf2RTjuWBZLp0N9xZkutpuEkrZ21RcLkTlykVQXHILULigbY7VBwlrKcKrbcEh6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBb-0003Os-Kz; Thu, 22 Feb 2024 19:52:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBb-002HYz-7A; Thu, 22 Feb 2024 19:52:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBb-009dAd-0P;
	Thu, 22 Feb 2024 19:52:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 6/7] ACPI: pfr_telemetry: Convert to platform remove callback returning void
Date: Thu, 22 Feb 2024 19:52:38 +0100
Message-ID:  <50355bb24c6a5f9c6cc3b0be0182926813795726.1708627599.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=zkXscEoH0Q82iZztdZMS8EwIjD1KMwTzAjbBuxTWu1U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl15f5D3JIAaLxZE1xUlOoOINlgYkh5retjxv2q MbVWDUBVC+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdeX+QAKCRCPgPtYfRL+ TsZZB/4gukvJHRUninNjy43DAbXJwRGZ2iH9N/kzfp7+kdOv0zr6LFDEq+OQgRAj0lpz5GeG7MI qC8bTILyOqbcrpYow0LMMS88cKwOC9rmH9noj99jLacFSkKkMhiMjFVdNH4XQeLuFXX3XW5EJGU /5/sdiqlpsnknC8InYnm+cPoZttZXXB6/FsZ8QCzi6GoZfs2DXVYNofWckjpqTseoKTx+gskJnt LEGsLkmO26NAkmOQNM8PSk/g8ZeuKUbhJ/WOFU7pv5yfj26PmU52O3dAxdDTAiysaRNycyWEi2i Ae/lbDZ3grKl8skemXhedu2cyfy7v4V2u7dCzbXNmw2LT1fE
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
 drivers/acpi/pfr_telemetry.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
index 843f678ade0c..998264a7333d 100644
--- a/drivers/acpi/pfr_telemetry.c
+++ b/drivers/acpi/pfr_telemetry.c
@@ -347,13 +347,11 @@ static const struct file_operations acpi_pfrt_log_fops = {
 	.llseek		= noop_llseek,
 };
 
-static int acpi_pfrt_log_remove(struct platform_device *pdev)
+static void acpi_pfrt_log_remove(struct platform_device *pdev)
 {
 	struct pfrt_log_device *pfrt_log_dev = platform_get_drvdata(pdev);
 
 	misc_deregister(&pfrt_log_dev->miscdev);
-
-	return 0;
 }
 
 static void pfrt_log_put_idx(void *data)
@@ -427,7 +425,7 @@ static struct platform_driver acpi_pfrt_log_driver = {
 		.acpi_match_table = acpi_pfrt_log_ids,
 	},
 	.probe = acpi_pfrt_log_probe,
-	.remove = acpi_pfrt_log_remove,
+	.remove_new = acpi_pfrt_log_remove,
 };
 module_platform_driver(acpi_pfrt_log_driver);
 
-- 
2.43.0


