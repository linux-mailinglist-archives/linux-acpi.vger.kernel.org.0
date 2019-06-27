Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408A757F45
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfF0JY2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jun 2019 05:24:28 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:13068 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726293AbfF0JY2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jun 2019 05:24:28 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5R9JbL0012627;
        Thu, 27 Jun 2019 04:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=LDfSe40WQTF2vrFIW1EbCXF2xsg9VsrEA/n3kgFm+bg=;
 b=On/eEP554W4CY93ATqTsSjtilrsHGQSosAnZrAfNug5Pf/f8dwlGj8a/lFpcXNTfaBNf
 herzW7B3Wnw/u8/yVguZzzs2lc6vE22NcqNDNFaACjD57d0uJ0yyNcBxtvclzdqgZNj0
 wV2F9ijawJRUSArrC357wpSN2RF7ZPAa/en87I7oRqwtmvHMvpncRhtTvo7chGxIWkAl
 aLEO0vCRc7HsScU9ySpeFKMAHt9inxue80FmD49XvVbR6ZTcDP+bRr9MaB5sJiQyzn7A
 kFHZYeN4XmAduL/2KkXSo4ae70qvxK49YjJY8Xby4itU9MDrYuAB6vdlb+IZegyS+TO2 UA== 
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2t9hr2gr54-1;
        Thu, 27 Jun 2019 04:24:13 -0500
Received: from EDIEX02.ad.cirrus.com (ediex02.ad.cirrus.com [198.61.84.81])
        by mail4.cirrus.com (Postfix) with ESMTP id C55AB611C8B4;
        Thu, 27 Jun 2019 04:24:14 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 27 Jun
 2019 10:24:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 27 Jun 2019 10:24:12 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2DDCC2DA;
        Thu, 27 Jun 2019 10:24:12 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <wsa@the-dreams.de>, <mika.westerberg@linux.intel.com>
CC:     <jarkko.nikula@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>, <linux-i2c@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.tissoires@redhat.com>, <jbroadus@gmail.com>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v8 6/6] i2c: core: Tidy up handling of init_irq
Date:   Thu, 27 Jun 2019 10:24:11 +0100
Message-ID: <20190627092411.26123-7-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190627092411.26123-1-ckeepax@opensource.cirrus.com>
References: <20190627092411.26123-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270109
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Only set init_irq during i2c_device_new and only handle client->irq on
the probe/remove paths.

Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/i2c/i2c-core-base.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index f0e1d338c7ddf..f26ed495d3842 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -314,6 +314,8 @@ static int i2c_device_probe(struct device *dev)
 
 	driver = to_i2c_driver(dev->driver);
 
+	client->irq = client->init_irq;
+
 	if (!client->irq && !driver->disable_i2c_core_irq_mapping) {
 		int irq = -ENOENT;
 
@@ -424,7 +426,7 @@ static int i2c_device_remove(struct device *dev)
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
 
-	client->irq = client->init_irq;
+	client->irq = 0;
 	if (client->flags & I2C_CLIENT_HOST_NOTIFY)
 		pm_runtime_put(&client->adapter->dev);
 
@@ -741,7 +743,6 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 	if (!client->init_irq)
 		client->init_irq = i2c_dev_irq_from_resources(info->resources,
 							 info->num_resources);
-	client->irq = client->init_irq;
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
-- 
2.11.0

