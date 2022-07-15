Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD99575E07
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jul 2022 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiGOIvg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jul 2022 04:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiGOIuw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2022 04:50:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9230C8239F
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 01:50:48 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t1so6769263lft.8
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 01:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NP3se/v+PuUKcQzIVvkexwGw74o8V8786Z6WGRgnFd4=;
        b=T1AAWzyWHscRbhdS3ButzMw0CabKXq0cifLUUd0wszCigDtPwU+z8OiyTMscLUk0vx
         lycERdVrvbGyqYO/rzmIXtJp2TVZX6/Ko/QfPBaTKh6nPqm9XGLig3V3V/u4YC5JKZcU
         /fjy7/hQIQsG3e6mU2sdy/1g0j366PROruhTALEIppwVs3VeTFyLUBCKUTSyhCRw/J4Y
         fwi/MEuw50OGzqFunexOlL+BDtSLqkOY/OGbxxjv4MgIzsVr60ck91q6U3hgvDSmUpwq
         6R4LI8wLDc4+YB6dXjDkSO9IQgL6whgqp2oBis4fAHtvwFYyIb8aapRofVIohJKDdOy+
         WLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NP3se/v+PuUKcQzIVvkexwGw74o8V8786Z6WGRgnFd4=;
        b=KwyhUmDYAq6qZPM1PW8SAph/YcT1rKn0G0+Df/6Nvq0kbAl0BiS+6xYMC6X/0Za7WU
         e4l4JvWnEUYOmEuQc1SKi958dx/2V4uLViwL42A6SrbEoCtfYc7pU4xTYYIyexYnEPFP
         kxzdmSV67MlbA+PbunZop3iKWSifYrbDe2+XZVZSoEzBrjdksbNGwtBGdlnlrt+xWB05
         k1UmWe/K0eESLGPmbxyW6PlBe47xR7yHSirkEw2b5tBLwX+yihuTXisxiL5Pay91vKIL
         O1gbLSsJecw5OwvoPnH+DMyLa8nbAiSywV1COQAkLp/HVOxOzaqRbSPWm4sBDcnvFLUn
         C5Jw==
X-Gm-Message-State: AJIora/xuTxK5xglPHa538zQiJy79Q8SDVOFvYxpLj+ThJ1Omj2VCREO
        VUbDbr3bY9Pi+X/LogaK+kgeMQ==
X-Google-Smtp-Source: AGRyM1sBfVkmYm14X9HuLxbsoNDGodL7vOsJqQoD9ZLXB6h07RwQpFb90Cm16jRuckKPSICUHXNZoA==
X-Received: by 2002:a05:6512:3e2a:b0:489:cf16:2d90 with SMTP id i42-20020a0565123e2a00b00489cf162d90mr7228043lfv.594.1657875046911;
        Fri, 15 Jul 2022 01:50:46 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id e4-20020a2e9e04000000b0025d773448basm667846ljk.23.2022.07.15.01.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 01:50:46 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        sean.wang@mediatek.com, Landen.Chao@mediatek.com,
        linus.walleij@linaro.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux@armlinux.org.uk, hkallweit1@gmail.com, gjb@semihalf.com,
        mw@semihalf.com, jaz@semihalf.com, tn@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, upstream@semihalf.com
Subject: [net-next: PATCH v2 5/8] device property: introduce fwnode_dev_node_match
Date:   Fri, 15 Jul 2022 10:50:09 +0200
Message-Id: <20220715085012.2630214-6-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220715085012.2630214-1-mw@semihalf.com>
References: <20220715085012.2630214-1-mw@semihalf.com>
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

This patch adds a new generic routine fwnode_dev_node_match
that can be used e.g. as a callback for class_find_device().
It searches for the struct device corresponding to a
struct fwnode_handle by iterating over device and
its parents.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 include/linux/property.h |  2 ++
 drivers/base/property.c  | 22 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 23330ae2b1fa..21b59ad08a39 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -456,6 +456,8 @@ int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
 				   devcon_match_fn_t match,
 				   void **matches, unsigned int matches_len);
 
+int fwnode_dev_node_match(struct device *dev, const void *data);
+
 /* -------------------------------------------------------------------------- */
 /* Software fwnode support - when HW description is incomplete or missing */
 
diff --git a/drivers/base/property.c b/drivers/base/property.c
index ed6f449f8e5c..839e7d586129 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1344,3 +1344,25 @@ int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
 	return count_graph + count_ref;
 }
 EXPORT_SYMBOL_GPL(fwnode_connection_find_matches);
+
+/*
+ * fwnode_dev_node_match - look for a device matching the struct fwnode_handle
+ * @dev: the struct device to initiate the search
+ * @data: pointer to the fwnode_handle
+ *
+ * Looks up the device structure corresponding with the fwnode by iterating
+ * over @dev and its parents.
+ * The routine can be used e.g. as a callback for class_find_device().
+ *
+ * Return: 1 - if match is found, 0 - otherwise.
+ */
+int fwnode_dev_node_match(struct device *dev, const void *data)
+{
+	for (; dev; dev = dev->parent) {
+		if (device_match_fwnode(dev, data))
+			return 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fwnode_dev_node_match);
-- 
2.29.0

