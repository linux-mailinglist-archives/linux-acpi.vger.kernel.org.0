Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BEC30B68C
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 05:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhBBEfL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 23:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhBBEfG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 23:35:06 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FEEC06178A
        for <linux-acpi@vger.kernel.org>; Mon,  1 Feb 2021 20:33:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w4so10643545ybc.7
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 20:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fSgRORThi3AA91PkRefUmvo52xoDuhhzbNgdJNcm8BQ=;
        b=aEX9NXcV8QEW4XVKUuhSyQsSbYFvnqTTdZ4c1y0Z6KG0Q/DdWLudlEjemR9SLkH9u5
         svzrnsEZ8EhRuGQHs1/ACl9y1myBW4Jfai/c1TKll6U/3DeKUAhK0W1RG5jApSQB3lNC
         pPbcTd8NsbxVJc7HKEYPN6OEwbMvrxprnysdFonYJ2/sMMvbXeiPOZY23yxoE7251oGb
         BbkXB07PmPjGtVHJPGqgNNfoVWlhNdZ2aiPTpaux981o4BGQBvZHJEIYKbGtXRJmxgev
         kG+MS4KLZ+Iux/96AJzn4AfdcQlQv6rwBWfk8OXt+j/1Qrfhu8r2+DD6VTisC7yKsnqn
         Ik6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fSgRORThi3AA91PkRefUmvo52xoDuhhzbNgdJNcm8BQ=;
        b=cvPNnBGNca7l//D38GDk47kTzZpTQGB3aqyIOpvMjzsh+ES9TX9V6PpLA9we/ruN98
         IXOU5fCdzRDODa0gyLBReeKWo7+xyccpw4O58B2sN6uCPozvpQMmfhvYwiBL1X4rvE89
         lmJ9DvMexYUKSJlmFmKAOVe9q+yFhFu+LLG2S5DSNJlnhKyMp5e9kgS01gB9R4DVl7ML
         eVzMHl0bCPw13l3k9n57NNag/8okYuHR0B+Ap1KS0CxROfKi26cRfkS4pTfilJ61KHew
         dhUTo5t+G+HsCqbNvAZ9EiYCuTTtnCV6sYThJqrAMs6TuwRwqumuGe2yfAImQad3wvaQ
         5UGQ==
X-Gm-Message-State: AOAM533XMZESLxxAdhWiamnGhuIa86AFQXGdP/OSM32cUUFTbWLhxFJM
        sTPTmjvBBXOmn8ytsLsMmY3SDx633Jr/qH4=
X-Google-Smtp-Source: ABdhPJyFG1Ia3x5SwBMx8tCTSeK0b66Tc8aeFpXD+/Uw4PFngSMbVCtmHjPwj1NFK+UCdFxD43+HG3zfrQ/+Yuw=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:ce4c:: with SMTP id
 x73mr24260093ybe.301.1612240430988; Mon, 01 Feb 2021 20:33:50 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:33:42 -0800
In-Reply-To: <20210202043345.3778765-1-saravanak@google.com>
Message-Id: <20210202043345.3778765-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 1/3] driver core: fw_devlink: Detect supplier devices that
 will never be added
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

