Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A382A0BFB
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 18:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgJ3RAA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 13:00:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:54480 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgJ3Q77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 12:59:59 -0400
IronPort-SDR: D+FHN8s4HrRdmg2JbN6/5zMbezWORVFa4RlDQsxibKM/QwuKqN1LJ+aG8zDCvDPl5orrupMUA8
 du6HML2TA6cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="230271388"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="230271388"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 09:59:23 -0700
IronPort-SDR: YNyQ8NFHqXxZYtLcfXDKjID5L9YASzfYrXHyikEdrFgK23FQVT6DHc6Fpmz/n6sQuOus7tOsp1
 fg9pcfPuoFVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="319377478"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2020 09:59:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B85E0638; Fri, 30 Oct 2020 18:59:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/5] irqdomain: Replace open coded of_node_to_fwnode()
Date:   Fri, 30 Oct 2020 18:59:17 +0200
Message-Id: <20201030165919.86234-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
References: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We can convert device node to fwnode with of_node_to_fwnode().
Replace open coded variant of it in of_phandle_args_to_fwspec().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf8b374b892d..831526f2e728 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -737,7 +737,7 @@ static void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 {
 	int i;
 
-	fwspec->fwnode = np ? &np->fwnode : NULL;
+	fwspec->fwnode = of_node_to_fwnode(np);
 	fwspec->param_count = count;
 
 	for (i = 0; i < count; i++)
-- 
2.28.0

