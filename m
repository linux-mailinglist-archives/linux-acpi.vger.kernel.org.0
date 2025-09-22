Return-Path: <linux-acpi+bounces-17174-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0323AB8F80C
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4633A55C2
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1F2FDC59;
	Mon, 22 Sep 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu0OU75t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046C2FDC25;
	Mon, 22 Sep 2025 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529724; cv=none; b=MoSnxr0q71b6koJUWotV1XRH/E6TLCJ5eMS5MRPwgX9oXanJgmeShw7DN7c3VhN8JxBh85LdGpCeE0mOll/KkWQ6edd8aFsAx1RRA6VsDI59FN+v3PH+9ddRB78jBr6Lj8Uy5QIa3Mqe13335EBPiJgZhPaZB0JcOb6gF57tZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529724; c=relaxed/simple;
	bh=+tEFpiH2SyGne7krnANKnL8umntjFTGvzqHPthyUCxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Itk3Y29McpbSiWYFu5uIjFgWKbwsHd2PTHHRjRpZALiH5Y8pk1ZPQ/Vlsyutfut7B+1l0JdPUmthQ3NUpNA8m/o+dQPtN+kqRka4FgPSTeSrAQ/SSecUOpMLCIOCJXT5mRNH7b3c3YTqJV8k4E4Tv7v6SFW5qQpQ66oVqexXTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tu0OU75t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891C5C4CEF5;
	Mon, 22 Sep 2025 08:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529724;
	bh=+tEFpiH2SyGne7krnANKnL8umntjFTGvzqHPthyUCxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tu0OU75tau4SKPk+JYe4VzWArSZkTHxkUvjl5cOPg9X0Mn1/Iy+Wyd+Ht7kWDUO5a
	 A5KItxZjEOHVQ0FYI+z4Z/tp7K+bqFD4DrM6OasYoo4a0lufpgjD4TaWax4p67qatd
	 7cUrZccwf4LNW5jOiAupqIaOBMD4GbYh8b8eNPM7w9tUK3VKPxmHiD1uatrt6+CPVE
	 bUipL0V0EoARbGS5hZTRAqIG4VairOQxOTPiAWYuXGZjX7Ha+Bvego+ZAxAU9FRdCJ
	 Rv9M0n7KY5Yqt6DXyB0m5Y+XLauSY9GVS8kvqoK9CaNLGdqCObsJhpGbYeZ7L12LuR
	 fZ+qSOOAs2pPQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0buc-00000008Kds-29qc;
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
Subject: [PATCH v3 03/26] of/irq: Add IRQ affinity reporting interface
Date: Mon, 22 Sep 2025 09:28:10 +0100
Message-ID: <20250922082833.2038905-4-maz@kernel.org>
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

Plug the irq_populate_fwspec_info() helper into the OF layer
to offer an IRQ affinity reporting function.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/of/irq.c       | 20 ++++++++++++++++++++
 include/linux/of_irq.h |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 74aaea61de13c..9a205cb033bda 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -479,6 +479,26 @@ int of_irq_get(struct device_node *dev, int index)
 }
 EXPORT_SYMBOL_GPL(of_irq_get);
 
+const struct cpumask *of_irq_get_affinity(struct device_node *dev, int index)
+{
+	struct of_phandle_args oirq;
+	struct irq_fwspec_info info;
+	struct irq_fwspec fwspec;
+	int rc;
+
+	rc = of_irq_parse_one(dev, index, &oirq);
+	if (rc)
+		return NULL;
+
+	of_phandle_args_to_fwspec(oirq.np, oirq.args, oirq.args_count,
+				  &fwspec);
+
+	if (!irq_populate_fwspec_info(&fwspec, &info))
+		return info.affinity;
+
+	return NULL;
+}
+
 /**
  * of_irq_get_byname - Decode a node's IRQ and return it as a Linux IRQ number
  * @dev: pointer to device tree node
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index a480063c9cb19..721cbdbc292df 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -43,6 +43,8 @@ extern int of_irq_parse_one(struct device_node *device, int index,
 			  struct of_phandle_args *out_irq);
 extern int of_irq_count(struct device_node *dev);
 extern int of_irq_get(struct device_node *dev, int index);
+extern const struct cpumask *of_irq_get_affinity(struct device_node *dev,
+						      int index);
 extern int of_irq_get_byname(struct device_node *dev, const char *name);
 extern int of_irq_to_resource_table(struct device_node *dev,
 		struct resource *res, int nr_irqs);
@@ -77,6 +79,11 @@ static inline int of_irq_get_byname(struct device_node *dev, const char *name)
 {
 	return 0;
 }
+static inline const struct cpumask *of_irq_get_affinity(struct device_node *dev,
+							int index)
+{
+	return NULL;
+}
 static inline int of_irq_to_resource_table(struct device_node *dev,
 					   struct resource *res, int nr_irqs)
 {
-- 
2.47.3


