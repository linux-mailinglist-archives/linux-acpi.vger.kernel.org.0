Return-Path: <linux-acpi+bounces-8824-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2AF9A1278
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 21:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8131C2221E
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 19:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16D62170B2;
	Wed, 16 Oct 2024 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mPKEV0fu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C8216A26
	for <linux-acpi@vger.kernel.org>; Wed, 16 Oct 2024 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106720; cv=none; b=uOxXd5AxJ4aL18WTuxQ1Ho+7hAT02HT5pDQgTgR5ZE4af8VDOfloJNv0DcBbmdo7jKZ9Gg1059HPUzrytflZE0vp3ztj1t/WSyRqGiL4ujXzH6pz2EjfYAX6NPvO2N/6rbaWrV5JbjD+9Dn2hq5Bvbq5wMriaOo7mohh/2l3Hws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106720; c=relaxed/simple;
	bh=5d0MbCIw8EE2ZSOCUaim9gDCiiqCphBCQxQbxbqbXHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcTG1c/4sXxmasXhoG+2ARt6IGDo3s41B88vdMtZwn3G3DMqntLLmcotS7pVcsujOX8qRLrenxmmYFTLAHQaoaK/gWgOdRbcL360lVZwmyd2xT5+11RnLkDtvSwW89sW/dtoaLxZdMYeMHXluNuueNWSGFyC4tP+V3qxz8SacXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mPKEV0fu; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4a46b6affeaso38564137.2
        for <linux-acpi@vger.kernel.org>; Wed, 16 Oct 2024 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729106718; x=1729711518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrmbhAeCdsnN6DuwhCdjgoaV0xg9bEsX7zAMN4X3gqU=;
        b=mPKEV0fuQxrYnrKL/HSLmS3sJ2k+KOxcrykrrDwRBvQur6XljwNuA7m1D4FsWjTxkT
         p3aDYUXaNUHuXhVeWVHYnQwVBjkuxjCSW8eYi+Xs1JuTt2zALQeTx4PvekEuFcd+52pf
         hEQqA+nguO8ErvQ2Tiovn9GDWCym76ilBr1hkCUuwyZyh/YzDpZ3fcsxzXnlDgn7Sm4g
         pPtsnAu0Li8ddrtlMvsGC2Imk/a/KK3DirPg7B2wQl2qaLOmm20WdtWGXS0S6XsR1DNn
         hQua5qAsMyimY4E1YAsCQzSkpnjmTCSWbuT0O99UtX8noO39lLUhI3kytPGPTR/U8B+b
         VJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106718; x=1729711518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrmbhAeCdsnN6DuwhCdjgoaV0xg9bEsX7zAMN4X3gqU=;
        b=a2DyDueBsopwogLHALcFhVkuZ2x1PxcFH8ZMFoJzszljqI6yh3g6h2aCl54Pw6lWWZ
         kse6nMDXHQ2Ea0jWc+4fEbFnp9hzRttyiHZCeep8uLidn03hwEH88BE12fWvSI25JtOT
         IWGxwXDwPQmicQy3tdJIfzQorW9/hNL7mpr+t2OraQbLs3ZISoXFWPNiepTEcr4fW6a6
         H9DEyn7I1ywYJw0CmSE6Fesqjlq7dxh7lXmUk74FFWR/kZnxJ5m1BgYhk01N/Ab4eQGX
         XXciJ5cp7FogfGps/ylVS8GIyjQYVAnm+nLwP2q0wmMNOdD0L4bwZd+skoOSPj0ca3L1
         64aw==
X-Forwarded-Encrypted: i=1; AJvYcCUDxP21qJAnkkor+xn90M9+UV068vAufIuXu/xbP/Bq0nmHmngeo3K65mjDIsS7GzL3vYAY/hbWAIm6@vger.kernel.org
X-Gm-Message-State: AOJu0YwRnJULdw1GD4UEbRRZkFbdXqEOOyBwYTrTB7IKbPWNIQ4LRpz3
	KiX6hbRgWOrY4lOkL7Z1bF8sFkTV7hH12dtkIzgtIPPBaut5FK14533sPocnRy4=
X-Google-Smtp-Source: AGHT+IFClvWp9HyykvU9mzj84/mtwGebanX8vIYbiVaXquh13pEcA6fQ2yrNp4hn0Qu9cQWW9s3xDg==
X-Received: by 2002:a05:6102:d92:b0:4a5:ba70:1c6e with SMTP id ada2fe7eead31-4a5ba702ba3mr3418941137.29.1729106718285;
        Wed, 16 Oct 2024 12:25:18 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b38ce69sm20271651cf.90.2024.10.16.12.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:25:17 -0700 (PDT)
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
Subject: [PATCH v2 3/3] acpi,srat: reduce memory block size if CFMWS has a smaller alignment
Date: Wed, 16 Oct 2024 15:24:45 -0400
Message-ID: <20241016192445.3118-4-gourry@gourry.net>
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

The CXL Fixed Memory Window allows for memory aligned down to the
size of 256MB.  However, by default on x86, memory blocks increase
in size as total System RAM capacity increases. On x86, this caps
out at 2G when 64GB of System RAM is reached.

When the CFMWS regions are not aligned to memory block size, this
results in lost capacity on either side of the alignment.

Parse all CFMWS to detect the largest common denomenator among all
regions, and advise memblock to reduce the block size accordingly.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/acpi/numa/srat.c | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 44f91f2c6c5d..5fc03a99570e 100644
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
@@ -333,6 +334,35 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
 	return 0;
 }
 
+/*
+ * CXL allows CFMW to be aligned along 256MB boundaries, but large memory
+ * systems default to larger alignments (2GB on x86). Misalignments can
+ * cause some capacity to become unreachable. Calculate the largest supported
+ * alignment for all CFMW to maximize the amount of mappable capacity.
+ */
+static int __init acpi_align_cfmws(union acpi_subtable_headers *header,
+				   void *arg, const unsigned long table_end)
+{
+	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
+	u64 start = cfmws->base_hpa;
+	u64 size = cfmws->window_size;
+	unsigned long *fin_bz = arg;
+	unsigned long bz;
+
+	for (bz = SZ_64T; bz >= SZ_256M; bz >>= 1) {
+		if (IS_ALIGNED(start, bz) && IS_ALIGNED(size, bz))
+			break;
+	}
+
+	/* Only adjust downward, we never want to increase block size */
+	if (bz < *fin_bz && bz >= SZ_256M)
+		*fin_bz = bz;
+	else if (bz < SZ_256M)
+		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
+
+	return 0;
+}
+
 static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 				   void *arg, const unsigned long table_end)
 {
@@ -501,6 +531,7 @@ acpi_table_parse_srat(enum acpi_srat_type id,
 int __init acpi_numa_init(void)
 {
 	int i, fake_pxm, cnt = 0;
+	unsigned long bz = SZ_64T;
 
 	if (acpi_disabled)
 		return -EINVAL;
@@ -552,6 +583,17 @@ int __init acpi_numa_init(void)
 	}
 	last_real_pxm = fake_pxm;
 	fake_pxm++;
+
+	/* Calculate and set largest supported memory block size alignment */
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_align_cfmws, &bz);
+	if (bz >= SZ_256M) {
+		if (memblock_advise_size_order(ffs(bz)-1) < 0)
+			pr_warn("CFMWS: memblock size advise failed\n");
+		else
+			pr_info("CFMWS: memblock advised size(%ld)\n", bz);
+	}
+
+	/* Then parse and fill the numa nodes with the described memory */
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
 			      &fake_pxm);
 
-- 
2.43.0


