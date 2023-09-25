Return-Path: <linux-acpi+bounces-111-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9A37ADEC2
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 20:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 89C88281621
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720C31D6B0
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:30:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF38219E5
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 18:06:21 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E4C210C;
	Mon, 25 Sep 2023 11:06:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [167.220.81.210])
	by linux.microsoft.com (Postfix) with ESMTPSA id C1BC1212C816;
	Mon, 25 Sep 2023 11:06:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1BC1212C816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695665176;
	bh=p14Nn8yShFD3PfmnLpi1+w5sDpk1yljf0ug3OMUAn1A=;
	h=From:To:Subject:Date:From;
	b=aYiDuMSiNfoqP1ABMbBcdZ++MtF6+932VxIdLt8NPUWFwI0NqurbgHc0dOFr6h1nz
	 vjeT21O0jYE2Agwul0i8dRPtNgd3O8wC/xO0I6GG6gnJ5BQX5rllfGvZesNZwHqG43
	 yH7M126uFcTaVUIciQeaIsPaSHpW7y+pfFksFMFs=
From: Jarred White <jarredwhite@linux.microsoft.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] acpi: Use access_width over register_width for system memory accesses
Date: Mon, 25 Sep 2023 11:05:52 -0700
Message-Id: <20230925180552.76071-1-jarredwhite@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To align with ACPI 6.3+, since bit_width can be any 8-bit value, we cannot
depend on it being always on a clean 8b boundary. Instead, use access_width
to determine the size and use the offset and width to shift and mask the
bit swe want to read/write out. Make sure to add a check for system memory
since pcc redefines the access_width to subspace id.

Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
---
 drivers/acpi/cppc_acpi.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7ff269a78c20..07619b36c056 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -777,6 +777,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 				if (gas_t->address) {
 					void __iomem *addr;
+					size_t access_width;
 
 					if (!osc_cpc_flexible_adr_space_confirmed) {
 						pr_debug("Flexible address space capability not supported\n");
@@ -784,7 +785,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 							goto out_free;
 					}
 
-					addr = ioremap(gas_t->address, gas_t->bit_width/8);
+					access_width = ((8 << (gas_t->access_width - 1)) / 8);
+					addr = ioremap(gas_t->address, access_width);
 					if (!addr)
 						goto out_free;
 					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
@@ -980,6 +982,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 {
 	void __iomem *vaddr = NULL;
+	int size;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
@@ -1015,7 +1018,12 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
 				val, reg->bit_width);
 
-	switch (reg->bit_width) {
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		size = (8 << (reg->access_width - 1));
+	else
+		size = reg->bit_width;
+
+	switch (size) {
 	case 8:
 		*val = readb_relaxed(vaddr);
 		break;
@@ -1034,12 +1042,16 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		return -EFAULT;
 	}
 
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		*val = (*val >> reg->bit_offset) & GENMASK((reg->bit_width) - 1, 0);
+
 	return 0;
 }
 
 static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 {
 	int ret_val = 0;
+	int size;
 	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
@@ -1067,7 +1079,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, reg->bit_width);
 
-	switch (reg->bit_width) {
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		size = (8 << (reg->access_width - 1));
+		val = (val >> reg->bit_offset) & GENMASK((reg->bit_width) - 1, 0);
+	} else
+		size = reg->bit_width;
+
+	switch (size) {
 	case 8:
 		writeb_relaxed(val, vaddr);
 		break;
-- 
2.34.1


