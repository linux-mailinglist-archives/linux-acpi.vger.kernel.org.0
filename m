Return-Path: <linux-acpi+bounces-9959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B149E5FB5
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D069028631D
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09C01CB51B;
	Thu,  5 Dec 2024 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MjJeSWjs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB81B87D0;
	Thu,  5 Dec 2024 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733431651; cv=none; b=CzFdGKbPuVXbWrtz6OVnHhS/11QYy8AlPk1gxaf0pr7S28qjN6o47EcAZkzEHxKjpFWp/MyEKaHOefWd5ACoxZGen92CAdHSrFSnKrmBV05idPowA/G8HXImUNcYShKrxShda9fotJfOFVANe+VLRQoImSqQUTNOIVChETDq89o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733431651; c=relaxed/simple;
	bh=Dnz8VEbwpgl6LUJweSEcqDxhkrrzgpj9dI0EqHUFdyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJ2vVmGzeu+iwyc5dBHyrv6Jr+/+EOXrsRPKBR23061wetxuXWtfto5he+Gg1kqKzmgGEKZwIhXhw+4UQddWH7Al+nu2vtew/+y+z36G8lPja6IJFPpH4vmu4jAXnOoPEcE1jtCg+bxcYdGi2EoCAkw7ySlddlwr8RtTlPv/w8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MjJeSWjs; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733431639;
	bh=Dnz8VEbwpgl6LUJweSEcqDxhkrrzgpj9dI0EqHUFdyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MjJeSWjsp35ZfbJtViZG7/UpRC75ebrAkTTtSX896Qzl52//tN+sYoctpgfkb+zol
	 IksIUhMuaufvYQmDUb6kSJ0AFLiNm8yYWn8EArifNYQvjHm26h7eUIHbg8dRcVKYyz
	 Fks+IEXwaMQlQG9G1+uOLua4DxtVNTlGTsA7poro=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 05 Dec 2024 21:46:35 +0100
Subject: [PATCH v5 1/4] ACPI: battery: Rename extensions to hook in
 messages
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-power-supply-extensions-v5-1-f0f996db4347@weissschuh.net>
References: <20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net>
In-Reply-To: <20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733431638; l=2452;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Dnz8VEbwpgl6LUJweSEcqDxhkrrzgpj9dI0EqHUFdyQ=;
 b=iQBWjUiU4xN/ovhrbPPILoVWmCfgac4Z1Yi8MSoBTKcha2/BdkoR+aXQ4LkJwKzWlqRnVBcV4
 xQojx8BbXY1C75zIygXMhqmWObAAQqIGduGEY2eBmCqJppn4r7oqhuN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This functionality is called "hook" everywhere in the code.
For consistency call it the same in the log messages.

The power supply subsystem is about to get its own extension
functionality. While the two are closely related and will be used
together, the current wording leaves room for misinterpretation.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
This patch can also be applied independently through the ACPI tree.
---
 drivers/acpi/battery.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 3d5342f8d7b3ae4e259131f9c7b7144a6206cfdb..6760330a8af55d51c82a0447623c2040ffdaab10 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -717,7 +717,7 @@ static void battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
 	}
 	list_del_init(&hook->list);
 
-	pr_info("extension unregistered: %s\n", hook->name);
+	pr_info("hook unregistered: %s\n", hook->name);
 }
 
 void battery_hook_unregister(struct acpi_battery_hook *hook)
@@ -751,18 +751,18 @@ void battery_hook_register(struct acpi_battery_hook *hook)
 		if (hook->add_battery(battery->bat, hook)) {
 			/*
 			 * If a add-battery returns non-zero,
-			 * the registration of the extension has failed,
+			 * the registration of the hook has failed,
 			 * and we will not add it to the list of loaded
 			 * hooks.
 			 */
-			pr_err("extension failed to load: %s", hook->name);
+			pr_err("hook failed to load: %s", hook->name);
 			battery_hook_unregister_unlocked(hook);
 			goto end;
 		}
 
 		power_supply_changed(battery->bat);
 	}
-	pr_info("new extension: %s\n", hook->name);
+	pr_info("new hook: %s\n", hook->name);
 end:
 	mutex_unlock(&hook_mutex);
 }
@@ -805,10 +805,10 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
 	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
 		if (hook_node->add_battery(battery->bat, hook_node)) {
 			/*
-			 * The notification of the extensions has failed, to
-			 * prevent further errors we will unload the extension.
+			 * The notification of the hook has failed, to
+			 * prevent further errors we will unload the hook.
 			 */
-			pr_err("error in extension, unloading: %s",
+			pr_err("error in hook, unloading: %s",
 					hook_node->name);
 			battery_hook_unregister_unlocked(hook_node);
 		}

-- 
2.47.1


