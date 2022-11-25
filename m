Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5E96382A5
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Nov 2022 04:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKYDNM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Nov 2022 22:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKYDNL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Nov 2022 22:13:11 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89401CB28
        for <linux-acpi@vger.kernel.org>; Thu, 24 Nov 2022 19:13:08 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NJKfn608Mz15MrJ;
        Fri, 25 Nov 2022 11:12:33 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 11:13:06 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 25 Nov
 2022 11:13:06 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <rafael.j.wysocki@intel.com>, <liwei391@huawei.com>,
        <devel@acpica.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH] ACPICA: Disassembler: Fix missing decrement reference when attach operand_object failed
Date:   Fri, 25 Nov 2022 11:11:20 +0800
Message-ID: <20221125031120.3946901-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The acpi_operand_object object's reference count has not been decremented
if attached to associated value failed, so may cause this object cannot be
released forever, this add acpi_ut_remove_reference() to handle reference
decrement.

Fixes: 6ccd7b5acc41 ("ACPICA: Disassembler: Add support for Operation Region externals")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/acpi/acpica/dsfield.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index de175f1b4beb..3a3d3ab3e2c3 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -93,6 +93,9 @@ acpi_ds_create_external_region(acpi_status lookup_status,
 
 	obj_desc->region.node = *node;
 	status = acpi_ns_attach_object(*node, obj_desc, ACPI_TYPE_REGION);
+	if (ACPI_FAILURE(status))
+		acpi_ut_remove_reference(obj_desc);
+
 	return (status);
 }
 #endif
-- 
2.25.1

