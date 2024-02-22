Return-Path: <linux-acpi+bounces-3871-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0A78601FC
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 19:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4AF1C2685A
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 18:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D87B14B812;
	Thu, 22 Feb 2024 18:52:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05E14B808
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627974; cv=none; b=rgBwLXo/yq8eTkD7jJbO3k8sgbIY0CP2taZwVsrKnrrQvkXYWbayvKMqfavH+6TyOvFhArlb68/YgCBF1Im4ZoR/TdMho1c33TAR4qso3vkittHL/kR/Ch4dLV1S6xA2i/JgbsIBolxb4tT/31SL7JLYR1tOSCEp3EViJqDJxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627974; c=relaxed/simple;
	bh=tC6LGyOBG9pBQHYV+OieRt5sFVsUVitpWNTNIBsS0m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tgn8HtTxTf82S6HR7uJKMXuSg8UV7A1VYaHfA9OER7fJ8zY1/nRb4v1mCijJ18nCtZHgDX1ozEAfkggseI+YcECuLlDeFt8KY7b+YAh4Q8NHca1Tv8/iFIGbdr3LbRDh6OmWzoEiuJzwSqZdYVvbbfzdT4Ku2nRZEl6bfMa7WsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBb-0003OY-3d; Thu, 22 Feb 2024 19:52:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBa-002HYr-N9; Thu, 22 Feb 2024 19:52:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBa-009dAV-22;
	Thu, 22 Feb 2024 19:52:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 4/7] ACPI: GED: Convert to platform remove callback returning void
Date: Thu, 22 Feb 2024 19:52:36 +0100
Message-ID:  <e9d2d8fc577b98983df0c600bf04ef03e53aad6b.1708627599.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=tC6LGyOBG9pBQHYV+OieRt5sFVsUVitpWNTNIBsS0m8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtTr078/8923sUzX+/cOxSCWuKvdHDWpf+TSv16ZftTSn 8u36NOtTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmkubJ/k9VSPDPPrt4xYja MJbqnQrmd7ZEbjjDyxnUspJV53V/q3DK4+JMNSOb2KVcnLV7vnPF8Fdc0OP2M7fr3NfpfIlz6tk q0R/9JQvEWh8bFc3/zSOf4XOl5sOFii6vJUdkndKKd05/sepa1xk56fCZj9zOHFi5PEJyqs7yym /pLMU/+o9LJ10q22Id9ylQ76tnpx1z+vrkD5cKZ2jLz/MTPZzqX8dZVh4fmlt9IoRHtttkS0ter 4b4g6WttfmPuJlDIqb1q7/eNXP2Potb594drJSw0LggVdBYLJz4gOX9beHQ9KBdGwxEZtWI2G7l aG//s+vNbc5753sa5VkMfu/8PddFcZNN38az8guWGdoCAA==
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
 drivers/acpi/evged.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index fe6b6792c8bb..11778c93254b 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -173,10 +173,9 @@ static void ged_shutdown(struct platform_device *pdev)
 	}
 }
 
-static int ged_remove(struct platform_device *pdev)
+static void ged_remove(struct platform_device *pdev)
 {
 	ged_shutdown(pdev);
-	return 0;
 }
 
 static const struct acpi_device_id ged_acpi_ids[] = {
@@ -186,7 +185,7 @@ static const struct acpi_device_id ged_acpi_ids[] = {
 
 static struct platform_driver ged_driver = {
 	.probe = ged_probe,
-	.remove = ged_remove,
+	.remove_new = ged_remove,
 	.shutdown = ged_shutdown,
 	.driver = {
 		.name = MODULE_NAME,
-- 
2.43.0


