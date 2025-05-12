Return-Path: <linux-acpi+bounces-13684-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D596EAB3216
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 10:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0492418871C1
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF8125A2B8;
	Mon, 12 May 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bmWYvnwx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B7259CB8;
	Mon, 12 May 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039607; cv=none; b=CidgXhzMVtGpoKpTgsCLxCYFQL0sDNgIfsDHktDbsNjOS1KJ8DGnRA3lb0Z5TeTaXqhoPzAVYNH++fxf1BumneSHKX1X3Vojuey7AEQy5AEPPOviBeReJe323c746XsKFuu9TJFlUYqwgNk5aiXV4/rWj3uSEGH5M78Ke9D3yqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039607; c=relaxed/simple;
	bh=7rbfKiTxV4TmgxsREEclgvq00JGTvcvzpLtxrb7oD+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpXelDSqlDRtmdEf9ywPBDy1CsLDd0OuanTk92guqk7n6oyhn07HS7dpmDjiqMc7MRrvvI7E3dnx7ylperK+L4lt4NsLcVPd2WQG3g/PpAsqlV3txv+oFArB5HnRb2DIu+f7cdvWQGO74tPw6b+HgRw2MpOPyFIORMX/gjeBxS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bmWYvnwx; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54C8jqc61586901
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 12 May 2025 01:46:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54C8jqc61586901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747039562;
	bh=r60JlXTos4KUiP7BNV4Mubm1J2LcZX1eO8iTOKbeekU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmWYvnwxTU0pVJW4u5KvyhR8cTc1ILbP2oLLV6/74QxSidvlgisrmNIxqhqDAWxKZ
	 TfRpxdQFxnaY6yhrR7m4LAqjzS1vvDMK3xmikiuu/o0qUX54thQc2j1Gjq2HQ4VNwr
	 rQKjxAF2qcQOahokDI2/tvLM1hf8YVHZ+abqqiF51/1wliz8hXeqPJdAFOMveLB42B
	 DSKDUbp1sv3q/sTl5Z8xcEzVErSlNqGYT1F1PLCScIypX4jxPqjgttEGM9q3tH7Gdv
	 i3o5hUvLakD4MvXrM6mRnnF2KzfqtpiDMAQ8pAj28Y0O3oXTU0l3ue3PDx/tGmMrY1
	 Snn6b8NY550AQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org
Cc: tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        rafael@kernel.org, lenb@kernel.org
Subject: [PATCH v1 2/3] x86/xen/msr: Fix uninitialized symbol 'err'
Date: Mon, 12 May 2025 01:45:51 -0700
Message-ID: <20250512084552.1586883-3-xin@zytor.com>
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

xen_read_msr_safe() currently passes an uninitialized argument err to
xen_do_read_msr().  But as xen_do_read_msr() may not set the argument,
xen_read_msr_safe() could return err with an unpredictable value.

To ensure correctness, initialize err to 0 (representing success)
in xen_read_msr_safe().

Because xen_read_msr_safe() is essentially a wrapper of xen_do_read_msr(),
the latter should be responsible for initializing the value of *err to 0.
Thus initialize *err to 0 in xen_do_read_msr().

Fixes: 502ad6e5a619 ("x86/msr: Change the function type of native_read_msr_safe()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/xen-devel/aBxNI_Q0-MhtBSZG@stanley.mountain/
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/xen/enlighten_pv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 3be38350f044..01f1d441347e 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1091,6 +1091,9 @@ static u64 xen_do_read_msr(u32 msr, int *err)
 {
 	u64 val = 0;	/* Avoid uninitialized value for safe variant. */
 
+	if (err)
+		*err = 0;
+
 	if (pmu_msr_chk_emulated(msr, &val, true))
 		return val;
 
@@ -1162,7 +1165,7 @@ static void xen_do_write_msr(u32 msr, u64 val, int *err)
 
 static int xen_read_msr_safe(u32 msr, u64 *val)
 {
-	int err;
+	int err = 0;
 
 	*val = xen_do_read_msr(msr, &err);
 	return err;
-- 
2.49.0


