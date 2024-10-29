Return-Path: <linux-acpi+bounces-9095-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C859B5344
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 21:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172141C22B06
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 20:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217B4207A07;
	Tue, 29 Oct 2024 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qnBfIcj7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C52076C2
	for <linux-acpi@vger.kernel.org>; Tue, 29 Oct 2024 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233248; cv=none; b=FEIBOmxQ3pPv6Urx81h/9y+wmBKXq+oYZqM7wUWhXK1iM800DWGE85LKPg84bMmwb2yv13jpd+aAMXg5bEPxKDb70YCXdHZEXKq4HdDnS2VvRk8WqG3b9fjOG3C0E09PtVqRG9sRI5gy7adlmGAD7qyfe19xQ79+S9WX7EKebVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233248; c=relaxed/simple;
	bh=BazxSNmpxlGCpFCf1Hx0SRVIOcK24C2uL40XGo91tgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgnGwVcElf/0NvmEWWbgiIaWfVt4grlrH5VhsZSoYUXZGBuXlqRXViWiryVIOwgTQ0OZCVmp5F+QUGt+aybj24hxIoyDJ3euetmmhaJL55OqlXoxEJT2M6yqo4VDxTwskZowSQbvX6CqGJWGJdpB9Wov741w+p+0rRbzStBjdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qnBfIcj7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460d1145cd8so46188851cf.3
        for <linux-acpi@vger.kernel.org>; Tue, 29 Oct 2024 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730233245; x=1730838045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYJpDly5fR8R/Ele1I4od50o5TfHJqlCfC6WSHHqe0A=;
        b=qnBfIcj74KvGuuSYTpl6qgwUxB8CAyOxj5LSm42MIybF9nTiY1TSTFxRlE6kD79fWV
         BhP+js5Qtm3cjQs4oQGrSqM/PyF9XnTBttWGI+kk1mEcREJ8abnR5EYymJmEv/Myd7JF
         HfHuFowNbjAKRbXKfh6L+L4DuB8mBtsvbnrRk/tqRgriFmAdEiDxVYMWYwPi9dW9RTRA
         Ya5dNmzJTo4rbmhoO5DKq5VteW1AzHgk8HDA0KY3kpVECt3aQGlkmrAEVp/SdYb7TDqn
         tyKL2RSNHJVS3y2esRZ4LbxF2+ctH7LJ1cZj+UNjlTFSNj4iU3WdobyZ4MC5JZcdWlaw
         YhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233245; x=1730838045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYJpDly5fR8R/Ele1I4od50o5TfHJqlCfC6WSHHqe0A=;
        b=jbGsCBfH7k45l6lasi89wUBw5UZHiJbSfp8fghPl5pbIwHHMi9SMw8RaT+lmzj3Z6p
         pG0PZP/xaRW4DigLYZYsfaX5kBQ3GgtfQIkbPw5sVfTO6Yh1zcVJenBiauhH3HIMyrgS
         QyeVmUE4GMqFCmM/aeEpqaod1mMvpsjdgeVssYlP8XaoYE989FWPGhEZxOk+DOVYubRW
         5wNib1z3i9kKbx9ADzYeThPQOLz3ES5rV5tPDNumnjm9mcYeQrzJBVaum2peJtxUCupa
         FKfJzCGuApG/XAAI3TTm9SQucQ8oH+TN7jQKDlpO3tBGZOQPDnSpdpu0MY8QJpoGxLG4
         dJGw==
X-Forwarded-Encrypted: i=1; AJvYcCXE9Gcns965WV8FyCa5K9sgGF4S0x6n44UOBrpQu3by/FKmCIa90XPCqhsJ5bxo/qTcQK0X7LTmlk3K@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkT3lpwos8rMPaluvcKmjthK88KCMS88TSsnmfyOHgEdns0tJ
	GUJu4jG//bW9SML5YHadYP1Sm7SpsLHLdqOhw1sGDZaI27ff0W22P1H7jPkwBFU=
X-Google-Smtp-Source: AGHT+IFEYRquwMMLuxm/I3OurD9YlNDiDcPqhW8mBugt6yiiX34O6cvjwJwhU0+zT5zZPMP4mvN4Qw==
X-Received: by 2002:a05:622a:4a:b0:460:a287:2069 with SMTP id d75a77b69052e-4613c036755mr178235441cf.35.1730233244725;
        Tue, 29 Oct 2024 13:20:44 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798bd8bdsm45071796d6.54.2024.10.29.13.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:20:44 -0700 (PDT)
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
Subject: [PATCH v4 1/3] memory: implement memory_block_advise/probe_max_size
Date: Tue, 29 Oct 2024 16:20:39 -0400
Message-ID: <20241029202041.25334-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029202041.25334-1-gourry@gourry.net>
References: <20241029202041.25334-1-gourry@gourry.net>
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
 drivers/base/memory.c  | 48 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h | 10 +++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 67858eeb92ed..099a972c52dc 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -110,6 +110,54 @@ static void memory_block_release(struct device *dev)
 	kfree(mem);
 }
 
+/**
+ * memory_block_advise_max_size() - advise memory hotplug on the max suggested
+ *				    block size, usually for alignment.
+ * @size: suggestion for maximum block size. must be aligned on power of 2.
+ *
+ * Early boot software (pre-allocator init) may advise archs on the max block
+ * size. This value can only decrease after initialization, as the intent is
+ * to identify the largest supported alignment for all sources.
+ *
+ * Use of this value is arch-defined, as is min/max block size.
+ *
+ * Return: 0 on success
+ *	   -EINVAL if size is 0 or not pow2 aligned
+ *	   -EBUSY if value has already been probed
+ */
+static size_t memory_block_advised_sz;
+static bool memory_block_advised_size_queried;
+int memory_block_advise_max_size(size_t size)
+{
+	if (!size || !is_power_of_2(size))
+		return -EINVAL;
+
+	if (memory_block_advised_size_queried)
+		return -EBUSY;
+
+	if (memory_block_advised_sz)
+		memory_block_advised_sz = min(size, memory_block_advised_sz);
+	else
+		memory_block_advised_sz = size;
+
+	return 0;
+}
+
+/**
+ * memory_block_advised_max_size() - query advised max hotplug block size.
+ *
+ * After the first call, the value can never change. Callers looking for the
+ * actual block size should use memory_block_size_bytes. This interface is
+ * intended for use by arch-init when initializing the hotplug block size.
+ *
+ * Return: advised size in bytes, or 0 if never set.
+ */
+size_t memory_block_advised_max_size(void)
+{
+	memory_block_advised_size_queried = true;
+	return memory_block_advised_sz;
+}
+
 unsigned long __weak memory_block_size_bytes(void)
 {
 	return MIN_MEMORY_BLOCK_SIZE;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index c0afee5d126e..07e20a77b717 100644
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
+static inline size_t memory_block_advised_max_size(void)
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
+size_t memory_block_advised_max_size(void);
 #endif	/* CONFIG_MEMORY_HOTPLUG */
 
 /*
-- 
2.43.0


