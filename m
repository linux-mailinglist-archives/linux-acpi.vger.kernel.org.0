Return-Path: <linux-acpi+bounces-13057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC983A8A60F
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 19:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09011177ACC
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 17:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D16E22171E;
	Tue, 15 Apr 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EyM7S8PJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F420DF4;
	Tue, 15 Apr 2025 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739684; cv=none; b=LZSJZbZnqTMumW4dhFi+bdyva+ThEW54oZbcPvpCGbJ5JF5ZQqvXrx1a7Xc+xhq6VyNnbuVIBOLJhPB+NIU0rmFpxI0SnsAG68HzKEjmohGK1tJjHXTiNNDsnL09S3Mbitb7kHLY6LHvQPNmxPOkA1j9UVtMgBHkeIud6E2IaBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739684; c=relaxed/simple;
	bh=sgTxui1Pq5485fxmXzQHQ03jEJSCpP7ydFwpvhxB9Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SV6WNHPMi6rKixDbgKzZOCo4at8FBuQ0TW2QtfM7/vI6R0M+E1a1Y6mhARABMhKxUPkG0xbziUKwLVSPSnLSldbjbZESDry6YvKk/U4gAbpgV9tPadQCxLgB253NQ+Zl2pnN299QPflY1yuN4Zqgl0AEqo+mGlevUTj1iGc90XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=EyM7S8PJ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53FHsB8E2944048
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 15 Apr 2025 10:54:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53FHsB8E2944048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1744739655;
	bh=QUAIsrR+KIDAFumJFsQCqaC9MbA5g/ZWUzIgWD8zGPI=;
	h=From:To:Cc:Subject:Date:From;
	b=EyM7S8PJiM7ipZCm60FbRItqrJUSyhapH46bkxlJv6dM91R/HxkGqUydIgHU2HoPu
	 xe5+7TsG7Fy3soD7ox9yOF0apQie2ZUOWNKoS7VPa22TEKHwzK+gOZ5XCGE9S0/bSE
	 LbDl96ojHFum2686uGaDEy4AMEYlIfSmgE2hiOgv3T2C532MAEc2Lu67aeC83zsxc3
	 DkgHn7HpN1wm0LSPBp41xuzdKt517PWNi/kVx4r3OYAajiPhkoRgcmXcxX67uIjipH
	 JyKYjv0ieh30+lPexHwpIP+VILLQr6LN4AZa5bybTFYhQTg2R8tJ28qg3AWGODVZra
	 MSQdnBaSbZoEA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org
Subject: [PATCH v1 0/3] x86/cpufeatures: Clean up formatting
Date: Tue, 15 Apr 2025 10:54:07 -0700
Message-ID: <20250415175410.2944032-1-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header arch/x86/include/asm/cpufeatures.h is a special file with
special formatting so shorten long named macros and remove whitespace
damages to format newer defines like the rest.


Borislav Petkov (AMD) (1):
  x86/cpufeatures: Clean up formatting

Xin Li (Intel) (2):
  x86/cpufeatures: Shorten X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT to
    X86_FEATURE_CLEAR_BHB_LOV
  x86/cpufeatures: Shorten X86_FEATURE_AMD_HETEROGENEOUS_CORES to
    X86_FEATURE_AMD_HTR_CORES

 arch/x86/include/asm/cpufeatures.h       | 22 +++++++++++-----------
 arch/x86/include/asm/nospec-branch.h     |  2 +-
 arch/x86/kernel/acpi/cppc.c              |  2 +-
 arch/x86/kernel/cpu/bugs.c               |  6 +++---
 arch/x86/kernel/cpu/scattered.c          |  2 +-
 arch/x86/kernel/cpu/topology_amd.c       |  2 +-
 tools/arch/x86/include/asm/cpufeatures.h | 22 +++++++++++-----------
 7 files changed, 29 insertions(+), 29 deletions(-)


base-commit: b4d2bada09b17fcd68a0f00811ca7f900ec988e6
-- 
2.49.0


