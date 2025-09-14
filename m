Return-Path: <linux-acpi+bounces-16881-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E37F2B567DF
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Sep 2025 13:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D41A189989B
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Sep 2025 11:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55C92475CF;
	Sun, 14 Sep 2025 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RqFQkaMl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8521EEA31;
	Sun, 14 Sep 2025 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757849334; cv=none; b=Jf6dVrioHozc+PPcKGMaL7ZiUwYgFHSGDLj33lS9PUdyq9vYXSBqwX65FvlBgKwGwkcSyGIDEvVnnP6IOyCvdBSsoOeSWsq6sZfgG2SjczQqm36+AfIAGbLXUGq9fhpxz9Tg0K8TGHE0S23Ert0b2S8ebq56mXRgR+uuViPa7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757849334; c=relaxed/simple;
	bh=sbbiQC5idlV79e5VJuSDrpNy3nbNksDDZ7ieLP3a9Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOFltky+kyD1reNx98teTdFg3B9vPb762k5cnZYV7lI+UbiJw71iPeNsLjhR/6uaxACPlK2lyAD7srIEGyNL4vfk+HH0mOLIj0IZrxSL9sNOmwe6Kkma8p8AXx80smyKuaGiucYN9b+SnMklMbg/VVOV9D8MiEVZ8xIXK0S0dRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RqFQkaMl; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jp
	U/nK/QiVXIUpvfuILcBhsqzSqu6VBvY4LCmLMP+fc=; b=RqFQkaMlzez5oqnrSf
	x+fq6pGLMgdelDStFABECMJ4HjYVL6ckEHP9+Z/3LXwkqW9RZz69/YhrI+CioAmX
	FS8xOA7D1GRLQ6VO6HbZiCQbveemYReYKRY5otrf+f3BFrs/ZMQTde3huXjj0lzG
	9edtSH3TJc0QQtGvBxL6pdlQ8=
Received: from MS-CMFLBWVCLQRG.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3AgYMo8ZoNtYUDA--.21814S2;
	Sun, 14 Sep 2025 19:12:13 +0800 (CST)
From: GuangFei Luo <luogf2025@163.com>
To: rafael@kernel.org
Cc: michal.wilczynski@intel.com,
	gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lkp@intel.com,
	luogf2025@163.com,
	sre@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v6] ACPI: battery: prevent sysfs_add_battery re-entry on rapid events
Date: Sun, 14 Sep 2025 19:12:11 +0800
Message-ID: <20250914111211.1570889-1-luogf2025@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910142653.313360-1-luogf2025@163.com>
References: <20250910142653.313360-1-luogf2025@163.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgB3AgYMo8ZoNtYUDA--.21814S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF43ur1kWw4fWF43uF18Grg_yoWxKFW5pa
	yrCayUKrW8JF48JwsF9F1UKryfurs0qF9rWr95Cr92k3srur1DAr4IqFyUAF47Gry8C3y8
	XFn5t3WYyw18Ww7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U04iUUUUUU=
X-CM-SenderInfo: poxrwwisqskqqrwthudrp/xtbBXxTHmWjFEa7oRwADsr

When removing and reinserting the laptop battery, ACPI can trigger
two notifications in quick succession:
  - ACPI_BATTERY_NOTIFY_STATUS (0x80)
  - ACPI_BATTERY_NOTIFY_INFO   (0x81)

Both notifications call acpi_battery_update(). Because the events
happen very close in time, sysfs_add_battery() can be re-entered
before battery->bat is set, causing a duplicate sysfs entry error.

This patch ensures that sysfs_add_battery() is not re-entered
when battery->bat is already non-NULL, preventing the duplicate
sysfs creation and stabilizing battery hotplug handling.

[  476.117945] sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1'
[  476.118896] CPU: 1 UID: 0 PID: 185 Comm: kworker/1:4 Kdump: loaded Not tainted 6.12.38+deb13-amd64 #1  Debian 6.12.38-1
[  476.118903] Hardware name: Gateway          NV44             /SJV40-MV        , BIOS V1.3121 04/08/2009
[  476.118906] Workqueue: kacpi_notify acpi_os_execute_deferred
[  476.118917] Call Trace:
[  476.118922]  <TASK>
[  476.118929]  dump_stack_lvl+0x5d/0x80
[  476.118938]  sysfs_warn_dup.cold+0x17/0x23
[  476.118943]  sysfs_create_dir_ns+0xce/0xe0
[  476.118952]  kobject_add_internal+0xba/0x250
[  476.118959]  kobject_add+0x96/0xc0
[  476.118964]  ? get_device_parent+0xde/0x1e0
[  476.118970]  device_add+0xe2/0x870
[  476.118975]  __power_supply_register.part.0+0x20f/0x3f0
[  476.118981]  ? wake_up_q+0x4e/0x90
[  476.118990]  sysfs_add_battery+0xa4/0x1d0 [battery]
[  476.118998]  acpi_battery_update+0x19e/0x290 [battery]
[  476.119002]  acpi_battery_notify+0x50/0x120 [battery]
[  476.119006]  acpi_ev_notify_dispatch+0x49/0x70
[  476.119012]  acpi_os_execute_deferred+0x1a/0x30
[  476.119015]  process_one_work+0x177/0x330
[  476.119022]  worker_thread+0x251/0x390
[  476.119026]  ? __pfx_worker_thread+0x10/0x10
[  476.119030]  kthread+0xd2/0x100
[  476.119033]  ? __pfx_kthread+0x10/0x10
[  476.119035]  ret_from_fork+0x34/0x50
[  476.119040]  ? __pfx_kthread+0x10/0x10
[  476.119042]  ret_from_fork_asm+0x1a/0x30
[  476.119049]  </TASK>
[  476.142552] kobject: kobject_add_internal failed for BAT1 with -EEXIST, don't try to register things with the same name in the same directory.
[  476.415022] ata1.00: unexpected _GTF length (8)
[  476.428076] sd 0:0:0:0: [sda] Starting disk
[  476.835035] ata1.00: unexpected _GTF length (8)
[  476.839720] ata1.00: configured for UDMA/133
[  491.328831] sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT1'
[  491.329720] CPU: 1 UID: 0 PID: 185 Comm: kworker/1:4 Kdump: loaded Not tainted 6.12.38+deb13-amd64 #1  Debian 6.12.38-1
[  491.329727] Hardware name: Gateway          NV44             /SJV40-MV        , BIOS V1.3121 04/08/2009
[  491.329731] Workqueue: kacpi_notify acpi_os_execute_deferred
[  491.329741] Call Trace:
[  491.329745]  <TASK>
[  491.329751]  dump_stack_lvl+0x5d/0x80
[  491.329758]  sysfs_warn_dup.cold+0x17/0x23
[  491.329762]  sysfs_create_dir_ns+0xce/0xe0
[  491.329770]  kobject_add_internal+0xba/0x250
[  491.329775]  kobject_add+0x96/0xc0
[  491.329779]  ? get_device_parent+0xde/0x1e0
[  491.329784]  device_add+0xe2/0x870
[  491.329790]  __power_supply_register.part.0+0x20f/0x3f0
[  491.329797]  sysfs_add_battery+0xa4/0x1d0 [battery]
[  491.329805]  acpi_battery_update+0x19e/0x290 [battery]
[  491.329809]  acpi_battery_notify+0x50/0x120 [battery]
[  491.329812]  acpi_ev_notify_dispatch+0x49/0x70
[  491.329817]  acpi_os_execute_deferred+0x1a/0x30
[  491.329820]  process_one_work+0x177/0x330
[  491.329826]  worker_thread+0x251/0x390
[  491.329830]  ? __pfx_worker_thread+0x10/0x10
[  491.329833]  kthread+0xd2/0x100
[  491.329836]  ? __pfx_kthread+0x10/0x10
[  491.329838]  ret_from_fork+0x34/0x50
[  491.329842]  ? __pfx_kthread+0x10/0x10
[  491.329844]  ret_from_fork_asm+0x1a/0x30
[  491.329850]  </TASK>
[  491.329855] kobject: kobject_add_internal failed for BAT1 with -EEXIST, don't try to register things with the same name in the same directory.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202509101620.yI0HZ5gT-lkp@intel.com/
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202509101620.yI0HZ5gT-lkp@intel.com/
Fixes: 10666251554c ("ACPI: battery: Install Notify() handler directly")
Signed-off-by: GuangFei Luo <luogf2025@163.com>
Cc: stable@vger.kernel.org
---
v6:
  - Update Fixes tag: point to commit 10666251554c ("ACPI: battery: Install
    Notify() handler directly"), which introduced the sysfs_add_battery()
    re-entry issue when acpi_battery_notify is registered via
    acpi_dev_install_notify_handler(). The problem does not occur with
    acpi_bus_register_driver().

v5:
  - Move changelog above the '---' line as per submission guidelines.

v4:
  - Uses guard(mutex) for battery->sysfs_lock in sysfs_add_battery().
  - Since sysfs_add_battery() now handles the battery->bat check with
    proper locking,the extra if (!battery->bat) check at the call site
    has become redundant.

v3:
  - Modified the earlier approach: since sysfs_add_battery() is invoked
    from multiple places, the most reliable way is to add the lock inside
    the function itself.
  - sysfs_remove_battery() had a similar race issue in the past, which was
    fixed by adding a lock as well. Reference:
    https://lore.kernel.org/all/9c921c22a7f33397a6774d7fa076db9b6a0fd669
        .1312318300.git.len.brown@intel.com/

v2:
 - Fix missing mutex_unlock in acpi_battery_update()
   (Reported-by: kernel test robot)

v1:
 - Initial patch to handle race when hotplugging battery, preventing
   duplicate sysfs entries.
---
 drivers/acpi/battery.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6905b56bf3e4..20d68f3e881f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -850,6 +850,10 @@ static void __exit battery_hook_exit(void)
 
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
+	guard(mutex)(&battery->sysfs_lock);
+	if (battery->bat)
+		return 0;
+
 	struct power_supply_config psy_cfg = {
 		.drv_data = battery,
 		.attr_grp = acpi_battery_groups,
@@ -1026,11 +1030,9 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 		return result;
 	acpi_battery_quirks(battery);
 
-	if (!battery->bat) {
-		result = sysfs_add_battery(battery);
-		if (result)
-			return result;
-	}
+	result = sysfs_add_battery(battery);
+	if (result)
+		return result;
 
 	/*
 	 * Wakeup the system if battery is critical low
@@ -1112,12 +1114,12 @@ static int battery_notify(struct notifier_block *nb,
 			result = acpi_battery_get_info(battery);
 			if (result)
 				return result;
-
-			result = sysfs_add_battery(battery);
-			if (result)
-				return result;
 		}
 
+		result = sysfs_add_battery(battery);
+		if (result)
+			return result;
+
 		acpi_battery_init_alarm(battery);
 		acpi_battery_get_state(battery);
 		break;
-- 
2.43.0


