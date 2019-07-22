Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D81E27052A
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2019 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfGVQOk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jul 2019 12:14:40 -0400
Received: from foss.arm.com ([217.140.110.172]:41430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfGVQOk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jul 2019 12:14:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA2E028;
        Mon, 22 Jul 2019 09:14:39 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 746C83F694;
        Mon, 22 Jul 2019 09:14:38 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-acpi@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ACPI/IORT: Rename arm_smmu_v3_set_proximity() 'node' local variable
Date:   Mon, 22 Jul 2019 17:14:33 +0100
Message-Id: <20190722161433.23027-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 36a2ba07757d ("ACPI/IORT: Reject platform device creation on NUMA
node mapping failure") introduced a local variable 'node' in
arm_smmu_v3_set_proximity() that shadows the struct acpi_iort_node
pointer function parameter.

Execution was unaffected but it is prone to errors and can lead
to subtle bugs.

Rename the local variable to prevent any issue.

Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/acpi/arm64/iort.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index d4551e33fa71..15dbfd657d82 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1256,12 +1256,12 @@ static int  __init arm_smmu_v3_set_proximity(struct device *dev,
 
 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
-		int node = acpi_map_pxm_to_node(smmu->pxm);
+		int dev_node = acpi_map_pxm_to_node(smmu->pxm);
 
-		if (node != NUMA_NO_NODE && !node_online(node))
+		if (dev_node != NUMA_NO_NODE && !node_online(dev_node))
 			return -EINVAL;
 
-		set_dev_node(dev, node);
+		set_dev_node(dev, dev_node);
 		pr_info("SMMU-v3[%llx] Mapped to Proximity domain %d\n",
 			smmu->base_address,
 			smmu->pxm);
-- 
2.21.0

