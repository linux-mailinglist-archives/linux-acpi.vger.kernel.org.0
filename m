Return-Path: <linux-acpi+bounces-16904-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C8B573CD
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 10:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E26807A9D64
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0982F5313;
	Mon, 15 Sep 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj2pEWdZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCB32F4A0F;
	Mon, 15 Sep 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926635; cv=none; b=t/bvT1yDOASTj56uSffuQut+9TPKT92t91M/iB1UBruLawwjDOjXS1TosXvvm65FFHyPa7VKyTYPJ8GeuWEhlQlltOg767Bn1vwoOI50matnT0gJRzKL7gdU88a/7v/w4EmypFdZnv/fPmlKd/mrwLC5tOk3iHrymbGGv18DWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926635; c=relaxed/simple;
	bh=6u/gpZ6YckoKaeQpYH44xQmuVDlG8thNzuOSAyOF6/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XEVCeLLsqnLSw27dv+60N7TuHImn3/aJqPtWVzBbemfO7w0mdWblGgS3Y6MQe/W2emmS/ZnHgsljoWhP5Y00gwuLJluymhFOzy9nT4pKRs6A0VPHJKAEx5C+Iw1DFKxrALNEAzEXtKKGkZfLxB/+InwoPXvJCcyE4BBKM6tk5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj2pEWdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9A9C113D0;
	Mon, 15 Sep 2025 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926635;
	bh=6u/gpZ6YckoKaeQpYH44xQmuVDlG8thNzuOSAyOF6/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hj2pEWdZSAR5UvhIlIEYVYke8cAsRdBmoGlEn4cI7Na9ib8+5xeSIqSfBYXjP8Pjc
	 dBqdxQ2IRUWWNsity5FW9r1UTjU5nc7rlSK/aZ3O82o6VlZGNiUko7d7BOj8TQJj7G
	 Bv2G4ZiPUYdW/4H59gwYxBJpp6GvqSotJfnogXcojU0LgrzAi2CBbIZznInqYel5GT
	 9diPInSRJlX0M1kT++phoEu7isTX9dZlXu+XX6w7BtzQRDEFXa4qDjodE1oAxZNt+W
	 hdrvSU99cLwChdAhvUE8mP1q2V/RGmhZM19RikO4+6Np/MCcrbJszzo21Yglwd1H/U
	 8WQNfStISdhCg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51N-00000006IHP-412L;
	Mon, 15 Sep 2025 08:57:14 +0000
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
	James Clark <james.clark@linaro.org>
Subject: [PATCH v2 11/25] genirq: Kill handle_percpu_devid_fasteoi_nmi()
Date: Mon, 15 Sep 2025 09:56:48 +0100
Message-Id: <20250915085702.519996-12-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250915085702.519996-1-maz@kernel.org>
References: <20250915085702.519996-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

There is no in-tree user of this flow handler anymore, so simply
remove it.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h |  1 -
 kernel/irq/chip.c   | 28 ++--------------------------
 2 files changed, 2 insertions(+), 27 deletions(-)

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
index 0d0276378c707..869068ec6ac91 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -892,7 +892,8 @@ void handle_percpu_irq(struct irq_desc *desc)
  *
  * action->percpu_dev_id is a pointer to percpu variables which
  * contain the real device id for the cpu on which this handler is
- * called
+ * called. This is also used for per-CPU NMIs, so special care is
+ * required.
  */
 void handle_percpu_devid_irq(struct irq_desc *desc)
 {
@@ -929,31 +930,6 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
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
2.39.2


