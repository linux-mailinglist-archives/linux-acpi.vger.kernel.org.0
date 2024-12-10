Return-Path: <linux-acpi+bounces-10067-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0B19EBD73
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 23:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E26284F9E
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 22:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B2723EA74;
	Tue, 10 Dec 2024 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m8EdZ7Ew"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377A23D432
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868351; cv=none; b=Zn8tjbEbkdEpqHiev35vHi/5PtFSbBLl2r1Ervq49c7Nuy4xSEKgFhF19HDrtg7dd+v59dN+kI0ejZXxXbBJdznEKWh7qefv8c+m7zXky4J+ZYbcyyLAf/xo5R18Clxk6NyXim49WqRk0hyAfs0c2TlSIldf7ip5lBOgUlmr8rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868351; c=relaxed/simple;
	bh=NI/VCBA4V00Ps24Jg1XYDOYEuE9C/bHGB4RLm7NSawQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtnRWGr1tZBHYdI6RSvNLU5+VLWcEaHzEStEjY4W/gdH7HN9OrL6J3pPwohuGXbzpWnEABSJ7ADJB2KFn6oQeL1d7GIKsMwnXlAPeNhQFELKocyDckasHrv3RDv7UiLGxMrtVxOQES9CRXQvQR+Kh9OOsnfBfQsDRfXS9DEc61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m8EdZ7Ew; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4677675abd5so8317301cf.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 14:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733868348; x=1734473148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oErJky2BLU9Af7jLve7daZWId/j12r2NaH/TqvsN93M=;
        b=m8EdZ7EwwcXdGFXJXBPI3dPzzacCNllhO+NMPLSyh0+DKq+Zjt7msnsbUWzoYSkOvP
         L0oRB2iMcGWMfxsVumcowsaaep8TuDD240Ecdzqln+A0sb4I58NdhJZ0d2dyBiuYUl/J
         MrKRwv8zRYHgDRT3Ba0qs+D7/ClCKODnQM6UGtiDKEyJc5t5x/XmKdlNqnCX2pdE/KVK
         0T7EaG6Hih5Hw+oTwTqAcIlh8kE44AsThVAX5wqGx74C879aCxLJGv8BMLM2Ll75cbSU
         6oww03NqRYHfMtn2Qc/j+yyBGZsrYnmi7n7Xzoq4/lrolbXu15ZiAdWLXSGJDcZ3yQX1
         /a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733868348; x=1734473148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oErJky2BLU9Af7jLve7daZWId/j12r2NaH/TqvsN93M=;
        b=NgRuwfY+QOgSls+WPF/xNTreAcdiCtQJZet1LtaSR0GYGBOmkJ99++amFQFnOTlclZ
         Zz2DzpO+TiIr/igQl4y4+9wy3I+96F/pRxob0XlLqNCMxRFAEIGyQi7/lUedjdeGdtoB
         ahU852IrLSt4fWz9Sd1TA/C8EmBrek3kAMPsx/3BxlHogLdyOL7kKKwvZMcbcvI8cOYt
         LQfYOzLfQsnWMANplPRWO+aU3L2wbUjpGi5oIBCyepStX+cYmcVQGiJwRTghu7TyJuj9
         MMMw2Q2IkaWB1d7Pu0gWaH1i/364xokw6rWOJ2NEAYLVkSz4rbW2c+8eiLOpcbrHMIEC
         2MBw==
X-Forwarded-Encrypted: i=1; AJvYcCXPHyp+2lAvHHGJqyasiRx6X+8bTeprxtu5dDbQB3j8Dzr+0aPjaZQ2PGQ6yzxoUwaxjHYpxze6VgJb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BRtjc0GwAGrZStyWLxmHS/Q8QOqvWccosdzkO46pVv8+jBmS
	knMVdEbgpJ2pCcK5bxjoAqWFWvCk8EZhrdGdN6pIqaX6iTBpYcFpEN71kGtEVxA=
X-Gm-Gg: ASbGnctf/5YNJ7LH+6DmjploJao0xtD0C/aNV1OT6/UVKbb9hOoJKE4V18yCenKwtSr
	ysKKtroDbSN1JTFFkl2TDGuFJI0Ccad6DzR+wFcX/VCAYqzS/iZulWBSYQ+MxN0R5cVG+tldJ2X
	hKG2v8jqBt30Pz1QAPasauPCoPbUoMYIEuT9XDtAdSxfygkr/YLNar3wF5SxdmHzP4afoKcoJWc
	B4Qm/ceuHOqM+Vl7NHLM27tsXtyNd8ktalT1Fx1Q+y0EjvNj+qpmQZNypSkrez+CupinJUMNWMb
	OUuglxRWcSgtL+HX3TyBqHwC/64gTQjQklFvdZU=
X-Google-Smtp-Source: AGHT+IENYQ0oAKQ+kT8P0UCH8ySBpUYpnMabT5K76y4L5ld+Nf2r6CwojmMzmHyhvdr+kBpYd1jW3w==
X-Received: by 2002:a05:6214:2682:b0:6d4:254f:1c8e with SMTP id 6a1803df08f44-6d934b7cc2amr10515796d6.37.1733868348294;
        Tue, 10 Dec 2024 14:05:48 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8eeb132e1sm49707756d6.35.2024.12.10.14.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:05:47 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	osalvador@suse.de,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v7 2/3] x86: probe memory block size advisement value during mm init
Date: Tue, 10 Dec 2024 17:05:16 -0500
Message-ID: <20241210220517.3744-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210220517.3744-1-gourry@gourry.net>
References: <20241210220517.3744-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Systems with hotplug may provide an advisement value on what the
memblock size should be.  Probe this value when the rest of the
configuration values are considered.

The new heuristic is as follows

1) set_memory_block_size_order value if already set (cmdline param)
2) minimum block size if memory is less than large block limit
3) if no hotplug advice: Max block size if system is bare-metal,
   otherwise use end of memory alignment.
4) if hotplug advice: lesser of advice and end of memory alignment.

Convert to cpu_feature_enabled() while at it.[1]

[1] https://lore.kernel.org/all/20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local/

Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
---
 arch/x86/mm/init_64.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df303..58ace82874eb 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1462,16 +1462,21 @@ static unsigned long probe_memory_block_size(void)
 	}
 
 	/*
-	 * Use max block size to minimize overhead on bare metal, where
-	 * alignment for memory hotplug isn't a concern.
+	 * When hotplug alignment is not a concern, maximize blocksize
+	 * to minimize overhead. Otherwise, align to the lesser of advice
+	 * alignment and end of memory alignment.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+	bz = memory_block_advised_max_size();
+	if (!bz) {
 		bz = MAX_BLOCK_SIZE;
-		goto done;
+		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+			goto done;
+	} else {
+		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
 	}
 
 	/* Find the largest allowed block size that aligns to memory end */
-	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
+	for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
 		if (IS_ALIGNED(boot_mem_end, bz))
 			break;
 	}
-- 
2.43.0


