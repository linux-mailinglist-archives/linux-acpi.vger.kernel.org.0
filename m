Return-Path: <linux-acpi+bounces-10844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847ECA1D99D
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 16:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62F53A1FB1
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4514B942;
	Mon, 27 Jan 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dj2HA8rn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C0149C53
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jan 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737992059; cv=none; b=bZJ7L4TDadBULonpaJN+bUO6IDD7xBz+7MSWUHTVoJklMv87pmGhKpbi/nIhU89oHNdwNmky23hUQC8adID/SUbV50wqF1A6kQBx13S1VunThNKbH4iTOdVdNk0On49JHAbkyVNs4hehGXIHsMEd492+q/iC+D4HB43Z7HpPzY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737992059; c=relaxed/simple;
	bh=JlIRardHN3T/rAzbVZsKRhQoD9nvYKKMQjOClOHhgOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4TUW8QUBtCRckPw5cQMAGOTpxsipQM+XthEQWzDXg3cF4ZYSgVdn+p5/kJKfyUDekBQ3FHiL7bYP74XhUBdX09+prKSjqsi+f86q2Ujvt4Bq40+o7nJeanaByh48wuClV5CEBioPkCTK4ib5VuDX+PHdDWnm3M+P7a6c/Gw+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dj2HA8rn; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so387317685a.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jan 2025 07:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1737992054; x=1738596854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEKgJJf51nUXgtjwZFRtEbK89HKdrqyuzjYJ58simEs=;
        b=dj2HA8rnoFiTxa2S//p5IKk2K5BIQjRfAn3abJ2mMWWy6TnQtD9xorztaejAujGUWU
         zBL2Kl4tUIZhWpPiX+RQz378HZ8Qv6rYKStTbmptjz/70QrEQ9PchLOqUJFTyzn1+Ldw
         4Ej7sxIqBhCNYYDSLn4IARkaepc8eCLxA66Np4KXPiCC9HFGePp6B43njBxjb2D7VZwh
         6KmR/iIY0/n31hVt4WtH5BK/RCZRrKtNF/WweJeOcp7lhTXazamDfS4icCDgwHJRBobT
         HBRydsXIFvgYE8InEmsFB2IaeUJjicUYV7VDlpu7us7cBeoyCiuFk8uDTsADIt3R6TE0
         aMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737992054; x=1738596854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEKgJJf51nUXgtjwZFRtEbK89HKdrqyuzjYJ58simEs=;
        b=v0cVkSJeo+K3kzUlGxL4tk85yFZaexiPhoSaofHnctZCDN7VrL3MxdieDySekLV0EF
         TuDs4P7cEuaHWZsR/ROO9FKmB6mFprO9Uy0jHLE119WTkdCkleFczxcWdNTj3BMs498l
         FUA3A/nKxjAvcabwZ7c96BdwOkoVdDDMtFf5psNTRbDo9r7VB/zub5vEZO6/gMwz0r9m
         i1rSHcK3jf7R05U0Tkh6wKJBPbJ/3xD5uEwiXl6HOw4Y1sjYFWY6USJoLwbcrK+mrTu9
         GCOL8/9sx/SxRb031jLdnrMhwvsOTEkBIAdFyZWtq4dW/Qksi+jaPObB13VYvm4KJVaF
         zHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe0X0sR5EXjbWvX3hvxNHEEoNY6DEKMXX3WXzx8wOFXEUOm/E1wWhyRFQDGkBpXcad72DD2BoV4Tja@vger.kernel.org
X-Gm-Message-State: AOJu0YyEC9cPON8e5S8R018aQcSciT25rLTWG4fZtjuwwh0TsFPRcPIy
	riXMPOXqkeISgkj38dAbDXTzY+BR8n+BeKrHSzFKMH59fXKSRcjtJvspqxwoYco=
X-Gm-Gg: ASbGncsayfrngp5V0l0O0+RY5XCsywRrRTEPOZXNbpgc6S9TisRhc3UCezPv6+agbjt
	JTvkCp9TrvKVYV352qLVg6q33XFuA03EnNp5rHaAqf0FMvt/ijO+1s53vtRx7StcAUHIkkYtvJa
	6JRZEDOtjvyyA9pJ4DhmS1EX0G7pTac1BvHWOhnth3Sc99TcsywE2BeD8NZ7CPvqLnBGpmb4v+G
	VhYMVRmZd7zUPIO2PnpLbkHqOgBBNCTRTQL47c/q1UmYOQ8BweBlxOeozXbPLsBwlDaR5V6iKq8
	dAcFXuqNldpoDkIYINIx1Ahfho1DBYFqii9ODACqMkPDwwbzx7YbXSo6qlEzQFh1O9gK
X-Google-Smtp-Source: AGHT+IGoKs+d0lqDKVI9i+teoRAx9CQCD+e8LPsJoU6HHbn9z9w7GdlOVjcgcKDj1hULyXcfAypH2A==
X-Received: by 2002:a05:6214:4b0f:b0:6e1:a36b:3445 with SMTP id 6a1803df08f44-6e1b21857c6mr708814736d6.19.1737992054132;
        Mon, 27 Jan 2025 07:34:14 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2058c2a51sm35380476d6.109.2025.01.27.07.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 07:34:13 -0800 (PST)
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
	Ira Weiny <ira.weiny@intel.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v8 1/3] memory: implement memory_block_advise/probe_max_size
Date: Mon, 27 Jan 2025 10:34:03 -0500
Message-ID: <20250127153405.3379117-2-gourry@gourry.net>
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
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/memory.c  | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h | 10 +++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 348c5dbbfa68..69feacbac3da 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -110,6 +110,57 @@ static void memory_block_release(struct device *dev)
 	kfree(mem);
 }
 
+
+/* Max block size to be set by memory_block_advise_max_size */
+static unsigned long memory_block_advised_size;
+static bool memory_block_advised_size_queried;
+
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
+int __init memory_block_advise_max_size(unsigned long size)
+{
+	if (!size || !is_power_of_2(size))
+		return -EINVAL;
+
+	if (memory_block_advised_size_queried)
+		return -EBUSY;
+
+	if (memory_block_advised_size)
+		memory_block_advised_size = min(memory_block_advised_size, size);
+	else
+		memory_block_advised_size = size;
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
+unsigned long memory_block_advised_max_size(void)
+{
+	memory_block_advised_size_queried = true;
+	return memory_block_advised_size;
+}
+
 unsigned long __weak memory_block_size_bytes(void)
 {
 	return MIN_MEMORY_BLOCK_SIZE;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index c0afee5d126e..8202d0efbf46 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -149,6 +149,14 @@ static inline int hotplug_memory_notifier(notifier_fn_t fn, int pri)
 {
 	return 0;
 }
+static inline int memory_block_advise_max_size(unsigned long size)
+{
+	return -ENODEV;
+}
+static inline unsigned long memory_block_advised_max_size(void)
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
+int memory_block_advise_max_size(unsigned long size);
+unsigned long memory_block_advised_max_size(void);
 #endif	/* CONFIG_MEMORY_HOTPLUG */
 
 /*
-- 
2.48.1


