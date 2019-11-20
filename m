Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55EFB1036AE
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2019 10:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfKTJdh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Nov 2019 04:33:37 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59057 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKTJdh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2019 04:33:37 -0500
Received: from 79.184.253.244.ipv4.supernova.orange.pl (79.184.253.244) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 4da6d083348937fd; Wed, 20 Nov 2019 10:33:34 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Smythies <dsmythies@telus.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] PM: QoS: Invalidate frequency QoS requests after removal
Date:   Wed, 20 Nov 2019 10:33:34 +0100
Message-ID: <12409907.uLZWGnKmhe@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Switching cpufreq drivers (or switching operation modes of the
intel_pstate driver from "active" to "passive" and vice versa)
does not work on some x86 systems with ACPI after commit
3000ce3c52f8 ("cpufreq: Use per-policy frequency QoS"), because
the ACPI _PPC and thermal code uses the same frequency QoS request
object for a given CPU every time a cpufreq driver is registered
and freq_qos_remove_request() does not invalidate the request after
removing it from its QoS list, so freq_qos_add_request() complains
and fails when that request is passed to it again.

Fix the issue by modifying freq_qos_remove_request() to clear the qos
and type fields of the frequency request pointed to by its argument
after removing it from its QoS list so as to invalidate it.

Fixes: 3000ce3c52f8 ("cpufreq: Use per-policy frequency QoS")
Reported-and-tested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/qos.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-pm/kernel/power/qos.c
===================================================================
--- linux-pm.orig/kernel/power/qos.c
+++ linux-pm/kernel/power/qos.c
@@ -814,6 +814,8 @@ EXPORT_SYMBOL_GPL(freq_qos_update_reques
  */
 int freq_qos_remove_request(struct freq_qos_request *req)
 {
+	int ret;
+
 	if (!req)
 		return -EINVAL;
 
@@ -821,7 +823,11 @@ int freq_qos_remove_request(struct freq_
 		 "%s() called for unknown object\n", __func__))
 		return -EINVAL;
 
-	return freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
+	ret = freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
+	req->qos = NULL;
+	req->type = 0;
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(freq_qos_remove_request);
 



