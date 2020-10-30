Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39452A0BFF
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 18:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgJ3RAS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 13:00:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:64519 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgJ3Q77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 12:59:59 -0400
IronPort-SDR: rvCT8+dqFrxw0K99YX1ZScrWQl037PM7Uo4oMrM+z8x/Exlmv3vYplAKKvDERT+3gwHX4TX+YF
 Aakr/sMVlDLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="168765504"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="168765504"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 09:59:23 -0700
IronPort-SDR: MQEgJw3eSNmulxDAetPI2V2g5YOCfJ5wHujxZTrF4I0DDvHQd6wVstIEo3aynr/CKrOQvN7C18
 SXrwz1n+XuKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="304988662"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 30 Oct 2020 09:59:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C11DC726; Fri, 30 Oct 2020 18:59:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/5] irqdomain: Introduce irq_domain_create_legacy() API
Date:   Fri, 30 Oct 2020 18:59:18 +0200
Message-Id: <20201030165919.86234-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
References: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Introduce irq_domain_create_legacy() API which is functional equivalent
to the existing irq_domain_add_legacy(), but takes a pointer to the struct
fwnode_handle as a parameter.

Some users want to use it in non-OF cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/core-api/irq/irq-domain.rst |  6 ++++++
 include/linux/irqdomain.h                 |  6 ++++++
 kernel/irq/irqdomain.c                    | 17 ++++++++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 096db12f32d5..a77c24c27f7b 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -147,6 +147,7 @@ Legacy
 	irq_domain_add_simple()
 	irq_domain_add_legacy()
 	irq_domain_add_legacy_isa()
+	irq_domain_create_legacy()
 
 The Legacy mapping is a special case for drivers that already have a
 range of irq_descs allocated for the hwirqs.  It is used when the
@@ -185,6 +186,11 @@ that the driver using the simple domain call irq_create_mapping()
 before any irq_find_mapping() since the latter will actually work
 for the static IRQ assignment case.
 
+irq_domain_add_legacy() and irq_domain_create_legacy() are functionally
+equivalent, except for the first argument is different - the former
+accepts an Open Firmware specific 'struct device_node', while the latter
+accepts a more general abstraction 'struct fwnode_handle'.
+
 Hierarchy IRQ domain
 --------------------
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d21f75d294d7..77bf7d84c673 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -271,6 +271,12 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data);
+struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
+					    unsigned int size,
+					    unsigned int first_irq,
+					    irq_hw_number_t first_hwirq,
+					    const struct irq_domain_ops *ops,
+					    void *host_data);
 extern struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 						   enum irq_domain_bus_token bus_token);
 extern bool irq_domain_check_msi_remap(void);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 831526f2e728..9c9cb8829f7a 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -350,17 +350,28 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
+{
+	return irq_domain_create_legacy(of_node_to_fwnode(of_node), size,
+					first_irq, first_hwirq, ops, host_data);
+}
+EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
+
+struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
+					 unsigned int size,
+					 unsigned int first_irq,
+					 irq_hw_number_t first_hwirq,
+					 const struct irq_domain_ops *ops,
+					 void *host_data)
 {
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(of_node_to_fwnode(of_node), first_hwirq + size,
-				  first_hwirq + size, 0, ops, host_data);
+	domain = __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + size, 0, ops, host_data);
 	if (domain)
 		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
 
 	return domain;
 }
-EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
+EXPORT_SYMBOL_GPL(irq_domain_create_legacy);
 
 /**
  * irq_find_matching_fwspec() - Locates a domain for a given fwspec
-- 
2.28.0

