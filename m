Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACCE30B68A
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 05:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhBBEfK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 23:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhBBEfG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 23:35:06 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E75CC06178B
        for <linux-acpi@vger.kernel.org>; Mon,  1 Feb 2021 20:33:54 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2so3686345pfa.17
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 20:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CgJfyfr5am1Q64/wCzhXTP3QCLCaZmhSlDrbg5QGO3I=;
        b=TARzRlSzsW15CUoVmpsSP3mjeyLxCOjaeQDw8PVAagBNB/45GwQ6wjurJeWnKP6Dzl
         jfN2OHOYmrvBcHBpyF9AE7Waao/UC7qLRBdsomclHPJUGeAcOUw8Hl8N5WZv6Pld49Vv
         fqG5PiRRpsRJWsEbc5U1TkDg+2jLDrgTnjj13SzAlI3wfcC4vUAm4EO7ESaSLVt8WMQV
         ESz6Ev1MYrwTvjhVTuMPzXY1+ySQYudvhR1JV0VEMC/P6hor0xFnMPutuhzhJiBF2MH0
         vz4Zig63OF81cf+NmMDKjrc5v2SihG0Nkaj9HTPhSV1+my4yLsy1fSiFV6A88BQn1wMx
         sBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CgJfyfr5am1Q64/wCzhXTP3QCLCaZmhSlDrbg5QGO3I=;
        b=sciqlUxEtKsV9ADVb/K5dr8vYnm4jVgxjyfdiPeb3Ckb+DhMRlhJrlj3m4/niVVP8J
         Z9D+y5mhapU7qeou6dstwdLFknVp5uXC5Xwu+wmKhztJ7Xny/dEnxEvAZr1i4frJ0oOv
         lw2kZcOt32kBtUznAXWovaDp9oxtAzXm0P5vvsZZySp7TuGJEp4G2UGa62IalvElBZBU
         JxKicIxk/l1F6uLzGX9/2c4pFEbYqw+GGY8VFp4TNAPi9MeUrMzwJCzy5V2v79x56vR1
         G43fOYV3+nWBU6JPNoVNxehMTCg/3IGc+OfOHpka4RFiAqWJI8xejj4bgC51IE6YFRCR
         P+7g==
X-Gm-Message-State: AOAM531VRWe4z6tO7h2cZ0weZxWL9LeqeV1UyhEZi7FbK0M2hWd1qqzH
        egQIOI5wdjXno9yEXl7swYhHcyFQGodGJOk=
X-Google-Smtp-Source: ABdhPJzVqsDXdmaWru36DHyVGEXZ+FwAIT0yoqHDvlGh4hrHIWs1CErEjcpnHWetB+vEJhwT3mAX5fO4PfK7gxE=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a17:90a:5513:: with SMTP id
 b19mr2247557pji.99.1612240433799; Mon, 01 Feb 2021 20:33:53 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:33:43 -0800
In-Reply-To: <20210202043345.3778765-1-saravanak@google.com>
Message-Id: <20210202043345.3778765-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 2/3] driver core: fw_devlink: Handle missing drivers for
 optional suppliers
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After a deferred probe attempt has exhaused all the devices that can be
bound, any device that remains unbound has one/both of these conditions
true:

(1) It is waiting on its supplier to bind
(2) It does not have a matching driver

So, to make fw_devlink=on more forgiving of missing drivers for optional
suppliers, after we've done a full deferred probe attempt, this patch
deletes all device links created by fw_devlink where the supplier hasn't
probed yet and the supplier itself is not waiting on any of its
suppliers. This allows consumers to probe during another deferred probe
attempt if they were waiting on optional suppliers.

When modules are enabled, we can't differentiate between a driver
that'll never be registered vs a driver that'll be registered soon by
loading a module. So, this patch doesn't do anything for the case where
modules are enabled.

Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h |   2 +
 drivers/base/core.c | 104 ++++++++++++++++++++++++++++++++++++--------
 drivers/base/dd.c   |   5 +++
 3 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index f5600a83124f..34befe9475cb 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -186,6 +186,8 @@ extern void device_links_no_driver(struct device *dev);
 extern bool device_links_busy(struct device *dev);
 extern void device_links_unbind_consumers(struct device *dev);
 
+bool fw_devlink_deferred_probe_retry(void);
+
 /* device pm support */
 void device_pm_move_to_tail(struct device *dev);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index c95b1daabac7..5e53fc6a21ea 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -50,6 +50,7 @@ static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
 static DEFINE_MUTEX(fwnode_link_lock);
 static bool fw_devlink_is_permissive(void);
+static bool fw_devlink_def_probe_retry;
 
 /**
  * fwnode_link_add - Create a link between two fwnode_handles.
@@ -881,6 +882,13 @@ static void device_link_put_kref(struct device_link *link)
 		WARN(1, "Unable to drop a managed device link reference\n");
 }
 
+static void device_link_drop_managed(struct device_link *link)
+{
+	link->flags &= ~DL_FLAG_MANAGED;
+	WRITE_ONCE(link->status, DL_STATE_NONE);
+	kref_put(&link->kref, __device_link_del);
+}
+
 /**
  * device_link_del - Delete a stateless link between two devices.
  * @link: Device link to delete.
@@ -943,6 +951,29 @@ static void device_links_missing_supplier(struct device *dev)
 	}
 }
 
+/**
+ * device_links_probe_blocked_by - Return first supplier blocking probe
+ * @dev: Consumer device.
+ *
+ * Checks if the probe of @dev is blocked by a supplier without a driver. If
+ * yes, return that supplier dev. Otherwise, return NULL.
+ */
+static struct device *device_links_probe_blocked_by(struct device *dev)
+{
+	struct device_link *link;
+
+	list_for_each_entry(link, &dev->links.suppliers, c_node) {
+		if (!(link->flags & DL_FLAG_MANAGED) ||
+		    link->flags & DL_FLAG_SYNC_STATE_ONLY)
+			continue;
+
+		if (link->status != DL_STATE_AVAILABLE)
+			return link->supplier;
+	}
+
+	return NULL;
+}
+
 /**
  * device_links_check_suppliers - Check presence of supplier drivers.
  * @dev: Consumer device.
@@ -961,7 +992,7 @@ static void device_links_missing_supplier(struct device *dev)
  */
 int device_links_check_suppliers(struct device *dev)
 {
-	struct device_link *link;
+	struct device_link *link, *tmp;
 	int ret = 0;
 
 	/*
@@ -982,19 +1013,47 @@ int device_links_check_suppliers(struct device *dev)
 
 	device_links_write_lock();
 
-	list_for_each_entry(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_safe(link, tmp, &dev->links.suppliers, c_node) {
 		if (!(link->flags & DL_FLAG_MANAGED))
 			continue;
 
-		if (link->status != DL_STATE_AVAILABLE &&
-		    !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
-			device_links_missing_supplier(dev);
-			dev_dbg(dev, "probe deferral - supplier %s not ready\n",
-				dev_name(link->supplier));
-			ret = -EPROBE_DEFER;
-			break;
+
+		if (link->status == DL_STATE_AVAILABLE ||
+		    link->flags & DL_FLAG_SYNC_STATE_ONLY) {
+			WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE);
+			continue;
+		}
+
+		/*
+		 * After a deferred probe attempt has exhaused all the devices
+		 * that can be bound, any device that remains unbound has
+		 * one/both of these conditions true:
+		 *
+		 * (1) It is waiting on its supplier to bind
+		 * (2) It does not have a matching driver
+		 *
+		 * If this device is waiting on a supplier to bind to a driver,
+		 * we make sure condition (1) above is not true for the
+		 * supplier. In which case, condition (2) has to be true for
+		 * the supplier. That is, the supplier doesn't have a matching
+		 * driver.
+		 *
+		 * When we find such a supplier, we delete the device link if
+		 * it was created by fw_devlink. This it to allow the consumer
+		 * to probe in case the supplier is an optional.
+		 */
+		if (fw_devlink_def_probe_retry &&
+		    link->flags & DL_FLAG_INFERRED &&
+		    !device_links_probe_blocked_by(link->supplier)) {
+			device_link_drop_managed(link);
+			continue;
 		}
-		WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE);
+
+		device_links_missing_supplier(dev);
+		dev_dbg(dev, "probe deferral - supplier %s not ready\n",
+			dev_name(link->supplier));
+		ret = -EPROBE_DEFER;
+		break;
 	}
 	dev->links.status = DL_DEV_PROBING;
 
@@ -1132,13 +1191,6 @@ static void __device_links_supplier_defer_sync(struct device *sup)
 		list_add_tail(&sup->links.defer_sync, &deferred_sync);
 }
 
-static void device_link_drop_managed(struct device_link *link)
-{
-	link->flags &= ~DL_FLAG_MANAGED;
-	WRITE_ONCE(link->status, DL_STATE_NONE);
-	kref_put(&link->kref, __device_link_del);
-}
-
 static ssize_t waiting_for_supplier_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -1597,6 +1649,24 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
 	return ret;
 }
 
+/** fw_devlink_deferred_probe_retry - Set up fw_devlink for probe retries
+ *
+ * This function requests fw_devlink to set itself up for a deferred probe
+ * retry. This allows fw_devlink to ignore device links it created to
+ * suppliers that'll never probe. This is necessary in case some of the
+ * suppliers are optional and their consumers can probe without them.
+ *
+ * Returns true if deferred probe retry is likely to make any difference.
+ */
+bool fw_devlink_deferred_probe_retry(void)
+{
+	if (IS_ENABLED(CONFIG_MODULES))
+		return false;
+
+	fw_devlink_def_probe_retry = true;
+	return fw_devlink_get_flags() && !fw_devlink_is_permissive();
+}
+
 /**
  * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
  * @con - Consumer device for the device link
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9179825ff646..11325df2327f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -317,6 +317,11 @@ static int deferred_probe_initcall(void)
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
 	flush_work(&deferred_probe_work);
+
+	if (fw_devlink_deferred_probe_retry()) {
+		driver_deferred_probe_trigger();
+		flush_work(&deferred_probe_work);
+	}
 	initcalls_done = true;
 
 	/*
-- 
2.30.0.365.g02bc693789-goog

