Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF75B3C11
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Sep 2022 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiIIPes (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Sep 2022 11:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiIIPeY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Sep 2022 11:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B73F0A95
        for <linux-acpi@vger.kernel.org>; Fri,  9 Sep 2022 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662737566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=amM9n6XscybehtqofNDdO8fz/PqxjtzxHUOFeogKRQk=;
        b=iGkdTaf20iRHZtNSFola/u+u7GZqAyvS4QmzaBGpaVOaFtWOTFT8Ikrkvuqw2XZnKrug1Y
        MIlrncvCrLgagQGOzIqp8Up23S1FljighrvgTVitPVH7AEeNyXDfSSL1tbLP446WnPZypQ
        8p9d+O6AOGeGJQWzuKsqRDfeg6sUVgU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-IjsoyFcGOU2kLmidtpG-9w-1; Fri, 09 Sep 2022 11:32:43 -0400
X-MC-Unique: IjsoyFcGOU2kLmidtpG-9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10BD385A58A;
        Fri,  9 Sep 2022 15:32:43 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2DC62166B26;
        Fri,  9 Sep 2022 15:32:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Arvid Norlander <lkml@vorpal.se>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 1/2] drivers/platform: toshiba_acpi: Call HCI_PANEL_POWER_ON on resume on some models
Date:   Fri,  9 Sep 2022 17:32:38 +0200
Message-Id: <20220909153239.34606-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some Toshibas have a broken acpi-video interface for brightness control, so
far these have been using a special workaround in drivers/acpi/acpi_video.c
which gets activated by the disable_backlight_sysfs_if module-param/quirks.

The recent x86/acpi backlight refactoring has broken this workaround:
1. This workaround relies on acpi_video_get_backlight_type() returning
   acpi_video so that the acpi_video code actually runs; and
2. this relies on the actual native GPU driver to offer the sysfs
   backlight interface to userspace.

After the refactor this breaks since the native driver will no
longer register its backlight-device if acpi_video_get_backlight_type()
does not return native and making it return native breaks 1.

Keeping the acpi_video backlight handling on resume active, while not
using it to set the brightness, is necessary because it does a _BCM
call on resume which is necessary to turn the panel back on on resume.

Looking at the DSDT shows that this _BCM call results in a Toshiba
HCI_SET HCI_LCD_BRIGHTNESS call, which turns the panel back on.

This commit makes toshiba_acpi do a HCI_SET HCI_PANEL_POWER_ON call
on resume on the affected models, so that the (now broken)
acpi_video disable_backlight_sysfs_if workaround will no longer
be necessary.

Note this uses HCI_PANEL_POWER_ON instead of HCI_LCD_BRIGHTNESS
to avoid changing the configured brightness level.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add a turn_on_panel_on_resume module parameter to allow overriding
  the DMI quirk based setting
---
 drivers/platform/x86/toshiba_acpi.c | 50 +++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 900ee68a4c0b..aa55ed0d029d 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -23,6 +23,7 @@
 #define PROC_INTERFACE_VERSION	1
 
 #include <linux/compiler.h>
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -50,6 +51,11 @@ MODULE_AUTHOR("John Belmonte");
 MODULE_DESCRIPTION("Toshiba Laptop ACPI Extras Driver");
 MODULE_LICENSE("GPL");
 
+int turn_on_panel_on_resume = -1;
+module_param(turn_on_panel_on_resume, int, 0644);
+MODULE_PARM_DESC(turn_on_panel_on_resume,
+	"Call HCI_PANEL_POWER_ON on resume (-1 = auto, 0 = no, 1 = yes");
+
 #define TOSHIBA_WMI_EVENT_GUID "59142400-C6A3-40FA-BADB-8A2652834100"
 
 /* Scan code for Fn key on TOS1900 models */
@@ -100,6 +106,7 @@ MODULE_LICENSE("GPL");
 #define TOS_NOT_INSTALLED		0x8e00
 
 /* Registers */
+#define HCI_PANEL_POWER_ON		0x0002
 #define HCI_FAN				0x0004
 #define HCI_TR_BACKLIGHT		0x0005
 #define HCI_SYSTEM_EVENT		0x0016
@@ -3002,6 +3009,43 @@ static const char *find_hci_method(acpi_handle handle)
 	return NULL;
 }
 
+/*
+ * Some Toshibas have a broken acpi-video interface for brightness control,
+ * these are quirked in drivers/acpi/video_detect.c to use the GPU native
+ * (/sys/class/backlight/intel_backlight) instead.
+ * But these need a HCI_SET call to actually turn the panel back on at resume,
+ * without this call the screen stays black at resume.
+ * Either HCI_LCD_BRIGHTNESS (used by acpi_video's _BCM) or HCI_PANEL_POWER_ON
+ * works. toshiba_acpi_resume() uses HCI_PANEL_POWER_ON to avoid changing
+ * the configured brightness level.
+ */
+static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
+	{
+	 /* Toshiba Portégé R700 */
+	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
+		},
+	},
+	{
+	 /* Toshiba Satellite/Portégé R830 */
+	 /* Portégé: https://bugs.freedesktop.org/show_bug.cgi?id=82634 */
+	 /* Satellite: https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
+		},
+	},
+	{
+	 /* Toshiba Satellite/Portégé Z830 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
+		},
+	},
+};
+
 static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 {
 	struct toshiba_acpi_dev *dev;
@@ -3144,6 +3188,9 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	ret = get_fan_status(dev, &dummy);
 	dev->fan_supported = !ret;
 
+	if (turn_on_panel_on_resume == -1)
+		turn_on_panel_on_resume = dmi_check_system(turn_on_panel_on_resume_dmi_ids);
+
 	toshiba_wwan_available(dev);
 	if (dev->wwan_supported)
 		toshiba_acpi_setup_wwan_rfkill(dev);
@@ -3260,6 +3307,9 @@ static int toshiba_acpi_resume(struct device *device)
 			rfkill_set_hw_state(dev->wwan_rfk, !dev->killswitch);
 	}
 
+	if (turn_on_panel_on_resume)
+		hci_write(dev, HCI_PANEL_POWER_ON, 1);
+
 	return 0;
 }
 #endif
-- 
2.36.1

