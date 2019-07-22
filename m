Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 390A370566
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2019 18:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfGVQZ4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jul 2019 12:25:56 -0400
Received: from foss.arm.com ([217.140.110.172]:41640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730116AbfGVQZ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jul 2019 12:25:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3ED228;
        Mon, 22 Jul 2019 09:25:55 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E38A3F694;
        Mon, 22 Jul 2019 09:25:54 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-acpi@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ACPI/IORT: Fix off-by-one check in iort_dev_find_its_id()
Date:   Mon, 22 Jul 2019 17:25:48 +0100
Message-Id: <20190722162548.23610-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Static analysis identified that index comparison against ITS entries in
iort_dev_find_its_id() is off by one.

Update the comparison condition and clarify the resulting error
message.

Fixes: 4bf2efd26d76 ("ACPI: Add new IORT functions to support MSI domain handling")
Link: https://lore.kernel.org/linux-arm-kernel/20190613065410.GB16334@mwanda/
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Will Deacon <will@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/arm64/iort.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 15dbfd657d82..5a7551d060f2 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -611,8 +611,8 @@ static int iort_dev_find_its_id(struct device *dev, u32 req_id,
 
 	/* Move to ITS specific data */
 	its = (struct acpi_iort_its_group *)node->node_data;
-	if (idx > its->its_count) {
-		dev_err(dev, "requested ITS ID index [%d] is greater than available [%d]\n",
+	if (idx >= its->its_count) {
+		dev_err(dev, "requested ITS ID index [%d] overruns ITS entries [%d]\n",
 			idx, its->its_count);
 		return -ENXIO;
 	}
-- 
2.21.0

