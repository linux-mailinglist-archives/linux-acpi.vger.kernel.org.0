Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B243DCF79
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 21:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394951AbfJRTlU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 15:41:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394885AbfJRTlU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Oct 2019 15:41:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A633F10C094D;
        Fri, 18 Oct 2019 19:41:19 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-168.ams2.redhat.com [10.36.117.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69D215C1B5;
        Fri, 18 Oct 2019 19:41:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/5] ACPI: button: Refactor lid_init_state module parsing code
Date:   Fri, 18 Oct 2019 21:41:11 +0200
Message-Id: <20191018194115.93281-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Fri, 18 Oct 2019 19:41:19 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Replace the weird strncmp() calls in param_set_lid_init_state(),
which look to me like they will also accept things like "opennnn"
to use sysfs_match_string instead.

Also rewrite param_get_lid_init_state() using the new lid_init_state_str
array. Instead of doing a straightforward one line replacement, e.g. :
  return sprintf(buffer, lid_init_state_str[lid_init_state]);
print all possible values, putting [] around the selected value, so
that users can easily find out what the possible values are.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 62 ++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 4a2cde2c536a..121d747a840c 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -44,9 +44,17 @@
 #define ACPI_BUTTON_DEVICE_NAME_LID	"Lid Switch"
 #define ACPI_BUTTON_TYPE_LID		0x05
 
-#define ACPI_BUTTON_LID_INIT_IGNORE	0x00
-#define ACPI_BUTTON_LID_INIT_OPEN	0x01
-#define ACPI_BUTTON_LID_INIT_METHOD	0x02
+enum {
+	ACPI_BUTTON_LID_INIT_IGNORE,
+	ACPI_BUTTON_LID_INIT_OPEN,
+	ACPI_BUTTON_LID_INIT_METHOD,
+};
+
+static const char * const lid_init_state_str[] = {
+	[ACPI_BUTTON_LID_INIT_IGNORE]		= "ignore",
+	[ACPI_BUTTON_LID_INIT_OPEN]		= "open",
+	[ACPI_BUTTON_LID_INIT_METHOD]		= "method",
+};
 
 #define _COMPONENT		ACPI_BUTTON_COMPONENT
 ACPI_MODULE_NAME("button");
@@ -578,36 +586,30 @@ static int acpi_button_remove(struct acpi_device *device)
 static int param_set_lid_init_state(const char *val,
 				    const struct kernel_param *kp)
 {
-	int result = 0;
-
-	if (!strncmp(val, "open", sizeof("open") - 1)) {
-		lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
-		pr_info("Notify initial lid state as open\n");
-	} else if (!strncmp(val, "method", sizeof("method") - 1)) {
-		lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
-		pr_info("Notify initial lid state with _LID return value\n");
-	} else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
-		lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
-		pr_info("Do not notify initial lid state\n");
-	} else
-		result = -EINVAL;
-	return result;
+	int i;
+
+	i = sysfs_match_string(lid_init_state_str, val);
+	if (i < 0)
+		return i;
+
+	lid_init_state = i;
+	pr_info("Initial lid state set to '%s'\n", lid_init_state_str[i]);
+	return 0;
 }
 
-static int param_get_lid_init_state(char *buffer,
-				    const struct kernel_param *kp)
+static int param_get_lid_init_state(char *buf, const struct kernel_param *kp)
 {
-	switch (lid_init_state) {
-	case ACPI_BUTTON_LID_INIT_OPEN:
-		return sprintf(buffer, "open");
-	case ACPI_BUTTON_LID_INIT_METHOD:
-		return sprintf(buffer, "method");
-	case ACPI_BUTTON_LID_INIT_IGNORE:
-		return sprintf(buffer, "ignore");
-	default:
-		return sprintf(buffer, "invalid");
-	}
-	return 0;
+	int i, c = 0;
+
+	for (i = 0; i < ARRAY_SIZE(lid_init_state_str); i++)
+		if (i == lid_init_state)
+			c += sprintf(buf + c, "[%s] ", lid_init_state_str[i]);
+		else
+			c += sprintf(buf + c, "%s ", lid_init_state_str[i]);
+
+	buf[c - 1] = '\n'; /* Replace the final space with a newline */
+
+	return c;
 }
 
 module_param_call(lid_init_state,
-- 
2.23.0

