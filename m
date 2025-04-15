Return-Path: <linux-acpi+bounces-13059-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017E5A8A613
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 19:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B5A189C9F9
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 17:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC7E2222C6;
	Tue, 15 Apr 2025 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="k+bZBH17"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22822156E;
	Tue, 15 Apr 2025 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739685; cv=none; b=KjPtMBSpWVsfEkCORSeiJXNPC+87ISLiKmDluptEc4WnJsQL7HJt67zJrdbkqQZ0A+g02IwK8NvqQQXSrJHoGAkhYsjV2KeaVh/8FKiWS2EayqH9jbpJO/PTp5kFB3X6xKYKCz1yQsgC8KBeUTQLkYyWUGH8rJKqLZPaM+mmzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739685; c=relaxed/simple;
	bh=M+zMviKzedpyVcUTanxcykOCPMJsS7KL0KSQCYg8Kn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ea4ULHa+AR8A3UVmhnzxEhBFer3u2qRn6fhflV43CMHiXuke/2/Uo4rzx+X9fQYCsz2HjVl76wqJS4j0diAZ1dLSahsBqfqrRWhHSZJHloTkNefYu3zqzGiyfCjkVuLhUXRgJtmjqAjMZ0zE71xhn/RzpZQHrKuAS4DQ0/kYwSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=k+bZBH17; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53FHsB8G2944048
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 15 Apr 2025 10:54:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53FHsB8G2944048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1744739657;
	bh=tB/i++ogWetfPnrNw35a9ccDCKCDYyDO4rRLp7+W6k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+bZBH17/cDtAXFIke/gNrrGd7JAptWesJ9ZEefAl32UZF2agBNU3358kEj9gkweq
	 J4CkpWBxQF4KllnmfTmXTnIIdmADZ4h8ZDKphZ6altgm/AZu8Oje8ez12I8W5TCw/s
	 01iIfp9XwS0qOFTB+s3NmtcTVeU7N0dKa8eCBt6D7GyODZnzhVAK3J5g77+Ksa6y4+
	 Y4Y2WkQIelodn6MQsJik8deivHDFWQgSr/pc/mzy/10w8NqR1FTr1dSzg090l+22pN
	 C6ndR2zXz+Rvt0px+JUnJ25O9qQ/rf+3JGOFITbEPVUZdAM+Dbu6abJd8Pwyh0J9ol
	 3sT+4KJJGh58Q==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org
Subject: [PATCH v1 2/3] x86/cpufeatures: Shorten X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT to X86_FEATURE_CLEAR_BHB_LOV
Date: Tue, 15 Apr 2025 10:54:09 -0700
Message-ID: <20250415175410.2944032-3-xin@zytor.com>
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

Shorten X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT to X86_FEATURE_CLEAR_BHB_LOV
to make the last column aligned consistently in the whole file.

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/cpufeatures.h       | 2 +-
 arch/x86/include/asm/nospec-branch.h     | 2 +-
 arch/x86/kernel/cpu/bugs.c               | 6 +++---
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 60b4a4c00491..78d0fd7dd690 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -476,7 +476,7 @@
 #define X86_FEATURE_CLEAR_BHB_LOOP	(21*32+ 1) /* Clear branch history at syscall entry using SW loop */
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
-#define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_CLEAR_BHB_LOV	(21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32+ 5) /* Fast CPPC */
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32+ 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 5c43f145454d..492beefeaf2e 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -327,7 +327,7 @@
 .endm
 
 .macro CLEAR_BRANCH_HISTORY_VMEXIT
-	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT
+	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_LOV
 .endm
 #else
 #define CLEAR_BRANCH_HISTORY
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0e120da17414..0e355f633f77 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1703,13 +1703,13 @@ static void __init bhi_select_mitigation(void)
 
 	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
 		pr_info("Spectre BHI mitigation: SW BHB clearing on VM exit only\n");
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOV);
 		return;
 	}
 
 	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall and VM exit\n");
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
+	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOV);
 }
 
 static void __init spectre_v2_select_mitigation(void)
@@ -2852,7 +2852,7 @@ static const char *spectre_bhi_state(void)
 		 !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE) &&
 		 rrsba_disabled)
 		return "; BHI: Retpoline";
-	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOV))
 		return "; BHI: Vulnerable, KVM: SW loop";
 
 	return "; BHI: Vulnerable";
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 44b66945554d..3e04290131d7 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -476,7 +476,7 @@
 #define X86_FEATURE_CLEAR_BHB_LOOP	(21*32+ 1) /* Clear branch history at syscall entry using SW loop */
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
-#define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_CLEAR_BHB_LOV	(21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32+ 5) /* Fast CPPC */
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32+ 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */
-- 
2.49.0


