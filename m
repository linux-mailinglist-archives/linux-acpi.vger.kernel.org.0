Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88050C2B6
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Apr 2022 01:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiDVW5x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Apr 2022 18:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiDVW5m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Apr 2022 18:57:42 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E9935C5F4
        for <linux-acpi@vger.kernel.org>; Fri, 22 Apr 2022 15:21:54 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id e4so10593218oif.2
        for <linux-acpi@vger.kernel.org>; Fri, 22 Apr 2022 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AvSAQb1M8ai7iREtClhTlQbpfuCOvIwvoizOPDtnCrk=;
        b=Pc1e+PMZm5IuYicnb0WwTJ3NxS7TWcDp5tMa6jMLdMKAY3An0CjGAK0elizA3QrGdx
         qzxqjjVPtpGIT6IPsJIq1xPrBEMGIwCLBxMej9K4Y+EHPh8ksv960DhiDp443oAUcbFZ
         Jhsny1PFJ8tHy9iAkzQntJe638zmBWWED/CGHiAsKTL/om+PCaUq7KuJMxwxuIDtdN+z
         b24DjqO1UN/wg00srUSnjInLBJasjhNV6itXuEF4Xm2wa8jd5dq6Aeb5ibdQYQLy6MJu
         UaPkjfulA0/O5DsIxHPt15xV9ek4CamZlac5+XwtbU0OWOkFk0ROC2t/7ED58vXNdNM2
         saOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvSAQb1M8ai7iREtClhTlQbpfuCOvIwvoizOPDtnCrk=;
        b=VK+yYjV/PH+DuN9Ntvft+j3oUZwXIw0xiP/L5olNcNSALX1+7DmLJZnfQru49pIFgE
         3lfXAuKe+oxmdq+N1Pt1Ks8SedkEuEbE2yix9x0B3vGtI6YPcj42jlLTQHj4oEogco2p
         K6Az7YbN/++QToQolgE/AnCnnHbxTxmQkrMA/uVWhUkdv/iHe4GcGi4Fz/LTab8AEvot
         MrMeSi0i9+69zByKfNMMOYFZa/unOZbO39RuKVEZ1uDBNwxv34t5EwDqhMEkk1pzUMgG
         NOaoUvZpig/GxzPrwsBcxvHdxBjjWlt5gNtlbUYQVY8nluVpLAHL5AUg6ukCIDmbXr36
         FIkg==
X-Gm-Message-State: AOAM531RT7IqFSGTCwlyM0gqBrnq6snWM8UGKMWsbuVcmm4s8Pao0JuD
        u0sOF6TGL4EcdfIDwTdAbevMYA==
X-Google-Smtp-Source: ABdhPJxPQFhhi1f//zKscwPmmuTNsN+HkKo9ZZPLpV1bgBPsKMaslivRlGVFdAXX/APr6Tx55vb/oQ==
X-Received: by 2002:a05:6808:3b8:b0:322:a783:8fc8 with SMTP id n24-20020a05680803b800b00322a7838fc8mr7584151oie.189.1650666113629;
        Fri, 22 Apr 2022 15:21:53 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id js4-20020a056870bac400b000e687cdf5adsm1049224oab.55.2022.04.22.15.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 15:21:53 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v5 3/7] usb: typec: mux: Check dev_set_name() return value
Date:   Fri, 22 Apr 2022 15:23:47 -0700
Message-Id: <20220422222351.1297276-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422222351.1297276-1-bjorn.andersson@linaro.org>
References: <20220422222351.1297276-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It's possible that dev_set_name() returns -ENOMEM, catch and handle this.

Fixes: 3370db35193b ("usb: typec: Registering real device entries for the muxes")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Added Fixes tag

 drivers/usb/typec/mux.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index c8340de0ed49..d2aaf294b649 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -131,8 +131,11 @@ typec_switch_register(struct device *parent,
 	sw->dev.class = &typec_mux_class;
 	sw->dev.type = &typec_switch_dev_type;
 	sw->dev.driver_data = desc->drvdata;
-	dev_set_name(&sw->dev, "%s-switch",
-		     desc->name ? desc->name : dev_name(parent));
+	ret = dev_set_name(&sw->dev, "%s-switch", desc->name ? desc->name : dev_name(parent));
+	if (ret) {
+		put_device(&sw->dev);
+		return ERR_PTR(ret);
+	}
 
 	ret = device_add(&sw->dev);
 	if (ret) {
@@ -338,8 +341,11 @@ typec_mux_register(struct device *parent, const struct typec_mux_desc *desc)
 	mux->dev.class = &typec_mux_class;
 	mux->dev.type = &typec_mux_dev_type;
 	mux->dev.driver_data = desc->drvdata;
-	dev_set_name(&mux->dev, "%s-mux",
-		     desc->name ? desc->name : dev_name(parent));
+	ret = dev_set_name(&mux->dev, "%s-mux", desc->name ? desc->name : dev_name(parent));
+	if (ret) {
+		put_device(&mux->dev);
+		return ERR_PTR(ret);
+	}
 
 	ret = device_add(&mux->dev);
 	if (ret) {
-- 
2.35.1

