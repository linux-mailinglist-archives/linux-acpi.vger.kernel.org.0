Return-Path: <linux-acpi+bounces-17173-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F37B8F807
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7A516F2EA
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57E2FD7D2;
	Mon, 22 Sep 2025 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RViPu+oh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4495246760;
	Mon, 22 Sep 2025 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529724; cv=none; b=dAslxgDHrglUzSjE/oDJNUjlJbpqi7KARskCg9/43zuHAHbfuo49Y7HvtD4u0OAWNIVb2nZ9WptIeRjzY5Fv1SgcwCRQntO1x0kEUMvN7EYwR1fOAnhaXCFw0HxAsyNpbnmN2nTsKg3oQXYC7oMUk7ZA0g24UEd6w+zmJ6JERi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529724; c=relaxed/simple;
	bh=uObPw0S3mvMocs9YeKVqpsEPMH1H13oQXDA2ZL7fzjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/o9hmUF36ZELAnVpgEt+tI6JFOAQo6QomJpYkRFX3ySiA65H4HfKdgwbfKcBenaMnB2A8wTb8fnQB+dJFA/b2mBumwcjzP/wE4OLLKouYILkbagvVQNzD3+VOSX0FucbB4rZUjyXnDBDRk5YxXixwfLnBMvFOvOnXfqOFXtXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RViPu+oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE0BC116B1;
	Mon, 22 Sep 2025 08:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529724;
	bh=uObPw0S3mvMocs9YeKVqpsEPMH1H13oQXDA2ZL7fzjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RViPu+oh+Pi7lWBLz2vkZCF9YKlTi7HdzTxcjfDwADvDAYsqf864Amflf/vQRN2hZ
	 I1WuSgTKgtCBMtYiOuk1caJKYvaJ/lxKpqqUmc9JwbKhGMdERAIyXt+E/js07yMwuy
	 dQtAjUw+4FpY9XBkBIvS2eiIJSTqRzQAb24MmAwXfLOiNCIaqM3bCd0nui+5nCDVt+
	 BJmc8IOZWugNsQEDyuBdmU2oHIQ4tvsyWu3aXkr39Cpt83SsaRHQhK9pjtUHFvGVHv
	 i+WLw26pWozDuTexOcSOpr4CEXsaYkXTidoqIfyKaLnfNTeqdBX43xsOK7bbktA1DG
	 xoarUu6R2FK5w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0buc-00000008Kds-0yLT;
	Mon, 22 Sep 2025 08:28:42 +0000
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
Subject: [PATCH v3 02/26] ACPI: irq: Add IRQ affinity reporting interface
Date: Mon, 22 Sep 2025 09:28:09 +0100
Message-ID: <20250922082833.2038905-3-maz@kernel.org>
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

Plug the irq_populate_fwspec_info() helper into the ACPI layer
to offer an IRQ affinity reporting function. This is currently
only supported for the CONFIG_ACPI_GENERIC_GSI configurations,
but could later be extended to legacy architectures if necessary.

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
2.47.3


