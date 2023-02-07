Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8B068CC39
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Feb 2023 02:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjBGBoG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 20:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjBGBnV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 20:43:21 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF76636685
        for <linux-acpi@vger.kernel.org>; Mon,  6 Feb 2023 17:42:50 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id x3-20020a654143000000b004f2f2dafb21so4808952pgp.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Feb 2023 17:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qO7SA/IWYPEhdvQ3bg5afBtNBnjngejmFoW2WqOrddI=;
        b=GazeBruttlU5oTI33IWVV1tAUn4JRdRTAmGz0onik+n6U1T5h3g5Eqk7gGdOGMDK/b
         pISWVmhqDorcgwiUsTtbwUhwsXkQBy9FbOADGd10qeFLJKcjSWm9FlwkrDf0YSZnQ9+5
         MlI9mebazN/CBNgen9ENy7akZji0sNSLpJDHAKCcuu7sotue0FW2RA5Bj0NTsc48DOU1
         BJ2j+WUhTu8DoyxWUtbwaehDC8ppns7BWt2T/8qAizu6/ITBGfNfqXYJKkF1ZM6CyRxn
         ZcscZDUsMpAZKiRckNDj1rDjE8L096aAxpbX+tYBH1Uk2VlibG8o8TaOGQfpibf5qmCu
         A4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qO7SA/IWYPEhdvQ3bg5afBtNBnjngejmFoW2WqOrddI=;
        b=RWUA765FFTOlZx9p+TyHY3b++f3eGS/avsxDcCeGRGTUUOdisMGreRUIyXyyClvLM/
         k78+wYOJA38H+p1ps0tD62eq58aa/bIaUzH2uvzkZ3GLt8Ncv9IyVQ6HbW/Ewm/hQmAT
         jdGMth5YvnsJBEqI6FulN8rq1IPNVQrGozZ5NwaVNoGlpCWRYri+yMnXz/3GGgZYkP9F
         eQSxmNmNbxWQx0lhlTAORvdlUZM9NXufwBBrw/wcC/o+Sax0GwsfharNudrsSVTpmiYv
         MRFht5bQBU6ZhTNZSgpK8wRVDrV2LDBIbwO2zl13rGiSKv7cLjOMJl7uysCloqDGjKg6
         yURQ==
X-Gm-Message-State: AO0yUKUZNYYSKzthDus15VPf3gWooOFr4pttI+hfcsh+yheF8WPMjo14
        jBd9+rT3FhV8UZ9hcaMs6zFU0exknkHG7i8=
X-Google-Smtp-Source: AK7set8CF2GrP/NVxAgKrUj8AGlYPMKVoXXaqrQpeXZ8O8WzceQ78vPHdt/Q5BozlBJGRB5LWE1p0PTeySIpdfY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ae1:aba6:f21c:4a94])
 (user=saravanak job=sendgmr) by 2002:a63:7304:0:b0:4da:d745:98dd with SMTP id
 o4-20020a637304000000b004dad74598ddmr170930pgc.62.1675734160457; Mon, 06 Feb
 2023 17:42:40 -0800 (PST)
Date:   Mon,  6 Feb 2023 17:42:03 -0800
In-Reply-To: <20230207014207.1678715-1-saravanak@google.com>
Message-Id: <20230207014207.1678715-12-saravanak@google.com>
Mime-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v3 11/12] firmware: arm_scmi: Set fwnode for the scmi_device
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

This allows fw_devlink to track and enforce supplier-consumer
dependencies for scmi_device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 35bb70724d44..cc2eba067575 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/of.h>
 
 #include "common.h"
 
@@ -191,7 +192,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 	scmi_dev->id = id;
 	scmi_dev->protocol_id = protocol;
 	scmi_dev->dev.parent = parent;
-	scmi_dev->dev.of_node = np;
+	device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
 	scmi_dev->dev.bus = &scmi_bus_type;
 	scmi_dev->dev.release = scmi_device_release;
 	dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);
-- 
2.39.1.519.gcb327c4b5f-goog

