Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47842E7C10
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2019 23:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390617AbfJ1WAj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Oct 2019 18:00:39 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54515 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390598AbfJ1WAf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Oct 2019 18:00:35 -0400
Received: by mail-pl1-f202.google.com with SMTP id w20so4601536plq.21
        for <linux-acpi@vger.kernel.org>; Mon, 28 Oct 2019 15:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4QHSVay5xnRXtHE5UvaRBduaybl+NfL/s405bQv+ZSs=;
        b=rVKnRspyExHb8e5Iw2iaEe+VaNM0a27FmGCb/j8adH7C/raQq1v7DTY8KgptgoygG1
         isqPE8RM6IML89xrh6Zs4MapknKuvFF27v8AF7hreUksBIk6flf5/Xju9VhocBIPsFDn
         SMKLKMAehdFaiYogi8Dxud9Qz+VfGOuWVxuY9xXBBbn1q4bCeo3xDmc3K8jbU5nKzHcq
         P7qmPea3Mar5vxaDo3sDd7aOZYNptcn+royjFX5Dvkt8vaLcD/3i7RbLwtSFclyuAGYq
         y4XeOLJ1lLgBma2mpsVwwkRoWu3A1RZ9JQKPSlnXx48J1FKojrQRpyoPIT8Q1U7URlaG
         jZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4QHSVay5xnRXtHE5UvaRBduaybl+NfL/s405bQv+ZSs=;
        b=Neh3/jbB9Oxat/gNJKUm9Z0lz4ABNQnXZV4Y+k7I/+kOO+UgEVqPiavh5wiO4PnPA+
         CrAx4OQrYYwRuoUAbpq7U+fBKUoR4E8doQIlVZBhamwifxJ8dv6bVGloHwozlOspnzLY
         US/4jjyHnqdmHBK3Ef2B/oiLFd9olconkVvQzMRhi1hmTcP5SIYrZ35Xgc5jcnRP9i/u
         3TujWynfSJHPwETPXSN6KTaSobhznM0aqQT57U6UmkN2DoTN5v+87PyVmsmRyqqPW6qc
         wNJOkA4/QF59daWS9VClDZCRoPry8O52kJKGKCdd1h1QkgMwAT3G8sZVwD3+PvJHJkoj
         QBXQ==
X-Gm-Message-State: APjAAAUguWichqRJU0/SED3HX2DLDGuo3y8P/qYCNGi5PeUI6Ak2MPPb
        3h8VfmwvxoAvoY/mbpJRJwzYWla5sIPv9mw=
X-Google-Smtp-Source: APXvYqxZs30NeDK+okF5Jb1rc311OynuujO07PZjWck7W6HzxalCldSjpZuRXpcks4sFZn8Chv2mPhsrw07fKR8=
X-Received: by 2002:a63:cd47:: with SMTP id a7mr22303385pgj.29.1572300034183;
 Mon, 28 Oct 2019 15:00:34 -0700 (PDT)
Date:   Mon, 28 Oct 2019 15:00:22 -0700
In-Reply-To: <20191028220027.251605-1-saravanak@google.com>
Message-Id: <20191028220027.251605-2-saravanak@google.com>
Mime-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v1 1/5] driver core: Add device link support for
 SYNC_STATE_ONLY flag
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Parent devices might need to create "proxy" device links from themselves
to supplier devices to make sure the supplier devices don't get a
sync_state() before the child consumer devices get a chance to add
device links to the supplier devices.

However, the parent device has no real dependency on the supplier device
and probing, suspend/resume or runtime PM don't need to be affected by
the supplier device.  To capture these cases, create a SYNC_STATE_ONLY
device link flag that only affects sync_state() behavior and doesn't
affect probing, suspend/resume or runtime PM.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 50 ++++++++++++++++++++++++++++++++++--------
 include/linux/device.h |  2 ++
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7ea665a97da2..17ed054c4132 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -131,6 +131,9 @@ static int device_is_dependent(struct device *dev, void *target)
 		return ret;
 
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
+		if (link->flags == (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
+			continue;
+
 		if (link->consumer == target)
 			return 1;
 
@@ -200,8 +203,11 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
 		device_pm_move_last(dev);
 
 	device_for_each_child(dev, NULL, device_reorder_to_tail);
-	list_for_each_entry(link, &dev->links.consumers, s_node)
+	list_for_each_entry(link, &dev->links.consumers, s_node) {
+		if (link->flags == (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
+			continue;
 		device_reorder_to_tail(link->consumer, NULL);
+	}
 
 	return 0;
 }
@@ -228,7 +234,8 @@ void device_pm_move_to_tail(struct device *dev)
 
 #define DL_MANAGED_LINK_FLAGS (DL_FLAG_AUTOREMOVE_CONSUMER | \
 			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
-			       DL_FLAG_AUTOPROBE_CONSUMER)
+			       DL_FLAG_AUTOPROBE_CONSUMER  | \
+			       DL_FLAG_SYNC_STATE_ONLY)
 
 #define DL_ADD_VALID_FLAGS (DL_MANAGED_LINK_FLAGS | DL_FLAG_STATELESS | \
 			    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
@@ -296,6 +303,8 @@ struct device_link *device_link_add(struct device *consumer,
 
 	if (!consumer || !supplier || flags & ~DL_ADD_VALID_FLAGS ||
 	    (flags & DL_FLAG_STATELESS && flags & DL_MANAGED_LINK_FLAGS) ||
+	    (flags & DL_FLAG_SYNC_STATE_ONLY &&
+	     flags != DL_FLAG_SYNC_STATE_ONLY) ||
 	    (flags & DL_FLAG_AUTOPROBE_CONSUMER &&
 	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
 		      DL_FLAG_AUTOREMOVE_SUPPLIER)))
@@ -316,11 +325,14 @@ struct device_link *device_link_add(struct device *consumer,
 
 	/*
 	 * If the supplier has not been fully registered yet or there is a
-	 * reverse dependency between the consumer and the supplier already in
-	 * the graph, return NULL.
+	 * reverse (non-SYNC_STATE_ONLY) dependency between the consumer and
+	 * the supplier already in the graph, return NULL. If the link is a
+	 * SYNC_STATE_ONLY link, we don't check for reverse dependencies
+	 * because it only affects sync_state() callbacks.
 	 */
 	if (!device_pm_initialized(supplier)
-	    || device_is_dependent(consumer, supplier)) {
+	    || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
+		  device_is_dependent(consumer, supplier))) {
 		link = NULL;
 		goto out;
 	}
@@ -347,9 +359,14 @@ struct device_link *device_link_add(struct device *consumer,
 		}
 
 		if (flags & DL_FLAG_STATELESS) {
-			link->flags |= DL_FLAG_STATELESS;
 			kref_get(&link->kref);
-			goto out;
+			if (link->flags & DL_FLAG_SYNC_STATE_ONLY &&
+			    !(link->flags & DL_FLAG_STATELESS)) {
+				link->flags |= DL_FLAG_STATELESS;
+				goto reorder;
+			} else {
+				goto out;
+			}
 		}
 
 		/*
@@ -371,6 +388,12 @@ struct device_link *device_link_add(struct device *consumer,
 			link->flags |= DL_FLAG_MANAGED;
 			device_link_init_status(link, consumer, supplier);
 		}
+		if (link->flags & DL_FLAG_SYNC_STATE_ONLY &&
+		    !(flags & DL_FLAG_SYNC_STATE_ONLY)) {
+			link->flags &= ~DL_FLAG_SYNC_STATE_ONLY;
+			goto reorder;
+		}
+
 		goto out;
 	}
 
@@ -410,6 +433,13 @@ struct device_link *device_link_add(struct device *consumer,
 	    flags & DL_FLAG_PM_RUNTIME)
 		pm_runtime_resume(supplier);
 
+	if (flags & DL_FLAG_SYNC_STATE_ONLY) {
+		dev_dbg(consumer,
+			"Linked as a sync state only consumer to %s\n",
+			dev_name(supplier));
+		goto out;
+	}
+reorder:
 	/*
 	 * Move the consumer and all of the devices depending on it to the end
 	 * of dpm_list and the devices_kset list.
@@ -635,7 +665,8 @@ int device_links_check_suppliers(struct device *dev)
 	device_links_write_lock();
 
 	list_for_each_entry(link, &dev->links.suppliers, c_node) {
-		if (!(link->flags & DL_FLAG_MANAGED))
+		if (!(link->flags & DL_FLAG_MANAGED) ||
+		    link->flags & DL_FLAG_SYNC_STATE_ONLY)
 			continue;
 
 		if (link->status != DL_STATE_AVAILABLE) {
@@ -949,7 +980,8 @@ void device_links_unbind_consumers(struct device *dev)
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
 		enum device_link_state status;
 
-		if (!(link->flags & DL_FLAG_MANAGED))
+		if (!(link->flags & DL_FLAG_MANAGED) ||
+		    link->flags & DL_FLAG_SYNC_STATE_ONLY)
 			continue;
 
 		status = link->status;
diff --git a/include/linux/device.h b/include/linux/device.h
index 9f2f2e169f95..f1f2aa0b19da 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1097,6 +1097,7 @@ enum device_link_state {
  * AUTOREMOVE_SUPPLIER: Remove the link automatically on supplier driver unbind.
  * AUTOPROBE_CONSUMER: Probe consumer driver automatically after supplier binds.
  * MANAGED: The core tracks presence of supplier/consumer drivers (internal).
+ * SYNC_STATE_ONLY: Link only affects sync_state() behavior.
  */
 #define DL_FLAG_STATELESS		BIT(0)
 #define DL_FLAG_AUTOREMOVE_CONSUMER	BIT(1)
@@ -1105,6 +1106,7 @@ enum device_link_state {
 #define DL_FLAG_AUTOREMOVE_SUPPLIER	BIT(4)
 #define DL_FLAG_AUTOPROBE_CONSUMER	BIT(5)
 #define DL_FLAG_MANAGED			BIT(6)
+#define DL_FLAG_SYNC_STATE_ONLY		BIT(7)
 
 /**
  * struct device_link - Device link representation.
-- 
2.24.0.rc0.303.g954a862665-goog

