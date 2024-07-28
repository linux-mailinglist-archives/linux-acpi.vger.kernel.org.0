Return-Path: <linux-acpi+bounces-7098-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E33C93E24D
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 03:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C39B21FFE
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 01:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A48F18EFFF;
	Sun, 28 Jul 2024 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaOpf+UT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208118F2E8;
	Sun, 28 Jul 2024 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127802; cv=none; b=IgNXIRoR1NolAvATW3XnBx0twxYys882WFgyUChg25fuoDN+JDIaU6WV0jLEIFmbMWxoLWjM25GwHT0PpmFLbGffWxU2F6GPtnnfFhXB0Yj6qGMd1UoZ1eSTct2XAGJ0Ip7chWl3AQWQb1YxmmTXuhSQCw0SEYOfWFW74ELR61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127802; c=relaxed/simple;
	bh=vUYTzlOXeMvLYcNJVQmJYDrotdJYZlNa4+xHs1y6bB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hnpYcxrf+Twg7tH2R0YuQMteIg+Mb8sFS9Fpj39zv74Z6r3bQmAOzi4XP+k0rzJ6ncED+HU3DzIphROrSXL6hUcFVlV2PiViXgL26RXzjuDQQOuH7r2NT6OIVN6TEaWCq2avfeW5h4VxO9KY6K4KU/KpgxtwKcciypkb4ilAbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaOpf+UT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC7EC32781;
	Sun, 28 Jul 2024 00:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127802;
	bh=vUYTzlOXeMvLYcNJVQmJYDrotdJYZlNa4+xHs1y6bB0=;
	h=From:To:Cc:Subject:Date:From;
	b=FaOpf+UTqYJHdH+Lo3Dei7+7J/5VtYHVoOuQmh02+zuDWd8VobDahVlWVUN75hXTU
	 rJSqQhFEpGGv3Ikd3n56yKzXwkfWA/uodkE9cAPzEqEUUuvNw44snI0ZM42/m7aQnS
	 PAFsFVdggWNg4a0/YvPC8QpvrMN1OCp6eFD7c0MFPYph8JWzdIGYkDk8X+WVVjOdMy
	 Q6FYZjUUYweDAh6tGvlxpkq3vlyDhPT5qDIqu3f9slMGcx6q65BpBOBhEOgYJbl/KE
	 8+CM7/SccpQdjM26j6tu++Lx3MNfrx2nOAsJSEKMmadvGUEgkxehgJrYyp0qVwXZyr
	 b9h/IGqiItNJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 1/2] ACPI: battery: create alarm sysfs attribute atomically
Date: Sat, 27 Jul 2024 20:49:58 -0400
Message-ID: <20240728004959.1708194-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit a231eed10ed5a290129fda36ad7bcc263c53ff7d ]

Let the power supply core register the attribute.
This ensures that the attribute is created before the device is
announced to userspace, avoid a race condition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/battery.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 084f156bdfbc4..088740fdea355 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -667,12 +667,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 	return count;
 }
 
-static const struct device_attribute alarm_attr = {
+static struct device_attribute alarm_attr = {
 	.attr = {.name = "alarm", .mode = 0644},
 	.show = acpi_battery_alarm_show,
 	.store = acpi_battery_alarm_store,
 };
 
+static struct attribute *acpi_battery_attrs[] = {
+	&alarm_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(acpi_battery);
+
 /*
  * The Battery Hooking API
  *
@@ -809,7 +815,10 @@ static void __exit battery_hook_exit(void)
 
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
-	struct power_supply_config psy_cfg = { .drv_data = battery, };
+	struct power_supply_config psy_cfg = {
+		.drv_data = battery,
+		.attr_grp = acpi_battery_groups,
+	};
 	bool full_cap_broken = false;
 
 	if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
@@ -854,7 +863,7 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 		return result;
 	}
 	battery_hook_add_battery(battery);
-	return device_create_file(&battery->bat->dev, &alarm_attr);
+	return 0;
 }
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
@@ -865,7 +874,6 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 		return;
 	}
 	battery_hook_remove_battery(battery);
-	device_remove_file(&battery->bat->dev, &alarm_attr);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
 	mutex_unlock(&battery->sysfs_lock);
-- 
2.43.0


