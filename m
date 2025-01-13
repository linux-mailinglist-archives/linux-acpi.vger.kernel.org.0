Return-Path: <linux-acpi+bounces-10562-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA405A0BF1A
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 18:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39ACE1695D9
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435F31C3BE9;
	Mon, 13 Jan 2025 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LNAylknn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7021C2325
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2025 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790297; cv=none; b=Raxj3AWFVSwMBWaOS03/gwtVTHexXuBlVufCyU1E4FBXp52Hl2ZMeaV8MUIFsJS6XnnJ+hR2BRYX9JWEcxhV0oDLF+4IwNQBqW/u6y33TSEydI84t19Ava5gIuVq+4iXaDzJgREG0fu4BS+voihklgDEyevl8RqRLr+XKSO1vyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790297; c=relaxed/simple;
	bh=SitMIzrEMABnbqzeLxJFSLv+X+tguAv/sqKQ/L0nmKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGYlrzp0o66VDKm43AkYooJm443i7KHOyUqLsgISrBlZ2MkBh/hj2YSmAJ39u8wynakgjYQ4f5LS9S+0kZ0tkCWo4ZySuOzi6Otqh5/a8untL0aDjuOyDQyHxYoz7EEsKBw8xfffh0RpRhm1zhdlbQTt1dk8iDa2sNCRbwW39RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LNAylknn; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b98a2e3b3eso250255485a.2
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2025 09:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736790294; x=1737395094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yl2EwUT2VKVvGiWjqp0to7EI8yUq6Zt171XOZkuZj5A=;
        b=LNAylknnjFzNU9MVUCWp3UGc2ajCWX5qmD9y0ccgh2fX7Rfgs4g2D2PhiJXfSIIGnX
         4ZV0fDcpJH9wS1pOws5mqBZdZ74hlkXPWVwSi4FuvVP/jWdWPv2AoPGnPSkLDgeBGmvf
         qyp7Fjk88zLExKFNhRoDTHWGJmNeiToG8GfU6wpBAWwTFJEzyBn7YlNg3/CmUEF8NbP+
         g/Hl6nnHlbrCcP2EkuHCDFOMAo+0w8hmDmJDZb310vklVIRI0vklsNJvnQheJfy6ynai
         Bx/vaoZoT30X/GLzzHQEtvOQyCVpQSdSqhIb6EkKW8jwT7+HwxGvWx93iz26//dIZ19F
         4Hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736790294; x=1737395094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yl2EwUT2VKVvGiWjqp0to7EI8yUq6Zt171XOZkuZj5A=;
        b=fn6wg/X2072qUf1gIOB8WywOy4bWByez7t1cyhd6vBoNToo6S1o2ZtUDOcW0rSYdju
         +4i0B/lD2XaroBy+ZzwSZCbJ/KmvW27cDOZjirkXImiST2iPafb8J8EP+ZT8+e4g0dlf
         3pxRUi5yViO5D21VpO1LYQyu7I9tYqPjbWDn/whG84RJe8A4zoraK6vh8UmoafBSuJYQ
         5jyEJCBTLm3iRq2uKS8Ude8nnJjy6SI343LId6I/NeYkZggCC/EHq1gW5rj1mvRmYdSS
         m6cV3rtTcRNEiIEp+Naq1CeZJi+ImaSL+tE/BzygJFr2aT1iwoYtmX0BC0BjgJpj56QF
         vGGA==
X-Forwarded-Encrypted: i=1; AJvYcCUGDXJP7nsSm8R3VS4qrnLDcNS+1v9irpkljp4kv/u3BSJEmo5QYgSIaK4GHR2prP7yb9GuWBLVlaoF@vger.kernel.org
X-Gm-Message-State: AOJu0YwCfAPr6hneUP/zewjs6DNHJmLSaWY0siOwPENKimKDGAM+0Xoh
	1zSVY8fRz97j8j/O7TQ+RW21bMXM/cVOZeykQASuCijyXzPHgvLNSWtEeIfpV1g=
X-Gm-Gg: ASbGncu+nyuLA+d87yMCdjPoHVwpoksZzoeDNjZMelEgyNV6A15jjjMaC1mkQ00eyqV
	FqHANUFxmjIn0bcXadbiakxH++vq70OgUtIqqOCFNShXxSSWjktttCRNfG+s/qQPeppSGn6oqG9
	9amcvZyG/ofbb5MiVARsYXLF5Yzju7V9ukTxHSUdGndjqTPEbZ/z1MF/briV83MSq9pfWX5jMSG
	m/GjPd5/lTin8n0RvP5rsNv2dS9Aeculv605bRcazSgkkRXYZaYeWuvA3bAFE0OcNlEVDAM8c5t
	I9OevKUJEftso+fmwcNPs/En4RtxZ/uXoYy/V/gN+4UN
X-Google-Smtp-Source: AGHT+IHjZNO++490q5I1chUVLoFtrxzaVQ8wh+7ZzlHK7PMYF+bXoOp6mvzhXoNAdBo9KngXvoeIQg==
X-Received: by 2002:a05:620a:4095:b0:7b6:6b88:cc00 with SMTP id af79cd13be357-7bcd96e8d37mr3639424985a.5.1736790294598;
        Mon, 13 Jan 2025 09:44:54 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248c80sm511214185a.49.2025.01.13.09.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:44:53 -0800 (PST)
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
	Fan Ni <fan.ni@samsung.com>
Subject: [RESEND v7 3/3] acpi,srat: give memory block size advice based on CFMWS alignment
Date: Mon, 13 Jan 2025 12:44:39 -0500
Message-ID: <20250113174439.1965168-4-gourry@gourry.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113174439.1965168-1-gourry@gourry.net>
References: <20250113174439.1965168-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Capacity is stranded when CFMWS regions are not aligned to block size.
On x86, block size increases with capacity (2G blocks @ 64G capacity).

Use CFMWS base/size to report memory block size alignment advice.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/acpi/numa/srat.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 59fffe34c9d0..7526119fe945 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <linux/memblock.h>
+#include <linux/memory.h>
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
@@ -425,13 +426,22 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 {
 	struct acpi_cedt_cfmws *cfmws;
 	int *fake_pxm = arg;
-	u64 start, end;
+	u64 start, end, align;
 	int node;
 
 	cfmws = (struct acpi_cedt_cfmws *)header;
 	start = cfmws->base_hpa;
 	end = cfmws->base_hpa + cfmws->window_size;
 
+	/* Align memblock size to CFMW regions if possible */
+	align = 1UL << __ffs(start | end);
+	if (align >= SZ_256M) {
+		if (memory_block_advise_max_size(align) < 0)
+			pr_warn("CFMWS: memblock size advise failed\n");
+	} else {
+		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
+	}
+
 	/*
 	 * The SRAT may have already described NUMA details for all,
 	 * or a portion of, this CFMWS HPA range. Extend the memblks
-- 
2.47.1


