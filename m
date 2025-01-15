Return-Path: <linux-acpi+bounces-10676-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BB5A11C4B
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 09:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB408188415A
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B711E7C30;
	Wed, 15 Jan 2025 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eR+4nySI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE41E7C23;
	Wed, 15 Jan 2025 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930588; cv=none; b=MSOKbOiaMX8+LM2j8gIHXicG3S/2NZHMl28P9LShOMsSyi4Sfk9vOkqaM3dzEu2cUqhityQuRi0/kH2KjzwFoOuv96uPOQu429AsLexuu4sVtELAxCspkqER/tc2f7tZjfSQvSZwBS9pFrjDgV/FcCIFaJIAnNkayiRGfx3LTGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930588; c=relaxed/simple;
	bh=dJvSJ5GhLVgfGFu1kZzq2w6pFKJT8xaVGhSpMC50ykQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SxTrJP3MoN9/zvPGCOdkOLG64ZFBxZZlxQZy37YNuRsoWvM5nIo38OqjfzNQiBIhBmmy2QOCvE1DaOvhCMoYNqFaGwvzfwT0RmCt0sU6dqFj/q9xX06ZZtzmOpOcja+NGEDl3XDmxybHCS9cCxumV3tDyNkxxJpVF2MFKVYnicU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eR+4nySI; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736930583; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QaUPRHEfNCFEmwu3vevftKoNk75hQNFopCX45O+gSAs=;
	b=eR+4nySImCa7UZuQelO/QPnEClh9dym7Nh9D3clVMl6pDXUbsZS2LlGeIxnHbQQmn6MTUc1BipuZrJkglx1JLRc5MvNRGPEekupQrLrW3DnKNsTG5xvkYKW2cQmsUQfZoSraG9kLE0Mcutg5zS/H6xXuTRlnMugyu1m70Ph2nCM=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WNhzKe1_1736930580 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 16:43:03 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	yazen.ghannam@amd.com
Cc: tianruidong@linux.alibaba.com,
	Tyler Baicar <baicar@os.amperecomputing.com>
Subject: [PATCH v3 5/5] trace, ras: add ARM RAS extension trace event
Date: Wed, 15 Jan 2025 16:42:28 +0800
Message-Id: <20250115084228.107573-6-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
References: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a trace event for hardware errors reported by the ARMv8
RAS extension registers.

Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/acpi/arm64/aest.c    |  2 +
 drivers/ras/aest/aest-core.c |  6 +++
 drivers/ras/ras.c            |  3 ++
 include/ras/ras_event.h      | 71 ++++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
index 312ddd5c15f5..adc12174f4e0 100644
--- a/drivers/acpi/arm64/aest.c
+++ b/drivers/acpi/arm64/aest.c
@@ -11,6 +11,8 @@
 
 #include "init.h"
 
+#include <ras/ras_event.h>
+
 #undef pr_fmt
 #define pr_fmt(fmt) "ACPI AEST: " fmt
 
diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 0530880ded3e..e72df9a79b96 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -13,6 +13,8 @@
 #include <linux/genalloc.h>
 #include <linux/ras.h>
 
+#include <ras/ras_event.h>
+
 #include "aest.h"
 
 DEFINE_PER_CPU(struct aest_device, percpu_adev);
@@ -90,6 +92,10 @@ static void aest_print(struct aest_event *event)
 		pr_err("%s  ERR%dMISC3: 0x%llx\n", pfx_seq, index,
 						regs->err_misc[3]);
 	}
+
+	trace_arm_ras_ext_event(event->type, event->id0, event->id1,
+				event->index, event->hid, &event->regs,
+				event->vendor_data, event->vendor_data_size);
 }
 
 static void aest_handle_memory_failure(u64 addr)
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index e5f23a8279c2..2a5a440e4c29 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -72,6 +72,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(non_standard_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(arm_event);
+#ifdef CONFIG_ARM64_RAS_EXTN
+EXPORT_TRACEPOINT_SYMBOL_GPL(arm_ras_ext_event);
+#endif
 
 static int __init parse_ras_param(char *str)
 {
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index e5f7ee0864e7..119e8c4e6d20 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -338,6 +338,77 @@ TRACE_EVENT(aer_event,
 			"Not available")
 );
 
+/*
+ * ARM RAS Extension Events Report
+ *
+ * This event is generated when an error reported by the ARM RAS extension
+ * hardware is detected.
+ */
+
+#ifdef CONFIG_ARM64_RAS_EXTN
+#include <asm/ras.h>
+TRACE_EVENT(arm_ras_ext_event,
+
+	TP_PROTO(const u8 type,
+		 const u32 id0,
+		 const u32 id1,
+		 const u32 index,
+		 char *hid,
+		 struct ras_ext_regs *regs,
+		 const u8 *data,
+		 const u32 len),
+
+	TP_ARGS(type, id0, id1, index, hid, regs, data, len),
+
+	TP_STRUCT__entry(
+		__field(u8,  type)
+		__field(u32, id0)
+		__field(u32, id1)
+		__field(u32, index)
+		__field(char *, hid)
+		__field(u64, err_fr)
+		__field(u64, err_ctlr)
+		__field(u64, err_status)
+		__field(u64, err_addr)
+		__field(u64, err_misc0)
+		__field(u64, err_misc1)
+		__field(u64, err_misc2)
+		__field(u64, err_misc3)
+		__field(u32, len)
+		__dynamic_array(u8, buf, len)
+	),
+
+	TP_fast_assign(
+		__entry->type = type;
+		__entry->id0 = id0;
+		__entry->id1 = id1;
+		__entry->index = index;
+		__entry->hid = hid;
+		__entry->err_fr = regs->err_fr;
+		__entry->err_ctlr = regs->err_ctlr;
+		__entry->err_status = regs->err_status;
+		__entry->err_addr = regs->err_addr;
+		__entry->err_misc0 = regs->err_misc[0];
+		__entry->err_misc1 = regs->err_misc[1];
+		__entry->err_misc2 = regs->err_misc[2];
+		__entry->err_misc3 = regs->err_misc[3];
+		__entry->len = len;
+		memcpy(__get_dynamic_array(buf), data, len);
+	),
+
+	TP_printk("type: %d; id0: %d; id1: %d; index: %d; hid: %s; "
+		  "ERR_FR: %llx; ERR_CTLR: %llx; ERR_STATUS: %llx; "
+		  "ERR_ADDR: %llx; ERR_MISC0: %llx; ERR_MISC1: %llx; "
+		  "ERR_MISC2: %llx; ERR_MISC3: %llx; data len:%d; raw data:%s",
+		  __entry->type, __entry->id0, __entry->id1, __entry->index,
+		  __entry->hid, __entry->err_fr, __entry->err_ctlr,
+		  __entry->err_status, __entry->err_addr, __entry->err_misc0,
+		  __entry->err_misc1, __entry->err_misc2, __entry->err_misc3,
+		  __entry->len,
+		  __print_hex(__get_dynamic_array(buf), __entry->len))
+);
+#endif
+
 /*
  * memory-failure recovery action result event
  *
-- 
2.33.1


