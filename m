Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB92A3A09DA
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 04:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhFICQo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 22:16:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53646 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhFICQo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 22:16:44 -0400
Received: from [123.112.67.167] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <hui.wang@canonical.com>)
        id 1lqnk0-0006cV-Sk; Wed, 09 Jun 2021 02:14:49 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     manuelkrause@netscape.net, hui.wang@canonical.com
Subject: [PATCH v3] ACPI : don't always override the acpi irq
Date:   Wed,  9 Jun 2021 10:14:42 +0800
Message-Id: <20210609021442.12446-1-hui.wang@canonical.com>
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
IRQNoFlags, and according to the Section 6.4.2.1 of ACPI 6.4 spec [1],
if IRQ() is empty or defines IRQNoFlags, the IRQ is High true, edge
sensitive and non-shareable. The linux ACPI driver (acpi_rs_set_irq[]
in rsirq.c) also assumes so.

Here check 3 conditions to decide if the legacy is true or not, if it
is true, it means the IRQ() is empty or defines IRQNoFlags and need to
call irq_override().

Link: https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#irq-descriptor # [1]
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
BugLink: http://bugs.launchpad.net/bugs/1909814
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-and-tested-by: Manuel Krause <manuelkrause@netscape.net>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/acpi/resource.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ee78a210c606..dc01fb550b28 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -423,6 +423,13 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	}
 }
 
+static bool irq_is_legacy(struct acpi_resource_irq *irq)
+{
+	return irq->triggering == ACPI_EDGE_SENSITIVE &&
+		irq->polarity == ACPI_ACTIVE_HIGH &&
+		irq->shareable == ACPI_EXCLUSIVE;
+}
+
 /**
  * acpi_dev_resource_interrupt - Extract ACPI interrupt resource information.
  * @ares: Input ACPI resource object.
@@ -461,7 +468,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 		}
 		acpi_dev_get_irqresource(res, irq->interrupts[index],
 					 irq->triggering, irq->polarity,
-					 irq->shareable, true);
+					 irq->shareable, irq_is_legacy(irq));
 		break;
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		ext_irq = &ares->data.extended_irq;
-- 
2.25.1

