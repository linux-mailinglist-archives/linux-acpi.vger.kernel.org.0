Return-Path: <linux-acpi+bounces-17978-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90CFBF13A4
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E123E3B17
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0675F316183;
	Mon, 20 Oct 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfMKwEFd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C3314D02;
	Mon, 20 Oct 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963410; cv=none; b=sgTWPXCbXQ3W7EH1x8O/CqjE7/yayi9K9XEWtPfzOigf+eNcB1lkbFGW9N/9zAVZLvIk5h+o//LDiwxcByyTXlNUHhsbQ5gq7wJhiu5xHzw+i9JtbPzIh4fAIWHOD1Vh2nlzi7Ly4FvwJMzdjtB2U4m32Arxm+txifx9QnDcR4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963410; c=relaxed/simple;
	bh=R/sYXDiHQLNGDpochXu8sf1+KEArDrCXfMKkHZAo3NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGFa7NHPvsPxZlSq0SrarkdbqsZ1RXlgZiAp9wFxH6MpzWVnxMbOVqUOLrNLwoaqju7NuNka32I1btENewrWaKmII9pvs2yLsteqkstaB6rsVjm0CY0S+P5kmp8dhaRGaiuW0/IWhn7T1Z/ZVw1bWlWBHS0ClHWTB0Iz5LBgYwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfMKwEFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17544C113D0;
	Mon, 20 Oct 2025 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963410;
	bh=R/sYXDiHQLNGDpochXu8sf1+KEArDrCXfMKkHZAo3NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfMKwEFd/pfmiDkfDo5n9KeuYiEYhCsQ/aJ940GDegGX7uEJqlmxlVGTOQ7Ww1Hqp
	 uD+1CA16aZVjZZbfPhhHKG6YAYw7ryRtUB8YZmKSv035Q5QWwc+bbib4YCEKbwbexl
	 QCY0FXiIINiCSXCjh5lncOkNRO9lZugh62bzLSCpJp5bG5ryhJp2PXziBYMlOFnsxJ
	 X643ke48aqiF3AdlP6idPApPsYA3pucbueYtitQUKzMlZJWbQ03JVeqnVw/IeGjGCk
	 uF/Kot6LJ+RRDg53JSAeRaYl5sKjzng2/ORpHeL9jpaNZKY809oJuFnhtFu/76kJAz
	 4/Jr6/RSsIbQA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1c-0000000FUu2-076A;
	Mon, 20 Oct 2025 12:30:08 +0000
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
Subject: [PATCH v4 03/26] of/irq: Add IRQ affinity reporting interface
Date: Mon, 20 Oct 2025 13:29:20 +0100
Message-ID: <20251020122944.3074811-4-maz@kernel.org>
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

Plug the irq_populate_fwspec_info() helper into the OF layer
to offer an IRQ affinity reporting function.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/of/irq.c       | 20 ++++++++++++++++++++
 include/linux/of_irq.h |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 65c3c23255b74..168fde921bd27 100644
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
+	if (irq_populate_fwspec_info(&fwspec, &info))
+		return NULL;
+
+	return info.affinity;
+}
+
 /**
  * of_irq_get_byname - Decode a node's IRQ and return it as a Linux IRQ number
  * @dev: pointer to device tree node
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 1db8543dfc8a6..1c2bc02818071 100644
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
@@ -76,6 +78,11 @@ static inline int of_irq_get_byname(struct device_node *dev, const char *name)
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


