Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168F9310030
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 23:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhBDWkK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 17:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhBDWkJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 17:40:09 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC89C0617A9
        for <linux-acpi@vger.kernel.org>; Thu,  4 Feb 2021 14:39:28 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id f5so3774819qtf.15
        for <linux-acpi@vger.kernel.org>; Thu, 04 Feb 2021 14:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=58Q92i4qhAAZTYBbk8UC1mmmTkThlWpH1fHFDUtPMuM=;
        b=euGAzslFXlbXVGiKL4nhk1Q3eNfg/xIlvg3MNxWZglXy0l/XNlmEKbPoQOPny89Rnu
         VHSsxEtvQzzkUSk+y0N8TUyncyHpoIXLoTsUcZTXng3m9IMZ1gHMV/PPyNjR8O84I4tH
         pf+HWg+hzsUH1NuugKSzWYwMbV/Dzwg8AXydTx1r/VCrRagfMgr+1QxTOpS7O7Bi6NyL
         un+XbQbh9AGCMcj0b7jV9R+X3KsJOfhga0oZEfTS6Bwb/A6ZvHb7/VkrJffbKbKykDsT
         L+CLjoVhjJCbW7m/MbpXvriyV10s4xdRt+K9GXF4vB+pEGkNLj/B39BFDuYM60qdykjz
         pXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=58Q92i4qhAAZTYBbk8UC1mmmTkThlWpH1fHFDUtPMuM=;
        b=CnWicqHjHpByNz9AmNfLu4ZgQHoUtjbTBRg0yJWyeZKQfuAsiSDdzz4Rta/l/oIWt/
         8aq/QX1Dlp5gaEcSyoIHUhRKmds9PVNjQFsO81KCnEnxadjHtmP2xJDkauFRlDc9MKNv
         8/rmGeTdV0zTE82jfkdn/4gkU/JsVGEgg40Su/ZVIfC4QGii+awoSYBkYKJ3QjwFd/F7
         7T/FpYD6haCCeOwKWMErNKZjpDMuvk7METpSoP0n2Gt3xRWt0cG8fNqNelwCVcVlFeZ7
         0gP8psbyFsv2oDAFdfNOHAyoikyrPR28ApzqefBhRLkBEd/0gUlFayMJrplL0rhbxLrv
         ELHg==
X-Gm-Message-State: AOAM530etJaVccBMTizhd5efH3iTz9dRn+8wT5rup0y2D/2swjz5vgrF
        NKT/2iB7WkJRJlhfGnD3A7mljnbBHV33bWs=
X-Google-Smtp-Source: ABdhPJyxupvoFcIfn7LkQf7okwYnUiD48Y4PFWbc4IZvT5ysgPT3kDUrc+h3fQQ4xTLjSywFcy/7gtG/YZuSLo4=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:8475:2f1d:e8b4:f65a])
 (user=saravanak job=sendgmr) by 2002:ad4:5a48:: with SMTP id
 ej8mr1537016qvb.41.1612478368174; Thu, 04 Feb 2021 14:39:28 -0800 (PST)
Date:   Thu,  4 Feb 2021 14:39:18 -0800
In-Reply-To: <20210204223921.1693487-1-saravanak@google.com>
Message-Id: <20210204223921.1693487-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210204223921.1693487-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 1/4] driver core: fw_devlink: Detect supplier devices that
 will never be added
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Martin Kaiser <martin@kaiser.cx>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

During the initial parsing of firmware by fw_devlink, fw_devlink might
infer that some supplier firmware nodes would get populated as devices.
But the inference is not always correct. This patch tries to logically
detect and fix such mistakes as boot progresses or more devices probe.

fw_devlink makes a fundamental assumption that once a device binds to a
driver, it will populate (i.e: add as struct devices) all the child
firmware nodes that could be populated as devices (if they aren't
populated already).

So, whenever a device probes, we check all its child firmware nodes. If
a child firmware node has a corresponding device populated, we don't
modify the child node or its descendants. However, if a child firmware
node has not been populated as a device, we delete all the fwnode links
where the child node or its descendants are suppliers. This ensures that
no other device is blocked on a firmware node that will never be
populated as a device. We also mark such fwnodes as NOT_DEVICE, so that
no new fwnode links are created with these nodes as suppliers.

Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 drivers/base/core.c    | 31 ++++++++++++++++++++++++++++---
 include/linux/fwnode.h |  2 ++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 484a942884ba..c95b1daabac7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -148,6 +148,21 @@ void fwnode_links_purge(struct fwnode_handle *fwnode)
 	fwnode_links_purge_consumers(fwnode);
 }
 
+static void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *child;
+
+	/* Don't purge consumer links of an added child */
+	if (fwnode->dev)
+		return;
+
+	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_links_purge_consumers(fwnode);
+
+	fwnode_for_each_available_child_node(fwnode, child)
+		fw_devlink_purge_absent_suppliers(child);
+}
+
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
 DEFINE_STATIC_SRCU(device_links_srcu);
@@ -1154,12 +1169,22 @@ void device_links_driver_bound(struct device *dev)
 	LIST_HEAD(sync_list);
 
 	/*
-	 * If a device probes successfully, it's expected to have created all
+	 * If a device binds successfully, it's expected to have created all
 	 * the device links it needs to or make new device links as it needs
-	 * them. So, it no longer needs to wait on any suppliers.
+	 * them. So, fw_devlink no longer needs to create device links to any
+	 * of the device's suppliers.
+	 *
+	 * Also, if a child firmware node of this bound device is not added as
+	 * a device by now, assume it is never going to be added and make sure
+	 * other devices don't defer probe indefinitely by waiting for such a
+	 * child device.
 	 */
-	if (dev->fwnode && dev->fwnode->dev == dev)
+	if (dev->fwnode && dev->fwnode->dev == dev) {
+		struct fwnode_handle *child;
 		fwnode_links_purge_suppliers(dev->fwnode);
+		fwnode_for_each_available_child_node(dev->fwnode, child)
+			fw_devlink_purge_absent_suppliers(child);
+	}
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 
 	device_links_write_lock();
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index fde4ad97564c..21082f11473f 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -19,8 +19,10 @@ struct device;
  * fwnode link flags
  *
  * LINKS_ADDED: The fwnode has already be parsed to add fwnode links.
+ * NOT_DEVICE: The fwnode will never be populated as a struct device.
  */
 #define FWNODE_FLAG_LINKS_ADDED		BIT(0)
+#define FWNODE_FLAG_NOT_DEVICE		BIT(1)
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
-- 
2.30.0.365.g02bc693789-goog

