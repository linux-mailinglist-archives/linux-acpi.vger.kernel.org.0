Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107762B78FE
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Nov 2020 09:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgKRImI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Nov 2020 03:42:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7646 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgKRImI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2020 03:42:08 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cbbrg6TyTz15NJp;
        Wed, 18 Nov 2020 16:41:39 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.144) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Nov 2020 16:41:47 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] ACPI/nfit: correct the badrange to be reported in nfit_handle_mce()
Date:   Wed, 18 Nov 2020 16:41:17 +0800
Message-ID: <20201118084117.1937-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The badrange to be reported should always cover mce->addr.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/acpi/nfit/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index ee8d9973f60b..053e719c7bea 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -63,7 +63,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 
 		/* If this fails due to an -ENOMEM, there is little we can do */
 		nvdimm_bus_add_badrange(acpi_desc->nvdimm_bus,
-				ALIGN(mce->addr, L1_CACHE_BYTES),
+				ALIGN_DOWN(mce->addr, L1_CACHE_BYTES),
 				L1_CACHE_BYTES);
 		nvdimm_region_notify(nfit_spa->nd_region,
 				NVDIMM_REVALIDATE_POISON);
-- 
2.26.0.106.g9fadedd


