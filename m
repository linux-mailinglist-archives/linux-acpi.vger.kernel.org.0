Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B07CA949F
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 23:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfIDVLq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 17:11:46 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:56947 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbfIDVLp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Sep 2019 17:11:45 -0400
Received: by mail-qt1-f202.google.com with SMTP id m6so60062qtk.23
        for <linux-acpi@vger.kernel.org>; Wed, 04 Sep 2019 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=16o51+fRGAtBL1knYafYOFrACsjnlPcT58bue7EPSIc=;
        b=EtncdXs6xZksPOI9YvqtVg+R73USdHA5XxztdSm/lbDuhNyfKt5SEappQpRT7AuxMd
         XBZyQPhvM9bzFz/N2oijh/hRdJlBaFlZUlNeUshn65LyrALCGKDjWp2eOisSl97xSxOV
         7vDFm2WtZU9AYB7LeW9chQFpCl/0EnNyOsYC+7ocxB176V1XGc7Wsv85ULRjxFf1tuZv
         iQfMpaFH/5to3bGrQSjrC/srj4V7OJm25Nt6YCk8n6jAZBkZG9tfpnBjI9q6kXOqyjfj
         jKshDlgj+kJtIJ+TKYIR2GMRa4Qvel9i6dTglwWPixgMxwGb9WsU/Q3XylEaQtaUGAbq
         WUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=16o51+fRGAtBL1knYafYOFrACsjnlPcT58bue7EPSIc=;
        b=bxhABKH8eKroIDebBbK1oqxsYKRdBER2zx39dPzlkdgFrtPwCkB0fDZcbTpDJePOl2
         IJ/kLalnrGfQDiARFASp4WpUgqH6ZbLJQzrYkOA83kQ195F+TvsNi8xDKJD3JUqmR77O
         wxJxP/fT0DHTtgfz6r5EUjqCP/pbuqD/3XTB4xsrm8VPcRp1/yz5M026/mXV47G+wE9z
         WwlEiAXoVZ6g1zk9DGBRPANfNeqAnomGnb5haoqDH3YElvSV+9A2BNp/d2qaGevAIPhf
         tHTX9ve1mk1uyCc7TNQw8Cb10VaRAWPgt1Ck1dMnZWZxn2W4XV7J3cP6uyzXXd+ykxw7
         RdcQ==
X-Gm-Message-State: APjAAAUFiKwZ0HP2V49NRdZzD575KeKG2mW6KQLz5FitajJGlzMPylCc
        QYLAOVShSFryRL6r+ItOz+pJBnUxQp+zcjA=
X-Google-Smtp-Source: APXvYqxeYy0fVBxdj57QTyED9Vstu+M5eN0/UaBzsEvEaWPKrDzrCe5pkYhvfQiQLMEkh/SX2CCQMWrYE66rcUo=
X-Received: by 2002:a0c:b5c7:: with SMTP id o7mr6416568qvf.225.1567631504283;
 Wed, 04 Sep 2019 14:11:44 -0700 (PDT)
Date:   Wed,  4 Sep 2019 14:11:23 -0700
In-Reply-To: <20190904211126.47518-1-saravanak@google.com>
Message-Id: <20190904211126.47518-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190904211126.47518-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v11 4/6] driver core: Add sync_state driver/bus callback
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, clang-built-linux@googlegroups.com,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com, kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This sync_state driver/bus callback is called once all the consumers
of a supplier have probed successfully.

This allows the supplier device's driver/bus to sync the supplier
device's state to the software state with the guarantee that all the
consumers are actively managing the resources provided by the supplier
device.

To maintain backwards compatibility and ease transition from existing
frameworks and resource cleanup schemes, late_initcall_sync is the
earliest when the sync_state callback might be called.

There is no upper bound on the time by which the sync_state callback
has to be called. This is because if a consumer device never probes,
the supplier has to maintain its resources in the state left by the
bootloader. For example, if the bootloader leaves the display
backlight at a fixed voltage and the backlight driver is never probed,
you don't want the backlight to ever be turned off after boot up.

Also, when multiple devices are added after kernel init, some
suppliers could be added before their consumer devices get added. In
these instances, the supplier devices could get their sync_state
callback called right after they probe because the consumers devices
haven't had a chance to create device links to the suppliers.

To handle this correctly, this change also provides APIs to
pause/resume sync state callbacks so that when multiple devices are
added, their sync_state callback evaluation can be postponed to happen
after all of them are added.

kbuild test robot reported missing documentation for device.state_synced
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 72 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h | 24 ++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b3896da73b3d..acbf0b1414ab 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -46,6 +46,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 /* Device links support. */
 static LIST_HEAD(wait_for_suppliers);
 static DEFINE_MUTEX(wfs_lock);
+static LIST_HEAD(deferred_sync);
+static unsigned int defer_sync_state_count = 1;
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
@@ -648,6 +650,69 @@ int device_links_check_suppliers(struct device *dev)
 	return ret;
 }
 
+static void __device_links_supplier_sync_state(struct device *dev)
+{
+	struct device_link *link;
+
+	if (dev->state_synced)
+		return;
+
+	list_for_each_entry(link, &dev->links.consumers, s_node) {
+		if (!(link->flags & DL_FLAG_MANAGED))
+			continue;
+		if (link->status != DL_STATE_ACTIVE)
+			return;
+	}
+
+	if (dev->bus->sync_state)
+		dev->bus->sync_state(dev);
+	else if (dev->driver && dev->driver->sync_state)
+		dev->driver->sync_state(dev);
+
+	dev->state_synced = true;
+}
+
+void device_links_supplier_sync_state_pause(void)
+{
+	device_links_write_lock();
+	defer_sync_state_count++;
+	device_links_write_unlock();
+}
+
+void device_links_supplier_sync_state_resume(void)
+{
+	struct device *dev, *tmp;
+
+	device_links_write_lock();
+	if (!defer_sync_state_count) {
+		WARN(true, "Unmatched sync_state pause/resume!");
+		goto out;
+	}
+	defer_sync_state_count--;
+	if (defer_sync_state_count)
+		goto out;
+
+	list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_sync) {
+		__device_links_supplier_sync_state(dev);
+		list_del_init(&dev->links.defer_sync);
+	}
+out:
+	device_links_write_unlock();
+}
+
+static int sync_state_resume_initcall(void)
+{
+	device_links_supplier_sync_state_resume();
+	return 0;
+}
+late_initcall(sync_state_resume_initcall);
+
+static void __device_links_supplier_defer_sync(struct device *sup)
+{
+	if (list_empty(&sup->links.defer_sync))
+		list_add_tail(&sup->links.defer_sync, &deferred_sync);
+}
+
 /**
  * device_links_driver_bound - Update device links after probing its driver.
  * @dev: Device to update the links for.
@@ -692,6 +757,11 @@ void device_links_driver_bound(struct device *dev)
 
 		WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
 		WRITE_ONCE(link->status, DL_STATE_ACTIVE);
+
+		if (defer_sync_state_count)
+			__device_links_supplier_defer_sync(link->supplier);
+		else
+			__device_links_supplier_sync_state(link->supplier);
 	}
 
 	dev->links.status = DL_DEV_DRIVER_BOUND;
@@ -808,6 +878,7 @@ void device_links_driver_cleanup(struct device *dev)
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
 	}
 
+	list_del_init(&dev->links.defer_sync);
 	__device_links_no_driver(dev);
 
 	device_links_write_unlock();
@@ -1782,6 +1853,7 @@ void device_initialize(struct device *dev)
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
 	INIT_LIST_HEAD(&dev->links.needs_suppliers);
+	INIT_LIST_HEAD(&dev->links.defer_sync);
 	dev->links.status = DL_DEV_NO_DRIVER;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
diff --git a/include/linux/device.h b/include/linux/device.h
index 968316bb3bd1..9f2f2e169f95 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -81,6 +81,13 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  *		that generate uevents to add the environment variables.
  * @probe:	Called when a new device or driver add to this bus, and callback
  *		the specific driver's probe to initial the matched device.
+ * @sync_state:	Called to sync device state to software state after all the
+ *		state tracking consumers linked to this device (present at
+ *		the time of late_initcall) have successfully bound to a
+ *		driver. If the device has no consumers, this function will
+ *		be called at late_initcall_sync level. If the device has
+ *		consumers that are never bound to a driver, this function
+ *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
  *
@@ -124,6 +131,7 @@ struct bus_type {
 	int (*match)(struct device *dev, struct device_driver *drv);
 	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
 	int (*probe)(struct device *dev);
+	void (*sync_state)(struct device *dev);
 	int (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
 
@@ -341,6 +349,13 @@ enum probe_type {
  * @probe:	Called to query the existence of a specific device,
  *		whether this driver can work with it, and bind the driver
  *		to a specific device.
+ * @sync_state:	Called to sync device state to software state after all the
+ *		state tracking consumers linked to this device (present at
+ *		the time of late_initcall) have successfully bound to a
+ *		driver. If the device has no consumers, this function will
+ *		be called at late_initcall_sync level. If the device has
+ *		consumers that are never bound to a driver, this function
+ *		will never get called until they do.
  * @remove:	Called when the device is removed from the system to
  *		unbind a device from this driver.
  * @shutdown:	Called at shut-down time to quiesce the device.
@@ -380,6 +395,7 @@ struct device_driver {
 	const struct acpi_device_id	*acpi_match_table;
 
 	int (*probe) (struct device *dev);
+	void (*sync_state)(struct device *dev);
 	int (*remove) (struct device *dev);
 	void (*shutdown) (struct device *dev);
 	int (*suspend) (struct device *dev, pm_message_t state);
@@ -1137,12 +1153,14 @@ enum dl_dev_state {
  * @suppliers: List of links to supplier devices.
  * @consumers: List of links to consumer devices.
  * @needs_suppliers: Hook to global list of devices waiting for suppliers.
+ * @defer_sync: Hook to global list of devices that have deferred sync_state.
  * @status: Driver status information.
  */
 struct dev_links_info {
 	struct list_head suppliers;
 	struct list_head consumers;
 	struct list_head needs_suppliers;
+	struct list_head defer_sync;
 	enum dl_dev_state status;
 };
 
@@ -1218,6 +1236,9 @@ struct dev_links_info {
  * @offline:	Set after successful invocation of bus type's .offline().
  * @of_node_reused: Set if the device-tree node is shared with an ancestor
  *              device.
+ * @state_synced: The hardware state of this device has been synced to match
+ *		  the software state of this device by calling the driver/bus
+ *		  sync_state() callback.
  * @dma_coherent: this particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
  *
@@ -1314,6 +1335,7 @@ struct device {
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
+	bool			state_synced:1;
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
@@ -1656,6 +1678,8 @@ struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
+void device_links_supplier_sync_state_pause(void);
+void device_links_supplier_sync_state_resume(void);
 
 #ifdef CONFIG_DEVICE_NOTIFICATIONS
 extern void post_device_notification(struct watch_notification *n, u64 id);
-- 
2.23.0.187.g17f5b7556c-goog

