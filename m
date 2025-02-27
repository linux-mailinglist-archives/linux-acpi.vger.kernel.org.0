Return-Path: <linux-acpi+bounces-11551-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1B9A47DF6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 13:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 297A37A8739
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 12:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39150233150;
	Thu, 27 Feb 2025 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TTBTbf3p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B4233158
	for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659842; cv=none; b=DTVVh14pi9OTt1KDuGUrvr7Y9+LsFmqcLI5rwUtPCQArOPqNDg8TzNVaevAEUociVywwoj5vM/AEAHBzI+Rlx/p+HFPbL9oCAVH0TTCdYi7Cn4YNYdlvzHW7oT8yZ+IED5cdpkTKhlxrMX/356/v3uUGr8o3WaPXi9okgZFP7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659842; c=relaxed/simple;
	bh=Q5uxxUx6KeY4zwC8bnmu7iQA3t7vZqPvLL2pQYA7C38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/t4V7d/3Gwufg96VQ/F+dVgw21/DywhETDO1Awkws83qla44T5nrBkTqext6qJ0VKZyitNQZf/h/qZfzjNm0Ni35a5InH2pYoXxaxlun6B4HzMCeFXq78js8d+qYPuisr7BInSHkqzketGCLyyba+lwsDdoCX2GvJYiwybjZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TTBTbf3p; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22185cddbffso34375895ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659840; x=1741264640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXVhLjcRoeCf2V/5WVQuQKEAR2qmhhl0hOLkmr0AsUA=;
        b=TTBTbf3p9mtat1hJOe3zuTTPvJL9QNYkfiejdQLuxo3foRymrjl6q3NvaSuNvubbz6
         lKZyeVVoOlpcIIfXDgMMfMCnfxliOYrzIKxqkN51GLfGNaDVBJYWV9SMk60h7HMAHbhR
         0VGpm5KvRUDppIElj36N1xcQd8HllUVWoiYFfKGdBHl3x1go1hAsvzOIX4bGA4ZXXOHh
         wM6aj6ZLpAJiAskOk8DLmmuhvSVGgJ0xJVh9+cQTLWQWslzViJa4SxgTgNQCIQr4ez0e
         xVHapLBSXizZLuBTcnrvfN7LKUZ0LA9TR70al96awVWiefgAOzMdekDbZSDR3uFo//TE
         y+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659840; x=1741264640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXVhLjcRoeCf2V/5WVQuQKEAR2qmhhl0hOLkmr0AsUA=;
        b=rsblGOsfBIgDftmHNFtjp2WkVZIfzuSeDv4uE1MyBbsf8Qte8TmKoRnyYKovCzuZqB
         ZSfreAvKh0V4Ud6shO86IY2bFQCSFRvrdumy34sYXmdZh4xf3meo4CvGAm+LLCbuixSP
         TzIq7oFWoo1fkxYGY/WrAHkR+xRfqmgpXCsJeVVo2G8IZkGDo59TdNUWGbpGkpsAGQHC
         XNqgZ40pwjkfuyZrN+ovro1tQNEM2fM6Pd6O4gTIABAUbalzMSIwV8GcuCKWBU3ibCMm
         G23m7G6nMZBPb2MLJR1kMbsOFBvV0hD5LZT6PmE1BMEYPojXuiWrspwdNHRZ8LdUiDbe
         DzQg==
X-Forwarded-Encrypted: i=1; AJvYcCU0cPDuf8N1BMIuW8STfC2DJF70oo8+vTdtCiaakHjcf84FFngCmgHOfhYDdjPzVQ3t7O4vFUurgKl9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+7Lt2nWdQs+TkaPfNV0PPA317f2P5MptuErNXrJOeeTc/3JG
	ly2Ly+Ij3r+bbnSGg1DKDUatq5YLuyDAJs09Ol8bznXe4c3XOt1Jlri3KPr1sqc=
X-Gm-Gg: ASbGncsVEEx7lCmN1g89Ahss5zEprnk18cA0VHb1mCLKyYWiaA0f1TM2XLjLV0eRs/j
	4BcZ3bOn+kd7A3gmdKQa6QQqBmzYtPG6tCWi2qStMYnbfK2zt6BMgfnzNiKguUp0u4dzOQs4SFJ
	4DG3yA9N16yT1HqyGkKG0rtTTgcjlca8/I2Va0EZDpSba7jfvtM9llwZlIdS0/XuM2vUEIRUYLp
	lOl2QA3FWbm7nQ3vwqDtbYFTjWp7yIH5YwS+JT4Yo5JWAy31DL6SQtJNv7FrRvkyBpelIFb6zSO
	fvhVTCrH244Gn2V6bopzV45GIbrVGF5cZDJg
X-Google-Smtp-Source: AGHT+IE/pZ3e6JonJxeQe62tq8o12LGMwm5f6Ts5InGRCEUeYVZmSfCnd9ZWVdPIH36ibrRnGp55zA==
X-Received: by 2002:a17:902:d507:b0:21f:1348:10e6 with SMTP id d9443c01a7336-2234a57fd4fmr60713595ad.13.1740659839830;
        Thu, 27 Feb 2025 04:37:19 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:19 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 08/10] riscv: Introduce HEST SSE notification handlers
Date: Thu, 27 Feb 2025 18:06:26 +0530
Message-ID: <20250227123628.2931490-9-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Functions to register a ghes entry with SSE
- Add Handlers for low/high priority events
- Call ghes common handler to handle an error event

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/ghes.c | 100 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8a1029163799..59abb89d3547 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -17,6 +17,7 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/riscv_sse.h>
 #include <linux/arm_sdei.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
@@ -97,6 +98,11 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
+#ifndef CONFIG_RISCV_SSE
+#define FIX_APEI_GHES_SSE_LOW_PRIORITY	__end_of_fixed_addresses
+#define FIX_APEI_GHES_SSE_HIGH_PRIORITY	__end_of_fixed_addresses
+#endif
+
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
@@ -1405,6 +1411,63 @@ static int apei_sdei_unregister_ghes(struct ghes *ghes)
 	return sdei_unregister_ghes(ghes);
 }
 
+#if defined(CONFIG_ACPI_APEI_SSE)
+/* SSE Handlers */
+static int __ghes_sse_callback(struct ghes *ghes,
+			       enum fixed_addresses fixmap_idx)
+{
+	if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx)) {
+		irq_work_queue(&ghes_proc_irq_work);
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+/* Low priority */
+static int ghes_sse_lo_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_lo);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_lo);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_LOW_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_lo);
+
+	return err;
+}
+
+/* High priority */
+static int ghes_sse_hi_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_hi);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_hi);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_HIGH_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_hi);
+
+	return err;
+}
+
+static int apei_sse_register_ghes(struct ghes *ghes)
+{
+	return sse_register_ghes(ghes, ghes_sse_lo_callback,
+				 ghes_sse_hi_callback);
+}
+
+static int apei_sse_unregister_ghes(struct ghes *ghes)
+{
+	return sse_unregister_ghes(ghes);
+}
+#else /* CONFIG_ACPI_APEI_SSE */
+static int apei_sse_register_ghes(struct ghes *ghes) { return -ENOTSUPP; }
+static int apei_sse_unregister_ghes(struct ghes *ghes) { return -ENOTSUPP; }
+#endif
+
 static int ghes_probe(struct platform_device *ghes_dev)
 {
 	struct acpi_hest_generic *generic;
@@ -1451,6 +1514,15 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		pr_warn(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
 			generic->header.source_id);
 		goto err;
+	case ACPI_HEST_NOTIFY_SSE:
+		if (!IS_ENABLED(CONFIG_ACPI_APEI_SSE)) {
+			pr_warn(GHES_PFX "Generic hardware error source: %d "
+				"notified via SSE is not supported\n",
+				generic->header.source_id);
+			rc = -ENOTSUPP;
+			goto err;
+		}
+		break;
 	default:
 		pr_warn(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
 			generic->notify.type, generic->header.source_id);
@@ -1514,6 +1586,18 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		if (rc)
 			goto err;
 		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		rc = apei_sse_register_ghes(ghes);
+		if (rc) {
+			pr_err(GHES_PFX "Failed to register for SSE notification"
+			       " on vector %d\n",
+			       generic->notify.vector);
+			goto err;
+		}
+		pr_err(GHES_PFX "Registered SSE notification on vector %d\n",
+		       generic->notify.vector);
+		break;
 	default:
 		BUG();
 	}
@@ -1543,7 +1627,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 static void ghes_remove(struct platform_device *ghes_dev)
 {
-	int rc;
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
 
@@ -1577,16 +1660,11 @@ static void ghes_remove(struct platform_device *ghes_dev)
 		ghes_nmi_remove(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
-		rc = apei_sdei_unregister_ghes(ghes);
-		if (rc) {
-			/*
-			 * Returning early results in a resource leak, but we're
-			 * only here if stopping the hardware failed.
-			 */
-			dev_err(&ghes_dev->dev, "Failed to unregister ghes (%pe)\n",
-				ERR_PTR(rc));
-			return;
-		}
+		apei_sdei_unregister_ghes(ghes);
+		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		apei_sse_unregister_ghes(ghes);
 		break;
 	default:
 		BUG();
-- 
2.43.0


