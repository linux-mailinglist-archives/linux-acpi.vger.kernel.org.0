Return-Path: <linux-acpi+bounces-8551-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1F598F905
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Oct 2024 23:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCF01F21F26
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Oct 2024 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210221BCA0B;
	Thu,  3 Oct 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqFe/SDl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0206748D
	for <linux-acpi@vger.kernel.org>; Thu,  3 Oct 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991496; cv=none; b=oBye73fCfslYt4DaWB8U54jw4JYTOyVxU3aLzKnHTJnEuOlhR2JB7AfDMQEGy4rpfpKUqZITHfMkhzt3Rot8YZrVnVSTF7X3xG9xA0XICNDsInUvOOAUtFdA5sLr5MqOnEJPAktRAAUHD3PEwrhuSlrGLV+6v4yi7fQ20Tr7Ps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991496; c=relaxed/simple;
	bh=RlBKs3fi93hQ4cXtxKh8uFwzSPAvsmdE+3peIcygRjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvK2cQS1a+i3/iWtdr7bEROai8fUujeVHUrw7SZ/fbkN9g31BEF8+4a/7MwKzyeAvUht88cygw5oG24H2UspAQvB1sQWAwsZVan67iwn8rwWGVzrf4Y9k3Z1gapvo7CXzgayyYM+LF9v5wtdifcs1NitAJxw8Eu2QlaqNkbvRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqFe/SDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D313C4CECC;
	Thu,  3 Oct 2024 21:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727991495;
	bh=RlBKs3fi93hQ4cXtxKh8uFwzSPAvsmdE+3peIcygRjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JqFe/SDlbiIVDwKFJDLmrKqt7xUQLjQbd1J1KoCMemP70nqvREEC95YaR7sqde5iE
	 DO4Ii8tbvyWeut2Yk7HGyAEMErqahipA3iWrQkNbuLmmPaZEDSL2ywv70I1DgLGQc1
	 zjNjDngFkCNU61DoWqTrIjwMd++XPZA8pETPgsM8/9nuKl11dZPvkQZlUF4yPkGtxV
	 yfjqqtxmBBPImHz9zgwXGHorOhGIREOZMMRgGMD9l2Cjay4PfU7ZQVNCfzth0d6uqi
	 lWb3vzqPOn3wpe9wjU9SCmttPnm4c9w8swsfvTLvI0oj0tuv8S7ZzlW4/ucaY1PVu5
	 NCMkA/lDVP6uQ==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-acpi@vger.kernel.org,
	Perry Yuan <perry.yuan@amd.com>,
	gautham.shenoy@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] x86/cpufeatures: Add feature bits for AMD heterogeneous processor
Date: Thu,  3 Oct 2024 16:37:58 -0500
Message-ID: <20241003213759.3038862-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003213759.3038862-1-superm1@kernel.org>
References: <20241003213759.3038862-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Perry Yuan <perry.yuan@amd.com>

CPUID leaf 0x80000026 advertises core types with different efficiency
rankings.

Bit 30 indicates the heterogeneous core topology feature, if the bit
set, it means not all instances at the current hierarchical level have
the same core topology.

This is described in the AMD64 Architecture Programmers Manual Volume
2 and 3, doc ID #25493 and #25494.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dd4682857c12..cea1ed82aeb4 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -473,6 +473,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
+#define X86_FEATURE_HETERO_CORE_TOPOLOGY	(21*32 + 6) /* Heterogeneous Core Topology */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index c84c30188fdf..3bba55323163 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -52,6 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_HETERO_CORE_TOPOLOGY,	CPUID_EAX,  30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.43.0


