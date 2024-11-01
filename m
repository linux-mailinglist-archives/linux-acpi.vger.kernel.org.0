Return-Path: <linux-acpi+bounces-9236-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93D9B9251
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 14:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C301F2201A
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726151A4E77;
	Fri,  1 Nov 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AXWIq9IN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830061A2562
	for <linux-acpi@vger.kernel.org>; Fri,  1 Nov 2024 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468840; cv=none; b=Dl4W3eyn+ZksCP/8GYdwzSkjQKc2Sp8F8Eorlf3PE5gfS1V9NmNra8nmVQVJFRsmAH4fdTwSKwS+y//X19zKB0K//ec4YutYyEaIJHqpWiXgbJX0Y9xCqmc45kZ4+yJLiSwHVmSdUJKuAq4qimPfIsxTCOjAw07V1zwlw5/eWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468840; c=relaxed/simple;
	bh=N0XPOmy3aARI7v9y/OYZfrAo+KC130k3/XQolnRqYXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPnJhNazjceWF+PVJR+lQAf5NQfKkmHJwAYZfoKGiFxXaYIm6DxtBOX6A8pfT8MQ6QMTDTRvRap2XJUHTpEtLr7ZY9d2e3xYVFGVOFNHzE5hzOtb464gx4D3kYvGTLFG8/sz8rWauA8QRRICfsmFT1ppXnkVjYgKjU4MITwM3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AXWIq9IN; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e2915f00c12so1806356276.0
        for <linux-acpi@vger.kernel.org>; Fri, 01 Nov 2024 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730468836; x=1731073636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqBWIQFF5FQxg66rq7hDVwvrkSgx0UrsiyD8ZLE5CIc=;
        b=AXWIq9INy2KD4MeakrhKW5WlAPb2H5dMjc4Lx3WARI5PzgmlA8XcrfR3qsNYpQlwRi
         iOQByHwq00Nw1ChbAVPBI9oGEwwxfjNQYRdXrwpPgoJmcO150RRm37xAqmQKZcpjLO7l
         b5k8MEn7JXLLI7Wgkv6r19YMt2JceBhDjB6uGRPWyKCw2PfzFuNzvRXJo7KnM9Xfxzor
         yT3r7OrFve8JTOQlpl0Ki/YWg7ShWW5A1OOGkvwhyVVTZ7DRWfamsbuU4WS3QCYDgIgP
         DutLUtss43CdiiBT8OwnVoSUYRT2QTp7QmiaA1xuVMhXDuhTYMuI5VVPiLSejanJAQrS
         YnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468836; x=1731073636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqBWIQFF5FQxg66rq7hDVwvrkSgx0UrsiyD8ZLE5CIc=;
        b=wY4GlSI6vlaGNJgJZoV1pSNpRWKdKk6/FgeBMDur+OZ38ZXGEPaZuOHGbOSojfxwMw
         maXLiBK79pqZzs2DRa7KDs8GykHV36v9u4LHieSQlGsjIGGDXY7JaFWzHS3on0qBznAA
         Xr8VTuCfskO+pwOSP9BRpUk1Rfgo1pAKTArwffJN5kAugey24UrIqUXprbkpW2qUiJIe
         8VlQgvuEXjpag9c5sg3pe+VEstbFxqgJ3jI6NJ1Gdruf2jkGvM5qyUY64Uw9UTwSNGyd
         E9462VnkCfhW8St4XLuRkG5cykKoqTCZvjHPxQMSrRR9JATtHcFXb4a5nfgOd/68YuDJ
         ZW7A==
X-Forwarded-Encrypted: i=1; AJvYcCUe0W3a/0RfKEJUrYOueumJ11pHqCNIAzdZhir/ZY/NbgovJ1vJDCOJ7OllkrmiyKRE9MTw8unGVH04@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qzCwSpDP9+SEb5SiLNFn2PgVlBaTKmFVjnyi9+lsV4TQAA3P
	fxGHiDta8kylWkfyA5nfNu75i3spHllieCj8pBy4EyIPR17SzP/cui5VRZAmxAg=
X-Google-Smtp-Source: AGHT+IHc7ueHoeZ78qtsNy3gd8c/oEoo2nOnDyxntt3wb0tJLgWmBDNYSZb05h7Av17dwgQfREUg1g==
X-Received: by 2002:a05:6902:b01:b0:e33:14fa:2273 with SMTP id 3f1490d57ef6-e3314fa232amr169232276.5.1730468836506;
        Fri, 01 Nov 2024 06:47:16 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com ([50.193.156.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0cac07sm18840631cf.48.2024.11.01.06.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:47:16 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Terry.Bowman@amd.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
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
	rppt@kernel.org
Subject: [PATCH v5 2/3] x86: probe memory block size advisement value during mm init
Date: Fri,  1 Nov 2024 09:47:04 -0400
Message-ID: <20241101134706.1185-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101134706.1185-1-gourry@gourry.net>
References: <20241101134706.1185-1-gourry@gourry.net>
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

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/init_64.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..f1a495e998ce 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1452,16 +1452,21 @@ static unsigned long probe_memory_block_size(void)
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
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
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


