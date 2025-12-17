Return-Path: <linux-acpi+bounces-19620-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC19CCC764A
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4A4A30517F2
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FCC32825D;
	Wed, 17 Dec 2025 11:31:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0331D5CF2;
	Wed, 17 Dec 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971066; cv=none; b=tgK5Kf448gumfgrNYoimqVfoiqFv28r5C470vEGuHWPR5hxXpdKPMyJQKJGBNKOqdTD0S7o3JC8ue55sA9bUGoN9IbCGdP7e5ZKZ9Io4p9a2ikL529u+qILFA8vz1ebeCfZ4augI1Y7s/Q0Sul2TmdsWALc62E/uCNCIVXIHq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971066; c=relaxed/simple;
	bh=wF34T9THlUrBVY7tKzZXbmOnFKqa96ZDLwFyUa+65GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0/4cKBZL6txL+q9+t7TbKN3lU+i38F44HFYBOH5k2H8q7SEJOkmatHCLZIpo4CiwitoGiQF5u9E5Uw9IFrIHva0xTe+psS0cHBnC1fLOl4sxicZ2dbtZAxSP2B+LB7dDeZ6TlkxWfddE1l/qvjDgNei85PBg6XD47EgzAqQQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B06B1688;
	Wed, 17 Dec 2025 03:30:52 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 831643F73B;
	Wed, 17 Dec 2025 03:30:57 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: tony.luck@intel.com,
	bp@alien8.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	linux-doc@vger.kernel.org,
	Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com,
	ahmed.tiba@arm.com
Subject: [PATCH 08/12] ghes: add estatus provider ops
Date: Wed, 17 Dec 2025 11:28:41 +0000
Message-ID: <20251217112845.1814119-9-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217112845.1814119-1-ahmed.tiba@arm.com>
References: <20251217112845.1814119-1-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the estatus_ops implementation that lets GHES present its CPER buffer
through the new core. The helper plugs the existing fixmap read/write code
into the generic callbacks, wires up the acknowledgment path for GHESv2
sources, and exposes the source name/notification attributes. No behaviour
changes yet—the next patch switches the GHES paths over to these hooks.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c | 157 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0dc767392a6c..5932542ea942 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -53,6 +53,7 @@
 #include <asm/tlbflush.h>
 #include <cxl/event.h>
 #include <ras/ras_event.h>
+#include <linux/estatus.h>
 
 #include "apei-internal.h"
 
@@ -250,6 +251,8 @@ static void unmap_gen_v2(struct ghes *ghes)
 	apei_unmap_generic_address(&ghes->generic_v2->read_ack_register);
 }
 
+static const struct estatus_ops ghes_estatus_ops;
+
 static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 {
 	int rc;
@@ -276,6 +279,8 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 		return ERR_PTR(-ENOMEM);
 
 	ghes->generic = generic;
+	scnprintf(ghes->name, sizeof(ghes->name), "GHES source %d",
+		  generic->header.source_id);
 	if (is_hest_type_generic_v2(ghes)) {
 		rc = map_gen_v2(ghes);
 		if (rc)
@@ -299,6 +304,12 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 		goto err_unmap_status_addr;
 	}
 
+	ghes->estatus_src.ops = &ghes_estatus_ops;
+	ghes->estatus_src.priv = ghes;
+	ghes->estatus_src.estatus = ghes->estatus;
+	ghes->estatus_src.fixmap_idx = FIX_APEI_GHES_IRQ;
+	INIT_LIST_HEAD(&ghes->elist);
+
 	return ghes;
 
 err_unmap_status_addr:
@@ -1844,3 +1855,149 @@ void ghes_unregister_report_chain(struct notifier_block *nb)
 	atomic_notifier_chain_unregister(&ghes_report_chain, nb);
 }
 EXPORT_SYMBOL_GPL(ghes_unregister_report_chain);
+
+#define GHES_ESTATUS_RW_FROM_PHYS	1
+#define GHES_ESTATUS_RW_TO_PHYS		0
+
+static void __iomem *ghes_estatus_map(struct ghes *ghes, u64 pfn,
+				      enum fixed_addresses fixmap_idx)
+{
+	phys_addr_t paddr = PFN_PHYS(pfn);
+	pgprot_t prot = arch_apei_get_mem_attribute(paddr);
+
+	__set_fixmap(fixmap_idx, paddr, prot);
+
+	return (void __iomem *)__fix_to_virt(fixmap_idx);
+}
+
+static void ghes_estatus_unmap(void __iomem *vaddr,
+			       enum fixed_addresses fixmap_idx)
+{
+	int _idx = virt_to_fix((unsigned long)vaddr);
+
+	WARN_ON_ONCE(fixmap_idx != _idx);
+	clear_fixmap(fixmap_idx);
+}
+
+static void ghes_estatus_copy_buffer(struct ghes *ghes, void *buffer,
+				     phys_addr_t paddr, size_t len,
+				     int from_phys,
+				     enum fixed_addresses fixmap_idx)
+{
+	void __iomem *vaddr;
+	u64 offset;
+	u32 chunk;
+
+	while (len > 0) {
+		offset = paddr - (paddr & PAGE_MASK);
+		vaddr = ghes_estatus_map(ghes, PHYS_PFN(paddr), fixmap_idx);
+		chunk = PAGE_SIZE - offset;
+		chunk = min_t(u32, chunk, len);
+		if (from_phys == GHES_ESTATUS_RW_FROM_PHYS)
+			memcpy_fromio(buffer, vaddr + offset, chunk);
+		else
+			memcpy_toio(vaddr + offset, buffer, chunk);
+
+		len -= chunk;
+		paddr += chunk;
+		buffer += chunk;
+		ghes_estatus_unmap(vaddr, fixmap_idx);
+	}
+}
+
+static int ghes_estatus_get_phys(struct estatus_source *source,
+				 phys_addr_t *addr)
+{
+	struct ghes *ghes = source->priv;
+	u64 value = 0;
+	int rc;
+
+	rc = apei_read(&value, &ghes->generic->error_status_address);
+	if (rc)
+		return rc;
+
+	*addr = value;
+	return 0;
+}
+
+static int ghes_estatus_read(struct estatus_source *source, phys_addr_t addr,
+			     void *buf, size_t len,
+			     enum fixed_addresses fixmap_idx)
+{
+	struct ghes *ghes = source->priv;
+
+	ghes_estatus_copy_buffer(ghes, buf, addr, len,
+				 GHES_ESTATUS_RW_FROM_PHYS, fixmap_idx);
+	return 0;
+}
+
+static int ghes_estatus_write(struct estatus_source *source, phys_addr_t addr,
+			      const void *buf, size_t len,
+			      enum fixed_addresses fixmap_idx)
+{
+	struct ghes *ghes = source->priv;
+
+	ghes_estatus_copy_buffer(ghes, (void *)buf, addr, len,
+				 GHES_ESTATUS_RW_TO_PHYS, fixmap_idx);
+	return 0;
+}
+
+static void ghes_estatus_ack(struct estatus_source *source)
+{
+	struct ghes *ghes = source->priv;
+	struct acpi_hest_generic_v2 *gv2;
+	u64 val = 0;
+	int rc;
+
+	if (ghes->generic->header.type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
+		return;
+
+	gv2 = ghes->generic_v2;
+	rc = apei_read(&val, &gv2->read_ack_register);
+	if (rc)
+		return;
+
+	val &= gv2->read_ack_preserve << gv2->read_ack_register.bit_offset;
+	val |= gv2->read_ack_write << gv2->read_ack_register.bit_offset;
+
+	apei_write(val, &gv2->read_ack_register);
+}
+
+static size_t ghes_estatus_get_max_len(struct estatus_source *source)
+{
+	struct ghes *ghes = source->priv;
+
+	return ghes->generic->error_block_length;
+}
+
+static enum estatus_notify_mode
+ghes_estatus_get_notify_mode(struct estatus_source *source)
+{
+	struct ghes *ghes = source->priv;
+	u8 notify_type = ghes->generic->notify.type;
+
+	if (notify_type == ACPI_HEST_NOTIFY_SEA)
+		return ESTATUS_NOTIFY_SEA;
+
+	return ESTATUS_NOTIFY_ASYNC;
+}
+
+static const char *ghes_estatus_get_name(struct estatus_source *source)
+{
+	struct ghes *ghes = source->priv;
+
+	if (ghes->dev)
+		return dev_name(ghes->dev);
+
+	return ghes->name;
+}
+
+static const struct estatus_ops ghes_estatus_ops = {
+	.get_phys	= ghes_estatus_get_phys,
+	.read		= ghes_estatus_read,
+	.write		= ghes_estatus_write,
+	.ack		= ghes_estatus_ack,
+	.get_max_len	= ghes_estatus_get_max_len,
+	.get_notify_mode = ghes_estatus_get_notify_mode,
+	.get_name	= ghes_estatus_get_name,
+};
-- 
2.43.0


