Return-Path: <linux-acpi+bounces-10950-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE9A2D73F
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 17:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB8A18890EC
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9A61F30A0;
	Sat,  8 Feb 2025 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHrP2rH6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FA01F17EF;
	Sat,  8 Feb 2025 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031743; cv=none; b=l9rBlwGrfPKzKzaqs9Zdwc/Y4NXiFodfWeG9hV9ZTECybLvN7nWTvFr6mack34WjyYhSwnSPT2njqA8HcoWaxtgNF9ZEtZCXltveIriiloPPJu4YrXXRLzgF66e5D2ub/nrIlL5g7lVxjp3ttc/VJHsDsmD34IbiteJORfg35Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031743; c=relaxed/simple;
	bh=HMyexdvrSbhPi8L8f9PM8AX6KBSHh5CStz+s+JDgAIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGQXudLoczqGseIO/pmjN7S6INHLlfcJzpny6lNd7Lxk4P37oNtlteVzFPUH4QYyNAgnInmeU/OcdJgLEZbL6jmXbSGUziHDdtY1CzwsV0gPn0e/ECzEUEzeVrW/87lnfV0ZQIvYItPl6AYqs3aDgvN13Ju8mPXH6RKcjYIoKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHrP2rH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790C7C4CEE2;
	Sat,  8 Feb 2025 16:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739031743;
	bh=HMyexdvrSbhPi8L8f9PM8AX6KBSHh5CStz+s+JDgAIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHrP2rH6harAFsyYxcW4tN+JUIeDd54zlCMp9kmtjMXQD6XUuQS46u5aeEbuR5CD1
	 Wk/YuV5IWXOjosmiXxLy/ZO26lB7nrHmUfQ14EB5MspNSAFxYdKnefSCWWdqgEGWPa
	 Q1AmPZnZJIx1yPbhPYRPR743Jlj1lwRdgI4cwMOVn+/sVjRoWHP6JEhxBMlexYdLBy
	 0Is5Za1RG9wVKtTb8+UTfx7IIAXcK04+zyAWeBCabJYS2ZPhkQKVvzMhsbf4BVyxMJ
	 Tz1lEsEJqNFX5GK8llBfc2MRX5pWGyhrqHi3TKzL+cnyEf2NODjXnZD2DyY8lYbQAK
	 xPW47qW3uFnJg==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/4] ACPI: battery: Save and report battery capacity over suspend
Date: Sat,  8 Feb 2025 10:22:08 -0600
Message-ID: <20250208162210.3929473-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208162210.3929473-1-superm1@kernel.org>
References: <20250208162210.3929473-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

To find out if a device is malfunctioning over suspend it's often
interesting to know how much battery was lost.

At the start of the suspend cycle cache the amount of battery.
During resume, read the battery level again and if the battery
has decreased report the difference to the suspend stats using
pm_report_sleep_energy()

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/battery.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6760330a8af55..f21bfd02a26d1 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -124,6 +124,7 @@ struct acpi_battery {
 	char oem_info[MAX_STRING_LENGTH];
 	int state;
 	int power_unit;
+	int capacity_suspend;
 	unsigned long flags;
 };
 
@@ -1011,9 +1012,6 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 		return 0;
 	}
 
-	if (resume)
-		return 0;
-
 	if (!battery->update_time) {
 		result = acpi_battery_get_info(battery);
 		if (result)
@@ -1032,6 +1030,14 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 			return result;
 	}
 
+	if (resume) {
+		if (battery->capacity_suspend > battery->capacity_now)
+			pm_report_sleep_energy(battery->capacity_suspend - battery->capacity_now);
+		else
+			pm_report_sleep_energy(0);
+		return 0;
+	}
+
 	/*
 	 * Wakeup the system if battery is critical low
 	 * or lower than the alarm level
@@ -1285,6 +1291,22 @@ static void acpi_battery_remove(struct acpi_device *device)
 }
 
 /* this is needed to learn about changes made in suspended state */
+static int acpi_battery_suspend(struct device *dev)
+{
+	struct acpi_battery *battery;
+
+	if (!dev)
+		return -EINVAL;
+
+	battery = acpi_driver_data(to_acpi_device(dev));
+	if (!battery)
+		return -EINVAL;
+
+	battery->capacity_suspend = battery->capacity_now;
+
+	return 0;
+}
+
 static int acpi_battery_resume(struct device *dev)
 {
 	struct acpi_battery *battery;
@@ -1301,7 +1323,7 @@ static int acpi_battery_resume(struct device *dev)
 	return 0;
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(acpi_battery_pm, NULL, acpi_battery_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(acpi_battery_pm, acpi_battery_suspend, acpi_battery_resume);
 
 static struct acpi_driver acpi_battery_driver = {
 	.name = "battery",
-- 
2.43.0


