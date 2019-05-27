Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A042B333
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2019 13:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfE0L12 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 May 2019 07:27:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33640 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfE0L12 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 May 2019 07:27:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so16591175wrx.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 May 2019 04:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4u6FsMjt7h1mCBbzF7v4CGj5ydrGz7m3OWmqqT2YeQ=;
        b=I9mAK54lsjfxBtfVgVx+UfCZ5AuAj4rEdu91KUk/42mbkyOYaJRKTY+IcGjZ0wIFAm
         Bn10OFQ9b3dXWOnNG5ohdDY/Dy5wSjvON2EsYDp4deuNhfh1tghQ2gMuIUWsL6wEUS69
         2cqOMV4tgfEbrGN+Znr3aHUr3nmrRGcTvJt+P8IkMQlQUDdD6gFdgyToEtEe3wfARh9J
         gh1NCsHs2kZ04wnKApvp81FDuCfdSPEUTSfimaCXW0wykCXioIQrVyfhzoXFEfzDXh5V
         ej+hCnIV3Q2y4FYUxQ9uHHWef7TfQvOWcTHCKhcD7KBPYV+o/1DaxMrxZcuAzSNjpTfg
         NF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4u6FsMjt7h1mCBbzF7v4CGj5ydrGz7m3OWmqqT2YeQ=;
        b=SlGfN4UDIaX49suNC/aJiq8Tt7Ah00zwRUZg0Vm+5y27VDGgFP/eSoNux0KTzoRAwb
         laXtPL6qREHGvEyUMR+hjxDPBCfvASb24MJ3YpTAwYGSHr93aKJrfP8vPKO8qEaXbsUE
         oLcprVgvfUfXH30fZGqAUBgLYkM/fuGqQtW9vkGEl5BXkyh+cYcwpVyaXU88KJ5ASHSy
         FY/Xu2d/NElSBtvxcysaLiVRqiQ4SjbyE+yr8VNML/nIqVMrtyQCK8+7JSpa9o3TuOFA
         VmkJ06+hnwbKpctr2fJnCvIurjzjYWv9t95yodBe2iTyLqoL8KzAMUQvOy5wXuLhy9bg
         4xeg==
X-Gm-Message-State: APjAAAUWWdjL3GMZu1ZkR7qQaAqSTJnJFZDvC1iZLZLIxX0gnXjCB9Jr
        VxlAxiQCsF1JZRUW6ddG2vTLEA==
X-Google-Smtp-Source: APXvYqwnB2Gk0QqWOibtkylqFHxJGe0tfUyzEORIvpkrV+qc60/5I4wSEzsHkwdlyHFZyLeCi1AWaQ==
X-Received: by 2002:adf:ce03:: with SMTP id p3mr6636532wrn.94.1558956446659;
        Mon, 27 May 2019 04:27:26 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:ccdd:dadc:1517:f416])
        by smtp.gmail.com with ESMTPSA id l6sm9677747wmi.24.2019.05.27.04.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 04:27:25 -0700 (PDT)
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
Subject: [PATCH v3 1/4] acpi/irq: implement helper to create hierachical domains
Date:   Mon, 27 May 2019 13:27:17 +0200
Message-Id: <20190527112720.2266-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527112720.2266-1-ard.biesheuvel@linaro.org>
References: <20190527112720.2266-1-ard.biesheuvel@linaro.org>
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
mode, we need a helper that implicitly grabs the default domain for
unqualified interrupts as the parent of the hierarchy.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/acpi/irq.c   | 20 ++++++++++++++++++++
 include/linux/acpi.h |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index c3b2222e2129..39824a6bbcd5 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -295,3 +295,23 @@ void __init acpi_set_irq_model(enum acpi_irq_model_id model,
 	acpi_irq_model = model;
 	acpi_gsi_domain_id = fwnode;
 }
+
+/**
+ * acpi_irq_create_hierarchy - Create a hierarchical IRQ domain with the default
+ *                             GSI domain as its parent.
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

