Return-Path: <linux-acpi+bounces-8918-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448E79AB8C2
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEC4B230CB
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631981FE0EF;
	Tue, 22 Oct 2024 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ekCC9UkA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2D1FBC80
	for <linux-acpi@vger.kernel.org>; Tue, 22 Oct 2024 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632896; cv=none; b=F9KF36xv5AW7bGBxvFLXf3Qk/y5T+LmXU0doA7x0VYsuulTrcDmi8dMt0jrwLQN+hDldKXPMoE6gGFWWCtPirFCvuMq8RPUhLKwgJj4FgtJSXMoGeMtFWwnQkJxZyWmhVm0w22F86UkygKC1BVFHgM76qnH8iNH7CPOArDhSrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632896; c=relaxed/simple;
	bh=72lvWaZVrGD5CN/tN9hRoU+ByQZLYWyjLH11N4oA4Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOM78W+GaYHbTkpFoRqOwLmF/P9h8CdZFnKyZxsM/ca8gPLPPFDP+mzLY2hBdfa5sdPwRKwXYe2L7EW1XPXm8SFzRnJRDHH6Rawb7hCOs64x6Lzhyveey0paSfPQRdNfX+8vWNHOpFfE//O5csN1ANVPtcc/H22UDRyd5W/Ggtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ekCC9UkA; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84fc1a5e65bso1777878241.2
        for <linux-acpi@vger.kernel.org>; Tue, 22 Oct 2024 14:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729632893; x=1730237693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufKC44gX2rTxHnQ7e/iieQk2KCFejx60Yu8CtfOC82k=;
        b=ekCC9UkA7HGcDb+gU9nt3WT/Ko16sornmZ0xWFUuznEIUjoN4A1AK5BpvA545P8lf/
         77Z895PRVVelKrK2iWnHEEBczsACczIG0KVa7G1u5bTNO+XCXPTIpG2Yj6m9dK122VRP
         UBzUVaQBSinudRDDcsI85eLJsyu3DAqp0VJXn6aczdBJDbCBkT2LG99uX1zKmOPpTE0U
         wMqT7PtbLcEHmkl92y8kQczvUMjjY+pMuqYdpN9TojXEcm20W8HQHWPfZ8y0yq1RBmPk
         BBpOcfe/gKSV0EkIZauTXOG+gt/ky028pdwJa9lTO/TZ44minSYYKyAE8LajYyVWjv98
         i54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729632893; x=1730237693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufKC44gX2rTxHnQ7e/iieQk2KCFejx60Yu8CtfOC82k=;
        b=MqNn6EzPh/XcpEpvrpAis/AR9swae/P9/UJhL9KIyvetelyM/Eyl9VuPC0f89cazlj
         UnrUABlk2cnl4CFREMnyqfSLGun7kU2OSSk1cdK44aqb3sV5D/8oprhYqjs+dgF3jYCU
         NApak6iC0K6jlB0vOtGj3JxTRHHvCiosfrntVP1R47sTWywcS3XpjoH4UhJMCAnOJLho
         cDWbg+xu8tmYk7pD8qYRmLDBOylg2V0guHCkG9FnYF/jYkIYl41wU4i2BfYuoAbNvanb
         Bbg5EhdtNgRbtSpyn8S9M5VVZAAl7QHs7cBKwerBvk1+KnlVe03V1+v7AJ4w9w3k28KO
         Ge3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1x/aYydoGxiZa7Qj1d7r/szF2XaiIlhHV4lEhiy9berQRoTeL/pLCPibwgDDLFMVqI5t+or9EW4Bn@vger.kernel.org
X-Gm-Message-State: AOJu0YwqYuH3BoU1VTEab4W9nNuXINQIwHWx2RP8ykQZuRPSnCapA1t7
	jXGMAB5NcmW2BNmcuJ9lZuA2kjr/Bf9DEps/tstm1DMeLDN2oEME0yIz8kqfONU=
X-Google-Smtp-Source: AGHT+IE++oEhimUSC/n6odFHU11d3lmzvoMxQ3GR+KJvVhAk1j85ECkXjUx948Kl/hJd8+RlCzZn1g==
X-Received: by 2002:a05:6102:3a07:b0:4a5:c74b:66a7 with SMTP id ada2fe7eead31-4a751c94d11mr591818137.19.1729632893322;
        Tue, 22 Oct 2024 14:34:53 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c62f4dsm33845841cf.28.2024.10.22.14.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:34:52 -0700 (PDT)
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
Subject: [PATCH v3 1/3] memory: implement memory_block_advise/probe_max_size
Date: Tue, 22 Oct 2024 17:34:48 -0400
Message-ID: <20241022213450.15041-2-gourry@gourry.net>
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

Hotplug memory sources may have opinions on what the memblock size
should be - usually for alignment purposes.  For example, CXL memory
extents can be 256MB with a matching alignment. If this size/alignment
is smaller than the block size, it can result in stranded capacity.

Implement memory_block_advise_max_size for use prior to allocator init,
for software to advise the system on the max block size.

Implement memory_block_probe_max_size for use by arch init code to
calculate the best block size. Use of advice is architecture defined.

The probe value can never change after first probe. Calls to advise
after probe will return -EBUSY to aid debugging.

On systems without hotplug, always return -ENODEV and 0 respectively.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/memory.c  | 43 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h | 10 ++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 67858eeb92ed..a0fd9e1451aa 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -110,6 +110,49 @@ static void memory_block_release(struct device *dev)
 	kfree(mem);
 }
 
+/*
+ * @size: suggestion for maximum block size. must be aligned on power of 2.
+ *
+ * Early boot software (pre-allocator init) may advise archs on the max block
+ * size.This value can only decrease after initialization, as the intent is to
+ * identify the largest supported alignment for all sources.
+ *
+ * Use of this value is arch dependent, as is min/max block size.
+ *
+ * Returns: 0 on success
+ *	    -EINVAL if size is 0 or not pow2 aligned
+ *	    -EBUSY if value has already been probed
+ */
+static size_t memory_block_advised_sz;
+static bool memory_block_size_probed;
+int memory_block_advise_max_size(size_t bz)
+{
+	if (!bz || (bz & (bz - 1)) != 0)
+		return -EINVAL;
+
+	if (memory_block_size_probed)
+		return -EBUSY;
+
+	if (memory_block_advised_sz)
+		memory_block_advised_sz = min(bz, memory_block_advised_sz);
+	else
+		memory_block_advised_sz = bz;
+
+	return 0;
+}
+
+/*
+ * memory_block_probe_max_size provides a suggested maximum memory block
+ * size value. After the first call, the value can never change.
+ *
+ * Returns: advised size in bytes, or 0 if never set.
+ */
+size_t memory_block_probe_max_size(void)
+{
+	memory_block_size_probed = true;
+	return memory_block_advised_sz;
+}
+
 unsigned long __weak memory_block_size_bytes(void)
 {
 	return MIN_MEMORY_BLOCK_SIZE;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index c0afee5d126e..47c00d6e1165 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -149,6 +149,14 @@ static inline int hotplug_memory_notifier(notifier_fn_t fn, int pri)
 {
 	return 0;
 }
+static inline int memory_block_advise_max_size(size_t size)
+{
+	return -ENODEV;
+}
+static inline size_t memory_block_probe_max_size(void)
+{
+	return 0;
+}
 #else /* CONFIG_MEMORY_HOTPLUG */
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
@@ -181,6 +189,8 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 void memory_block_add_nid(struct memory_block *mem, int nid,
 			  enum meminit_context context);
 #endif /* CONFIG_NUMA */
+int memory_block_advise_max_size(size_t size);
+size_t memory_block_probe_max_size(void);
 #endif	/* CONFIG_MEMORY_HOTPLUG */
 
 /*
-- 
2.43.0


