Return-Path: <linux-acpi+bounces-17983-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29657BF1308
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A660D4F4E91
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F143161AA;
	Mon, 20 Oct 2025 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3J+ayYa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B4319879;
	Mon, 20 Oct 2025 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963412; cv=none; b=XQL6ehNLOvNUDe5sgByzTxJTE9fIngGRLURbZ5wwzQlHPxZuV6yzUyO0rt8bYHdfMIYvPLhoOQA4ucNp5YXc32vZ40ghZUyH/oouXY5qo2ooMnhKa405tbFAWD5bEm4vkXhO+iytbowWrav0sXRP0grylZgcfYJsHLQbF/k0vx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963412; c=relaxed/simple;
	bh=kRXD1z71SrYl6iB3aM4rmsDGsHlWWsoJMtlsjrsgPVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpgImUZ8GOLEIwYhtszox0gcBNtgsCFCWTFlOcEsUXwAUJAzxYtpy0Q0HC6XONALG/YRvX3ACluBsw2/tjQiMcAEQtoL2Yir5IzLJ3TtPDQR8x+07z9mEZP/jM3jmsX9AAU6W6Ww+QevbJOdIun6sTmwd7t9PAGQ9FJltLmoCu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3J+ayYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F513C2BCB1;
	Mon, 20 Oct 2025 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963412;
	bh=kRXD1z71SrYl6iB3aM4rmsDGsHlWWsoJMtlsjrsgPVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3J+ayYay2/r9RcFtwYuF7F3gc7y6DQfR+tf2EJdREgQszSL6zv9Vf2nKZbsTMrGd
	 GpfrIoVvsPBEVfKT+u5wfXHj4kQO0M8f5Mkv649WczcABkB4eNXf5/IMqppxBBbX6n
	 m4z1XiiQlztIoHHZgwpmRmvChfPlaXhMTvtQtyi1/9RLdUTSO68lmXlQQVNBGzjJ3g
	 8wGO2P7lbTMalTME5Tpq60FVLZe/jx6fK3hzQKhg5630yo+VlG80Lq1KqJO/+WgK2B
	 7mET/NebPK2jOk6OxPLRe9AnCsnJA1A4IoJyxMrhLbuOEztviDDui+lpBb6oys9kiT
	 b/n8Gb3iwZFiw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1e-0000000FUu2-2Mbl;
	Mon, 20 Oct 2025 12:30:10 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH v4 11/26] genirq: Kill handle_percpu_devid_fasteoi_nmi()
Date: Mon, 20 Oct 2025 13:29:28 +0100
Message-ID: <20251020122944.3074811-12-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020122944.3074811-1-maz@kernel.org>
References: <20251020122944.3074811-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org, jonathan.cameron@huawei.com, ruanjinjie@huawei.com, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

There is no in-tree user of this flow handler anymore, so simply
remove it.

Suggested-by: Will Deacon <will@kernel.org>
Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h |  1 -
 kernel/irq/chip.c   | 25 -------------------------
 2 files changed, 26 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c67e76fbcc077..b728c18f6ded7 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -655,7 +655,6 @@ extern void handle_bad_irq(struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
 
 extern void handle_fasteoi_nmi(struct irq_desc *desc);
-extern void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc);
 
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
 extern int irq_chip_pm_get(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 3ffa0d80ddd19..633e1f67bb6f4 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -929,31 +929,6 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
-/**
- * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
- *				     dev ids
- * @desc:	the interrupt description structure for this irq
- *
- * Similar to handle_fasteoi_nmi, but handling the dev_id cookie
- * as a percpu pointer.
- */
-void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irqaction *action = desc->action;
-	unsigned int irq = irq_desc_get_irq(desc);
-	irqreturn_t res;
-
-	__kstat_incr_irqs_this_cpu(desc);
-
-	trace_irq_handler_entry(irq, action);
-	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
-	trace_irq_handler_exit(irq, action, res);
-
-	if (chip->irq_eoi)
-		chip->irq_eoi(&desc->irq_data);
-}
-
 static void
 __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 		     int is_chained, const char *name)
-- 
2.47.3


