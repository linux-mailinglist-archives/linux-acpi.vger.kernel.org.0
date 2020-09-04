Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA88525E0B9
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 19:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgIDR0R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 13:26:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58200 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgIDR0O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 13:26:14 -0400
Received: from 89-64-89-131.dynamic.chello.pl (89.64.89.131) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.468)
 id cdf42de74af96259; Fri, 4 Sep 2020 19:26:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 5/6] ACPI: OSL: Change the type of acpi_os_map_generic_address() return value
Date:   Fri, 04 Sep 2020 19:24:51 +0200
Message-ID: <9772445.uTLouIlUSL@kreacher>
In-Reply-To: <1748021.N9i9sLPJ40@kreacher>
References: <1748021.N9i9sLPJ40@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Modify acpi_os_map_generic_address() to return the pointer returned
by acpi_os_map_iomem() which represents the logical address
corresponding to the struct acpi_generic_address argument passed to
it or NULL if that address cannot be obtained (for example, the
argument does not represent an address in system memory or it could
not be mapped by the OS).

Among other things, that will allow the ACPI OS layer to pass the
logical addresses of the FADT GPE blocks 0 and 1 to ACPICA going
forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/apei/apei-base.c |  6 +++++-
 drivers/acpi/osl.c            | 18 +++++++-----------
 include/acpi/acpi_io.h        |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index e358d0046494..552fd9ffaca4 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -632,7 +632,11 @@ int apei_map_generic_address(struct acpi_generic_address *reg)
 	rc = apei_check_gar(reg, &address, &access_bit_width);
 	if (rc)
 		return rc;
-	return acpi_os_map_generic_address(reg);
+
+	if (!acpi_os_map_generic_address(reg))
+		return -ENXIO;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(apei_map_generic_address);
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 4a0b07792233..3a50d8fa310b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -447,24 +447,19 @@ void __ref acpi_os_unmap_memory(void *virt, acpi_size size)
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
 
-int acpi_os_map_generic_address(struct acpi_generic_address *gas)
+void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
 {
 	u64 addr;
-	void __iomem *virt;
 
 	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		return 0;
+		return NULL;
 
 	/* Handle possible alignment issues */
 	memcpy(&addr, &gas->address, sizeof(addr));
 	if (!addr || !gas->bit_width)
-		return -EINVAL;
-
-	virt = acpi_os_map_iomem(addr, gas->bit_width / 8);
-	if (!virt)
-		return -EIO;
+		return NULL;
 
-	return 0;
+	return acpi_os_map_iomem(addr, gas->bit_width / 8);
 }
 EXPORT_SYMBOL(acpi_os_map_generic_address);
 
@@ -1756,10 +1751,11 @@ acpi_status __init acpi_os_initialize(void)
 		 * Use acpi_os_map_generic_address to pre-map the reset
 		 * register if it's in system memory.
 		 */
-		int rv;
+		void *rv;
 
 		rv = acpi_os_map_generic_address(&acpi_gbl_FADT.reset_register);
-		pr_debug(PREFIX "%s: map reset_reg status %d\n", __func__, rv);
+		pr_debug(PREFIX "%s: map reset_reg %s\n", __func__,
+			 rv ? "successful" : "failed");
 	}
 	acpi_os_initialized = true;
 
diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
index 12d8bd333fe7..027faa8883aa 100644
--- a/include/acpi/acpi_io.h
+++ b/include/acpi/acpi_io.h
@@ -21,7 +21,7 @@ void __iomem __ref
 void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size);
 void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size);
 
-int acpi_os_map_generic_address(struct acpi_generic_address *addr);
+void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *addr);
 void acpi_os_unmap_generic_address(struct acpi_generic_address *addr);
 
 #endif
-- 
2.26.2




