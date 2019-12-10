Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2863A1187D0
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2019 13:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfLJMNg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Dec 2019 07:13:36 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52996 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfLJMNg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2019 07:13:36 -0500
Received: from 79.184.255.117.ipv4.supernova.orange.pl (79.184.255.117) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 616de29a2a835439; Tue, 10 Dec 2019 13:13:32 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [RFC v2][PATCH 2/9] ACPI: processor: Introduce acpi_processor_evaluate_cst()
Date:   Tue, 10 Dec 2019 13:02:12 +0100
Message-ID: <16599294.5T63LaqZPT@kreacher>
In-Reply-To: <35821518.IbFVMVmUy3@kreacher>
References: <35821518.IbFVMVmUy3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order to separate the ACPI _CST evaluation from checks
specific to the ACPI processor driver, move the majority of
the acpi_processor_get_power_info_cst() function body to a new
function, acpi_processor_evaluate_cst(), that will extract
the C-states information from _CST output, and redefine
acpi_processor_get_power_info_cst() as a wrapper around it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

No changes from the previous version.

---
 drivers/acpi/processor_idle.c |   52 +++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -297,21 +297,17 @@ static int acpi_processor_get_power_info
 	return 0;
 }
 
-static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
+static int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
+				       struct acpi_processor_power *info)
 {
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *cst;
 	acpi_status status;
 	u64 count;
-	int current_count;
+	int current_count = 0;
 	int i, ret = 0;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *cst;
-
-	if (nocst)
-		return -ENODEV;
-
-	current_count = 0;
 
-	status = acpi_evaluate_object(pr->handle, "_CST", NULL, &buffer);
+	status = acpi_evaluate_object(handle, "_CST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No _CST, giving up\n"));
 		return -ENODEV;
@@ -335,9 +331,6 @@ static int acpi_processor_get_power_info
 		goto end;
 	}
 
-	/* Tell driver that at least _CST is supported. */
-	pr->flags.has_cst = 1;
-
 	for (i = 1; i <= count; i++) {
 		union acpi_object *element;
 		union acpi_object *obj;
@@ -383,7 +376,7 @@ static int acpi_processor_get_power_info
 		cx.entry_method = ACPI_CSTATE_SYSTEMIO;
 		if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
 			if (acpi_processor_ffh_cstate_probe
-					(pr->id, &cx, reg) == 0) {
+					(cpu, &cx, reg) == 0) {
 				cx.entry_method = ACPI_CSTATE_FFH;
 			} else if (cx.type == ACPI_STATE_C1) {
 				/*
@@ -432,7 +425,7 @@ static int acpi_processor_get_power_info
 			continue;
 
 		current_count++;
-		memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx));
+		memcpy(&info->states[current_count], &cx, sizeof(cx));
 
 		/*
 		 * We support total ACPI_PROCESSOR_MAX_POWER - 1
@@ -446,12 +439,9 @@ static int acpi_processor_get_power_info
 		}
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d power states\n",
-			  current_count));
+	acpi_handle_info(handle, "Found %d idle states\n", current_count);
 
-	/* Validate number of power states discovered */
-	if (current_count < 2)
-		ret = -EFAULT;
+	info->count = current_count;
 
       end:
 	kfree(buffer.pointer);
@@ -459,6 +449,28 @@ static int acpi_processor_get_power_info
 	return ret;
 }
 
+static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
+{
+	int ret;
+
+	if (nocst)
+		return -ENODEV;
+
+	ret = acpi_processor_evaluate_cst(pr->handle, pr->id, &pr->power);
+	if (ret)
+		return ret;
+
+	/*
+	 * It is expected that there will be at least 2 states, C1 and
+	 * something else (C2 or C3), so fail if that is not the case.
+	 */
+	if (pr->power.count < 2)
+		return -EFAULT;
+
+	pr->flags.has_cst = 1;
+	return 0;
+}
+
 static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 					   struct acpi_processor_cx *cx)
 {



