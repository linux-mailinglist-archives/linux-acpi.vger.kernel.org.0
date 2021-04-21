Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7828A367065
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Apr 2021 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244238AbhDUQoC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Apr 2021 12:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239598AbhDUQoB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Apr 2021 12:44:01 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B1C61406;
        Wed, 21 Apr 2021 16:43:28 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lZFwk-008jPD-Dw; Wed, 21 Apr 2021 17:43:26 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Fu Wei <wefu@redhat.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        stable@vgerlkernel.org
Subject: [PATCH 1/2] ACPI: GTDT: Don't corrupt interrupt mappings on watchdow probe failure
Date:   Wed, 21 Apr 2021 17:43:16 +0100
Message-Id: <20210421164317.1718831-2-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421164317.1718831-1-maz@kernel.org>
References: <20210421164317.1718831-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, guohanjun@huawei.com, dann.frazier@canonical.com, wefu@redhat.com, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com, stable@vgerlkernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When failing the driver probe because of invalid firmware properties,
the GTDT driver unmaps the interrupt that it mapped earlier.

However, it never checks whether the mapping of the interrupt actially
succeeded. Even more, should the firmware report an illegal interrupt
number that overlaps with the GIC SGI range, this can result in an
IPI being unmapped, and subsequent fireworks (as reported by Dann
Frazier).

Rework the driver to have a slightly saner behaviour and actually
check whether the interrupt has been mapped before unmapping things.

Reported-by: dann frazier <dann.frazier@canonical.com>
Fixes: ca9ae5ec4ef0 ("acpi/arm64: Add SBSA Generic Watchdog support in GTDT driver")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/YH87dtTfwYgavusz@xps13.dannf
Cc: stable@vgerlkernel.org
Cc: Fu Wei <wefu@redhat.com>
---
 drivers/acpi/arm64/gtdt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index f2d0e5915dab..0a0a982f9c28 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -329,7 +329,7 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
 					int index)
 {
 	struct platform_device *pdev;
-	int irq = map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
+	int irq;
 
 	/*
 	 * According to SBSA specification the size of refresh and control
@@ -338,7 +338,7 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
 	struct resource res[] = {
 		DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
 		DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
-		DEFINE_RES_IRQ(irq),
+		{},
 	};
 	int nr_res = ARRAY_SIZE(res);
 
@@ -348,10 +348,11 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
 
 	if (!(wd->refresh_frame_address && wd->control_frame_address)) {
 		pr_err(FW_BUG "failed to get the Watchdog base address.\n");
-		acpi_unregister_gsi(wd->timer_interrupt);
 		return -EINVAL;
 	}
 
+	irq = map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
+	res[2] = (struct resource)DEFINE_RES_IRQ(irq);
 	if (irq <= 0) {
 		pr_warn("failed to map the Watchdog interrupt.\n");
 		nr_res--;
@@ -364,7 +365,8 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
 	 */
 	pdev = platform_device_register_simple("sbsa-gwdt", index, res, nr_res);
 	if (IS_ERR(pdev)) {
-		acpi_unregister_gsi(wd->timer_interrupt);
+		if (irq > 0)
+			acpi_unregister_gsi(wd->timer_interrupt);
 		return PTR_ERR(pdev);
 	}
 
-- 
2.29.2

