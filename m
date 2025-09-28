Return-Path: <linux-acpi+bounces-17380-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39360BA6ED4
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 12:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EB73A312E
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 10:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F31D2D9EFE;
	Sun, 28 Sep 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0FPpTF7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE022FE02;
	Sun, 28 Sep 2025 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759054713; cv=none; b=bKpQDKhgCAIS+05x9sHl1+/d8fXQyPkM6XvEZWDjNbghiXghv3gV6HPNECrTees02niFWi0rVuKruEcBKmJSOSrr+sC56CjjA3Eo+wy8vlLT4A7/BetORZIXaSFHDk9yZqUyIMcUTXdh43IyJqDqRzthEsVfvLTlLK/1mRkmrho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759054713; c=relaxed/simple;
	bh=qpqNZeseSpoppJPiIQZ8f4guCrUeGX/8HcqAsfo+0UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DgqINScjWcTKsqGPCPnKmudUIW4Lb5U1w0mdwJoQPGzjaLNdXfnd0/2r4WAHeLd8slKjOICnZ+pfQJ0WwgqHeSCTjDF8yLJYWmxSiH8uEeGuUxC68VhSL7y6Tuy9JMxqpR/tuMbIn6EfVhqHqy4G+9eudanXpmVvprdSjaF5Fns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0FPpTF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975BEC4CEF0;
	Sun, 28 Sep 2025 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759054712;
	bh=qpqNZeseSpoppJPiIQZ8f4guCrUeGX/8HcqAsfo+0UU=;
	h=From:To:Cc:Subject:Date:From;
	b=E0FPpTF7GLh91oAXnFoijHrD0X+RJ2ccS6qrx2KJ34l7GWtf9bI7GzmABuKW+snKL
	 XHTAZcqeEs85gbV53TGDIeA+l6M06Pdcera9aG6XKoAUUDVFsWfrrT0obc9nPORWrh
	 TebMQrIFkj6RKm2G9OhrUbW99w6wsIg48bPjn38CXRvWJewzabMG4d51HSQnpLuiI/
	 fTvwpgP8k043Y4T1rSzwf0hm/HgKkKlmIv13UIv+XUpxVoQaBRWgCNBqlbzUx5jRM4
	 0Atr5c2wjd1RjZglMdUtn26hW6zFojQq77GnBo3sHRJ42wanykGTSB48hQTc8KOe3l
	 LLgpOpmWpZLwA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 GuangFei Luo <luogf2025@163.com>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject:
 [PATCH v2] ACPI: battery: Add synchronization between interface updates
Date: Sun, 28 Sep 2025 12:18:29 +0200
Message-ID: <12754933.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is no synchronization between different code paths in the ACPI
battery driver that update its sysfs interface or its power supply
class device interface.  In some cases this results to functional
failures due to race conditions.

One example of this is when two ACPI notifications:

  - ACPI_BATTERY_NOTIFY_STATUS (0x80)
  - ACPI_BATTERY_NOTIFY_INFO   (0x81)

are triggered (by the platform firmware) in a row with a little delay
in between after removing and reinserting a laptop battery.  Both
notifications cause acpi_battery_update() to be called and if the delay
between them is sufficiently small, sysfs_add_battery() can be re-entered
before battery->bat is set which leads to a duplicate sysfs entry error:

 sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1'
 CPU: 1 UID: 0 PID: 185 Comm: kworker/1:4 Kdump: loaded Not tainted 6.12.38+deb13-amd64 #1  Debian 6.12.38-1
 Hardware name: Gateway          NV44             /SJV40-MV        , BIOS V1.3121 04/08/2009
 Workqueue: kacpi_notify acpi_os_execute_deferred
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5d/0x80
  sysfs_warn_dup.cold+0x17/0x23
  sysfs_create_dir_ns+0xce/0xe0
  kobject_add_internal+0xba/0x250
  kobject_add+0x96/0xc0
  ? get_device_parent+0xde/0x1e0
  device_add+0xe2/0x870
  __power_supply_register.part.0+0x20f/0x3f0
  ? wake_up_q+0x4e/0x90
  sysfs_add_battery+0xa4/0x1d0 [battery]
  acpi_battery_update+0x19e/0x290 [battery]
  acpi_battery_notify+0x50/0x120 [battery]
  acpi_ev_notify_dispatch+0x49/0x70
  acpi_os_execute_deferred+0x1a/0x30
  process_one_work+0x177/0x330
  worker_thread+0x251/0x390
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xd2/0x100
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 kobject: kobject_add_internal failed for BAT1 with -EEXIST, don't try to register things with the same name in the same directory.

There are also other scenarios in which analogous issues may occur.

Address this by using a common lock in all of the code paths leading
to updates of driver interfaces: ACPI Notify () handler, system resume
callback and post-resume notification, device addition and removal.

This new lock replaces sysfs_lock that has been used only in
sysfs_remove_battery() which now is going to be always called under
the new lock, so it doesn't need any internal locking any more.

Fixes: 10666251554c ("ACPI: battery: Install Notify() handler directly")
Closes: https://lore.kernel.org/linux-acpi/20250910142653.313360-1-luogf2025@163.com/
Reported-by: GuangFei Luo <luogf2025@163.com>
Tested-by: GuangFei Luo <luogf2025@163.com>
Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Added a new function for acpi_battery_add() failure path to avoid
   compiler warning regarding defining a new variable after a label.

---
 drivers/acpi/battery.c |   43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -92,7 +92,7 @@ enum {
 
 struct acpi_battery {
 	struct mutex lock;
-	struct mutex sysfs_lock;
+	struct mutex update_lock;
 	struct power_supply *bat;
 	struct power_supply_desc bat_desc;
 	struct acpi_device *device;
@@ -904,15 +904,12 @@ static int sysfs_add_battery(struct acpi
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
 {
-	mutex_lock(&battery->sysfs_lock);
-	if (!battery->bat) {
-		mutex_unlock(&battery->sysfs_lock);
+	if (!battery->bat)
 		return;
-	}
+
 	battery_hook_remove_battery(battery);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
-	mutex_unlock(&battery->sysfs_lock);
 }
 
 static void find_battery(const struct dmi_header *dm, void *private)
@@ -1072,6 +1069,9 @@ static void acpi_battery_notify(acpi_han
 
 	if (!battery)
 		return;
+
+	guard(mutex)(&battery->update_lock);
+
 	old = battery->bat;
 	/*
 	 * On Acer Aspire V5-573G notifications are sometimes triggered too
@@ -1094,21 +1094,22 @@ static void acpi_battery_notify(acpi_han
 }
 
 static int battery_notify(struct notifier_block *nb,
-			       unsigned long mode, void *_unused)
+			  unsigned long mode, void *_unused)
 {
 	struct acpi_battery *battery = container_of(nb, struct acpi_battery,
 						    pm_nb);
-	int result;
 
-	switch (mode) {
-	case PM_POST_HIBERNATION:
-	case PM_POST_SUSPEND:
+	if (mode == PM_POST_SUSPEND || mode == PM_POST_HIBERNATION) {
+		guard(mutex)(&battery->update_lock);
+
 		if (!acpi_battery_present(battery))
 			return 0;
 
 		if (battery->bat) {
 			acpi_battery_refresh(battery);
 		} else {
+			int result;
+
 			result = acpi_battery_get_info(battery);
 			if (result)
 				return result;
@@ -1120,7 +1121,6 @@ static int battery_notify(struct notifie
 
 		acpi_battery_init_alarm(battery);
 		acpi_battery_get_state(battery);
-		break;
 	}
 
 	return 0;
@@ -1198,6 +1198,8 @@ static int acpi_battery_update_retry(str
 {
 	int retry, ret;
 
+	guard(mutex)(&battery->update_lock);
+
 	for (retry = 5; retry; retry--) {
 		ret = acpi_battery_update(battery, false);
 		if (!ret)
@@ -1208,6 +1210,13 @@ static int acpi_battery_update_retry(str
 	return ret;
 }
 
+static void sysfs_battery_cleanup(struct acpi_battery *battery)
+{
+	guard(mutex)(&battery->update_lock);
+
+	sysfs_remove_battery(battery);
+}
+
 static int acpi_battery_add(struct acpi_device *device)
 {
 	int result = 0;
@@ -1230,7 +1239,7 @@ static int acpi_battery_add(struct acpi_
 	if (result)
 		return result;
 
-	result = devm_mutex_init(&device->dev, &battery->sysfs_lock);
+	result = devm_mutex_init(&device->dev, &battery->update_lock);
 	if (result)
 		return result;
 
@@ -1262,7 +1271,7 @@ fail_pm:
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
 fail:
-	sysfs_remove_battery(battery);
+	sysfs_battery_cleanup(battery);
 
 	return result;
 }
@@ -1281,6 +1290,9 @@ static void acpi_battery_remove(struct a
 
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
+
+	guard(mutex)(&battery->update_lock);
+
 	sysfs_remove_battery(battery);
 }
 
@@ -1297,6 +1309,9 @@ static int acpi_battery_resume(struct de
 		return -EINVAL;
 
 	battery->update_time = 0;
+
+	guard(mutex)(&battery->update_lock);
+
 	acpi_battery_update(battery, true);
 	return 0;
 }




