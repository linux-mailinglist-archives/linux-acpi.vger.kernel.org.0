Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D923534B68
	for <lists+linux-acpi@lfdr.de>; Thu, 26 May 2022 10:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346644AbiEZIQU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 May 2022 04:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346645AbiEZIQJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 May 2022 04:16:09 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A19BA54B
        for <linux-acpi@vger.kernel.org>; Thu, 26 May 2022 01:16:03 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id i9-20020a632209000000b003facc62e253so544353pgi.11
        for <linux-acpi@vger.kernel.org>; Thu, 26 May 2022 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DUCLIv3fIFZkN4IwkAbrdxyKeVczdAPuMH/CpPcV4SU=;
        b=CyzwtSa5kL7asxlJAQxy6KynJEIdFhvGau0g94npATBUb08mCN7xWPYiqWSpgyW7pp
         AeKTLb8s+1yIbjcvPRGqkRXa/d5TFin/hQLWeMaJAETlo6oYW5f14ntDOqjhIvmFKH7Y
         to71h+gy1/+mvnPHDbGWIsuAvvkUo1tnVwOwiNBYAz/Th1IFA4cu6ZOpIDrj4HrVUFgZ
         8TxgahJGhhjYVYLYmfpUFt435KgFpIWHwyX3O6yL6OwYx2jNmvoxtX57zkKnPlBhHjOv
         6ap3F7Gzmj4ck2T+A1f3T4XMo/l1Sr7ClNm8Ko3J8AHf9Vnb1FGRV7j+BHxzraC/ZahT
         26MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DUCLIv3fIFZkN4IwkAbrdxyKeVczdAPuMH/CpPcV4SU=;
        b=YoA7S9R5NRtLu/doF1KpmFPHqfjzhtHRyweiM3DZypDC9EQQXuvWz8OJmsiZR0GtH7
         I17mh4E85qulVuemOU2+OfL/T8L0yh+hiIwSBaVXUNGNS/nZ5MOZwKI+NLEl9rraD6Z/
         YNihCFLdVI6yO4SOKWABXpgy/Q78VsO4qAI4mnnn9niMTEicFQsVWk4l6migOEbzCMNu
         OvumTOj3BtqiAcSnqiJlHHP3kSVWhlpLVIspH0cuuAkPYtyY0onQgubgSleySZtMFxg7
         3/rA9UGcM1DLc6qTNniYWX08TQ7qFjHD/wvPSb51BxY74IEHk2cGB3BnExTEH68SHigh
         YUbw==
X-Gm-Message-State: AOAM5312pc6XVWLwQLH8vlqT1l3sJMc5oIojG2xEMVzQDZIKdtsOqLsa
        +/HJV/onSI5ngkEkrrVITgrI0aoigslsG/s=
X-Google-Smtp-Source: ABdhPJw2pOLycSo0Dk2hnHYGrYjnmnj9FmTbJXx5Eil6VtjWJt3Y4OCof/7QvyjmXMAMae1GQK5aRzIjQ2vExSg=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a63:343:0:b0:3f6:52e5:edbe with SMTP id
 64-20020a630343000000b003f652e5edbemr29501334pgd.272.1653552962496; Thu, 26
 May 2022 01:16:02 -0700 (PDT)
Date:   Thu, 26 May 2022 01:15:42 -0700
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
Message-Id: <20220526081550.1089805-4-saravanak@google.com>
Mime-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 3/9] net: mdio: Delete usage of driver_deferred_probe_check_state()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        John Stultz <jstultz@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Now that fw_devlink=on by default and fw_devlink supports interrupt
properties, the execution will never get to the point where
driver_deferred_probe_check_state() is called before the supplier has
probed successfully or before deferred probe timeout has expired.

So, delete the call and replace it with -ENODEV.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/net/mdio/fwnode_mdio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 1c1584fca632..3e79c2c51929 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -47,9 +47,7 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 	 * just fall back to poll mode
 	 */
 	if (rc == -EPROBE_DEFER)
-		rc = driver_deferred_probe_check_state(&phy->mdio.dev);
-	if (rc == -EPROBE_DEFER)
-		return rc;
+		rc = -ENODEV;
 
 	if (rc > 0) {
 		phy->irq = rc;
-- 
2.36.1.124.g0e6072fb45-goog

