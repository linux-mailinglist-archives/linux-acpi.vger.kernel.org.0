Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B9D367067
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Apr 2021 18:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244294AbhDUQoD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Apr 2021 12:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241939AbhDUQoC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Apr 2021 12:44:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F9861450;
        Wed, 21 Apr 2021 16:43:28 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lZFwk-008jPD-UV; Wed, 21 Apr 2021 17:43:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Fu Wei <wefu@redhat.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [PATCH 2/2] ACPI: irq: Prevent unregistering of GIC SGIs
Date:   Wed, 21 Apr 2021 17:43:17 +0100
Message-Id: <20210421164317.1718831-3-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421164317.1718831-1-maz@kernel.org>
References: <20210421164317.1718831-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, guohanjun@huawei.com, dann.frazier@canonical.com, wefu@redhat.com, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When using ACPI on arm64, which implies the GIC IRQ model, no
table should ever provide a GSI number in the range [0:15],
as these are reserved for IPIs.

However, drivers tend to call acpi_unregister_gsi() with any
random GSI number provided by half baked tables, which results
in an exploding kernel when its IPIs have been unconfigured.

In order to catch this, check for the silly case early, warn
that something is going wrong and avoid the above disaster.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/irq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index e209081d644b..c68e694fca26 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -75,8 +75,12 @@ void acpi_unregister_gsi(u32 gsi)
 {
 	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
 							DOMAIN_BUS_ANY);
-	int irq = irq_find_mapping(d, gsi);
+	int irq;
 
+	if (WARN_ON(acpi_irq_model == ACPI_IRQ_MODEL_GIC && gsi < 16))
+		return;
+
+	irq = irq_find_mapping(d, gsi);
 	irq_dispose_mapping(irq);
 }
 EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
-- 
2.29.2

