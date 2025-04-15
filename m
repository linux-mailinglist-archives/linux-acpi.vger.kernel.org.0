Return-Path: <linux-acpi+bounces-13058-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E43A8A610
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 19:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8437189C948
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 17:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D6D221DB3;
	Tue, 15 Apr 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dsfkW43b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B10221549;
	Tue, 15 Apr 2025 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739684; cv=none; b=hSqbbO1ZHcxAwgZUUkYLE5h/A9oJbEd/H6crAZrnYMOeGwb7H1ZQfi0pePcnd3z8MZv4dR53ePu/knG1zf1ZAVrC5hG4WoQET5WqQoPR2VXkxyzYCxllRaYkOYw2hwUgxbcXQnKrHIbo//U624tlimGEOSYoc8W2hN47M116giI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739684; c=relaxed/simple;
	bh=zwTEBnJd9gMAF72E5g6VevBq496UtLA8Rm+5AjpFEis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mij0a3mq6zw7oGnv/81Y1Ovi+cEr/t5S0eOIGeyvvdvHjBMj5Q6qkNJG5gNDHrYIx6FlFCns4fgTgY/9wA1Tn2Ehi3tcSTFDqo6v0rylOfu2S18jQMvw01kwlmDmtNciudkHIpH2agFhHG7iAlptQr87jcvqZ5k32z5pF1Nqofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=dsfkW43b; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53FHsB8F2944048
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 15 Apr 2025 10:54:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53FHsB8F2944048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1744739656;
	bh=qNBN74OQ76/tVgBKaHsIn5jkMpB4T44AbqMUmkAqvrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dsfkW43by4nPbmLMVWXcjFkznLmY9V+0yY2k7734IXLp4qkKv2TfxZChY7N8Amyh+
	 uJZzwb9tvxaehX3uQpqumAqyJrHOSRXEttbWpEUxqiCSipD+T8Yl29i+pkGkB6RLY0
	 73eKDUD89rmrofJ4jTX+gRssupqB3TzpQSZTvlONRmRbFpR46OUp8UURlVCw0az85V
	 6PrHHG4kdwwlt1g6emR2UeoBlTbYb7POHWlA1o5+uRdEBS5KcjhyM0Kwm6WW8/1GZb
	 8S9s55/YkmXn3W4rqU+OFyTmqIZ21V5PpGM39MMl7PoqdD0WZ9v8h7CVXdcmqsqm3X
	 3KRTihuYWzkEQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org
Subject: [PATCH v1 1/3] x86/cpufeatures: Clean up formatting
Date: Tue, 15 Apr 2025 10:54:08 -0700
Message-ID: <20250415175410.2944032-2-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415175410.2944032-1-xin@zytor.com>
References: <20250415175410.2944032-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

It is a special file with special formatting so remove one whitespace
damage and format newer defines like the rest.

No functional changes.

 [ Xin: Do the same to tools/arch/x86/include/asm/cpufeatures.h. ]

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/cpufeatures.h       | 20 ++++++++++----------
 tools/arch/x86/include/asm/cpufeatures.h | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index e8f8d43a3825..60b4a4c00491 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -477,10 +477,10 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
-#define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
-#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
-#define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
-#define X86_FEATURE_PREFER_YMM		(21*32 + 8) /* Avoid ZMM registers due to downclocking */
+#define X86_FEATURE_AMD_FAST_CPPC	(21*32+ 5) /* Fast CPPC */
+#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32+ 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */
+#define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 
 /*
  * BUG word(s)
@@ -527,10 +527,10 @@
 #define X86_BUG_TDX_PW_MCE		X86_BUG(31) /* "tdx_pw_mce" CPU may incur #MC if non-TD software does partial write to TDX private memory */
 
 /* BUG word 2 */
-#define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* "srso" AMD SRSO bug */
-#define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* "div0" AMD DIV0 speculation bug */
-#define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
-#define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
-#define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
-#define X86_BUG_SPECTRE_V2_USER		X86_BUG(1*32 + 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
+#define X86_BUG_SRSO			X86_BUG( 1*32+ 0) /* "srso" AMD SRSO bug */
+#define X86_BUG_DIV0			X86_BUG( 1*32+ 1) /* "div0" AMD DIV0 speculation bug */
+#define X86_BUG_RFDS			X86_BUG( 1*32+ 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
+#define X86_BUG_BHI			X86_BUG( 1*32+ 3) /* "bhi" CPU is affected by Branch History Injection */
+#define X86_BUG_IBPB_NO_RET		X86_BUG( 1*32+ 4) /* "ibpb_no_ret" IBPB omits return target predictions */
+#define X86_BUG_SPECTRE_V2_USER		X86_BUG( 1*32+ 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 8e3cee73917c..44b66945554d 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -477,10 +477,10 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
-#define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
-#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
-#define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
-#define X86_FEATURE_PREFER_YMM		(21*32 + 8) /* Avoid ZMM registers due to downclocking */
+#define X86_FEATURE_AMD_FAST_CPPC	(21*32+ 5) /* Fast CPPC */
+#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32+ 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */
+#define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 
 /*
  * BUG word(s)
@@ -527,10 +527,10 @@
 #define X86_BUG_TDX_PW_MCE		X86_BUG(31) /* "tdx_pw_mce" CPU may incur #MC if non-TD software does partial write to TDX private memory */
 
 /* BUG word 2 */
-#define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* "srso" AMD SRSO bug */
-#define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* "div0" AMD DIV0 speculation bug */
-#define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
-#define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
-#define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
-#define X86_BUG_SPECTRE_V2_USER		X86_BUG(1*32 + 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
+#define X86_BUG_SRSO			X86_BUG( 1*32+ 0) /* "srso" AMD SRSO bug */
+#define X86_BUG_DIV0			X86_BUG( 1*32+ 1) /* "div0" AMD DIV0 speculation bug */
+#define X86_BUG_RFDS			X86_BUG( 1*32+ 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
+#define X86_BUG_BHI			X86_BUG( 1*32+ 3) /* "bhi" CPU is affected by Branch History Injection */
+#define X86_BUG_IBPB_NO_RET		X86_BUG( 1*32+ 4) /* "ibpb_no_ret" IBPB omits return target predictions */
+#define X86_BUG_SPECTRE_V2_USER		X86_BUG( 1*32+ 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
 #endif /* _ASM_X86_CPUFEATURES_H */
-- 
2.49.0


