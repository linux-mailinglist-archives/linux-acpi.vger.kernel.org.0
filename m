Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AF839EDE2
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 06:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhFHE6d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 00:58:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45811 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFHE6c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 00:58:32 -0400
Received: from [123.112.67.167] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <hui.wang@canonical.com>)
        id 1lqTn4-00016o-MB; Tue, 08 Jun 2021 04:56:39 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     manuelkrause@netscape.net
Subject: [PATCH] ACPI : don't always override the acpi irq
Date:   Tue,  8 Jun 2021 12:56:32 +0800
Message-Id: <20210608045632.8832-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The laptop keyboard doesn't work on many MEDION notebooks, but the
keyboard works well under Windows and Unix.

Through debugging, we found this log in the dmesg:
ACPI: IRQ 1 override to edge, high
pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)

And we checked the IRQ definition in the DSDT, it is:
    IRQ (Level, ActiveLow, Exclusive, )
        {1}

So the BIOS defines the keyboard irq to Level_Low, but the linux
kernel override it to Edge_High. If let the linux kernel skip the irq
override, the keyboard will work normally.

From the existing comment in the acpi_dev_get_irqresource(), the
override function only needs to be called when BIOS defines IRQ() or
IRQNoFlags, and according to page 419 and 420 of the
ACPI_6_3_final_Jan30.pdf, if IRQ() is empty or defines IRQNoFlags,
the IRQ is High true, edge sensitive and non-shareable. The linux
ACPI driver (acpi_rs_set_irq[] in rsirq.c) also assumes so.

So here add a function to check 4 conditions, if all of them are true,
call override function. otherwise, it means IRQ descriptior in the
BIOS is not legacy or is not empty.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
BugLink: http://bugs.launchpad.net/bugs/1909814
Reported-and-tested-by: Manuel Krause <manuelkrause@netscape.net>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/acpi/resource.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ee78a210c606..d346aa24ffd6 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -380,6 +380,16 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
 
+static bool acpi_dev_irq_empty_or_noflags(bool legacy, u8 triggering, u8 polarity,
+					  u8 shareable)
+{
+	if (legacy && (triggering == ACPI_EDGE_SENSITIVE) &&
+	    (polarity == ACPI_ACTIVE_HIGH) && (shareable == ACPI_EXCLUSIVE))
+		return true;
+	else
+		return false;
+}
+
 static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 				     u8 triggering, u8 polarity, u8 shareable,
 				     bool legacy)
@@ -401,7 +411,8 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	 * using extended IRQ descriptors we take the IRQ configuration
 	 * from _CRS directly.
 	 */
-	if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
+	if (acpi_dev_irq_empty_or_noflags(legacy, triggering, polarity, shareable)
+	    && !acpi_get_override_irq(gsi, &t, &p)) {
 		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
 		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
 
-- 
2.25.1

