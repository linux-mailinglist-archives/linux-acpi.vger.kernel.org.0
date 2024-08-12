Return-Path: <linux-acpi+bounces-7517-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1B994E45B
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48FC2B20318
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBB3D2EE;
	Mon, 12 Aug 2024 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Nu9cgdVV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E963F8E4
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424459; cv=none; b=WHsmMCTLsyhJzlqwXHhMZRCn8loJQ/1J+6VCxDn1m6i8TTV2Z/MyOpnNGephF0HX5Q+MXplvqlTF9Y+ykvCcdtzqogKN6cs8SnajczWTH4vvou27IRz89WyNNTbPHNoihF9vMeLfmbDSP8F1/BlRwD7hX+EX8ov3K4hmVAoaR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424459; c=relaxed/simple;
	bh=iGwYOvrwXbSwOk6tDmwtihd5FyLmpwbhGFgFf5/6nKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHC/PwAawj7hBv+XXLouaLRKFXnACxZmFbYUlVN/i5mwvCnvaWI7W4mTWpRv4RSGH1CWhw6wOdRjvHbFsEAqOsMYvFK/Zpl+kqhsH3WqAewCU0SiIUMhhX5929XGk1yHFYIYAp0zsXIeNc/8zsbhRCTs6gAVG3XsCh41hW+KMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Nu9cgdVV; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db22c02a42so2489317b6e.3
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424457; x=1724029257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMNBqe/9cTzO1EXtoBS3N5wT2H0f1rIMH9omusI+3YU=;
        b=Nu9cgdVVyh+Y8uT2C+fgYHpqd6I7NNpOs9E3ttt/mnjU+Y6dEi9sowSosNe0y3NxnB
         JEbY3jYeBOWm0PTfjyi7cWWVu6NKjuFQ3lGV8659iP0EBD4fAA9h+CyRSQNAGYRxIiYF
         wN6jBPPhIdz2sKbvIunjTKf0JXV+1RTX98XEP+9gH7tI4c0JOCvTDsOl4iOjwBKu2n/k
         +O6qKvFUbYEt93IzveXJ4g2ZdAXLseBEUMzeMHnkSrYPRgbpG+yN/3y/TOu++snx2LAu
         bV1HsT/2Yqb9YuGM7PHgX+5B76EKFtoQu0b+XcBEgM2X9SyFf+7OqST2nueV4LDtQ6wK
         MsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424457; x=1724029257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMNBqe/9cTzO1EXtoBS3N5wT2H0f1rIMH9omusI+3YU=;
        b=fn9W1tqnYQ8NNF4vUfHmT0/0VOIeUCC6Ke2ZIsvz4cQSND4DwLFXc3cC3LQSdulFRf
         4kninBxlaaHou/pqoLd2MLUtP/mHSWbO2lQgYKerD8pT7ybR9mFKGbX92vnpmp72QSdn
         /nFxmUdaj3POb2W76ObCI/HoTM1AhLQmfJrWZQnIcKqIhvTSbrONIcKZOMYEGBusq9ut
         2fl792/+Yp+LH/rks44GojCGUQ8XEnWgsI0GXq6lpB8Nj9a5G0jhO5fsRFwV7+pVwDyo
         4a1ehYXGPxz1fjXb1DSJQiQj4i5IkTw1PN+qY9guQRlQJSaBFRuRFao/LUGxeZWa7hHY
         bchw==
X-Forwarded-Encrypted: i=1; AJvYcCWjvITHeAagx5bQpE6apdcOhpgp9eXkar4ewHZAC7itkaZQmCPKw3EvR88+x0L1L7afTOt4sPTh2KUNFkaqDTQJsyJfrC23HERRjw==
X-Gm-Message-State: AOJu0YzYglJpiZGbXVqNjOIVDC6WlH8O5WGO3ZtF8OSEO1z78qv6ZmBG
	aPBfuG0yZtXvXPo0mS373b7f1rQa6knDWva55qvTZM1s79EnDCIjjmm45mt8Rko=
X-Google-Smtp-Source: AGHT+IHH0tD3H2b4nYjMLU3yefWBfcIBabXBtrcMk+XbHZMJ1kwyx0P2UJ9m1CeDn96dZhdAvQwZUw==
X-Received: by 2002:a05:6870:d8cc:b0:258:5143:a21a with SMTP id 586e51a60fabf-26c62c69d1cmr9739322fac.13.1723424456739;
        Sun, 11 Aug 2024 18:00:56 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:56 -0700 (PDT)
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
Subject: [PATCH v8 12/17] ACPI: RISC-V: Implement function to add implicit dependencies
Date: Mon, 12 Aug 2024 06:29:24 +0530
Message-ID: <20240812005929.113499-13-sunilvl@ventanamicro.com>
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

RISC-V interrupt controllers for wired interrupts are platform devices
and hence their driver will be probed late. Also, APLIC which is one
such interrupt controller can not be probed early since it needs MSI
services. This needs a probing order between the interrupt controller
driver and the device drivers.

_DEP is typically used to indicate such dependencies. However, the
dependency may be already available like GSI mapping. Hence, instead of
an explicit _DEP, architecture can find the implicit dependencies and
add to the dependency list.

For RISC-V, add the dependencies for below use cases.

1) For devices which has IRQ resource, find out the interrupt controller
using GSI number map and add the dependency.

2) For PCI host bridges:
        a) If _PRT indicate PCI link devices, add dependency on the link
           device.
        b) If _PRT indicates GSI, find out the interrupt controller
           using GSI number map and add the dependency.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/riscv/irq.c | 155 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 9028787c73a7..cced960c2aef 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -20,6 +20,12 @@ struct riscv_ext_intc_list {
 	struct list_head	list;
 };
 
+struct acpi_irq_dep_ctx {
+	int		rc;
+	unsigned int	index;
+	acpi_handle	handle;
+};
+
 LIST_HEAD(ext_intc_list);
 
 static int irqchip_cmp_func(const void *in0, const void *in1)
@@ -178,3 +184,152 @@ void __init riscv_acpi_init_gsi_mapping(void)
 	if (acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, riscv_acpi_aplic_parse_madt, 0) > 0)
 		acpi_get_devices("RSCV0002", riscv_acpi_create_gsi_map, NULL, NULL);
 }
+
+static acpi_handle riscv_acpi_get_gsi_handle(u32 gsi)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct list_head *i;
+
+	list_for_each(i, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (gsi >= ext_intc_element->gsi_base &&
+		    gsi < (ext_intc_element->gsi_base + ext_intc_element->nr_irqs))
+			return ext_intc_element->handle;
+	}
+
+	return NULL;
+}
+
+static acpi_status riscv_acpi_irq_get_parent(struct acpi_resource *ares, void *context)
+{
+	struct acpi_irq_dep_ctx *ctx = context;
+	struct acpi_resource_irq *irq;
+	struct acpi_resource_extended_irq *eirq;
+
+	switch (ares->type) {
+	case ACPI_RESOURCE_TYPE_IRQ:
+		irq = &ares->data.irq;
+		if (ctx->index >= irq->interrupt_count) {
+			ctx->index -= irq->interrupt_count;
+			return AE_OK;
+		}
+		ctx->handle = riscv_acpi_get_gsi_handle(irq->interrupts[ctx->index]);
+		return AE_CTRL_TERMINATE;
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		eirq = &ares->data.extended_irq;
+		if (eirq->producer_consumer == ACPI_PRODUCER)
+			return AE_OK;
+
+		if (ctx->index >= eirq->interrupt_count) {
+			ctx->index -= eirq->interrupt_count;
+			return AE_OK;
+		}
+
+		/* Support GSIs only */
+		if (eirq->resource_source.string_length)
+			return AE_OK;
+
+		ctx->handle = riscv_acpi_get_gsi_handle(eirq->interrupts[ctx->index]);
+		return AE_CTRL_TERMINATE;
+	}
+
+	return AE_OK;
+}
+
+static int riscv_acpi_irq_get_dep(acpi_handle handle, unsigned int index, acpi_handle *gsi_handle)
+{
+	struct acpi_irq_dep_ctx ctx = {-EINVAL, index, NULL};
+
+	if (!gsi_handle)
+		return 0;
+
+	acpi_walk_resources(handle, METHOD_NAME__CRS, riscv_acpi_irq_get_parent, &ctx);
+	*gsi_handle = ctx.handle;
+	if (*gsi_handle)
+		return 1;
+
+	return 0;
+}
+
+static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_pci_routing_table *entry;
+	struct acpi_handle_list dep_devices;
+	acpi_handle gsi_handle;
+	acpi_handle link_handle;
+	acpi_status status;
+	u32 count = 0;
+
+	status = acpi_get_irq_routing_table(handle, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to get IRQ routing table\n");
+		kfree(buffer.pointer);
+		return 0;
+	}
+
+	entry = buffer.pointer;
+	while (entry && (entry->length > 0)) {
+		if (entry->source[0]) {
+			acpi_get_handle(handle, entry->source, &link_handle);
+			dep_devices.count = 1;
+			dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+			if (!dep_devices.handles) {
+				acpi_handle_err(handle, "failed to allocate memory\n");
+				continue;
+			}
+
+			dep_devices.handles[0] = link_handle;
+			count += acpi_scan_add_dep(handle, &dep_devices);
+		} else {
+			gsi_handle = riscv_acpi_get_gsi_handle(entry->source_index);
+			dep_devices.count = 1;
+			dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+			if (!dep_devices.handles) {
+				acpi_handle_err(handle, "failed to allocate memory\n");
+				continue;
+			}
+
+			dep_devices.handles[0] = gsi_handle;
+			count += acpi_scan_add_dep(handle, &dep_devices);
+		}
+
+		entry = (struct acpi_pci_routing_table *)
+			((unsigned long)entry + entry->length);
+	}
+
+	kfree(buffer.pointer);
+	return count;
+}
+
+static u32 riscv_acpi_add_irq_dep(acpi_handle handle)
+{
+	struct acpi_handle_list dep_devices;
+	acpi_handle gsi_handle;
+	u32 count = 0;
+	int i;
+
+	for (i = 0;
+	     riscv_acpi_irq_get_dep(handle, i, &gsi_handle);
+	     i++) {
+		dep_devices.count = 1;
+		dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+		if (!dep_devices.handles) {
+			acpi_handle_err(handle, "failed to allocate memory\n");
+			continue;
+		}
+
+		dep_devices.handles[0] = gsi_handle;
+		count += acpi_scan_add_dep(handle, &dep_devices);
+	}
+
+	return count;
+}
+
+u32 arch_acpi_add_auto_dep(acpi_handle handle)
+{
+	if (acpi_has_method(handle, "_PRT"))
+		return riscv_acpi_add_prt_dep(handle);
+
+	return riscv_acpi_add_irq_dep(handle);
+}
-- 
2.43.0


