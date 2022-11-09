Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D440622C80
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Nov 2022 14:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKINfk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Nov 2022 08:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKINfd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Nov 2022 08:35:33 -0500
X-Greylist: delayed 569 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Nov 2022 05:35:23 PST
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12E230F5F
        for <linux-acpi@vger.kernel.org>; Wed,  9 Nov 2022 05:35:23 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N6m1q5WJjz1DyW
        for <linux-acpi@vger.kernel.org>; Wed,  9 Nov 2022 21:25:51 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4N6m1Y6SH1z5TCG6
        for <linux-acpi@vger.kernel.org>; Wed,  9 Nov 2022 21:25:37 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4N6m1V5hnHz9tyD7
        for <linux-acpi@vger.kernel.org>; Wed,  9 Nov 2022 21:25:34 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N6m1R2hpMz8R043
        for <linux-acpi@vger.kernel.org>; Wed,  9 Nov 2022 21:25:31 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N6m1N1MFPz4y0vN;
        Wed,  9 Nov 2022 21:25:28 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 2A9DPLPo095556;
        Wed, 9 Nov 2022 21:25:21 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 9 Nov 2022 21:25:25 +0800 (CST)
Date:   Wed, 9 Nov 2022 21:25:25 +0800 (CST)
X-Zmail-TransId: 2b05636baa4532d1ea80
X-Mailer: Zmail v1.0
Message-ID: <202211092125250606392@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <rafael@kernel.org>
Cc:     <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIEFDUEk6IHN5c2ZzOiB1c2Ugc3lzZnNfZW1pdCgpIHRvIGluc3RlYWQgb2Ygc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2A9DPLPo095556
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 636BAA5E.000 by FangMail milter!
X-FangMail-Envelope: 1668000351/4N6m1q5WJjz1DyW/636BAA5E.000/10.35.20.165/[10.35.20.165]/mxde.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636BAA5E.000/4N6m1q5WJjz1DyW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

Replace scnprintf() with sysfs_emit() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/acpi/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 2d81c742e4d2..e6fe1c02a138 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -198,7 +198,7 @@ static int param_set_trace_method_name(const char *val,

 static int param_get_trace_method_name(char *buffer, const struct kernel_param *kp)
 {
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", acpi_gbl_trace_method_name);
+	return sysfs_emit(buffer, "%s\n", acpi_gbl_trace_method_name);
 }

 static const struct kernel_param_ops param_ops_trace_method = {
-- 
2.15.2
