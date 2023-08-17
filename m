Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC0377F303
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Aug 2023 11:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349543AbjHQJPG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Aug 2023 05:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349424AbjHQJOo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Aug 2023 05:14:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B75271B
        for <linux-acpi@vger.kernel.org>; Thu, 17 Aug 2023 02:14:37 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRK5m5WlFzVkm4;
        Thu, 17 Aug 2023 17:12:28 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 17:14:35 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>, <rafael@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>, <lenb@kernel.org>,
        <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 2/2] ACPI: NFIT: use struct_size() helper
Date:   Thu, 17 Aug 2023 17:11:24 +0800
Message-ID: <20230817091124.915407-2-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817091124.915407-1-liaoyu15@huawei.com>
References: <20230817091124.915407-1-liaoyu15@huawei.com>
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

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/acpi/nfit/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 305f590c54a8..2f7217600307 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -712,8 +712,7 @@ static bool add_spa(struct acpi_nfit_desc *acpi_desc,
 		}
 	}
 
-	nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa) + sizeof_spa(spa),
-			GFP_KERNEL);
+	nfit_spa = devm_kzalloc(dev, struct_size(nfit_spa, spa, 1), GFP_KERNEL);
 	if (!nfit_spa)
 		return false;
 	INIT_LIST_HEAD(&nfit_spa->list);
@@ -741,7 +740,7 @@ static bool add_memdev(struct acpi_nfit_desc *acpi_desc,
 			return true;
 		}
 
-	nfit_memdev = devm_kzalloc(dev, sizeof(*nfit_memdev) + sizeof(*memdev),
+	nfit_memdev = devm_kzalloc(dev, struct_size(nfit_memdev, memdev, 1),
 			GFP_KERNEL);
 	if (!nfit_memdev)
 		return false;
@@ -812,8 +811,7 @@ static bool add_dcr(struct acpi_nfit_desc *acpi_desc,
 			return true;
 		}
 
-	nfit_dcr = devm_kzalloc(dev, sizeof(*nfit_dcr) + sizeof(*dcr),
-			GFP_KERNEL);
+	nfit_dcr = devm_kzalloc(dev, struct_size(nfit_dcr, dcr, 1), GFP_KERNEL);
 	if (!nfit_dcr)
 		return false;
 	INIT_LIST_HEAD(&nfit_dcr->list);
@@ -855,7 +853,7 @@ static size_t sizeof_idt(struct acpi_nfit_interleave *idt)
 {
 	if (idt->header.length < sizeof(*idt))
 		return 0;
-	return sizeof(*idt) + sizeof(u32) * idt->line_count;
+	return struct_size(idt, line_offset, idt->line_count);
 }
 
 static bool add_idt(struct acpi_nfit_desc *acpi_desc,
-- 
2.25.1

