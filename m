Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BA568CC23
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Feb 2023 02:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBGBnU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 20:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBGBmv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 20:42:51 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC726360BD
        for <linux-acpi@vger.kernel.org>; Mon,  6 Feb 2023 17:42:30 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id qb3-20020a17090b280300b002307b2547b5so135759pjb.1
        for <linux-acpi@vger.kernel.org>; Mon, 06 Feb 2023 17:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JGHkdwcUfLjfQ2SnsdEOolH8s6ejvGtumPkNayiDgT8=;
        b=cmJIPfjh2AT7clgu/AcVdJaljQV0PRWLl0KlermC6ZkWT+Ktm1K8V1Irljae7Bq8Fd
         GbMsUz601iHCeLXt4v0Rnf+ruid/MJUPH3GyDn0qe5TYc01L/zU3AL0CiSXNq1mNWjTP
         qE08lD8A69+o55t4ttKFQVGkWdLDRR8RChew8VuR1jgPsH29lSPfBKrH1qLMmzlD69Rx
         RerElbokUWXmYixLrXoTaVym2o+myHxz/3QHu0Xwx3AQe5+HEcLgMIGCNNDKIwLCqPXY
         y2wwvn6c/RMBhyRh+SXPpusHhU9Q8LtVjjKcpVYhLKb5nc+g+TuZKIzFEEnmrOG2qcUI
         9knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGHkdwcUfLjfQ2SnsdEOolH8s6ejvGtumPkNayiDgT8=;
        b=u+nB1pd4sG69PiTkI6QBD/GqQ8KVQd5+mJ5Mo6Y3X4/IE1AKWohRYECcjhxqtRMtPd
         glEcqgYYIMGxJyutth8MnGEsxqbcF4Yii89sXR6ev7NUTPjjZn6czBH4JP7jFSB7ccgj
         kjQK6wip6o9HnRx1L/VXkwPSDTDoVKZS2i/DfIxMM4N/a7nVgCoTxsgvvDwNnrjJRPoT
         oH6563jNPQ1nQC8FmI6jdG8T7CxrfKjVpxVCor7GepUoTa5o00iqO0ulWilmESpsYFRr
         fLJnsDPq0IDNdy/ZL7uVtQgjfG6QImx6PN8C1hnRD3PlICtNzBWCns+mgjilUzwPZ4Hu
         seOw==
X-Gm-Message-State: AO0yUKVPiuD0+Z5pZuoM/mS5PxJPNOkQH1Leh6xGQ7UUe7A4tRFiHSte
        CpKA/jXOAlp9I4ITn8ORRgqhm4dm4lbFxMM=
X-Google-Smtp-Source: AK7set+tPnBqk0Wq06gNiBk48vsYJFP2q19C+ua9C9YCIEMT4/WAsanOpJamvGVlOlVgWMjXunH03PJr6mwa1NE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a17:90a:55c7:b0:230:9d6c:5e96 with SMTP
 id o7-20020a17090a55c700b002309d6c5e96mr425362pjm.100.1675734149506; Mon, 06
 Feb 2023 17:42:29 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:41:59 -0800
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
Message-Id: <20230207014207.1678715-8-saravanak@google.com>
Mime-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 07/12] driver core: fw_devlink: Consolidate device link
 flag computation
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=" <rafal@milecki.pl>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Consolidate the code that computes the flags to be used when creating a
device link from a fwnode link.

Fixes: 2de9d8e0d2fe ("driver core: fw_devlink: Improve handling of cyclic dependencies")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/core.c    | 28 +++++++++++++++-------------
 include/linux/fwnode.h |  1 -
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4869b6fdfeaf..e4b60436a4a4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1727,8 +1727,11 @@ static int __init fw_devlink_strict_setup(char *arg)
 }
 early_param("fw_devlink.strict", fw_devlink_strict_setup);
 
-u32 fw_devlink_get_flags(void)
+static inline u32 fw_devlink_get_flags(u8 fwlink_flags)
 {
+	if (fwlink_flags & FWLINK_FLAG_CYCLE)
+		return FW_DEVLINK_FLAGS_PERMISSIVE | DL_FLAG_CYCLE;
+
 	return fw_devlink_flags;
 }
 
@@ -1938,7 +1941,7 @@ static bool fwnode_ancestor_init_without_drv(struct fwnode_handle *fwnode)
  * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
  * @con: consumer device for the device link
  * @sup_handle: fwnode handle of supplier
- * @flags: devlink flags
+ * @link: fwnode link that's being converted to a device link
  *
  * This function will try to create a device link between the consumer device
  * @con and the supplier device represented by @sup_handle.
@@ -1955,10 +1958,17 @@ static bool fwnode_ancestor_init_without_drv(struct fwnode_handle *fwnode)
  *  possible to do that in the future
  */
 static int fw_devlink_create_devlink(struct device *con,
-				     struct fwnode_handle *sup_handle, u32 flags)
+				     struct fwnode_handle *sup_handle,
+				     struct fwnode_link *link)
 {
 	struct device *sup_dev;
 	int ret = 0;
+	u32 flags;
+
+	if (con->fwnode == link->consumer)
+		flags = fw_devlink_get_flags(link->flags);
+	else
+		flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 
 	/*
 	 * In some cases, a device P might also be a supplier to its child node
@@ -2091,7 +2101,6 @@ static void __fw_devlink_link_to_consumers(struct device *dev)
 	struct fwnode_link *link, *tmp;
 
 	list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook) {
-		u32 dl_flags = fw_devlink_get_flags();
 		struct device *con_dev;
 		bool own_link = true;
 		int ret;
@@ -2121,14 +2130,13 @@ static void __fw_devlink_link_to_consumers(struct device *dev)
 				con_dev = NULL;
 			} else {
 				own_link = false;
-				dl_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 			}
 		}
 
 		if (!con_dev)
 			continue;
 
-		ret = fw_devlink_create_devlink(con_dev, fwnode, dl_flags);
+		ret = fw_devlink_create_devlink(con_dev, fwnode, link);
 		put_device(con_dev);
 		if (!own_link || ret == -EAGAIN)
 			continue;
@@ -2169,19 +2177,13 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
 	bool own_link = (dev->fwnode == fwnode);
 	struct fwnode_link *link, *tmp;
 	struct fwnode_handle *child = NULL;
-	u32 dl_flags;
-
-	if (own_link)
-		dl_flags = fw_devlink_get_flags();
-	else
-		dl_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 
 	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
 		int ret;
 		struct device *sup_dev;
 		struct fwnode_handle *sup = link->supplier;
 
-		ret = fw_devlink_create_devlink(dev, sup, dl_flags);
+		ret = fw_devlink_create_devlink(dev, sup, link);
 		if (!own_link || ret == -EAGAIN)
 			continue;
 
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index fdf2ee0285b7..5700451b300f 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -207,7 +207,6 @@ static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
 		fwnode->flags &= ~FWNODE_FLAG_INITIALIZED;
 }
 
-extern u32 fw_devlink_get_flags(void);
 extern bool fw_devlink_is_strict(void);
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
 void fwnode_links_purge(struct fwnode_handle *fwnode);
-- 
2.39.1.519.gcb327c4b5f-goog

