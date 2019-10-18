Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 317E9DCF7D
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 21:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394862AbfJRTl3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 15:41:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394908AbfJRTl3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Oct 2019 15:41:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A486C30833CB;
        Fri, 18 Oct 2019 19:41:28 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-168.ams2.redhat.com [10.36.117.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BFBE5C1B5;
        Fri, 18 Oct 2019 19:41:27 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 5/5] ACPI: button: Remove unused acpi_lid_notifier_[un]register functions
Date:   Fri, 18 Oct 2019 21:41:15 +0200
Message-Id: <20191018194115.93281-5-hdegoede@redhat.com>
In-Reply-To: <20191018194115.93281-1-hdegoede@redhat.com>
References: <20191018194115.93281-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 18 Oct 2019 19:41:28 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are no users of the acpi_lid_notifier_[un]register functions,
so lets remove them.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 27 +--------------------------
 include/acpi/button.h | 12 ------------
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 3021afc77fc2..117be25ef578 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -135,7 +135,6 @@ struct acpi_button {
 	bool suspended;
 };
 
-static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
 static int lid_init_state = -1;
 
@@ -165,7 +164,6 @@ static int acpi_lid_evaluate_state(struct acpi_device *device)
 static int acpi_lid_notify_state(struct acpi_device *device, int state)
 {
 	struct acpi_button *button = acpi_driver_data(device);
-	int ret;
 	ktime_t next_report;
 	bool do_update;
 
@@ -242,18 +240,7 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
 		button->last_time = ktime_get();
 	}
 
-	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
-	if (ret == NOTIFY_DONE)
-		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
-						   device);
-	if (ret == NOTIFY_DONE || ret == NOTIFY_OK) {
-		/*
-		 * It is also regarded as success if the notifier_chain
-		 * returns NOTIFY_OK or NOTIFY_DONE.
-		 */
-		ret = 0;
-	}
-	return ret;
+	return 0;
 }
 
 static int __maybe_unused acpi_button_state_seq_show(struct seq_file *seq,
@@ -350,18 +337,6 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 /* --------------------------------------------------------------------------
                                 Driver Interface
    -------------------------------------------------------------------------- */
-int acpi_lid_notifier_register(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&acpi_lid_notifier, nb);
-}
-EXPORT_SYMBOL(acpi_lid_notifier_register);
-
-int acpi_lid_notifier_unregister(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&acpi_lid_notifier, nb);
-}
-EXPORT_SYMBOL(acpi_lid_notifier_unregister);
-
 int acpi_lid_open(void)
 {
 	if (!lid_device)
diff --git a/include/acpi/button.h b/include/acpi/button.h
index 3a2b8535dec6..340da7784cc8 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -2,21 +2,9 @@
 #ifndef ACPI_BUTTON_H
 #define ACPI_BUTTON_H
 
-#include <linux/notifier.h>
-
 #if IS_ENABLED(CONFIG_ACPI_BUTTON)
-extern int acpi_lid_notifier_register(struct notifier_block *nb);
-extern int acpi_lid_notifier_unregister(struct notifier_block *nb);
 extern int acpi_lid_open(void);
 #else
-static inline int acpi_lid_notifier_register(struct notifier_block *nb)
-{
-	return 0;
-}
-static inline int acpi_lid_notifier_unregister(struct notifier_block *nb)
-{
-	return 0;
-}
 static inline int acpi_lid_open(void)
 {
 	return 1;
-- 
2.23.0

