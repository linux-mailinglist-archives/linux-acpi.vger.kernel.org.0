Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A49167DA69
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jan 2023 01:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjA0AMe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Jan 2023 19:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjA0AMJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jan 2023 19:12:09 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903116F233
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2023 16:12:00 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5065604854eso38271067b3.16
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2023 16:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh9n3L4UWXrQbdrJTDPlIhqjDz/QZuPxqjZ+YtW27N0=;
        b=G74bBdDoqQx1KR6DetFf1YNIzkWjOP6KL9IYtrHgCD9G9wEHtFD8EHstSjKfFfmAqr
         ISbUHFRqJabuZmUKgRWorZBVgDKnmeTVicoLqVyrBGBDyL1uHflKB5UurzV3akEp7hGc
         ZzEZtL/4/PFdMQN/HBzKLb8xrv2f+zym4Ko1HtAzh8yr3h9Ld7VypXHbftepJqpZ9I8O
         smO+OU9xOD1wl4zX1koYAJCimGRWosLGdupFrEqM3gd+fa48FfcLoZ1xHiXRUAdGYV9d
         KyxSp2m/nOsiAXAOecWeZblw4YUbMhKslhw5nrxhWhAficedyi45ldmQitGGdUiB1axj
         75Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh9n3L4UWXrQbdrJTDPlIhqjDz/QZuPxqjZ+YtW27N0=;
        b=0AJG3Q+fn021GLABgJHC7P/K3f+j1js9HajqXeV6gQsnFQtnyuAmbjoN9OmoQwcOE7
         ZOBoO/zStDiPlNM2CL6mDg8aXk+OGZipdfqcq5b0a7J4Rj2MbXmcF4Gmah2hKq4ApsBH
         KwxcY+J2hVnpDY1zh86Lg0eBqrsPkJzIlC/wZsNsi9sguNSaku/LQGgStZ1cG7qYvpa3
         zkezzUwfhaw1JXvgr6ETGFgVF2WXETLZHRA7uvRsJpqUB9O/rluQThcmB/OXtr2Aj7QP
         sC7nHmg8w1/CGf62flTTGinVTd3oCa/wajbj4DMWhHp+kAYteVZhdNKKx+NlWN4OmWuX
         ubkA==
X-Gm-Message-State: AFqh2kqTTUkdMUX5YQ7OFwnJ2h3qhIO0oIywGr6R6FaIJv9zchdGmO7q
        Qopu8qcFHXumCGsU4qUZ3kmmV4DzYNfuS0E=
X-Google-Smtp-Source: AMrXdXuaVhwccOHhS4ypPKj9tT5Sjzx3zuPYcn3EAccfwv8JX4VjdqgQURic7wuQ8IQaDQjvs232A0OJlYM0/L4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:c3b4:8b1c:e3ee:3708])
 (user=saravanak job=sendgmr) by 2002:a81:40f:0:b0:4fd:870d:b6ce with SMTP id
 15-20020a81040f000000b004fd870db6cemr3050429ywe.318.1674778320247; Thu, 26
 Jan 2023 16:12:00 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:11:33 -0800
In-Reply-To: <20230127001141.407071-1-saravanak@google.com>
Message-Id: <20230127001141.407071-7-saravanak@google.com>
Mime-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v2 06/11] driver core: fw_devlink: Allow marking a fwnode link
 as being part of a cycle
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

To improve detection and handling of dependency cycles, we need to be
able to mark fwnode links as being part of cycles. fwnode links marked
as being part of a cycle should not block their consumers from probing.

Fixes: 2de9d8e0d2fe ("driver core: fw_devlink: Improve handling of cyclic dependencies")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 41 +++++++++++++++++++++++++++++++++++------
 include/linux/fwnode.h | 11 ++++++++++-
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e5390b09a02f..82b29e9070bf 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -126,6 +126,19 @@ static void __fwnode_link_del(struct fwnode_link *link)
 	kfree(link);
 }
 
+/**
+ * __fwnode_link_cycle - Mark a fwnode link as being part of a cycle.
+ * @link: the fwnode_link to be marked
+ *
+ * The fwnode_link_lock needs to be held when this function is called.
+ */
+static void __fwnode_link_cycle(struct fwnode_link *link)
+{
+	pr_debug("%pfwf: Relaxing link with %pfwf\n",
+		 link->consumer, link->supplier);
+	link->flags |= FWLINK_FLAG_CYCLE;
+}
+
 /**
  * fwnode_links_purge_suppliers - Delete all supplier links of fwnode_handle.
  * @fwnode: fwnode whose supplier links need to be deleted
@@ -1041,6 +1054,23 @@ static bool dev_is_best_effort(struct device *dev)
 		(dev->fwnode && (dev->fwnode->flags & FWNODE_FLAG_BEST_EFFORT));
 }
 
+static struct fwnode_handle *fwnode_links_check_suppliers(
+						struct fwnode_handle *fwnode)
+{
+	struct fwnode_link *link;
+
+	if (!fwnode || fw_devlink_is_permissive())
+		return NULL;
+
+	list_for_each_entry(link, &fwnode->suppliers, c_hook) {
+		if (link->flags & FWLINK_FLAG_CYCLE)
+			continue;
+		return link->supplier;
+	}
+
+	return NULL;
+}
+
 /**
  * device_links_check_suppliers - Check presence of supplier drivers.
  * @dev: Consumer device.
@@ -1068,11 +1098,8 @@ int device_links_check_suppliers(struct device *dev)
 	 * probe.
 	 */
 	mutex_lock(&fwnode_link_lock);
-	if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
-	    !fw_devlink_is_permissive()) {
-		sup_fw = list_first_entry(&dev->fwnode->suppliers,
-					  struct fwnode_link,
-					  c_hook)->supplier;
+	sup_fw = fwnode_links_check_suppliers(dev->fwnode);
+	if (sup_fw) {
 		if (!dev_is_best_effort(dev)) {
 			fwnode_ret = -EPROBE_DEFER;
 			dev_err_probe(dev, -EPROBE_DEFER,
@@ -1261,7 +1288,9 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
 	bool val;
 
 	device_lock(dev);
-	val = !list_empty(&dev->fwnode->suppliers);
+	mutex_lock(&fwnode_link_lock);
+	val = !!fwnode_links_check_suppliers(dev->fwnode);
+	mutex_unlock(&fwnode_link_lock);
 	device_unlock(dev);
 	return sysfs_emit(buf, "%u\n", val);
 }
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 89b9bdfca925..fdf2ee0285b7 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -18,7 +18,7 @@ struct fwnode_operations;
 struct device;
 
 /*
- * fwnode link flags
+ * fwnode flags
  *
  * LINKS_ADDED:	The fwnode has already be parsed to add fwnode links.
  * NOT_DEVICE:	The fwnode will never be populated as a struct device.
@@ -36,6 +36,7 @@ struct device;
 #define FWNODE_FLAG_INITIALIZED			BIT(2)
 #define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	BIT(3)
 #define FWNODE_FLAG_BEST_EFFORT			BIT(4)
+#define FWNODE_FLAG_VISITED			BIT(5)
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
@@ -46,11 +47,19 @@ struct fwnode_handle {
 	u8 flags;
 };
 
+/*
+ * fwnode link flags
+ *
+ * CYCLE:	The fwnode link is part of a cycle. Don't defer probe.
+ */
+#define FWLINK_FLAG_CYCLE			BIT(0)
+
 struct fwnode_link {
 	struct fwnode_handle *supplier;
 	struct list_head s_hook;
 	struct fwnode_handle *consumer;
 	struct list_head c_hook;
+	u8 flags;
 };
 
 /**
-- 
2.39.1.456.gfc5497dd1b-goog

