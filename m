Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED9CE363
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2019 15:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfD2NMU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Apr 2019 09:12:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37546 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfD2NMT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Apr 2019 09:12:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id r6so15992207wrm.4
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2019 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aF6l04CaNOxatTezE3P0EG9tcSof6ocX8T/Hj4rb3rU=;
        b=y0PxrwNPQ79uhV6F0ybWo2y4mgV33xEuUKcozXD+KpG6GxZrXk1fuDWAPysrJQZHyI
         CD8sIHT+o/3j5xs34dVnc22/2G3BezaxpH644dAfpu8PSvn+f8mRbk8EZG5BJx/a/NCS
         gOzxfhBaH3/PD35lPKdTkOvKtvYYw3z6wzIu6QPI75/aeXJZ9Q0FJqs/C6gHjhwoUzHB
         AcvmR0t4UzCwwbJueeInjlaTCj9Xn0QPipqK9Pbd9A4EZ3gXNHIW5Y/Ahh/ibqpGw88w
         67TDidPn6WnHOnBDH09QWbfmhKYTyGj13+c3zwLEnFiuEp6GuE2kF3VaeSO7Wgo26XyA
         LOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aF6l04CaNOxatTezE3P0EG9tcSof6ocX8T/Hj4rb3rU=;
        b=f4QwXFiniiEPRhSBZfAtK1o9S45IbnZBaG+jf02uvXk4Om23d/T0IyKRUE/BgJzpBs
         hed7U0lvX8Z49+jotMCF68fiMtSHiBX1etnwEenY/8v+aTlbUeHVxhT5BE3899CUHsrG
         cmwWQ9A2ysGxFmOP6Z3WT1SKVSkJCVQn1bURRzT4+JC2fEH/f9lNEruoUhtvfUmkZbUL
         sFgiG1mSepvCQYlxlIDFOXNQdoRkk7kkL7EfHPHU2xXroZ16ORv7FDIYvdi/ketHMkV6
         47/NYQNbbO0KB2y4ygDwk65h+2QQyLA02f6mpXbou3ctg4FsReYyKOvwyoL17LWMWqZJ
         gbmw==
X-Gm-Message-State: APjAAAWQcQFLa8+7qFdpPBCTiHCt4rVH/6R99oxpZjJvvzj368Tll0tX
        u0HozgaZ32MEdzp6VwhAq9094w==
X-Google-Smtp-Source: APXvYqwm4uRJsb3P36w5LULvD/Wn35rUh1BGa5lbrfB3weTyaSZxvO0cs+MLwkR6J4CcGNGyALNITA==
X-Received: by 2002:a5d:674f:: with SMTP id l15mr16932208wrw.41.1556543537573;
        Mon, 29 Apr 2019 06:12:17 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f9fc:88:6502:8fa7])
        by smtp.gmail.com with ESMTPSA id s16sm5410282wrg.71.2019.04.29.06.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 06:12:16 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-gpio@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 3/4] irqchip/exiu: implement ACPI support
Date:   Mon, 29 Apr 2019 15:12:07 +0200
Message-Id: <20190429131208.3620-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
References: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Expose the existing EXIU hierarchical irqchip domain code to permit
the interrupt controller to be used as the irqchip component of a
GPIO controller on ACPI systems, or as the target of ordinary
interrupt resources.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/irqchip/irq-sni-exiu.c | 72 +++++++++++++++++---
 1 file changed, 64 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index 52ce662334d4..68394f804af1 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -134,9 +135,13 @@ static int exiu_domain_translate(struct irq_domain *domain,
 
 		*hwirq = fwspec->param[1] - info->spi_base;
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
-		return 0;
+	} else {
+		if (fwspec->param_count != 2)
+			return -EINVAL;
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
 	}
-	return -EINVAL;
+	return 0;
 }
 
 static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
@@ -147,16 +152,21 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
 	struct exiu_irq_data *info = dom->host_data;
 	irq_hw_number_t hwirq;
 
-	if (fwspec->param_count != 3)
-		return -EINVAL;	/* Not GIC compliant */
-	if (fwspec->param[0] != GIC_SPI)
-		return -EINVAL;	/* No PPI should point to this domain */
+	parent_fwspec = *fwspec;
+	if (is_of_node(dom->parent->fwnode)) {
+		if (fwspec->param_count != 3)
+			return -EINVAL;	/* Not GIC compliant */
+		if (fwspec->param[0] != GIC_SPI)
+			return -EINVAL;	/* No PPI should point to this domain */
 
+		hwirq = fwspec->param[1] - info->spi_base;
+	} else {
+		hwirq = fwspec->param[0];
+		parent_fwspec.param[0] = hwirq + info->spi_base + 32;
+	}
 	WARN_ON(nr_irqs != 1);
-	hwirq = fwspec->param[1] - info->spi_base;
 	irq_domain_set_hwirq_and_chip(dom, virq, hwirq, &exiu_irq_chip, info);
 
-	parent_fwspec = *fwspec;
 	parent_fwspec.fwnode = dom->parent->fwnode;
 	return irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
 }
@@ -244,3 +254,49 @@ static int __init exiu_dt_init(struct device_node *node,
 	return 0;
 }
 IRQCHIP_DECLARE(exiu, "socionext,synquacer-exiu", exiu_dt_init);
+
+#ifdef CONFIG_ACPI
+static int exiu_acpi_probe(struct platform_device *pdev)
+{
+	struct irq_domain *parent_domain, *domain;
+	struct resource *res;
+
+	parent_domain = acpi_get_gsi_irqdomain();
+	if (!parent_domain) {
+		dev_err(&pdev->dev, "unable to obtain parent domain\n");
+		return -ENODEV;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to parse memory resource\n");
+		return -ENXIO;
+	}
+
+	domain = exiu_init(parent_domain, dev_fwnode(&pdev->dev), res);
+	if (IS_ERR(domain)) {
+		dev_err(&pdev->dev, "failed to create IRQ domain (%ld)\n",
+			PTR_ERR(domain));
+		return PTR_ERR(domain);
+	}
+
+	dev_info(&pdev->dev, "%d interrupts forwarded\n", NUM_IRQS);
+
+	return 0;
+}
+
+static const struct acpi_device_id exiu_acpi_ids[] = {
+	{ "SCX0008" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, exiu_acpi_ids);
+
+static struct platform_driver exiu_driver = {
+	.driver = {
+		.name = "exiu",
+		.acpi_match_table = exiu_acpi_ids,
+	},
+	.probe = exiu_acpi_probe,
+};
+builtin_platform_driver(exiu_driver);
+#endif
-- 
2.20.1

