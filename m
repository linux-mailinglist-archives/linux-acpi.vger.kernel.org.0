Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFFB16ACB1
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 18:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbfGPQ1V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 12:27:21 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48911 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbfGPQ1U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 12:27:20 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 64969a0796722d71; Tue, 16 Jul 2019 18:27:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH 2/8] ACPICA: Return u32 from acpi_dispatch_gpe()
Date:   Tue, 16 Jul 2019 18:11:19 +0200
Message-ID: <13053879.VYiyMdvJKT@kreacher>
In-Reply-To: <71085220.z6FKkvYQPX@kreacher>
References: <71085220.z6FKkvYQPX@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In some cases it is useful to know whether or not the
acpi_ev_detect_gpe() called by acpi_dispatch_gpe() has found
the GPE to be active, so return the return value of it (whose
data type is u32) from latter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evxfgpe.c |    6 +++---
 include/acpi/acpixf.h         |    8 +++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-pm/drivers/acpi/acpica/evxfgpe.c
@@ -644,17 +644,17 @@ ACPI_EXPORT_SYMBOL(acpi_get_gpe_status)
  * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number          - GPE level within the GPE block
  *
- * RETURN:      None
+ * RETURN:      INTERRUPT_HANDLED or INTERRUPT_NOT_HANDLED
  *
  * DESCRIPTION: Detect and dispatch a General Purpose Event to either a function
  *              (e.g. EC) or method (e.g. _Lxx/_Exx) handler.
  *
  ******************************************************************************/
-void acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number)
+u32 acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number)
 {
 	ACPI_FUNCTION_TRACE(acpi_dispatch_gpe);
 
-	acpi_ev_detect_gpe(gpe_device, NULL, gpe_number);
+	return acpi_ev_detect_gpe(gpe_device, NULL, gpe_number);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_dispatch_gpe)
Index: linux-pm/include/acpi/acpixf.h
===================================================================
--- linux-pm.orig/include/acpi/acpixf.h
+++ linux-pm/include/acpi/acpixf.h
@@ -297,6 +297,9 @@ ACPI_GLOBAL(u8, acpi_gbl_system_awake_an
 #define ACPI_HW_DEPENDENT_RETURN_OK(prototype) \
 	ACPI_EXTERNAL_RETURN_OK(prototype)
 
+#define ACPI_HW_DEPENDENT_RETURN_UINT32(prototype) \
+	ACPI_EXTERNAL_RETURN_UINT32(prototype)
+
 #define ACPI_HW_DEPENDENT_RETURN_VOID(prototype) \
 	ACPI_EXTERNAL_RETURN_VOID(prototype)
 
@@ -307,6 +310,9 @@ ACPI_GLOBAL(u8, acpi_gbl_system_awake_an
 #define ACPI_HW_DEPENDENT_RETURN_OK(prototype) \
 	static ACPI_INLINE prototype {return(AE_OK);}
 
+#define ACPI_HW_DEPENDENT_RETURN_UINT32(prototype) \
+	static ACPI_INLINE prototype {return(0);}
+
 #define ACPI_HW_DEPENDENT_RETURN_VOID(prototype) \
 	static ACPI_INLINE prototype {return;}
 
@@ -738,7 +744,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
 						     u32 gpe_number,
 						     acpi_event_status
 						     *event_status))
-ACPI_HW_DEPENDENT_RETURN_VOID(void acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number))
+ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))



