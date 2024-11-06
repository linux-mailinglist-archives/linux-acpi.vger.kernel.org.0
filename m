Return-Path: <linux-acpi+bounces-9357-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D799BF260
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 16:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7803C1F22F86
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B80205E3C;
	Wed,  6 Nov 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qBwZo1GP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EFB20514F
	for <linux-acpi@vger.kernel.org>; Wed,  6 Nov 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908746; cv=none; b=LyxD2FXycZ3Pu6BlYxxV52GC0DqqC7I9TNLkfoa+1CwZWmi/eZV5e76P3xhWStUDMdBRejSYCSkT6bcJVp05XFPhe3QB45N7VitnnSpsev1Xy9aKhIwyR0ojssZWapk+Lr3SWfhXhz4PbFL13ZTDhAQpqXUbqnkA9SNyIWTpsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908746; c=relaxed/simple;
	bh=SC4txGz5NoH743U6+tsH0RKT8dY+2Y1qyxiWEtmJVVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAGHkOoVqj2MAzGQf5dRupzn3/VQNRfCgoSVcKoysIDUh+Xjr4HKS7u9HxyzuxKxLecwnPGp/iq5kyGrNnTzGs/9XSOkQWDBMFfid6zkd6cHNSrFcXiztIhkF1Yhnuwxzy3oFjNZanZYwlEgLix/gfze3OE2KWr7BFRnUtSM+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qBwZo1GP; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b148919e82so469089185a.0
        for <linux-acpi@vger.kernel.org>; Wed, 06 Nov 2024 07:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730908744; x=1731513544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhjUN4fArKWWoXRi7BXSpLcpyo3J42V+ZDp+ucOnHvE=;
        b=qBwZo1GPAzNG4RgIgkz34dzNdRI1UYQ0/49eFDAqcm6ZEsaT36dOWd9XS7CvJoXFlz
         qCPxRJw3XQLomnG2xGUzcZ0aKtnLF/SoaQyBKYRdw+r4wL/O7E9LM7QhKl4VlxfLxlst
         yNGWKB4IWbdgORa5ptLYfD2aNbTf1I/DKC8xwkd8F3G/dgX4SY+92shDH/NpbIiU8Mhd
         0634kJv4QUrjpijMnnt4yHuM1PKyMiMFcLV5P3rLKoxtYRln0uEwvwbd3wFhd1GNhdAt
         T/4XjwFUuTs+xn7H3+KtFTSmcnQFT73fZ/0Qdpbre/kRc7XpI1DhBMHVqg67bL7qtDrS
         o+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908744; x=1731513544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhjUN4fArKWWoXRi7BXSpLcpyo3J42V+ZDp+ucOnHvE=;
        b=rMi/N/Z2rSpSjoQaF1zMiqmB0pgvRsYfV9uhXr0JVYK3EBaW5GnD2gVyDK5pFO6BsX
         jeHzTvNsy0MAE1VAUK9d1pyEDiOwbml9a/bblrqmP70FKB+4oOA8L0rMpkD2tr3YvxCM
         rLM54udFzlqZ/OnWogKQtF4kQRSBbYNTWkJLwgzTVzev6vgxefudeGGdh81i+Oak0D5B
         1eJXrvdn3Q97Qj+HYipQdx4lv08Qw5iGxW1hG3K2sSi9uap1viXE6XYs8wEI4NE4pvBp
         npAOntmHHE31c6BfAVNUmR2xn6PuhA/ji/KyQtjielJzV7BBSV0UnpK9redoJheKCJ0p
         aTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1AdkDxrw6BbhC+P2h51aSoWD5H4S632YetjYyr7SVYnqmXze4NK+rAKWqpMY3nYOjsVLEqVhUlg3Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4xKdYbE3yeNSwE7fy7Et/cR8E/5sUxPt3mf/uFdEhU61t9zMk
	BOgM94XAXqABEWshRQEjf8B0Yp6G8L1FyOTu+HrFa7y/d7VeCKn2A3kYFUvgWOI=
X-Google-Smtp-Source: AGHT+IGyyNaqJP5GT84XkBpTnZi+GYICvytezSItQpJFP+BO2bYKSnE0l+VTemNGpDBYq2sb9frOVw==
X-Received: by 2002:a05:620a:190f:b0:7a9:b456:c5e6 with SMTP id af79cd13be357-7b2f253d534mr3445707985a.42.1730908744203;
        Wed, 06 Nov 2024 07:59:04 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f7b85sm641377285a.31.2024.11.06.07.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:59:03 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
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
Subject: [PATCH v6 2/3] x86: probe memory block size advisement value during mm init
Date: Wed,  6 Nov 2024 10:58:46 -0500
Message-ID: <20241106155847.7985-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241106155847.7985-1-gourry@gourry.net>
References: <20241106155847.7985-1-gourry@gourry.net>
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
---
 arch/x86/mm/init_64.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..2622dc7c78ba 100644
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


