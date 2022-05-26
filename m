Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3FF534B58
	for <lists+linux-acpi@lfdr.de>; Thu, 26 May 2022 10:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346654AbiEZIQK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 May 2022 04:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbiEZIP6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 May 2022 04:15:58 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DC4AE250
        for <linux-acpi@vger.kernel.org>; Thu, 26 May 2022 01:15:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id i19-20020aa79093000000b0050d44b83506so715776pfa.22
        for <linux-acpi@vger.kernel.org>; Thu, 26 May 2022 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1IM3Fvbt8ArJUmTPEiiyr+pPYoVHFzyhPnAJGlSaBT4=;
        b=hAnSk3S9Qg0dtqCUypketAd2iTMRbAyagepCTA0NOJrVOCYo/te3z7FpVSX+BIFv7w
         HFcBaSe8ey43rsPOJ4EjkpljhrSmzZ1XVfIWV1DDuCsC0XNnyEb5qUDG+IdRWB1l+ul8
         1+Z/Ua4o1ESvV/9Kg1g2lrH9ViDRc2EvuOCNnW0G2m+ijHjBO1KC5Ck9UQlUnR4EKgjD
         We+nltaFfzSRtA+CLFGxgY+57TX8DeoDR4srqJYZz+sXUodRK7yMpUhoEFX98DiW0heG
         FyUxGgvp4/hgqLihCcZx8cKb4bTu089o4kruA0ivqPzW49fGKGvzAR3Epx0sWNWjAIVq
         1iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1IM3Fvbt8ArJUmTPEiiyr+pPYoVHFzyhPnAJGlSaBT4=;
        b=G0lEM/BNgwyv7LKIzrVHpswnsh+PnAr2qWeDrcB2YGmRUVgiesOzox2cnmAgwaw+cO
         7bDkZIfsTpfC30pbhTTgtt3fZ4g2k93LEhF1wM5r0eNDdqblLF7wOv/4JzwhDaWtWcA/
         bEeXsLGMhibTplXg4ZKOpqHnzFNBm5QfBBIxFyDnnSjBlSQBaH2g95yYv3kTCLLkvnpz
         nrcgx8XO9wp+atmBpZJOAtPGlwb2/FyWBeamiWmAkY14rxu4EpChM9C+OWSIYQDQiNuQ
         IKbTSFF4/3kFuvnb4C2KzxKHXrE80z5vf3xF2IqOJFUR4LichVZIgi5AQ1M1ANkkauxz
         m/wA==
X-Gm-Message-State: AOAM533kSh87Kl6UCK7ZE6CUuOJ0fnYrewMDEIqMTSYqq1+3pbav9hSP
        4c6cCo7KbbLLdZVMLNDAeLZUo/Ny4NCNGYM=
X-Google-Smtp-Source: ABdhPJymfPGXL/xfcU37VydiB6tPwHU4G2U1fbHUW+y/HyW7OlytTUy4MZTLFHGyXEorOunFh2vZDJQB7oQgrz0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a17:902:ecd1:b0:163:6120:563c with SMTP
 id a17-20020a170902ecd100b001636120563cmr5819104plh.90.1653552956872; Thu, 26
 May 2022 01:15:56 -0700 (PDT)
Date:   Thu, 26 May 2022 01:15:40 -0700
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
Message-Id: <20220526081550.1089805-2-saravanak@google.com>
Mime-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 1/9] PM: domains: Delete usage of driver_deferred_probe_check_state()
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Now that fw_devlink=on by default and fw_devlink supports
"power-domains" property, the execution will never get to the point
where driver_deferred_probe_check_state() is called before the supplier
has probed successfully or before deferred probe timeout has expired.

So, delete the call and replace it with -ENODEV.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 739e52cd4aba..3e86772d5fac 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return driver_deferred_probe_check_state(base_dev);
+		return -ENODEV;
 	}
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
-- 
2.36.1.124.g0e6072fb45-goog

