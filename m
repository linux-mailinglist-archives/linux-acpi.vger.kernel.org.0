Return-Path: <linux-acpi+bounces-10321-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111889FDFE7
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Dec 2024 17:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98CA18824E8
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Dec 2024 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4DC15B99E;
	Sun, 29 Dec 2024 16:45:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359B926ACC;
	Sun, 29 Dec 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735490717; cv=none; b=VnQNshxhttShivoXPai5hpEGREvkma/pNOkfaECm6Pj1wl2mQz5tZlqpsP08sKSI5UUMEH6EZAMgKtlNjMLR2OPxdDYKi6WX9OQZIBQF6a6jxG8cWlkES/eb210ubRnSti5gdMXBysb60nLFy5SPw/u7FZHxYu7YC4lk842u48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735490717; c=relaxed/simple;
	bh=TpCV3afmp6BdyNdYrqeE7DF3QvY7MLFjaxCR3eQOJzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QwknhckyL+RMe77odtVFVZ9sCIsxMxNhF9cyzgoyeTv6Atkrpw6ZM5zRCFElS462T1Sy8o6Ym94raO3p810zsn6FE8Ret88U2bIjz/flxwoelYlhxV1oVN3+lvCNG9H3e2Fck8ZSXq7WW5mJq6w/oHnvO4E3o1xSX0q3pcivOeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1tRwPg-00000004nnD-09oJ;
	Sun, 29 Dec 2024 17:45:12 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: PM: Add HP EliteBook 855 G7 WWAN modem power resource quirk
Date: Sun, 29 Dec 2024 17:45:06 +0100
Message-ID: <fdf629284a00da61384eadea6ac0cd78c20e7e11.1735490662.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.47.1
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

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/acpi/power.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 25174c24d3d7..1db93cf8e4f6 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -23,6 +23,7 @@
 
 #define pr_fmt(fmt) "ACPI: PM: " fmt
 
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -991,9 +992,57 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 }
 
 #ifdef CONFIG_ACPI_SLEEP
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
+	bool hp_eb_gp12pxp_quirk = dmi_check_system(dmi_hp_elitebook_gp12pxp_quirk);
 
 	mutex_lock(&power_resource_list_lock);
 
@@ -1012,8 +1061,34 @@ void acpi_resume_power_resources(void)
 
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

