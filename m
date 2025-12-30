Return-Path: <linux-acpi+bounces-19907-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E95CE92EF
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 10:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AB0F302573D
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Dec 2025 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34725285068;
	Tue, 30 Dec 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="taaI2OpK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E725C27EC7C;
	Tue, 30 Dec 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086043; cv=none; b=lGuB6RYOFYGzHIrd7IJACYTlplaH7zZ7+jOptnM6rP/PmAkj7FThwB9eNCGRMbY/3MSSZa5txr59IB9aeEozajZ9hxxz0K8gxtpJJxkETynGm+cRLaxurodn2vuD+amMJ9WLuW64pKgaoGSXZgm/udlVj7hYW+Jvz3Z0kJ9shDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086043; c=relaxed/simple;
	bh=JonOw3VGLl703056/AxF+iojNf9Z4+6LQ5MG6EzxMHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/AaZLEV6Ml46/DNk7QocPR5A2A+jBizzFVzPDHsxNp44ukH+bxhjXi4K4/4G2IQTd/bHRKHvhJNFzpfzb7bjccmRev09F1XHJID7Z4yhynWyoDQPVGrzXTgafdcC0rRJMmBocdmVCgMikGbna29//v4BGV5a0lV0P2EWvO1BmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=taaI2OpK; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767086037; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GjegSgNOv/nDtEoAj2ftDZL3bA2AKQ1zkNE8Ep3evP0=;
	b=taaI2OpKwUIsbJBZD4wXth+ZPEESiI+HCgn3X4a7iq3ZKs6Q+yiFa5N2pHQ/GzMJ8WP46IEfFSNOraLqMUxDlton54Fqh+KNnSlJN7r5LIF6tNfZWL2z0zhjKk++fc8YV3RNwv2T/wraI1DmXsREX5+BDPPBpq/fzkO0p4FyHWc=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvzVBAD_1767086034 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 17:13:56 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	yazen.ghannam@amd.com,
	misono.tomohiro@fujitsu.com,
	fengwei_yin@linux.alibaba.com
Cc: tianruidong@linux.alibaba.com
Subject: [PATCH v5 17/17] trace, ras: add ARM RAS extension trace event
Date: Tue, 30 Dec 2025 17:13:53 +0800
Message-Id: <20251230091353.50626-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20251230090945.43969-1-tianruidong@linux.alibaba.com>
References: <20251230090945.43969-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a trace event for hardware errors reported by the ARMv8
RAS extension registers. userspace app can monitor this
trace event and decode error information.

Link: https://lore.kernel.org/r/20251222094351.38792-19-tianruidong@linux.alibaba.com
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/aest/aest-core.c |  6 +++
 drivers/ras/ras.c            |  3 ++
 include/ras/ras_event.h      | 71 ++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index 33e1f32c5892..9f06ac0b7c16 100644
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
index 050b49466a18..3c0ba6c02d27 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -109,6 +109,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(non_standard_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(arm_event);
+#ifdef CONFIG_ARM64_RAS_EXTN
+EXPORT_TRACEPOINT_SYMBOL_GPL(arm_ras_ext_event);
+#endif
 
 static int __init parse_ras_param(char *str)
 {
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index eaecc3c5f772..3a4a0c0e4dbe 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -377,6 +377,77 @@ TRACE_EVENT(aer_event,
 			"Not available")
 );
 #endif /* CONFIG_PCIEAER */
+
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
+#endif /* CONFIG_ARM64_RAS_EXTN */
 #endif /* _TRACE_HW_EVENT_MC_H */
 
 /* This part must be outside protection */
-- 
2.47.3


