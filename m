Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0687F2B334
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2019 13:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfE0L1a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 May 2019 07:27:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35293 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfE0L1a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 May 2019 07:27:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so16592444wrv.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 May 2019 04:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKi5I0CJ2X5BwXo9XUNw8Vf2df15TmcuH8E+kJajjPM=;
        b=sim4f/+0M6hyPlAu9JEJF6ab6YBU9dpZnMdeKmnIMIkLoCJzRZqS+78KibKroDfuto
         ebgvxg/PCgDh69ige4loWXKOwSc4TIdOZ+0rnNqGW3yCwrr5TirBVl/NgllyRrTD1Zp+
         uq9dIjXKWfXQNWtEgrfb3Ac8vNOCgwRvrrIsMwGpQRXInQZm7lOQjJe8TvELVv7cYcGe
         eMdadgQ2HizkBWsIYuyqEbKxjaku7BBqZLqU9J71DXn1TU5NbNJ6fqggyLfXuwBB5qT0
         NQG0nhZEhUK+oQplf7r2ufho7xHk3Rkk4uBW2Xhp+YUaIuN2RJBWc7+zGmxFn5zfBdlj
         0sBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKi5I0CJ2X5BwXo9XUNw8Vf2df15TmcuH8E+kJajjPM=;
        b=apU0owNjU2RfxUrDywAFn/CHwsVdN/2xG6jPveUjbHtzdgCeAgrPtO0zRWTgfx2I5B
         5xgia8Ik3m/6C/J43gY+moqsRQ+JzjHHrLibMVsItZQNs6tRtkULXsfoUYFKRpCKN6y9
         jK3H5SW/xIOVyhRmBGpSpCc6N9Ib4OvhfMoo1t68qnKvDG5eAWALxOb0Jf3/C5qCmG5T
         To6bksLHneVTsivDoqmaQdb3WhyDBxoFIrxYOP+tNR7bUH7vpO7GCTPeMTFLWGXpjWmj
         37cH4OlJ02pqlOh7fkjTdKPYoSOEXE5gDL4PUEu+lEPZVGutsusa0WrJPiqIsW5TvqQd
         X1wQ==
X-Gm-Message-State: APjAAAVIrkVvad9L4myYoaGZF0OzHH0cDL0Lha9uaaA3bTU+nkKXVtFS
        cOzfE+a0RO52CBN6VXTKJAD71g==
X-Google-Smtp-Source: APXvYqw8SpCd+M4jJyq7zUwyAoqTgJjIobKM8rD3YiFtd56bz9HkfCXw5eBbjkgOO1RpXxVXLBy4pQ==
X-Received: by 2002:adf:ef8d:: with SMTP id d13mr5588247wro.60.1558956448042;
        Mon, 27 May 2019 04:27:28 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:ccdd:dadc:1517:f416])
        by smtp.gmail.com with ESMTPSA id l6sm9677747wmi.24.2019.05.27.04.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 04:27:27 -0700 (PDT)
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
Subject: [PATCH v3 2/4] irqchip/exiu: preparatory refactor for ACPI support
Date:   Mon, 27 May 2019 13:27:18 +0200
Message-Id: <20190527112720.2266-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527112720.2266-1-ard.biesheuvel@linaro.org>
References: <20190527112720.2266-1-ard.biesheuvel@linaro.org>
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
 drivers/irqchip/irq-sni-exiu.c | 66 +++++++++++++-------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index 1927b2f36ff6..fef7c2437dfb 100644
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
@@ -167,35 +167,23 @@ static const struct irq_domain_ops exiu_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
-static int __init exiu_init(struct device_node *node,
-			    struct device_node *parent)
+static struct exiu_irq_data *exiu_init(const struct fwnode_handle *fwnode,
+				       struct resource *res)
 {
-	struct irq_domain *parent_domain, *domain;
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
@@ -205,11 +193,44 @@ static int __init exiu_init(struct device_node *node,
 	writel_relaxed(0xFFFFFFFF, data->base + EIREQCLR);
 	writel_relaxed(0xFFFFFFFF, data->base + EIMASK);
 
+	return data;
+
+out_free:
+	kfree(data);
+	return ERR_PTR(err);
+}
+
+static int __init exiu_dt_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *domain;
+	struct exiu_irq_data *data;
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
+	data = exiu_init(of_node_to_fwnode(node), &res);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	domain = irq_domain_add_hierarchy(parent_domain, 0, NUM_IRQS, node,
 					  &exiu_domain_ops, data);
 	if (!domain) {
 		pr_err("%pOF: failed to allocate domain\n", node);
-		err = -ENOMEM;
 		goto out_unmap;
 	}
 
@@ -220,8 +241,7 @@ static int __init exiu_init(struct device_node *node,
 
 out_unmap:
 	iounmap(data->base);
-out_free:
 	kfree(data);
-	return err;
+	return -ENOMEM;
 }
-IRQCHIP_DECLARE(exiu, "socionext,synquacer-exiu", exiu_init);
+IRQCHIP_DECLARE(exiu, "socionext,synquacer-exiu", exiu_dt_init);
-- 
2.20.1

