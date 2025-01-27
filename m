Return-Path: <linux-acpi+bounces-10845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E86C3A1D99E
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 16:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4179C161CC2
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C9114F9FD;
	Mon, 27 Jan 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lQIjy5KV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640E14A4FF
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jan 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737992059; cv=none; b=NEcCzq+87NIUNwVnM6ZbXyr4m7ddC4xwWI6tKSBWknZaIgfO4xBd84EbpJg13EL0eXVfED7u/AoCrB3PYSur1AO4DHrXDoAuc6JFmDkdeI3kxeZCVZZ8rWKPKBm/lnfjOGF7TneMlXYHRaClFmhJDBaLglmrJOH1BfKh+XoDszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737992059; c=relaxed/simple;
	bh=9Bnw9+CkdHqaCLM0YEFQRfjPOnve6pPOiFVrRE8u43Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXy0zu08JpNggFJ/gC/gBET9f4073NTit7OsQ7wIqLdJzuBCmAoEL8STlzN7j+NXcjpa3ShLyJJSYIb/YL/IkB656/iuOVkjEQy1i452mMhUxDoBRLfQEi2Y5obHJa6thoHgDxCNgzhF61hUfzek7FIpmo6i3BTapOdFyo0SD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lQIjy5KV; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dd01781b56so55509096d6.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jan 2025 07:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1737992056; x=1738596856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuGLm5QAWvME/iYTUeN4C38ZerEmS6SWYSvNtkJw+ks=;
        b=lQIjy5KVxE7WdL4ONGFzbxw4loh5PvryKwkMZJVwnKzMzHjpVIrznT7yXaX2Rus86I
         rRBbSR5SAvDfJOkX0Sj8eYL0+hpsqXbFoRvEYdc+5W52BWbTmeaAx9GnLWoDVD99mNDk
         OAQKoN/EHBKIwEg9B7AXfgwgAHO2WuGcURW1ZGMTutNyq7R9vq9DfKfQrNJnbrFCuP/3
         z0JhYNARN0ixszY+/J2sXLIpm7BM2c4yGFuc+guvVLfe4MvGEHQ5jeLT6YRb0kexxZev
         06iF2WBi8u46Il4Yk83+2i0WX6SsJ4ZN4oNatwRatbj4uAbK5AefpfOtwb1bYx1YR/xm
         URAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737992056; x=1738596856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuGLm5QAWvME/iYTUeN4C38ZerEmS6SWYSvNtkJw+ks=;
        b=bMs9V09BX9/A16OYxpMJ+ceuBK47u80xvtA0UpzLMZXwFSa9zuOoDN0Pz67/hlMp/6
         zX8uMRTUS9QdMoogWvrxx58+YGUNNndZDK29eIUqq61doPppDgklUpyRm1F4X00ybv9W
         p8mMEgRKPhsh6FTIaS9w3gEPOhjTb7Bux9yRin+AJxmzGXDcjr39Ag9Ut2Kn20d39s11
         Ylg4UU5is/hDRPLrPELnnbBReYwem82FbRrNvrpRntL2To/uiAvZOIBFJdIK8kIyEKn3
         mmM7QiTmhaFt/Xgug9D1dMLCII86C37M9+2nmf056LXpP8f3dCQFo3q3kLD4T7lzrT2i
         +x4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVt3BtydlWy5gbpDmbVbYW2EZSVOVipUsnGzCcW5E5SRTv+bg74cBYJ67IvWZTfKkDW64ughSF6n3E5@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKNTVAlVE0qIh6Mogusb3QpR7B5JnfojSd4xW0Av7GeKQaVji
	HHDFaGRSlc624yQuDCyOA4mbYEQ+qkCvMfWUpvX/K3/fvMDRYs98DtlrK9vvcvQ=
X-Gm-Gg: ASbGncsr4EhZnERDdNTV2p7wdYDeynav7auR9kFHqmpsHCGBjWo/oUcwmvP4Xx2RCZG
	KVb6fb3LQIXPjqe32/rI8tK0XTsYbayVhh7hDpsLt7ILaoAhmQ7ksc56k+Oo8w+6JngW6ecxjqN
	PjKq0VIk+k9OoYXn8ZQNYV9op7pFKcnDdo1Lw9/6aMe65PdrQieoTeHBqtg2yvCe0O219VNMOIr
	J+xe+PZEqNRgMFpF51F6CoHL1bIbOyfLSjH+w2qxAeqeaInbaP3Nlw5Dr+ZHmspicekED7SZrEx
	KQdgHEGHTSquybGvlz7DBa9qX4bm2t9/CS2VXwCWhNC99Dz/hXgl2z6nBLNNUrVE2aQR
X-Google-Smtp-Source: AGHT+IH3YD2uq0s2UOyUMAffGvHi1zghb5NCWsDgLZca9QQje9OVBrkdwmDEWT3QH9fizy2t68UjHA==
X-Received: by 2002:a05:6214:1248:b0:6d8:b3ee:8b72 with SMTP id 6a1803df08f44-6e1b2229d49mr616446186d6.32.1737992056362;
        Mon, 27 Jan 2025 07:34:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2058c2a51sm35380476d6.109.2025.01.27.07.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 07:34:15 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	linux-acpi@vger.kernel.org
Cc: kernel-team@meta.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	alison.schofield@intel.com,
	rrichter@amd.com,
	rppt@kernel.org,
	gourry@gourry.net,
	bfaccini@nvidia.com,
	haibo1.xu@intel.com,
	dave.jiang@intel.com,
	Fan Ni <fan.ni@samsung.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v8 2/3] x86: probe memory block size advisement value during mm init
Date: Mon, 27 Jan 2025 10:34:04 -0500
Message-ID: <20250127153405.3379117-3-gourry@gourry.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127153405.3379117-1-gourry@gourry.net>
References: <20250127153405.3379117-1-gourry@gourry.net>
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
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
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
2.48.1


