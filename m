Return-Path: <linux-acpi+bounces-9237-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E9D9B9252
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 14:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DB51C2180F
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414931A7261;
	Fri,  1 Nov 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lQF5mFq+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413CB1A071E
	for <linux-acpi@vger.kernel.org>; Fri,  1 Nov 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468843; cv=none; b=EfkNIPy2tAk7ervfy41kKNM10yDO//QRrcpKeCSAOq289OHJTiu6QZ47ZCmA8aYhmNYlFvAjXkNSufs3/eUK5fLgKyVwJs/B1BY31+iKrfNSP7YN8tbwStkmxHjy2jqGv+n1Kcw07MOkdw0ABVxfTBLjd08wQw1toexkXrJy3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468843; c=relaxed/simple;
	bh=w/E90TDRcavpiLD6UuAlqK6J3Z+bDO28CswOLV8SvO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4ZJy3xfltZa2/UJWkDw9dQhEh9yKkW55Y6b9BM2TOUF2Q0qLAStnpbOPAIkea7yTPO2PNcvsv9dq9NGgtD4VoCfvYVL7lwyfSJUCM936UVx8odETceJ4k05wCBaeSqlxO4TPH6SeoCMeSU15kPDRSUCRzd35aic0+k7OpRgZ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lQF5mFq+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4609beb631aso13305371cf.2
        for <linux-acpi@vger.kernel.org>; Fri, 01 Nov 2024 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730468840; x=1731073640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+zdKugU7xiryBghEkTtjHu3m1t20HIVG0keEZ55skE=;
        b=lQF5mFq+8i6gXEumXeFamDXeFhH+8jUdL4ewTWNI3J5bSG7CC0UWTCmxSmbtcRBxom
         16yoSe4ScQeZI+60P1gTQw799L3nRcF64Wjcsy5+COKycAYcr0Za4RVvIRgNTaMitXM/
         DEBlRmrMMKX+X831rjZEW7/57B8sHXIGDPzPZsSUsyxCJ2qTTFpOoql3mZkJ/B/REXb2
         eNhwrTM/0YXgv9xi1+utA+5jIghu6t6CrqIghaO0P/cDtQE9UzQh9BsBEqtW72T1P+X3
         bp2TPU2EfUYBwv8ZEyEPGeLGlemC7YEGoZVG31vBV3TQcs2zalzO+6AyJdQsfIXSMYb8
         +Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468840; x=1731073640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+zdKugU7xiryBghEkTtjHu3m1t20HIVG0keEZ55skE=;
        b=LeUDFC9s1BYmeba+BZEH6STvrABaK/vbDHJ6kLaLh8XAEHw05Qe3zjPyr45na6i8cn
         rYoMMG9JhKjgHBMbpColKjJ3byWBZNX/U45gC8mKZaBy/wHzfuV1FR/ZQRyxuRb2N/xE
         fvbQK1qntreUiYSgz3uuKieV93jbTUVsWcnAlQnP9RoS4ueAQbIfH1GRPD26CJpx8jYV
         Qn7ayXNwRIzoIlbAwbzuQogpyblW+q3Nt6eUV/RFa1TxzvR+CeZoHB9c+omCoD2JMJ+L
         fX7JHN4/HraWE/zVvF3Y3GBr83js4SjWxI0rdv2gH0tjkVMTTIcmk/7OaCBFMbyb2M6J
         y8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7LQERlVR8ppKPx5MOPbJngUfeP0Rli568nwRHVoQmKfclJ9X7FLPu+fT4LlmCBRpbRWg8i0Gve95S@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0HZ8lOOTyJF/1xYOK0bVh+tjsiwMoriedq0oraeDWJ1VUFgC3
	yQxsJCYmScO+e4+sR+P3mHaoK5Do09oS4lGk4781u9ATauxkchLcmBZCKYkMRNo=
X-Google-Smtp-Source: AGHT+IEqYRg/5UZkjuUahc1kZYI/R3+uQRVmb1D8Hw7IJxtfAawWOive+EatrYV0MOKL9iMFUrnP5A==
X-Received: by 2002:ac8:5acc:0:b0:461:15a1:7889 with SMTP id d75a77b69052e-462b8680102mr46144121cf.16.1730468840141;
        Fri, 01 Nov 2024 06:47:20 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com ([50.193.156.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0cac07sm18840631cf.48.2024.11.01.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:47:19 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
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
Subject: [PATCH v5 3/3] acpi,srat: give memory block size advice based on CFMWS alignment
Date: Fri,  1 Nov 2024 09:47:05 -0400
Message-ID: <20241101134706.1185-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101134706.1185-1-gourry@gourry.net>
References: <20241101134706.1185-1-gourry@gourry.net>
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


