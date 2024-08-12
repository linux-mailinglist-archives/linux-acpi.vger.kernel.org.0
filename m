Return-Path: <linux-acpi+bounces-7516-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E64494E458
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DCB281E6E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB42015EA6;
	Mon, 12 Aug 2024 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nPkYE5Ky"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407E15E89
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424452; cv=none; b=D+s9DWAOUDomDm04mMc0mTyb/eCb52L1PDsv+NcV/YPELfHdxPJImODjsoo4MnW9FHLqSrb1bRBLpjLSXurRnm8z2fGWB+vuMJRblPkf5TYd2w0CsEV80YjiuAFgRDSqS3iVuqTRGp6lfCabt+QLApCjF2d5pfSR94FioW3uD7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424452; c=relaxed/simple;
	bh=xZxlyDcMOh+rhR2esklH3kbgHbWDV2ZIJQfnY0eZOqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lS/Dy9egSFUqoH7EmdNaQpiasgwbwBY0Ci1NFlQfkw5Y4JrxmtRvEZ8nTSHKyF6n9o+jsZGf5oWt7hFhP/jfNw93+jeRbPTUd25m/Xtu48N2PPg5vAeW+z0IdOUunESPA30+pbft4MxzUlglLSEx8W+5nrrz7FjaVUShb62v2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nPkYE5Ky; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so2651703b3a.3
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424450; x=1724029250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGfeskz8g19r+OqajKxPNYjNNE+F0wltIvoajFyWVok=;
        b=nPkYE5KywNnZncmpeGKj0K0O4kLz0mH+p6AK50IF0MFjUY0323Dz6u4bHGiHHvctvi
         DQz1HOxI+8tiYOL3rou31Eg7OAnjlXyThkSu5XL6LACW9TokI0qWE3b0aI4GnM9cTh8Q
         VOQ0aDLxwZS4HwhkUOMuFIjx5mAdZ39KqHCt56VBxr0HqqmhhQG+hlOkzt5dwSYi0f3z
         h93suKW3zc3sfQQjcEyjmNTSvjF0WEevPP93KRhSCW0Zqi2pHCl+BjIBJoF52wrsjRMA
         v1yGM0bD3kZiL5wO7T3GaW737w4+5tVcZDEnB/p7RuAOZ0oVnAH91vW/dMhRQNxHfHTQ
         zw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424450; x=1724029250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGfeskz8g19r+OqajKxPNYjNNE+F0wltIvoajFyWVok=;
        b=WtlzziJ7Y0G3k/Psi24OeI9JsG9Tji6dYnBE6xthGx3MaZ886QtW9Gh7DSCbokyXdr
         VQHeFEYrvq4DQ0p0s4RY7eGQCDY4z37X+jgpVgsqL97GW5Szd71EPqxdQJ7A40tob0v7
         etYXc8bh6RYFFmTtDVJhJEpUnLiLVyOipa1zv9IZF2wJ3qNHREoCb4xWM0ohgcGYgUUS
         wgd6thPhWSxeKxWMMiyPwQvukCZalBynbIRBX/27RcNYOSv9rzDC6c6qlLjNZsOXMRZE
         +8Q5vgrwIZgh+79IrdLs862bYRd7V9sh/f2uZlBt7FK3WJyqbyvSD6k86bBgkZo3/oiQ
         qM3g==
X-Forwarded-Encrypted: i=1; AJvYcCV3NTbR2aNx6a5qZJEahG1G2IJlg1AE/ZW+DGKP8pqjBy1qu7t9R4KVvAv4zVF/0bYekHocK2ggG5oXHC5bp1OElS6/dNWJbBaHOg==
X-Gm-Message-State: AOJu0Yw97fUDIv+2IQInwlnTXWb7Y80FASD+Xdp1KW9P1h2Qna8zkPQ6
	p0FaZJWS3/hCZ75+YUCvVsGG/dT9RO3ne0UmmSR0ZD/yK2eAnwuAqPmIuFUr/xQ=
X-Google-Smtp-Source: AGHT+IE3q8lKgHgWLAwxE/0Wiss9V/UMieO99InX6OgVwr4G4I59tEn3alleuzimlu24LFWs915ICg==
X-Received: by 2002:a05:6a00:2da1:b0:710:7efe:a870 with SMTP id d2e1a72fcca58-710dcaeb509mr5600452b3a.19.1723424450430;
        Sun, 11 Aug 2024 18:00:50 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:49 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 11/17] ACPI: RISC-V: Initialize GSI mapping structures
Date: Mon, 12 Aug 2024 06:29:23 +0530
Message-ID: <20240812005929.113499-12-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

RISC-V has PLIC and APLIC in MADT as well as namespace devices.
Initialize the list of those structures using MADT and namespace devices
to create mapping between the ACPI handle and the GSI ranges. This will
be used later to add dependencies.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/irq.h |  22 ++++++
 drivers/acpi/riscv/init.c    |   2 +
 drivers/acpi/riscv/init.h    |   4 +
 drivers/acpi/riscv/irq.c     | 147 +++++++++++++++++++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 drivers/acpi/riscv/init.h

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 8e10a94430a2..44a0b128c602 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -16,4 +16,26 @@ void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
 
 struct fwnode_handle *riscv_get_intc_hwnode(void);
 
+#ifdef CONFIG_ACPI
+
+enum riscv_irqchip_type {
+	ACPI_RISCV_IRQCHIP_INTC		= 0x00,
+	ACPI_RISCV_IRQCHIP_IMSIC	= 0x01,
+	ACPI_RISCV_IRQCHIP_PLIC		= 0x02,
+	ACPI_RISCV_IRQCHIP_APLIC	= 0x03,
+};
+
+int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
+			    u32 *id, u32 *nr_irqs, u32 *nr_idcs);
+struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi);
+
+#else
+static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
+					  u32 *id, u32 *nr_irqs, u32 *nr_idcs)
+{
+	return 0;
+}
+
+#endif /* CONFIG_ACPI */
+
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index a875a76aa44c..5ef97905a727 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -5,7 +5,9 @@
  */
 
 #include <linux/acpi.h>
+#include "init.h"
 
 void __init acpi_riscv_init(void)
 {
+	riscv_acpi_init_gsi_mapping();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
new file mode 100644
index 000000000000..0b9a07e4031f
--- /dev/null
+++ b/drivers/acpi/riscv/init.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/init.h>
+
+void __init riscv_acpi_init_gsi_mapping(void);
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 835eb6eccd53..9028787c73a7 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -6,6 +6,21 @@
 
 #include <linux/acpi.h>
 #include <linux/sort.h>
+#include <linux/irq.h>
+
+#include "init.h"
+
+struct riscv_ext_intc_list {
+	acpi_handle		handle;
+	u32			gsi_base;
+	u32			nr_irqs;
+	u32			nr_idcs;
+	u32			id;
+	u32			type;
+	struct list_head	list;
+};
+
+LIST_HEAD(ext_intc_list);
 
 static int irqchip_cmp_func(const void *in0, const void *in1)
 {
@@ -31,3 +46,135 @@ void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
 		return;
 	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
 }
+
+static acpi_status riscv_acpi_update_gsi_handle(u32 gsi_base, acpi_handle handle)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct list_head *i, *tmp;
+
+	list_for_each_safe(i, tmp, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (gsi_base == ext_intc_element->gsi_base) {
+			ext_intc_element->handle = handle;
+			return AE_OK;
+		}
+	}
+
+	return AE_NOT_FOUND;
+}
+
+int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
+			    u32 *id, u32 *nr_irqs, u32 *nr_idcs)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct list_head *i;
+
+	list_for_each(i, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (ext_intc_element->handle == ACPI_HANDLE_FWNODE(fwnode)) {
+			*gsi_base = ext_intc_element->gsi_base;
+			*id = ext_intc_element->id;
+			*nr_irqs = ext_intc_element->nr_irqs;
+			if (nr_idcs)
+				*nr_idcs = ext_intc_element->nr_idcs;
+
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct acpi_device *adev;
+	struct list_head *i;
+
+	list_for_each(i, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (gsi >= ext_intc_element->gsi_base &&
+		    gsi < (ext_intc_element->gsi_base + ext_intc_element->nr_irqs)) {
+			adev = acpi_fetch_acpi_dev(ext_intc_element->handle);
+			if (!adev)
+				return NULL;
+
+			return acpi_fwnode_handle(adev);
+		}
+	}
+
+	return NULL;
+}
+
+static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr_idcs,
+					       u32 id, u32 type)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+
+	ext_intc_element = kzalloc(sizeof(*ext_intc_element), GFP_KERNEL);
+	if (!ext_intc_element)
+		return -ENOMEM;
+
+	ext_intc_element->gsi_base = gsi_base;
+	ext_intc_element->nr_irqs = nr_irqs;
+	ext_intc_element->nr_idcs = nr_idcs;
+	ext_intc_element->id = id;
+	list_add_tail(&ext_intc_element->list, &ext_intc_list);
+	return 0;
+}
+
+static acpi_status __init riscv_acpi_create_gsi_map(acpi_handle handle, u32 level,
+						    void *context, void **return_value)
+{
+	acpi_status status;
+	u64 gbase;
+
+	if (!acpi_has_method(handle, "_GSB")) {
+		acpi_handle_err(handle, "_GSB method not found\n");
+		return AE_ERROR;
+	}
+
+	status = acpi_evaluate_integer(handle, "_GSB", NULL, &gbase);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to evaluate _GSB method\n");
+		return status;
+	}
+
+	status = riscv_acpi_update_gsi_handle((u32)gbase, handle);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to find the GSI mapping entry\n");
+		return status;
+	}
+
+	return AE_OK;
+}
+
+static int __init riscv_acpi_aplic_parse_madt(union acpi_subtable_headers *header,
+					      const unsigned long end)
+{
+	struct acpi_madt_aplic *aplic = (struct acpi_madt_aplic *)header;
+
+	return riscv_acpi_register_ext_intc(aplic->gsi_base, aplic->num_sources, aplic->num_idcs,
+					    aplic->id, ACPI_RISCV_IRQCHIP_APLIC);
+}
+
+static int __init riscv_acpi_plic_parse_madt(union acpi_subtable_headers *header,
+					     const unsigned long end)
+{
+	struct acpi_madt_plic *plic = (struct acpi_madt_plic *)header;
+
+	return riscv_acpi_register_ext_intc(plic->gsi_base, plic->num_irqs, 0,
+					    plic->id, ACPI_RISCV_IRQCHIP_PLIC);
+}
+
+void __init riscv_acpi_init_gsi_mapping(void)
+{
+	/* There can be either PLIC or APLIC */
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_PLIC, riscv_acpi_plic_parse_madt, 0) > 0) {
+		acpi_get_devices("RSCV0001", riscv_acpi_create_gsi_map, NULL, NULL);
+		return;
+	}
+
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, riscv_acpi_aplic_parse_madt, 0) > 0)
+		acpi_get_devices("RSCV0002", riscv_acpi_create_gsi_map, NULL, NULL);
+}
-- 
2.43.0


