Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05789E35E
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2019 15:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfD2NMP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Apr 2019 09:12:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35308 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbfD2NMP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Apr 2019 09:12:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id f7so7470888wrs.2
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2019 06:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgLkZH7fvnn9ow85IxLoErjzNeQPt/Y/6sGtcm5H+QY=;
        b=JUEtyqTfzgq+eI8JsoNhV2vJVtHVdvLJneMkfVrhS7zClvtLa1COifGGYGf1vqxZsY
         oL/ChqJVd/RBTwXD5iru8C/LUzLz6jjirc+ok6uL3d+L3bwJYu6ptGzutMt9T9KnKne6
         JjCEp7UjWOIjrNKdA6HCoA0ACG6hThLrFTo5rEPUiLMjowlnHb1g2ms6t4iLrT3Pj582
         pItzXWpE2Pg2Qu19ZOF3VQAlYYMPATGQHxZ1N1kSRBpsu5eCmxmGSrK9q2Y7Be12UFYs
         THtw+p6BHyz2Yfrunab4WyoE55JWezpVm8bxfQ8q291n2vU76uMm/3m/XqzF5Bs2NAMt
         oZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgLkZH7fvnn9ow85IxLoErjzNeQPt/Y/6sGtcm5H+QY=;
        b=carT6nfnUeoxHOoeozoX/f7zJfkWKlerMu9egW6RK8XKu5uA/Hm2DODoUduBwNsAzY
         f+n4QWUyTGSrl9zRFx1LL38u2AXob+1Ep3h/k2zvYyvQiyPMK95ms6ip+l8KEZ8ENUu4
         mHqA9vQE2KNwJcVKlOodmfv4yxp93M7HwJqjGT4Xv6Mwgr5AoMmBoOK+XxYNyZhFx2VD
         z1tM6E3aUlqWLlxW1RT6ThcfG/lVE7znJjW14EeaoKHWWG7H3X/99Xw6bHZSi1gwk4re
         KRSXAfRZNb4nCSoYoVvi3wgD1gpk9nzzja3rQ0e/ZyyTlpofVeqIQnHPO+d5G+bDc4Ab
         LCxw==
X-Gm-Message-State: APjAAAWWCcI17mc+v1jzHZ6LgAa7UZNeTcrG3mzCPP23Lk93UA8V3iei
        s08yLbZP6OAzBBRu9tcZo8puaQ==
X-Google-Smtp-Source: APXvYqwJ8ZujIPozdE+1Ob5C21h/cnNZvQf3dhNn73e7SzG9yWn26X0dddFhBP5DGB/Kau+p1YxQpA==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr19107653wrs.265.1556543533485;
        Mon, 29 Apr 2019 06:12:13 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f9fc:88:6502:8fa7])
        by smtp.gmail.com with ESMTPSA id s16sm5410282wrg.71.2019.04.29.06.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 06:12:12 -0700 (PDT)
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
Subject: [PATCH v2 1/4] acpi/irq: implement getter for GSI irqdomain
Date:   Mon, 29 Apr 2019 15:12:05 +0200
Message-Id: <20190429131208.3620-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
References: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
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
mode, we need a helper that returns the default domain for unqualified
interrupts.

This is essentially what the ACPI GSI domain provides, so add a helper
that returns a reference to this domain.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/acpi/irq.c   | 14 ++++++++++----
 include/linux/acpi.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index c3b2222e2129..d47bbd54d4aa 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -17,6 +17,14 @@ enum acpi_irq_model_id acpi_irq_model;
 
 static struct fwnode_handle *acpi_gsi_domain_id;
 
+/**
+ * acpi_get_gsi_irqdomain - Retrieve the irqdomain that owns the GSI space.
+ */
+struct irq_domain *acpi_get_gsi_irqdomain(void)
+{
+	return irq_find_matching_fwnode(acpi_gsi_domain_id, DOMAIN_BUS_ANY);
+}
+
 /**
  * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
  * @gsi: GSI IRQ number to map
@@ -29,8 +37,7 @@ static struct fwnode_handle *acpi_gsi_domain_id;
  */
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 {
-	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
-							DOMAIN_BUS_ANY);
+	struct irq_domain *d = acpi_get_gsi_irqdomain();
 
 	*irq = irq_find_mapping(d, gsi);
 	/*
@@ -76,8 +83,7 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
  */
 void acpi_unregister_gsi(u32 gsi)
 {
-	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
-							DOMAIN_BUS_ANY);
+	struct irq_domain *d = acpi_get_gsi_irqdomain();
 	int irq = irq_find_mapping(d, gsi);
 
 	irq_dispose_mapping(irq);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d5dcebd7aad3..1016027dd626 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -316,6 +316,7 @@ static inline bool acpi_sci_irq_valid(void)
 extern int sbf_port;
 extern unsigned long acpi_realmode_flags;
 
+struct irq_domain *acpi_get_gsi_irqdomain(void);
 int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
-- 
2.20.1

