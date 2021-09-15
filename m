Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784D040C173
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Sep 2021 10:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhIOINr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Sep 2021 04:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbhIOINU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Sep 2021 04:13:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC24EC061574
        for <linux-acpi@vger.kernel.org>; Wed, 15 Sep 2021 01:11:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i77-20020a25d150000000b005b1d20152b0so2594788ybg.14
        for <linux-acpi@vger.kernel.org>; Wed, 15 Sep 2021 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XikR/WOyJ2plSXMfR/Ef32dJfmo7/8orGj4hh35u364=;
        b=TuHTGT5MNcDdeMBfWhtm4T/pyh3m+EAo8jpD6ijC3MxuXQlqpvD80rQJf52X5NiEs7
         FjEDDkXki6rhLTfnJeJEbHdg5+XEVSPO+XEFq6kW87922I0XxniRk9eGw1n6wCmSp1rN
         j6G0QceBDMDZzsW9fWpuWhEToW062Udv9V+RL2NFPmDCYwWb1J4UF7H2+acTk4U2y49P
         FaqOPkiX4kQ+Gg4MJUxoBvoihMaJKUx9Wd8d0jlpACi7By0kUVM+ObbAOwi4RBLAqo7x
         LW41dQN59e1nvGG/34DjLju2N+Rn345HadSQW+6SXqG+Kt5l5P++sWACZZw71Dj5s8Gi
         I/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XikR/WOyJ2plSXMfR/Ef32dJfmo7/8orGj4hh35u364=;
        b=j1lcJ+za1IG+nlYFVfypI6XvuVAD2bBg5LZDKNFSwPVcIyJ39KdgGEQSqUsAe4OZy5
         sjSNjAYYZAtkI/cS+unUjlWAhrXLwFRUlz8CNL+3jndG4cxIRCVzuMs0U31nNs2f5U7F
         4Oa6lLWbOcqY40F/GZkLqC5tz6VAbzo59dV1tuUhT8KZ/mNH8w40JaoxCMygmC9mnF1x
         j+kRYwNVqhUxXKtf52zzlv9YXHLemXftkRfpaeMi4QAnoHmLqrUs4BmVRbcGPv1cHtTZ
         1dOpIpUGaHuaOJ72IRusenWdc5FlUz0eUrIvfnabWGMhNdOlzeiXsxxy7yQRlEPeMwDX
         Cuew==
X-Gm-Message-State: AOAM532Smp8ZV1q2zk1RWzwt3oDIg70cNwtdd308npX5so6TR/jMCGlv
        dPPnsANuNidHgd82DL3SzrI/UfuG1MErw4c=
X-Google-Smtp-Source: ABdhPJy5AxcNM2TqizAS8drKUPgZ4XQI+j5Lt62BcdTxiW35unksixbmoua3iA7KZ+GXHA9w8WG4ySlrigtnNDE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:16d1:ab0e:fc4a:b9b1])
 (user=saravanak job=sendgmr) by 2002:a25:cac3:: with SMTP id
 a186mr4869148ybg.370.1631693517036; Wed, 15 Sep 2021 01:11:57 -0700 (PDT)
Date:   Wed, 15 Sep 2021 01:11:37 -0700
In-Reply-To: <20210915081139.480263-1-saravanak@google.com>
Message-Id: <20210915081139.480263-6-saravanak@google.com>
Mime-Version: 1.0
References: <20210915081139.480263-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 5/6] driver core: fw_devlink: Add support for FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If a parent device is also a supplier to a child device, fw_devlink=on by
design delays the probe() of the child device until the probe() of the
parent finishes successfully.

However, some drivers of such parent devices (where parent is also a
supplier) expect the child device to finish probing successfully as soon as
they are added using device_add() and before the probe() of the parent
device has completed successfully. One example of such a case is discussed
in the link mentioned below.

Add a flag to make fw_devlink=on not enforce these supplier-consumer
relationships, so these drivers can continue working.

Link: https://lore.kernel.org/netdev/CAGETcx_uj0V4DChME-gy5HGKTYnxLBX=TH2rag29f_p=UcG+Tg@mail.gmail.com/
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 19 +++++++++++++++++++
 include/linux/fwnode.h | 11 ++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f06e8e2dc69b..15986cc2fe5e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1736,6 +1736,25 @@ static int fw_devlink_create_devlink(struct device *con,
 	struct device *sup_dev;
 	int ret = 0;
 
+	/*
+	 * In some cases, a device P might also be a supplier to its child node
+	 * C. However, this would defer the probe of C until the probe of P
+	 * completes successfully. This is perfectly fine in the device driver
+	 * model. device_add() doesn't guarantee probe completion of the device
+	 * by the time it returns.
+	 *
+	 * However, there are a few drivers that assume C will finish probing
+	 * as soon as it's added and before P finishes probing. So, we provide
+	 * a flag to let fw_devlink know not to delay the probe of C until the
+	 * probe of P completes successfully.
+	 *
+	 * When such a flag is set, we can't create device links where P is the
+	 * supplier of C as that would delay the probe of C.
+	 */
+	if (sup_handle->flags & FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD &&
+	    fwnode_is_ancestor_of(sup_handle, con->fwnode))
+		return -EINVAL;
+
 	sup_dev = get_dev_from_fwnode(sup_handle);
 	if (sup_dev) {
 		/*
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 59828516ebaf..9f4ad719bfe3 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -22,10 +22,15 @@ struct device;
  * LINKS_ADDED:	The fwnode has already be parsed to add fwnode links.
  * NOT_DEVICE:	The fwnode will never be populated as a struct device.
  * INITIALIZED: The hardware corresponding to fwnode has been initialized.
+ * NEEDS_CHILD_BOUND_ON_ADD: For this fwnode/device to probe successfully, its
+ *			     driver needs its child devices to be bound with
+ *			     their respective drivers as soon as they are
+ *			     added.
  */
-#define FWNODE_FLAG_LINKS_ADDED		BIT(0)
-#define FWNODE_FLAG_NOT_DEVICE		BIT(1)
-#define FWNODE_FLAG_INITIALIZED		BIT(2)
+#define FWNODE_FLAG_LINKS_ADDED			BIT(0)
+#define FWNODE_FLAG_NOT_DEVICE			BIT(1)
+#define FWNODE_FLAG_INITIALIZED			BIT(2)
+#define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	BIT(3)
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
-- 
2.33.0.309.g3052b89438-goog

