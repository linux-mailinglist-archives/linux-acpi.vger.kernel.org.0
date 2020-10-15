Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EF028F756
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 19:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389973AbgJORAF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 13:00:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41578 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388946AbgJORAE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2020 13:00:04 -0400
Received: from 89-64-88-192.dynamic.chello.pl (89.64.88.192) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id b914199718e2c358; Thu, 15 Oct 2020 19:00:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 2/2] ACPI: DPTF: Add ACPI_DPTF Kconfig menu
Date:   Thu, 15 Oct 2020 18:59:52 +0200
Message-ID: <35637045.pmxlVluP8t@kreacher>
In-Reply-To: <2206290.MayQypTng0@kreacher>
References: <2206290.MayQypTng0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a Kconfig menu for Intel DPTF (Dynamic Platform and Thermal
Framework), put both the existing participant drivers in it and set
them to be built as modules by default.

While at it, do a few assorted cleanups for a good measure.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/dptf/Kconfig |   29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/dptf/Kconfig
===================================================================
--- linux-pm.orig/drivers/acpi/dptf/Kconfig
+++ linux-pm/drivers/acpi/dptf/Kconfig
@@ -1,8 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0
-config DPTF_POWER
-	tristate "DPTF Platform Power Participant"
+
+menuconfig ACPI_DPTF
+	bool "Intel DPTF (Dynamic Platform and Thermal Framework) Support"
 	depends on X86
 	help
+	  Intel Dynamic Platform and Thermal Framework (DPTF) is a platform
+	  level hardware/software solution for power and thermal management.
+
+	  As a container for multiple power/thermal technologies, DPTF provides
+	  a coordinated approach for different policies to effect the hardware
+	  state of a system.
+
+	  For more information see:
+	  <https://01.org/intel%C2%AE-dynamic-platform-and-thermal-framework-dptf-chromium-os/overview>
+
+if ACPI_DPTF
+
+config DPTF_POWER
+	tristate "Platform Power DPTF Participant"
+	default m
+	help
 	  This driver adds support for Dynamic Platform and Thermal Framework
 	  (DPTF) Platform Power Participant device (INT3407) support.
 	  This participant is responsible for exposing platform telemetry:
@@ -16,15 +33,17 @@ config DPTF_POWER
 	  the module will be called dptf_power.
 
 config DPTF_PCH_FIVR
-	tristate "DPTF PCH FIVR Participant"
-	depends on X86
+	tristate "PCH FIVR DPTF Participant"
+	default m
 	help
 	  This driver adds support for Dynamic Platform and Thermal Framework
 	  (DPTF) PCH FIVR Participant device support. This driver allows to
-	  switch PCH FIVR (Fully Integrated Voltage Regulator) frequency.
+	  switch the PCH FIVR (Fully Integrated Voltage Regulator) frequency.
 	  This participant is responsible for exposing:
 		freq_mhz_low_clock
 		freq_mhz_high_clock
 
 	  To compile this driver as a module, choose M here:
 	  the module will be called dptf_pch_fivr.
+
+endif



