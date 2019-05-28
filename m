Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F852C7D8
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2019 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfE1NhD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 May 2019 09:37:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46287 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfE1NhC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2019 09:37:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so20245625wrr.13
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2019 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ds56CQkAv670ntBJCxp4IuqDeQwQznKOl9murxD3/48=;
        b=xBkQ++s/BFIGDL4wQxDNtxhdWbOBqFvUU8rn7YRmvpFNqMiQ7KyWXOv+uPsPf2CR8Z
         IExLhc6FzLUKZFPgkNsi+Z+c/v871LUTEnnqLkU+UIyIT4JR/heJSuj/jMIO0LCzxfim
         3QwjR9u4xrRYqU90W3Kjk6rG4i14VKaKT0oTWMi8FP5W1VItas8JVBaq49DYC3v1nIs4
         KossB59WaMSJezPB8qllcvt1+3l4/8NwaUivh9bzbx6V3S8o7ntV1x/t68JbYl7DAKsc
         IUkA20CKvg/OpQkG0C8Hh0sWW+TONvGYtudSW8MxFZEorkaUojP7fSC8CoplIfYQTtCI
         5MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ds56CQkAv670ntBJCxp4IuqDeQwQznKOl9murxD3/48=;
        b=g1TMc5ecK4TJfBPSUpAyvt/juerun1WrCTMpFaips1d5Q5/5dOO559ZwArCIX/Bwre
         Gq7qNp7qqGFQoYFzAPZk6AQy+DGYSbXX1Ht9p8xwufpZJqZt0TcHr/5KFKYJDFwPDTbL
         NtKCWa5CeJohuijsxP2G0hZxW0jvwyJMVo3i2ErdEzeeIFnxlPMCMXXUV8udm7ho2KJ+
         L44VK8Ix2BncNMHhXvpQ97hcmYSJbv7VBZKxJy+IZ8wcFb42VbQfQwKtIdXOFBCZRuBf
         T3UNLiHbBa8Bsey9itrgE5gIgU23/6FySuVKKbfPehYUDODcwjcOaMoeNMc+Ln5pMvgu
         4QLA==
X-Gm-Message-State: APjAAAUsTdQr3odlpwJ2p6LLZXpgmkOfw1clecwcU69Gwgq3W9PCIC11
        EYQuhL2s09Vcu0FnVlNgKYZVdQ==
X-Google-Smtp-Source: APXvYqzd4VklYkD2c8O7aaDf1GHCGdPU58iygopVD5DNArmfwcmrWnemCrQp6+0DGMQpCnxY5it8WA==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr5532806wro.253.1559050620184;
        Tue, 28 May 2019 06:37:00 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:c8c7:f81b:b165:1aa7])
        by smtp.gmail.com with ESMTPSA id 95sm8652668wrk.70.2019.05.28.06.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 06:36:59 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v4 3/4] irqchip/exiu: implement ACPI support
Date:   Tue, 28 May 2019 15:36:46 +0200
Message-Id: <20190528133647.3362-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528133647.3362-1-ard.biesheuvel@linaro.org>
References: <20190528133647.3362-1-ard.biesheuvel@linaro.org>
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

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/irqchip/irq-sni-exiu.c | 76 +++++++++++++++++---
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index fef7c2437dfb..30a323a2b332 100644
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
@@ -245,3 +255,53 @@ static int __init exiu_dt_init(struct device_node *node,
 	return -ENOMEM;
 }
 IRQCHIP_DECLARE(exiu, "socionext,synquacer-exiu", exiu_dt_init);
+
+#ifdef CONFIG_ACPI
+static int exiu_acpi_probe(struct platform_device *pdev)
+{
+	struct irq_domain *domain;
+	struct exiu_irq_data *data;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to parse memory resource\n");
+		return -ENXIO;
+	}
+
+	data = exiu_init(dev_fwnode(&pdev->dev), res);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	domain = acpi_irq_create_hierarchy(0, NUM_IRQS, dev_fwnode(&pdev->dev),
+					   &exiu_domain_ops, data);
+	if (!domain) {
+		dev_err(&pdev->dev, "failed to create IRQ domain\n");
+		goto out_unmap;
+	}
+
+	dev_info(&pdev->dev, "%d interrupts forwarded\n", NUM_IRQS);
+
+	return 0;
+
+out_unmap:
+	iounmap(data->base);
+	kfree(data);
+	return -ENOMEM;
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

