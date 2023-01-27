Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF5067DA79
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jan 2023 01:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjA0ANJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Jan 2023 19:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjA0AMX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jan 2023 19:12:23 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA6074A5C
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2023 16:12:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-50660dd3263so38124267b3.19
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2023 16:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNud8Lepb4eeXuGOsqZyJ2CqEHzF4/YGHX/WXomA3GE=;
        b=dg98ZZl1AyihbP1LtRx2ePJtNIBANvg6l6Gdfmwrlmg+xT29TDIlqdpN4YyRCNlsxH
         2d+0NDQIyNI3+imcQ7NQDTRWU1cDISH1SIRjs9KZ9MtQYKwyRV2E4kxG41RUu30tztbk
         1mwsm7nys4j63yTbqvFZ+dsEGsC+i/ndeRX8r4+da18Js4TD+T2SAi+UhZwx6pYIX2zk
         S33rrWohkq2TTRvsyKP/W20Tvxz9wzR67Dg4HTFjJ3AJA4tGIDsFSQ5Evi/mLTjK/dZc
         mdnVVzCHcFRVh1ANjNSv5R8RCXk+iP/LFXcXuHnbESiTmXqgog9RUHjvs7XuDBqjK0Te
         pPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNud8Lepb4eeXuGOsqZyJ2CqEHzF4/YGHX/WXomA3GE=;
        b=C56Wz8rkYs8KFFAxZCAwpDMkftPVjM+W0r9U7a5ox0PiT88E7n2yHJZZEOWE83nqw4
         zLtu0RNhaL+DnjF3Fkz+J2DEFyjgijXJr4ixyNDXkSKGmKi227Ima7yVAQcMXqaoNL1R
         rEKqheyuloDpfuqsfjGJFovTvH6aaJHV4kFjNa4mdIk20TjYCTh+ZQCoa1nVDiQd1lt9
         IYjDogPSVqxAPdyFSFSah4OwfipfmlpsP4YwsJE7KHJTs1g7LsC98bSEVPDy/PLnWDT3
         7B2KIFSU4jYxm6qL4QVVnDyIXP/z3zoPFTec0K1THTfge3Geu081t+54c+H8IzNvclAH
         wZ0w==
X-Gm-Message-State: AFqh2krTU/wiVb24GT/8c1R/6U42ud2Lc17ojws91wa/Oac3gq6VcpPZ
        XWQp/VbRQB/MgF0xkbRi1Kyk9WfLjakHa8k=
X-Google-Smtp-Source: AMrXdXsSdZknjAr0wKn0gY/MpnIZeRHel3NzwGKSoO8sLRLrs7LZP2oF+s13fwjubTyvaUKdTsWZdOHXxvgHyc8=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:c3b4:8b1c:e3ee:3708])
 (user=saravanak job=sendgmr) by 2002:a81:6284:0:b0:373:8313:2991 with SMTP id
 w126-20020a816284000000b0037383132991mr3462545ywb.261.1674778329995; Thu, 26
 Jan 2023 16:12:09 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:11:37 -0800
In-Reply-To: <20230127001141.407071-1-saravanak@google.com>
Message-Id: <20230127001141.407071-11-saravanak@google.com>
Mime-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v2 10/11] irqchip/irq-imx-gpcv2: Mark fwnode device as not initialized
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

Since this device is only partially initialized by the irqchip driver,
we need to mark the fwnode device as not initialized. This is to let
fw_devlink know that the device will be completely initialized at a
later point. That way, fw_devlink will continue to defer the probe of
the power domain consumers till the power domain driver successfully
binds to the struct device and completes the initialization of the
device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 1 +
 drivers/soc/imx/gpcv2.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index b9c22f764b4d..8a0e82067924 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -283,6 +283,7 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	 * later the GPC power domain driver will not be skipped.
 	 */
 	of_node_clear_flag(node, OF_POPULATED);
+	fwnode_dev_initialized(domain->fwnode, false);
 	return 0;
 }
 
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 7a47d14fde44..b24f9ab634dc 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -1519,6 +1519,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 
 		pd_pdev->dev.parent = dev;
 		pd_pdev->dev.of_node = np;
+		pd_pdev->dev.fwnode = of_fwnode_handle(np);
 
 		ret = platform_device_add(pd_pdev);
 		if (ret) {
-- 
2.39.1.456.gfc5497dd1b-goog

