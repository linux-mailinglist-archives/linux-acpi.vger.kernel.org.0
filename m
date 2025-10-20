Return-Path: <linux-acpi+bounces-17975-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DE3BF12E4
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25DDB4F4979
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852C526657D;
	Mon, 20 Oct 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsAgRyzt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0429E109;
	Mon, 20 Oct 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963410; cv=none; b=q4AfvAxyRvb0ERoZsEJqCcKq1ZNvYc5tkcQ6kLqGjuAGxkqvsL2VudQ6miLUGgccANl5L50TJEZUXSqfMyyb6SCjkXXpbg1e8/1W5+wtfMfB7rFGCYGmUnzCXsKBOWVUs0qSuTcXGfvsMPTc9OpxdRad6Za5e/jiyL4MbPLlEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963410; c=relaxed/simple;
	bh=HST/sUWtIZNiNIOKHh+hRvomjQF/XTcjUD7JT/PX8wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hj4+Uckw9l3h8uqHi1+o0oJh04UX22Nv4or1GAhPjRL4psHxFD3Sb13DL/U5pjAeC8Gc/PIymc9Ecq/B02JRi5OKz8xQtULpXt2Y+hl8A8RV4DMZ9ChROtSjS7Bq5b4ZH7UidVkO+FPhxfTPtDHfQ3QqLSpSfstC79mvGywgtSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsAgRyzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33D7C4CEF9;
	Mon, 20 Oct 2025 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963409;
	bh=HST/sUWtIZNiNIOKHh+hRvomjQF/XTcjUD7JT/PX8wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsAgRyztlAAjxGp8pjp1m/4q6fcsOTlph00ZZwRTKCTuHoWP0o/hp4xOtlpuOVZxp
	 A8SYrv7Z0eT56XqSXoUO/X29JE4/Z0kaC5eDM3BBTr18H3HIbKqzRoojf5wm/G8BJD
	 3dmQfUjogscs49GW0dwLTh0slYoFkC/f8cNg1yiS3GTPzrofDtqnL03hdQOc8Jb3pI
	 c0vkpnLcXK5AIF7mIHfsKw3QfE/hCmxLmdPlMtdHvO556SuAhdJ4Kr7VkG8zzwWsrK
	 1+2fBj5+3URB1gnFwqYAG5fVYKbdk/08aPzJaaOand08zJZcsI/hdqu97f1M+9LaOf
	 a1GffeGRH0O1Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1b-0000000FUu2-30EN;
	Mon, 20 Oct 2025 12:30:07 +0000
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
Subject: [PATCH v4 02/26] ACPI: irq: Add IRQ affinity reporting interface
Date: Mon, 20 Oct 2025 13:29:19 +0100
Message-ID: <20251020122944.3074811-3-maz@kernel.org>
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

Plug the irq_populate_fwspec_info() helper into the ACPI layer
to offer an IRQ affinity reporting function. This is currently
only supported for the CONFIG_ACPI_GENERIC_GSI configurations,
but could later be extended to legacy architectures if necessary.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/irq.c   | 19 +++++++++++++++++++
 include/linux/acpi.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 76a856c32c4d0..d1595156c86a4 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -300,6 +300,25 @@ int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
 }
 EXPORT_SYMBOL_GPL(acpi_irq_get);
 
+const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
+					    unsigned int index)
+{
+	struct irq_fwspec_info info;
+	struct irq_fwspec fwspec;
+	unsigned long flags;
+
+	if (acpi_irq_parse_one(handle, index, &fwspec, &flags))
+		return NULL;
+
+	if (irq_populate_fwspec_info(&fwspec, &info))
+		return NULL;
+
+	if (!(info.flags & IRQ_FWSPEC_INFO_AFFINITY_VALID))
+		return NULL;
+
+	return info.affinity;
+}
+
 /**
  * acpi_set_irq_model - Setup the GSI irqdomain information
  * @model: the value assigned to acpi_irq_model
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5ff5d99f6ead5..607db773b6721 100644
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
2.47.3


