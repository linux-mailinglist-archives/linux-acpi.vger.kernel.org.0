Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4118C50C3E3
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Apr 2022 01:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiDVW5G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Apr 2022 18:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiDVW47 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Apr 2022 18:56:59 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED11376682
        for <linux-acpi@vger.kernel.org>; Fri, 22 Apr 2022 15:21:57 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-d39f741ba0so10034507fac.13
        for <linux-acpi@vger.kernel.org>; Fri, 22 Apr 2022 15:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZN6Zt3nDrquMGvxHt/QElrh6H38NKlikXj3lsOy1lI=;
        b=dSoGWyLvstbL4O3lghCrhJfbLZQ9PPNdEpiAqQBZaeCuTDnM3EHyVR4hCZlbt6YUG0
         7COIeBGGRULeoKoqIdyJdVyoQ2dNh0KYpCJgcxfQ+Hgoh9r5dKnHY9t+8aKkXTRKjqhg
         WHzuwIDLzMZ0WFe/lfX5M/v/eaq9SVAAOLUFcESQmQX/QqJ/s+m/iKuOObFmbhTgbACE
         Hb8r52nPhXwgwhp06wfhayF5zq4pssB0xgvgPwe1YCtqIzT+pJb9b/Nj91Jjk3DImzVR
         PYyWwTf5fze35nZ0hO0B88nNWNnC867JHDGKpHdSDPRsYhYt6Cad0VK7Pcg9l15IA39x
         LdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZN6Zt3nDrquMGvxHt/QElrh6H38NKlikXj3lsOy1lI=;
        b=nbf88yrvM/bH9nutUXQS2MiRw1ZYKLjEM+NcUrEY00NsU24Y82pqqMDWl1x6P4n3Ep
         hOjVs7cKnsVY+UugA9PaOsVWfRDRNkFaaeT1gcncatkC1yU6y8rdjr4moTzfZJdeEDVV
         StJtMXNS8eJmA3kk4V//hn4LaGXnpdWoSXZfRFw/fkSAI/g5QVSdbA5Nd0cNVUg/OhME
         VqpDL++sl76YwUp4b6qUXzDrIUhHBbxEfb9w8NNxD0x3LLwkqJ1sFVMcNOGsLsM7g5ZD
         G6bpvnCOzMzsknW5U4d8QrGCOVIXrQxXQlNsOIquiiiUEmHWtKZ/eXOY4JWGm+ZRQalV
         J/oQ==
X-Gm-Message-State: AOAM533mH5c4PEXPP4IXufSPOgRYx4SiHl/8JOZMbuN5cD9MgBNVVxq8
        ckEJCqJS9GcdwnNW/TOndyaivA==
X-Google-Smtp-Source: ABdhPJxx8HVT12hM8dHtgpR8ya/52JDTLcKh4apdtUfXZReIakG45ZoMf581rVq74RFPawXvKQvkhg==
X-Received: by 2002:a05:6870:9a21:b0:e5:c836:9456 with SMTP id fo33-20020a0568709a2100b000e5c8369456mr2956229oab.282.1650666115987;
        Fri, 22 Apr 2022 15:21:55 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id js4-20020a056870bac400b000e687cdf5adsm1049224oab.55.2022.04.22.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 15:21:55 -0700 (PDT)
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
Subject: [PATCH v5 5/7] usb: typec: mux: Allow multiple mux_devs per mux
Date:   Fri, 22 Apr 2022 15:23:49 -0700
Message-Id: <20220422222351.1297276-6-bjorn.andersson@linaro.org>
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

In the Qualcomm platforms the USB/DP PHY handles muxing and orientation
switching of the SuperSpeed lines, but the SBU lines needs to be
connected and switched by external (to the SoC) hardware.

It's therefor necessary to be able to have the TypeC controller operate
multiple TypeC muxes and switches. Use the newly introduced indirection
object to handle this, to avoid having to taint the TypeC controllers
with knowledge about the downstream hardware configuration.

The max number of devs per indirection is set to 3, which account for
being able to mux/switch the USB HS, SS and SBU lines, as per defined
defined in the usb-c-connector binding. This number could be grown if
need arrises at a later point in time.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- None

 drivers/usb/typec/mux.c | 128 ++++++++++++++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index bb6c095b4af9..fd55c2c516a5 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -17,8 +17,11 @@
 #include "class.h"
 #include "mux.h"
 
+#define TYPEC_MUX_MAX_DEVS	3
+
 struct typec_switch {
-	struct typec_switch_dev *sw_dev;
+	struct typec_switch_dev *sw_devs[TYPEC_MUX_MAX_DEVS];
+	unsigned int num_sw_devs;
 };
 
 static int switch_fwnode_match(struct device *dev, const void *fwnode)
@@ -67,25 +70,50 @@ static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
  */
 struct typec_switch *fwnode_typec_switch_get(struct fwnode_handle *fwnode)
 {
-	struct typec_switch_dev *sw_dev;
+	struct typec_switch_dev *sw_devs[TYPEC_MUX_MAX_DEVS];
 	struct typec_switch *sw;
+	int count;
+	int err;
+	int i;
 
 	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
 	if (!sw)
 		return ERR_PTR(-ENOMEM);
 
-	sw_dev = fwnode_connection_find_match(fwnode, "orientation-switch", NULL,
-					      typec_switch_match);
-	if (IS_ERR_OR_NULL(sw_dev)) {
+	count = fwnode_connection_find_matches(fwnode, "orientation-switch", NULL,
+					       typec_switch_match,
+					       (void **)sw_devs,
+					       ARRAY_SIZE(sw_devs));
+	if (count <= 0) {
 		kfree(sw);
-		return ERR_CAST(sw_dev);
+		return NULL;
 	}
 
-	WARN_ON(!try_module_get(sw_dev->dev.parent->driver->owner));
+	for (i = 0; i < count; i++) {
+		if (IS_ERR(sw_devs[i])) {
+			err = PTR_ERR(sw_devs[i]);
+			goto put_sw_devs;
+		}
+	}
 
-	sw->sw_dev = sw_dev;
+	for (i = 0; i < count; i++) {
+		WARN_ON(!try_module_get(sw_devs[i]->dev.parent->driver->owner));
+		sw->sw_devs[i] = sw_devs[i];
+	}
+
+	sw->num_sw_devs = count;
 
 	return sw;
+
+put_sw_devs:
+	for (i = 0; i < count; i++) {
+		if (!IS_ERR(sw_devs[i]))
+			put_device(&sw_devs[i]->dev);
+	}
+
+	kfree(sw);
+
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(fwnode_typec_switch_get);
 
@@ -98,14 +126,17 @@ EXPORT_SYMBOL_GPL(fwnode_typec_switch_get);
 void typec_switch_put(struct typec_switch *sw)
 {
 	struct typec_switch_dev *sw_dev;
+	unsigned int i;
 
 	if (IS_ERR_OR_NULL(sw))
 		return;
 
-	sw_dev = sw->sw_dev;
+	for (i = 0; i < sw->num_sw_devs; i++) {
+		sw_dev = sw->sw_devs[i];
 
-	module_put(sw_dev->dev.parent->driver->owner);
-	put_device(&sw_dev->dev);
+		module_put(sw_dev->dev.parent->driver->owner);
+		put_device(&sw_dev->dev);
+	}
 	kfree(sw);
 }
 EXPORT_SYMBOL_GPL(typec_switch_put);
@@ -173,13 +204,21 @@ int typec_switch_set(struct typec_switch *sw,
 		     enum typec_orientation orientation)
 {
 	struct typec_switch_dev *sw_dev;
+	unsigned int i;
+	int ret;
 
 	if (IS_ERR_OR_NULL(sw))
 		return 0;
 
-	sw_dev = sw->sw_dev;
+	for (i = 0; i < sw->num_sw_devs; i++) {
+		sw_dev = sw->sw_devs[i];
+
+		ret = sw_dev->set(sw_dev, orientation);
+		if (ret)
+			return ret;
+	}
 
-	return sw_dev->set(sw_dev, orientation);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(typec_switch_set);
 
@@ -211,7 +250,8 @@ EXPORT_SYMBOL_GPL(typec_switch_get_drvdata);
 /* ------------------------------------------------------------------------- */
 
 struct typec_mux {
-	struct typec_mux_dev *mux_dev;
+	struct typec_mux_dev *mux_devs[TYPEC_MUX_MAX_DEVS];
+	unsigned int num_mux_devs;
 };
 
 static int mux_fwnode_match(struct device *dev, const void *fwnode)
@@ -294,25 +334,50 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
 struct typec_mux *fwnode_typec_mux_get(struct fwnode_handle *fwnode,
 				       const struct typec_altmode_desc *desc)
 {
-	struct typec_mux_dev *mux_dev;
+	struct typec_mux_dev *mux_devs[TYPEC_MUX_MAX_DEVS];
 	struct typec_mux *mux;
+	int count;
+	int err;
+	int i;
 
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
 		return ERR_PTR(-ENOMEM);
 
-	mux_dev = fwnode_connection_find_match(fwnode, "mode-switch", (void *)desc,
-					       typec_mux_match);
-	if (IS_ERR_OR_NULL(mux_dev)) {
+	count = fwnode_connection_find_matches(fwnode, "mode-switch",
+					       (void *)desc, typec_mux_match,
+					       (void **)mux_devs,
+					       ARRAY_SIZE(mux_devs));
+	if (count <= 0) {
 		kfree(mux);
-		return ERR_CAST(mux_dev);
+		return NULL;
 	}
 
-	WARN_ON(!try_module_get(mux_dev->dev.parent->driver->owner));
+	for (i = 0; i < count; i++) {
+		if (IS_ERR(mux_devs[i])) {
+			err = PTR_ERR(mux_devs[i]);
+			goto put_mux_devs;
+		}
+	}
+
+	for (i = 0; i < count; i++) {
+		WARN_ON(!try_module_get(mux_devs[i]->dev.parent->driver->owner));
+		mux->mux_devs[i] = mux_devs[i];
+	}
 
-	mux->mux_dev = mux_dev;
+	mux->num_mux_devs = count;
 
 	return mux;
+
+put_mux_devs:
+	for (i = 0; i < count; i++) {
+		if (!IS_ERR(mux_devs[i]))
+			put_device(&mux_devs[i]->dev);
+	}
+
+	kfree(mux);
+
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(fwnode_typec_mux_get);
 
@@ -325,13 +390,16 @@ EXPORT_SYMBOL_GPL(fwnode_typec_mux_get);
 void typec_mux_put(struct typec_mux *mux)
 {
 	struct typec_mux_dev *mux_dev;
+	unsigned int i;
 
 	if (IS_ERR_OR_NULL(mux))
 		return;
 
-	mux_dev = mux->mux_dev;
-	module_put(mux_dev->dev.parent->driver->owner);
-	put_device(&mux_dev->dev);
+	for (i = 0; i < mux->num_mux_devs; i++) {
+		mux_dev = mux->mux_devs[i];
+		module_put(mux_dev->dev.parent->driver->owner);
+		put_device(&mux_dev->dev);
+	}
 	kfree(mux);
 }
 EXPORT_SYMBOL_GPL(typec_mux_put);
@@ -339,13 +407,21 @@ EXPORT_SYMBOL_GPL(typec_mux_put);
 int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 {
 	struct typec_mux_dev *mux_dev;
+	unsigned int i;
+	int ret;
 
 	if (IS_ERR_OR_NULL(mux))
 		return 0;
 
-	mux_dev = mux->mux_dev;
+	for (i = 0; i < mux->num_mux_devs; i++) {
+		mux_dev = mux->mux_devs[i];
+
+		ret = mux_dev->set(mux_dev, state);
+		if (ret)
+			return ret;
+	}
 
-	return mux_dev->set(mux_dev, state);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(typec_mux_set);
 
-- 
2.35.1

