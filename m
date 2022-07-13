Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EBC573704
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jul 2022 15:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiGMNNy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 13 Jul 2022 09:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbiGMNNx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jul 2022 09:13:53 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FD11277B;
        Wed, 13 Jul 2022 06:13:48 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DAH6DC011654;
        Wed, 13 Jul 2022 09:13:38 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h73h6vaj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 09:13:37 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 26DDDXcg053467
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jul 2022 09:13:33 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 13 Jul 2022 09:13:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 13 Jul 2022 09:13:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 13 Jul 2022 09:13:32 -0400
Received: from nsa.ad.analog.com ([10.44.3.56])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26DDDI1T004951;
        Wed, 13 Jul 2022 09:13:21 -0400
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
Subject: [PATCH 0/4] add support for bias pull-disable
Date:   Wed, 13 Jul 2022 15:14:17 +0200
Message-ID: <20220713131421.1527179-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: pwQnqwK7M1Bl9xWTTvGwG7PmVJK8l6wq
X-Proofpoint-ORIG-GUID: pwQnqwK7M1Bl9xWTTvGwG7PmVJK8l6wq
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

The gpio core looks at 'FLAG_BIAS_DISABLE' in preparation of calling the
gpiochip 'set_config()' hook. However, AFAICT, there's no way that this
flag is set because there's no support for it in firwmare code. Moreover,
in 'gpiod_configure_flags()', only pull-ups and pull-downs are being
handled.

On top of this, there are some users that are looking at
'PIN_CONFIG_BIAS_DISABLE' in the 'set_config()' hook. So, unless I'm
missing something, it looks like this was never working for these chips.

Note that the ACPI case is only compiled tested. At first glance, it seems
the current patch is enough but i'm not really sure...

As a side note, this came to my attention during this patchset [1]
(and, ofr OF,  was tested with it).

[1]: https://lore.kernel.org/linux-input/20220708093448.42617-5-nuno.sa@analog.com/

Nuno Sá (4):
  gpiolib: add support for bias pull disable
  gpiolib: of: support bias pull disable
  gpiolib: acpi: support bias pull disable
  dt-bindings: gpio: add pull-disable flag

 drivers/gpio/gpiolib-acpi.c     | 3 +++
 drivers/gpio/gpiolib-of.c       | 7 +++++++
 drivers/gpio/gpiolib.c          | 8 ++++++--
 include/dt-bindings/gpio/gpio.h | 3 +++
 include/linux/gpio/machine.h    | 1 +
 include/linux/of_gpio.h         | 1 +
 6 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.37.0

