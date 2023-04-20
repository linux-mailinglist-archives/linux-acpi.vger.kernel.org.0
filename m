Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529606E91D2
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 13:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjDTLF2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 07:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjDTLEs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 07:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617855A4
        for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2023 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681988544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hq3QNEMudW51eMDzNrroNHBYxi5M+MAF5mxOYyUo23U=;
        b=E2RqiFn0phuGeEqYwqIC1aCxUJKGsBDrLeLjVwFioZG2bHWHOsM/uYZ/6cfI/gabot9l0c
        eAktN4PH736d29EX1N4DYpYif78lH1VLCoSGbH9+rAv0QlWRSsxMaiXWLgbuSSPe9t0M7h
        OEeWAA02CrWE5Yh/YWDA1Zfwpadi618=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247--BaZiDkLPmGhpw1imRHhmA-1; Thu, 20 Apr 2023 07:02:23 -0400
X-MC-Unique: -BaZiDkLPmGhpw1imRHhmA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CC38800047;
        Thu, 20 Apr 2023 11:02:22 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7026492B05;
        Thu, 20 Apr 2023 11:02:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, regressions@lists.linux.dev,
        linux-acpi@vger.kernel.org,
        =?UTF-8?q?G=C3=A9=20Koerkamp?= <ge.koerkamp@gmail.com>
Subject: [PATCH] ACPI: PM: Do not turn of unused power resources on the Toshiba Click Mini
Date:   Thu, 20 Apr 2023 13:02:20 +0200
Message-Id: <20230420110220.23168-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The CPR3 power resource on the Toshiba Click Mini toggles a GPIO
which is called SISP (for SIS touchscreen power?) on/off.

This CPR3 power resource is not listed in any _PR? lists, let alone
in a _PR0 list for the SIS0817 touchscreen ACPI device which needs it.

Before commit a1224f34d72a ("ACPI: PM: Check states of power resources
during initialization") this was not an issue because since nothing
referenced the CPR3 power resource its state was always
ACPI_POWER_RESOURCE_STATE_UNKNOWN and power resources with this state
get ignored by acpi_turn_off_unused_power_resources().

This clearly is a bug in the DSDT of this device. Add a DMI quirk
to make acpi_turn_off_unused_power_resources() a no-op on this
model to fix the touchscreen no longer working since kernel 5.16 .

This quirk also causes 2 other power resources to not get turned
off, but the _OFF method on these already was a no-op, so this makes
no difference for the other 2 power resources.

Fixes: a1224f34d72a ("ACPI: PM: Check states of power resources during initialization")
Reported-by: Gé Koerkamp <ge.koerkamp@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216946
Link: https://lore.kernel.org/regressions/32a14a8a-9795-4c8c-7e00-da9012f548f8@leemhuis.info/
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/power.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 292cec3691cc..5dc792961ab8 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -23,6 +23,7 @@
 
 #define pr_fmt(fmt) "ACPI: PM: " fmt
 
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -1022,6 +1023,21 @@ void acpi_resume_power_resources(void)
 }
 #endif
 
+static const struct dmi_system_id dmi_leave_unused_power_resources_on[] = {
+	{
+		/*
+		 * The Toshiba Click Mini has a CPR3 power-resource which must
+		 * be on for the touchscreen to work, but which is not in any
+		 * _PR? lists. The other 2 affected power-resources are no-ops.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE Click Mini L9W-B"),
+		},
+	},
+	{}
+};
+
 /**
  * acpi_turn_off_unused_power_resources - Turn off power resources not in use.
  */
@@ -1029,6 +1045,9 @@ void acpi_turn_off_unused_power_resources(void)
 {
 	struct acpi_power_resource *resource;
 
+	if (dmi_check_system(dmi_leave_unused_power_resources_on))
+		return;
+
 	mutex_lock(&power_resource_list_lock);
 
 	list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_node) {
-- 
2.39.2

