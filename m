Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166CEE360
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2019 15:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfD2NMS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Apr 2019 09:12:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42211 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfD2NMS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Apr 2019 09:12:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so312378wrb.9
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2019 06:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LflG0JOcbN8VcRqNOvuJxlldgCtsVbbH4h32KwiCqss=;
        b=ElwC/dqyvPGkd7e4295vczNFShOirzGuBqdcY0+km+H5WkenpoB7C4k4h9TYj6Ak1D
         RWL/xEmSkeCmKYBXiSL0WLzeOy4M7otJdu9ogPADkHyARgiuArqGpY5gkcYUAPOALtLF
         j6VaYECxgPkQmOv1TnNU4v9DH0UaSQ3ARXKhBWY5RPyBzw8spXWuksnol/xZWpe/sMn+
         +O5AeEc3sWJS/Syv+gDpLOBOrNFCRXRp9tHhKaAQE1SXfsZ5otjL985N0wwA3wxLpe3I
         wjlgFMNyQ7r7VcwTUecaBbDbq3NNFRivwhM/pUAfPSvl0tf+tpkQRCq/I+2ERcqGUPnt
         o71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LflG0JOcbN8VcRqNOvuJxlldgCtsVbbH4h32KwiCqss=;
        b=lfTnxVz6+mEiGNBbzD4wQJGd0B9xwbyTrYZAzcx0oDtliYq5lQku8Wk/3xbDStKAkS
         oQPVl2Uy6dfPDFMPe5HywGf2b6vTBdPCi90uLFXsyINZppaJxbOyKb6hGP7ge88CcXu7
         SsGAZ4Lumb//UMScrsP0F90UjB3/faKxauwDcpI40vj0NWK++x+K6R3oPUz3fNHI1i+p
         MNfkSBz1ShZG4BumbyrL3sNVk4E48rmCd6rSKevT5AjdL6k83et52FV3BNjZn+2Sx56V
         mqsht5zcMlx/5F0aAFDGokg882XqRkx5cLLYoPZolMT6r/sMxiZnivXZ00HI9uaSJoLc
         tiPg==
X-Gm-Message-State: APjAAAWy8rAPxDHjtP3a1RSiEklQH1pRClYw6o2CcTMcNf6Cx/9UJDKO
        QcT6VzomadLxXMutKFCHWdUvrQ==
X-Google-Smtp-Source: APXvYqxZRciGKidEMatOjeaVtXcFEliHDCDCxz2u62O6w/9skVAzOgp9b9xr6SoZkrJE31gTiz9QpA==
X-Received: by 2002:a05:6000:12c1:: with SMTP id l1mr4895866wrx.152.1556543536105;
        Mon, 29 Apr 2019 06:12:16 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f9fc:88:6502:8fa7])
        by smtp.gmail.com with ESMTPSA id s16sm5410282wrg.71.2019.04.29.06.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 06:12:15 -0700 (PDT)
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
Subject: [PATCH v2 2/4] irqchip/exiu: preparatory refactor for ACPI support
Date:   Mon, 29 Apr 2019 15:12:06 +0200
Message-Id: <20190429131208.3620-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
References: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation of adding support for EXIU controller devices described
via ACPI, split the DT init function in a DT specific and a generic part,
where the latter will be reused for ACPI support later.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/irqchip/irq-sni-exiu.c | 77 ++++++++++++--------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index 1927b2f36ff6..52ce662334d4 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -1,7 +1,7 @@
 /*
  * Driver for Socionext External Interrupt Unit (EXIU)
  *
- * Copyright (c) 2017 Linaro, Ltd. <ard.biesheuvel@linaro.org>
+ * Copyright (c) 2017-2019 Linaro, Ltd. <ard.biesheuvel@linaro.org>
  *
  * Based on irq-tegra.c:
  *   Copyright (C) 2011 Google, Inc.
@@ -167,35 +167,25 @@ static const struct irq_domain_ops exiu_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
-static int __init exiu_init(struct device_node *node,
-			    struct device_node *parent)
+static struct irq_domain *exiu_init(struct irq_domain *parent_domain,
+				    struct fwnode_handle *fwnode,
+				    struct resource *res)
 {
-	struct irq_domain *parent_domain, *domain;
+	struct irq_domain *domain;
 	struct exiu_irq_data *data;
 	int err;
 
-	if (!parent) {
-		pr_err("%pOF: no parent, giving up\n", node);
-		return -ENODEV;
-	}
-
-	parent_domain = irq_find_host(parent);
-	if (!parent_domain) {
-		pr_err("%pOF: unable to obtain parent domain\n", node);
-		return -ENXIO;
-	}
-
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	if (of_property_read_u32(node, "socionext,spi-base", &data->spi_base)) {
-		pr_err("%pOF: failed to parse 'spi-base' property\n", node);
+	if (fwnode_property_read_u32_array(fwnode, "socionext,spi-base",
+					   &data->spi_base, 1)) {
 		err = -ENODEV;
 		goto out_free;
 	}
 
-	data->base = of_iomap(node, 0);
+	data->base = ioremap(res->start, resource_size(res));
 	if (!data->base) {
 		err = -ENODEV;
 		goto out_free;
@@ -205,23 +195,52 @@ static int __init exiu_init(struct device_node *node,
 	writel_relaxed(0xFFFFFFFF, data->base + EIREQCLR);
 	writel_relaxed(0xFFFFFFFF, data->base + EIMASK);
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, NUM_IRQS, node,
-					  &exiu_domain_ops, data);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, NUM_IRQS,
+					     fwnode, &exiu_domain_ops, data);
 	if (!domain) {
-		pr_err("%pOF: failed to allocate domain\n", node);
 		err = -ENOMEM;
 		goto out_unmap;
 	}
+	return domain;
+out_unmap:
+	iounmap(data->base);
+out_free:
+	kfree(data);
+	return ERR_PTR(err);
+}
+
+static int __init exiu_dt_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *domain;
+	struct resource res;
+
+	if (!parent) {
+		pr_err("%pOF: no parent, giving up\n", node);
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%pOF: unable to obtain parent domain\n", node);
+		return -ENXIO;
+	}
+
+	if (of_address_to_resource(node, 0, &res)) {
+		pr_err("%pOF: failed to parse memory resource\n", node);
+		return -ENXIO;
+	}
+
+	domain = exiu_init(parent_domain, of_node_to_fwnode(node), &res);
+	if (IS_ERR(domain)) {
+		pr_err("%pOF: failed to create IRQ domain (%ld)\n", node,
+		       PTR_ERR(domain));
+		return PTR_ERR(domain);
+	}
 
 	pr_info("%pOF: %d interrupts forwarded to %pOF\n", node, NUM_IRQS,
 		parent);
 
 	return 0;
-
-out_unmap:
-	iounmap(data->base);
-out_free:
-	kfree(data);
-	return err;
 }
-IRQCHIP_DECLARE(exiu, "socionext,synquacer-exiu", exiu_init);
+IRQCHIP_DECLARE(exiu, "socionext,synquacer-exiu", exiu_dt_init);
-- 
2.20.1

