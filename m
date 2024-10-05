Return-Path: <linux-acpi+bounces-8573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5766F9915D2
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 12:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899BB1C21407
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F67158DCA;
	Sat,  5 Oct 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="i86JFv2d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A85156676;
	Sat,  5 Oct 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122734; cv=none; b=TPqvzsqS2p1G/MhNutMYjmTBO2kr8J89CtDjruH/axQsdWO0+szGOEL4k99Td/GXgD+X08UfS96J19auja7jjfJ68HyRppcd7WmwXR8Vrw93JwirPpgecXKB0rDmZqTzeNTHkDt7WW3UdrFOdNOfSkKdaYsmI2FJKLj5P8eV9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122734; c=relaxed/simple;
	bh=YXJ4Fir9eqOqi0FqoCYgm/ICDLFYsW7/A4um6dWTZJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TFGRyYv5BHzH2mKpXKDcbwD+xFN+vhHEsXuyg/3yuVhu6VxX4wTZr5lgRn6Fpajt3zTB2rZeV2kH+mlfEYtDEFapL8x+c6QpaJzUz5j3RREHZwZVAzzQK1F2FqHE9EMzTYF8ee+HXZ2CO4JNkkcog7POSqWwg/13Rt2BWdJ/h80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=i86JFv2d; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122727;
	bh=YXJ4Fir9eqOqi0FqoCYgm/ICDLFYsW7/A4um6dWTZJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i86JFv2dtl8WLc/GYrYsC/nn7BuANhfkG/ee9pPJaP0qRWjr82/UD67taXHeuYy2C
	 a1/sbMGGJJrULHcpmsTMjVZZB5xlznKgXgKEq/tN9qulLcSdiSjhZ0kT77nmkf0qLl
	 /fP86hrlttKmlamPnyo9xkqwOXL6XzRHyVeO2QBY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:05:07 +0200
Subject: [PATCH 5/8] power: supply: cros_usbpd-charger: register power
 supply with devm_power_supply_register()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-no-wakeup-source-v1-5-1d62bf9bcb1d@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122726; l=1287;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YXJ4Fir9eqOqi0FqoCYgm/ICDLFYsW7/A4um6dWTZJ4=;
 b=zMABkNI/yH/mHTfFBL90ELge7YlPIZ79Fq2gURl8pwSUdznUygzgIu6i1GNlNbX6WWihS54dJ
 FB2MJCjrplWCgdd1/BKXLFWj45aBa6+0Vph+uuFUEB4cegtHallZcOX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

devm_power_supply_register_no_ws() is going to be removed.
Switch to the general registration API.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/cros_usbpd-charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index bed3e2e9bfea971142f10956ed499b1ac2d834dd..47d3f58aa15ceb792b3c3dc2468e770890d76b7e 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -618,6 +618,7 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 		psy_desc->external_power_changed =
 					cros_usbpd_charger_power_changed;
 		psy_cfg.drv_data = port;
+		psy_cfg.no_wakeup_source = true;
 
 		if (cros_usbpd_charger_port_is_dedicated(port)) {
 			sprintf(port->name, CHARGER_DEDICATED_DIR_NAME);
@@ -644,8 +645,7 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 
 		psy_desc->name = port->name;
 
-		psy = devm_power_supply_register_no_ws(dev, psy_desc,
-						       &psy_cfg);
+		psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
 		if (IS_ERR(psy)) {
 			dev_err(dev, "Failed to register power supply\n");
 			continue;

-- 
2.46.2


