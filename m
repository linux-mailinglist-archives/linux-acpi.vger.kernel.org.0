Return-Path: <linux-acpi+bounces-13683-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAFEAB320E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 10:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAAFB7A9BB0
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBCC25A325;
	Mon, 12 May 2025 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="g9yE1SUI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE325A2C5;
	Mon, 12 May 2025 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039595; cv=none; b=rOukwpcWe7Iycd87KirRUqOJoOzKVcBY8dgk2wMhl7Y9uDsolorqIYD2BB4D9u1wA9/24RrwlfSO0KqsBk6IyDJj6ELO8C1qajnexOiAE1ZvcA9rk9j81gS0GmHAp6KnOCQcb/yRzGF4Rmqa4VOK4bOUFIzW/ahgO2gHDPHEY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039595; c=relaxed/simple;
	bh=Z2VWxu2V7moZYDd06BiypMThnTUdVOI8o7oiaxVEHIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Su6OKdyBxkfiJVS0Tu1Hzw7en9JCcXveakcUYwj+7M+aZHiNV6oT1hK1oh0v+PVOTMUMDijIeJyoSuEz1LOwvAO5+c8cC6PR1d+cLCrcbhjpTZ5UADjQ4v34fvem2KafCR/1J+hNOG/tM12jWGzVWBmNvKDmKaqUKLuRmdK7tOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=g9yE1SUI; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54C8jqc41586901
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 12 May 2025 01:45:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54C8jqc41586901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747039560;
	bh=7a7DioSZkOkbzgFBLNF+1MMN8PbvCPClN1vs7CkMDT4=;
	h=From:To:Cc:Subject:Date:From;
	b=g9yE1SUIh+a4/A07fhKWcikSvZS/B1o32tMs/ljMYpKNDM5Mzs8/5CLXUUzW+O2d9
	 anFCSIGiPm6lXib7pAMPfKu9y7K6kCM65jPzDHqpFTNgaiVUrnm8LLASk4DkkPleFV
	 KXWcQs4YY0htPPFfCvcSwzJaxgP0bip3uPvcLW58ILxilulgaXhzoJ3fH7rYGNjr2W
	 Jti+nP3nWugH5PAeH7DXNtt/R17RvC/pPhDLA2a7XbxaimpeGRXO4LZHZhIhz24/d8
	 76LsC0rfGbo5S8nmx6unBRR1HHW9iyGvQiDbgcMLTqL2t+jkloEdlVTsyQg+vtg+z7
	 TwX8Nrssqf2bQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org
Cc: tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        rafael@kernel.org, lenb@kernel.org
Subject: [PATCH v1 0/3] MSR fixes and cleanups after last round of MSR cleanups
Date: Mon, 12 May 2025 01:45:49 -0700
Message-ID: <20250512084552.1586883-1-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches:

1) remove a superfluous inclusion of <asm/asm.h> accidently added to
   drivers/acpi/processor_throttling.c in commit:

     efef7f184f2e ("x86/msr: Add explicit includes of <asm/msr.h>").

2) Fix uninitialized symbol 'err' introduced by:

     d815da84fdd0 ("x86/msr: Change the function type of native_read_msr_safe()").

3) Convert a native_wrmsr() use to native_wrmsrq() in
   arch/x86/coco/sev/core.c.


Xin Li (Intel) (3):
  x86/msr: Remove a superfluous inclusion of <asm/asm.h>
  x86/xen/msr: Fix uninitialized symbol 'err'
  x86/msr: Convert a native_wrmsr() use to native_wrmsrq()

 arch/x86/coco/sev/core.c            | 7 +------
 arch/x86/xen/enlighten_pv.c         | 5 ++++-
 drivers/acpi/processor_throttling.c | 1 -
 3 files changed, 5 insertions(+), 8 deletions(-)


base-commit: 9cf78722003178b09c409df9aafe9d79e5b9a74e
-- 
2.49.0


