Return-Path: <linux-acpi+bounces-17176-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCF2B8F815
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A893A6D27
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8F82FE07D;
	Mon, 22 Sep 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY8MLpCB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E12FE049;
	Mon, 22 Sep 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529725; cv=none; b=jm27EeHQb+R8aSVklXERCjfanJ96VjQkz08ST6HKjqLA/DPFF2Bi2c8yif6Scbwr/VjcceAj0L7z1O0trk/TokK/doc6I2FiXvyvsvw41tlEIpA7zcWJYy4oZPJwX9IpS7cPLPECVrajBhjJMqfADb1aPOKdOAnChMl3sltKQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529725; c=relaxed/simple;
	bh=C6E+aBEwGO9hdt1adgFxxn43Y+KPhVq4P5UdcbaK3jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXHRHaipJ2BXbqXIBbGGYIk2upEOy4j3enmkvmnsMPEgrL95xQJnsbluwkD9Nm2MuSvXfm3e0imjLJEUyarPooNGtKqpTLvtOxsdIpY6RODoRbKMo3V7FBIATyXSERen0RnKSJpIxZXI2ZHb6fmHoc0wtyM2ZNfRIhEO7sUTuxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY8MLpCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC71AC4CEF0;
	Mon, 22 Sep 2025 08:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529724;
	bh=C6E+aBEwGO9hdt1adgFxxn43Y+KPhVq4P5UdcbaK3jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LY8MLpCBLX0GLYkb9PnQBGX3JXCY3s6Ve4syk+SVOeb1idI0OqyzBtTx+tmtoeZUA
	 yStqoW/MQ9WwO01xrNasugarr6r8BQJ0kaPyQmYw+PWBz6gHqw0MoeVB3z/BtoSaRc
	 YAv4isq8YH1glfqHYKzrh2FIhHkatvtmKHsWr3YOqpOQSNPcy6tVeMpNmPoqYZ6fI2
	 +BdKU6efM4GJLUKJtbmKVrrEdOANoS7b/ARS02vm62Vy/qgSrzTgppF5VTUp+AILUF
	 jFxlQ5Mt2eXjrc3G4Yp7M+r/DceiP0h1hyEa/yyQY0SvcJ6Jts/VNiQKhQ9+00iLYs
	 j8vaL8+6vP1AQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0buc-00000008Kds-3L2U;
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
Subject: [PATCH v3 04/26] platform: Add firmware-agnostic irq and affinity retrieval interface
Date: Mon, 22 Sep 2025 09:28:11 +0100
Message-ID: <20250922082833.2038905-5-maz@kernel.org>
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

Expand platform_get_irq_optional() to also return an affinity if
available, renaming it to platform_get_irq_affinity() in the
process.

platform_get_irq_optional() is preserved with its current semantics
by calling into the new helper with a NULL affinity pointer.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/base/platform.c         | 60 +++++++++++++++++++++++++++------
 include/linux/platform_device.h |  2 ++
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 09450349cf323..3a058f63ef0d3 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -150,25 +150,37 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
 #endif /* CONFIG_HAS_IOMEM */
 
+static const struct cpumask *get_irq_affinity(struct platform_device *dev,
+					      unsigned int num)
+{
+	const struct cpumask *mask = NULL;
+#ifndef CONFIG_SPARC
+	struct fwnode_handle *fwnode = dev_fwnode(&dev->dev);
+
+	if (is_of_node(fwnode))
+		mask = of_irq_get_affinity(to_of_node(fwnode), num);
+	else if (is_acpi_device_node(fwnode))
+		mask = acpi_irq_get_affinity(ACPI_HANDLE_FWNODE(fwnode), num);
+#endif
+
+	return mask ?: cpu_possible_mask;
+}
+
 /**
- * platform_get_irq_optional - get an optional IRQ for a device
+ * platform_get_irq_affinity - get an optional IRQ and its affinity for a device
  * @dev: platform device
  * @num: IRQ number index
+ * @affinity: optional cpumask pointer to get the affinity of a per-cpu IRQ
  *
  * Gets an IRQ for a platform device. Device drivers should check the return
  * value for errors so as to not pass a negative integer value to the
- * request_irq() APIs. This is the same as platform_get_irq(), except that it
- * does not print an error message if an IRQ can not be obtained.
- *
- * For example::
- *
- *		int irq = platform_get_irq_optional(pdev, 0);
- *		if (irq < 0)
- *			return irq;
+ * request_irq() APIs. Optional affinity information is provided in the
+ * affinity pointer if available, and NULL otherwise.
  *
  * Return: non-zero IRQ number on success, negative error number on failure.
  */
-int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
+int platform_get_irq_affinity(struct platform_device *dev, unsigned int num,
+			      const struct cpumask **affinity)
 {
 	int ret;
 #ifdef CONFIG_SPARC
@@ -236,8 +248,36 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 out:
 	if (WARN(!ret, "0 is an invalid IRQ number\n"))
 		return -EINVAL;
+
+	if (ret > 0 && affinity)
+		*affinity = get_irq_affinity(dev, num);
+
 	return ret;
 }
+EXPORT_SYMBOL_GPL(platform_get_irq_affinity);
+
+/**
+ * platform_get_irq_optional - get an optional IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
+ *
+ * Gets an IRQ for a platform device. Device drivers should check the return
+ * value for errors so as to not pass a negative integer value to the
+ * request_irq() APIs. This is the same as platform_get_irq(), except that it
+ * does not print an error message if an IRQ can not be obtained.
+ *
+ * For example::
+ *
+ *		int irq = platform_get_irq_optional(pdev, 0);
+ *		if (irq < 0)
+ *			return irq;
+ *
+ * Return: non-zero IRQ number on success, negative error number on failure.
+ */
+int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
+{
+	return platform_get_irq_affinity(dev, num, NULL);
+}
 EXPORT_SYMBOL_GPL(platform_get_irq_optional);
 
 /**
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 074754c23d330..ad66333ce85ce 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -102,6 +102,8 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_get_irq_optional(struct platform_device *, unsigned int);
+extern int platform_get_irq_affinity(struct platform_device *, unsigned int,
+				     const struct cpumask **);
 extern int platform_irq_count(struct platform_device *);
 extern int devm_platform_get_irqs_affinity(struct platform_device *dev,
 					   struct irq_affinity *affd,
-- 
2.47.3


