Return-Path: <linux-acpi+bounces-3876-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 591F686020A
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 20:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A847BB2BA9D
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 18:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0384873F21;
	Thu, 22 Feb 2024 18:53:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92314B815
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627980; cv=none; b=SGRRtfiUqBRa44v4+72YNV5YGw8ju8p9xiaNawZOhc3x4GkrxC2nTtS/0DtiuQtX4v3Y0DKocVc9Kd1CR1v7/XeLhzdf8BPZC969f1l3Gafe6kCWOjvIpGN9L7IBUWA2muzT2odhkvjNrt9nmXEPmHtfmgT6YtzV+d7Bt4QR8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627980; c=relaxed/simple;
	bh=vIi5PB6mBSI3DnBlsSRa3+P9radJLrcOBAJNG7A7HK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAjv7VIA7mx+ACKQMRv9y4GmCXk8JyXiVFzp5ufiVpG4DBTSEJNA+KMxCHLvjeeVV36lpuQCTaxNF0M92HCgL0zEWp/6XA7o7zFUzMNpSam2mla1rkcv7EiYzu5GjL3DbuuHdocaJvQCc1GniswiArk6/dBONvS99en3XSWxTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBc-0003OS-P6; Thu, 22 Feb 2024 19:52:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBa-002HYk-9g; Thu, 22 Feb 2024 19:52:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBa-009dAN-0g;
	Thu, 22 Feb 2024 19:52:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 2/7] ACPI: AGDI: Convert to platform remove callback returning void
Date: Thu, 22 Feb 2024 19:52:34 +0100
Message-ID:  <c41853160b8947e865357f99171cfbdbb4b4804e.1708627599.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=vIi5PB6mBSI3DnBlsSRa3+P9radJLrcOBAJNG7A7HK4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl15f0xqptdAC5hEDdn2wh5R231nJb0dnMsCV/x 7U3KRN60tiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdeX9AAKCRCPgPtYfRL+ TqWCB/9l6oenxy72Kf0YfqU3sH9aj3b0y64880Oa0pka6LqJLF6E49dhvrc75HVPQPX7KXE7m+t 3Mun9/JJ9GOYHfHIvs17Y97ScydbCr9YUUMQR1N02r+Sa13SU2+kOtW72uJ6MKTuu1azYpJLTb/ L5YRI6eaHqsGLzyLHC391frafw6ZDEVnfc6qTHvrDddcFYNe6YYSIG6ZNlhNf11fg7+a0ekptdP SnVbt6IcfX7R0aA4BowRlR75HHM1xvqtlKR5/xnx5Jg/n+djv9yvp7+Wed3dqwH8lS1eJGfnetb GrWb1mNrKxWWJXOU8YBObh+d7IHOfpfmmHSZlL9YaFjpQbqc
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
 drivers/acpi/arm64/agdi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
index 8b3c7d42b41b..f5f21dd0d277 100644
--- a/drivers/acpi/arm64/agdi.c
+++ b/drivers/acpi/arm64/agdi.c
@@ -58,7 +58,7 @@ static int agdi_probe(struct platform_device *pdev)
 	return agdi_sdei_probe(pdev, adata);
 }
 
-static int agdi_remove(struct platform_device *pdev)
+static void agdi_remove(struct platform_device *pdev)
 {
 	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
 	int err, i;
@@ -67,7 +67,7 @@ static int agdi_remove(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev, "Failed to disable sdei-event #%d (%pe)\n",
 			adata->sdei_event, ERR_PTR(err));
-		return 0;
+		return;
 	}
 
 	for (i = 0; i < 3; i++) {
@@ -81,8 +81,6 @@ static int agdi_remove(struct platform_device *pdev)
 	if (err)
 		dev_err(&pdev->dev, "Failed to unregister sdei-event #%d (%pe)\n",
 			adata->sdei_event, ERR_PTR(err));
-
-	return 0;
 }
 
 static struct platform_driver agdi_driver = {
@@ -90,7 +88,7 @@ static struct platform_driver agdi_driver = {
 		.name = "agdi",
 	},
 	.probe = agdi_probe,
-	.remove = agdi_remove,
+	.remove_new = agdi_remove,
 };
 
 void __init acpi_agdi_init(void)
-- 
2.43.0


