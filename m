Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C34D2A7179
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Nov 2020 00:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbgKDXYQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Nov 2020 18:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732817AbgKDXYP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Nov 2020 18:24:15 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE4C0613D2
        for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2020 15:24:15 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id w189so14486344qkd.6
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2020 15:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GBfX89ipKAdhSeKOBnmDOlEumypWnqMaH7J6rYeJ5xI=;
        b=OtStWDvUWMoNu1uFW93R3YUJPK4KdVXvIirI8DYQDbP1mtGw7pOxQr70pccFJI1sjW
         KpMBl0v04JrAPqiZ0gw8qg1aJ8V6uHQWqx8nQ9PU14zcRePMBJi/pxXFk73+WXMrui4C
         im5QvJFb0yOBMqPaXBpF9BBwr4fbfZh0ZBKrJfwqHEvtnoI8xPp4GvlAMGwIBxU8NwCV
         AZrt9Ud0caxdBy6uAsuhwVfRiGM0KDKiVOIEvEhoQQFXw8M5AdrhL3yMl7LlalVIVhc+
         ozc/TIYiy9wDUKWjZQ99SfwUosjxaIt+liQq+XMXelo1UytBI+S7Gya+KRV+2klWQPmN
         0rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GBfX89ipKAdhSeKOBnmDOlEumypWnqMaH7J6rYeJ5xI=;
        b=RpNv0nKBXNNM/DcuSJhKsSGX6J1hh7v8bZjLLC8+W8s3z/yNHabRH6oZsZ6U2UhCMz
         ggc/ftpG2Ro2Y/aoPwPJFtTuQ2Z3zACqIaxaU/KtG9Q76EjQTpqq7n0pyDY9XBKMaMB8
         1buHiNw+B7nIajs9wo/CplQj0hLez80gJctebLQh9OtNcW9H6UWo5XuoQVnA5oHF1V3g
         VzN3WghNo6D97lNN31FwPZQkeQatIaICiaqSyoj6fKP2/SY3HQUc7MfmOxXeWiMJk9ln
         mZxs0coLjzK4ceCroH2eu7mL5abvid59SKzQZUyKzd0Qe/56a6VyAkH2NgRfqkrTFycx
         WhxQ==
X-Gm-Message-State: AOAM5314BnN2VLHm+wFkgiChuH9kgTLQ+GcYR2Cf8ZsXKCBTKAIKCfaj
        DuG0UvmpIWKc34lb/B2DyTLAld/Zj+HTjVo=
X-Google-Smtp-Source: ABdhPJzpMzNB3hV/VqHLMmIuFIM8PLOEu5q57/n9A5EgKtdFkuQ/Dp5bx2fhoyEsfYeKa0SZ4GL4IQ3er3anLZc=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:ad4:4b32:: with SMTP id
 s18mr447192qvw.16.1604532254675; Wed, 04 Nov 2020 15:24:14 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:43 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-7-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 06/18] Revert "driver core: fw_devlink: Add support for
 batching fwnode parsing"
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit 716a7a25969003d82ab738179c3f1068a120ed11.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h    |   1 -
 drivers/base/core.c    | 116 +++--------------------------------------
 drivers/base/dd.c      |   8 ---
 include/linux/fwnode.h |   2 -
 4 files changed, 7 insertions(+), 120 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index c3562adf4789..91cfb8405abd 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -156,7 +156,6 @@ extern char *make_class_name(const char *name, struct kobject *kobj);
 extern int devres_release_all(struct device *dev);
 extern void device_block_probing(void);
 extern void device_unblock_probing(void);
-extern void driver_deferred_probe_force_trigger(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6745375a8bb9..31a76159f118 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -50,9 +50,6 @@ static LIST_HEAD(wait_for_suppliers);
 static DEFINE_MUTEX(wfs_lock);
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
-static unsigned int defer_fw_devlink_count;
-static DEFINE_MUTEX(defer_fw_devlink_lock);
-static bool fw_devlink_is_permissive(void);
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
@@ -758,7 +755,7 @@ static void device_link_add_missing_supplier_links(void)
 		int ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
 		if (!ret)
 			list_del_init(&dev->links.needs_suppliers);
-		else if (ret != -ENODEV || fw_devlink_is_permissive())
+		else if (ret != -ENODEV)
 			dev->links.need_for_probe = false;
 	}
 	mutex_unlock(&wfs_lock);
@@ -1444,116 +1441,17 @@ static void fw_devlink_link_device(struct device *dev)
 {
 	int fw_ret;
 
-	if (!fw_devlink_flags)
-		return;
-
-	mutex_lock(&defer_fw_devlink_lock);
-	if (!defer_fw_devlink_count)
-		device_link_add_missing_supplier_links();
-
-	/*
-	 * The device's fwnode not having add_links() doesn't affect if other
-	 * consumers can find this device as a supplier.  So, this check is
-	 * intentionally placed after device_link_add_missing_supplier_links().
-	 */
-	if (!fwnode_has_op(dev->fwnode, add_links))
-		goto out;
+	device_link_add_missing_supplier_links();
 
-	/*
-	 * If fw_devlink is being deferred, assume all devices have mandatory
-	 * suppliers they need to link to later. Then, when the fw_devlink is
-	 * resumed, all these devices will get a chance to try and link to any
-	 * suppliers they have.
-	 */
-	if (!defer_fw_devlink_count) {
+	if (fw_devlink_flags && fwnode_has_op(dev->fwnode, add_links)) {
 		fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
-		if (fw_ret == -ENODEV && fw_devlink_is_permissive())
-			fw_ret = -EAGAIN;
-	} else {
-		fw_ret = -ENODEV;
+		if (fw_ret == -ENODEV && !fw_devlink_is_permissive())
+			device_link_wait_for_mandatory_supplier(dev);
+		else if (fw_ret)
+			device_link_wait_for_optional_supplier(dev);
 	}
-
-	if (fw_ret == -ENODEV)
-		device_link_wait_for_mandatory_supplier(dev);
-	else if (fw_ret)
-		device_link_wait_for_optional_supplier(dev);
-
-out:
-	mutex_unlock(&defer_fw_devlink_lock);
 }
 
-/**
- * fw_devlink_pause - Pause parsing of fwnode to create device links
- *
- * Calling this function defers any fwnode parsing to create device links until
- * fw_devlink_resume() is called. Both these functions are ref counted and the
- * caller needs to match the calls.
- *
- * While fw_devlink is paused:
- * - Any device that is added won't have its fwnode parsed to create device
- *   links.
- * - The probe of the device will also be deferred during this period.
- * - Any devices that were already added, but waiting for suppliers won't be
- *   able to link to newly added devices.
- *
- * Once fw_devlink_resume():
- * - All the fwnodes that was not parsed will be parsed.
- * - All the devices that were deferred probing will be reattempted if they
- *   aren't waiting for any more suppliers.
- *
- * This pair of functions, is mainly meant to optimize the parsing of fwnodes
- * when a lot of devices that need to link to each other are added in a short
- * interval of time. For example, adding all the top level devices in a system.
- *
- * For example, if N devices are added and:
- * - All the consumers are added before their suppliers
- * - All the suppliers of the N devices are part of the N devices
- *
- * Then:
- *
- * - With the use of fw_devlink_pause() and fw_devlink_resume(), each device
- *   will only need one parsing of its fwnode because it is guaranteed to find
- *   all the supplier devices already registered and ready to link to. It won't
- *   have to do another pass later to find one or more suppliers it couldn't
- *   find in the first parse of the fwnode. So, we'll only need O(N) fwnode
- *   parses.
- *
- * - Without the use of fw_devlink_pause() and fw_devlink_resume(), we would
- *   end up doing O(N^2) parses of fwnodes because every device that's added is
- *   guaranteed to trigger a parse of the fwnode of every device added before
- *   it. This O(N^2) parse is made worse by the fact that when a fwnode of a
- *   device is parsed, all it descendant devices might need to have their
- *   fwnodes parsed too (even if the devices themselves aren't added).
- */
-void fw_devlink_pause(void)
-{
-	mutex_lock(&defer_fw_devlink_lock);
-	defer_fw_devlink_count++;
-	mutex_unlock(&defer_fw_devlink_lock);
-}
-
-/** fw_devlink_resume - Resume parsing of fwnode to create device links
- *
- * This function is used in conjunction with fw_devlink_pause() and is ref
- * counted. See documentation for fw_devlink_pause() for more details.
- */
-void fw_devlink_resume(void)
-{
-	mutex_lock(&defer_fw_devlink_lock);
-	if (!defer_fw_devlink_count) {
-		WARN(true, "Unmatched fw_devlink pause/resume!");
-		goto out;
-	}
-
-	defer_fw_devlink_count--;
-	if (defer_fw_devlink_count)
-		goto out;
-
-	device_link_add_missing_supplier_links();
-	driver_deferred_probe_force_trigger();
-out:
-	mutex_unlock(&defer_fw_devlink_lock);
-}
 /* Device links support end. */
 
 int (*platform_notify)(struct device *dev) = NULL;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index ec67b5ffa06d..b42229b74fd6 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -163,14 +163,6 @@ static bool driver_deferred_probe_enable = false;
  * again.
  */
 static void driver_deferred_probe_trigger(void)
-{
-	if (!driver_deferred_probe_enable)
-		return;
-
-	driver_deferred_probe_force_trigger();
-}
-
-void driver_deferred_probe_force_trigger(void)
 {
 	if (!driver_deferred_probe_enable)
 		return;
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 9506f8ec0974..e0abafbb17f8 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -171,7 +171,5 @@ struct fwnode_operations {
 #define get_dev_from_fwnode(fwnode)	get_device((fwnode)->dev)
 
 extern u32 fw_devlink_get_flags(void);
-void fw_devlink_pause(void);
-void fw_devlink_resume(void);
 
 #endif
-- 
2.29.1.341.ge80a0c044ae-goog

