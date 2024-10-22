Return-Path: <linux-acpi+bounces-8922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD7C9AB8CB
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCECF1C23466
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A926B200115;
	Tue, 22 Oct 2024 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="I2U39Ejh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC41FF7AF
	for <linux-acpi@vger.kernel.org>; Tue, 22 Oct 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632901; cv=none; b=iZ1KJAZ5J8thLy3mqNUIX8zzHsAWIijK/X+72jc4B4WCZotBCBdgF+d8uD4IwD1DdNy5oKNI0h31NvshppZ9tK1M+DhSAcfQw/Pi+h+aKUbLf58HEYFB7EL+7Ok5SXQhczBzhVbPBYINbXZokvHv/ZS6UlW0tDWai06uUpvrlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632901; c=relaxed/simple;
	bh=vPwlrbEZICwJySvKEDe0ketAegKzxYlX66KxGsRhSew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqnyIHtMGiDzI03uNHzgbNBIF/d2E50f+t1C6/q5sI7QR3OchObKkBlABb4o3CEStzmaEUXrtgEiUfltpe3R5GiAKkiiI2vqn8vtYiHNHrpzaQAXtE2HVV+wGvfYJIJ+IbLHcOPoZNKDhHL2PVlWV6vWjfEVfnIj90oq4OGOEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=I2U39Ejh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4609d75e2f8so2158861cf.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Oct 2024 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729632899; x=1730237699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Y78ubexqEa4jb5hMLl30/Xq5Y9Xokfp+mSha683Q8I=;
        b=I2U39EjhyDafxvJfSnhOrjQXXMep4ooXvriCjP1wQOvHxIwk/Gde8GEXrgkeibmbiu
         Nhpovxx5i164KmiGQtSfraPrKpTi7EbvpyFXwCNJ21IZQxmC7RCsfdEvdM8y6efOvK0o
         vtZbiiwgFP3QEupseiAy8xj5xhDaku9GK7uVqskp7PZxSSYmW6wERzxi2XUoAqDxCNDX
         zgTREzS5lzOrwE5E94MkOQRUEu8Jq9WirAGpRpgEllq7nr5nHl7pfx0VqTqQGV7a9oqu
         jekphsVKehOu1btdaaWILQtuDqCZ3uBoneIGqWeGCH7x+0zg0y8yeH3qzVV4n6TH/gcO
         zlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729632899; x=1730237699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Y78ubexqEa4jb5hMLl30/Xq5Y9Xokfp+mSha683Q8I=;
        b=sg4n/vM8swS4v+DcX1rgZY8R+xoBcTY1wkg00IwY8FH5i3n744ReKnJKa2mqprTXa3
         Rod/zi+3ZCUdRkME8EH6BNd14BJJQRN5f0aO6KzoZ2LJ1xJMHhccjcUGknu/HtVFQxzF
         hJB19hp1tzONXlFCqzlveNThq9jCvaP90JMO58wi8t9+b4T6CD5hpy8lJKKWRciB6e4O
         DNGRCoh9j+2UmxJ2cQyV+k2Ac6GWC2mLKKHoSEo2ITfxQznDD7GaeK8dDhJuCpvzglEp
         EK+YxiznJL7FcerpdMg+pj3mviRlMm+I1iyVZ8N2CkWi2NQO7rqjEechQRhsa1hInuY+
         pv9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJAXZCEivU0Y3Y9rxwJq1kRUFQ4l+6SkttiLmjdL/LmT3IfzPU0z0mQuf6vAS5zT4WC1aJlN3Pp9c6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8nemBcYS8qbMqZ1Ftw047J0zgfZp1iJz2gAXnjWHuD+kn6E+e
	ZUHyrVcuAAQo5K/YKHjOlPngCyIRT2mkwVqX42T3Ec6iY0pQMoDS4YxVh59/QlY=
X-Google-Smtp-Source: AGHT+IH7eGA0cnfOQp14jPD3sIr1Ycw9daRo5ztpuW4QPmIXbYkKfaWizk6DGwzl4TxDDXn1JCZDPg==
X-Received: by 2002:ac8:7d04:0:b0:459:a824:a1c2 with SMTP id d75a77b69052e-46114102e22mr12146281cf.22.1729632898984;
        Tue, 22 Oct 2024 14:34:58 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c62f4dsm33845841cf.28.2024.10.22.14.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:34:58 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@kvack.org,
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
Subject: [PATCH v3 3/3] acpi,srat: give memory block size advice based on CFMWS alignment
Date: Tue, 22 Oct 2024 17:34:50 -0400
Message-ID: <20241022213450.15041-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022213450.15041-1-gourry@gourry.net>
References: <20241022213450.15041-1-gourry@gourry.net>
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

After the alignment, the acpi code begins populating numa nodes with
memblocks, so probe the value just prior to lock it in.  All future
callers should be providing advice prior to this point.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/acpi/numa/srat.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 44f91f2c6c5d..35e6f7c17f60 100644
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
@@ -333,6 +334,29 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
 	return 0;
 }
 
+/* Advise memblock on maximum block size to avoid stranded capacity. */
+static int __init acpi_align_cfmws(union acpi_subtable_headers *header,
+				   void *arg, const unsigned long table_end)
+{
+	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
+	u64 start = cfmws->base_hpa;
+	u64 size = cfmws->window_size;
+	unsigned long bz;
+
+	for (bz = SZ_64T; bz >= SZ_256M; bz >>= 1) {
+		if (IS_ALIGNED(start, bz) && IS_ALIGNED(size, bz))
+			break;
+	}
+
+	if (bz >= SZ_256M) {
+		if (memory_block_advise_max_size(bz) < 0)
+			pr_warn("CFMWS: memblock size advise failed\n");
+	} else
+		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
+
+	return 0;
+}
+
 static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 				   void *arg, const unsigned long table_end)
 {
@@ -545,6 +569,15 @@ int __init acpi_numa_init(void)
 	 * Initialize a fake_pxm as the first available PXM to emulate.
 	 */
 
+	/* Align memblock size to CFMW regions if possible */
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_align_cfmws, NULL);
+
+	/*
+	 * Nodes start populating with blocks after this, so probe the max
+	 * block size to prevent it from changing in the future.
+	 */
+	memory_block_probe_max_size();
+
 	/* fake_pxm is the next unused PXM value after SRAT parsing */
 	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
 		if (node_to_pxm_map[i] > fake_pxm)
-- 
2.43.0


