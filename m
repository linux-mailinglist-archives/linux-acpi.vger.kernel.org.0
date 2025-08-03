Return-Path: <linux-acpi+bounces-15480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530DAB194F8
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 21:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65387172C63
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 19:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC41C4A24;
	Sun,  3 Aug 2025 19:18:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD420311;
	Sun,  3 Aug 2025 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754248715; cv=none; b=Ju7bl4kdiGdXXgIESNQycjimovO7615d33CQQwr7JzwzwjD13Eb4sIuG3ChidzTLpqGQ6JY0grIFJh+t/kMYmQBzM7TVDll0lO9Bb9Vp0F3GGF30JawBt1gOrwLc5zHw4p1jcGTl6IgeC0AMuDJgD2qjs7n74wBYhgrPyrKNing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754248715; c=relaxed/simple;
	bh=t4JFnPe9gqwe0MLV9N3+1ndOHzUwYCL+u3GoDH6fu10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhKdWczqi2N6Q8cYxBc5L1krjmBufFtHYUz67Mj3DMZlHxc7v38W5sC03AtD01lH748P62hmfF5JE0KccUl9zKsCbi3y85sYGTNFCYSGEqDibGiQhZIB4qLGs1VVwydBkq0QiKy49vOBtU0ho7DmUwQ0DY8TP5//UPejM5/sdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1uieE2-00000000Muu-2ls7;
	Sun, 03 Aug 2025 21:18:30 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ACPI: PM: Add HP EliteBook 855 G7 WWAN modem power resource quirk
Date: Sun,  3 Aug 2025 21:18:12 +0200
Message-ID: <c6ff6931c5d27592052f30339de1b9cc298c43f0.1754243159.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754243159.git.mail@maciej.szmigiero.name>
References: <cover.1754243159.git.mail@maciej.szmigiero.name>
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
once - in acpi_power_resources_init() function.

This way the whole resume path overhead of this change on other systems
amounts to simple hp_eb_gp12pxp_quirk flag comparison.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/acpi/power.c | 80 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index cd9380b1f951..361a7721a6a8 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -23,6 +23,7 @@
 
 #define pr_fmt(fmt) "ACPI: PM: " fmt
 
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -63,6 +64,7 @@ struct acpi_power_resource_entry {
 	struct acpi_power_resource *resource;
 };
 
+static bool hp_eb_gp12pxp_quirk;
 static bool unused_power_resources_quirk;
 
 static LIST_HEAD(acpi_power_resource_list);
@@ -994,6 +996,38 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
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
+static void acpi_resume_on_eb_gp12pxp(struct acpi_power_resource *resource)
+{
+	acpi_handle_notice(resource->device.handle,
+			   "HP EB quirk - turning OFF then ON\n");
+
+	__acpi_power_off(resource);
+	__acpi_power_on(resource);
+
+	/*
+	 * Use the same delay as DSDT uses in modem _RST method.
+	 *
+	 * Otherwise we get "Unable to change power state from unknown to D0,
+	 * device inaccessible" error for the modem PCI device after thaw.
+	 *
+	 * This power resource is normally being enabled only during thaw (once)
+	 * so this wait is not a performance issue.
+	 */
+	msleep(200);
+}
+
 void acpi_resume_power_resources(void)
 {
 	struct acpi_power_resource *resource;
@@ -1015,8 +1049,14 @@ void acpi_resume_power_resources(void)
 
 		if (state == ACPI_POWER_RESOURCE_STATE_OFF
 		    && resource->ref_count) {
-			acpi_handle_debug(resource->device.handle, "Turning ON\n");
-			__acpi_power_on(resource);
+			if (hp_eb_gp12pxp_quirk &&
+			    resource_is_gp12pxp(resource->device.handle)) {
+				acpi_resume_on_eb_gp12pxp(resource);
+			} else {
+				acpi_handle_debug(resource->device.handle,
+						  "Turning ON\n");
+				__acpi_power_on(resource);
+			}
 		}
 
 		mutex_unlock(&resource->resource_lock);
@@ -1026,6 +1066,41 @@ void acpi_resume_power_resources(void)
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
@@ -1070,6 +1145,7 @@ void acpi_turn_off_unused_power_resources(void)
 
 void __init acpi_power_resources_init(void)
 {
+	hp_eb_gp12pxp_quirk = dmi_check_system(dmi_hp_elitebook_gp12pxp_quirk);
 	unused_power_resources_quirk =
 		dmi_check_system(dmi_leave_unused_power_resources_on);
 }

