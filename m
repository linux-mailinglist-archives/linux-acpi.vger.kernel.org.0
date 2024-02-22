Return-Path: <linux-acpi+bounces-3870-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25CF8601FB
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 19:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C25C28D10F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C086C137938;
	Thu, 22 Feb 2024 18:52:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657A12D208
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627973; cv=none; b=Q1j8IQTA2kPLySWl2aWDceacH/WPLVCwjc8KqhKhQ8w6PN0ViiON/NUaR/IYvzcitpnrzsdjtpEPBd70DuKgjGilZ0QapSYCKm2B49vlYNnsjW20Tn0J8kwFRA+PcxxbPvz0wPNhs97i5lSdeGQanJa15XrpOhijxnpDwi5E0Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627973; c=relaxed/simple;
	bh=fAlGPZxX+yovfBFVUw/Aze9TIZyyaeDy+h6cvTvOjjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttTXWgC13o1k/aZG1Vo4j+j7SxXcYWGEC1FCYW08Gh1rjtUYuiiRRkaHPu7I1kZyIuQKwTSI/a7GzncqDtEC1BIlyZLDA/JMKJI4EkTkXrel771yBvkn2GbgXwYEGWf5te5DvLnN9VsL5igB/UvY8CbwibXuICCQQ5LrRpwXFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBa-0003OL-FH; Thu, 22 Feb 2024 19:52:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBa-002HYh-2T; Thu, 22 Feb 2024 19:52:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBZ-009dAJ-3D;
	Thu, 22 Feb 2024 19:52:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/7] ACPI: TAD: Convert to platform remove callback returning void
Date: Thu, 22 Feb 2024 19:52:33 +0100
Message-ID:  <15600c270b1684c1a24cdd6da5e110d8eac42266.1708627599.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=fAlGPZxX+yovfBFVUw/Aze9TIZyyaeDy+h6cvTvOjjU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl15fzr6RJWKCtJhntx9ZX55g3mVwX+MmNmQZAW yNo3VSqLUWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdeX8wAKCRCPgPtYfRL+ TtUzB/91pzcvfCZMPnvqG7OfRX4IRXk77i/LG0clQlJhcaX8u52zifqaEPE7m/rA+itKOtX1esV e4U0aXAMbC9ObrYDnFWbHRsrGL37XCp7WO/AV1YioUgQowhvGuY1xq2DS0r55SaOv4bEJjUxdJ6 k5TdQ06l7/9u9w4tglLEFFdPvOZkyVzNtUi6K4wbxfMCzN2STzRvzMfHYaVxnbMe+zfX2NxVbwf Zr4+muTkH/sLZEPT3GQeCJOGnPiJk7hHDrNMKnWoYCEblAg4ZARG7z1Q6Tjfmo7F1sQuh7bObT2 GoQPUJRWf43bNkh7JfVS2WpvlYWJ5gY55SYq1kRKCEoMldw9
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
 drivers/acpi/acpi_tad.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 33c3b16af556..1d670dbe4d1d 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -554,7 +554,7 @@ static int acpi_tad_disable_timer(struct device *dev, u32 timer_id)
 	return acpi_tad_wake_set(dev, "_STV", timer_id, ACPI_TAD_WAKE_DISABLED);
 }
 
-static int acpi_tad_remove(struct platform_device *pdev)
+static void acpi_tad_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	acpi_handle handle = ACPI_HANDLE(dev);
@@ -579,7 +579,6 @@ static int acpi_tad_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	acpi_remove_cmos_rtc_space_handler(handle);
-	return 0;
 }
 
 static int acpi_tad_probe(struct platform_device *pdev)
@@ -684,7 +683,7 @@ static struct platform_driver acpi_tad_driver = {
 		.acpi_match_table = acpi_tad_ids,
 	},
 	.probe = acpi_tad_probe,
-	.remove = acpi_tad_remove,
+	.remove_new = acpi_tad_remove,
 };
 MODULE_DEVICE_TABLE(acpi, acpi_tad_ids);
 
-- 
2.43.0


