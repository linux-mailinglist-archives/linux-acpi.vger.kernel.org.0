Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632411DBA1B
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 18:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETQtb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 12:49:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:40344 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgETQtb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 12:49:31 -0400
IronPort-SDR: j2OorsXcnBhStH+I12uwRWkIcPcllhhhCnBIjOwR3MuX0yDXyCPXVDiAArVXk5RX+iduL+YhoX
 SVR+5uJLn0YA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 09:49:30 -0700
IronPort-SDR: Y1SCKT2h35aN4PMn+Z5vjjoLC3V76rGwqdqdipFgCRF8odvuTmkfTZGaInNL0BwI72HHTYwQMZ
 uJ6PkIbukTmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="466457865"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2020 09:49:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5B9E514E; Wed, 20 May 2020 19:49:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] irqdomain: Get rid of special treatment for ACPI in __irq_domain_add()
Date:   Wed, 20 May 2020 19:49:26 +0300
Message-Id: <20200520164927.39090-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520164927.39090-1-andriy.shevchenko@linux.intel.com>
References: <20200520164927.39090-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After change __irq_domain_add() to cooperate better with fwnodes
we don't need to have special treatment for ACPI case.

Get rid of the special treatment for ACPI.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irqdomain.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d59a4224f920..c6204bc606a2 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -161,22 +161,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 			domain->name = fwid->name;
 			break;
 		}
-#ifdef CONFIG_ACPI
-	} else if (is_acpi_device_node(fwnode)) {
-		struct acpi_buffer buf = {
-			.length = ACPI_ALLOCATE_BUFFER,
-		};
-		acpi_handle handle;
-
-		handle = acpi_device_handle(to_acpi_device_node(fwnode));
-		if (acpi_get_name(handle, ACPI_FULL_PATHNAME, &buf) == AE_OK) {
-			domain->name = buf.pointer;
-			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
-		}
-
-		domain->fwnode = fwnode;
-#endif
-	} else if (is_of_node(fwnode)) {
+	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode)) {
 		char *name;
 
 		/*
-- 
2.26.2

