Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869FD77F302
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Aug 2023 11:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbjHQJPH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Aug 2023 05:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349422AbjHQJOo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Aug 2023 05:14:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB98210E
        for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2023 02:14:37 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRK471HLHzNnHZ;
        Thu, 17 Aug 2023 17:11:03 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 17:14:34 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>, <rafael@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>, <lenb@kernel.org>,
        <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 1/2] ACPI: NFIT: Fix incorrect calculation of idt size
Date:   Thu, 17 Aug 2023 17:11:23 +0800
Message-ID: <20230817091124.915407-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_nfit_interleave's field 'line_offset' is switched to flexible array [1],
but sizeof_idt() still calculates the size in the form of 1-element array.

Therefore, fix incorrect calculation in sizeof_idt().

[1] https://lore.kernel.org/lkml/2652195.BddDVKsqQX@kreacher/

Fixes: 2a5ab99847bd ("ACPICA: struct acpi_nfit_interleave: Replace 1-element array with flexible array")
Cc: stable@vger.kernel.org # v6.4+
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 07204d482968..305f590c54a8 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -855,7 +855,7 @@ static size_t sizeof_idt(struct acpi_nfit_interleave *idt)
 {
 	if (idt->header.length < sizeof(*idt))
 		return 0;
-	return sizeof(*idt) + sizeof(u32) * (idt->line_count - 1);
+	return sizeof(*idt) + sizeof(u32) * idt->line_count;
 }
 
 static bool add_idt(struct acpi_nfit_desc *acpi_desc,
-- 
2.25.1

