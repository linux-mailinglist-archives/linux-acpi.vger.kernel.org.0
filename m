Return-Path: <linux-acpi+bounces-1034-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEBC7D8BBC
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 00:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272C1B20F22
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 22:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BEF3F4A0
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mECLMyoq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB414426
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 21:15:40 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76BA2D42;
	Thu, 26 Oct 2023 14:15:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [167.220.81.210])
	by linux.microsoft.com (Postfix) with ESMTPSA id C581420B74C0;
	Thu, 26 Oct 2023 14:15:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C581420B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1698354938;
	bh=PgZoaoibE13ScmHye43oCQ/2BwAjMAKb/hl5ibbfSWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mECLMyoqF9w2yNqUDNY7F9NDbH4P1tPk+cINv6d/rbddrJ7V/Sc9whevItpN7mq+d
	 u0UwQDmnBKziulz0MoFpI9it8oTJ2Uv85lONKfus6VskyJEGvdYzT+1Pg+N2i1RnfH
	 MSMwznr4M0zr0U1EEfpcVosP+E/DFd/TzQ0o3jhY=
From: Jarred White <jarredwhite@linux.microsoft.com>
To: jarredwhite@linux.microsoft.com
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Subject: [PATCH v2] acpi: Use access_width over register_width for system memory  accesses
Date: Thu, 26 Oct 2023 14:15:13 -0700
Message-Id: <20231026211513.474-1-jarredwhite@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <42a5c36d-8b65-418f-9826-2808ab49d67a@linux.microsoft.com>
References: <42a5c36d-8b65-418f-9826-2808ab49d67a@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To align with ACPI 6.3+, since bit_width can be any 8-bit value, we cannot
depend on it being always on a clean 8b boundary. Instead, use access_width
to determine the size and use the offset and width to shift and mask the
bits we want to read/write out. Make sure to add a check for system memory
since pcc redefines the access_width to subspace id.

Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
---
changelog:
v1-->v2:
	1. Fixed coding style errors
        2. Backwards compatibility with ioremapping of address still an
           open question. Suggestions are welcomed.

 drivers/acpi/cppc_acpi.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7ff269a78c20..fb37e1727bf8 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -163,6 +163,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
+/* Use access_width to determine the total number of bits */
+#define ACCESS_WIDTH_TO_BITS(reg) 8 << ((reg)->access_width - 1)
+
+/* Shift and apply the mask for CPC reads/writes */
+#define MASK_VAL(val) (((val) >> reg->bit_offset) & 			\
+					GENMASK((reg->bit_width), 0))
+
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -777,6 +784,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 				if (gas_t->address) {
 					void __iomem *addr;
+					size_t access_width;
 
 					if (!osc_cpc_flexible_adr_space_confirmed) {
 						pr_debug("Flexible address space capability not supported\n");
@@ -784,7 +792,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 							goto out_free;
 					}
 
-					addr = ioremap(gas_t->address, gas_t->bit_width/8);
+					access_width = ACCESS_WIDTH_TO_BITS(gas_t) / 8;
+					addr = ioremap(gas_t->address, access_width);
 					if (!addr)
 						goto out_free;
 					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
@@ -980,6 +989,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 {
 	void __iomem *vaddr = NULL;
+	int size;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
@@ -991,7 +1001,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	*val = 0;
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		u32 width = 8 << (reg->access_width - 1);
+		u32 width = ACCESS_WIDTH_TO_BITS(reg);
 		u32 val_u32;
 		acpi_status status;
 
@@ -1015,7 +1025,12 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
 				val, reg->bit_width);
 
-	switch (reg->bit_width) {
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		size = ACCESS_WIDTH_TO_BITS(reg);
+	else
+		size = reg->bit_width;
+
+	switch (size) {
 	case 8:
 		*val = readb_relaxed(vaddr);
 		break;
@@ -1034,18 +1049,22 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		return -EFAULT;
 	}
 
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		*val = MASK_VAL(*val);
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
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		u32 width = 8 << (reg->access_width - 1);
+		u32 width = ACCESS_WIDTH_TO_BITS(reg);
 		acpi_status status;
 
 		status = acpi_os_write_port((acpi_io_address)reg->address,
@@ -1067,7 +1086,14 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, reg->bit_width);
 
-	switch (reg->bit_width) {
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		size = ACCESS_WIDTH_TO_BITS(reg);
+		val = MASK_VAL(val);
+	} else {
+		size = reg->bit_width;
+	}
+
+	switch (size) {
 	case 8:
 		writeb_relaxed(val, vaddr);
 		break;
-- 
2.34.1


