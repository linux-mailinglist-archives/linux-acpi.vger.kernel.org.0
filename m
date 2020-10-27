Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD24429AD85
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 14:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443574AbgJ0NiY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 09:38:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6160 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443525AbgJ0NiY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2020 09:38:24 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CLCTD6rhtz15NDl;
        Tue, 27 Oct 2020 21:38:24 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 27 Oct 2020
 21:38:17 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>
CC:     <linux-nvdimm@lists.01.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH -next] ACPI: NFIT: Fix judgment of rc is '-ENXIO'
Date:   Tue, 27 Oct 2020 21:49:01 +0800
Message-ID: <20201027134901.65045-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Initial value of rc is '-ENXIO', and we should
use the initial value to check it.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 756227837b3b..3a3c209ed3d3 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1564,7 +1564,7 @@ static ssize_t format1_show(struct device *dev,
 					le16_to_cpu(nfit_dcr->dcr->code));
 			break;
 		}
-		if (rc != ENXIO)
+		if (rc != -ENXIO)
 			break;
 	}
 	mutex_unlock(&acpi_desc->init_mutex);
-- 
2.17.1

