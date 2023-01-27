Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F58E67DA4E
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jan 2023 01:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjA0AMI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Jan 2023 19:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjA0AMC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jan 2023 19:12:02 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96659728C4
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2023 16:11:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5005ef73cf3so38192627b3.2
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2023 16:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oSp69aiP/ondfVBxLJgKdKcBnN2p1Qu9kMhAEVz7jQo=;
        b=WN5DOQpYzA92uZTk5nB7Gm+JHPUhYwyKPFfQgnsGcIXK24VeOqAuCHMqj0K9QIHsK4
         VDJINGbm+PZQ3D46gH9OOk1BZIZYxmKsfVmUhh5yU1FVIGGNA8uHoGLKqrlP5q/XWMIC
         ASunugeOvewn6WROaXEMgKC5JzdCO+ZRpSFJcmK7Ru/kahTql81VAj0bRBch6D1sH5E2
         R+TLl4pbdpM/C+LxjBtFvrZF+cEvz3GgORkPhsdcgSXXbMs0WwBxILTvUbbxTpb5gNop
         80tc/HoW58bY7nNrnAEcmXR8sWMLTD10O/iaU0O8n4d/GXA/XwchgaZYTtWd+lYxHcnL
         oecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSp69aiP/ondfVBxLJgKdKcBnN2p1Qu9kMhAEVz7jQo=;
        b=XCzi7Lw+novo6E5IVB5dFwe1RtYLYUUmY381N+fBCC6DmKsGWzT6oVyXH4CjyYQynt
         J96LGz38sD+0C8bbOlc1xgCAKEGDgzb7Jl1nkgEWC129bh6PY42pRYctz+QFWY0X7TtF
         vPEWnAB5CnYBLoWjOO4tIZbIyxc24YhXaTXmGJt1Io+W3JDb6W6eEnzrYBj0aE5p3VrU
         9hJk59YcZhF9TUo98L7ZgeuFt+svJvrTFNsygmRlQGaNTd7xE4Li+lJ4jhmY2IDgYteQ
         8OirP3RsMc/C+pA3Gpyqlr7YAuyRVECH8KdPz2PnY2DFTpxPKc4TtOqhtrmmxYVu83bw
         k3QQ==
X-Gm-Message-State: AO0yUKWyDWNVRo/YB+ABBC3havQ57k/euze1lT7WLz5/ozCgG/sDAqWf
        stR/pgTr5ApfV3MhlFguFaJtEatXKM0qibE=
X-Google-Smtp-Source: AK7set96Y+e9U1r05pqMQpL0k9Ij3R0FH79/ElueXQokOeBTjKJdHwZIAnvnycP8rHNiKQopHaYQfRQ9y4PwQpk=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:c3b4:8b1c:e3ee:3708])
 (user=saravanak job=sendgmr) by 2002:a25:69d0:0:b0:80b:7021:b88d with SMTP id
 e199-20020a2569d0000000b0080b7021b88dmr1335558ybc.93.1674778309799; Thu, 26
 Jan 2023 16:11:49 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:11:29 -0800
In-Reply-To: <20230127001141.407071-1-saravanak@google.com>
Message-Id: <20230127001141.407071-3-saravanak@google.com>
Mime-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v2 02/11] driver core: fw_devlink: Improve check for fwnode
 with no device/driver
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

fw_devlink shouldn't defer the probe of a device to wait on a supplier
that'll never have a struct device or will never be probed by a driver.
We currently check if a supplier falls into this category, but don't
check its ancestors. We need to check the ancestors too because if the
ancestor will never probe, then the supplier will never probe either.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b6d98cc82f26..919728e784e8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1867,6 +1867,35 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
 	return ret;
 }
 
+static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
+{
+	struct device *dev;
+	bool ret;
+
+	if (!(fwnode->flags & FWNODE_FLAG_INITIALIZED))
+		return false;
+
+	dev = get_dev_from_fwnode(fwnode);
+	ret = !dev || dev->links.status == DL_DEV_NO_DRIVER;
+	put_device(dev);
+
+	return ret;
+}
+
+static bool fwnode_ancestor_init_without_drv(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent;
+
+	fwnode_for_each_parent_node(fwnode, parent) {
+		if (fwnode_init_without_drv(parent)) {
+			fwnode_handle_put(parent);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
  * @con: consumer device for the device link
@@ -1948,9 +1977,16 @@ static int fw_devlink_create_devlink(struct device *con,
 		goto out;
 	}
 
-	/* Supplier that's already initialized without a struct device. */
-	if (sup_handle->flags & FWNODE_FLAG_INITIALIZED)
+	/*
+	 * Supplier or supplier's ancestor already initialized without a struct
+	 * device or being probed by a driver.
+	 */
+	if (fwnode_init_without_drv(sup_handle) ||
+	    fwnode_ancestor_init_without_drv(sup_handle)) {
+		dev_dbg(con, "Not linking %pfwP - Might never probe\n",
+			sup_handle);
 		return -EINVAL;
+	}
 
 	/*
 	 * DL_FLAG_SYNC_STATE_ONLY doesn't block probing and supports
-- 
2.39.1.456.gfc5497dd1b-goog

