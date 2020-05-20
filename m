Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2991DBA1D
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 18:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgETQtd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 12:49:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:29689 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgETQtb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 12:49:31 -0400
IronPort-SDR: pLP+2emcwG+cLwOCaYwGDlEHj4gn/y8BN1jOvbqrk0D5nJNdVviCSpTA1W0+I875yeRSW+k1U4
 jYaj5FL6D7WA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 09:49:30 -0700
IronPort-SDR: HnYbro/NjAr0r6UV/+lTENLyp3LauNTVC0VU7/HiFcTTE//uwh/rrcGdz43CpkdAvUpwtX8HEl
 hO+ACXxNj4aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="299992956"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 May 2020 09:49:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4EE4017E; Wed, 20 May 2020 19:49:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] irqdomain: Make __irq_domain_add() less OF-dependent
Date:   Wed, 20 May 2020 19:49:25 +0300
Message-Id: <20200520164927.39090-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

__irq_domain_add() in some places relies on the fact that fwnode
can be only type of OF. This prevents refactoring of the code
to support other types of fwnode. Make it less OF-dependent
by switching to use fwnode directly where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irqdomain.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 35b8d97c3a1d..d59a4224f920 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -132,14 +132,13 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 				    const struct irq_domain_ops *ops,
 				    void *host_data)
 {
-	struct device_node *of_node = to_of_node(fwnode);
 	struct irqchip_fwid *fwid;
 	struct irq_domain *domain;
 
 	static atomic_t unknown_domains;
 
 	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
-			      GFP_KERNEL, of_node_to_nid(of_node));
+			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
 	if (!domain)
 		return NULL;
 
@@ -177,15 +176,15 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 
 		domain->fwnode = fwnode;
 #endif
-	} else if (of_node) {
+	} else if (is_of_node(fwnode)) {
 		char *name;
 
 		/*
-		 * DT paths contain '/', which debugfs is legitimately
+		 * fwnode paths contain '/', which debugfs is legitimately
 		 * unhappy about. Replace them with ':', which does
 		 * the trick and is not as offensive as '\'...
 		 */
-		name = kasprintf(GFP_KERNEL, "%pOF", of_node);
+		name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
 		if (!name) {
 			kfree(domain);
 			return NULL;
@@ -210,7 +209,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
-	of_node_get(of_node);
+	fwnode_handle_get(fwnode);
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
@@ -259,7 +258,7 @@ void irq_domain_remove(struct irq_domain *domain)
 
 	pr_debug("Removed domain %s\n", domain->name);
 
-	of_node_put(irq_domain_get_of_node(domain));
+	fwnode_handle_put(domain->fwnode);
 	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
 		kfree(domain->name);
 	kfree(domain);
-- 
2.26.2

