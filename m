Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726C24372E9
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 09:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhJVHlf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 03:41:35 -0400
Received: from unicom146.biz-email.net ([210.51.26.146]:48569 "EHLO
        unicom146.biz-email.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhJVHle (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Oct 2021 03:41:34 -0400
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((LNX1044)) with ASMTP (SSL) id PHJ00011;
        Fri, 22 Oct 2021 15:39:11 +0800
Received: from localhost.localdomain (10.200.104.119) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server id
 15.1.2308.14; Fri, 22 Oct 2021 15:39:11 +0800
From:   Kai Song <songkai01@inspur.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kai Song <songkai01@inspur.com>
Subject: [PATCH] ACPI: CPPC: fix return value in register_pcc_channel()
Date:   Fri, 22 Oct 2021 15:39:10 +0800
Message-ID: <20211022073910.14398-1-songkai01@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.119]
tUid:   202110221539116c8af728a6c594ba2f1525590d3a69cf
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It uses IS_ERR to judge the return value of
pcc_mbox_request_channel().If it is invalid, maybe we should
use PTR_ERR to get the correct return value.

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index bd482108310c..0bbb5fa27ce7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -503,7 +503,7 @@ static int register_pcc_channel(int pcc_ss_idx)
 		if (IS_ERR(pcc_data[pcc_ss_idx]->pcc_channel)) {
 			pr_err("Failed to find PCC channel for subspace %d\n",
 			       pcc_ss_idx);
-			return -ENODEV;
+			return PTR_ERR(pcc_data[pcc_ss_idx]->pcc_channel);
 		}
 
 		/*
-- 
2.27.0

