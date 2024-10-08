Return-Path: <linux-acpi+bounces-8604-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED119950DF
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845FA2863CB
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5336C1DF98E;
	Tue,  8 Oct 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="e6ygE81/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14841DF733
	for <linux-acpi@vger.kernel.org>; Tue,  8 Oct 2024 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396052; cv=none; b=BGwQW9XI03/fiKGCg4ICrO+CHWdvgOhNUbsqd8c4B694UsExpmwGAbJu6vGuKpDJgZ9iQibMJJuZ6zGZgc/npvSoQUJF3K3iitBlJWD9yN0F8R6iW5pP56LkrvlsSG4kYnTH7GZRIZ3t5CSaYjQHBFRudQGWBU63Tqe6L11pzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396052; c=relaxed/simple;
	bh=f24xe0s0P5sHWBZEyg+EVqdFYYoHXDXlETSsuM55DQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9saPZJ18VvMMR2Rfs+nlVzH9+sga00oFa+iaAVu/4hNPwq00fY7TF/P6hidXhlGV/cnfXw67CX8IR00SEhyeZWxcQjjtICiDG2zd6UQSXWB7nJBrTGSixPcmQebFXP3W12fj+yuhEbmRtekBrSMoJSrQEP8mZ0BNsYMDIwMztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=e6ygE81/; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbc14b3b08so4794656d6.3
        for <linux-acpi@vger.kernel.org>; Tue, 08 Oct 2024 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728396049; x=1729000849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYVH9bPzhptOKAKA155SqTUHRG9AKR7xI41sAuZER68=;
        b=e6ygE81/SJshv+LRjedykthxtW3UO3MvQQc00UzO3sItolCnpOGN/CSJR5UUHhjz10
         Nm5WpL0LLBo6diEBIPcZpQMDfxyxadhYnnJTnwajnhBbQP/Wyojzuwon6eD9u9lKi/7s
         v44KfQnKGIjvZYmX0VdJPxp556wG2i4m8beb8zW33jnXZD5NA78ndbvH6EpxaEj5k4Mz
         EP1kaafWBz7PFLM4l4kGgBqx8oR0G3kOPrEbjXD3r15/TyujmDLQ7OQ4PPZV5A/rCC+u
         isoSoXleZeyU08ov//WsMKjkzPY08ZRmsG5kSOfaXb6k83/0SMmrN/8aNpAunZvyxs0p
         v8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396049; x=1729000849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYVH9bPzhptOKAKA155SqTUHRG9AKR7xI41sAuZER68=;
        b=tbmIDNMYuu3ml+yov0znMnMDSb1e0xsgZRwuiVmyYS4CNJba+lZf8c+l5KodAMGlDP
         8kJN+kWTLCGERFxUn2LFlcks8pyD53Nn9TLnSMHGFodNQzFUV/h7M/1FFwBzIAG/ZOA5
         9zpfWE3bjRxhnUJJADlWR6pE0FCrAPF/D6XKrLcrtxT5e21PU0Plv8Eyv8BRlk3ImRgC
         mWxcNv5yStxxCFI72pVOyz/O3hExWwwuCchWrcva3egM8oJq/KdnBT5sN6NGXXZ8EvGe
         oXcbmxfad0ec/ArJjhq9fhkb4ct0YjIQXLcKpN2MSbsIDrj/wDqnYUSfQNK7HvObuaD8
         CgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFlUzXfa6Dn8A6ksMI1rdl593h2Y/LqqT16FJ7knOviXlbEuvMcpqgOnw27pLBy7qRf8vTOv0TpM3P@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZKcRYUW+ZR7kfPZcN9NWWEQod2OtdW8b8VhkZhiMpy/xUdTs
	LA2LR8AHSkIq8jnrlqg352a6I9c38EMJKgQVotm3yQXbPq6sCqY7QlFBbUUQabw=
X-Google-Smtp-Source: AGHT+IH1G8ITusE7F8TZWngF/LW6FSnDnTSAvzMp2nN4Kfl3aRMl8OFWOkAOoxtA/bT+IIYMoMEjDg==
X-Received: by 2002:a05:6214:2b91:b0:6cb:5eea:8a3e with SMTP id 6a1803df08f44-6cb9a2ed3d2mr210771516d6.10.1728396048953;
        Tue, 08 Oct 2024 07:00:48 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbc78650efsm698396d6.39.2024.10.08.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:00:48 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@Huawei.com,
	alison.schofield@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com,
	lenb@kernel.org,
	dave.jiang@intel.com,
	ira.weiny@intel.com
Subject: [PATCH 1/3] memory: extern memory_block_size_bytes and set_memory_block_size_order
Date: Tue,  8 Oct 2024 00:43:53 -0400
Message-ID: <20241008044355.4325-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008044355.4325-1-gourry@gourry.net>
References: <20241008044355.4325-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CXL systems, block alignment may be as small as 256MB, which may
require a resize of the block size during initialization.  This is done
in the ACPI driver, so the resize function need to be made available.

Presently, only x86 provides the functionality to resize memory
block sizes.  Wire up a weak stub for set_memory_block_size_order,
similar to memory_block_size_bytes, that simply returns -ENODEV.

Since set_memory_block_size_order is now extern, we also need to
drop the __init macro.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 arch/x86/mm/init_64.c  | 2 +-
 drivers/base/memory.c  | 6 ++++++
 include/linux/memory.h | 4 ++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..6086f99449fa 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1424,7 +1424,7 @@ void mark_rodata_ro(void)
 
 /* Adjustable memory block size */
 static unsigned long set_memory_block_size;
-int __init set_memory_block_size_order(unsigned int order)
+int set_memory_block_size_order(unsigned int order)
 {
 	unsigned long size = 1UL << order;
 
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 67858eeb92ed..f9045642f69e 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -110,6 +110,12 @@ static void memory_block_release(struct device *dev)
 	kfree(mem);
 }
 
+int __weak set_memory_block_size_order(unsigned int order)
+{
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(set_memory_block_size_order);
+
 unsigned long __weak memory_block_size_bytes(void)
 {
 	return MIN_MEMORY_BLOCK_SIZE;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index c0afee5d126e..c57706178354 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -86,8 +86,8 @@ struct memory_block {
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
-unsigned long memory_block_size_bytes(void);
-int set_memory_block_size_order(unsigned int order);
+extern unsigned long memory_block_size_bytes(void);
+extern int set_memory_block_size_order(unsigned int order);
 
 /* These states are exposed to userspace as text strings in sysfs */
 #define	MEM_ONLINE		(1<<0) /* exposed to userspace */
-- 
2.43.0


