Return-Path: <linux-acpi+bounces-8566-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CD89915BA
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 12:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F8E1C21B29
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E90148307;
	Sat,  5 Oct 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NHfnLLUb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0513D276;
	Sat,  5 Oct 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122730; cv=none; b=pUA3bsXeZXb5LBCw5LQINSYdmLvVIjYifKRj09BGHZbpAnjPb/ER6GrEBJZpjkh/2nzgK4mKZ6PZAAz/lNiAHRyHdtQ1f59J9WHULi5WGAMhBT5D/QN0WJgBokcnC3Cvr8dj7zXjh6WNTqgMyYFLhKC/kVHj4HRzcpHBiRIyKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122730; c=relaxed/simple;
	bh=WQKSkjSktZCriiwkdWIUgiePB+EnguIBlEAzjDlXbT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BUs8kCqI/ZOnWbEFOdBu12dF/lqPcPyEqNsisUK44PCaM/roPiYOqN9x6euqCRd0LJrpzLjiIIBV+nFurquo8d1/Z3jUtR/ryWqc2EObKCjy8JbcielQ9KilHT0rp7fWxDqRFBS7gdbd9uO2KmEUc83ydqUf7+ooM1preM2JHLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NHfnLLUb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122726;
	bh=WQKSkjSktZCriiwkdWIUgiePB+EnguIBlEAzjDlXbT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NHfnLLUbldI/L+kjukmJjkdP/ksheXaJsmwm0+R7zyiiftDHfCQH4kZqPeGKRxCLs
	 1AMSBIy/5PbmfOBsl3dCKHjGT5zY+LphyrmNMRtfxHyTI/cudjqtiZDbBvdJ0WIn9a
	 +7amOUZFxqm8aHObS6IS2MyiGDQFl8fIWmcpR+HY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:05:05 +0200
Subject: [PATCH 3/8] power: supply: acer_a500_battery: register power
 supply with devm_power_supply_register()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-no-wakeup-source-v1-3-1d62bf9bcb1d@weissschuh.net>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, chrome-platform@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122726; l=1231;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WQKSkjSktZCriiwkdWIUgiePB+EnguIBlEAzjDlXbT8=;
 b=kJ4kyvm3rSkSK9d7BH2dX6xc6AmzbCJi+3MyyQvRFk32eAI889qmopc+SG6KbmeFgfZDBI3UT
 auXgsi7YK6XAIZl+9+aizcn6z38bUCsYnnT6CeSaRqIWJX1fUNhKgZi
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

devm_power_supply_register_no_ws() is going to be removed.
Switch to the general registration API.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/acer_a500_battery.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/acer_a500_battery.c b/drivers/power/supply/acer_a500_battery.c
index ef5c419b1b7f20744b48e1648c38289f4d546cf9..58e7b2eac68f9745f5a2c48ba27951f65e681d2f 100644
--- a/drivers/power/supply/acer_a500_battery.c
+++ b/drivers/power/supply/acer_a500_battery.c
@@ -233,14 +233,15 @@ static int a500_battery_probe(struct platform_device *pdev)
 
 	psy_cfg.of_node = pdev->dev.parent->of_node;
 	psy_cfg.drv_data = bat;
+	psy_cfg.no_wakeup_source = true;
 
 	bat->regmap = dev_get_regmap(pdev->dev.parent, "KB930");
 	if (!bat->regmap)
 		return -EINVAL;
 
-	bat->psy = devm_power_supply_register_no_ws(&pdev->dev,
-						    &a500_battery_desc,
-						    &psy_cfg);
+	bat->psy = devm_power_supply_register(&pdev->dev,
+					      &a500_battery_desc,
+					      &psy_cfg);
 	if (IS_ERR(bat->psy))
 		return dev_err_probe(&pdev->dev, PTR_ERR(bat->psy),
 				     "failed to register battery\n");

-- 
2.46.2


