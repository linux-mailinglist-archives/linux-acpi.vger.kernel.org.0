Return-Path: <linux-acpi+bounces-16474-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CFEB49554
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 18:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1E3188CE71
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965B630F939;
	Mon,  8 Sep 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+jhPL21"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7C30F928;
	Mon,  8 Sep 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349108; cv=none; b=qyI9qVkJ84UK2l4mwGH3njnljTATRlG9Pmi8AZI3uFeozMG6UoV29uAMaamWDbWaLOUHn+Hp1rAP7UemzJSfDMXRqF1pq9bTx5BmF6ugn5kD0AkA4PhTL29TTmDlckBzyEyxIFbVBgI+BKWry0uEBMpjeiyC1jN3MlHEPh0EH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349108; c=relaxed/simple;
	bh=2U6Z8RxH98hnMaQV8REDzyDMoE+2Jx+42xIbx271+3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dKoJvl7Tb2H0fAxxI/l/qIBsySdaIKT9fQ6Q52NTyxRU6zv1yU8OH/oUmV03xBJ91fKSZjEdw9417NsckYmyG811O933iPfgn7qr0xPd9GcRhLuVq1LxZfKkZ6igo258CGogHjHzxYdkPvH4d9DnDTiQ8zgJ1+KXNdy7cricvws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+jhPL21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B838C4CEF5;
	Mon,  8 Sep 2025 16:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349108;
	bh=2U6Z8RxH98hnMaQV8REDzyDMoE+2Jx+42xIbx271+3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+jhPL21Otg8MBgyvrxFvetugXwyghDpLo2xSflV+SYtLXx+bXDQP1AgTsTzdVhG3
	 bAGkUgZx64V1d0qTs8i5cXtW82Y1GsNs3JXCR2dLJhrbQPVtPdMJtsFSsxF/1mZZK7
	 MNQKQRcjtDDir026fV1AIYu+XU0Mi76FSuKrZ6xtYKa8fCUZALY18ssyyVLzIhPUNP
	 rH5jP0EWdLL0RGCzlaCNDUy67EEudP571YDJ7laPS4p4mw8bMJw89uByrzny13qzDG
	 T3I3+6RKZF/bIwEmecVWNfoBj5vA+gEW5tQGZhk6yVFjTJL3EuuwzwflAwZvNCDAb0
	 C9YcHpVaHAPKw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uvemQ-00000004NTm-0Bsz;
	Mon, 08 Sep 2025 16:31:46 +0000
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
Subject: [PATCH 02/25] ACPI: irq: Add IRQ affinity reporting interface
Date: Mon,  8 Sep 2025 17:31:04 +0100
Message-Id: <20250908163127.2462948-3-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250908163127.2462948-1-maz@kernel.org>
References: <20250908163127.2462948-1-maz@kernel.org>
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

Plug the irq_populate_fwspec_info() helper into the ACPI layer
to offer an IRQ affinity reporting function. This is currently
only supported for the CONFIG_ACPI_GENERIC_GSI configurations,
but could later be extended to legacy architectures if necessary.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/irq.c   | 15 +++++++++++++++
 include/linux/acpi.h |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 76a856c32c4d0..22f93fe23ddce 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -300,6 +300,21 @@ int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
 }
 EXPORT_SYMBOL_GPL(acpi_irq_get);
 
+const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
+					    unsigned int index)
+{
+	struct irq_fwspec_info info;
+	unsigned long flags;
+
+	if (!acpi_irq_parse_one(handle, index, &info.fwspec, &flags)) {
+		if (!irq_populate_fwspec_info(&info) &&
+		    info.flags & IRQ_FWSPEC_INFO_AFFINITY_VALID)
+			return info.affinity;
+	}
+
+	return NULL;
+}
+
 /**
  * acpi_set_irq_model - Setup the GSI irqdomain information
  * @model: the value assigned to acpi_irq_model
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1c5bb1e887cd1..c506ae4bacc86 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1509,12 +1509,19 @@ static inline int acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 
 #if IS_ENABLED(CONFIG_ACPI_GENERIC_GSI)
 int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res);
+const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
+					    unsigned int index);
 #else
 static inline
 int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
 {
 	return -EINVAL;
 }
+static inline const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
+							  unsigned int index)
+{
+	return NULL;
+}
 #endif
 
 #ifdef CONFIG_ACPI_LPIT
-- 
2.39.2


