Return-Path: <linux-acpi+bounces-16897-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D05B573C0
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D15F3BA618
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8E2F39A7;
	Mon, 15 Sep 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8MyW1t/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520432F3638;
	Mon, 15 Sep 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926634; cv=none; b=OoTZXd2/UjBObAkJXNX7uidnceMS7xtbsHoyHaTOt+m7E2UokqF7/KFnKWQy1tWK8ouDmdeexVukfWJVkrzrbYb+QugLqhi66HuWw/6TlWvIg33JY3jpLq9Kb9KN8LheYl6G7qK+2bdwly5WsRP14P+MDG7Ut/8MeI/6sds0ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926634; c=relaxed/simple;
	bh=Tg++jEb0qzQoJaPtBtzDLbCLFkMuRzXyuZynLSvq9z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMeZfgqXRyX/9L70UEh0HzIUgyQ+W1J/T2aZne5Gb7s5R6Y/bQ6yeEruS2nPr7TD3i/cacgd1LwEZbIh9VAf1K0QMCvbyeoyRB+xS279amT3i7kn9Qsb0WRstGPuQSFTuafkDHvN28DRO93TzfL4cHftQcgCVcYy97b2utNt1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8MyW1t/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0717C4CEFF;
	Mon, 15 Sep 2025 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926634;
	bh=Tg++jEb0qzQoJaPtBtzDLbCLFkMuRzXyuZynLSvq9z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8MyW1t/KY+ePpGZ7kfxfZRZBXGE5f4b73es1XFslk69eaQaAMgtMaeZGI3L8/NsK
	 KAGz3FyHUAZOTmeog5TG72kUiRUp5CsuVPy7AuLErJFu2MKSVeh+F3Li51dPbqb7LZ
	 bPXRm2bBsjYxqlVm2zUvWTj9uTLXg3D2yNm7pAb6NcUBG2B7EQUDyZ65/xtg+aFaDR
	 k6qgSiUX1HOt8GldVlOEr9GuOZ8s8cI9InmQLHrgAQ1wK4ZTW4P1ckeHFrBsmMvlQU
	 jq58QzrVRPj/0SUZHzQl7mwB8VUSiKBV3xVbgKdfUkfyfTaaL1XqRqHEzdN031SJZK
	 n7YoGq73YbgPg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51L-00000006IHP-3rFH;
	Mon, 15 Sep 2025 08:57:11 +0000
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
Subject: [PATCH v2 03/25] of/irq: Add IRQ affinity reporting interface
Date: Mon, 15 Sep 2025 09:56:40 +0100
Message-Id: <20250915085702.519996-4-maz@kernel.org>
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
2.39.2


