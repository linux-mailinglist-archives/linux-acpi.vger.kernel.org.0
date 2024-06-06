Return-Path: <linux-acpi+bounces-6215-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBBB8FE33F
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 11:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5718A1C20DB1
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34719179641;
	Thu,  6 Jun 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2TkRhkm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B515E5C9;
	Thu,  6 Jun 2024 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666969; cv=none; b=rXLERFj6u/5X3AEqWbtQTt2l7XZV8K+VLdRNGV/a0XZHhb2zabl/Y6iq2LrdSkknYqUTGS7X6J8B4Fx5e2oGGOtCURCoUjvjPv3IWo6esT0BTV1V9i2hFUceZFWpZvNR6RMKP0hi4zjOyL/o9B5U9TstJmhUug9YzanZ+x1aFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666969; c=relaxed/simple;
	bh=rYDwo9sVsMIRRs3ihHMD2TPD1n36mAZ6UOjA9MgTFl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQI70CXNFqpEA0g0nv9yPWdgSWmtnNTLoKcyme8uivuF0O0WKnhUGtAHmX++H72a/tIQE9Xv9HIkClKS/nLRj5vqYonXld9pyOyLTG+pvV2IFEgG0mqbEgOvA9uMvhOELv0e5ve9I5mZN+dK90l9G1IL75rD5N2C8hXCfyfyyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2TkRhkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0507EC4AF17;
	Thu,  6 Jun 2024 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717666968;
	bh=rYDwo9sVsMIRRs3ihHMD2TPD1n36mAZ6UOjA9MgTFl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2TkRhkmkHjPelu0TX61Lw03mfsgAKX5AdeVNRWdi69bFB8h0qZsJnPFLrnCuPxku
	 dxdFZfRwwZwOtg8OiNz43pfLyVhf2onir3ssxX3F1buE3GQT4llJfb1SaU9lXk1KvY
	 CkG1TiSdf3YFb1CgChk2S7RyHCbrWYb4IOLWhybYbd55HfBQ+rCmSJEdR9k+MPybNL
	 ZMna50fnozr8JAm3EzkevVB+iynVrPyA+BP+9FdkeaAJc8EwX+Q06hZluA80nBriBD
	 vNw0aiZ8qa4baABrbRhOw2lK2CdvGaaK3q9nO5e9poi3W8Z9CBm8NxWQ2B1PMEhLBS
	 Wp2yXdqXshmqQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v6 1/1] irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing
Date: Thu,  6 Jun 2024 11:42:38 +0200
Message-Id: <20240606094238.757649-2-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606094238.757649-1-lpieralisi@kernel.org>
References: <20240123110332.112797-1-lpieralisi@kernel.org>
 <20240606094238.757649-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GIC architecture specification defines a set of registers for
redistributors and ITSes that control the sharebility and cacheability
attributes of redistributors/ITSes initiator ports on the interconnect
(GICR_[V]PROPBASER, GICR_[V]PENDBASER, GITS_BASER<n>).

Architecturally the GIC provides a means to drive shareability and
cacheability attributes signals but it is not mandatory for designs to
wire up the corresponding interconnect signals that control the
cacheability/shareability of transactions.

Redistributors and ITSes interconnect ports can be connected to
non-coherent interconnects that are not able to manage the
shareability/cacheability attributes; this implicitly makes the
redistributors and ITSes non-coherent observers.

To enable non-coherent GIC designs on ACPI based systems, parse the MADT
GICC/GICR/ITS subtables non-coherent flags to determine whether the
respective components are non-coherent observers and force the
shareability attributes to be programmed into the redistributors and
ITSes registers.

An ACPI global function (acpi_get_madt_revision()) is added to retrieve
the MADT revision, in that it is essential to check the MADT revision
before checking for flags that were added with MADT revision 7 so that
if the kernel is booted with an ACPI MADT table with revision < 7 it
skips parsing the newly added flags (that should be zeroed reserved
values for MADT versions < 7 but they could turn out to be buggy and
should be ignored).

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/processor_core.c    | 15 +++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c |  4 ++++
 drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
 include/linux/acpi.h             |  3 +++
 4 files changed, 31 insertions(+)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index b203cfe28550..915713c0e9b7 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -215,6 +215,21 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
 	return rv;
 }
 
+int __init acpi_get_madt_revision(void)
+{
+	struct acpi_table_header *madt = NULL;
+	int revision;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_MADT, 0, &madt)))
+		return -EINVAL;
+
+	revision = madt->revision;
+
+	acpi_put_table(madt);
+
+	return revision;
+}
+
 static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 40ebf1726393..af5297ef2293 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5600,6 +5600,10 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 		goto node_err;
 	}
 
+	if (acpi_get_madt_revision() >= 7 &&
+	    (its_entry->flags & ACPI_MADT_ITS_NON_COHERENT))
+		its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
+
 	err = its_probe_one(its);
 	if (!err)
 		return 0;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fb276504bcc..e4bc5f04226e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2349,6 +2349,11 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
 		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
 		return -ENOMEM;
 	}
+
+	if (acpi_get_madt_revision() >= 7 &&
+	    (redist->flags & ACPI_MADT_GICR_NON_COHERENT))
+		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
 	gic_request_region(redist->base_address, redist->length, "GICR");
 
 	gic_acpi_register_redist(redist->base_address, redist_base);
@@ -2373,6 +2378,10 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 		return -ENOMEM;
 	gic_request_region(gicc->gicr_base_address, size, "GICR");
 
+	if (acpi_get_madt_revision() >= 7 &&
+	    (gicc->flags & ACPI_MADT_GICC_NON_COHERENT))
+		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
 	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
 	return 0;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 28c3fb2bef0d..000d339e1596 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -279,6 +279,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
 	return phys_id == PHYS_CPUID_INVALID;
 }
 
+
+int __init acpi_get_madt_revision(void);
+
 /* Validate the processor object's proc_id */
 bool acpi_duplicate_processor_id(int proc_id);
 /* Processor _CTS control */
-- 
2.34.1


