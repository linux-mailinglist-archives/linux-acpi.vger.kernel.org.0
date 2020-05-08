Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9CA1CA1CD
	for <lists+linux-acpi@lfdr.de>; Fri,  8 May 2020 06:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgEHEMQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 May 2020 00:12:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40940 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbgEHEMQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 May 2020 00:12:16 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7DA261CDD37E0367DED5;
        Fri,  8 May 2020 12:12:13 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 12:12:03 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/2] ACPI: IORT: Add comments for not calling acpi_put_table()
Date:   Fri, 8 May 2020 12:05:53 +0800
Message-ID: <1588910753-18543-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1588910753-18543-1-git-send-email-guohanjun@huawei.com>
References: <1588910753-18543-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The iort_table will be used at runtime after acpi_iort_init(),
so add some comments to clarify this to make it less confusing.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/arm64/iort.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 6e445bc..619a3e5 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1667,6 +1667,10 @@ void __init acpi_iort_init(void)
 {
 	acpi_status status;
 
+	/* iort_table will be used at runtime after the iort init,
+	 * so we don't need to call acpi_put_table() to release
+	 * the IORT table mapping.
+	 */
 	status = acpi_get_table(ACPI_SIG_IORT, 0, &iort_table);
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND) {
-- 
1.7.12.4

