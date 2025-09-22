Return-Path: <linux-acpi+bounces-17182-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B93B8F83C
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC187A7D5F
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036C13002D0;
	Mon, 22 Sep 2025 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvKPJ6yo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0262FFFAD;
	Mon, 22 Sep 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529726; cv=none; b=slisCeuVvBtlK+wCdo9YJHtlUOEKvXZfaMVsqtgkeXDbc0KRQ74mhs7AgbtQk8PYtmFU8Ed+aJcIkmgixaGPpt1GtclldD/xYHYRwMB/vEKNGhOacvo6pT0GjNpYEfIP/YOM2mK6wr8edXo5NWUXveJ6yEA2azwvJCJUpcVLgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529726; c=relaxed/simple;
	bh=9bnWd8U5uJVzMhF0VNM4Fq8zW1CPc18xcTGjzBTs9K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKMyIHIv92uwEwurhdRxUdcj18mdMv5uFQPYl1sb62Ro5LopPa/4DeEvpm7X0RbJzKQ7wrt17k4T7im+rH3oyy/VJ0LCXEIRBGCkjxhROY7yYlpw1PyoPeTYH8jHhQBBP0PLvuGnYnsGkWHVhhfE/RULBpMVZhUk2/1uJmuObhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvKPJ6yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAF7C4CEF0;
	Mon, 22 Sep 2025 08:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529726;
	bh=9bnWd8U5uJVzMhF0VNM4Fq8zW1CPc18xcTGjzBTs9K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvKPJ6yo3XE1zMlVxa0zyYCqCRg+QyaZH0AgS89N4mvhinGfez7MvNY3GdyBIvqFz
	 j7557PGEljG/RT7LHlH7yw3XJZPLJPr4g07iA2W+R0UqUCdoUy25GutLkf5nKbgUww
	 HTq/AeacIAttwMjQgJN1q5RFHQhkl/RPKDznfmC4sKTQp+cpIzj51iWcPgB4IOVLE7
	 QdsObwNmNbNaK/zIn4DKYLieKNmctRb0YUP3A8gg0Q16cPzQwMVl76CBMFkDV+xipn
	 jdZCh6FLxc21zw338WxdkfD5x5zNO4d6eCoJuzXhoA9OzrlEeEZ5OFkhtEVHOSRT/4
	 3D1c3epO0VbtQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0bue-00000008Kds-3Zg8;
	Mon, 22 Sep 2025 08:28:44 +0000
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
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v3 11/26] genirq: Kill handle_percpu_devid_fasteoi_nmi()
Date: Mon, 22 Sep 2025 09:28:18 +0100
Message-ID: <20250922082833.2038905-12-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922082833.2038905-1-maz@kernel.org>
References: <20250922082833.2038905-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org, jonathan.cameron@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

There is no in-tree user of this flow handler anymore, so simply
remove it.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h |  1 -
 kernel/irq/chip.c   | 25 -------------------------
 2 files changed, 26 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1d6b606a81efe..1381f9d1f5c9d 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -655,7 +655,6 @@ extern void handle_bad_irq(struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
 
 extern void handle_fasteoi_nmi(struct irq_desc *desc);
-extern void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc);
 
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
 extern int irq_chip_pm_get(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 0d0276378c707..d1c9e357f64d2 100644
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


