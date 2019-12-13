Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C21311E0AC
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 10:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLMJ1d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 04:27:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61210 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfLMJ1d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Dec 2019 04:27:33 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 3e4136f9a6c3eaa5; Fri, 13 Dec 2019 10:27:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 07/10] cpuidle: Allow idle states to be disabled by default
Date:   Fri, 13 Dec 2019 10:22:04 +0100
Message-ID: <23901825.xGlorUmkL0@kreacher>
In-Reply-To: <3950312.2WmFeOdZGY@kreacher>
References: <3950312.2WmFeOdZGY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In certain situations it may be useful to prevent some idle states
from being used by default while allowing user space to enable them
later on.

For this purpose, introduce a new state flag, CPUIDLE_FLAG_OFF, to
mark idle states that should be disabled by default, make the core
set CPUIDLE_STATE_DISABLED_BY_USER for those states at the
initialization time and add a new state attribute in sysfs,
"default_status", to inform user space of the initial status of
the given idle state ("disabled" if CPUIDLE_FLAG_OFF is set for it,
"enabled" otherwise).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Changes from the RFC version:
 - Call the new sysfs attribute "default_status" (instead of "initial_status").

---
 Documentation/ABI/testing/sysfs-devices-system-cpu |  6 ++++++
 Documentation/admin-guide/pm/cpuidle.rst           |  3 +++
 drivers/cpuidle/cpuidle.c                          |  6 +++++-
 drivers/cpuidle/sysfs.c                            | 10 ++++++++++
 include/linux/cpuidle.h                            |  1 +
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index fc20cde63d1e..2e0e3b45d02a 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -196,6 +196,12 @@ Description:
 		does not reflect it. Likewise, if one enables a deep state but a
 		lighter state still is disabled, then this has no effect.
 
+What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/default_status
+Date:		December 2019
+KernelVersion:	v5.6
+Contact:	Linux power management list <linux-pm@vger.kernel.org>
+Description:
+		(RO) The default status of this state, "enabled" or "disabled".
 
 What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/residency
 Date:		March 2014
diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index e70b365dbc60..311cd7cc2b75 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -506,6 +506,9 @@ object corresponding to it, as follows:
 ``disable``
 	Whether or not this idle state is disabled.
 
+``default_status``
+	The default status of this state, "enabled" or "disabled".
+
 ``latency``
 	Exit latency of the idle state in microseconds.
 
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0005be5ea2b4..24eaa4c8138b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -571,10 +571,14 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 	if (!try_module_get(drv->owner))
 		return -EINVAL;
 
-	for (i = 0; i < drv->state_count; i++)
+	for (i = 0; i < drv->state_count; i++) {
 		if (drv->states[i].flags & CPUIDLE_FLAG_UNUSABLE)
 			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_DRIVER;
 
+		if (drv->states[i].flags & CPUIDLE_FLAG_OFF)
+			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_USER;
+	}
+
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
 
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 38ef770be90d..254d1560dc19 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -327,6 +327,14 @@ static ssize_t store_state_disable(struct cpuidle_state *state,
 	return size;
 }
 
+static ssize_t show_state_default_status(struct cpuidle_state *state,
+					  struct cpuidle_state_usage *state_usage,
+					  char *buf)
+{
+	return sprintf(buf, "%s\n",
+		       state->flags & CPUIDLE_FLAG_OFF ? "disabled" : "enabled");
+}
+
 define_one_state_ro(name, show_state_name);
 define_one_state_ro(desc, show_state_desc);
 define_one_state_ro(latency, show_state_exit_latency);
@@ -337,6 +345,7 @@ define_one_state_ro(time, show_state_time);
 define_one_state_rw(disable, show_state_disable, store_state_disable);
 define_one_state_ro(above, show_state_above);
 define_one_state_ro(below, show_state_below);
+define_one_state_ro(default_status, show_state_default_status);
 
 static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_name.attr,
@@ -349,6 +358,7 @@ static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_disable.attr,
 	&attr_above.attr,
 	&attr_below.attr,
+	&attr_default_status.attr,
 	NULL
 };
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 1dabe36bd011..ebfb52b3ffbf 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -77,6 +77,7 @@ struct cpuidle_state {
 #define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
 #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
 #define CPUIDLE_FLAG_UNUSABLE	BIT(3) /* avoid using this state */
+#define CPUIDLE_FLAG_OFF	BIT(4) /* disable this state by default */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
-- 
2.16.4





