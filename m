Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BACB22F40
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2019 10:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbfETItp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 May 2019 04:49:45 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:44190 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731334AbfETItp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 May 2019 04:49:45 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4K8i21b030385;
        Mon, 20 May 2019 03:49:38 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2sjefmt3em-1;
        Mon, 20 May 2019 03:49:37 -0500
Received: from EDIEX02.ad.cirrus.com (unknown [198.61.84.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 8D997611C8BD;
        Mon, 20 May 2019 03:49:37 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 20 May
 2019 09:49:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 20 May 2019 09:49:36 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9FE6645;
        Mon, 20 May 2019 09:49:36 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <wsa@the-dreams.de>, <mika.westerberg@linux.intel.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.tissoires@redhat.com>,
        <jbroadus@gmail.com>, <patches@opensource.cirrus.com>
Subject: [PATCH 5/5] i2c: core: Tidy up handling of init_irq
Date:   Mon, 20 May 2019 09:49:36 +0100
Message-ID: <20190520084936.10590-6-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190520084936.10590-1-ckeepax@opensource.cirrus.com>
References: <20190520084936.10590-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=985 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200064
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Only set init_irq during i2c_device_new and only handle client->irq on
the probe/remove paths.

Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/i2c/i2c-core-base.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index f958b50c78c04..c0a52802d23e7 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -322,6 +322,8 @@ static int i2c_device_probe(struct device *dev)
 
 	driver = to_i2c_driver(dev->driver);
 
+	client->irq = client->init_irq;
+
 	if (!client->irq && !driver->disable_i2c_core_irq_mapping) {
 		int irq = -ENOENT;
 
@@ -432,7 +434,7 @@ static int i2c_device_remove(struct device *dev)
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
 
-	client->irq = client->init_irq;
+	client->irq = 0;
 	if (client->flags & I2C_CLIENT_HOST_NOTIFY)
 		pm_runtime_put(&client->adapter->dev);
 
@@ -749,7 +751,6 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 	if (!client->init_irq)
 		client->init_irq = i2c_dev_irq_from_resources(info->resources,
 							 info->num_resources);
-	client->irq = client->init_irq;
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
-- 
2.11.0

