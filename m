Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305FD2ECE96
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 12:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbhAGLTi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 06:19:38 -0500
Received: from foss.arm.com ([217.140.110.172]:58090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbhAGLTF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 06:19:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81D0B11D4;
        Thu,  7 Jan 2021 03:18:19 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67BC13F719;
        Thu,  7 Jan 2021 03:18:18 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com
Cc:     viro@zeniv.linux.org.uk, catalin.marinas@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 3/3] acpi: cppc_acpi: initialise vaddr pointers to NULL
Date:   Thu,  7 Jan 2021 11:17:17 +0000
Message-Id: <20210107111717.5571-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20210107111717.5571-1-ionela.voinescu@arm.com>
References: <20210107111717.5571-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Properly initialise vaddr pointers in cpc_read() and cpc_write() to
NULL instead of 0.

This fixes the following sparse warnings:
drivers/acpi/cppc_acpi.c:937:31: warning: Using plain integer as NULL pointer
drivers/acpi/cppc_acpi.c:982:31: warning: Using plain integer as NULL pointer

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index fd71020f5d5f..69057fcd2c04 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -934,7 +934,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 {
 	int ret_val = 0;
-	void __iomem *vaddr = 0;
+	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
@@ -979,7 +979,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 {
 	int ret_val = 0;
-	void __iomem *vaddr = 0;
+	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
-- 
2.29.2.dirty

