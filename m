Return-Path: <linux-acpi+bounces-7518-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F8C94E45D
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF1B281E58
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B309182C9;
	Mon, 12 Aug 2024 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fIrNQKkT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC935495E5
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424465; cv=none; b=X5l+JkR49mmTozplr/ZBDWr58djXBUVEN8i/52QICsF/DyoDc5ZYdm+B8+cPNhRvWNbx3o0IuHJG5EWmUGxkXAn2t+CjLDK1YEVGSlO53TXZc71zWChmkyzApChyYho8HlKKpVSUR5w1v9BGOJfnB40jwzr9b0Ce2bKFxf+yDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424465; c=relaxed/simple;
	bh=c1qYc4e9QVIA4mjJd8so/MjtDZRnBh9X0X6PihmPtA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItMN8clhKrVqFFR+Suz15BQN/RbJ1L2ynx2tE++mFv+1Nlh4vTopaz//jUQcobiNCUWn0Foox8EPwJfykD85d8OYn1s/JPW2hCn2GsrS624qJubnW0rSU53o03zZZJLP77isx8fir06GeNDyS0F9P73NkXPoxBgYn8qUmeytjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fIrNQKkT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb53da06a9so2516440a91.0
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424463; x=1724029263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eWLrHir182byqrnausz4PNiecB0MULYeCzMr04SHA0=;
        b=fIrNQKkTMkiUxfExrArXoVdzzk5c2ql1ftyieqizDZtgi1Gv+jb4NfEmb0HtoSd7Z3
         dyStfuD692hBpKEot+vNOt9M5KHGwwYhGb3Apb/U5BTLrdjakkQ19ebWWsEtifK5Wz1e
         seblnTFDGN7tO2oYa+XS9HXV7lu9UH5q7GzWCSr+0m90wnPgAZKyt5VT2MStpL8iJBbk
         PSBh8tz4gFci92tuMF3fsraetQ8jyms/f/uQkH3OFJOGUOf/OIpjSGydIwP5+7AYPABl
         5UUcuOnqUtuGOBn47L9Ka3+/6RBWX6vU4LteuylRJibHN/kwllccBsLGqX+/Hi1a+A0z
         ZPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424463; x=1724029263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eWLrHir182byqrnausz4PNiecB0MULYeCzMr04SHA0=;
        b=pb6kLNJB1XaAnW0eXYTLUOTNu972335vc/fPL28KM/4iGnVzH6Qo4mVklBbQRrdvwL
         ANOIi2+J+LLTktqI9EgjyNa8ZA3wWXUWQPLYQxBTNpS/XT/CHTRzt+x7JdbWP9mSyQgZ
         RbRtNiSpXIOkmn7uycNuuKiqtCnHes/zMixdOQ2XGsHqiTr8GlC9zYQ5Uu2G4zEbNN8h
         op3C/WPuPZ7/FED58wbYrfTCqu3NyqZPaeFmSa7zoedLyZLsuUxQnGka1E2KqH1RAguR
         WYoJPhNEELxeur17b0aQ8fuQICKWIzoO7vzxUsSLYT1D/VqSG7KXMZZ3ikRYvlQJL0yh
         M2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSHvLk7JUSZLoh1kExh8440TzmUJKlsaaAJ45x3rhfwmr4aKvR7xkpHiXWb3RNlwSm1ZBolowHVKjvYz0qIReSjfAvrP43tPXSmQ==
X-Gm-Message-State: AOJu0YzCgfipmN0oVWcB8tODGuRy0ReULwyfWGeL0FYNHPOehX5B8XHW
	BbR+LEEFJ7JaSu96TM8ah0vuqVsQ5MHPqTXzaSEozOOcCUJR/HgHiZiImV3+sMs=
X-Google-Smtp-Source: AGHT+IEmnnZO8yRXJ6ENu6bAM1Iq53DDo8oXCMY/2aarMSTJFhyCJE6z0a/eBIRQSdiXXTmWXrm9Iw==
X-Received: by 2002:a17:90b:1887:b0:2cf:dd3c:9b0d with SMTP id 98e67ed59e1d1-2d1c4b674cdmr19256482a91.2.1723424463037;
        Sun, 11 Aug 2024 18:01:03 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:01:02 -0700 (PDT)
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
Subject: [PATCH v8 13/17] irqchip/riscv-intc: Add ACPI support for AIA
Date: Mon, 12 Aug 2024 06:29:25 +0530
Message-ID: <20240812005929.113499-14-sunilvl@ventanamicro.com>
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

The RINTC subtype structure in MADT also has information about other
interrupt controllers. Save this information and provide interfaces to
retrieve them when required by corresponding drivers.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/irq.h     | 33 ++++++++++++
 drivers/irqchip/irq-riscv-intc.c | 90 ++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 44a0b128c602..7e9a84a005ed 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -12,6 +12,8 @@
 
 #include <asm-generic/irq.h>
 
+#define INVALID_CONTEXT UINT_MAX
+
 void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
 
 struct fwnode_handle *riscv_get_intc_hwnode(void);
@@ -28,6 +30,11 @@ enum riscv_irqchip_type {
 int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
 			    u32 *id, u32 *nr_irqs, u32 *nr_idcs);
 struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi);
+unsigned long acpi_rintc_index_to_hartid(u32 index);
+unsigned long acpi_rintc_ext_parent_to_hartid(unsigned int plic_id, unsigned int ctxt_idx);
+unsigned int acpi_rintc_get_plic_nr_contexts(unsigned int plic_id);
+unsigned int acpi_rintc_get_plic_context(unsigned int plic_id, unsigned int ctxt_idx);
+int __init acpi_rintc_get_imsic_mmio_info(u32 index, struct resource *res);
 
 #else
 static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
@@ -36,6 +43,32 @@ static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi
 	return 0;
 }
 
+static inline unsigned long acpi_rintc_index_to_hartid(u32 index)
+{
+	return INVALID_HARTID;
+}
+
+static inline unsigned long acpi_rintc_ext_parent_to_hartid(unsigned int plic_id,
+							    unsigned int ctxt_idx)
+{
+	return INVALID_HARTID;
+}
+
+static inline unsigned int acpi_rintc_get_plic_nr_contexts(unsigned int plic_id)
+{
+	return INVALID_CONTEXT;
+}
+
+static inline unsigned int acpi_rintc_get_plic_context(unsigned int plic_id, unsigned int ctxt_idx)
+{
+	return INVALID_CONTEXT;
+}
+
+static inline int __init acpi_rintc_get_imsic_mmio_info(u32 index, struct resource *res)
+{
+	return 0;
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 47f3200476da..8c5411386220 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -250,6 +250,85 @@ IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
 
 #ifdef CONFIG_ACPI
 
+struct rintc_data {
+	union {
+		u32		ext_intc_id;
+		struct {
+			u32	context_id	: 16,
+				reserved	:  8,
+				aplic_plic_id	:  8;
+		};
+	};
+	unsigned long		hart_id;
+	u64			imsic_addr;
+	u32			imsic_size;
+};
+
+static u32 nr_rintc;
+static struct rintc_data *rintc_acpi_data[NR_CPUS];
+
+#define for_each_matching_plic(_plic_id)				\
+	unsigned int _plic;						\
+									\
+	for (_plic = 0; _plic < nr_rintc; _plic++)			\
+		if (rintc_acpi_data[_plic]->aplic_plic_id != _plic_id)	\
+			continue;					\
+		else
+
+unsigned int acpi_rintc_get_plic_nr_contexts(unsigned int plic_id)
+{
+	unsigned int nctx = 0;
+
+	for_each_matching_plic(plic_id)
+		nctx++;
+
+	return nctx;
+}
+
+static struct rintc_data *get_plic_context(unsigned int plic_id, unsigned int ctxt_idx)
+{
+	unsigned int ctxt = 0;
+
+	for_each_matching_plic(plic_id) {
+		if (ctxt == ctxt_idx)
+			return rintc_acpi_data[_plic];
+
+		ctxt++;
+	}
+
+	return NULL;
+}
+
+unsigned long acpi_rintc_ext_parent_to_hartid(unsigned int plic_id, unsigned int ctxt_idx)
+{
+	struct rintc_data *data = get_plic_context(plic_id, ctxt_idx);
+
+	return data ? data->hart_id : INVALID_HARTID;
+}
+
+unsigned int acpi_rintc_get_plic_context(unsigned int plic_id, unsigned int ctxt_idx)
+{
+	struct rintc_data *data = get_plic_context(plic_id, ctxt_idx);
+
+	return data ? data->context_id : INVALID_CONTEXT;
+}
+
+unsigned long acpi_rintc_index_to_hartid(u32 index)
+{
+	return index >= nr_rintc ? INVALID_HARTID : rintc_acpi_data[index]->hart_id;
+}
+
+int acpi_rintc_get_imsic_mmio_info(u32 index, struct resource *res)
+{
+	if (index >= nr_rintc)
+		return -1;
+
+	res->start = rintc_acpi_data[index]->imsic_addr;
+	res->end = res->start + rintc_acpi_data[index]->imsic_size - 1;
+	res->flags = IORESOURCE_MEM;
+	return 0;
+}
+
 static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 				       const unsigned long end)
 {
@@ -258,6 +337,15 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 	int rc;
 
 	rintc = (struct acpi_madt_rintc *)header;
+	rintc_acpi_data[nr_rintc] = kzalloc(sizeof(*rintc_acpi_data[0]), GFP_KERNEL);
+	if (!rintc_acpi_data[nr_rintc])
+		return -ENOMEM;
+
+	rintc_acpi_data[nr_rintc]->ext_intc_id = rintc->ext_intc_id;
+	rintc_acpi_data[nr_rintc]->hart_id = rintc->hart_id;
+	rintc_acpi_data[nr_rintc]->imsic_addr = rintc->imsic_addr;
+	rintc_acpi_data[nr_rintc]->imsic_size = rintc->imsic_size;
+	nr_rintc++;
 
 	/*
 	 * The ACPI MADT will have one INTC for each CPU (or HART)
@@ -277,6 +365,8 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 	rc = riscv_intc_init_common(fn, &riscv_intc_chip);
 	if (rc)
 		irq_domain_free_fwnode(fn);
+	else
+		acpi_set_irq_model(ACPI_IRQ_MODEL_RINTC, riscv_acpi_get_gsi_domain_id);
 
 	return rc;
 }
-- 
2.43.0


