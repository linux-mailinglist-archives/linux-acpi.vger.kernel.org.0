Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806881B5573
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Apr 2020 09:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgDWHPy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Apr 2020 03:15:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41420 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727028AbgDWHPy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Apr 2020 03:15:54 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50CC9EBCA0F13E12BD17;
        Thu, 23 Apr 2020 15:15:49 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 15:15:39 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] ACPI / CPPC: Make some symbols static
Date:   Thu, 23 Apr 2020 15:21:58 +0800
Message-ID: <1587626518-97669-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix the following sparse warnings:

drivers/acpi/cppc_acpi.c:353:20: warning: symbol 'cppc_mbox_cl' was not declared. Should it be static?
drivers/acpi/cppc_acpi.c:600:5: warning: symbol 'pcc_data_alloc' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 8b2e89c..f818400 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -350,7 +350,7 @@ static void cppc_chan_tx_done(struct mbox_client *cl, void *msg, int ret)
 				*(u16 *)msg, ret);
 }
 
-struct mbox_client cppc_mbox_cl = {
+static struct mbox_client cppc_mbox_cl = {
 	.tx_done = cppc_chan_tx_done,
 	.knows_txdone = true,
 };
@@ -597,7 +597,7 @@ bool __weak cpc_ffh_supported(void)
  *
  * Return: 0 for success, errno for failure
  */
-int pcc_data_alloc(int pcc_ss_id)
+static int pcc_data_alloc(int pcc_ss_id)
 {
 	if (pcc_ss_id < 0 || pcc_ss_id >= MAX_PCC_SUBSPACES)
 		return -EINVAL;
-- 
2.6.2

