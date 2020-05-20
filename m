Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DB41DBA20
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 18:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgETQtq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 12:49:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:40989 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgETQtq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 12:49:46 -0400
IronPort-SDR: CDIAnRxHwz2fRbPpt6045xdiUAhYrNiwtisjCMXj4vqO24Xep41PMvLAOF52igLkxskQ6lyQKd
 kqJPdlYoYrvg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 09:49:30 -0700
IronPort-SDR: QSmIUmN5LSjnVegBOaEDJUo4hEJu5QoOWHXqoqQ7SeziH1+4eKGMYk2IAw/pqGQVqj8aHGXqe3
 4gulLecZzHFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="374138640"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 May 2020 09:49:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 633FC1ED; Wed, 20 May 2020 19:49:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] irqdomain: Allow software node to be correct one for IRQ domain
Date:   Wed, 20 May 2020 19:49:27 +0300
Message-Id: <20200520164927.39090-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520164927.39090-1-andriy.shevchenko@linux.intel.com>
References: <20200520164927.39090-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In some cases we might need to have an IRQ domain created out of software node.
One of such cases is DesignWare GPIO driver when it's instantiated from
half-baked ACPI table (alas, we can't fix it for devices which are few years
on market) and thus using software nodes to quirk this up. But the driver
is using IRQ domains based on per GPIO port firmware nodes, which are in
the above case software ones. This brings a warning message to be printed

  [   73.957183] irq: Invalid fwnode type for irqdomain

and creates an unknown IRQ domain.

When we allow software node to be correct one for IRQ domain we will
get rid of the warning message and nice domain name at the same time:

  % ls -1 /sys/kernel/debug/irq/domains/
  ...
  intel-quark-dw-apb-gpio:portA

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irqdomain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index c6204bc606a2..e4ebc5398ef5 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -161,7 +161,8 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 			domain->name = fwid->name;
 			break;
 		}
-	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode)) {
+	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) ||
+		   is_software_node(fwnode)) {
 		char *name;
 
 		/*
-- 
2.26.2

