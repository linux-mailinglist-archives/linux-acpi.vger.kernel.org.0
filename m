Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA286205C3
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Nov 2022 02:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiKHB1o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Nov 2022 20:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbiKHB1m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Nov 2022 20:27:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1B328733
        for <linux-acpi@vger.kernel.org>; Mon,  7 Nov 2022 17:27:41 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5r7M2s0SzmVmR;
        Tue,  8 Nov 2022 09:27:27 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 09:27:38 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 09:27:38 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <maz@kernel.org>,
        <lvjianmin@loongson.cn>, <guohanjun@huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <yangyingliang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] ACPI: irq: Fix some kernel-doc issues
Date:   Tue, 8 Nov 2022 09:46:23 +0800
Message-ID: <20221108014623.71622-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The following commit change the second parameter of acpi_set_irq_model()
but forgot to update the function description. Let's fix it.

  commit 7327b16f5f56 ("APCI: irq: Add support for multiple GSI domains")

Also add description of parameter 'gsi' for
acpi_get_irq_source_fwhandle() to avoid the following build W=1 warning.

  drivers/acpi/irq.c:108: warning: Function parameter or member 'gsi' not described in 'acpi_get_irq_source_fwhandle'

Fixes: 7327b16f5f56 ("APCI: irq: Add support for multiple GSI domains")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/acpi/irq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 1cc4647f78b8..c2c786eb95ab 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -94,6 +94,7 @@ EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
 /**
  * acpi_get_irq_source_fwhandle() - Retrieve fwhandle from IRQ resource source.
  * @source: acpi_resource_source to use for the lookup.
+ * @gsi: GSI IRQ number
  *
  * Description:
  * Retrieve the fwhandle of the device referenced by the given IRQ resource
@@ -297,8 +298,8 @@ EXPORT_SYMBOL_GPL(acpi_irq_get);
 /**
  * acpi_set_irq_model - Setup the GSI irqdomain information
  * @model: the value assigned to acpi_irq_model
- * @fwnode: the irq_domain identifier for mapping and looking up
- *          GSI interrupts
+ * @fn: a dispatcher function that will return the domain fwnode
+ *	for a given GSI
  */
 void __init acpi_set_irq_model(enum acpi_irq_model_id model,
 			       struct fwnode_handle *(*fn)(u32))
-- 
2.20.1

