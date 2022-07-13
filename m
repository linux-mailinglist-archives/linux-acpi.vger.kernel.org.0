Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3665573705
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jul 2022 15:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiGMNNz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jul 2022 09:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiGMNNx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jul 2022 09:13:53 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90BD12097;
        Wed, 13 Jul 2022 06:13:48 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DD0sit026930;
        Wed, 13 Jul 2022 09:13:37 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h9r37acav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 09:13:37 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 26DDDaOu062857
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jul 2022 09:13:36 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 13 Jul 2022 09:13:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 13 Jul 2022 09:13:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 13 Jul 2022 09:13:35 -0400
Received: from nsa.ad.analog.com ([10.44.3.56])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26DDDI1U004951;
        Wed, 13 Jul 2022 09:13:30 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-acpi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>
Subject: [PATCH 1/4] gpiolib: add support for bias pull disable
Date:   Wed, 13 Jul 2022 15:14:18 +0200
Message-ID: <20220713131421.1527179-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713131421.1527179-1-nuno.sa@analog.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 4DZeFZNFc8NlCsYm-V42Z1DKOWw07IhX
X-Proofpoint-ORIG-GUID: 4DZeFZNFc8NlCsYm-V42Z1DKOWw07IhX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_02,2022-07-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This change prepares the gpio core to look at firmware flags and set
'FLAG_BIAS_DISABLE' if necessary. It works in similar way to
'GPIO_PULL_DOWN' and 'GPIO_PULL_UP'.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/gpio/gpiolib.c       | 8 ++++++--
 include/linux/gpio/machine.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9535f48e18d1..0692ec84d3b0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3945,9 +3945,11 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 	if (lflags & GPIO_OPEN_SOURCE)
 		set_bit(FLAG_OPEN_SOURCE, &desc->flags);
 
-	if ((lflags & GPIO_PULL_UP) && (lflags & GPIO_PULL_DOWN)) {
+	if (((lflags & GPIO_PULL_UP) && (lflags & GPIO_PULL_DOWN)) ||
+	    ((lflags & GPIO_PULL_UP) && (lflags & GPIO_PULL_DISABLE)) ||
+	    ((lflags & GPIO_PULL_DOWN) && (lflags & GPIO_PULL_DISABLE))) {
 		gpiod_err(desc,
-			  "both pull-up and pull-down enabled, invalid configuration\n");
+			  "multiple pull-up, pull-down or pull-disable enabled, invalid configuration\n");
 		return -EINVAL;
 	}
 
@@ -3955,6 +3957,8 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 		set_bit(FLAG_PULL_UP, &desc->flags);
 	else if (lflags & GPIO_PULL_DOWN)
 		set_bit(FLAG_PULL_DOWN, &desc->flags);
+	else if (lflags & GPIO_PULL_DISABLE)
+		set_bit(FLAG_BIAS_DISABLE, &desc->flags);
 
 	ret = gpiod_set_transitory(desc, (lflags & GPIO_TRANSITORY));
 	if (ret < 0)
diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
index 4d55da28e664..0b619eb7ae83 100644
--- a/include/linux/gpio/machine.h
+++ b/include/linux/gpio/machine.h
@@ -14,6 +14,7 @@ enum gpio_lookup_flags {
 	GPIO_TRANSITORY			= (1 << 3),
 	GPIO_PULL_UP			= (1 << 4),
 	GPIO_PULL_DOWN			= (1 << 5),
+	GPIO_PULL_DISABLE		= (1 << 6),
 
 	GPIO_LOOKUP_FLAGS_DEFAULT	= GPIO_ACTIVE_HIGH | GPIO_PERSISTENT,
 };
-- 
2.37.0

