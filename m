Return-Path: <linux-acpi+bounces-7075-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE9C93DA46
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 23:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1961F22134
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 21:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA91494DB;
	Fri, 26 Jul 2024 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CMuSz0vD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBAB79952
	for <linux-acpi@vger.kernel.org>; Fri, 26 Jul 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722030965; cv=none; b=eMti37FB85UT8g0aFEZUR6hty8Bh0E/IAB16XMtUEOEQS6o/NklRbFiqDCMO4JZNyfX6XJceIEFDc4mR80VTpIgUUfBh4tM2FEWyVP41OC/6s9EI/Cb/+Or830mwRgNTpl+1QIx/Ul/jIqRLY3p+0M4gamlhi2ZaTpeGFcmKECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722030965; c=relaxed/simple;
	bh=YoJiPshgJkcuazzZoSi0oZDPlQBuO7UcJEB+03ez1JY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRnozuFteTzBN08MsI6XAnd6CUDx/unfavokPQY8i/w6hRNsNC823WxJuvbZNoDglGf2urGSmfO/duXpOp5l9Km91qU00vOXtxSrS3/O0e+WVRFqbTL3JFh2bE6qyXbFHfSuYeO8lzEeCWFxa33CyWPqri37X3B/lw9VYK7ejSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CMuSz0vD; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79f19f19059so70510385a.0
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jul 2024 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1722030962; x=1722635762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vYo20ihtC42TqqCCz+7a2VTWK+V1RqG4C3Nqajh31so=;
        b=CMuSz0vDZIcLZ/NRl1z7XIesKPKtiJaKvheIiY2tFS7dBW6Txz6DpnRcV0iCUMaNbg
         nfaf4RonvLSSImuFIwaOTKk9TJiZkKFxMrknao1wqjG+JFnpn8i5zJslJtO+2w/zeoQU
         8mmcwQ745Wob3Q6xG//lmjWJQ43bU8LMRc90YR8XpbzOoGukbOfk60P2m3EP6yahP+w0
         jvhxW1sAsbIHriLU1sVcnAGPhwrUAM9V5pdsFn7+7RwN0JMq14BUwRGMrpJZzgk2j4o/
         gbreM4qG7I9ZqnVJCxzqkB+G/CQUvLJsQgLuoqow+UBQMjeUWxnebcJqG4/IjwnnYBOe
         yQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722030962; x=1722635762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYo20ihtC42TqqCCz+7a2VTWK+V1RqG4C3Nqajh31so=;
        b=GE9ahX6Pah3pTFemJUbXE4NF0x5yiOCbsY9xapqs55pvtgsfYT82N1MxvEVTa2Uv2d
         yh9+tNUCjeWjH4IqNcLfcoqubugt+Vxn66rkthz5YuEFnOUgbd/ELO64udk43PHNIC1P
         cx/HV60PP4P9iII1ng0MZY+kw8f99whzI9HASffvIYn/N+KFIC6VgNadQMlyB7gqwZSy
         CTK7GD8M2IO097aQhtCpUmC4CXuj8uEuxda7R21Q6o2lbSArbCiF8d8FCIvD9kZms9uN
         /yE2M1k9Sz57f84+TviZykTvCqfrkfX7qgv9Vx4RPW9OiOWZl0QfocSdndbcXD+AP0I4
         GO7A==
X-Forwarded-Encrypted: i=1; AJvYcCU0TS4dxv8/RQ52iuCrlMJRRubxF0hGB2o1iqqNxLr0DahBtdaTfZE7UUpiKtlpO/24eDDNwiFOBwFLDvHXMyl5KOwZsxUVVlyNlg==
X-Gm-Message-State: AOJu0YwJPJAVH7qciRK55WjdRYAJTw+lkh/McJBR+Cig7FTiWORCfoal
	0BVJcNOYnPuUjCrtXxVTfCXU8/33VKWn5+bwhL0d7j3Mb3DN+RTzbSC+MYmcOIE=
X-Google-Smtp-Source: AGHT+IFUA/fLnYCWnsDHvFpZtDoWfetBhvPxCxdD6Yap2Sp22Tks1MSFqHnaHQ+QoyS/S2H4JSnUuQ==
X-Received: by 2002:a05:620a:171e:b0:79f:108e:249d with SMTP id af79cd13be357-7a1e52f046cmr145741285a.60.1722030962254;
        Fri, 26 Jul 2024 14:56:02 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7398d3asm215044985a.7.2024.07.26.14.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 14:56:01 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	ying.huang@intel.com,
	dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com,
	horenchuang@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	dan.j.williams@intel.com,
	lenb@kernel.org
Subject: [PATCH] acpi/hmat,mm/memtier: always register hmat adist calculation callback
Date: Fri, 26 Jul 2024 17:55:48 -0400
Message-ID: <20240726215548.10653-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the event that hmat data is not available for the DRAM tier,
or if it is invalid (bandwidth or latency is 0), we can still register
a callback to calculate the abstract distance for non-cpu nodes
and simply assign it a different tier manually.

In the case where DRAM HMAT values are missing or not sane we
manually assign adist=(MEMTIER_ADISTANCE_DRAM + MEMTIER_CHUNK_SIZE).

If the HMAT data for the non-cpu tier is invalid (e.g. bw = 0), we
cannot reasonable determine where to place the tier, so it will default
to MEMTIER_ADISTANCE_DRAM (which is the existing behavior).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/acpi/numa/hmat.c |  6 ++++--
 mm/memory-tiers.c        | 10 ++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2c8ccc91ebe6..1642d2bd83b5 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -1080,8 +1080,10 @@ static __init int hmat_init(void)
 	if (hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
 		goto out_put;
 
-	if (!hmat_set_default_dram_perf())
-		register_mt_adistance_algorithm(&hmat_adist_nb);
+	if (hmat_set_default_dram_perf())
+		pr_notice("Failed to set default dram perf\n");
+
+	register_mt_adistance_algorithm(&hmat_adist_nb);
 
 	return 0;
 out_put:
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 6632102bd5c9..43bd508938ae 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -765,8 +765,14 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 	    perf->read_bandwidth + perf->write_bandwidth == 0)
 		return -EINVAL;
 
-	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
-		return -ENOENT;
+	/*
+	 * If the DRAM tier did not have valid HMAT data, we can instead just
+	 * assume that the non-cpu numa nodes are 1 tier below cpu nodes
+	 */
+	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
+		*adist = MEMTIER_ADISTANCE_DRAM + MEMTIER_CHUNK_SIZE;
+		return 0;
+	}
 
 	/*
 	 * The abstract distance of a memory node is in direct proportion to
-- 
2.43.0


