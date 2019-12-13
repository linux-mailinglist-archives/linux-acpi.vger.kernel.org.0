Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB2211E08F
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 10:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfLMJ1b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 04:27:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43234 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfLMJ1b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Dec 2019 04:27:31 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 9e2bfb5acf4f8881; Fri, 13 Dec 2019 10:27:28 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 09/10] intel_idle: Add module parameter to prevent ACPI _CST from being used
Date:   Fri, 13 Dec 2019 10:24:58 +0100
Message-ID: <4991900.sFTjH42vUX@kreacher>
In-Reply-To: <3950312.2WmFeOdZGY@kreacher>
References: <3950312.2WmFeOdZGY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Add a new module parameter called "no_acpi" to the intel_idle driver
to allow the driver to be prevented from using ACPI _CST via kernel
command line.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

No changes from the RFC version.

---
 drivers/idle/intel_idle.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index a072b84d9595..26fe383bb921 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1138,6 +1138,10 @@ static bool intel_idle_max_cstate_reached(int cstate)
 #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
 #include <acpi/processor.h>
 
+static bool no_acpi __read_mostly;
+module_param(no_acpi, bool, 0444);
+MODULE_PARM_DESC(no_acpi, "Do not use ACPI _CST for building the idle states list");
+
 static struct acpi_processor_power acpi_state_table;
 
 /**
@@ -1167,6 +1171,11 @@ static bool intel_idle_acpi_cst_extract(void)
 {
 	unsigned int cpu;
 
+	if (no_acpi) {
+		pr_debug("Not allowed to use ACPI _CST\n");
+		return false;
+	}
+
 	for_each_possible_cpu(cpu) {
 		struct acpi_processor *pr = per_cpu(processors, cpu);
 
-- 
2.16.4





