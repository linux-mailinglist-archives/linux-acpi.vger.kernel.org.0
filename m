Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F042A0BFD
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 18:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgJ3RAO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 13:00:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:23301 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgJ3Q77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 12:59:59 -0400
IronPort-SDR: 9okJ5D8e68fPce6YVZpJNOVkzZbTXdlLD3iA6e6Ff0Jj+uzNttNCINYHr4i874yKl0/1Yes4He
 V8RVZNniqLGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="156409552"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="156409552"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 09:59:26 -0700
IronPort-SDR: d/J/nuxwkIfLocNU+z20Qnvu1v3oTx0L/VU2g/crrf7ikpwzlmAHCs/hNbuIUOQwLminprexI9
 iqWlJd0tOcJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="351926030"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 30 Oct 2020 09:59:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CDFAC772; Fri, 30 Oct 2020 18:59:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/5] regmap: irq: Convert to use fwnode directly
Date:   Fri, 30 Oct 2020 18:59:19 +0200
Message-Id: <20201030165919.86234-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
References: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since IRQ domain provides an API to take fwnode as a parameter,
switch regmap IRQ to use that directly instead of be limited
to OF case only.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-irq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index ad5c2de395d1..19db764ffa4a 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -803,13 +803,12 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	}
 
 	if (irq_base)
-		d->domain = irq_domain_add_legacy(to_of_node(fwnode),
-						  chip->num_irqs, irq_base,
-						  0, &regmap_domain_ops, d);
+		d->domain = irq_domain_create_legacy(fwnode, chip->num_irqs,
+						     irq_base, 0,
+						     &regmap_domain_ops, d);
 	else
-		d->domain = irq_domain_add_linear(to_of_node(fwnode),
-						  chip->num_irqs,
-						  &regmap_domain_ops, d);
+		d->domain = irq_domain_create_linear(fwnode, chip->num_irqs,
+						     &regmap_domain_ops, d);
 	if (!d->domain) {
 		dev_err(map->dev, "Failed to create IRQ domain\n");
 		ret = -ENOMEM;
-- 
2.28.0

