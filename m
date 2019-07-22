Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD7A16FDB0
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2019 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfGVKXB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jul 2019 06:23:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46678 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfGVKXA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jul 2019 06:23:00 -0400
Received: from 79.184.253.188.ipv4.supernova.orange.pl (79.184.253.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 3cd7878186d92ba4; Mon, 22 Jul 2019 12:22:57 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] int340X/processor_thermal_device: Fix proc_thermal_rapl_remove()
Date:   Mon, 22 Jul 2019 12:22:57 +0200
Message-ID: <3270289.QqOHTbhTGK@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Passing 0 to cpuhp_remove_state() triggers the BUG_ON() in
__cpuhp_remove_state_cpuslocked() and the argument passed to
powercap_unregister_control_type() is expected to be a valid
pointer, so avoid calling these functions with incorrect
arguments from proc_thermal_rapl_remove().

Fixes: 555c45fe0d04 ("int340X/processor_thermal_device: add support for MMIO RAPL")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -487,6 +487,7 @@ static int proc_thermal_rapl_add(struct
 				rapl_mmio_cpu_online, rapl_mmio_cpu_down_prep);
 	if (ret < 0) {
 		powercap_unregister_control_type(rapl_mmio_priv.control_type);
+		rapl_mmio_priv.control_type = NULL;
 		return ret;
 	}
 	rapl_mmio_priv.pcap_rapl_online = ret;
@@ -496,6 +497,9 @@ static int proc_thermal_rapl_add(struct
 
 static void proc_thermal_rapl_remove(void)
 {
+	if (IS_ERR_OR_NULL(rapl_mmio_priv.control_type))
+		return;
+
 	cpuhp_remove_state(rapl_mmio_priv.pcap_rapl_online);
 	powercap_unregister_control_type(rapl_mmio_priv.control_type);
 }



