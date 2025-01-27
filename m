Return-Path: <linux-acpi+bounces-10846-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD8BA1D9A4
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 16:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578DE7A4677
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409581553AB;
	Mon, 27 Jan 2025 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="I6Qihem8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A8150997
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jan 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737992061; cv=none; b=jP9Mf2QDTn1KN0zgKtWcUnrOj5fc+h5O5qo4mc2rP0DZJf9H0tJinkKNuxbnNAETakiwXcr2nazmZZzwqvf1XyjKHdeOTR9EINhLTUuUFnKKoxmDPnm7KoN/gpk7/a0iJSWuwhA8jcVEw4G2J/TS81kcPsVcuvaLraeJrF/P9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737992061; c=relaxed/simple;
	bh=V5XzW7xlrKvXPXLFvpi5tASensizwqikatEr538IoTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMB74Mtr9WzaRk1EFkVesf1xNwdh202c5GeanxXDSRk25ms+24SQ5xcfcNWsr1r8kcGVkIRZHRItqoS8Zq/cKWvFSpsidmJGEorLyYGDr+cMf5gucYGeSdW2d0AKYMGHNifh8pOtsXlwcyvzkLC9H7cT5xVXh5c7fNLLqdWL3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=I6Qihem8; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso46791276d6.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jan 2025 07:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1737992058; x=1738596858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2QKacaR1w2J0DOe/2A1iWnNo84Ql16Satbz8d4J348=;
        b=I6Qihem8NkNlByKXTVIOrHtSfvD6cEaI2153UUHcAIOPJyPivhUovH3TYW4lrlVd5t
         Jeh14cZc2ckY1pcYgKN3sEFW6Z4tTwrievFQtAkVy4DHkf+vT7DyaDxxwhjPXru2kUyp
         AsD/OjyUWvx0udby4wvvV0sKXv+DKMLFtfRaixIK2WE0fYugqI5tL7tfLXqSJHOe6PXq
         ZzilYMrnFWPU3gc965sG1J5Ty30mlwf0dX6LJtSwWPTw+hA5JO4qR+a3l9VVs3PP3rZ+
         W8NKnyj6Y38xutKIv7muyZAIXAj1qJ7P0M/sRPUrBuIp5z+SaoBDXmeTuRMb6gwpomWf
         QRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737992058; x=1738596858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2QKacaR1w2J0DOe/2A1iWnNo84Ql16Satbz8d4J348=;
        b=LYoMecQuriBSWiC7XoLsbxNSQSQT7+Eq+hglHehCNCyB+BrpyySzyDdR9ZIeD/2tfn
         zheo1fVcipev2YRdXRq1VQ79v/5lO9pTbP+mMygDMAD7pFxf12Nm1DsgeDKdxNYL44sF
         gJ85sUnIEQiQ1H+taQRwJtK4Ej+ynBnUn/+621QROuK83W6BJN7y1TM37D7HA6Kqcmgt
         e6yRAqgqOWOCvHOWJLeeV/WYjLxpjfKHnCFE+UeN61swBCg40MaJ52rP3nayi98KXIad
         VxZb0hpkgxOylWWpii0hpgzuYftpImwyb7nfvU4hyF3WESrT9/SARtGFDUAFpfDeDhgY
         mNGA==
X-Forwarded-Encrypted: i=1; AJvYcCVEWfbkJIWwlLigWBNaNgSEsIkXSY4lQfZSa2Z4iWcUqHzYahnNvkeKBb/6VsushyNWeoOSjdnZ00/l@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WGtgEywVN+QzRWwtV8ARtDjJBR0dBjeDQDof7D6d+swG9jMK
	91lZt+9FjS38dXFacQO7QFrpr6bs4kARKdTlFbQIg6F8eVYcunyIwmcUKkOsY/I=
X-Gm-Gg: ASbGncsqnX9ibxOgNu2McTLQ8VNWpI4+BA+2U0UbWkCLqfnUXQHeyED/uuvjwN+KYf9
	kMuH2+r5p7nPmbn+FPf3wtzjxvAHn3lB2rFE1GEpzOm76pdAUfrpQ4CgKAN9hjMt+a7Sc+6+T6V
	M2/vBpq7GL/aHK8jPQ/e7yTxdxW4/93qu1v7R5ka3gz2NsVqq/rPYu/5cM05mDVInq3z5zB4YFZ
	bVMZruPpjvgEoZKRBEE0U3bYUzb/7L1wwfEIoWChHMLNF5Sa0CpS/kUIM3Qvqu0TfD7JfvAryLI
	ZqacAavt0dsK/iexR9sgCXlgbUnnkIiGW25+xMX3289nu2h9YZ05g+wEsBxpki/zjsBb
X-Google-Smtp-Source: AGHT+IEloh1Kwttg6pCvanJlLHnirCN2YmmH2PFhQey08HdVHFNPfJ5MgRHGu5KGGQRd7g7bqkubRw==
X-Received: by 2002:a05:6214:2584:b0:6cb:ee08:c1e8 with SMTP id 6a1803df08f44-6e1b21b7b81mr667790436d6.23.1737992058363;
        Mon, 27 Jan 2025 07:34:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2058c2a51sm35380476d6.109.2025.01.27.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 07:34:18 -0800 (PST)
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
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v8 3/3] acpi,srat: give memory block size advice based on CFMWS alignment
Date: Mon, 27 Jan 2025 10:34:05 -0500
Message-ID: <20250127153405.3379117-4-gourry@gourry.net>
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

Capacity is stranded when CFMWS regions are not aligned to block size.
On x86, block size increases with capacity (2G blocks @ 64G capacity).

Use CFMWS base/size to report memory block size alignment advice.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/acpi/numa/srat.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 59fffe34c9d0..1501a9bb3936 100644
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
@@ -425,13 +426,23 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 {
 	struct acpi_cedt_cfmws *cfmws;
 	int *fake_pxm = arg;
-	u64 start, end;
+	u64 start, end, align;
 	int node;
+	int err;
 
 	cfmws = (struct acpi_cedt_cfmws *)header;
 	start = cfmws->base_hpa;
 	end = cfmws->base_hpa + cfmws->window_size;
 
+	/* Align memblock size to CFMW regions if possible */
+	align = 1UL << __ffs(start | end);
+	if (align >= SZ_256M) {
+		err = memory_block_advise_max_size(align);
+		if (err)
+			pr_warn("CFMWS: memblock size advise failed (%d)\n", err);
+	} else
+		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
+
 	/*
 	 * The SRAT may have already described NUMA details for all,
 	 * or a portion of, this CFMWS HPA range. Extend the memblks
-- 
2.48.1


