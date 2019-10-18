Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB74DCF7B
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 21:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394885AbfJRTl0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 15:41:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394862AbfJRTl0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Oct 2019 15:41:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90DA8155E0;
        Fri, 18 Oct 2019 19:41:24 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-168.ams2.redhat.com [10.36.117.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51D1C5C1B5;
        Fri, 18 Oct 2019 19:41:22 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 3/5] ACPI: button: Turn lid_blacklst dmi table into a generic quirk table
Date:   Fri, 18 Oct 2019 21:41:13 +0200
Message-Id: <20191018194115.93281-3-hdegoede@redhat.com>
In-Reply-To: <20191018194115.93281-1-hdegoede@redhat.com>
References: <20191018194115.93281-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 18 Oct 2019 19:41:26 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 3540c32a9ae4 ("ACPI / button: Add quirks for initial lid state
notification") added 3 different modes to the LID handling code to deal
with various buggy implementations.

Until now users which need one of the 2 non-default modes to get their
hw to work have to pass a kernel commandline option for this.

E.g. https://bugzilla.kernel.org/show_bug.cgi?id=106151 was closed with a
note that the user has to add "button.lid_init_state=open" to the kernel
commandline to get the LID code to not cause undesirable suspends on his
Samsung N210 Plus.

This commit modifies the existing lid_blacklst dmi table so that it can
be used not only to completely disable the LID code on devices where
the ACPI tables are broken beyond repair, but also to select one of the 2
non default LID handling modes on devices where this is necessary.

This will allow us to add quirks to make the LID work OOTB on broken
devices. Getting this working OOTB is esp. important because the typical
breakage is false LID closed reporting, causing undesirable suspends which
basically make the system unusable.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 7f69d8d1905b..6e8a155f355d 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -75,18 +75,16 @@ static const struct acpi_device_id button_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, button_device_ids);
 
-/*
- * Some devices which don't even have a lid in anyway have a broken _LID
- * method (e.g. pointing to a floating gpio pin) causing spurious LID events.
- */
-static const struct dmi_system_id lid_blacklst[] = {
+/* Please keep this list sorted alphabetically by vendor and model */
+static const struct dmi_system_id dmi_lid_quirks[] = {
 	{
-		/* GP-electronic T701 */
+		/* GP-electronic T701, _LID method points to a floating GPIO */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "T701"),
 			DMI_MATCH(DMI_BIOS_VERSION, "BYT70A.YNCHENG.WIN.007"),
 		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
 	},
 	{}
 };
@@ -128,7 +126,7 @@ struct acpi_button {
 
 static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
-static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
+static int lid_init_state = -1;
 
 static unsigned long lid_report_interval __read_mostly = 500;
 module_param(lid_report_interval, ulong, 0644);
@@ -483,8 +481,7 @@ static int acpi_button_add(struct acpi_device *device)
 	int error;
 
 	if (!strcmp(hid, ACPI_BUTTON_HID_LID) &&
-	    (dmi_check_system(lid_blacklst) ||
-	     lid_init_state == ACPI_BUTTON_LID_INIT_DISABLED))
+	     lid_init_state == ACPI_BUTTON_LID_INIT_DISABLED)
 		return -ENODEV;
 
 	button = kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
@@ -623,6 +620,16 @@ MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
 
 static int acpi_button_register_driver(struct acpi_driver *driver)
 {
+	const struct dmi_system_id *dmi_id;
+
+	if (lid_init_state == -1) {
+		dmi_id = dmi_first_match(dmi_lid_quirks);
+		if (dmi_id)
+			lid_init_state = (long)dmi_id->driver_data;
+		else
+			lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
+	}
+
 	/*
 	 * Modules such as nouveau.ko and i915.ko have a link time dependency
 	 * on acpi_lid_open(), and would therefore not be loadable on ACPI
-- 
2.23.0

