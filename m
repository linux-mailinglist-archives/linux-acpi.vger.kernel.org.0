Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA8967DA54
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jan 2023 01:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjA0AMK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Jan 2023 19:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjA0AMF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jan 2023 19:12:05 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA0F728F1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2023 16:11:53 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5066df312d7so38546277b3.0
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2023 16:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qrGwsyJhvuk8/KLfQTHsy0tky5Hgdg5GqDKep+1DD4=;
        b=ImHEFeirQ0+RNKXqTaRuRYAbdlWC5P5L5GKOen6KHlSMssg4oHFiz8wutXFV5a4tIe
         S7kQQuXLu7CpQ+gcDOKQIgq7ikdWUn+rZ1UtcQPNh0gxcZQw1wsRj6iqGY3gnJnXhy1G
         NkOjRS354EK8XltpUyGCaPrUCbw/DnHLbLReN+Ew9y/NfKLLZcgs7hauSWp5PvS5MbaA
         FqgwSH8VK+sdmrpkFSE4HZxG2acds1LrKo7sRSFq7ryxJ4Wxoqki0uG9IRIlPHito8iZ
         zImbuVkz+4PK9IaO7IHdiDnHqOYuRc6/qWn3UZ4pCiAfGD+B5KwFGQl+8L+UgsEnm9Z+
         3qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qrGwsyJhvuk8/KLfQTHsy0tky5Hgdg5GqDKep+1DD4=;
        b=NGxuxVCqss9B898DC3mddOmjdACrlw+EX9ZoCuWgzBU0f+A3CylQMuPyZB3M4AJyzY
         SiFJlAaAE1hqlFVTYEaouxHZ+yLmIXxeAtUmbKjFLyoYOKRU3a51QoUs8rMjijjIXEzH
         AwkQIQTB0TEAc6KpF7QFaxzb740zpRTtqMejdRAp+UQ8SphUdKr9rKFO7OHRiT9F0AMY
         AAdBFK3doKPFciGwylGe8bYMDf/MOTkV6aVRr5MhWwGI/R9VQVOnqI0QsfGyYyin/QWc
         0tieCsTbpS8LhzU2W2vr359xcRb3pBC9Kiy/BtLXEjqqkkx2By2Z6dV4IKCuephYzwDL
         oOig==
X-Gm-Message-State: AO0yUKX/yr+H2aEiblPyaQcsxIGMn9+Cy+cWYZKoI7VpvDwke2MiLw00
        SdBwzW7Q/kvC5M1/2iiDR3HisntXabmHCS8=
X-Google-Smtp-Source: AK7set94B+Uk166woh0daWeHRoT+YOBMrypJ1SORaMn8sBX2Wuwc6YxVyj9CsmbZUek2b/SIx0NT19DAyygxzRQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:c3b4:8b1c:e3ee:3708])
 (user=saravanak job=sendgmr) by 2002:a25:260c:0:b0:80b:663d:6a98 with SMTP id
 m12-20020a25260c000000b0080b663d6a98mr1309860ybm.598.1674778312253; Thu, 26
 Jan 2023 16:11:52 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:11:30 -0800
In-Reply-To: <20230127001141.407071-1-saravanak@google.com>
Message-Id: <20230127001141.407071-4-saravanak@google.com>
Mime-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v2 03/11] soc: renesas: Move away from using OF_POPULATED for fw_devlink
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

The OF_POPULATED flag was set to let fw_devlink know that the device
tree node will not have a struct device created for it. This information
is used by fw_devlink to avoid deferring the probe of consumers of this
device tree node.

Let's use fwnode_dev_initialized() instead because it achieves the same
effect without using OF specific flags. This allows more generic code to
be written in driver core.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/soc/renesas/rcar-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index b0a80de34c98..03246ed4a79e 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -437,7 +437,7 @@ static int __init rcar_sysc_pd_init(void)
 
 	error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
 	if (!error)
-		of_node_set_flag(np, OF_POPULATED);
+		fwnode_dev_initialized(&np->fwnode, true);
 
 out_put:
 	of_node_put(np);
-- 
2.39.1.456.gfc5497dd1b-goog

