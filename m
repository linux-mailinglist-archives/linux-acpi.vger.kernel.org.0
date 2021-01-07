Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1B42ECE8C
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 12:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbhAGLTE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 06:19:04 -0500
Received: from foss.arm.com ([217.140.110.172]:58076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGLTD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 06:19:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F39711B3;
        Thu,  7 Jan 2021 03:18:17 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 752223F719;
        Thu,  7 Jan 2021 03:18:16 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com
Cc:     viro@zeniv.linux.org.uk, catalin.marinas@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 2/3] acpi: cppc_acpi: add __iomem annotation to generic_comm_base pointer
Date:   Thu,  7 Jan 2021 11:17:16 +0000
Message-Id: <20210107111717.5571-3-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20210107111717.5571-1-ionela.voinescu@arm.com>
References: <20210107111717.5571-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ppc_comm_addr is a virtual address to the PCC space and it's annotated
with __iomem. Therefore, generic_comm_base which gets assigned the value of
pcc_comm_address should be annotated as well.

This already happens in check_pcc_chan(), but not in send_pcc_cmd(), which
results in the following sparse warnings:

drivers/acpi/cppc_acpi.c:237:18: warning: cast removes address space '__iomem' of expression
drivers/acpi/cppc_acpi.c:299:9: warning: incorrect type in argument 2 (different address spaces)
drivers/acpi/cppc_acpi.c:299:9:    expected void volatile [noderef] __iomem *addr
drivers/acpi/cppc_acpi.c:299:9:    got unsigned short *
drivers/acpi/cppc_acpi.c:302:9: warning: incorrect type in argument 2 (different address spaces)
drivers/acpi/cppc_acpi.c:302:9:    expected void volatile [noderef] __iomem *addr
drivers/acpi/cppc_acpi.c:302:9:    got unsigned short *

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 75aaf94ae0a9..fd71020f5d5f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -233,8 +233,8 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
 {
 	int ret = -EIO, i;
 	struct cppc_pcc_data *pcc_ss_data = pcc_data[pcc_ss_id];
-	struct acpi_pcct_shared_memory *generic_comm_base =
-		(struct acpi_pcct_shared_memory *)pcc_ss_data->pcc_comm_addr;
+	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
+		pcc_ss_data->pcc_comm_addr;
 	unsigned int time_delta;
 
 	/*
-- 
2.29.2.dirty

