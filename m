Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851B62D1DA
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2019 01:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfE1XCk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 May 2019 19:02:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35069 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbfE1XCi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2019 19:02:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so263675pfd.2
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2019 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=babayev.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TApL13/IWHA6p9W6T8SV9xqxLEQgsxufxiO/2MDfUXk=;
        b=ZJOaWquNqgKZhJQs1PTXJ/31Y1TjjQ9lC9SHCR217UhvWrr4xvnjYN4WTtKJ2Nw7fc
         oMG1hpBNCnR1QJ5xZK0IarzmvhJG1zAVTZMoIecQ5gD3T4291/3xM8jhLP6dbHvQH2LC
         FPIFnrlGT5Vckw16/MfPBp5A2TPLouNKttnEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TApL13/IWHA6p9W6T8SV9xqxLEQgsxufxiO/2MDfUXk=;
        b=XdlR7YwJPE8q2C/lB3j0Bt8/wiZ9AU/BTlCsFLzuRUm+ZU1DmkG1dzyCO4AncgckgW
         rI+2d1fvmkmwBuBmGjR8IJOlZbHyp8w+NRf6rcfnp5R/JgEgwepu3HZQ6ade4sZpEwwO
         HWIfhSr3nclCKeaXIH0Gb8BUX3pzKIYpC4oS5TBY25hivk33yEHawA0WACFFYnGVVdqq
         HTqZ4lugfhem3J4PkrtWfJqIP76oh97a/we+fdt0UQfAUZ5LHZeuCsXQIuIWTBLbaiOU
         ijwi9rAMBSqTCx6bb9xoFs7ixQwAK7FessvuHyP62L1MDM+Y8NP/2R9L0Df+xWtwtsMg
         GU8g==
X-Gm-Message-State: APjAAAWSUSA7tgyUDZ+BbVtYLRFLRMpXffbn4Fb/1I1mKpgAzEFPNX6U
        40sY08YDaZWt01YAh2YpOZQwrA==
X-Google-Smtp-Source: APXvYqy9yJ3BtjJVCvwuUdO32bTMEQjQdREbeUgAJAa4cyo80WRBRVUwmVf36AEon+bBBhIOd6wDhw==
X-Received: by 2002:aa7:8f16:: with SMTP id x22mr76577654pfr.202.1559084557329;
        Tue, 28 May 2019 16:02:37 -0700 (PDT)
Received: from p50.cisco.com ([128.107.241.183])
        by smtp.gmail.com with ESMTPSA id p16sm27028196pfq.153.2019.05.28.16.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 16:02:36 -0700 (PDT)
From:   Ruslan Babayev <ruslan@babayev.com>
To:     mika.westerberg@linux.intel.com, wsa@the-dreams.de,
        linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        xe-linux-external@cisco.com
Subject: [net-next,v4 2/2] net: phy: sfp: enable i2c-bus detection on ACPI based systems
Date:   Tue, 28 May 2019 16:02:33 -0700
Message-Id: <20190528230233.26772-3-ruslan@babayev.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190528230233.26772-1-ruslan@babayev.com>
References: <20190528230233.26772-1-ruslan@babayev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Lookup I2C adapter using the "i2c-bus" device property on ACPI based
systems similar to how it's done with DT.

An example DSD describing an SFP on an ACPI based system:

Device (SFP0)
{
    Name (_HID, "PRP0001")
    Name (_CRS, ResourceTemplate()
    {
        GpioIo(Exclusive, PullDefault, 0, 0, IoRestrictionNone,
               "\\_SB.PCI0.RP01.GPIO", 0, ResourceConsumer)
            { 0, 1, 2, 3, 4 }
    })
    Name (_DSD, Package ()
    {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
            Package () { "compatible", "sff,sfp" },
            Package () { "i2c-bus", \_SB.PCI0.RP01.I2C.MUX.CH0 },
            Package () { "maximum-power-milliwatt", 1000 },
            Package () { "tx-disable-gpios", Package () { ^SFP0, 0, 0, 1} },
            Package () { "reset-gpio",       Package () { ^SFP0, 0, 1, 1} },
            Package () { "mod-def0-gpios",   Package () { ^SFP0, 0, 2, 1} },
            Package () { "tx-fault-gpios",   Package () { ^SFP0, 0, 3, 0} },
            Package () { "los-gpios",        Package () { ^SFP0, 0, 4, 1} },
        },
    })
}

Device (PHY0)
{
    Name (_HID, "PRP0001")
    Name (_DSD, Package ()
    {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
            Package () { "compatible", "ethernet-phy-ieee802.3-c45" },
            Package () { "sfp", \_SB.PCI0.RP01.SFP0 },
            Package () { "managed", "in-band-status" },
            Package () { "phy-mode", "sgmii" },
        },
    })
}

Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
Cc: xe-linux-external@cisco.com
---
 drivers/net/phy/sfp.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index d4635c2178d1..554acc869c25 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/acpi.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -1782,6 +1783,7 @@ static void sfp_cleanup(void *data)
 static int sfp_probe(struct platform_device *pdev)
 {
 	const struct sff_data *sff;
+	struct i2c_adapter *i2c;
 	struct sfp *sfp;
 	bool poll = false;
 	int irq, err, i;
@@ -1801,7 +1803,6 @@ static int sfp_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node) {
 		struct device_node *node = pdev->dev.of_node;
 		const struct of_device_id *id;
-		struct i2c_adapter *i2c;
 		struct device_node *np;
 
 		id = of_match_node(sfp_of_match, node);
@@ -1818,14 +1819,32 @@ static int sfp_probe(struct platform_device *pdev)
 
 		i2c = of_find_i2c_adapter_by_node(np);
 		of_node_put(np);
-		if (!i2c)
-			return -EPROBE_DEFER;
-
-		err = sfp_i2c_configure(sfp, i2c);
-		if (err < 0) {
-			i2c_put_adapter(i2c);
-			return err;
+	} else if (has_acpi_companion(&pdev->dev)) {
+		struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+		struct fwnode_handle *fw = acpi_fwnode_handle(adev);
+		struct fwnode_reference_args args;
+		struct acpi_handle *acpi_handle;
+		int ret;
+
+		ret = acpi_node_get_property_reference(fw, "i2c-bus", 0, &args);
+		if (ACPI_FAILURE(ret) || !is_acpi_device_node(args.fwnode)) {
+			dev_err(&pdev->dev, "missing 'i2c-bus' property\n");
+			return -ENODEV;
 		}
+
+		acpi_handle = ACPI_HANDLE_FWNODE(args.fwnode);
+		i2c = i2c_acpi_find_adapter_by_handle(acpi_handle);
+	} else {
+		return -EINVAL;
+	}
+
+	if (!i2c)
+		return -EPROBE_DEFER;
+
+	err = sfp_i2c_configure(sfp, i2c);
+	if (err < 0) {
+		i2c_put_adapter(i2c);
+		return err;
 	}
 
 	for (i = 0; i < GPIO_MAX; i++)
-- 
2.19.2

