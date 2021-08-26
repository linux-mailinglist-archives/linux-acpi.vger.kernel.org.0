Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089383F8346
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Aug 2021 09:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbhHZHqV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Aug 2021 03:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239817AbhHZHqU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Aug 2021 03:46:20 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B2DC0613C1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Aug 2021 00:45:33 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b24-20020ac86798000000b0029eaa8c35d6so675924qtp.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Aug 2021 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HUmRAcDzztnKxy5pKmKq2USl0q0kZIBvrwBQCQ/1nmI=;
        b=vDlQeB9eZYhyuhJvkRFprhHgmhlUTNG2gZKTMjlE54agavbX1YsG5j9ANDcfF8tIrR
         2yJ325FKUobUIG5oQf+fSzgJr9ekX8rjpE9/alg92dqk0oLArE0ggZw4PJoWQ89NFohX
         Wvd9fPSlfuRnyOdW55RWCJZGrmK0QHkyLHUBbv0PKp0QcDAFNLpPf7TmpEywTVikFfXg
         t38VgqnNeNb6aJRxixZ957vrt+QQhQPHMHSg8QGj7N7X0LXw6lYBknVpJOjh7KPEPC/3
         L5r2q8QExtUbq5+CW9L9VchBsPwUHAe8TVegAv/NcKz9OlpzlTKzV4eSJcTb8QOkkzfM
         giDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HUmRAcDzztnKxy5pKmKq2USl0q0kZIBvrwBQCQ/1nmI=;
        b=H+LwE2tWa33kG+HDCHp/ju4Z/sj9OP6XkHIvy8TUJQACwQmj9+tHWM4lz0S8vz56d3
         YlCIOHs2GMD59dm+8xygFi6+g9tNn2qPXSXy1/jQqtTa4px9vkfl2mjl+YYXIDS4gicT
         eheD4u8agF3lLfVB73pi9CSIFEt3N6ooJF2i0WK20vJM3PHHiM/x5e1xpKLy9SxdF+kt
         tmOzpbEoOLmX85FuW6ReEO6hoHSEPya8/3f1JubBkhXXe/lDSrGPe6LVQRP3R8j9liM9
         /2AvOgCarvenm8f/r69tQ7RFGHLkNeIjK78ulmgg3qOXnm6Fhs1F+O4KSa3/d5bc87ye
         jsbw==
X-Gm-Message-State: AOAM533sWtQIULjcH2D+lbF7cgCU9ieaE7lVeGxoPF0k2yIMMDBj/vox
        4OrwH2X0Pj1yg2dz4EXh3j2p8HbRddNSW/I=
X-Google-Smtp-Source: ABdhPJzKB6i+ELJ3azTpl11cp1xEPfOcbGw0rbi8n8hgqYrxPUdbTqF9de4PcodRrCpKwahzktUBHsrmwcwk3Co=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:5b7b:56e7:63bf:9b3c])
 (user=saravanak job=sendgmr) by 2002:a05:6214:d83:: with SMTP id
 e3mr2611023qve.23.1629963932578; Thu, 26 Aug 2021 00:45:32 -0700 (PDT)
Date:   Thu, 26 Aug 2021 00:45:24 -0700
In-Reply-To: <20210826074526.825517-1-saravanak@google.com>
Message-Id: <20210826074526.825517-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210826074526.825517-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v1 1/2] driver core: fw_devlink: Add support for FWNODE_FLAG_BROKEN_PARENT
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Alvin Sipraga <ALSI@bang-olufsen.dk>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If a parent device is also a supplier to a child device, fw_devlink=on
(correctly) delays the probe() of the child device until the probe() of
the parent finishes successfully.

However, some drivers of such parent devices (where parent is also a
supplier) incorrectly expect the child device to finish probing
successfully as soon as they are added using device_add() and before the
probe() of the parent device has completed successfully. While this
might have worked before, this is not guaranteed by driver core.
fw_devlink=on catches/breaks such drivers. One example of such a case is
discussed in the link mentioned below.

Add a flag to make fw_devlink=on not enforce these supplier-consumer
relationships, so these drivers can continue working. The flag is
intentionally called BROKEN_PARENT so it's clear that this flag
shouldn't be used in the normal case and that there's a problem with the
driver.

Link: https://lore.kernel.org/netdev/CAGETcx_uj0V4DChME-gy5HGKTYnxLBX=TH2rag29f_p=UcG+Tg@mail.gmail.com/
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 22 ++++++++++++++++++++++
 include/linux/fwnode.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f6360490a4a3..2cc34f8ff051 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1719,6 +1719,28 @@ static int fw_devlink_create_devlink(struct device *con,
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
+	 * as soon as it's added and before P finishes probing. While this is a
+	 * broken assumption that needs the driver to be fixed, we don't want
+	 * to block fw_devlink improvements because of these drivers.
+	 *
+	 * So, we provide a flag to let fw_devlink know not to delay the probe
+	 * of C until the probe of P completes successfully.
+	 *
+	 * When such a flag is set, we can't create device links with P as the
+	 * supplier of C as that would delay the probe of C.
+	 */
+	if (sup_handle->flags & FWNODE_FLAG_BROKEN_PARENT &&
+	    fwnode_is_ancestor_of(sup_handle, con->fwnode))
+		return -EINVAL;
+
 	sup_dev = get_dev_from_fwnode(sup_handle);
 	if (sup_dev) {
 		/*
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 59828516ebaf..9382065e6ff8 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -22,10 +22,13 @@ struct device;
  * LINKS_ADDED:	The fwnode has already be parsed to add fwnode links.
  * NOT_DEVICE:	The fwnode will never be populated as a struct device.
  * INITIALIZED: The hardware corresponding to fwnode has been initialized.
+ * BROKEN_PARENT: The driver of this fwnode/device expects the child devices to
+ *		  probe as soon as they are added.
  */
 #define FWNODE_FLAG_LINKS_ADDED		BIT(0)
 #define FWNODE_FLAG_NOT_DEVICE		BIT(1)
 #define FWNODE_FLAG_INITIALIZED		BIT(2)
+#define FWNODE_FLAG_BROKEN_PARENT	BIT(3)
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
-- 
2.33.0.rc2.250.ged5fa647cd-goog

