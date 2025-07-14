Return-Path: <linux-acpi+bounces-15145-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD2B045F7
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 18:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688C0162385
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jul 2025 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CA025F7A4;
	Mon, 14 Jul 2025 16:57:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C50259C92;
	Mon, 14 Jul 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512266; cv=none; b=KjzntsNUBrr//VxCcx1y3JPvPMjJxbmkmvvY0RZwFozuDX9t1/++Ipl2FJ7ZxZ4hkB5rjQtxFqsI+Opc96vHMdUeOoF/GddkJl1NI8cbNS3wMq1CHAbsgfbrjnYf4Yi5kUTuABvzMEg33wfS2Q3v0gjhmvWf8X+ECfd6QKlWCi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512266; c=relaxed/simple;
	bh=eKAdqCDO003fP3K1uBEK4504ZrmN+ncMJaYNVcw8ZcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GEtF1m98LuytZyDUnaMz2XeroDT2jS6crk6wLoZM2VZV+IVYg8O6k2tF2ebdzm0a7T/5dXdJ9sIYEH7Dqxs5PNM7hJHiUuoi+VQzOrYgk1ZTyBaVq4D5bx1UsTyZ1KJ+kM828mOKHzRXOH1sUjbitoSKkEP02/+GVVSsdFXYHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so7464651a12.3;
        Mon, 14 Jul 2025 09:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752512263; x=1753117063;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPJZVawJT7CPGnMAptYuh6EKT+rETkMW0bHZBhmJAVo=;
        b=r1Ny2Co1kMG6Jsi6ZaiftiK3cMRSn/lH8JNl72AFtu5HiBHblOCjL4LeQmoeaJ89RF
         PkP7KeITo3TWm+7xu5L2HlMtv4W0wrTmZ7VJdTsx/96yjp5bTnAynckfTMa2u/zq8Ij3
         8Ozpy6gZyMJQXmDyUS23S6YNEr6AciPQSvrzRamMaTcMitcGljmMbn0DFwZy98c+GHBP
         KSApywBUINF6u7b4+ob8oCMXPQUL90f1FyhYfyUHzDai6gtwwHoflcKDm4ljzqOSUIJE
         Ygnn6A2c+y2laBAO5RSKaBJHHELPzS7lErI65+0j9uQ/xcMIcMDeFv6RFS9lmnEqSF92
         d6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXc0vdAKI0GtkYtGyjZt4Ce7grOM7CSL6TK3eAEUOrpk4avbNqMsS7PpVDjatKyMc6rDK522c3n5zlFW/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbqm5HRXhH68HDgj62WkSWGPuQ109eLwX1no1ylm4NKMToOgN1
	aKnfcgCJ9i91AAO7IvUlA56HRzn9fsv3aAeDQdcHluZDGjOL4fV74Fdz
X-Gm-Gg: ASbGncvWs7h8gFcCcCl1a7V8aKhrE5ob6cPFYAdOef7+ItudFmCJwNrvVGQaK+BS2CR
	999uqk+MR43cjVZ+lNZ9GNkGr6dKy+eYX7IunnY6eeAAFCNSZo32xJ8qdanAGg2kMPp3RwkHR7s
	wVaHBNck7yWVtM7l8XGNLQ1g5LXvjQqtvbNAYNXVPNLee4IoO+VGJkwQ4VhqxW51QWLivoChMiz
	kvmyqO5ZM16WYRfWbcPaU4ycg8MMZwVB8zrsHcjg2krWBi5ab1NQZbxmIRuDFP5HBTDop1UQp26
	QMHdzUdzW/wLxJSPWiGuNcaNMbfGEOgRKJS9iOeZLyXC2hOfc3ohJVNHc1qD1nHy/gVruDccbfk
	K0EnLo259qV6wqoQ+YAuPNb4=
X-Google-Smtp-Source: AGHT+IH4+NoV/k8BNZ35hPnNGpYGLhQAWXWvnEspzGRclmJEYNu1kq5VOlTvVPxMTFvfJc9CL5J7MQ==
X-Received: by 2002:a50:d791:0:b0:606:a77b:cca3 with SMTP id 4fb4d7f45d1cf-611e7611eacmr10110799a12.7.1752512262565;
        Mon, 14 Jul 2025 09:57:42 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9523a75sm6344787a12.25.2025.07.14.09.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:57:42 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Jul 2025 09:57:29 -0700
Subject: [PATCH] ghes: Track number of recovered hardware errors
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
X-B4-Tracking: v=1; b=H4sIAPk2dWgC/x3MQQqDMBAF0KsMf20gjm3EXEWKSDqts6iRCWghe
 HfBd4BXUcRUCiJVmOxaNK+I1DaEtMzrV5y+EQns+el737v9l7LJtByTmGVzHfODBwmpawMawmb
 y0f89jq/zvADoaEhfYQAAAA==
X-Change-ID: 20250707-vmcore_hw_error-322429e6c316
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3762; i=leitao@debian.org;
 h=from:subject:message-id; bh=eKAdqCDO003fP3K1uBEK4504ZrmN+ncMJaYNVcw8ZcQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBodTcFDimZ8jCGBcMTxwoApHwIhC39Iq5RcmAtn
 Ixt2kenafqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHU3BQAKCRA1o5Of/Hh3
 bWdgD/9usBjWL6yAM7Z4+a0pJhupguVwDbO7Ajuv0qnSue+UfuBWehu3+VUikW9YzKBx8nk7zZQ
 PquRK0hPe0d+fpkgWFCkB2AdM5WP5x0ziGV7xIMO1KGcCm65faZmrVdv9Acq5Dw0J6/QbJ5ha1g
 Fno6UkGDx2LBrnpPqJysDJGLgs5YOMvMvOE/b8IlBqDvfthEzCZMpE9V3s1goC5r9Rc/ZGq0UmW
 NSF30HNRlLTI8Q4izitvyu5YK4WTsqbWXsKxzzi4setbxBgC8B1y5/mNMoMF2fOmD9ZTxE/cOV/
 yHwPp5JShRE7GACYfivm2vjsdvGIs+GL670H8lnjZ2nRxuTr+2zdoy5Vx5Og8gGRF4525TNrYX+
 wxPOMG2M2+l8TbpLoXVsvnD/3pRI6gxC/Jy6ej795+TBVcY+1M0F7Js4SG7tIi+tY4v21FokiME
 wtuhfNnyEN3omcjt58VTrlJ0gAWEHZP7mo/2VUMEShmk9kxOmTYV1ihX/kn2B5HG++MIaqi1gAb
 8trbB697DBWJ3I9tA2P+MD+ORqmOdeGOTL6cHHkonjH2WGFM7lCIZTO9yf5f4AKQQSd3r8TcuWK
 hi7T3q2LTYwfka23pT9yf+5dIfHTG2U4PN1bnB+wkuLv4uCAcbwL+ET0Pvpk162gC15BEXQShZI
 5+YS0zxpX3Llyeg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a global variable, ghes_recovered_erors, to count hardware errors
classified as recoverable or corrected. This counter is exported and
included in vmcoreinfo for post-crash diagnostics.

Tracking this value helps operators potentially correlate hardware
errors across system events and crash dumps, indicating that RAS logs
might be useful while analyzing these crashes. This discussion and
motivation could be found in [1].

Atomic operations are deliberately omitted, as precise accuracy is not
required for this metric.

Link: https://lore.kernel.org/all/20250704-taint_recovered-v1-0-7a817f2d228e@debian.org/#t [1]
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/apei/ghes.c | 15 +++++++++++++--
 include/acpi/ghes.h      |  2 ++
 kernel/vmcore_info.c     |  4 ++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f0584ccad4519..3735cfba17667 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -118,6 +118,12 @@ static inline bool is_hest_sync_notify(struct ghes *ghes)
 	return notify_type == ACPI_HEST_NOTIFY_SEA;
 }
 
+/* Count the number of hardware recovered errors, to be reported at
+ * crash/vmcore
+ */
+unsigned int ghes_recovered_erors;
+EXPORT_SYMBOL_GPL(ghes_recovered_erors);
+
 /*
  * This driver isn't really modular, however for the time being,
  * continuing to use module_param is the easiest way to remain
@@ -1100,13 +1106,16 @@ static int ghes_proc(struct ghes *ghes)
 {
 	struct acpi_hest_generic_status *estatus = ghes->estatus;
 	u64 buf_paddr;
-	int rc;
+	int rc, sev;
 
 	rc = ghes_read_estatus(ghes, estatus, &buf_paddr, FIX_APEI_GHES_IRQ);
 	if (rc)
 		goto out;
 
-	if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
+	sev = ghes_severity(estatus->error_severity);
+	if (sev == GHES_SEV_RECOVERABLE || sev ==  GHES_SEV_CORRECTED)
+		ghes_recovered_erors += 1;
+	else if (sev >= GHES_SEV_PANIC)
 		__ghes_panic(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);
 
 	if (!ghes_estatus_cached(estatus)) {
@@ -1750,6 +1759,8 @@ void __init acpi_ghes_init(void)
 		pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit.\n");
 	else
 		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
+
+	ghes_recovered_erors = 0;
 }
 
 /*
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index be1dd4c1a9174..4b6be6733f826 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -75,6 +75,8 @@ void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 struct list_head *ghes_get_devices(void);
 
 void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
+
+extern unsigned int ghes_recovered_erors;
 #else
 static inline struct list_head *ghes_get_devices(void) { return NULL; }
 
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index e066d31d08f89..cb2a7daef3a68 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -14,6 +14,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <acpi/ghes.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -223,6 +224,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(kallsyms_offsets);
 	VMCOREINFO_SYMBOL(kallsyms_relative_base);
 #endif /* CONFIG_KALLSYMS */
+#ifdef CONFIG_ACPI_APEI_GHES
+	VMCOREINFO_NUMBER(ghes_recovered_erors);
+#endif
 
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250707-vmcore_hw_error-322429e6c316

Best regards,
--  
Breno Leitao <leitao@debian.org>


