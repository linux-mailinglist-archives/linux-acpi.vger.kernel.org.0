Return-Path: <linux-acpi+bounces-10561-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53575A0BF17
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 18:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C37218875AF
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0821C1F27;
	Mon, 13 Jan 2025 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cDLsdk0w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8752E1BDAA0
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2025 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790295; cv=none; b=PPmGdUJw3aASxNrT5kB+xPKsup1e3ki0YvOSsgYaQvi7RN/5ZlUI/RuZ/fuHQ2eySpUuiYV8xl2eDwLEC4y8i64uKRJVvBBVZXU/jq+07XSkOrmQ/kFJsdzeujLO+T6++m3ZOyTs443FXb3UcQT+UybqqzeWz6xiemN1W5Bs0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790295; c=relaxed/simple;
	bh=Z6hmuojvYtXTroj1JJWHKwTtvZg1ohkoBA7CDtsjZso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0XT+o6OdZxrogoxH4BPxKfPtxB9BoOgoF8hlXKEnwd5yqalKU1B3OzsI/+ubmocFMsY7soDJLuMjGRJOiPOJOHx3AXFVub/WkdRRFGhJzw4skzuQFir1UwK9gkpIzJEfHeC0ai3uR9Wa4pHNTFszH7RhdaJxpIT0b/CGWFv9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cDLsdk0w; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6c3629816so260199785a.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2025 09:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736790292; x=1737395092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZSM7cd0rzVSNSrAghH4+54a5vGC27L1Y4nGLMrRkSY=;
        b=cDLsdk0wSNVC6HsXeucUQLdvPy3zy9q05WcNaAUzzEnlg8Cxf8l0nVVrDC/i6zRhCy
         2Jxx1UmKL6UgEv2mXTz71gQb9puPzYSiiJ2ifHX4jBL7h/uFy9LuLKOKSbd5i0iLBQds
         YYRrbIKgJdvYyJwHaT5omy8i3fWcDoc+gfHVBq7O9QGfaLosivCDBlNCiPEy2xwFQ8Fs
         JdqBC3vleqV4naM5YGU8N148XpoB1d6LcUzM9YkAV/4jnTHmwA5q7gHR4yKnKOzD7Zo1
         ZEhU1knkgyTRDbjnofPWcew3JFYvKZ8LB/Z3TnAPMTh52lC7BTUfVFGGOENOO2dnpKlK
         u43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736790292; x=1737395092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZSM7cd0rzVSNSrAghH4+54a5vGC27L1Y4nGLMrRkSY=;
        b=EnQYVV+uMottwezXNjerhIbw47HgIIbLKk+th5wIcBH5Fcgkefv8vzNsgT2LyUu18T
         zSsW9k5k/qRD1iYuwMMfIESaXUDNazNZeH9l6V3/GJz0seHKuKNI3IIXu0Qd0ulhei/R
         lLMryN20zgdJzixVK9eTklfS80ohoKjy/elxakNup9/enN4DAYx5als1FJ/riAPlh120
         b3OoHNYDnM/8FrNI7TV7EzyyQioGxbmGSVf4HVUCPDeUUbIBnBiVFE63eVWXKF2aeu+k
         G81/5inu5544fpZuAnb2zj7179dbYhyMsHj+UnEGPMiyQEZIK0o00WeIT6au5tIakxaa
         dJIg==
X-Forwarded-Encrypted: i=1; AJvYcCVodFf1MY0gJv1kO2CM3nf6WIQLypIZZZlD9SnYNs6Ht76L6DV8Tl7TS7Mji3hdx/nhUzd/NqEKoY4f@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUqmE3uWrNqdsx2e6R6R0wuA4sCDggihvJNz/W7UbuhfH/iA2
	NqQyEJmBj+JWPprwUbruI72uezmGV4GvcRPe+O1137luffuDyCaQarZZoO/fuLM=
X-Gm-Gg: ASbGncuwL6dlIHQZX3WFD9I9KbhJeDSUTYWqPgskzip8WhsHjXpEroWWISoMHjJaKZ8
	abp9cb8NEMYF6CLfc+X74KwyAyekRH1mbX7CZKkYMvKbFHYUadkvl+arY/oJXWXEOb0oInEMkYw
	wxidKNZGUh5+6Uhd7zqza51e4vAm/5EFzBWay+ZWJ1VidoTSigFlSkvO1D8vl/RyIEo05ijoOJM
	vgIYOmV2ddlaUIu/p211I0kqUARyjBa/re+q396iOykl0m2r791QRImE8J/WOD2tkZJpy0/AGwS
	EN5zQWPSejdRH6TAFEcKxFsmtwqIQd6FNcgjD0hckRbi
X-Google-Smtp-Source: AGHT+IF+IF6Rv5no47DpWYrkZUPK0sDnR8tgi7nlXfUyokU9C1+7BbgLKk1J4eOLXpCwFls4u2oImw==
X-Received: by 2002:a05:620a:2697:b0:7b7:24b:dc58 with SMTP id af79cd13be357-7bcd97627d1mr3005432485a.43.1736790292471;
        Mon, 13 Jan 2025 09:44:52 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248c80sm511214185a.49.2025.01.13.09.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:44:52 -0800 (PST)
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
Subject: [RESEND v7 2/3] x86: probe memory block size advisement value during mm init
Date: Mon, 13 Jan 2025 12:44:38 -0500
Message-ID: <20250113174439.1965168-3-gourry@gourry.net>
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
2.47.1


