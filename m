Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754631E4791
	for <lists+linux-acpi@lfdr.de>; Wed, 27 May 2020 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE0PdI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 May 2020 11:33:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgE0PdI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 May 2020 11:33:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43606AD72;
        Wed, 27 May 2020 15:33:07 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     linux-acpi@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, rui.zhang@intel.com
Subject: Remove last acpi procfs dirs after being marked deprecated for a decade
Date:   Wed, 27 May 2020 17:33:03 +0200
Message-ID: <1696561.dScFM4BVNv@c100>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Kernel development should not be hindered anymore by this absolutely
outdated stuff.

CC: Sorin Manolache <sorinm@gmail.com>
CC: Lan Tianyu <tianyu.lan@intel.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Thomas Renninger <trenn@suse.de>

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ce2730d61a8f..db3c45305414 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -99,23 +99,6 @@ config ACPI_SLEEP
 	depends on ACPI_SYSTEM_POWER_STATES_SUPPORT
 	default y
 
-config ACPI_PROCFS_POWER
-	bool "Deprecated power /proc/acpi directories"
-	depends on X86 && PROC_FS
-	help
-	  For backwards compatibility, this option allows
-	  deprecated power /proc/acpi/ directories to exist, even when
-	  they have been replaced by functions in /sys.
-	  The deprecated directories (and their replacements) include:
-	  /proc/acpi/battery/* (/sys/class/power_supply/*) and
-	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*).
-	  This option has no effect on /proc/acpi/ directories
-	  and functions which do not yet exist in /sys.
-	  This option, together with the proc directories, will be
-	  deleted in the future.
-
-	  Say N to delete power /proc/acpi/ directories that have moved to /sys.
-
 config ACPI_REV_OVERRIDE_POSSIBLE
 	bool "Allow supported ACPI revision to be overridden"
 	depends on X86
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index e81e1ebbfb32..9a957544e357 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -55,7 +55,6 @@ acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
 acpi-$(CONFIG_X86)		+= x86/apple.o
 acpi-$(CONFIG_X86)		+= x86/utils.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
-acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 acpi-y				+= acpi_lpat.o
 acpi-$(CONFIG_ACPI_LPIT)	+= acpi_lpit.o
 acpi-$(CONFIG_ACPI_GENERIC_GSI) += irq.o
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 69d2db13886b..0149893f9e66 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -13,10 +13,6 @@
 #include <linux/types.h>
 #include <linux/dmi.h>
 #include <linux/delay.h>
-#ifdef CONFIG_ACPI_PROCFS_POWER
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#endif
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/acpi.h>
@@ -66,12 +62,6 @@ static int acpi_ac_resume(struct device *dev);
 #endif
 static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-extern struct proc_dir_entry *acpi_lock_ac_dir(void);
-extern void *acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir);
-#endif
-
-
 static int ac_sleep_before_get_state_ms;
 static int ac_check_pmic = 1;
 
@@ -150,77 +140,6 @@ static enum power_supply_property ac_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-/* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-
-static struct proc_dir_entry *acpi_ac_dir;
-
-static int acpi_ac_seq_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_ac *ac = seq->private;
-
-
-	if (!ac)
-		return 0;
-
-	if (acpi_ac_get_state(ac)) {
-		seq_puts(seq, "ERROR: Unable to read AC Adapter state\n");
-		return 0;
-	}
-
-	seq_puts(seq, "state:                   ");
-	switch (ac->state) {
-	case ACPI_AC_STATUS_OFFLINE:
-		seq_puts(seq, "off-line\n");
-		break;
-	case ACPI_AC_STATUS_ONLINE:
-		seq_puts(seq, "on-line\n");
-		break;
-	default:
-		seq_puts(seq, "unknown\n");
-		break;
-	}
-
-	return 0;
-}
-
-static int acpi_ac_add_fs(struct acpi_ac *ac)
-{
-	struct proc_dir_entry *entry = NULL;
-
-	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for AC is loaded,"
-			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
-	if (!acpi_device_dir(ac->device)) {
-		acpi_device_dir(ac->device) =
-			proc_mkdir(acpi_device_bid(ac->device), acpi_ac_dir);
-		if (!acpi_device_dir(ac->device))
-			return -ENODEV;
-	}
-
-	/* 'state' [R] */
-	entry = proc_create_single_data(ACPI_AC_FILE_STATE, S_IRUGO,
-			acpi_device_dir(ac->device), acpi_ac_seq_show, ac);
-	if (!entry)
-		return -ENODEV;
-	return 0;
-}
-
-static int acpi_ac_remove_fs(struct acpi_ac *ac)
-{
-
-	if (acpi_device_dir(ac->device)) {
-		remove_proc_entry(ACPI_AC_FILE_STATE,
-				  acpi_device_dir(ac->device));
-		remove_proc_entry(acpi_device_bid(ac->device), acpi_ac_dir);
-		acpi_device_dir(ac->device) = NULL;
-	}
-
-	return 0;
-}
-#endif
-
 /* --------------------------------------------------------------------------
                                    Driver Model
    -------------------------------------------------------------------------- */
@@ -348,11 +267,6 @@ static int acpi_ac_add(struct acpi_device *device)
 	psy_cfg.drv_data = ac;
 
 	ac->charger_desc.name = acpi_device_bid(device);
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	result = acpi_ac_add_fs(ac);
-	if (result)
-		goto end;
-#endif
 	ac->charger_desc.type = POWER_SUPPLY_TYPE_MAINS;
 	ac->charger_desc.properties = ac_props;
 	ac->charger_desc.num_properties = ARRAY_SIZE(ac_props);
@@ -372,9 +286,6 @@ static int acpi_ac_add(struct acpi_device *device)
 	register_acpi_notifier(&ac->battery_nb);
 end:
 	if (result) {
-#ifdef CONFIG_ACPI_PROCFS_POWER
-		acpi_ac_remove_fs(ac);
-#endif
 		kfree(ac);
 	}
 
@@ -418,10 +329,6 @@ static int acpi_ac_remove(struct acpi_device *device)
 	power_supply_unregister(ac->charger);
 	unregister_acpi_notifier(&ac->battery_nb);
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_ac_remove_fs(ac);
-#endif
-
 	kfree(ac);
 
 	return 0;
@@ -447,18 +354,8 @@ static int __init acpi_ac_init(void)
 			}
 	}
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_ac_dir = acpi_lock_ac_dir();
-	if (!acpi_ac_dir)
-		return -ENODEV;
-#endif
-
-
 	result = acpi_bus_register_driver(&acpi_ac_driver);
 	if (result < 0) {
-#ifdef CONFIG_ACPI_PROCFS_POWER
-		acpi_unlock_ac_dir(acpi_ac_dir);
-#endif
 		return -ENODEV;
 	}
 
@@ -468,9 +365,6 @@ static int __init acpi_ac_init(void)
 static void __exit acpi_ac_exit(void)
 {
 	acpi_bus_unregister_driver(&acpi_ac_driver);
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_unlock_ac_dir(acpi_ac_dir);
-#endif
 }
 module_init(acpi_ac_init);
 module_exit(acpi_ac_exit);
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 366c389175d8..cab4af532f36 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -24,12 +24,6 @@
 
 #include <asm/unaligned.h>
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/uaccess.h>
-#endif
-
 #include <linux/acpi.h>
 #include <linux/power_supply.h>
 
@@ -69,11 +63,6 @@ static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-extern struct proc_dir_entry *acpi_lock_battery_dir(void);
-extern void *acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
-#endif
-
 static const struct acpi_device_id battery_device_ids[] = {
 	{"PNP0C0A", 0},
 	{"", 0},
@@ -1023,226 +1012,6 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 	sysfs_add_battery(battery);
 }
 
-/* --------------------------------------------------------------------------
-                              FS Interface (/proc)
-   -------------------------------------------------------------------------- */
-
-#ifdef CONFIG_ACPI_PROCFS_POWER
-static struct proc_dir_entry *acpi_battery_dir;
-
-static const char *acpi_battery_units(const struct acpi_battery *battery)
-{
-	return (battery->power_unit == ACPI_BATTERY_POWER_UNIT_MA) ?
-		"mA" : "mW";
-}
-
-static int acpi_battery_info_proc_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_battery *battery = seq->private;
-	int result = acpi_battery_update(battery, false);
-
-	if (result)
-		goto end;
-
-	seq_printf(seq, "present:                 %s\n",
-		   acpi_battery_present(battery) ? "yes" : "no");
-	if (!acpi_battery_present(battery))
-		goto end;
-	if (battery->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "design capacity:         unknown\n");
-	else
-		seq_printf(seq, "design capacity:         %d %sh\n",
-			   battery->design_capacity,
-			   acpi_battery_units(battery));
-
-	if (battery->full_charge_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "last full capacity:      unknown\n");
-	else
-		seq_printf(seq, "last full capacity:      %d %sh\n",
-			   battery->full_charge_capacity,
-			   acpi_battery_units(battery));
-
-	seq_printf(seq, "battery technology:      %srechargeable\n",
-		   battery->technology ? "" : "non-");
-
-	if (battery->design_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "design voltage:          unknown\n");
-	else
-		seq_printf(seq, "design voltage:          %d mV\n",
-			   battery->design_voltage);
-	seq_printf(seq, "design capacity warning: %d %sh\n",
-		   battery->design_capacity_warning,
-		   acpi_battery_units(battery));
-	seq_printf(seq, "design capacity low:     %d %sh\n",
-		   battery->design_capacity_low,
-		   acpi_battery_units(battery));
-	seq_printf(seq, "cycle count:		  %i\n", battery->cycle_count);
-	seq_printf(seq, "capacity granularity 1:  %d %sh\n",
-		   battery->capacity_granularity_1,
-		   acpi_battery_units(battery));
-	seq_printf(seq, "capacity granularity 2:  %d %sh\n",
-		   battery->capacity_granularity_2,
-		   acpi_battery_units(battery));
-	seq_printf(seq, "model number:            %s\n", battery->model_number);
-	seq_printf(seq, "serial number:           %s\n", battery->serial_number);
-	seq_printf(seq, "battery type:            %s\n", battery->type);
-	seq_printf(seq, "OEM info:                %s\n", battery->oem_info);
-      end:
-	if (result)
-		seq_printf(seq, "ERROR: Unable to read battery info\n");
-	return result;
-}
-
-static int acpi_battery_state_proc_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_battery *battery = seq->private;
-	int result = acpi_battery_update(battery, false);
-
-	if (result)
-		goto end;
-
-	seq_printf(seq, "present:                 %s\n",
-		   acpi_battery_present(battery) ? "yes" : "no");
-	if (!acpi_battery_present(battery))
-		goto end;
-
-	seq_printf(seq, "capacity state:          %s\n",
-			(battery->state & 0x04) ? "critical" : "ok");
-	if ((battery->state & 0x01) && (battery->state & 0x02))
-		seq_printf(seq,
-			   "charging state:          charging/discharging\n");
-	else if (battery->state & 0x01)
-		seq_printf(seq, "charging state:          discharging\n");
-	else if (battery->state & 0x02)
-		seq_printf(seq, "charging state:          charging\n");
-	else
-		seq_printf(seq, "charging state:          charged\n");
-
-	if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "present rate:            unknown\n");
-	else
-		seq_printf(seq, "present rate:            %d %s\n",
-			   battery->rate_now, acpi_battery_units(battery));
-
-	if (battery->capacity_now == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "remaining capacity:      unknown\n");
-	else
-		seq_printf(seq, "remaining capacity:      %d %sh\n",
-			   battery->capacity_now, acpi_battery_units(battery));
-	if (battery->voltage_now == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "present voltage:         unknown\n");
-	else
-		seq_printf(seq, "present voltage:         %d mV\n",
-			   battery->voltage_now);
-      end:
-	if (result)
-		seq_printf(seq, "ERROR: Unable to read battery state\n");
-
-	return result;
-}
-
-static int acpi_battery_alarm_proc_show(struct seq_file *seq, void *offset)
-{
-	struct acpi_battery *battery = seq->private;
-	int result = acpi_battery_update(battery, false);
-
-	if (result)
-		goto end;
-
-	if (!acpi_battery_present(battery)) {
-		seq_printf(seq, "present:                 no\n");
-		goto end;
-	}
-	seq_printf(seq, "alarm:                   ");
-	if (battery->alarm) {
-		seq_printf(seq, "%u %sh\n", battery->alarm,
-				acpi_battery_units(battery));
-	} else {
-		seq_printf(seq, "unsupported\n");
-	}
-      end:
-	if (result)
-		seq_printf(seq, "ERROR: Unable to read battery alarm\n");
-	return result;
-}
-
-static ssize_t acpi_battery_write_alarm(struct file *file,
-					const char __user * buffer,
-					size_t count, loff_t * ppos)
-{
-	int result = 0;
-	char alarm_string[12] = { '\0' };
-	struct seq_file *m = file->private_data;
-	struct acpi_battery *battery = m->private;
-
-	if (!battery || (count > sizeof(alarm_string) - 1))
-		return -EINVAL;
-	if (!acpi_battery_present(battery)) {
-		result = -ENODEV;
-		goto end;
-	}
-	if (copy_from_user(alarm_string, buffer, count)) {
-		result = -EFAULT;
-		goto end;
-	}
-	alarm_string[count] = '\0';
-	if (kstrtoint(alarm_string, 0, &battery->alarm)) {
-		result = -EINVAL;
-		goto end;
-	}
-	result = acpi_battery_set_alarm(battery);
-      end:
-	if (result)
-		return result;
-	return count;
-}
-
-static int acpi_battery_alarm_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, acpi_battery_alarm_proc_show, PDE_DATA(inode));
-}
-
-static const struct proc_ops acpi_battery_alarm_proc_ops = {
-	.proc_open	= acpi_battery_alarm_proc_open,
-	.proc_read	= seq_read,
-	.proc_write	= acpi_battery_write_alarm,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
-};
-
-static int acpi_battery_add_fs(struct acpi_device *device)
-{
-	pr_warn(PREFIX "Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
-	if (!acpi_device_dir(device)) {
-		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
-						     acpi_battery_dir);
-		if (!acpi_device_dir(device))
-			return -ENODEV;
-	}
-
-	if (!proc_create_single_data("info", S_IRUGO, acpi_device_dir(device),
-			acpi_battery_info_proc_show, acpi_driver_data(device)))
-		return -ENODEV;
-	if (!proc_create_single_data("state", S_IRUGO, acpi_device_dir(device),
-			acpi_battery_state_proc_show, acpi_driver_data(device)))
-		return -ENODEV;
-	if (!proc_create_data("alarm", S_IFREG | S_IRUGO | S_IWUSR,
-			acpi_device_dir(device), &acpi_battery_alarm_proc_ops,
-			acpi_driver_data(device)))
-		return -ENODEV;
-	return 0;
-}
-
-static void acpi_battery_remove_fs(struct acpi_device *device)
-{
-	if (!acpi_device_dir(device))
-		return;
-	remove_proc_subtree(acpi_device_bid(device), acpi_battery_dir);
-	acpi_device_dir(device) = NULL;
-}
-
-#endif
-
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -1432,14 +1201,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (result)
 		goto fail;
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	result = acpi_battery_add_fs(device);
-	if (result) {
-		acpi_battery_remove_fs(device);
-		goto fail;
-	}
-#endif
-
 	pr_info(PREFIX "%s Slot [%s] (battery %s)\n",
 		ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
 		device->status.battery_present ? "present" : "absent");
@@ -1468,9 +1229,6 @@ static int acpi_battery_remove(struct acpi_device *device)
 	device_init_wakeup(&device->dev, 0);
 	battery = acpi_driver_data(device);
 	unregister_pm_notifier(&battery->pm_nb);
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_battery_remove_fs(device);
-#endif
 	sysfs_remove_battery(battery);
 	mutex_destroy(&battery->lock);
 	mutex_destroy(&battery->sysfs_lock);
@@ -1531,16 +1289,7 @@ static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
 			}
 	}
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_battery_dir = acpi_lock_battery_dir();
-	if (!acpi_battery_dir)
-		return;
-#endif
 	result = acpi_bus_register_driver(&acpi_battery_driver);
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	if (result < 0)
-		acpi_unlock_battery_dir(acpi_battery_dir);
-#endif
 	battery_driver_registered = (result == 0);
 }
 
@@ -1560,10 +1309,6 @@ static void __exit acpi_battery_exit(void)
 		acpi_bus_unregister_driver(&acpi_battery_driver);
 		battery_hook_exit();
 	}
-#ifdef CONFIG_ACPI_PROCFS_POWER
-	if (acpi_battery_dir)
-		acpi_unlock_battery_dir(acpi_battery_dir);
-#endif
 }
 
 module_init(acpi_battery_init);
diff --git a/drivers/acpi/cm_sbs.c b/drivers/acpi/cm_sbs.c
deleted file mode 100644
index 0ca9f82de8ba..000000000000
--- a/drivers/acpi/cm_sbs.c
+++ /dev/null
@@ -1,87 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/acpi.h>
-#include <linux/types.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <acpi/acpi_bus.h>
-#include <acpi/acpi_drivers.h>
-
-#define PREFIX "ACPI: "
-
-ACPI_MODULE_NAME("cm_sbs");
-#define ACPI_AC_CLASS		"ac_adapter"
-#define ACPI_BATTERY_CLASS	"battery"
-#define _COMPONENT		ACPI_SBS_COMPONENT
-static struct proc_dir_entry *acpi_ac_dir;
-static struct proc_dir_entry *acpi_battery_dir;
-
-static DEFINE_MUTEX(cm_sbs_mutex);
-
-static int lock_ac_dir_cnt;
-static int lock_battery_dir_cnt;
-
-struct proc_dir_entry *acpi_lock_ac_dir(void)
-{
-	mutex_lock(&cm_sbs_mutex);
-	if (!acpi_ac_dir)
-		acpi_ac_dir = proc_mkdir(ACPI_AC_CLASS, acpi_root_dir);
-	if (acpi_ac_dir) {
-		lock_ac_dir_cnt++;
-	} else {
-		printk(KERN_ERR PREFIX
-				  "Cannot create %s\n", ACPI_AC_CLASS);
-	}
-	mutex_unlock(&cm_sbs_mutex);
-	return acpi_ac_dir;
-}
-EXPORT_SYMBOL(acpi_lock_ac_dir);
-
-void acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir_param)
-{
-	mutex_lock(&cm_sbs_mutex);
-	if (acpi_ac_dir_param)
-		lock_ac_dir_cnt--;
-	if (lock_ac_dir_cnt == 0 && acpi_ac_dir_param && acpi_ac_dir) {
-		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
-		acpi_ac_dir = NULL;
-	}
-	mutex_unlock(&cm_sbs_mutex);
-}
-EXPORT_SYMBOL(acpi_unlock_ac_dir);
-
-struct proc_dir_entry *acpi_lock_battery_dir(void)
-{
-	mutex_lock(&cm_sbs_mutex);
-	if (!acpi_battery_dir) {
-		acpi_battery_dir =
-		    proc_mkdir(ACPI_BATTERY_CLASS, acpi_root_dir);
-	}
-	if (acpi_battery_dir) {
-		lock_battery_dir_cnt++;
-	} else {
-		printk(KERN_ERR PREFIX
-				  "Cannot create %s\n", ACPI_BATTERY_CLASS);
-	}
-	mutex_unlock(&cm_sbs_mutex);
-	return acpi_battery_dir;
-}
-EXPORT_SYMBOL(acpi_lock_battery_dir);
-
-void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir_param)
-{
-	mutex_lock(&cm_sbs_mutex);
-	if (acpi_battery_dir_param)
-		lock_battery_dir_cnt--;
-	if (lock_battery_dir_cnt == 0 && acpi_battery_dir_param
-	    && acpi_battery_dir) {
-		remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
-		acpi_battery_dir = NULL;
-	}
-	mutex_unlock(&cm_sbs_mutex);
-	return;
-}
-EXPORT_SYMBOL(acpi_unlock_battery_dir);



