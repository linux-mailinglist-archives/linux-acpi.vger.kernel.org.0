Return-Path: <linux-acpi+bounces-8570-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3FC9915C8
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 12:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147DE1C21426
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA121586F2;
	Sat,  5 Oct 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BVgqe0Kh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E3156880;
	Sat,  5 Oct 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122733; cv=none; b=f6Fgq5cWn1uXHzkwqoZZ+VNS1HnM6qqYlneOn9hLCaYVLApkd12B9OkXd0x6tVpcYCf4tnWGhNgKOkktjWYeASjucluUlXfzKfoleK/8uVU+QQ8/IjaoMJlWNfSN1y4zlTpK7soFGk6GFm5lnsizQYFLG+HxOP2MNPWx6hirN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122733; c=relaxed/simple;
	bh=3snWepe9T3lSQIhIsMzHnhIEWoE3d7gmIqXXaoMOHIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sH8sZt+1xi3SRvQFQIjC4tmjCX1tlzMYDA9wbESHH7pREG9KL37oj1k0vNBwnapj9cGMoD8hl/gwSgdHqJw5EG7UTXfcAWUihEFCVtCjDYIfuZ6DPo3YKnmp7LKbkJup5C8nYFvMEs79IcNyKB1cUGY/KaRgBwo1kULCbXXyZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BVgqe0Kh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122727;
	bh=3snWepe9T3lSQIhIsMzHnhIEWoE3d7gmIqXXaoMOHIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BVgqe0KhMmiPeizZjTssaawplS6rO+dMYTHMeJRyW5QX2STc/OvJBesdWia2vsnpJ
	 gBjtwV+L7+g3gKrW8IZJ5Us1ChmS1zbqQBhzHLRyJJf5mWrTLo1C/HXvGsqn1AYb10
	 c/x+cLLgGBJ8bw9LitAcgjbnudXMk1YbaI4fxa0k=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:05:09 +0200
Subject: [PATCH 7/8] power: supply: max77976_charger: register power supply
 with devm_power_supply_register()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-no-wakeup-source-v1-7-1d62bf9bcb1d@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122726; l=1188;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3snWepe9T3lSQIhIsMzHnhIEWoE3d7gmIqXXaoMOHIQ=;
 b=3UsHP+aMkWRD1r9zQMg7Af2LSY8LFcimqVICArhDMt7Esm+h5fI1iBx0vrkAM2Ck0VoEiFvpV
 sDO+rIQxEu0DlDtmK9jJqDhQNSdqJVmO0ioWVXIezvndn4hMi9J37pr
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

devm_power_supply_register_no_ws() is going to be removed.
Switch to the general registration API.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/max77976_charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supply/max77976_charger.c
index d7e520da768864f7f7e5177195ec0a16a51724f5..e6fe68cebc32b6fa39df71616ca293ce20098150 100644
--- a/drivers/power/supply/max77976_charger.c
+++ b/drivers/power/supply/max77976_charger.c
@@ -452,6 +452,7 @@ static int max77976_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, chg);
 	psy_cfg.drv_data = chg;
+	psy_cfg.no_wakeup_source = true;
 	chg->client = client;
 
 	chg->regmap = devm_regmap_init_i2c(client, &max77976_regmap_config);
@@ -475,7 +476,7 @@ static int max77976_probe(struct i2c_client *client)
 	if (err)
 		return err;
 
-	psy = devm_power_supply_register_no_ws(dev, &max77976_psy_desc, &psy_cfg);
+	psy = devm_power_supply_register(dev, &max77976_psy_desc, &psy_cfg);
 	if (IS_ERR(psy))
 		return dev_err_probe(dev, PTR_ERR(psy), "cannot register\n");
 

-- 
2.46.2


