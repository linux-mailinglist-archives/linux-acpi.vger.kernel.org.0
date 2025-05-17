Return-Path: <linux-acpi+bounces-13771-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C1ABAB3B
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 18:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D1117D762
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D29205E3E;
	Sat, 17 May 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OYWedsLY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6001D514F;
	Sat, 17 May 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747501070; cv=none; b=u6ny8G8xKR2WHWBj/OMEVA0yKaQjjmWgBc5Atdh3yZFLW8Zjyot+ePM4EcqhN2kvPLMs6OPcIBVcfWZS0WvD55R0SvRd0tFVXfDBQS8537fktqIt2KLoJ95Ily4L3VLti2zgZrzOJ1fS9kPr2XS8st14duawMEHy0miWnwljNWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747501070; c=relaxed/simple;
	bh=ygzNzs7UaCvsP0sFN3SdSeG6G3cRl9r+gxrWvNu9d0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deWKE2H6L97QhXvS5hlBxDpiUbo7h4RfbyggJdaLK15e3ZmNpFMrTY8KO98N/nPJTmMfzCCf9lCPsEGQGwAloVlnYmR7i4ROkH4aeodWU1/aP1Zxwyo7gs3Qg1v5qRJa4WYnQrbo8kb+iMqmNe6RUz28l/VuEg+nrhIWDXScoLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=OYWedsLY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54HGvDhh935399
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 17 May 2025 09:57:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54HGvDhh935399
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747501039;
	bh=mKRkOm6YCP44COro/tUSTMPHIOXwpBJTdxPBtiGGv34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYWedsLYqMQmUpWqc2lx996Ra0psIm3b5PKqU86NwNH25aNWyIThMqo2+aNRuDOug
	 B1CY58kCLHBpWGBl0T1HxmhtWReeJMNs8rsPm9o1GG8t67JuTKpzymKrmieoahJOdS
	 TOqO3IMnQj/CrXNe879Sjb1ZilZ2/j9XWTakmjs3koC7vrgSeL/nPPgUkb6zuBW+E2
	 bSVwKohXIIesXQ58FjFp9XJnUD25RKDb3oAyZD2kHGEN27x07cSde3P9HrdTNVUlKv
	 gLCdquuKYcnBd0aCK3drY1Cst2OvRwLvdn/z9ZSeVsC564kEFulFyZbIaENPQ9nP+A
	 k0KUjSx4wKMfA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org
Cc: tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        dan.carpenter@linaro.org, rafael@kernel.org, lenb@kernel.org
Subject: [PATCH v1A 2/3] x86/xen/msr: Fix uninitialized symbol 'err'
Date: Sat, 17 May 2025 09:57:12 -0700
Message-ID: <20250517165713.935384-1-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <ae1d05f6-cd65-4ca4-87c5-af0ae34e21ce@suse.com>
References: <ae1d05f6-cd65-4ca4-87c5-af0ae34e21ce@suse.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xen_read_msr_safe() currently passes an uninitialized argument err to
xen_do_read_msr().  But as xen_do_read_msr() may not set the argument,
xen_read_msr_safe() could return err with an unpredictable value.

To ensure correctness, initialize err to 0 (representing success)
in xen_read_msr_safe().

Do the same in xen_read_msr(), even err is not used after being passed
to xen_do_read_msr().

Fixes: d815da84fdd0 ("x86/msr: Change the function type of native_read_msr_safe()"
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/xen-devel/aBxNI_Q0-MhtBSZG@stanley.mountain/
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Change in v1A:
*) Drop setting err to 0 in xen_do_read_msr() initially and set err to
   0 in all callers (Jürgen Groß).
---
 arch/x86/xen/enlighten_pv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 7f9ded1bc707..26bbaf4b7330 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1162,7 +1162,7 @@ static void xen_do_write_msr(u32 msr, u64 val, int *err)
 
 static int xen_read_msr_safe(u32 msr, u64 *val)
 {
-	int err;
+	int err = 0;
 
 	*val = xen_do_read_msr(msr, &err);
 	return err;
@@ -1179,7 +1179,7 @@ static int xen_write_msr_safe(u32 msr, u64 val)
 
 static u64 xen_read_msr(u32 msr)
 {
-	int err;
+	int err = 0;
 
 	return xen_do_read_msr(msr, xen_msr_safe ? &err : NULL);
 }
-- 
2.49.0


