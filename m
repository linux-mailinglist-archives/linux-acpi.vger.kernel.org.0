Return-Path: <linux-acpi+bounces-14527-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D11AE66B0
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 15:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF527B4E29
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9A29B20D;
	Tue, 24 Jun 2025 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="vg3vdHso"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244E6F06B;
	Tue, 24 Jun 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772301; cv=none; b=D3SDyH0jo1+A69io3NIy6GyrKYUV/XvLnIU4ode//pyX0qUuFtwJgRSYWKX8EGsFNKPePES8GFbpcndkvHWuIDiHdme/IXfnQt+7yagpblYwFUw/QAiJhvC1zoQXwEKExO2jgGtVSScawdcCQ2K9/RgKC3NDzYUJo93UbJBAe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772301; c=relaxed/simple;
	bh=AdcsWCAHRElClpEpLE/K99EdSkd/FjbQKab8AQNNKY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJuzEXZ22lkBQM6LCh4y1IgEZIfqYj6O+vwQzeRyx3dfbDY4nOcnd8ao2MzYktmabZWbrHlZrdiX0OiCn1+BfXEOQWPeaFqKwAjoNtulfcH4TEarZdHbna84X46h3dqIpK/yo8efsEkzmYI/QxUmE3O1g4tFB3RkCObciDLMNhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=vg3vdHso; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bRQxr66b1z9smm;
	Tue, 24 Jun 2025 15:38:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750772288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=heJczSmTTnohPlRu3ndyEoGAEAX1UBzTDFy/0pevf7s=;
	b=vg3vdHso3IGdjrYqJMzhb+VqN/f1vAN+3QNFGjsgQAxcDwn0nyBAPpbWu8+DsH9mUM40h5
	frx4sVW5/tWywkEw5eETvP21b3bkWUKmQUMElFe0KM1m+KaZdn5XxMktXCFYBGhs3pfaYN
	b1Ut2BoRhaAJCovscJLeKuZkz3eWN+az/XAL9dBSGTlREAngErx3+Kg560oOQDsbniJbZH
	HFdw1UfQEoaCWphbFR5I5l2s7Zhn8yhmtxXIBeIqQl6w3AlLD33j+hT8X79sUC2rX/MaOq
	DjWCMtwEbkxMBg5BHtDQ87cjV7bwixNrHZFUwaOUBtIbr4MaqGZSNVALEqUlJA==
From: Brahmajit Das <listout@listout.xyz>
To: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	lv.zheng@intel.com,
	kees@kernel.org,
	rui.zhang@intel.com,
	len.brown@intel.com
Subject: [PATCH] ACPI / sysfs: Replace deprecated and unsafe functions with sysfs_emit
Date: Tue, 24 Jun 2025 19:07:39 +0530
Message-ID: <20250624133739.25215-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bRQxr66b1z9smm

acpi/sysfs.c has many instances of unsafe or deprecated functions such
as sprintf, strcpy. This patch relaces them with sysfs_emit to safer
alternavtive and better following of kernel API.

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 drivers/acpi/sysfs.c | 87 ++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a48ebbf768f9..c3bb7af79fcb 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -94,23 +94,23 @@ static int param_get_debug_layer(char *buffer, const struct kernel_param *kp)
 	int result = 0;
 	int i;
 
-	result = sprintf(buffer, "%-25s\tHex        SET\n", "Description");
+	result = sysfs_emit(buffer, "%-25s\tHex        SET\n", "Description");
 
 	for (i = 0; i < ARRAY_SIZE(acpi_debug_layers); i++) {
-		result += sprintf(buffer + result, "%-25s\t0x%08lX [%c]\n",
+		result += sysfs_emit(buffer + result, "%-25s\t0x%08lX [%c]\n",
 				  acpi_debug_layers[i].name,
 				  acpi_debug_layers[i].value,
 				  (acpi_dbg_layer & acpi_debug_layers[i].value)
 				  ? '*' : ' ');
 	}
 	result +=
-	    sprintf(buffer + result, "%-25s\t0x%08X [%c]\n", "ACPI_ALL_DRIVERS",
+	    sysfs_emit(buffer + result, "%-25s\t0x%08X [%c]\n", "ACPI_ALL_DRIVERS",
 		    ACPI_ALL_DRIVERS,
 		    (acpi_dbg_layer & ACPI_ALL_DRIVERS) ==
 		    ACPI_ALL_DRIVERS ? '*' : (acpi_dbg_layer & ACPI_ALL_DRIVERS)
 		    == 0 ? ' ' : '-');
 	result +=
-	    sprintf(buffer + result,
+	    sysfs_emit(buffer + result,
 		    "--\ndebug_layer = 0x%08X ( * = enabled)\n",
 		    acpi_dbg_layer);
 
@@ -122,17 +122,17 @@ static int param_get_debug_level(char *buffer, const struct kernel_param *kp)
 	int result = 0;
 	int i;
 
-	result = sprintf(buffer, "%-25s\tHex        SET\n", "Description");
+	result = sysfs_emit(buffer, "%-25s\tHex        SET\n", "Description");
 
 	for (i = 0; i < ARRAY_SIZE(acpi_debug_levels); i++) {
-		result += sprintf(buffer + result, "%-25s\t0x%08lX [%c]\n",
+		result += sysfs_emit(buffer + result, "%-25s\t0x%08lX [%c]\n",
 				  acpi_debug_levels[i].name,
 				  acpi_debug_levels[i].value,
 				  (acpi_dbg_level & acpi_debug_levels[i].value)
 				  ? '*' : ' ');
 	}
 	result +=
-	    sprintf(buffer + result, "--\ndebug_level = 0x%08X (* = enabled)\n",
+	    sysfs_emit(buffer + result, "--\ndebug_level = 0x%08X (* = enabled)\n",
 		    acpi_dbg_level);
 
 	return result;
@@ -181,11 +181,11 @@ static int param_set_trace_method_name(const char *val,
 
 	/* This is a hack.  We can't kmalloc in early boot. */
 	if (is_abs_path)
-		strcpy(trace_method_name, val);
+		sysfs_emit(trace_method_name, "%s", val);
 	else {
-		trace_method_name[0] = '\\';
-		strcpy(trace_method_name+1, val);
+		sysfs_emit(trace_method_name, "\%s", val);
 	}
+	pr_info("tracepoint: %s", trace_method_name);
 
 	/* Restore the original tracer state */
 	(void)acpi_debug_trace(trace_method_name,
@@ -255,13 +255,13 @@ static int param_set_trace_state(const char *val,
 static int param_get_trace_state(char *buffer, const struct kernel_param *kp)
 {
 	if (!(acpi_gbl_trace_flags & ACPI_TRACE_ENABLED))
-		return sprintf(buffer, "disable\n");
+		return sysfs_emit(buffer, "disable\n");
 	if (!acpi_gbl_trace_method_name)
-		return sprintf(buffer, "enable\n");
+		return sysfs_emit(buffer, "enable\n");
 	if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
-		return sprintf(buffer, "method-once\n");
+		return sysfs_emit(buffer, "method-once\n");
 	else
-		return sprintf(buffer, "method\n");
+		return sysfs_emit(buffer, "method\n");
 }
 
 module_param_call(trace_state, param_set_trace_state, param_get_trace_state,
@@ -282,7 +282,7 @@ static int param_get_acpica_version(char *buffer,
 {
 	int result;
 
-	result = sprintf(buffer, "%x\n", ACPI_CA_VERSION);
+	result = sysfs_emit(buffer, "%x\n", ACPI_CA_VERSION);
 
 	return result;
 }
@@ -366,9 +366,8 @@ static int acpi_table_attr_init(struct kobject *tables_obj,
 	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
 					 !acpi_get_table
 					 (table_header->signature, 2, &header))) {
-		snprintf(instance_str, sizeof(instance_str), "%u",
-			 table_attr->instance);
-		strcat(table_attr->filename, instance_str);
+		sysfs_emit(instance_str, "%u%s", table_attr->instance,
+			   table_attr->filename);
 	}
 
 	table_attr->attr.size = table_header->length;
@@ -687,7 +686,7 @@ static ssize_t counter_show(struct kobject *kobj,
 	    acpi_irq_not_handled;
 	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
 	    acpi_gpe_count;
-	size = sprintf(buf, "%8u", all_counters[index].count);
+	size = sysfs_emit(buf, "%8u", all_counters[index].count);
 
 	/* "gpe_all" or "sci" */
 	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
@@ -698,29 +697,29 @@ static ssize_t counter_show(struct kobject *kobj,
 		goto end;
 
 	if (status & ACPI_EVENT_FLAG_ENABLE_SET)
-		size += sprintf(buf + size, "  EN");
+		size += sysfs_emit(buf + size, "  EN");
 	else
-		size += sprintf(buf + size, "    ");
+		size += sysfs_emit(buf + size, "    ");
 	if (status & ACPI_EVENT_FLAG_STATUS_SET)
-		size += sprintf(buf + size, " STS");
+		size += sysfs_emit(buf + size, " STS");
 	else
-		size += sprintf(buf + size, "    ");
+		size += sysfs_emit(buf + size, "    ");
 
 	if (!(status & ACPI_EVENT_FLAG_HAS_HANDLER))
-		size += sprintf(buf + size, " invalid     ");
+		size += sysfs_emit(buf + size, " invalid     ");
 	else if (status & ACPI_EVENT_FLAG_ENABLED)
-		size += sprintf(buf + size, " enabled     ");
+		size += sysfs_emit(buf + size, " enabled     ");
 	else if (status & ACPI_EVENT_FLAG_WAKE_ENABLED)
-		size += sprintf(buf + size, " wake_enabled");
+		size += sysfs_emit(buf + size, " wake_enabled");
 	else
-		size += sprintf(buf + size, " disabled    ");
+		size += sysfs_emit(buf + size, " disabled    ");
 	if (status & ACPI_EVENT_FLAG_MASKED)
-		size += sprintf(buf + size, " masked  ");
+		size += sysfs_emit(buf + size, " masked  ");
 	else
-		size += sprintf(buf + size, " unmasked");
+		size += sysfs_emit(buf + size, " unmasked");
 
 end:
-	size += sprintf(buf + size, "\n");
+	size += sysfs_emit(buf + size, "\n");
 	return result ? result : size;
 }
 
@@ -885,27 +884,27 @@ void acpi_irq_stats_init(void)
 		char *name;
 
 		if (i < num_gpes)
-			sprintf(buffer, "gpe%02X", i);
+			sysfs_emit(buffer, "gpe%02X", i);
 		else if (i == num_gpes + ACPI_EVENT_PMTIMER)
-			sprintf(buffer, "ff_pmtimer");
+			sysfs_emit(buffer, "ff_pmtimer");
 		else if (i == num_gpes + ACPI_EVENT_GLOBAL)
-			sprintf(buffer, "ff_gbl_lock");
+			sysfs_emit(buffer, "ff_gbl_lock");
 		else if (i == num_gpes + ACPI_EVENT_POWER_BUTTON)
-			sprintf(buffer, "ff_pwr_btn");
+			sysfs_emit(buffer, "ff_pwr_btn");
 		else if (i == num_gpes + ACPI_EVENT_SLEEP_BUTTON)
-			sprintf(buffer, "ff_slp_btn");
+			sysfs_emit(buffer, "ff_slp_btn");
 		else if (i == num_gpes + ACPI_EVENT_RTC)
-			sprintf(buffer, "ff_rt_clk");
+			sysfs_emit(buffer, "ff_rt_clk");
 		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE)
-			sprintf(buffer, "gpe_all");
+			sysfs_emit(buffer, "gpe_all");
 		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI)
-			sprintf(buffer, "sci");
+			sysfs_emit(buffer, "sci");
 		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI_NOT)
-			sprintf(buffer, "sci_not");
+			sysfs_emit(buffer, "sci_not");
 		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR)
-			sprintf(buffer, "error");
+			sysfs_emit(buffer, "error");
 		else
-			sprintf(buffer, "bug%02X", i);
+			sysfs_emit(buffer, "bug%02X", i);
 
 		name = kstrdup(buffer, GFP_KERNEL);
 		if (name == NULL)
@@ -937,7 +936,7 @@ static void __exit interrupt_stats_exit(void)
 
 static ssize_t pm_profile_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", acpi_gbl_FADT.preferred_profile);
+	return sysfs_emit(buf, "%d\n", acpi_gbl_FADT.preferred_profile);
 }
 
 static const struct kobj_attribute pm_profile_attr = __ATTR_RO(pm_profile);
@@ -946,7 +945,7 @@ static ssize_t enabled_show(struct kobject *kobj, struct kobj_attribute *attr, c
 {
 	struct acpi_hotplug_profile *hotplug = to_acpi_hotplug_profile(kobj);
 
-	return sprintf(buf, "%d\n", hotplug->enabled);
+	return sysfs_emit(buf, "%d\n", hotplug->enabled);
 }
 
 static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1000,7 +999,7 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
 static ssize_t force_remove_show(struct kobject *kobj,
 				 struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", 0);
+	return sysfs_emit(buf, "%d\n", 0);
 }
 
 static ssize_t force_remove_store(struct kobject *kobj,
-- 
2.50.0


