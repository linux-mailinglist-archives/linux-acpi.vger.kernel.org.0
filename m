Return-Path: <linux-acpi+bounces-15241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A859B0B23F
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Jul 2025 00:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C603A3C85
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Jul 2025 22:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA67921CC58;
	Sat, 19 Jul 2025 22:21:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47769171CD;
	Sat, 19 Jul 2025 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752963674; cv=none; b=tkS08WsmQKAQygQQZdKK/DAWa0ZsCtpqoPLS4Bgy/vl6DidfFkWgkXwP96qOfbvRUFkZtxZ7joznAq5jyqdRPrd18W+PD7Pj0jvfyPmMwSkY2Ty0TGM+1agJ6niPKN98+W+HSMxukVop9JvC4hnpLSwYCjXtj9Ea0G3o6MIrgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752963674; c=relaxed/simple;
	bh=Fo4iOhIRyuFADpawBdj5F2OyRYGQrj4EGLxAWsIFJSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laDp6qbvD+ZDrE+OEwAq0H05TX1LxlYDriKohbZlCbbptWz9caF9Yi297DoWeWnq0EDCruivCUs/4tyyF+34OFgDL0XF5J48nqUINVTXpdddYdbB7wBoldqNi2eRuwUNXx2GUtLJV+MHOZrPHrQqXjRJqkKP/+mVyiLJZTgdJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1udF45-00000000yXv-1hLw;
	Sat, 19 Jul 2025 23:25:53 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: PM: Add HP EliteBook 855 G7 WWAN modem power resource quirk
Date: Sat, 19 Jul 2025 23:25:17 +0200
Message-ID: <999bc59ab1cb18764c5b85afb75da9625365ce1a.1752959347.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: mhej@vps-ovh.mhejs.net

This laptop (and possibly similar models too) has power resource called
"GP12.PXP_" for its Intel XMM7360 WWAN modem.

For this power resource to turn ON power for the modem it needs certain
internal flag called "ONEN" to be set:
Method (_ON, 0, NotSerialized) // _ON_: Power On
{
	If (^^^LPCB.EC0.ECRG)
	{
		If ((ONEN == Zero))
		{
                        Return (Zero)
		}
(..)
	}
}

This flag only gets set from this power resource "_OFF" method, while the
actual modem power gets turned off during suspend by "GP12.PTS" method
called from the global "_PTS" (Prepare To Sleep) method.

In fact, this power resource "_OFF" method implementation just sets the
aforementioned flag:
Method (_OFF, 0, NotSerialized) // _OFF: Power Off
{
	OFEN = Zero
	ONEN = One
}

Upon hibernation finish we try to set this power resource back ON since its
"_STA" method returns 0 and the resource is still considered in use as it
is declared as required for D0 for both the modem ACPI device (GP12.PWAN)
and its parent PCIe port ACPI device (GP12).
But the "_ON" method won't do anything since that "ONEN" flag is not set.

Overall, this means the modem is dead after hibernation finish until the
laptop is rebooted since the modem power has been cut by "_PTS" and its PCI
configuration was lost and not able to be restored.

The easiest way to workaround this issue is to call this power resource
"_OFF" method before calling the "_ON" method to make sure the "ONEN"
flag gets properly set.

This makes the modem alive once again after hibernation finish - with
properly restored PCI configuration space.

Since this platform does *not* support S3 the fact that
acpi_resume_power_resources() is also called during resume from S3 is
not a problem there.

Do the DMI based quirk matching and quirk flag initialization just
once - in acpi_power_resources_init() function similar to existing
acpi_*_init() functions.

This way the whole resume path overhead of this change on other systems
amounts to hp_eb_gp12pxp_quirk flag comparison.

Opportunistically convert the single already existing DMI match-based
quirk in this ACPI power resource handler ("leave unused power
resources on" quirk) to the same one-time initialization in
acpi_power_resources_init() function instead of re-running that DMI
match each time acpi_turn_off_unused_power_resources() gets called.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---

This Intel WWAN modem in general has *a lot* of issues with
suspend/resume on various laptop platforms (not only HP).

More patches are needed for these, hopefully they can be mainlined
too so suspend/resume work out of the box for users (that's
important functionality on a laptop).

See the following ModemManager issue containing patches also for
Thinkpad T14 G1 and Dell Precision 3561:
https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/issues/992


Changes from v1:
* Move hp_eb_gp12pxp_quirk flag initialization via DMI match to
  new acpi_power_resources_init() function for reduced resume path
  overhead.

* Move also the existing DMI match-based quirk for leaving unused power
  resources ON to acpi_power_resources_init() function for consistency.

* Update patch description about acpi_resume_power_resources() being
  called also from S3 resume not being an issue on this platform.

 drivers/acpi/internal.h |  1 +
 drivers/acpi/power.c    | 86 ++++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/scan.c     |  1 +
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index e2781864fdce..63354972ab0b 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -140,6 +140,7 @@ int __acpi_device_uevent_modalias(const struct acpi_device *adev,
 /* --------------------------------------------------------------------------
                                   Power Resource
    -------------------------------------------------------------------------- */
+void acpi_power_resources_init(void);
 void acpi_power_resources_list_free(struct list_head *list);
 int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
 				 struct list_head *list);
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index b7243d7563b1..944c17b471d5 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -23,6 +23,7 @@
 
 #define pr_fmt(fmt) "ACPI: PM: " fmt
 
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -63,6 +64,9 @@ struct acpi_power_resource_entry {
 	struct acpi_power_resource *resource;
 };
 
+static bool hp_eb_gp12pxp_quirk;
+static bool leave_unused_power_resources_on_quirk;
+
 static LIST_HEAD(acpi_power_resource_list);
 static DEFINE_MUTEX(power_resource_list_lock);
 
@@ -992,6 +996,18 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 }
 
 #ifdef CONFIG_ACPI_SLEEP
+static bool resource_is_gp12pxp(acpi_handle handle)
+{
+	const char *path;
+	bool ret;
+
+	path = acpi_handle_path(handle);
+	ret = path && strcmp(path, "\\_SB_.PCI0.GP12.PXP_") == 0;
+	kfree(path);
+
+	return ret;
+}
+
 void acpi_resume_power_resources(void)
 {
 	struct acpi_power_resource *resource;
@@ -1013,8 +1029,34 @@ void acpi_resume_power_resources(void)
 
 		if (state == ACPI_POWER_RESOURCE_STATE_OFF
 		    && resource->ref_count) {
+			bool eb_gp12pxp = hp_eb_gp12pxp_quirk &&
+				resource_is_gp12pxp(resource->device.handle);
+
+			if (eb_gp12pxp) {
+				acpi_handle_notice(resource->device.handle,
+						   "HP EB quirk - turning OFF before ON\n");
+				__acpi_power_off(resource);
+			}
+
 			acpi_handle_debug(resource->device.handle, "Turning ON\n");
 			__acpi_power_on(resource);
+
+			if (eb_gp12pxp) {
+				/*
+				 * Use the same delay as DSDT uses in modem _RST
+				 * method.
+				 *
+				 * Otherwise we get "Unable to change power
+				 * state from unknown to D0, device
+				 * inaccessible" error for the modem PCI device
+				 * after thaw.
+				 *
+				 * This power resource is normally being enabled
+				 * only during thaw (once) so this wait is not
+				 * a performance issue.
+				 */
+				msleep(200);
+			}
 		}
 
 		mutex_unlock(&resource->resource_lock);
@@ -1024,6 +1066,41 @@ void acpi_resume_power_resources(void)
 }
 #endif
 
+static const struct dmi_system_id dmi_hp_elitebook_gp12pxp_quirk[] = {
+/*
+ * This laptop (and possibly similar models too) has power resource called
+ * "GP12.PXP_" for its WWAN modem.
+ *
+ * For this power resource to turn ON power for the modem it needs certain
+ * internal flag called "ONEN" to be set.
+ * This flag only gets set from this power resource "_OFF" method, while the
+ * actual modem power gets turned off during suspend by "GP12.PTS" method
+ * called from the global "_PTS" (Prepare To Sleep) method.
+ * On the other hand, this power resource "_OFF" method implementation just
+ * sets the aforementioned flag without actually doing anything else (it
+ * doesn't contain any code to actually turn off power).
+ *
+ * The above means that when upon hibernation finish we try to set this
+ * power resource back ON since its "_STA" method returns 0 (while the resource
+ * is still considered in use) its "_ON" method won't do anything since
+ * that "ONEN" flag is not set.
+ * Overall, this means the modem is dead until laptop is rebooted since its
+ * power has been cut by "_PTS" and its PCI configuration was lost and not able
+ * to be restored.
+ *
+ * The easiest way to workaround the issue is to call this power resource
+ * "_OFF" method before calling the "_ON" method to make sure the "ONEN"
+ * flag gets properly set.
+ */
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 855 G7 Notebook PC"),
+		},
+	},
+	{}
+};
+
 static const struct dmi_system_id dmi_leave_unused_power_resources_on[] = {
 	{
 		/*
@@ -1046,7 +1123,7 @@ void acpi_turn_off_unused_power_resources(void)
 {
 	struct acpi_power_resource *resource;
 
-	if (dmi_check_system(dmi_leave_unused_power_resources_on))
+	if (leave_unused_power_resources_on_quirk)
 		return;
 
 	mutex_lock(&power_resource_list_lock);
@@ -1065,3 +1142,10 @@ void acpi_turn_off_unused_power_resources(void)
 
 	mutex_unlock(&power_resource_list_lock);
 }
+
+void __init acpi_power_resources_init(void)
+{
+	hp_eb_gp12pxp_quirk = dmi_check_system(dmi_hp_elitebook_gp12pxp_quirk);
+	leave_unused_power_resources_on_quirk =
+		dmi_check_system(dmi_leave_unused_power_resources_on);
+}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..bb74e7834435 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2702,6 +2702,7 @@ void __init acpi_scan_init(void)
 	acpi_memory_hotplug_init();
 	acpi_watchdog_init();
 	acpi_pnp_init();
+	acpi_power_resources_init();
 	acpi_int340x_thermal_init();
 	acpi_init_lpit();
 

