Return-Path: <linux-acpi+bounces-10560-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA3A0BF15
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 18:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7853A98D2
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84E01BEF7C;
	Mon, 13 Jan 2025 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jpABpXlW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CFB1BD9C1
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790293; cv=none; b=WxwuliOSjMTmh2hJibO0NQ7aZ/ihKIuS4wUB8XVVMl8os8l3DiEpX0W1NxpL216PA43o7xswvlJgiAqGae7YolCj1Azg01w6ySmkERIg88BETZWAqxdFOssSkTIdvk3gUxkrOwTMSYKr6k1cbaa0Gxe/QmfgsgiFPXSEIg2yqqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790293; c=relaxed/simple;
	bh=F2KZg16EBTp92ge3DrBqc9jy1V79LKncQdKxeIVxUOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIA6bdctMcmUQmgzBE3XW7CqvIKviB5knFtrkeuX4vxaKyI2pyeRtInQ0m1wICdwze15NmyrW9pNV+eOi6WQDQnZJ2X33ZFeu2tR6pQNf0UDBPypzXHMynsHLVSXSxvzWPRLzon7VgfL4gOXb2aXoUVxCmBTomKP+h6CnUDok0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jpABpXlW; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b9bc648736so409886685a.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2025 09:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736790291; x=1737395091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lYIOjwVOiyZSO9nrORqGYqQ+1pRAYOeyq4Co+ahKG0=;
        b=jpABpXlW3rerS4GsjVOihPJsh35EflWQAd+8/TNnwQZ8/sX9dn0HFUdIQRnOXsLpuR
         Da6G2ChDus8OxbgIaIQfNbOvMTFgUOgpFsHktPuVXkppHjxu5v9xOi2fW1+l1rNbKjuq
         8MRqeqz0IgLv41kLCmu9I/+5grrB+D0nLwMn0Pdc+c9IoMvuwRudqwdIOyENL2VwWfEY
         0VB0cT4ALEkxOxGmgPZWDVW8HkRuDlZDG4azcDwhTr4dOyV14OpGuC2YsK0f8PEGWUN+
         Dfgq+mx8SFh+jPrPY056TRNlzSQRhkCU6WkShXZv1ecp3Hm/8i2+pzuVI3W28N2egMx+
         MT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736790291; x=1737395091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lYIOjwVOiyZSO9nrORqGYqQ+1pRAYOeyq4Co+ahKG0=;
        b=dJ+fXDrvMpeBE+QXD9bq9y0YcMM1hg2eVGLI6f+FMN1pK47tkklktvTYdSfKl/THyM
         QEsvRyvuUaXus9M2UI24n2DPIIXZ8X61JYah1uIihSNlF0IDfqRDjbaBIjhxKWF5fa4B
         OUjeFAxLF4VeHPKjM192ZQysOmsd2/vNufvCp4Get2TDac1aJucpBerkFGQgbqaCUcTv
         5H6beZeE+xpbIyJIU5Tv/45s0FoWMXzIy5p2Tm6kR/OGPyQxKjdom8zdMKKIfneI757i
         SGjefTwQ+cAlyOatZAsHjQnZs/oJ2OLrErNtVCfdVe2MEpieKPyNgLykV9bqK8g7PGtH
         A05g==
X-Forwarded-Encrypted: i=1; AJvYcCX16HFB6QINUBo/WO7s69Ue4rS7kl9lKsoli8YT8nm3B1IdZs9R6OMLY0oyKkzXPfM4Hk9+Gt6Ek3qC@vger.kernel.org
X-Gm-Message-State: AOJu0YxhOkynl0jdhWu6GgQ/Tc77+WoPQDGxmXNePmcgKlhT98QaMk0q
	1tqHPyP4DF9jcB059kSDLFoRuvjNyUsSP+IgcMjYK+NZQfV1miNbSixptao0guc=
X-Gm-Gg: ASbGncsj2d7GySSOIDe+DM/UsbDH27ULi5Mv+77YqTB7qb7wSQI7GUkGdSbkVxYymvV
	8NfOTWuE/jFktI0KW38VikUipYC57w4ueqH7Msh1e4V65LWi6G9nKQlLdcp4twntvHrm1rmIYM6
	We4kc2h8n0jfngtWPJgL5GSkxFPwLe543cO1zUqYIjnMqpFTDhh/Fst4RvDvI3Br+7gpaVQfEKb
	idssqHIIGfY7w9sxhw6hM5p5x29TIuZgQ5AVOHtLyb97JbB+Eba8PMYymunUGVJYM/swqlDyy3U
	++Q/vf3HKzngEYkAZ8ZsxWqCgWPOzrQ6fdxlPJj17FTJ
X-Google-Smtp-Source: AGHT+IGji/zdVSjj+QKuBorX8KRhL5U0vYxcdcXprimxamnxuQtc2su0NPyPj8UIhAzTvvuSrnfbyg==
X-Received: by 2002:a05:620a:460f:b0:7b1:1d91:5d06 with SMTP id af79cd13be357-7bcd9759e0amr3397038585a.46.1736790290892;
        Mon, 13 Jan 2025 09:44:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248c80sm511214185a.49.2025.01.13.09.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:44:50 -0800 (PST)
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
Subject: [RESEND v7 1/3] memory: implement memory_block_advise/probe_max_size
Date: Mon, 13 Jan 2025 12:44:37 -0500
Message-ID: <20250113174439.1965168-2-gourry@gourry.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113174439.1965168-1-gourry@gourry.net>
References: <20250113174439.1965168-1-gourry@gourry.net>
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
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/base/memory.c  | 53 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h | 10 ++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 348c5dbbfa68..e59378ec5b00 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -110,6 +110,59 @@ static void memory_block_release(struct device *dev)
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
+	if (memory_block_advised_size) {
+		memory_block_advised_size = min(memory_block_advised_size,
+						size);
+	} else {
+		memory_block_advised_size = size;
+	}
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
2.47.1


