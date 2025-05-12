Return-Path: <linux-acpi+bounces-13681-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99782AB320A
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFD03AE90D
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 08:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE6125A2D5;
	Mon, 12 May 2025 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Wqu4jU+G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E3225A2B7;
	Mon, 12 May 2025 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039594; cv=none; b=ScEwW81rbfPQkeRo59ucZbU8bCGQ0Arwtft45+yI5n/zQyGK+0F1cRCk6+LnUbtRCrLFKbsOZXL49RUxgjyBimdrhRNWMyk9IgWRN4+TPbICdnbP2nmc8LJ3EJnleIiFE77aawIYezS9Ep9l/MGwnU2F8/8HRud/tQpzfpLSLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039594; c=relaxed/simple;
	bh=mNrvlVy7n4m/KddWEReBiHCLsCEcSbh6FGrWwUy2B7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EB7lqTBT6zPV3OBihutujlR925lz3Lg/WAOOYyOOQUcAFvc/Jk35tL+rl6vvjFhpH2jmLjld0syXIp6oxpgoh/qnZqMT9KnG0xwzmBZFy8kekqyeX48iHhnwcxk4uyd5NVA2AS6nt0gXL1INaTgeDyCNqevGF09m0yceq6tNQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Wqu4jU+G; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54C8jqc71586901
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 12 May 2025 01:46:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54C8jqc71586901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747039563;
	bh=SJyp7okD30HInZ1fgTptAjmwrX1aqps8vhA1kdAJWhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wqu4jU+G5jmxtcMoxZU7xxTMdvYR6zp4VYJGyttTpRKojR4aUWkuBntnRPy95mMNP
	 TdZY/WjcOubxB+VWkDSGvR2bQ2PxqfaD5oWLx5oeN+NwmwkfwQIUZulba428YPa6+d
	 a4AmbXGRcZ1fxkw8DveEBEf6vdK9sioL+MwfJHOFQAN6ndlCoGnFJkOa79chbmM/8k
	 1WrQiT23ytcFJl83Qmf/PRSdkQRCO12iTFRgpvQMjzhTN1Kupv6cOH9+fDYRg2byiA
	 tWnUdW/sgtBWnr7GH/hZQsLfWNgCHqZh3Zuo+gLz+y09m/2TX32FcNb1vZHCeyNmv1
	 7DFsocyxduIZw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org
Cc: tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        rafael@kernel.org, lenb@kernel.org
Subject: [PATCH v1 3/3] x86/msr: Convert a native_wrmsr() use to native_wrmsrq()
Date: Mon, 12 May 2025 01:45:52 -0700
Message-ID: <20250512084552.1586883-4-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512084552.1586883-1-xin@zytor.com>
References: <20250512084552.1586883-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert a native_wrmsr() use to native_wrmsrq() to zap meaningless type
conversions when a u64 MSR value is splitted into two u32.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/coco/sev/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ff82151f7718..b3ce6fc8b62d 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -282,12 +282,7 @@ static inline u64 sev_es_rd_ghcb_msr(void)
 
 static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 {
-	u32 low, high;
-
-	low  = (u32)(val);
-	high = (u32)(val >> 32);
-
-	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
+	native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, val);
 }
 
 static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
-- 
2.49.0


