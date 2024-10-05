Return-Path: <linux-acpi+bounces-8572-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908A9915CC
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 12:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312CF28312C
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084E158A00;
	Sat,  5 Oct 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dt5jVMQd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C1156887;
	Sat,  5 Oct 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122734; cv=none; b=GLB2RuN9D0LWH8Nv2YzEAwBS3S1Jfz7679oH3pHQxnW8/KFJSR2S0/TPTrWCSU24VavU4KWfJ+zUziyqK/pqmW8YVb9HTjuK1YKlsmkaytHcK6R8qfNzsBxVWb5GmxqFFV7LoSKeCXgH/TBNJN+Zae8VVBKQWhRDxCzGyEy5ZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122734; c=relaxed/simple;
	bh=tuUyOoOOYHY8iDGRGbdi+WxIWgqrr87gAbpI7vZbnPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YbtPHgkd1Cz8eKhDi+rN4hu2tAYy47DK95OWrxJm4bdWe1iv3H/aGEgHIXuPB2xJfhQYHDOhCuaBDyToCAZnkygj+3YxcQz9ZDabraeEB4/w3kZuMjkF59qN2SM4iJ5H68Fvr55Vgo0c7DkYTPga06WS/FtDdxS5cfPwW87QV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dt5jVMQd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122727;
	bh=tuUyOoOOYHY8iDGRGbdi+WxIWgqrr87gAbpI7vZbnPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dt5jVMQdArecgtN2/XQ36wxQTDu6IWVFvNMeWjg3Ib1jTtBQ1I8PjFJxczXx5oY4u
	 1eEMJ+kKME8lAiUOqStjcjpRqdUIQv0h3I/5DiSaeVXr/qXaEI2xIV6nrokBw5DmCr
	 fKb14d2+kIsNY8G9RSs1TOYa9561u/vGI8Zy+5Mc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:05:08 +0200
Subject: [PATCH 6/8] power: supply: lenovo_yoga_c630_battery: register
 power supplies with power_supply_register()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-no-wakeup-source-v1-6-1d62bf9bcb1d@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122726; l=1943;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tuUyOoOOYHY8iDGRGbdi+WxIWgqrr87gAbpI7vZbnPM=;
 b=01TTVw+n3v/wVo5h+Gth0Wq5fG+yLZ4Lq9uaGnFlpGrgtEfNteDcNOfoVUe2HQpOSmuCFtcll
 cKmOZc2yKXcAteB5/nBeL1LTZd44RgvUmh10E/88U1CKFHowzVo/Er4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

{,devm_}power_supply_register_no_ws() are going to be removed.
Switch to the general registration API.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/lenovo_yoga_c630_battery.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/lenovo_yoga_c630_battery.c b/drivers/power/supply/lenovo_yoga_c630_battery.c
index f98f65e00831a5c463b133f7c074182c7db00e7e..7a6c8af9e8c24810abf2b6448fe061991738f87c 100644
--- a/drivers/power/supply/lenovo_yoga_c630_battery.c
+++ b/drivers/power/supply/lenovo_yoga_c630_battery.c
@@ -368,11 +368,12 @@ static int yoga_c630_psy_register_bat_psy(struct yoga_c630_psy *ecbat)
 
 	bat_cfg.drv_data = ecbat;
 	bat_cfg.fwnode = ecbat->fwnode;
-	ecbat->bat_psy = power_supply_register_no_ws(ecbat->dev,
-						     ecbat->unit_mA ?
-						     &yoga_c630_psy_bat_psy_desc_mA :
-						     &yoga_c630_psy_bat_psy_desc_mWh,
-						     &bat_cfg);
+	bat_cfg.no_wakeup_source = true;
+	ecbat->bat_psy = power_supply_register(ecbat->dev,
+					       ecbat->unit_mA ?
+					       &yoga_c630_psy_bat_psy_desc_mA :
+					       &yoga_c630_psy_bat_psy_desc_mWh,
+					       &bat_cfg);
 	if (IS_ERR(ecbat->bat_psy)) {
 		dev_err(ecbat->dev, "failed to register battery supply\n");
 		return PTR_ERR(ecbat->bat_psy);
@@ -442,7 +443,8 @@ static int yoga_c630_psy_probe(struct auxiliary_device *adev,
 	adp_cfg.fwnode = ecbat->fwnode;
 	adp_cfg.supplied_to = (char **)&yoga_c630_psy_bat_psy_desc_mA.name;
 	adp_cfg.num_supplicants = 1;
-	ecbat->adp_psy = devm_power_supply_register_no_ws(dev, &yoga_c630_psy_adpt_psy_desc, &adp_cfg);
+	adp_cfg.no_wakeup_source = true;
+	ecbat->adp_psy = devm_power_supply_register(dev, &yoga_c630_psy_adpt_psy_desc, &adp_cfg);
 	if (IS_ERR(ecbat->adp_psy)) {
 		dev_err(dev, "failed to register AC adapter supply\n");
 		return PTR_ERR(ecbat->adp_psy);

-- 
2.46.2


