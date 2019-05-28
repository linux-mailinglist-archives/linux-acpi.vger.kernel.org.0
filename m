Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9682C7D4
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2019 15:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfE1NhA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 May 2019 09:37:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42506 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfE1Ng7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2019 09:36:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so20275865wrb.9
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2019 06:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ce8JB4XUI/WvY+NITbCG46XF1cnECw0qEl06Q1Mp/6Q=;
        b=P/jGceWxx8v4ni8+lxF2N/eLIfQmpPLTRxWN2UiaK2Bp1kohbPKJIrNXBc7yP+Ph/b
         XT7wb92Kbe06wMgapYg99AEwL1lrR+r2KY5jX8JOPyIhRYlC2hD1ZXIKZylwz5WYff8J
         95YCxb0D/XNQOzuA2qIt4qUrIj+OOwhHjlnhwgxIZXJ+hBVMbv6zd2DOCooJKyWH+vtD
         3n4qdvaqtCopkxCxkMRVvJBtXaSVdKmqjKw1A/TUEIsKXm0xGrssVJ66v+bE4N1JYRy2
         TQOSN1fppopXHuPcLxN3r3xxVco9Xphd6RhQNBDHZVTySETNbp7npBDN2cJ/riXq3EBO
         OgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ce8JB4XUI/WvY+NITbCG46XF1cnECw0qEl06Q1Mp/6Q=;
        b=gDKrU43HpaC58j86mbY78An/NWIZ0JO4xBDXdZikVLQUkXgs7xAlAglOJNarOEcwRB
         /X+FfQrbh/PfcbRiSstfMI3cDGXhTsWYyjgrrIksgH1a1ymH+ICWZpiTROULk0ZpbMGf
         uCFRxVbouF9eWwHkGQBUf562JzawJ2i6UxgDUmQPqjFyi1VYxfC523lsPFrQ023fXx5P
         tqs6MXJ3ulJnOGaP4edm4SB2L4ze13LBFG99RWk3Batuk9beuY7hRKOt5JHffa7QtRFi
         flmrFutRb94P/5nrzw2xWBl+IPpcCGciCpW+8JWjV0CxC1D42x61BhTwkNIx6s/0h6vC
         ukNw==
X-Gm-Message-State: APjAAAXptfKWvrgKxc7HIXsU+Wc5+G843zm7PDL2PRsH6adOsCMcMiAe
        2oISttCjbUHRN1+knH/Ba7p09w==
X-Google-Smtp-Source: APXvYqx2CE57SmrhiCjOkLL+8sPrYUtF2G/COWgH9e10bLXzDIkX0v+1Au3LnYdN5q2CDra5lG5b2Q==
X-Received: by 2002:adf:f246:: with SMTP id b6mr4672878wrp.92.1559050617427;
        Tue, 28 May 2019 06:36:57 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:c8c7:f81b:b165:1aa7])
        by smtp.gmail.com with ESMTPSA id 95sm8652668wrk.70.2019.05.28.06.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 06:36:56 -0700 (PDT)
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
Subject: [PATCH v4 1/4] acpi/irq: implement helper to create hierachical domains
Date:   Tue, 28 May 2019 15:36:44 +0200
Message-Id: <20190528133647.3362-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528133647.3362-1-ard.biesheuvel@linaro.org>
References: <20190528133647.3362-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI permits arbitrary producer->consumer interrupt links to be
described in AML, which means a topology such as the following
is perfectly legal:

  Device (EXIU) {
    Name (_HID, "SCX0008")
    Name (_UID, Zero)
    Name (_CRS, ResourceTemplate () {
      ...
    })
  }

  Device (GPIO) {
    Name (_HID, "SCX0007")
    Name (_UID, Zero)
    Name (_CRS, ResourceTemplate () {
      Memory32Fixed (ReadWrite, SYNQUACER_GPIO_BASE, SYNQUACER_GPIO_SIZE)
      Interrupt (ResourceConsumer, Edge, ActiveHigh, ExclusiveAndWake, 0, "\\_SB.EXIU") {
        7,
      }
    })
    ...
  }

The EXIU in this example is the external interrupt unit as can be found
on Socionext SynQuacer based platforms, which converts a block of 32 SPIs
from arbitrary polarity/trigger into level-high, with a separate set
of config/mask/unmask/clear controls.

The existing DT based driver in drivers/irqchip/irq-sni-exiu.c models
this as a hierarchical domain stacked on top of the GIC's irqdomain.
Since the GIC is modeled as a DT node as well, obtaining a reference
to this irqdomain is easily done by going through the parent link.

On ACPI systems, however, the GIC is not modeled as an object in the
namespace, and so device objects cannot refer to it directly. So in
order to obtain the irqdomain reference when driving the EXIU in ACPI
mode, we need a helper that implicitly grabs the default domain as the
parent of the hierarchy for interrupts allocated out of the global GSI
pool.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/acpi/irq.c   | 26 ++++++++++++++++++++
 include/linux/acpi.h |  7 ++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index c3b2222e2129..ce6b25a3b7a7 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -295,3 +295,29 @@ void __init acpi_set_irq_model(enum acpi_irq_model_id model,
 	acpi_irq_model = model;
 	acpi_gsi_domain_id = fwnode;
 }
+
+/**
+ * acpi_irq_create_hierarchy - Create a hierarchical IRQ domain with the default
+ *                             GSI domain as its parent.
+ * @flags:      Irq domain flags associated with the domain
+ * @size:       Size of the domain.
+ * @fwnode:     Optional fwnode of the interrupt controller
+ * @ops:        Pointer to the interrupt domain callbacks
+ * @host_data:  Controller private data pointer
+ */
+struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
+					     unsigned int size,
+					     struct fwnode_handle *fwnode,
+					     const struct irq_domain_ops *ops,
+					     void *host_data)
+{
+	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
+							DOMAIN_BUS_ANY);
+
+	if (!d)
+		return NULL;
+
+	return irq_domain_create_hierarchy(d, flags, size, fwnode, ops,
+					   host_data);
+}
+EXPORT_SYMBOL_GPL(acpi_irq_create_hierarchy);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 98440df7fe42..70de4bc30cea 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -23,6 +23,7 @@
 
 #include <linux/errno.h>
 #include <linux/ioport.h>	/* for struct resource */
+#include <linux/irqdomain.h>
 #include <linux/resource_ext.h>
 #include <linux/device.h>
 #include <linux/property.h>
@@ -327,6 +328,12 @@ int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 void acpi_set_irq_model(enum acpi_irq_model_id model,
 			struct fwnode_handle *fwnode);
 
+struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
+					     unsigned int size,
+					     struct fwnode_handle *fwnode,
+					     const struct irq_domain_ops *ops,
+					     void *host_data);
+
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 #else
-- 
2.20.1

