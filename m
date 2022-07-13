Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EF257370A
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jul 2022 15:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiGMNN4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jul 2022 09:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbiGMNNx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jul 2022 09:13:53 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2143012759;
        Wed, 13 Jul 2022 06:13:48 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DBI9aL011643;
        Wed, 13 Jul 2022 09:13:38 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h73h6vaja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 09:13:38 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 26DDDbb5053473
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jul 2022 09:13:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 13 Jul
 2022 09:13:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 13 Jul 2022 09:13:36 -0400
Received: from nsa.ad.analog.com ([10.44.3.56])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26DDDI1V004951;
        Wed, 13 Jul 2022 09:13:32 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-acpi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/4] gpiolib: of: support bias pull disable
Date:   Wed, 13 Jul 2022 15:14:19 +0200
Message-ID: <20220713131421.1527179-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713131421.1527179-1-nuno.sa@analog.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: rO5cgpAfo1D3Ajsqu5BLVpoO_9LhkWE1
X-Proofpoint-ORIG-GUID: rO5cgpAfo1D3Ajsqu5BLVpoO_9LhkWE1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_02,2022-07-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On top of looking at PULL_UP and PULL_DOWN flags, also look at
PULL_DISABLE and set the appropriate GPIO flag. The GPIO core will then
pass down this to controllers that support it.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/gpio/gpiolib-of.c | 7 +++++++
 include/linux/of_gpio.h   | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index f80307be37d5..a037b50bef33 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -354,6 +354,9 @@ struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
 	if (flags & OF_GPIO_PULL_DOWN)
 		lflags |= GPIO_PULL_DOWN;
 
+	if (flags & OF_GPIO_PULL_DISABLE)
+		lflags |= GPIO_PULL_DISABLE;
+
 	ret = gpiod_configure_flags(desc, propname, lflags, dflags);
 	if (ret < 0) {
 		gpiod_put(desc);
@@ -556,6 +559,8 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 		*flags |= GPIO_PULL_UP;
 	if (of_flags & OF_GPIO_PULL_DOWN)
 		*flags |= GPIO_PULL_DOWN;
+	if (of_flags & OF_GPIO_PULL_DISABLE)
+		*flags |= GPIO_PULL_DISABLE;
 
 	return desc;
 }
@@ -621,6 +626,8 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 		*lflags |= GPIO_PULL_UP;
 	if (xlate_flags & OF_GPIO_PULL_DOWN)
 		*lflags |= GPIO_PULL_DOWN;
+	if (xlate_flags & OF_GPIO_PULL_DISABLE)
+		*lflags |= GPIO_PULL_DISABLE;
 
 	if (of_property_read_bool(np, "input"))
 		*dflags |= GPIOD_IN;
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 8bf2ea859653..a5166eb93437 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -29,6 +29,7 @@ enum of_gpio_flags {
 	OF_GPIO_TRANSITORY = 0x8,
 	OF_GPIO_PULL_UP = 0x10,
 	OF_GPIO_PULL_DOWN = 0x20,
+	OF_GPIO_PULL_DISABLE = 0x40,
 };
 
 #ifdef CONFIG_OF_GPIO
-- 
2.37.0

