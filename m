Return-Path: <linux-acpi+bounces-16477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E928CB49558
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 18:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66FF3B28C3
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0858330F955;
	Mon,  8 Sep 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHTWYSuP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AC130F946;
	Mon,  8 Sep 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349108; cv=none; b=mq/1rjhfN9PNwaF6YjelEK0oBR1rVgNpR+W+lt9JNn+n/NVDe8SFBOfauK3Dep5N56Gy3nkVIQhH5AfBSu/7u2QFgnJ3+a3SvLRvybFjHlP6NdVd7d5ZApR/DIAnUs7Chg5nMEWo3M6sqRDDvzYLGbft6O3s473EI2BpwaSXcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349108; c=relaxed/simple;
	bh=G+swjEVbqFRe3VO4Brd816oEyLNB4BZ+ieu+z8ZYXlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOAaI60RW0WB18kSXDmw/26rhlckHoLDOxhLt3wUr16eJ3J+EYZclBDHyiHL1nBmoFhbC3juTvcANIkFzDLHYNvQdIjwKu20U9eCI+6uoeUl1QnO4bZu++HOWkUwYlg4xWsGtW8rAahdahpsDC02rXPuy7QKm9MSwRWrwfBCBjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHTWYSuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B01C4CEF7;
	Mon,  8 Sep 2025 16:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349108;
	bh=G+swjEVbqFRe3VO4Brd816oEyLNB4BZ+ieu+z8ZYXlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHTWYSuP0bU3853OaXCg5l9DIuMvx66uOm4gpVe7T/uBz9nPeoGr0Vs4zn/L0wXgj
	 baiclTzTjvT2VJaV/Bu121IMYPe2UvqJVk5KfUES34qx6ug8fv/3jDa/F6EqIltXlv
	 F65V7TasHeaz4YdUDc4/rCsymfbwYSIsqdIKV4r7iL8JTGZnBDpcWVT9N711wKa1uR
	 px2b0BnjbDxPiUrXExgycyFU5sjVNBpeYQGpFKcKVEDMkjdc2vAyfZ6IEb7Tsswt3i
	 aBSyDl709uN/Cpz1+xnuHtUAjCDKPrgEMAHaCVv/1aYiRmLwuUul+jsY5FXB5PnHw2
	 6Vr/9lIDN+wqQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uvemQ-00000004NTm-2RZZ;
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
Subject: [PATCH 04/25] platform: Add firmware-agnostic irq and affinity retrieval interface
Date: Mon,  8 Sep 2025 17:31:06 +0100
Message-Id: <20250908163127.2462948-5-maz@kernel.org>
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
index 09450349cf323..fad33d6b2349a 100644
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
+ * platform_get_irq_affinity - get an optional IRQ and its affnity for a device
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
2.39.2


