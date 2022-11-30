Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027D963D037
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Nov 2022 09:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiK3IQT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Nov 2022 03:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiK3IQT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Nov 2022 03:16:19 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115D44FFB8;
        Wed, 30 Nov 2022 00:16:18 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NMX8w4bkZz8RV7G;
        Wed, 30 Nov 2022 16:16:16 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AU8G6MD040533;
        Wed, 30 Nov 2022 16:16:06 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 30 Nov 2022 16:16:08 +0800 (CST)
Date:   Wed, 30 Nov 2022 16:16:08 +0800 (CST)
X-Zmail-TransId: 2af963871148fffffffff8d9463e
X-Mailer: Zmail v1.0
Message-ID: <202211301616083499042@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <rafael@kernel.org>
Cc:     <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBBQ1BJOiB1c2Ugc3lzZnNfZW1pdCgpIHRvIGluc3RlYWQgb2Ygc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AU8G6MD040533
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63871150.000 by FangMail milter!
X-FangMail-Envelope: 1669796176/4NMX8w4bkZz8RV7G/63871150.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63871150.000/4NMX8w4bkZz8RV7G
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
combine patchs in drivers/acpi/.
 drivers/acpi/acpi_pad.c  | 4 ++--
 drivers/acpi/cppc_acpi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index edbb28faee2a..02f1a1b1143c 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -287,7 +287,7 @@ static ssize_t rrtime_store(struct device *dev,
 static ssize_t rrtime_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n", round_robin_time);
+	return sysfs_emit(buf, "%d\n", round_robin_time);
 }
 static DEVICE_ATTR_RW(rrtime);

@@ -309,7 +309,7 @@ static ssize_t idlepct_store(struct device *dev,
 static ssize_t idlepct_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n", idle_pct);
+	return sysfs_emit(buf, "%d\n", idle_pct);
 }
 static DEVICE_ATTR_RW(idlepct);

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 093675b1a1ff..0f17b1c32718 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -148,7 +148,7 @@ __ATTR(_name, 0444, show_##_name, NULL)
 		if (ret)						\
 			return ret;					\
 									\
-		return scnprintf(buf, PAGE_SIZE, "%llu\n",		\
+		return sysfs_emit(buf, "%llu\n",		\
 				(u64)st_name.member_name);		\
 	}								\
 	define_one_cppc_ro(member_name)
@@ -174,7 +174,7 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj,
 	if (ret)
 		return ret;

-	return scnprintf(buf, PAGE_SIZE, "ref:%llu del:%llu\n",
+	return sysfs_emit(buf, "ref:%llu del:%llu\n",
 			fb_ctrs.reference, fb_ctrs.delivered);
 }
 define_one_cppc_ro(feedback_ctrs);
-- 
2.25.1
