Return-Path: <linux-acpi+bounces-8417-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A5E98638E
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031CA1F220B7
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F4113AA38;
	Wed, 25 Sep 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gZGwU3h5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E086E614
	for <linux-acpi@vger.kernel.org>; Wed, 25 Sep 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277921; cv=none; b=Y2UYr1e4ga1R5EbVD4GJib+DFysqHlsje7BWalgZzgN16vvg/IramVjuUeFU88BQykzaGdJyv/001M1m5Ybs8qkWQtojtYB6XNx6Dt07np9yJDfqpeNAqEWZ3CJTZoHIdXqmES71mQfnNNJkevlf4ON4ii0gcDim9T6F8L0dBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277921; c=relaxed/simple;
	bh=4NzR5DidyoUmrZ+K4uxE/Z4IXAaQsNqkWmWjxvs3iYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQQt9cSJQ25U4CDctQgL/NJiOJm9k1+wbZ2d3j0F+gogs9bPi3r7CzC3O+0dwf6h6s7KD3YsLeljFq3bvO/2bAUJrpp+pADOCZ6zLR2DCdNbKPBCGM25gHHNrAfgYKT7XCxShb5QwVuIJlbUBbReTn5TCCn0Ae7ZslQ20znnL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gZGwU3h5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb2ad51162so38556d6.3
        for <linux-acpi@vger.kernel.org>; Wed, 25 Sep 2024 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727277918; x=1727882718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hGdMDbh9UwXnFNGPPTkVVdPgZQuI/AwB7by/k6hdyY=;
        b=gZGwU3h5M/qbKdJw0tXpKvFFYq7mMahz6WxKSJTwrWD0JvKMcupMto1bUiZefr1xJB
         Tnad00H/+EMb2h15ul0ZgGAu/K6HE93EA2Svi+LMNsgVnCsW7K2p2x3zZ+maurUlXAC+
         IPwyo18+9kb+GUWRMtpTG0jGOIB+sl18gBIxES51Knzx64TNQc0E/9Ov+R/VPro4U+qc
         zuOXIMz3adTbXjr0lfPNZu9Ya/nH0DT04UbYs+ARM2u+9oNdBGuQjj+EAEy2wg+/+zD4
         BjuXQdahJ2Wyw8HDHlP/tNsDk10naE9C2lfxtwHQzEwxBa+lvr412Ptnxj+lojJswOfF
         PrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727277918; x=1727882718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hGdMDbh9UwXnFNGPPTkVVdPgZQuI/AwB7by/k6hdyY=;
        b=rIwQnAKC0XHPmu46nkm+zD88O4hcGIqNJJ8sWsd7+2zR4B2Ei1BE+HAXJas0naszCl
         trF6vLeAxg8cdiwrlzAwkU6EuAAWgikpeVG1HW7HsrRkBb0tlMs+KU1BAZs+rS9iYcr8
         ujgtYQFlF5brv5W+fom4PUxLpOpxGLaSe8QYMv9oU9HM2xJBUddVejyt+BenBTEegw1B
         +klXhZ3BB7wBOlPnhpAxe1ZxIQ1Ax2Ov3pN7qSQAjStl3RmZVT1JVE75Njy/qVFRrk77
         +63Ji6EsjjmnvdqBKhNGVQBrT1ZmvRciqO8TlWthxYuCx7f40N2r7dbMTZg1c4LbcNOV
         /ybA==
X-Gm-Message-State: AOJu0Yx5VUI3UYAdQizea3TC1oGAVsA/53CQbRRFihfr54o40hOAjJQ2
	ZBmZX7ZmLhzV9JOQrPbZjGYCaB0etJ+4yeiLQzFFJ0KUBfifsYMyTWZuAtc9Dg1ShNtJUezT3y4
	t
X-Google-Smtp-Source: AGHT+IE8TN9DFo2XaKG3bw9ola+OVqnHsX+9dbOdRMmzQMA3REfDiTueYYqSEpdhSgbt26BHpwX0sA==
X-Received: by 2002:a05:6214:17c1:b0:6cb:21e9:aba8 with SMTP id 6a1803df08f44-6cb21e9ac79mr24554266d6.3.1727277918201;
        Wed, 25 Sep 2024 08:25:18 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb254ead6fsm4583356d6.26.2024.09.25.08.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:25:17 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-acpi@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	rrichter@amd.com,
	ytcoode@gmail.com,
	gourry@gourry.net,
	dave.jiang@intel.com,
	haibo1.xu@intel.com
Subject: [RFC PATCH 2/2] acpi,srat: reduce memory block size if CFMWS has a smaller alignment
Date: Wed, 25 Sep 2024 00:52:42 -0400
Message-ID: <20240925045242.3735-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925045242.3735-1-gourry@gourry.net>
References: <20240925045242.3735-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL Fixed Memory Window allows for memory aligned down to the
size of 256MB.  However, by default, memory blocks increase in size
as total System RAM capacity increases. On x86, this caps out at
2G when 64GB of System RAM is reached.

When the CFMWS regions are not 2GB aligned, this results in lost
capacity on either side of the alignment - regardless of if the
memory is mapped as normal system ram or hotplug.

In ACPI, when the CFMWS is parsed, reduce the block size to the
smallest amount detected if it is less than 2GB.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/acpi/numa/srat.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 44f91f2c6c5d..5074e6158dc7 100644
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
+ * CXL allows CFMW to be aligned along 256MB boundaries, but larger
+ * memory systems typically default to ~2GB memory boundaries for
+ * memblocks. Calculate the largest supported alignment for all CFMWS.
+ *
+ * Only adjust downward if less than 2G, and error on invalid alignment.
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
+	for (bz = SZ_2G; bz >= SZ_256M; bz >>= 1) {
+		if (IS_ALIGNED(start, bz) && IS_ALIGNED(size, bz))
+			break;
+	}
+
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
@@ -501,6 +531,8 @@ acpi_table_parse_srat(enum acpi_srat_type id,
 int __init acpi_numa_init(void)
 {
 	int i, fake_pxm, cnt = 0;
+	unsigned long block_sz = memory_block_size_bytes();
+	unsigned long cfmw_align = block_sz;
 
 	if (acpi_disabled)
 		return -EINVAL;
@@ -552,6 +584,18 @@ int __init acpi_numa_init(void)
 	}
 	last_real_pxm = fake_pxm;
 	fake_pxm++;
+
+	/*
+	 * First parse the CFMWS to determine if the memory block size
+	 * should be smaller than 2G. We don't care about larger sizes,
+	 * this simply avoids losing memory to smaller alignements.
+	 */
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_align_cfmws,
+			      &cfmw_align);
+	if (cfmw_align < block_sz && cfmw_align >= SZ_256M)
+		set_memory_block_size_order(ffs(cfmw_align)-1);
+
+	/* Then we need to make a pass to fill the numa nodes */
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
 			      &fake_pxm);
 
-- 
2.43.0


