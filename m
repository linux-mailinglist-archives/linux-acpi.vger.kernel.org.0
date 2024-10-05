Return-Path: <linux-acpi+bounces-8567-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060099915BD
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 12:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04231F236A7
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862FD1494AC;
	Sat,  5 Oct 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WQyDcrB8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3E145B10;
	Sat,  5 Oct 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122730; cv=none; b=dYhO0VVyLQUXcnt0c08CMZ9b04d4HFwlE0kcNnSNfinAajCW+kJzVy7ZxMF3Pemj5O1ge7B+Pmp/LW5n2YkLKvrUv4jlNQaC5xL4RxpM/nCvAYkCwcjBS5MO94eyBOkSehVmeNMYhWYaasAgaB/hNwYTbnDCfkMzOcij1LD2ppM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122730; c=relaxed/simple;
	bh=r6VqPKJndOSTJfo57apH3Pg1CyWBmiP5JsMt4rLFKFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VVhaS0OYZUc0tW6muRdXMj22WScPThdJib+zl2nHw6HTemMYbYM2Wm0GbmXWAfEYSh6JWo4J8M+fyzVWz0923L+XejwWx/xSGEbu9r8HVH7KWfB57U8cBTuWu5+n6DHWDm6lDzDhLedJROtO7/5SXNeeBv4f4f3xihSxf7rQj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WQyDcrB8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122726;
	bh=r6VqPKJndOSTJfo57apH3Pg1CyWBmiP5JsMt4rLFKFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WQyDcrB8RLAqjTGnlBsySLN+Egn0GPkwyi+XgeITucgfHmA6u+odPPBKtYZq2EOA4
	 KV4+4jPfzuKwaofux/k+Zn6qPiJHXMCHn9LJRF1KG8vN+BlVVnY3xRNqQKwZY2axkz
	 Yj3A6lYKUHFV3Eo/1wabvvc2zaqXcv+Nr7TQGB4g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:05:04 +0200
Subject: [PATCH 2/8] ACPI: battery: Register power supply with
 power_supply_register()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-no-wakeup-source-v1-2-1d62bf9bcb1d@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122726; l=1138;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=r6VqPKJndOSTJfo57apH3Pg1CyWBmiP5JsMt4rLFKFU=;
 b=J59RzEPdQuB35y2GIKegik92KvMQTF53sRsbhC0YelLPfOGPNUtJ15nzYc4xjr5xAFnRX2a/7
 K+wF8HXrdhjAEIuaR+Yw/jp49NNtmrRE9ZRRF1AYwlcBJkgZR4/1oXm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

power_supply_register_no_ws() is going to be removed.
Switch to the general registration API.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 65fa3444367a13ac83644444076a11f08152c382..9a3a475f8ad334bb365e6a0273084034b8baa3bd 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -853,6 +853,7 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 	struct power_supply_config psy_cfg = {
 		.drv_data = battery,
 		.attr_grp = acpi_battery_groups,
+		.no_wakeup_source = true,
 	};
 	bool full_cap_broken = false;
 
@@ -888,7 +889,7 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 	battery->bat_desc.type = POWER_SUPPLY_TYPE_BATTERY;
 	battery->bat_desc.get_property = acpi_battery_get_property;
 
-	battery->bat = power_supply_register_no_ws(&battery->device->dev,
+	battery->bat = power_supply_register(&battery->device->dev,
 				&battery->bat_desc, &psy_cfg);
 
 	if (IS_ERR(battery->bat)) {

-- 
2.46.2


