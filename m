Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260553F834C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Aug 2021 09:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhHZHq0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Aug 2021 03:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbhHZHqW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Aug 2021 03:46:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA4C061757
        for <linux-acpi@vger.kernel.org>; Thu, 26 Aug 2021 00:45:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b127-20020a25e485000000b005943f1efa05so2235700ybh.15
        for <linux-acpi@vger.kernel.org>; Thu, 26 Aug 2021 00:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YHIgrK6tAkKZGZR6Q2TwdOpVzreK8GCVzLPUG55+FFA=;
        b=rhStSsGxbaIR0MHB9CmSlbRSYrPUet7tGgyJ+OcOlMCUMLgbNQjDUbORc7FcHe1ros
         eyJjNPIteE6dcBbFrVV4sAG1CfkyctKtYXFUFJFjILiWA67roZgtqUY+kW//6sWFQBuL
         XJneAy7Kdqhg2gB58jMjQkZIStv8T7VXpY87t6vptrNXwrmktfKWgyxFIcrm88KDaTC2
         aAKaQZvxNsln4iUtVENNv4blcCIXXIYkyPCXiSrYsxpAC6a0evyoY0kjbsFKYs3rbNcx
         1GFyICXzmkbexbA2W7BfkCml5A0a+cfdXbMtdQMvqkdvurKKGhfD2RUL/jmX5CZ73WBN
         TKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YHIgrK6tAkKZGZR6Q2TwdOpVzreK8GCVzLPUG55+FFA=;
        b=U8wlPInWCS0RnHtvagyghM/Uq4IVOIEUoDgtK7Euo1WpYl72sjOQedxsCkRH3tpRq+
         hVSfcCo/5fGyETnnoJ/mhx3p0HvXtVkBgU8g9QuyUrPWpfm9XYtHu1CSR/OuTC8XYZu0
         441BBg+AQg4+dVYwMxEHcvtrUQALEiy21MwW6uHnznAKU/wxYy4xLE0K8kgwtMkqj0Bb
         RrGxjQpka4La15y1Q5YqYbYUkxdAjsPgKuHf2XKnNift5VTZaEppj4IkbTgZdN1m/KA7
         qu2zATLOZpNh4NVnOThUftSU4NKUDH8cIGo4Zzq5smH8Rhuaaq5r+oU2cUiSJceVaa5N
         ZuqQ==
X-Gm-Message-State: AOAM532c6U9X/M+BbZctR4IcPi7lxe5rleAaR9fMF7sJ7PgU+9MCWJzC
        4gVLoWtZA7HzakjxuDsHjU5rpsrj9tRStQM=
X-Google-Smtp-Source: ABdhPJycNYDqto2n3MH4BgrRVXIGSmkVWlpLM27lpYHQFpoOpL13Ca6ZU3KzJ3Auys6ImZMCuoSNk0Dqns2CdFc=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:5b7b:56e7:63bf:9b3c])
 (user=saravanak job=sendgmr) by 2002:a25:5ed7:: with SMTP id
 s206mr3728540ybb.387.1629963935137; Thu, 26 Aug 2021 00:45:35 -0700 (PDT)
Date:   Thu, 26 Aug 2021 00:45:25 -0700
In-Reply-To: <20210826074526.825517-1-saravanak@google.com>
Message-Id: <20210826074526.825517-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210826074526.825517-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v1 2/2] net: dsa: rtl8366rb: Quick fix to work with fw_devlink=on
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

This is just a quick fix to make this driver work with fw_devlink=on.
The proper fix might need a significant amount of rework of the driver
of the framework to use a component device model.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/net/dsa/realtek-smi-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/dsa/realtek-smi-core.c b/drivers/net/dsa/realtek-smi-core.c
index 8e49d4f85d48..f79c174f4954 100644
--- a/drivers/net/dsa/realtek-smi-core.c
+++ b/drivers/net/dsa/realtek-smi-core.c
@@ -394,6 +394,13 @@ static int realtek_smi_probe(struct platform_device *pdev)
 	var = of_device_get_match_data(dev);
 	np = dev->of_node;
 
+	/* This driver assumes the child PHYs would be probed successfully
+	 * before this functions returns. That's not a valid assumption, but
+	 * let fw_devlink know so that this driver continues to function with
+	 * fw_devlink=on.
+	 */
+	np->fwnode.flags |= FWNODE_FLAG_BROKEN_PARENT;
+
 	smi = devm_kzalloc(dev, sizeof(*smi) + var->chip_data_sz, GFP_KERNEL);
 	if (!smi)
 		return -ENOMEM;
-- 
2.33.0.rc2.250.ged5fa647cd-goog

