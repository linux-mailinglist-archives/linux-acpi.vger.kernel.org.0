Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA1D582046
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jul 2022 08:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiG0Gog (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jul 2022 02:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiG0GoL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jul 2022 02:44:11 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B865419AD
        for <linux-acpi@vger.kernel.org>; Tue, 26 Jul 2022 23:43:51 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u17so8624754lji.5
        for <linux-acpi@vger.kernel.org>; Tue, 26 Jul 2022 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjpPOw/EHkdGMlNJx96x3tiCm2I3MhnvsH5Bdl+D29E=;
        b=eaw0CSRmVCkatxLGZl8bUwnuKZqXHQmUWTrF+8ClFW+gQ+9nkwgzFmxXSTo0VK0RbC
         aV4dIUCd2t5RH2ECwdVSLNJydWtb7HpjuulvoE7z2UM/j0gCGG++g9KYh2JHI0GNLWBj
         S6HgOpQZcWXfE7pE1QQVqYk54vEerMk55ek4xUXekKIiojkJBeMT86Fe3eDNe18qyb2g
         5TsYchAHEV4HtRX37aQd78d4S5JfwXXH9afyAP+BUzdGemP/K60BZ1wEY1bpyqq9c4Ht
         M8xbVByvmTcxrdO+Oo1Azy12WA8R3tnv5BnEG6VHhQ6u9zozukNlYH6wfjlRJI618HAe
         ePQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjpPOw/EHkdGMlNJx96x3tiCm2I3MhnvsH5Bdl+D29E=;
        b=DuuNi3N0wI7K5JzGuh6nxNz/6nKyn0E9PnmfLnuQbu4h3q9Dt9tap6sg/ca89Z7E9s
         Ldn1jfygqUQ6/W3chCjXKEuLOTui1UKHuOeoqY1U3G4IAziTw/3Sa6g3UFSR/sZ2sMO6
         H5Bh6C7XCvfZ3lj7bjHLfjfWhYk0n9aUvQgTwrZg7Wu1d9x1zkVWfm8AaTrDBy3QsEK5
         00JpKM1HPXNnAgXInzSzGqa8TnMe/Pf6dFOYZhveEFEJgKJgnqV98ewnqNs7Md8PMLRc
         hok0D5pNchUFX72QAmO2Mec/pzTX/ogBmXYDuDvUX/7BgBsR3A3rsORyNg9/twVZftmm
         1Acw==
X-Gm-Message-State: AJIora9+1f+wegeDIejYMvFYlyoqpWdOmMxVfQPNT8RtYJYfIV49KCBC
        Ef5Llvbz4QqIVbREdByJNTldOw==
X-Google-Smtp-Source: AGRyM1s0sRFTSUqI9uwyloFsy7TMvBWrfyPieQcx1tIMUxMjzvRQhRmhkmi48m6OKXIMRsCJE25Y6Q==
X-Received: by 2002:a2e:9cd8:0:b0:25e:ec:237c with SMTP id g24-20020a2e9cd8000000b0025e00ec237cmr5283663ljj.277.1658904230528;
        Tue, 26 Jul 2022 23:43:50 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id w19-20020a05651234d300b0048a97a1df02sm1157231lfr.6.2022.07.26.23.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:43:50 -0700 (PDT)
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
Subject: [net-next: PATCH v3 8/8] net: dsa: mv88e6xxx: switch to device_/fwnode_ APIs
Date:   Wed, 27 Jul 2022 08:43:21 +0200
Message-Id: <20220727064321.2953971-9-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220727064321.2953971-1-mw@semihalf.com>
References: <20220727064321.2953971-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In order to support both DT and ACPI in future, modify the
mv88e6xx driver  code to use device_/fwnode_ equivalent routines.
No functional change is introduced by this patch.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 43 +++++++++-----------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index a46ebdfba1c3..e7848b56316f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3891,10 +3891,11 @@ static int mv88e6xxx_mdio_write(struct mii_bus *bus, int phy, int reg, u16 val)
 }
 
 static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
-				   struct device_node *np,
+				   struct fwnode_handle *fwnode,
 				   bool external)
 {
 	static int index;
+	struct device_node *np = to_of_node(fwnode);
 	struct mv88e6xxx_mdio_bus *mdio_bus;
 	struct mii_bus *bus;
 	int err;
@@ -3973,18 +3974,18 @@ static void mv88e6xxx_mdios_unregister(struct mv88e6xxx_chip *chip)
 }
 
 static int mv88e6xxx_mdios_register(struct mv88e6xxx_chip *chip,
-				    struct device_node *np)
+				    struct fwnode_handle *fwnode)
 {
-	struct device_node *child;
+	struct fwnode_handle *child;
 	int err;
 
 	/* Always register one mdio bus for the internal/default mdio
 	 * bus. This maybe represented in the device tree, but is
 	 * optional.
 	 */
-	child = of_get_child_by_name(np, "mdio");
+	child = fwnode_get_named_child_node(fwnode, "mdio");
 	err = mv88e6xxx_mdio_register(chip, child, false);
-	of_node_put(child);
+	fwnode_handle_put(child);
 	if (err)
 		return err;
 
@@ -3992,13 +3993,13 @@ static int mv88e6xxx_mdios_register(struct mv88e6xxx_chip *chip,
 	 * which say they are compatible with the external mdio
 	 * bus.
 	 */
-	for_each_available_child_of_node(np, child) {
-		if (of_device_is_compatible(
-			    child, "marvell,mv88e6xxx-mdio-external")) {
+	fwnode_for_each_available_child_node(fwnode, child) {
+		if (fwnode_property_match_string(child, "compatible",
+						 "marvell,mv88e6xxx-mdio-external") == 0) {
 			err = mv88e6xxx_mdio_register(chip, child, true);
 			if (err) {
 				mv88e6xxx_mdios_unregister(chip);
-				of_node_put(child);
+				fwnode_handle_put(child);
 				return err;
 			}
 		}
@@ -6984,20 +6985,16 @@ static SIMPLE_DEV_PM_OPS(mv88e6xxx_pm_ops, mv88e6xxx_suspend, mv88e6xxx_resume);
 static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 {
 	struct dsa_mv88e6xxx_pdata *pdata = mdiodev->dev.platform_data;
+	struct fwnode_handle *fwnode = dev_fwnode(&mdiodev->dev);
 	const struct mv88e6xxx_info *compat_info = NULL;
 	struct device *dev = &mdiodev->dev;
-	struct device_node *np = dev->of_node;
 	struct mv88e6xxx_chip *chip;
 	int port;
 	int err;
 
-	if (!np && !pdata)
-		return -EINVAL;
-
-	if (np)
-		compat_info = of_device_get_match_data(dev);
-
-	if (pdata) {
+	if (fwnode)
+		compat_info = device_get_match_data(dev);
+	else if (pdata) {
 		compat_info = pdata_device_get_match_data(dev);
 
 		if (!pdata->netdev)
@@ -7054,9 +7051,9 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	mv88e6xxx_phy_init(chip);
 
 	if (chip->info->ops->get_eeprom) {
-		if (np)
-			of_property_read_u32(np, "eeprom-length",
-					     &chip->eeprom_len);
+		if (fwnode)
+			device_property_read_u32(dev, "eeprom-length",
+						 &chip->eeprom_len);
 		else
 			chip->eeprom_len = pdata->eeprom_len;
 	}
@@ -7067,8 +7064,8 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	if (err)
 		goto out;
 
-	if (np) {
-		chip->irq = of_irq_get(np, 0);
+	if (fwnode) {
+		chip->irq = fwnode_irq_get(fwnode, 0);
 		if (chip->irq == -EPROBE_DEFER) {
 			err = chip->irq;
 			goto out;
@@ -7106,7 +7103,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	if (err)
 		goto out_g1_atu_prob_irq;
 
-	err = mv88e6xxx_mdios_register(chip, np);
+	err = mv88e6xxx_mdios_register(chip, fwnode);
 	if (err)
 		goto out_g1_vtu_prob_irq;
 
-- 
2.29.0

