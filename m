Return-Path: <linux-acpi+bounces-8605-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C459950E1
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598D3286EE2
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBEC1DFD9E;
	Tue,  8 Oct 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="StN/9/9V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E91DF99F
	for <linux-acpi@vger.kernel.org>; Tue,  8 Oct 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396054; cv=none; b=pgW+HH0iL5kCLr6XLkY9x2cRkIYlQ/WKLKv14nJPrNqTXVA4jW/L90+eEsal8Ruz2n18nGhJ9XUCIxjfZ+URGGV8FYKPs4WzjxYLsq7AO07g24BQyOCOnqw2Fq7Z/8oLOr0ssj0dEbA83qQt87XNHp7qi6mTybhYQJdjjuRGqJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396054; c=relaxed/simple;
	bh=D9ssUjGQ6h7QeJF1IwpdOtgRJ/SdyRy/lVBrG03bkKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2uJoy6tMabM1O0e3MhRxspw2dkudSDlWbANvt+mieDVTTct8i/P0Xt7vyKKKTUxEJeqxf1lxdZKMvHTgYFBCFGGbkNbsM/eSMzR+WolP9UUOexTEIpOiPoYBcIDLEjqFqrAxQa8kt034n8owhsfydWm8SNagp3pn3jF79+ySBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=StN/9/9V; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbc7c77c99so249386d6.3
        for <linux-acpi@vger.kernel.org>; Tue, 08 Oct 2024 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728396052; x=1729000852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOmfBB2o+BmwtYmn6lEeWqW0gfRN00aP7+NLXlUlw00=;
        b=StN/9/9VHUbqA+DqeHGKDKHwt6Tsn/zsnYDAfaM8fwy3k1NlJIgr/Q9LzY0ZoRNyXq
         +uMPnOBFTgKREJeABH/Ls/dKUkbsRLvsp5u57mnOTSd+WmANTIwUJSU9/cwt8/TkUEm9
         8UBlw8NHNliC/5UQPovW+V33uUdJ73g04pTLC85V0HkT2KBIkxOEhEDFU50ataaOHFYB
         B/rkDpnpdrAUUCPx5rQYvweU2utBM9qTOcXJayRmh1aH+lQD2RcDsC5/b/0apCqRf8TB
         elOmMdTbePZRr8x8/8cxOv6EVP5RwnMzsKreKWtQcwlL6E49h/krnxfDcw847ZB2UP/m
         JtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396052; x=1729000852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOmfBB2o+BmwtYmn6lEeWqW0gfRN00aP7+NLXlUlw00=;
        b=LSWJJtUeASXCZxRamYTmwvKu4sUD1PubQgZEqYH9oAnRN0AJ+lVfKY7zfNWDU1hBYZ
         Sq51UwSwA2YSunQwZxq7wC31eHgKkKq6ZUlZSA1m+FTmoCq5GKuuRRPEs2IBa+1zunuS
         LRyZ667Adx4IkP37wp4yCIR6Mb2lIlGh1D6H4OTDOv2RysL43fCVuOGF7EGaTw2lZjau
         K0Dj5BxXGZQysn0BZLLnFo4ISkKjEwBfBkFjiG9TIMgcMqrMd2FrdU7dwWgno5b3IgnD
         nxFU8hTgPx1WuGsb9IMlubBxLwjV/nkX1uASUOyClgbKk8cLU2Q33W8IwoHFMTMg5Fru
         QwGw==
X-Forwarded-Encrypted: i=1; AJvYcCX1wfpOlkQc0TCfVjEuLFxHltEogCwr46YuUKcbA9IjGtB/bk1xwMXDrqW5o+JgNRixwYmJ2Emf7RY3@vger.kernel.org
X-Gm-Message-State: AOJu0YyXoTkt1z34abo4gXc+p+/8HGmf7t+jsyxN1vf0/yZArkrnqJ85
	TmIF82TkIutYwdoszf4mpWiyN7v6IF3Fktb2LU8Ihd7Aljjy8+1PCXK3axAdnuQ=
X-Google-Smtp-Source: AGHT+IHe1DIW8UN+mP+xqS2Oh3mXbQusW6tw3/R+BVrHed7J8ntdmkY9QJ5q2+XDvRLblwgEqMcXNQ==
X-Received: by 2002:a05:6214:3b85:b0:6cb:c745:4f44 with SMTP id 6a1803df08f44-6cbc745517dmr10453496d6.26.1728396051760;
        Tue, 08 Oct 2024 07:00:51 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbc78650efsm698396d6.39.2024.10.08.07.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:00:50 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@Huawei.com,
	alison.schofield@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com,
	lenb@kernel.org,
	dave.jiang@intel.com,
	ira.weiny@intel.com
Subject: [PATCH 2/3] x86/mm: if memblock size is adjusted, update the cached value
Date: Tue,  8 Oct 2024 00:43:54 -0400
Message-ID: <20241008044355.4325-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008044355.4325-1-gourry@gourry.net>
References: <20241008044355.4325-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing CFMWS, we need to know the currently registered memory
block size to avoid accidentally adjusting the size upward. Querying
the size causes it to be cached in a static global.  Update the static
global if the value is subsequently updated.

Print a warning that this has occurred for debugging purposes if
the memory block size is changed at an unexpected time (post-init).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 arch/x86/mm/init_64.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 6086f99449fa..733dfa899232 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1424,6 +1424,7 @@ void mark_rodata_ro(void)
 
 /* Adjustable memory block size */
 static unsigned long set_memory_block_size;
+static unsigned long memory_block_size_probed;
 int set_memory_block_size_order(unsigned int order)
 {
 	unsigned long size = 1UL << order;
@@ -1432,6 +1433,19 @@ int set_memory_block_size_order(unsigned int order)
 		return -EINVAL;
 
 	set_memory_block_size = size;
+
+	/*
+	 * If the block size has already been probed, we need to change it.
+	 * This can happen during ACPI/CFMWS parsing, since it needs to
+	 * probe the system for the existing block size to avoid increasing
+	 * the block size if lower memory happens to be misaligned
+	 */
+	if (memory_block_size_probed) {
+		memory_block_size_probed = size;
+		pr_warn("x86/mm: Memory block size changed: %ldMB\n",
+			size >> 20);
+	}
+
 	return 0;
 }
 
@@ -1471,7 +1485,6 @@ static unsigned long probe_memory_block_size(void)
 	return bz;
 }
 
-static unsigned long memory_block_size_probed;
 unsigned long memory_block_size_bytes(void)
 {
 	if (!memory_block_size_probed)
-- 
2.43.0


