Return-Path: <linux-acpi+bounces-8571-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2279915CA
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 12:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133711F234CE
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093D4158851;
	Sat,  5 Oct 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Kwqa7tMU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668B15687C;
	Sat,  5 Oct 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122733; cv=none; b=GX/u8Umi2yDJNswVxcWNlmlDLi65835dv+h9d5SRCkQIs4pS9iP8gUeS/ZqxtnlN1C4niIc2JvUMaUUKhbMvMYZyuIOxXsdlM/M4h44HYwtEg6SYVbmCQpN6BldJ/+FHizJp34gf7NQgMQ2Rk3SeQv86f5ATQCCaJUWFPey5KHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122733; c=relaxed/simple;
	bh=moxkro+CB+xOsJiW1z/X3lMPdX4iMCNAf6TleiEEwmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mtICFTM4IezLET3Tiy0vfQipHX7WZR+zxnK+3Bcd0LP2VARcBNyFdamQhPqOqW7hNWrMKygu7MkV1L/skRaFJ5bceNnNi2lSox1TwfNq+aqHqK6B9/Df09xWPwvues34wiPCEy2i5K3p81pPjRu0N5xA4JgDPl9VQi+r6FXzs+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Kwqa7tMU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122726;
	bh=moxkro+CB+xOsJiW1z/X3lMPdX4iMCNAf6TleiEEwmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kwqa7tMUb+H3aKu2W258Qs14tw0tw3cKhWG3YMEEsfndpclsWatGHqvhv2NNx7gAr
	 OcfEdX/wGbehTlPzF9QfgxiBQgdKh6JY6acezjlr+en1v34TNhUygSyTORttZ6XcaG
	 jMoDhzEPS/SeJYjVLlYJG4M6qTdr1Tf4Vcx+v8LI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:05:06 +0200
Subject: [PATCH 4/8] power: supply: bq27xxx_battery: register power supply
 with power_supply_register()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-no-wakeup-source-v1-4-1d62bf9bcb1d@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122726; l=1268;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=moxkro+CB+xOsJiW1z/X3lMPdX4iMCNAf6TleiEEwmk=;
 b=QRuIUev1efYRdNAvqBQ+zRFuEfyQr5o1ubmALwExgLuVPWNX8Xqf4YhFZSA04glfrEE6II1Wp
 w8Hre2VV+HuCM0NLXqoLHVlJepzsWhGqT1T8cMl0/M8sdYcuI78M89V
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

devm_power_supply_register_no_ws() is going to be removed.
Switch to the general registration API.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/bq27xxx_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 750fda543308c873f65ef3600546b086af68fafd..e47556ec3cfeadd6ce014559d90807b293d781d5 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2131,6 +2131,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	struct power_supply_config psy_cfg = {
 		.of_node = di->dev->of_node,
 		.drv_data = di,
+		.no_wakeup_source = true,
 	};
 	int ret;
 
@@ -2157,7 +2158,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	psy_desc->get_property = bq27xxx_battery_get_property;
 	psy_desc->external_power_changed = bq27xxx_external_power_changed;
 
-	di->bat = devm_power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
+	di->bat = devm_power_supply_register(di->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(di->bat))
 		return dev_err_probe(di->dev, PTR_ERR(di->bat),
 				     "failed to register battery\n");

-- 
2.46.2


