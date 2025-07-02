Return-Path: <linux-acpi+bounces-14905-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B9AF0A76
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0F5441754
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE342236E9;
	Wed,  2 Jul 2025 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hYdos85D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83D71F5838
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433348; cv=none; b=g+SyCWZIKymOeyOR3VukpimIKN6PqV+y/D0aucZv09eKKkJoVpFVoQP0do+71CiSL1JxN/AwpjrTZwBtkc6mJwQ9MLulzLO+gp/bQg/ZPv0KSU8fEmlxXXP4tjraSRgBYF9q4kLV/PZDWvY/x8jtyilNXN1K7PYOhya4zdFM/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433348; c=relaxed/simple;
	bh=Lt1dzy9yqik0Bteim+AtzsP8/JK538WOl/oxTcecFS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIj2+q9jsbPxYCTQdKz6rDc6MTgUPJR7kys3Ffr1QbPNSc0nSYo2myQCChHBNcKrgm195lnTKc4OilyBe8aG1hOmRPkberkE5glA55Zir+6WUTJmV+DHCm2JKrTumkHHaUW/nehR4Mh8jQdExZyTHCcSIpxHr57wASlamLV7N2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hYdos85D; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234fcadde3eso52619135ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433346; x=1752038146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df2FyXzkxBTr99ltlso4sgxLOMKPyu9ZrXlLZcqz5Z0=;
        b=hYdos85Dlq9jKuS5Nxdq31t7Sv1cbRqKv0lO3/EUIblMwAWrc3tKzsppNhgD8aokZa
         2TO4f4pY0LhWmyQTC1bPJLU5LyK/pXCP67IkXRT9P6A3ZmdZ/ZZXmMjkWmW6U5hxb6k1
         sqfXZ1abLTluJrCdeYjHCdKFu2bHB5hYF8bAwVdZJIsVS10pMBzUUOhlE7xVMFXZiNQi
         BgGjGgChk6AsIyKZVH4gwO89T+nCKcBtR71AfYqgUtqKq3bolav2EZ8pq63Xdj3z8Rbt
         esd/nDgF8lB3PG2FrmHwrGLB91hv23aI3fjMEnzISsCqd+PgqjdtU9/mfretti3RkhiL
         1KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433346; x=1752038146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df2FyXzkxBTr99ltlso4sgxLOMKPyu9ZrXlLZcqz5Z0=;
        b=ClevAHkUHwAQlpk71QmafbSCYNE2fsUkwj8Hu+lDrzcNPS45J9RA8zhpeV/TKuEWdA
         1L5G5ZxwzK6CTQFL7+hy/pxbSbVQIaQrg5PmsKo2/5frf90SHffCFAot9gN8li7SKTDj
         4Fq/Wpt8ajBfim/jcsjTlKNYxn4T7vZZXY4S3LmOjrx2R6KHtt51UWuRZWzZXXhcRbx3
         S8M8YBoEja3xO8BAQFp2wPm318AQrcm5faje4FirseZb33ElEWohW9e51vlHACQXRKwu
         6wohYaba0qKaRhtt3f1W+hQ8teiMPo++CiN6JtnlhomECx6bfFweqo7M1JrvS6Qo54iJ
         +IbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRiXFSSyLxY90I1juDMwN+ahk1Bg9d2xX3P9AoG11BdbDODKbMOHcT/RSrfeKtnBCiUWCPKVg7JJ2r@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8sJf3OL1F2jb0vg07HDxDz/HCpaWAB1x8liWSOJ/WRjQSilcj
	takhGdwLdbx6vtTAHhMXZB5MPH2RhUM5AWSggqeMM8SF5ULOV0HYwVX0CfhNl25C5Ag=
X-Gm-Gg: ASbGncs9WUcr2fq0/XbAvc7bIGxzUMJO7pfsC2MkvGJUExkmZZlrmEzYzNSz1Zf6V9O
	ek9LXobtJMoqi1ttsP2lsopLbCG0UIN+g2R/46FEg4IRd1YIospmXXyL8nq6kIeS52MeHyODubt
	qyozh3rPEXHEuI7NjxQvCaSPwOvHmVPLl980D/eDpl4LDDE65HC63tTEQEeVCwz4QXy5fjDI5Vr
	CrJFR6QL/NmONTTkxFww2RslOiV6lKTC3P9sG/poGYK3RpTiXRZvjidS0h8DOdUG7UeodhRhW7U
	BSG8Qi1/fOUU+1Ryn/QuL+zp7trnGN8LXvQCj8YBLFbp3Uskona7WenOOCWTLcOV2EIEGsOby1h
	JBupFMAK9Ocnpr0m5rldH+rlCXG8=
X-Google-Smtp-Source: AGHT+IHKXlJUNM5wrbDzFdMKDrEAtkb/8gAyGIxBsjnrD3QF0H8k7d9INC+T6MIOZ9N6zsBU82fkwA==
X-Received: by 2002:a17:903:8cd:b0:235:e96b:191c with SMTP id d9443c01a7336-23c6e58ac8emr21059475ad.29.1751433345766;
        Tue, 01 Jul 2025 22:15:45 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:15:45 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v7 13/24] irqchip: Add driver for the RPMI system MSI service group
Date: Wed,  2 Jul 2025 10:43:34 +0530
Message-ID: <20250702051345.1460497-14-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702051345.1460497-1-apatel@ventanamicro.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RPMI specification defines a system MSI service group which
allows application processors to receive MSIs upon system events
such as graceful shutdown/reboot request, CPU hotplug event, memory
hotplug event, etc.

Add an irqchip driver for the RISC-V RPMI system MSI service group
to directly receive system MSIs in Linux kernel.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig                    |   7 +
 drivers/irqchip/Makefile                   |   1 +
 drivers/irqchip/irq-riscv-rpmi-sysmsi.c    | 283 +++++++++++++++++++++
 include/linux/mailbox/riscv-rpmi-message.h |  13 +
 4 files changed, 304 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-rpmi-sysmsi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 0d196e447142..96bf6aa55681 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -617,6 +617,13 @@ config RISCV_IMSIC
 	select GENERIC_MSI_IRQ
 	select IRQ_MSI_LIB
 
+config RISCV_RPMI_SYSMSI
+	bool
+	depends on MAILBOX
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_MSI_IRQ
+	default RISCV
+
 config SIFIVE_PLIC
 	bool
 	depends on RISCV
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 23ca4959e6ce..4fd966aa78ab 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
 obj-$(CONFIG_RISCV_APLIC)		+= irq-riscv-aplic-main.o irq-riscv-aplic-direct.o
 obj-$(CONFIG_RISCV_APLIC_MSI)		+= irq-riscv-aplic-msi.o
 obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
+obj-$(CONFIG_RISCV_RPMI_SYSMSI)		+= irq-riscv-rpmi-sysmsi.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_STARFIVE_JH8100_INTC)	+= irq-starfive-jh8100-intc.o
 obj-$(CONFIG_THEAD_C900_ACLINT_SSWI)	+= irq-thead-c900-aclint-sswi.o
diff --git a/drivers/irqchip/irq-riscv-rpmi-sysmsi.c b/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
new file mode 100644
index 000000000000..c42fceab71fa
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025 Ventana Micro Systems Inc. */
+
+#include <linux/bits.h>
+#include <linux/bug.h>
+#include <linux/device.h>
+#include <linux/device/devres.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox/riscv-rpmi-message.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+struct rpmi_sysmsi_get_attrs_rx {
+	__le32 status;
+	__le32 sys_num_msi;
+	__le32 flag0;
+	__le32 flag1;
+};
+
+#define RPMI_SYSMSI_MSI_ATTRIBUTES_FLAG0_PREF_PRIV	BIT(0)
+
+struct rpmi_sysmsi_set_msi_state_tx {
+	__le32 sys_msi_index;
+	__le32 sys_msi_state;
+};
+
+struct rpmi_sysmsi_set_msi_state_rx {
+	__le32 status;
+};
+
+#define RPMI_SYSMSI_MSI_STATE_ENABLE			BIT(0)
+#define RPMI_SYSMSI_MSI_STATE_PENDING			BIT(1)
+
+struct rpmi_sysmsi_set_msi_target_tx {
+	__le32 sys_msi_index;
+	__le32 sys_msi_address_low;
+	__le32 sys_msi_address_high;
+	__le32 sys_msi_data;
+};
+
+struct rpmi_sysmsi_set_msi_target_rx {
+	__le32 status;
+};
+
+struct rpmi_sysmsi_priv {
+	struct device		*dev;
+	struct mbox_client	client;
+	struct mbox_chan	*chan;
+	u32			nr_irqs;
+	u32			gsi_base;
+};
+
+static int rpmi_sysmsi_get_num_msi(struct rpmi_sysmsi_priv *priv)
+{
+	struct rpmi_sysmsi_get_attrs_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_SYSMSI_SRV_GET_ATTRIBUTES,
+					  NULL, 0, &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(priv->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	return le32_to_cpu(rx.sys_num_msi);
+}
+
+static int rpmi_sysmsi_set_msi_state(struct rpmi_sysmsi_priv *priv,
+				     u32 sys_msi_index, u32 sys_msi_state)
+{
+	struct rpmi_sysmsi_set_msi_state_tx tx;
+	struct rpmi_sysmsi_set_msi_state_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	tx.sys_msi_index = cpu_to_le32(sys_msi_index);
+	tx.sys_msi_state = cpu_to_le32(sys_msi_state);
+	rpmi_mbox_init_send_with_response(&msg, RPMI_SYSMSI_SRV_SET_MSI_STATE,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(priv->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	return 0;
+}
+
+static int rpmi_sysmsi_set_msi_target(struct rpmi_sysmsi_priv *priv,
+				      u32 sys_msi_index, struct msi_msg *m)
+{
+	struct rpmi_sysmsi_set_msi_target_tx tx;
+	struct rpmi_sysmsi_set_msi_target_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	tx.sys_msi_index = cpu_to_le32(sys_msi_index);
+	tx.sys_msi_address_low = cpu_to_le32(m->address_lo);
+	tx.sys_msi_address_high = cpu_to_le32(m->address_hi);
+	tx.sys_msi_data = cpu_to_le32(m->data);
+	rpmi_mbox_init_send_with_response(&msg, RPMI_SYSMSI_SRV_SET_MSI_TARGET,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(priv->chan, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	return 0;
+}
+
+static void rpmi_sysmsi_irq_mask(struct irq_data *d)
+{
+	struct rpmi_sysmsi_priv *priv = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	int ret;
+
+	ret = rpmi_sysmsi_set_msi_state(priv, hwirq, 0);
+	if (ret)
+		dev_warn(priv->dev, "Failed to mask hwirq %lu (error %d)\n", hwirq, ret);
+	irq_chip_mask_parent(d);
+}
+
+static void rpmi_sysmsi_irq_unmask(struct irq_data *d)
+{
+	struct rpmi_sysmsi_priv *priv = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	int ret;
+
+	irq_chip_unmask_parent(d);
+	ret = rpmi_sysmsi_set_msi_state(priv, hwirq, RPMI_SYSMSI_MSI_STATE_ENABLE);
+	if (ret)
+		dev_warn(priv->dev, "Failed to unmask hwirq %lu (error %d)\n", hwirq, ret);
+}
+
+static void rpmi_sysmsi_write_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct rpmi_sysmsi_priv *priv = irq_data_get_irq_chip_data(d);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	int ret;
+
+	/* For zeroed MSI, do nothing as of now */
+	if (!msg->address_hi && !msg->address_lo && !msg->data)
+		return;
+
+	ret = rpmi_sysmsi_set_msi_target(priv, hwirq, msg);
+	if (ret)
+		dev_warn(priv->dev, "Failed to set target for hwirq %lu (error %d)\n", hwirq, ret);
+}
+
+static void rpmi_sysmsi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = desc->data.icookie.value;
+}
+
+static int rpmi_sysmsi_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
+				 unsigned long *hwirq, unsigned int *type)
+{
+	struct msi_domain_info *info = d->host_data;
+	struct rpmi_sysmsi_priv *priv = info->data;
+
+	if (WARN_ON(fwspec->param_count < 1))
+		return -EINVAL;
+
+	/* For DT, gsi_base is always zero. */
+	*hwirq = fwspec->param[0] - priv->gsi_base;
+	*type = IRQ_TYPE_NONE;
+	return 0;
+}
+
+static const struct msi_domain_template rpmi_sysmsi_template = {
+	.chip = {
+		.name			= "RPMI-SYSMSI",
+		.irq_mask		= rpmi_sysmsi_irq_mask,
+		.irq_unmask		= rpmi_sysmsi_irq_unmask,
+#ifdef CONFIG_SMP
+		.irq_set_affinity	= irq_chip_set_affinity_parent,
+#endif
+		.irq_write_msi_msg	= rpmi_sysmsi_write_msg,
+		.flags			= IRQCHIP_SET_TYPE_MASKED |
+					  IRQCHIP_SKIP_SET_WAKE |
+					  IRQCHIP_MASK_ON_SUSPEND,
+	},
+
+	.ops = {
+		.set_desc		= rpmi_sysmsi_set_desc,
+		.msi_translate		= rpmi_sysmsi_translate,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			= MSI_FLAG_USE_DEV_FWNODE,
+		.handler		= handle_simple_irq,
+		.handler_name		= "simple",
+	},
+};
+
+static int rpmi_sysmsi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rpmi_sysmsi_priv *priv;
+	int rc;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = dev;
+
+	/* Setup mailbox client */
+	priv->client.dev		= priv->dev;
+	priv->client.rx_callback	= NULL;
+	priv->client.tx_block		= false;
+	priv->client.knows_txdone	= true;
+	priv->client.tx_tout		= 0;
+
+	/* Request mailbox channel */
+	priv->chan = mbox_request_channel(&priv->client, 0);
+	if (IS_ERR(priv->chan))
+		return PTR_ERR(priv->chan);
+
+	/* Get number of system MSIs */
+	rc = rpmi_sysmsi_get_num_msi(priv);
+	if (rc < 1) {
+		mbox_free_channel(priv->chan);
+		if (rc)
+			return dev_err_probe(dev, rc, "Failed to get number of system MSIs\n");
+		else
+			return dev_err_probe(dev, -ENODEV, "No system MSIs found\n");
+	}
+	priv->nr_irqs = rc;
+
+	/* Set the device MSI domain if not available */
+	if (!dev_get_msi_domain(dev)) {
+		/*
+		 * The device MSI domain for OF devices is only set at the
+		 * time of populating/creating OF device. If the device MSI
+		 * domain is discovered later after the OF device is created
+		 * then we need to set it explicitly before using any platform
+		 * MSI functions.
+		 */
+		if (dev_of_node(dev))
+			of_msi_configure(dev, dev_of_node(dev));
+
+		if (!dev_get_msi_domain(dev)) {
+			mbox_free_channel(priv->chan);
+			return -EPROBE_DEFER;
+		}
+	}
+
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					  &rpmi_sysmsi_template,
+					  priv->nr_irqs, priv, priv)) {
+		mbox_free_channel(priv->chan);
+		return dev_err_probe(dev, -ENOMEM, "failed to create MSI irq domain\n");
+	}
+
+	dev_info(dev, "%u system MSIs registered\n", priv->nr_irqs);
+	return 0;
+}
+
+static const struct of_device_id rpmi_sysmsi_match[] = {
+	{ .compatible = "riscv,rpmi-system-msi" },
+	{}
+};
+
+static struct platform_driver rpmi_sysmsi_driver = {
+	.driver = {
+		.name		= "rpmi-sysmsi",
+		.of_match_table	= rpmi_sysmsi_match,
+	},
+	.probe = rpmi_sysmsi_probe,
+};
+builtin_platform_driver(rpmi_sysmsi_driver);
diff --git a/include/linux/mailbox/riscv-rpmi-message.h b/include/linux/mailbox/riscv-rpmi-message.h
index c90918dca367..521a0c9b9b90 100644
--- a/include/linux/mailbox/riscv-rpmi-message.h
+++ b/include/linux/mailbox/riscv-rpmi-message.h
@@ -91,6 +91,7 @@ static inline int rpmi_to_linux_error(int rpmi_error)
 }
 
 /* RPMI service group IDs */
+#define RPMI_SRVGRP_SYSTEM_MSI		0x00002
 #define RPMI_SRVGRP_CLOCK		0x00008
 
 /* RPMI clock service IDs */
@@ -106,6 +107,18 @@ enum rpmi_clock_service_id {
 	RPMI_CLK_SRV_ID_MAX_COUNT
 };
 
+/* RPMI system MSI service IDs */
+enum rpmi_sysmsi_service_id {
+	RPMI_SYSMSI_SRV_ENABLE_NOTIFICATION = 0x01,
+	RPMI_SYSMSI_SRV_GET_ATTRIBUTES = 0x02,
+	RPMI_SYSMSI_SRV_GET_MSI_ATTRIBUTES = 0x03,
+	RPMI_SYSMSI_SRV_SET_MSI_STATE = 0x04,
+	RPMI_SYSMSI_SRV_GET_MSI_STATE = 0x05,
+	RPMI_SYSMSI_SRV_SET_MSI_TARGET = 0x06,
+	RPMI_SYSMSI_SRV_GET_MSI_TARGET = 0x07,
+	RPMI_SYSMSI_SRV_ID_MAX_COUNT
+};
+
 /* RPMI Linux mailbox attribute IDs */
 enum rpmi_mbox_attribute_id {
 	RPMI_MBOX_ATTR_SPEC_VERSION,
-- 
2.43.0


