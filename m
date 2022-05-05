Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FAC51C21A
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380499AbiEEOS3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 May 2022 10:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380492AbiEEOSZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2022 10:18:25 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2056.outbound.protection.outlook.com [40.107.102.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C4F5A08B;
        Thu,  5 May 2022 07:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m66XOuwBl/b0ovzuSvnvOL8dPYLBGXpzJfwDSvjmZMREivXSHJC5ON1OI2ckiBwolyaJx6XyasLnKipW2O6sZjZdTgrKj6XtyYl2rpPlMkqWJOXyky7I5GUJqvjKKp/2ZYLLDs061pmM00xNxIiudqKU41v9N7Esmu1YHA/492UZHISSKM1x+4rRfTLYjh3ex/mt0z3u7iqRCeAxExm7EGfUUCTPBYbIh/Ntm0gYTzUH+Tpt+oyVswMzbjZY2Z8kWvFCmEPu5jhpgt81mfgE6xlneb/hqzDnb4h+V/3cLRiSellYbf1pf3jcXFzrXdmRjTPcb9XcOru10eFtVDf+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCVlehqiyL45RZAUzPXD+jLKsIhw/xp2kY7NN+B1FdQ=;
 b=lj4Au/ZUhFUS1n+FlH6YNfCYnizlypjcka/1hVHLa72PFQvDOUKWh5jsD5WzOeZhB+vgVB0/olD4YfLmCBRdJUmMbg2buuXJh44kd+0jLPNYRslnHbRfvGrzvCTZIgFO2qZQHta4eexakr0n/lh8yMWRGk7jXs3eb5HlwlEYEPb87RAGBgG4vniQ4+yFLIIkcceRHo/Nu/wJt9a1nKQgBFPN2fdfHlO7YWs8kE0mge5QnRrhvCdLFD+CZn06Q1BK6qYM/8a+ZvxSpwrDC05dov3v63jbX5C2g3IYAi6KyUqJEHC3QbRjELY0yIDyyQwO4rdw4LHyXJ8G5/3ONaHTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCVlehqiyL45RZAUzPXD+jLKsIhw/xp2kY7NN+B1FdQ=;
 b=dMWWBSDlDYfWXjoQG6638WJEdnkzCYKeeC5enLJuQDhT7Wm2DI+UO5KxjNWxGO+0a5eM/KpuqAwKmTxHdTNS3XmbIw144Sc/DRmahxVaWxXGAuqix7445VzhoPO8L4Lc/fWfY7VRGdJoGRodjHBMpWK5lDdOpn/p6jyZO2BfPCBGtFOVT/BZNKaALKc8UNRKJ9SKxOqCe0754o6CNoUzB97QlwavTYlapHZI+wUEKIx0U4/X1zqcy4JDpU2dmMT+as2hx9X53wwwUDFrGbqhJMuqxibHBgbPD59hh7+VdjKVqtT9BUWRipGZREJyXHYK9wBSBi4QT8eCpcA1jxpGcw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CY4PR12MB1223.namprd12.prod.outlook.com (2603:10b6:903:38::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 14:14:43 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::fd9e:abad:8541:b221]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::fd9e:abad:8541:b221%3]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 14:14:43 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] Add driver for Mellanox BlueField-3 GPIO
 controller
Thread-Topic: [PATCH v1 1/1] Add driver for Mellanox BlueField-3 GPIO
 controller
Thread-Index: AQHYUy6f8PYDEwnjH0GY1hRsyl4qdK0QbjTw
Date:   Thu, 5 May 2022 14:14:43 +0000
Message-ID: <CH2PR12MB3895A1FB2977B725ED92AB57D7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20220418141416.27529-1-asmaa@nvidia.com>
In-Reply-To: <20220418141416.27529-1-asmaa@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0b697b0-1a4c-4784-e427-08da2ea199d3
x-ms-traffictypediagnostic: CY4PR12MB1223:EE_
x-microsoft-antispam-prvs: <CY4PR12MB122374B993C6DF203DE52E9BD7C29@CY4PR12MB1223.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EMzwjlPvvWwpdtUWcQq/htFVyhh+9PdM9bljcagpypx2bV2uFULGnzJPIBl9Gce1ngpWVE4pMLDY4UwUpRHxxC8ihfcSnt+ctBINhSSogV2qYTnnTCakI8axZjB8t9noXmnAQ+R7vOXaBlZIRkq+6/aqzvH9PRsO9fw6woza/2VZ/+OO4Vmcfex5XH806zvGKerdCTZihYccSP2c+tSVAl2y5fT/Gq4axpAc8T9E2U2G1OXq27FSxMNLMhYlkpC2Y7maP7BqBO2E1Dgqd35bYtdi7ag7bSEUx8PGIjOlR1OvfJD1EQZ5lnEQA1srx602/28KXugjR9XvEDMO8dEYhoNYJFw7A/yV/ZUd+O0LnjRN7ZHCi23g8JYrmTzro+7WB6bYKVKGvWXcN17JXpY87N9INi5j8bUEWbwuB1uFqRKaEWuo1GeVX4e8rB5NgVA3Boj+OPdxSvbZduMWTbItNn6BSx+4n+iyDFC8S0ctPAnluwkxcoJ1IcIrJrSQGP5atrQn9zRvkFFcYEXbWYOFhm/33uqz3YpfeKd9gjLzfY1nqzgVp0Ueebb/7qiT+UDQZHJTYGE1NjqVbAJLHl0m+lAcsvj+drWDmBdhDdANjOY93t2H8IZnSOxRRTT0a8m3iSDuGl++b9jLZt9NL/9ReG86YqvCaGKgpJS3+gZS7U3VnIhhYRNFQL86yKaoHA5XIR7yFROjAqt++tisyuUy7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6506007)(9686003)(53546011)(33656002)(7696005)(26005)(122000001)(86362001)(38070700005)(38100700002)(55016003)(30864003)(110136005)(83380400001)(5660300002)(508600001)(316002)(66946007)(76116006)(8676002)(66556008)(8936002)(66476007)(52536014)(66446008)(64756008)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yc+6XTbygUv2NuA5vt4eYaNkgqkR7/TayTcgBmYBkTeiyneo/d7m/yHV0FU1?=
 =?us-ascii?Q?nW/C2Tgcqa7UFRhbHOKjr7DUq1CDtlJTYCy7l0k8WslKw5wW4vpAVexb2Ahp?=
 =?us-ascii?Q?8vDR2XUzp395gptUZG8seXcJ5MUt0yCYHrZd+KDGkZr1E11xg6vDSFGhOg7Q?=
 =?us-ascii?Q?Ekf2AP48QHbsP0noDoovicxnUPyw767MVHbeFCC7+vr1st7jAcassgL8xKUq?=
 =?us-ascii?Q?5gLCmNEf5xXJ/hjLrzKoDQsyPmxQpei7P06SRSXevWQa/nGYfDWaVc7HfbKJ?=
 =?us-ascii?Q?SbKt/AsD+18aXsL74TuCiszscuHfWDts1RnqQMOmDb3Q+oGDRHLyX3gujD5x?=
 =?us-ascii?Q?J8f6QZ4YCq7eyFNh/Sb9M4gGdgGfxgM5HRnTjnGg1T0gN+q7Y1KDKq6Ag+ye?=
 =?us-ascii?Q?n752GHaQtLEr4zMEXNpo8bFqoxbUz6vnidcJZgdUOLmpPWnDbe418u82m0lT?=
 =?us-ascii?Q?DNBIgPHD9FuJBrfAHVds+DvGAeElImGrxeJpUSm0eFxjDHJC0QLlFfKT8Com?=
 =?us-ascii?Q?B0jjK4i74ex1oYWun4jnkmcpzSnF4HhbeGtpuqkdFGWpKSmyRGvViK5q6pix?=
 =?us-ascii?Q?NFj057lcbHvVd2f80ZP5xeQA4dy7HvrlOf4T4kYr99gXSqqQr3JFc6lpsSqe?=
 =?us-ascii?Q?ubXEMPgnHskS5SLiyvDZSdM8mId5vM6d95suWehQW4aLOZyFPvPD5z3J1m2O?=
 =?us-ascii?Q?eSEWyBphC9scOxj4uphDn74MeU1R+VdUbbfSCFptxSErGRvBQBBuhlWweQZM?=
 =?us-ascii?Q?cfGmtDKYotu/puno6IDMARBhfWjcU6QZYrJumZTwhcArsKfCp6JVjDy96zKN?=
 =?us-ascii?Q?PbXZWN0ULrvnJWGdJzuwJFVIebYp4BMBcQMYFr+Q14Z/Q2i7508swge1Le/+?=
 =?us-ascii?Q?nmCqOc7gn2xNiYTYdnHHNss8jE2v9cwfJXBzj8dGTcWchhVKgqCDg8J7zZDA?=
 =?us-ascii?Q?Tn/C128l3J+kRE4/Z97BK5NZRXpJzcr4cmRsbXnw4rEEzDfmTfdvkzEEKgQ5?=
 =?us-ascii?Q?JKd5HA/OH9xHe5XM7HB6flBK826DhmsvEZD3e7lu6qTbB6gRrf8I9++zdy1E?=
 =?us-ascii?Q?yzp/ImPF2H71IasAz3Nlo3ivDZ7SQPuD25buPGGzFixGn6ACuk5umCmmVZOQ?=
 =?us-ascii?Q?SAsXF/fjhvT4mda91s+eTBYttxxZwgn4szNEjxN+GjgSIVZBenYpt5x1PgKX?=
 =?us-ascii?Q?uZssRCdvGnLX6yRgAEda4UjZnoUbmcsGT3z8GLWw0nTFNOQXqs1gRtgeQKCP?=
 =?us-ascii?Q?Tkzd/gK/BPfQjq+ncj0StnLg11U/j1EfuyIWI5LHzTZJKRBVGf62sCI03aEV?=
 =?us-ascii?Q?w/u5CFATmqTH93e3HXQ045bBvy2xtMieM2I4JuvgYN6FSwTQyDwBUN7xJXD5?=
 =?us-ascii?Q?JxkfTINQldhRY5xa0BSNSbnC09AV+GT7LG/Vi9m2k9pzCuAGGM6LRxbDstm4?=
 =?us-ascii?Q?0IBo+8fsnb6BYlTllkmFTSGRsESy7xRairNqqMv+XkT8wMbgGta6czjhvniF?=
 =?us-ascii?Q?6zjVy7xr+IXLRbLSRrCR87KWpJL1HLu/dCJvO/t3Vl27eTsI48j8EOGgf2mR?=
 =?us-ascii?Q?wToJF4aGZCBJPOPeyo1oUfRGt0sQ1LjN17fm8Lok6RsLDSQGB+13bg5F4WOy?=
 =?us-ascii?Q?Lwb7nAFlsBgcTnMLhSaNo2cyQRIL1424Ka2/cXfhKjYn4afVS16Wag6TRe8s?=
 =?us-ascii?Q?dS2eXaUfImCI3XhOs5HqB5zD35DCS40CJVHju5CtJj8xhsAA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b697b0-1a4c-4784-e427-08da2ea199d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 14:14:43.1290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5mlhZEA6WJoK4aTiW2cFC8BoNWOCJX+CHgxrFSi31KmJ1hZvgH2i5aMBqz6pEPwgO0gsC69CymaK6XFYqvhIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1223
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Could you please have a look at this patch?

Thank you,
Asmaa

-----Original Message-----
From: Asmaa Mnebhi <asmaa@nvidia.com>=20
Sent: Monday, April 18, 2022 10:14 AM
To: andy.shevchenko@gmail.com; linus.walleij@linaro.org; bgolaszewski@bayli=
bre.com; linux-gpio@vger.kernel.org; linux-acpi@vger.kernel.org
Cc: Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 1/1] Add driver for Mellanox BlueField-3 GPIO controller
Importance: High

This patch adds support for the GPIO controller used by Mellanox BlueField-=
3 SOCs.
By default (after a reset for example), only the hardware has control over =
the GPIO values.
The GPIOs need to be configured accordingly for the software to control the=
m.
We don't allow the user to manipulate the GPIO pins unless it is allowed by=
 the ACPI table property "ctrl_gpio_mask".

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/gpio/Kconfig       |   7 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-mlxbf3.c | 337 +++++++++++++++++++++++++++++++++++++
 3 files changed, 345 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf3.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig index 45764ec3b2eb=
..d470117e7254 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1530,6 +1530,13 @@ config GPIO_MLXBF2
 	help
 	  Say Y here if you want GPIO support on Mellanox BlueField 2 SoC.
=20
+config GPIO_MLXBF3
+	tristate "Mellanox BlueField 3 SoC GPIO"
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || (64BIT && COMPILE_TEST=
)
+	select GPIO_GENERIC
+	help
+	  Say Y here if you want GPIO support on Mellanox BlueField 3 SoC.
+
 config GPIO_ML_IOH
 	tristate "OKI SEMICONDUCTOR ML7213 IOH GPIO support"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile index 14352f6dfe=
8e..eb24e8e4c4e1 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_GPIO_MERRIFIELD)		+=3D gpio-merrifield.o
 obj-$(CONFIG_GPIO_ML_IOH)		+=3D gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MLXBF)		+=3D gpio-mlxbf.o
 obj-$(CONFIG_GPIO_MLXBF2)		+=3D gpio-mlxbf2.o
+obj-$(CONFIG_GPIO_MLXBF3)		+=3D gpio-mlxbf3.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)		+=3D gpio-mm-lantiq.o
 obj-$(CONFIG_GPIO_MOCKUP)		+=3D gpio-mockup.o
 obj-$(CONFIG_GPIO_MOXTET)		+=3D gpio-moxtet.o
diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c new fi=
le mode 100644 index 000000000000..1f576de43680
--- /dev/null
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
+
+/*
+ * Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES  */
+
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+/*
+ * There are 2 YU GPIO blocks:
+ * gpio[0]: HOST_GPIO0->HOST_GPIO31
+ * gpio[1]: HOST_GPIO32->HOST_GPIO55
+ */
+#define MLXBF3_GPIO_MAX_PINS_PER_BLOCK 32
+
+/*
+ * fw_gpio[x] block registers and their offset  */
+#define YU_GPIO_FW_CONTROL_SET		0x00
+#define YU_GPIO_FW_OUTPUT_ENABLE_SET	0x04
+#define YU_GPIO_FW_DATA_OUT_SET		0x08
+#define YU_GPIO_FW_CONTROL_CLEAR	0x14
+#define YU_GPIO_FW_OUTPUT_ENABLE_CLEAR	0x18
+#define YU_GPIO_FW_DATA_OUT_CLEAR	0x1c
+#define YU_GPIO_CAUSE_RISE_EN		0x28
+#define YU_GPIO_CAUSE_FALL_EN		0x2c
+#define YU_GPIO_READ_DATA_IN		0x30
+#define YU_GPIO_READ_OUTPUT_ENABLE	0x34
+#define YU_GPIO_READ_DATA_OUT		0x38
+#define YU_GPIO_READ_FW_CONTROL		0x44
+
+#define YU_GPIO_CAUSE_OR_CAUSE_EVTEN0	0x00
+#define YU_GPIO_CAUSE_OR_EVTEN0		0x14
+#define YU_GPIO_CAUSE_OR_CLRCAUSE	0x18
+
+/* BlueField-3 gpio block context structure. */ struct=20
+mlxbf3_gpio_context {
+	struct gpio_chip gc;
+	struct irq_chip irq_chip;
+
+	/* YU GPIO blocks address */
+	void __iomem *gpio_io;
+
+	/* YU GPIO cause block address */
+	void __iomem *gpio_cause_io;
+
+	/* Represents GPIO pins that the user can manipulate */
+	uint32_t ctrl_gpio_mask;
+};
+
+static void mlxbf3_gpio_set(struct gpio_chip *chip, unsigned int=20
+offset, int val) {
+	struct mlxbf3_gpio_context *gs =3D gpiochip_get_data(chip);
+
+	/* Software can only control GPIO pins defined by ctrl_gpio_mask */
+	if (!(BIT(offset) & gs->ctrl_gpio_mask))
+		return;
+
+	if (val)
+		writel(BIT(offset), gs->gpio_io + YU_GPIO_FW_DATA_OUT_SET);
+	else
+		writel(BIT(offset), gs->gpio_io + YU_GPIO_FW_DATA_OUT_CLEAR);
+
+	/* Make sure all previous writes are done before changing YU_GPIO_FW_CONT=
ROL_SET */
+	wmb();
+
+	/* This needs to be done last to avoid glitches */
+	writel(BIT(offset), gs->gpio_io + YU_GPIO_FW_CONTROL_SET); }
+
+static int mlxbf3_gpio_direction_input(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	struct mlxbf3_gpio_context *gs =3D gpiochip_get_data(chip);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+
+	writel(BIT(offset), gs->gpio_io + YU_GPIO_FW_OUTPUT_ENABLE_CLEAR);
+	writel(BIT(offset), gs->gpio_io + YU_GPIO_FW_CONTROL_CLEAR);
+
+	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+
+	return 0;
+}
+
+static int mlxbf3_gpio_direction_output(struct gpio_chip *chip,
+					unsigned int offset,
+					int value)
+{
+	struct mlxbf3_gpio_context *gs =3D gpiochip_get_data(chip);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+
+	writel(BIT(offset), gs->gpio_io + YU_GPIO_FW_OUTPUT_ENABLE_SET);
+
+	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+
+	return 0;
+}
+
+static void mlxbf3_gpio_irq_enable(struct irq_data *irqd) {
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(irqd);
+	struct mlxbf3_gpio_context *gs =3D gpiochip_get_data(gc);
+	int offset =3D irqd_to_hwirq(irqd);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	val =3D readl(gs->gpio_cause_io + YU_GPIO_CAUSE_OR_CLRCAUSE);
+	val |=3D BIT(offset);
+	writel(val, gs->gpio_cause_io + YU_GPIO_CAUSE_OR_CLRCAUSE);
+
+	val =3D readl(gs->gpio_cause_io + YU_GPIO_CAUSE_OR_EVTEN0);
+	val |=3D BIT(offset);
+	writel(val, gs->gpio_cause_io + YU_GPIO_CAUSE_OR_EVTEN0);
+	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags); }
+
+static void mlxbf3_gpio_irq_disable(struct irq_data *irqd) {
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(irqd);
+	struct mlxbf3_gpio_context *gs =3D gpiochip_get_data(gc);
+	int offset =3D irqd_to_hwirq(irqd);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	val =3D readl(gs->gpio_cause_io + YU_GPIO_CAUSE_OR_EVTEN0);
+	val &=3D ~BIT(offset);
+	writel(val, gs->gpio_cause_io + YU_GPIO_CAUSE_OR_EVTEN0);
+	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags); }
+
+static irqreturn_t mlxbf3_gpio_irq_handler(int irq, void *ptr) {
+	struct mlxbf3_gpio_context *gs =3D ptr;
+	struct gpio_chip *gc =3D &gs->gc;
+	unsigned long pending;
+	u32 level;
+
+	pending =3D readl(gs->gpio_cause_io + YU_GPIO_CAUSE_OR_CAUSE_EVTEN0);
+	writel(pending, gs->gpio_cause_io + YU_GPIO_CAUSE_OR_CLRCAUSE);
+
+	for_each_set_bit(level, &pending, gc->ngpio) {
+		int gpio_irq =3D irq_find_mapping(gc->irq.domain, level);
+
+		generic_handle_irq(gpio_irq);
+	}
+
+	return IRQ_RETVAL(pending);
+}
+
+static int
+mlxbf3_gpio_irq_set_type(struct irq_data *irqd, unsigned int type) {
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(irqd);
+	struct mlxbf3_gpio_context *gs =3D gpiochip_get_data(gc);
+	int offset =3D irqd_to_hwirq(irqd);
+	unsigned long flags;
+	bool fall =3D false;
+	bool rise =3D false;
+	u32 val;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_BOTH:
+		fall =3D true;
+		rise =3D true;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		rise =3D true;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		fall =3D true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	if (fall) {
+		val =3D readl(gs->gpio_io + YU_GPIO_CAUSE_FALL_EN);
+		val |=3D BIT(offset);
+		writel(val, gs->gpio_io + YU_GPIO_CAUSE_FALL_EN);
+	}
+
+	if (rise) {
+		val =3D readl(gs->gpio_io + YU_GPIO_CAUSE_RISE_EN);
+		val |=3D BIT(offset);
+		writel(val, gs->gpio_io + YU_GPIO_CAUSE_RISE_EN);
+	}
+	spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+
+	return 0;
+}
+
+/* BlueField-3 GPIO driver initialization routine. */ static int=20
+mlxbf3_gpio_probe(struct platform_device *pdev) {
+	struct mlxbf3_gpio_context *gs;
+	struct device *dev =3D &pdev->dev;
+	struct gpio_irq_chip *girq;
+	struct gpio_chip *gc;
+	unsigned int npins;
+	const char *name;
+	int ret, irq;
+
+	name =3D dev_name(dev);
+
+	gs =3D devm_kzalloc(dev, sizeof(*gs), GFP_KERNEL);
+	if (!gs)
+		return -ENOMEM;
+
+	/* YU GPIO block address */
+	gs->gpio_io =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(gs->gpio_io))
+		return PTR_ERR(gs->gpio_io);
+
+	/* YU GPIO block address */
+	gs->gpio_cause_io =3D devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(gs->gpio_cause_io))
+		return PTR_ERR(gs->gpio_cause_io);
+
+	if (device_property_read_u32(dev, "npins", &npins))
+		npins =3D MLXBF3_GPIO_MAX_PINS_PER_BLOCK;
+
+	if (device_property_read_u32(dev, "ctrl_gpio_mask", &gs->ctrl_gpio_mask))
+		gs->ctrl_gpio_mask =3D 0x0;
+
+	gc =3D &gs->gc;
+
+	/* To set the direction to input, just give control to HW by setting
+	 * YU_GPIO_FW_CONTROL_CLEAR.
+	 * If the GPIO is controlled by HW, read its value via read_data_in regis=
ter.
+	 *
+	 * When the direction =3D output, the GPIO is controlled by SW and
+	 * datain=3Ddataout. If software modifies the value of the GPIO pin,
+	 * the value can be read from read_data_in without changing the direction=
.
+	 */
+	ret =3D bgpio_init(gc, dev, 4,
+			gs->gpio_io + YU_GPIO_READ_DATA_IN,
+			NULL,
+			NULL,
+			NULL,
+			NULL,
+			0);
+
+	gc->set =3D mlxbf3_gpio_set;
+	gc->direction_input =3D mlxbf3_gpio_direction_input;
+	gc->direction_output =3D mlxbf3_gpio_direction_output;
+
+	gc->ngpio =3D npins;
+	gc->owner =3D THIS_MODULE;
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq >=3D 0) {
+		gs->irq_chip.name =3D name;
+		gs->irq_chip.irq_set_type =3D mlxbf3_gpio_irq_set_type;
+		gs->irq_chip.irq_enable =3D mlxbf3_gpio_irq_enable;
+		gs->irq_chip.irq_disable =3D mlxbf3_gpio_irq_disable;
+
+		girq =3D &gs->gc.irq;
+		girq->chip =3D &gs->irq_chip;
+		girq->handler =3D handle_simple_irq;
+		girq->default_type =3D IRQ_TYPE_NONE;
+		/* This will let us handle the parent IRQ in the driver */
+		girq->num_parents =3D 0;
+		girq->parents =3D NULL;
+		girq->parent_handler =3D NULL;
+
+		/*
+		 * Directly request the irq here instead of passing
+		 * a flow-handler because the irq is shared.
+		 */
+		ret =3D devm_request_irq(dev, irq, mlxbf3_gpio_irq_handler,
+				       IRQF_SHARED, name, gs);
+		if (ret) {
+			dev_err(dev, "failed to request IRQ");
+			return ret;
+		}
+	}
+
+	platform_set_drvdata(pdev, gs);
+
+	ret =3D devm_gpiochip_add_data(dev, &gs->gc, gs);
+	if (ret) {
+		dev_err(dev, "Failed adding memory mapped gpiochip\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mlxbf3_gpio_remove(struct platform_device *pdev) {
+	struct mlxbf3_gpio_context *gs =3D platform_get_drvdata(pdev);
+
+	/* Set the GPIO control back to HW */
+	writel(gs->ctrl_gpio_mask, gs->gpio_io + YU_GPIO_FW_CONTROL_CLEAR);
+
+	return 0;
+}
+
+static const struct acpi_device_id __maybe_unused mlxbf3_gpio_acpi_match[]=
 =3D {
+	{ "MLNXBF33", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, mlxbf3_gpio_acpi_match);
+
+static struct platform_driver mlxbf3_gpio_driver =3D {
+	.driver =3D {
+		.name =3D "mlxbf3_gpio",
+		.acpi_match_table =3D mlxbf3_gpio_acpi_match,
+	},
+	.probe    =3D mlxbf3_gpio_probe,
+	.remove   =3D mlxbf3_gpio_remove,
+};
+
+module_platform_driver(mlxbf3_gpio_driver);
+
+MODULE_DESCRIPTION("Mellanox BlueField-3 GPIO Driver");=20
+MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>"); MODULE_LICENSE("Dual=20
+BSD/GPL");
--
2.30.1

