Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37AFDCF7A
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 21:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395007AbfJRTlW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 15:41:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394885AbfJRTlW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Oct 2019 15:41:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01C203090FD6;
        Fri, 18 Oct 2019 19:41:22 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-168.ams2.redhat.com [10.36.117.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDE895C1B5;
        Fri, 18 Oct 2019 19:41:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/5] ACPI: button: Allow disabling LID support with the lid_init_state module option
Date:   Fri, 18 Oct 2019 21:41:12 +0200
Message-Id: <20191018194115.93281-2-hdegoede@redhat.com>
In-Reply-To: <20191018194115.93281-1-hdegoede@redhat.com>
References: <20191018194115.93281-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 18 Oct 2019 19:41:22 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a new "disabled" value for the lid_init_state module option, which can
be used to disable LID support on devices where it is completely broken.

Sometimes devices seem to spontaneously suspend and the cause for this is
not clear. The LID switch is known to be one possible cause for this,
this commit allows easily disabling the LID switch for testing if it
is the cause.

For example some devices which do not even have a lid, still have a LID
device in their ACPI tables, pointing to a floating GPIO.

This is not really related to the initial LID state, but re-using the
existing option keeps things simple and it will make it much easier to
add DMI quirks which can either disable the LID completely or set another
non-default lid_init_state value, both of which are necessary on some
devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 121d747a840c..7f69d8d1905b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -48,12 +48,14 @@ enum {
 	ACPI_BUTTON_LID_INIT_IGNORE,
 	ACPI_BUTTON_LID_INIT_OPEN,
 	ACPI_BUTTON_LID_INIT_METHOD,
+	ACPI_BUTTON_LID_INIT_DISABLED,
 };
 
 static const char * const lid_init_state_str[] = {
 	[ACPI_BUTTON_LID_INIT_IGNORE]		= "ignore",
 	[ACPI_BUTTON_LID_INIT_OPEN]		= "open",
 	[ACPI_BUTTON_LID_INIT_METHOD]		= "method",
+	[ACPI_BUTTON_LID_INIT_DISABLED]		= "disabled",
 };
 
 #define _COMPONENT		ACPI_BUTTON_COMPONENT
@@ -480,7 +482,9 @@ static int acpi_button_add(struct acpi_device *device)
 	char *name, *class;
 	int error;
 
-	if (!strcmp(hid, ACPI_BUTTON_HID_LID) && dmi_check_system(lid_blacklst))
+	if (!strcmp(hid, ACPI_BUTTON_HID_LID) &&
+	    (dmi_check_system(lid_blacklst) ||
+	     lid_init_state == ACPI_BUTTON_LID_INIT_DISABLED))
 		return -ENODEV;
 
 	button = kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
-- 
2.23.0

