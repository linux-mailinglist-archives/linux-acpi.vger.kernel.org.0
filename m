Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93209120401
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 12:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfLPLex (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 06:34:53 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49632 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfLPLex (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 06:34:53 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 3930d591b1240d67; Mon, 16 Dec 2019 12:34:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: processor: Make ACPI_PROCESSOR_CSTATE depend on ACPI_PROCESSOR
Date:   Mon, 16 Dec 2019 12:34:50 +0100
Message-ID: <16614264.JRhOIQ9zEg@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To avoid build errors when CONFIG_ACPI_PROCESSOR_CSTATE is set and
CONFIG_ACPI_PROCESSOR is not (that may appear in randconfig builds),
make the former depend on the latter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The build issues addressed by this patch are exposed by the series adding ACPI
support to intel_idle:

https://lore.kernel.org/linux-pm/3950312.2WmFeOdZGY@kreacher/T/#t

so it has been added to the intel_idle+acpi branch (which has been rebased on
top of 5.5-rc2).

---
 drivers/acpi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/drivers/acpi/Kconfig
===================================================================
--- linux-pm.orig/drivers/acpi/Kconfig
+++ linux-pm/drivers/acpi/Kconfig
@@ -241,6 +241,7 @@ config ACPI_CPU_FREQ_PSS
 
 config ACPI_PROCESSOR_CSTATE
 	def_bool y
+	depends on ACPI_PROCESSOR
 	depends on IA64 || X86
 
 config ACPI_PROCESSOR_IDLE



