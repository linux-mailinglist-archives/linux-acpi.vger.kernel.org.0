Return-Path: <linux-acpi+bounces-9358-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A066B9BF262
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 16:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FCF1F2393E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 15:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075E22064FB;
	Wed,  6 Nov 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fCRPLyiZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B32038DA
	for <linux-acpi@vger.kernel.org>; Wed,  6 Nov 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908748; cv=none; b=t0xCQllIYX43Uc9gcEsfPU9a6TvNsGP71oL3kLIIkM/DWs+o1nzvGY2aTuXQTEmBNHvh8NotwiM+CJZUkTFjAdCwYdfwWzfeebvTm6GeBNGVcLa+6co1cZ6qtn//zfkZPrIzrM+JBJRhDJGtiZHgCf9fztRGZMuJmL1/Nm+Tzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908748; c=relaxed/simple;
	bh=a2SRNhgByLYkEQQV8w/BUYuqaC8BJarO22cske/QxvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXa/zuGFSpWB6tUorA7UoKAc5d+0Ck8jWObZu4a3Mrszqz1lyK9uKG9eBvb9aTYf6c4IX7k1qePZ8cFpkD15Shv6CWEgtJ7euA05n4tSpYjr0L3YfyWM705FwQrw+bXwrjyMKNfvTzIQDcMJ75ijfjOAAdBMTtu/w4/ntvmpVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fCRPLyiZ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b1507c42faso82704585a.0
        for <linux-acpi@vger.kernel.org>; Wed, 06 Nov 2024 07:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730908746; x=1731513546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dE7GBdO27UpsSNU1CxN3p2/3T9xO+pcffcnhhBLFfkk=;
        b=fCRPLyiZs+9ptDNCDmtf7ik0bWzhFKd4BMazhLG6cy/alPFUiNI+GEx1762pXu5mZN
         AKDBm5RFPgL0HN7JFp6vDUJB2F+q6iXUluKrvZonZU6NjYvyIbVsuKUcJ+pFzS3FcZ38
         iD2nip8wqtN6NLt+DFgFlitub6QaIhi+AtsX6zozjH4Lx/Ewt13X+vqV2/P62vbx1PBa
         qPaYkBl683qMGsb/Y/lY2UyTV3NlMYgMahjEFd7UjBqa9ZzDXZTJ1jX0QTDh2Xvlba5/
         Ta4KYbbfXJ7ojUBUVGG0c8LElVjA2wm6l4ToaUY8y8LaVx8gmHELuz3XIF7YvU02YuCS
         DOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908746; x=1731513546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dE7GBdO27UpsSNU1CxN3p2/3T9xO+pcffcnhhBLFfkk=;
        b=IHe5YrGc2B7CNnzDHwZEgBlHt21zW0J7f6C3ByvxkYJ0sRYQagbMwYC7OQiptegPRJ
         wMv/lI5FMda06BdNwmAj5qhU5MR8jyVhkKvuNRIPCXbK0j3m/6DsOdJuI9Eco62LnJAW
         QxIkwq28RN/vhygF6hOotS7WsgT8iujDd1jgwAZkpq5W3ZS8QCxHzyySR2dnHiomRdOc
         A+Dgl48E9x0aqCQHWeZDdtlrRWs8M/MSv9w2EaISNyQg6LQX/A4Plo0MpeqqNKHnBe9i
         nDHUliE5EUKFh64iR6m2vTBghDaFi3wprMZfcpsbcWo+1j83P5rqAHBKj5N2k6azW2fN
         2WAA==
X-Forwarded-Encrypted: i=1; AJvYcCVkwXrh8ShlM3wXfgp0Wx7MUBGeoUyEYUvH0/mOK0rKdoKqPSQrYZB3ZQBVbjq/IxSdRag56IEp8Dv0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9bAWAAOcWxJ61WlNFVdX2sq8eVzKjUAG42TAsdERvKfIlILSk
	gMpCtBdTrBAR5SJSw8cD2Fuu3bAyuDq0WnjhvFTHANt7vDefgMD4kt3KXewwbbg=
X-Google-Smtp-Source: AGHT+IEUkctiVyqefq/YK8UzVAb3G1JlrVxWuRVPIwvQYFeNj0t51VLwtemS/L2Zn+W2U6AWN8z3Tg==
X-Received: by 2002:a05:620a:bc4:b0:7b1:3c19:a665 with SMTP id af79cd13be357-7b3217fd138mr445393985a.19.1730908746378;
        Wed, 06 Nov 2024 07:59:06 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f7b85sm641377285a.31.2024.11.06.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:59:06 -0800 (PST)
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
Subject: [PATCH v6 3/3] acpi,srat: give memory block size advice based on CFMWS alignment
Date: Wed,  6 Nov 2024 10:58:47 -0500
Message-ID: <20241106155847.7985-4-gourry@gourry.net>
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

Capacity is stranded when CFMWS regions are not aligned to block size.
On x86, block size increases with capacity (2G blocks @ 64G capacity).

Use CFMWS base/size to report memory block size alignment advice.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 drivers/acpi/numa/srat.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 44f91f2c6c5d..34b6993e7d6c 100644
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
@@ -338,13 +339,22 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
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
2.43.0


