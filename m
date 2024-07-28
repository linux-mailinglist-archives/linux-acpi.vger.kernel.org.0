Return-Path: <linux-acpi+bounces-7092-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F5F93E22A
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 03:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952B52820A2
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Jul 2024 01:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0A82B9C6;
	Sun, 28 Jul 2024 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDNhHBB5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295C2AF15;
	Sun, 28 Jul 2024 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127776; cv=none; b=qFv4bW8MiKCCYGj1VK4BRVzM69aYvDel+i86Kox0dMJR4kkDq2i6/Ai1MviaRG+8qmWerYxJ0La5mepoaIPclwUacNcIYru2t9Pf+gt4lVs13Skuh9rYsKKQGFkSstIwGrIhm8l5CcYq3QoG0P9kQ9Rqz/ST8xJssOeSw/HsE0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127776; c=relaxed/simple;
	bh=iwB9TqkerK+x/pRroDAAPD3wSFIQpoQPGTawX5l+5Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Aqcjs8L8ZG0WSN1cRC8kQMWCDmeZubwWn8O+8QCmY7ugAf2R7kBlQReu5YYZlcKW/on5fJwDXk3ALdaPEgE3LT+9XhSNK5353HEP9iDq66JUxKCA0l8l5ZTAlanJx9zh8s9ypeFAaN7r8oVWyWc3FW4GJ6aUbKy+gc0kuIMaKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDNhHBB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FBFC32781;
	Sun, 28 Jul 2024 00:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127776;
	bh=iwB9TqkerK+x/pRroDAAPD3wSFIQpoQPGTawX5l+5Dw=;
	h=From:To:Cc:Subject:Date:From;
	b=KDNhHBB5sISa6yEfu8BKYycb766yBn6dbh0/MSpqjZsrfwOBRbtpMfBTCLfmv8lie
	 O9nBYe5mJJC/1skqh/Skfgkh1gLmPbv8wDsYlouBDnVHLFSj0/Ssz4cO4KgWFG1aFW
	 5GV1Pr2BN49+wk5+D27Hs5IyyZj/suh6oLpTdKtf25Be6wPkeDx61uv6oG8VQGCzVL
	 lZtM4FIN3o2nCeLMo3h1LdSK60seZsXD9tPcKhgeEUlXTn8gPxIKJ7ZNL1fUQ6IedK
	 44oCpVk6OuCwGYiRnK7pzwQp1sLbdVi2lbUajfiqujzpzTf6Iws0xYW0jF/tYT3MsE
	 tU30TxLsue4Tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 1/9] ACPI: battery: create alarm sysfs attribute atomically
Date: Sat, 27 Jul 2024 20:49:21 -0400
Message-ID: <20240728004934.1706375-1-sashal@kernel.org>
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
X-stable-base: Linux 6.10.2
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
index b379401ff1c20..44ca989f16466 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -678,12 +678,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
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
@@ -823,7 +829,10 @@ static void __exit battery_hook_exit(void)
 
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
-	struct power_supply_config psy_cfg = { .drv_data = battery, };
+	struct power_supply_config psy_cfg = {
+		.drv_data = battery,
+		.attr_grp = acpi_battery_groups,
+	};
 	bool full_cap_broken = false;
 
 	if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
@@ -868,7 +877,7 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 		return result;
 	}
 	battery_hook_add_battery(battery);
-	return device_create_file(&battery->bat->dev, &alarm_attr);
+	return 0;
 }
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
@@ -879,7 +888,6 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 		return;
 	}
 	battery_hook_remove_battery(battery);
-	device_remove_file(&battery->bat->dev, &alarm_attr);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
 	mutex_unlock(&battery->sysfs_lock);
-- 
2.43.0


