Return-Path: <linux-acpi+bounces-8823-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A746B9A1276
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 21:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9C81F23253
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2EC216A0E;
	Wed, 16 Oct 2024 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Hk5bp7aR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AFC215026
	for <linux-acpi@vger.kernel.org>; Wed, 16 Oct 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106718; cv=none; b=C5M8w75sMb2SyDa/n4AWU8GMz+XPKC6GiGIecvJZWCLg7NnKL8/WQngQJ2ztMMovMaUPP+HpKlHKe4GP7a3GPdBourQxLWWoFmhgfy1jwgX/nKt/KK+2aqU959H/AmcH6w3UnvOy8HDI2eDa0lsiPipWD+Evtvc9janG5Xu94nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106718; c=relaxed/simple;
	bh=UFARBbqayRLFnWF98y3uEkaCwwYUXXMM3OzZ3HiPfXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAlUK3bKlf2eyI/vt+UCUIyp00gD+Vo+Prbv4uHAQol+xiWLNYTS6FxFeuJiqdskfb3tvG3dG9H9hHhXvGjm3Jg9/ZtcT7r/KbW8H59n07riPCW0P5uADLNqFQ5CR0/ZA0v5LPTrmoDgaAJwGGlK0PYZ7Tq/M82pIIfPOLbhtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Hk5bp7aR; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46045199e4dso1567781cf.3
        for <linux-acpi@vger.kernel.org>; Wed, 16 Oct 2024 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729106716; x=1729711516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhSiZfD9mtqxRJdpC7TxMcZ82+QcCBZVMQrw8INyhYE=;
        b=Hk5bp7aR84sV4AFuoNdhLQKYRO1SAzKp65QOnd3latWq2n7RjMIOFxLRmQKJjo1AMM
         Ztkn2eRk1mra+G1ouMF1rJMJtntTMuIQbUduj++L1WCshVGa1INCz34oZaraXbZ6XuYo
         O3a6a6Bffj1J3ncunOU/gzIolYy/+CuXakCGqQvF0bBbUzpL0S44anj9f5LqkiXxdsbO
         SLdnw/TC81o/6M5XvZiFDjucVNYycfXv9Mf8Cx+IHg8JNh+svjM2Kly3+s1tiPmj5pow
         1BHDHpRyZnXSp55iTNrx2kqHLNPCXdRrWF34pTVUC//6j4brkXdY3afOewwoQjOgomlB
         9XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106716; x=1729711516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhSiZfD9mtqxRJdpC7TxMcZ82+QcCBZVMQrw8INyhYE=;
        b=wLKki7UqJi60+r1x409+iFND2eHPr88rezBPIi0JJgh3vNWuDCH5iKCNCFZbc71geB
         ShhLnbbsREaUwa8v/RXHQO9cDRn8fnc1/qs/t41OY9hT5ixEzky3A55wg8uc5IDFcQhv
         7xzz4XwzMoIXeekmdW0c3pjR7hDP1tSEvaTIXqE+Exk+oun1N3QDYRXUo4788VuWFS7I
         EqfJaCBsnAR2BU+RGk2h/1vsksUWA8UyTMduuzq+1OcPjJ2puddTRgTfgysXpe8xvoJN
         9VJ7T1bBrgZhXgCN4PaDgFKkMpUclQ8aXvVzsOh+kdglLfGXPba7RaNrxgs8tpOSsfv0
         E51g==
X-Forwarded-Encrypted: i=1; AJvYcCUsL2RH9n/9sMe5gpNYX5LAya+/2lzczxoi+baQtOPMgm25SJMz/dhrhOa4VHa2/vre5RzNF6ePdfGJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Tszck+D7B0qAaIv+iJq6uZL9E+ERZjU/mpKdD16LGpY1rHzH
	UG1dz9CHpYWjZqyhbCBc3CQaRVR2BaK7m1DLfKVvtXCdP/v1SaJ/teiuxSVPL1o=
X-Google-Smtp-Source: AGHT+IFAUHFf6NguMqIqPpOUU8ECxUJfxWjg38Snyk4DLApeDSEpJ+qoxL7DfuWK9Mow+ZcYMf8Ygg==
X-Received: by 2002:a05:622a:244b:b0:45f:784:1b5a with SMTP id d75a77b69052e-46058444fa6mr282643391cf.25.1729106716169;
        Wed, 16 Oct 2024 12:25:16 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b38ce69sm20271651cf.90.2024.10.16.12.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:25:15 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	david@redhat.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	rrichter@amd.com,
	ytcoode@gmail.com,
	haibo1.xu@intel.com,
	dave.jiang@intel.com
Subject: [PATCH v2 2/3] x86: probe memblock size advisement value during mm init
Date: Wed, 16 Oct 2024 15:24:44 -0400
Message-ID: <20241016192445.3118-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016192445.3118-1-gourry@gourry.net>
References: <20241016192445.3118-1-gourry@gourry.net>
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
3) [new] hotplug advise: lesser of advise value or memory alignment
4) Max block size if system is bare-metal
5) Largest size that aligns to end of memory.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 arch/x86/mm/init_64.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..b72923b12d99 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1439,6 +1439,7 @@ static unsigned long probe_memory_block_size(void)
 {
 	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
 	unsigned long bz;
+	int order;
 
 	/* If memory block size has been set, then use it */
 	bz = set_memory_block_size;
@@ -1451,6 +1452,21 @@ static unsigned long probe_memory_block_size(void)
 		goto done;
 	}
 
+	/* Consider hotplug advisement value (if set) */
+	order = memblock_probe_size_order();
+	bz = order > 0 ? (1UL << order) : 0;
+	if (bz) {
+		/* Align down to max and up to min supported */
+		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
+		/* Use lesser of advisement and end of memory alignment */
+		for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
+			if (IS_ALIGNED(boot_mem_end, bz))
+				goto done;
+		}
+		/* Barring clean alignment, default to min block size */
+		goto done;
+	}
+
 	/*
 	 * Use max block size to minimize overhead on bare metal, where
 	 * alignment for memory hotplug isn't a concern.
-- 
2.43.0


