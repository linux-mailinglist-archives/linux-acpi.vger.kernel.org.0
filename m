Return-Path: <linux-acpi+bounces-16553-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7EDB50CE4
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 06:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3341BC7E9E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 04:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D766F2BE657;
	Wed, 10 Sep 2025 04:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCBoPQh+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337C2277CB1
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 04:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757479539; cv=none; b=nSnqBeCiL+Hs1lc9QiRwk65rQYmHVwz8agZBNwfw6Hfc15+NrpJIR8IRV9u8nbnNvr/TYBSPABQdUAj6i9KOp+gzMuCyW70dl6xV825iikTICj8hHSrwU96U+SqKEqEq5yh5dE7VOWVUVRogeQyvqq5GB15W1RoPeGDi/ETBj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757479539; c=relaxed/simple;
	bh=syiSmSAFO+aipbEzZrniarasYU989JCArBVy1P7PnhU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j/V+KUGmtj7dhJS7MgDr4Sqn+f6z9gSGZAnb5s5RsqO+bAoK2WiszBMnFlLi1ipIvi79pKahA0R2sKws9g0tZHMDWlWQSPL5DCtltKrNTDXYZ/PBVpHGrypRe41XxBZWT/0ryhj9gfkJnifBGysnENxjh9m0XwlZg+PmVTOeyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZCBoPQh+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32bbacf6512so9328783a91.1
        for <linux-acpi@vger.kernel.org>; Tue, 09 Sep 2025 21:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757479537; x=1758084337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FJadLmysskB2boZjs9046Qcr8br6WCNXbEVyeTwtHYE=;
        b=ZCBoPQh+GNzJLIRKiqmcNlXL7lxgRv57fZL7g0oftxb/mTYkul78ipNKPdS8skYv4w
         xfysLsJbVWzeB+BYHhu2kxn4MzDGaaX6GQdIhfhMKq5yWA547kgClap7kE7tvxDYzsO4
         J3wkbhqHKGWkXQ1XZELwiI3+fbd47S3ANAlB5LDqzfDD+QJIeWOHWqShHLZG7AXYEhZP
         cGnZxiZAcCxRW+luE2HH+3oUibkgNeeIjzJvJ2jo84Ue9iNM9ObLKD9bggWigspANXni
         16WUqVrZeZAsfwqOlcXayR7NvmeQvqNCbUcuZ/CjSdeZ+ADE+y9JN2yZZ7rnym4qULna
         4hBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757479537; x=1758084337;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJadLmysskB2boZjs9046Qcr8br6WCNXbEVyeTwtHYE=;
        b=aMEdxY1cXvHPmQe5zoXI1Se0meTSJciCcRXnTKooNSTd+l6eYufsfnrR7MFATGKkia
         Z3Ben5J6ShhhhE4CRMyNB6OVOCgGQ06mmDOSeTS3U906xNkCg3pg1k3wptsq7Ajs2juN
         GtAk4LH/ENlobsEdVSfJ+krJ8Na0r/Lynex/qpws6n5T39e2od7AJQQ/zle8isZaZGr7
         7D3hUK6pFPW/vOyBe1HHTmcdXynS+bTEJ1USjyfdsY4Ymjq1rjBXoXuLzBjQFcHniPBT
         SiAN1NLOKs4XizwHbyKMwLd//5QoiLPl++AWybNsZW1MCg29Trt7NHIjKTUH53itEY3+
         yw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8f0SFrb0qdagdHt0U/RLf0g+d7F97R+C3mS7ST3eAOtagY3HkoAiHUIynmLdKnIf3uU91fY+rMGDk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzik243lZidZrMsBFb5c5bp/TmKWBhScUD00xGm505Hf/9kcIS0
	jque+RyAMQsvHhnT3B4AMeI0Mh8/ffRDuBue7JAUy+fYev/iThu+HqyeD69Y1LhQxoxv0dPvJEG
	bPo3xLVJv8Z2nSA==
X-Google-Smtp-Source: AGHT+IGtF7G2qOTh8GkkHp+M2bIvebaZlladQ6uTxMfb0gBBP18Ndrlwth4enuUWrPoL3Hi7QjmZAZ4P9gFopQ==
X-Received: from pjbqx4.prod.google.com ([2002:a17:90b:3e44:b0:327:cee7:a99f])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:51cf:b0:32d:a721:8cc7 with SMTP id 98e67ed59e1d1-32da7226f41mr6178432a91.35.1757479537478;
 Tue, 09 Sep 2025 21:45:37 -0700 (PDT)
Date: Wed, 10 Sep 2025 04:45:31 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250910044531.264043-1-jiaqiyan@google.com>
Subject: [PATCH v3] ACPI: APEI: EINJ: Allow more types of addresses except MMIO
From: Jiaqi Yan <jiaqiyan@google.com>
To: tony.luck@intel.com, rafael@kernel.org, guohanjun@huawei.com
Cc: dan.j.williams@intel.com, bp@alien8.de, mchehab@kernel.org, 
	xueshuai@linux.alibaba.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

EINJ driver today only allows injection request to go through for two
kinds of IORESOURCE_MEM: IORES_DESC_PERSISTENT_MEMORY and
IORES_DESC_SOFT_RESERVED. This check prevents user of EINJ to test
memory corrupted in many interesting areas:

- Legacy persistent memory
- Memory claimed to be used by ACPI tables or NV storage
- Kernel crash memory and others

There is need to test how kernel behaves when something consumes memory
errors in these memory regions. For example, if certain ACPI table is
corrupted, does kernel crash gracefully to prevent "silent data
corruption". For another example, legacy persistent memory, when managed
by Device DAX, does support recovering from Machine Check Exception
raised by memory failure, hence worth to be tested.

However, attempt to inject memory error via EINJ to legacy persistent
memory or ACPI owned memory fails with -EINVAL.

Allow EINJ to inject at address except it is MMIO. Leave it to the BIOS
or firmware to decide what is a legitimate injection target.

In addition to the test done in [1], on a machine having the following
iomem resources:

    ...
    01000000-08ffffff : Crash kernel
    768f0098-768f00a7 : APEI EINJ
    ...
  768f4000-77323fff : ACPI Non-volatile Storage
  77324000-777fefff : ACPI Tables
  777ff000-777fffff : System RAM
  77800000-7fffffff : Reserved
  80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
  90040000-957fffff : PCI Bus 0000:00
  ...
  300000000-3ffffffff : Persistent Memory (legacy)
  ...

I commented __einj_error_inject during the test and just tested when
injecting a memory error at each start address shown above:
- 0x80000000 and 0x90040000 both failed with EINVAL
- request passed through for all other addresses

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---

Changelog

v2 [2] -> v3:
- Remove unnecessary IORES_DESC_CXL per comment from Hanjun [3].
- Minor update to code comment.

v1 [1] -> v2:
- In addition to allow IORES_DESC_PERSISTENT_MEMORY_LEGACY, open the
  door wider and only exclude MMIO per suggestion from Tony [4].
- Rebased to commit 11e7861d680c ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm").

[1] https://lore.kernel.org/linux-acpi/20250825223348.3780279-1-jiaqiyan@google.com
[2] https://lore.kernel.org/linux-acpi/20250830030226.918555-1-jiaqiyan@google.com
[3] https://lore.kernel.org/linux-acpi/bc8ad4b8-c000-0298-efd1-4a332c4c7820@huawei.com
[4] https://lore.kernel.org/linux-acpi/SJ1PR11MB60835824926BEE57F094DE6FFC39A@SJ1PR11MB6083.namprd11.prod.outlook.com

drivers/acpi/apei/einj-core.c | 51 ++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 2561b045acc7b..3c87953dbd197 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -656,6 +656,43 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	return rc;
 }
 
+/* Allow almost all types of address except MMIO. */
+static bool is_allowed_range(u64 base_addr, u64 size)
+{
+	int i;
+	/*
+	 * MMIO region is usually claimed with IORESOURCE_MEM + IORES_DESC_NONE.
+	 * However, IORES_DESC_NONE is treated like a wildcard when we check if
+	 * region intersects with known resource. So do an allow list check for
+	 * IORES_DESCs that definitely or most likely not MMIO.
+	 */
+	int non_mmio_desc[] = {
+		IORES_DESC_CRASH_KERNEL,
+		IORES_DESC_ACPI_TABLES,
+		IORES_DESC_ACPI_NV_STORAGE,
+		IORES_DESC_PERSISTENT_MEMORY,
+		IORES_DESC_PERSISTENT_MEMORY_LEGACY,
+		/* Treat IORES_DESC_DEVICE_PRIVATE_MEMORY as MMIO. */
+		IORES_DESC_RESERVED,
+		IORES_DESC_SOFT_RESERVED,
+	};
+
+	if (region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
+			      == REGION_INTERSECTS)
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(non_mmio_desc); ++i) {
+		if (region_intersects(base_addr, size, IORESOURCE_MEM, non_mmio_desc[i])
+				      == REGION_INTERSECTS)
+			return true;
+	}
+
+	if (arch_is_platform_page(base_addr))
+		return true;
+
+	return false;
+}
+
 /* Inject the specified hardware error */
 int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 		      u64 param4)
@@ -702,19 +739,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 	 * Disallow crazy address masks that give BIOS leeway to pick
 	 * injection address almost anywhere. Insist on page or
 	 * better granularity and that target address is normal RAM or
-	 * NVDIMM.
+	 * as long as is not MMIO.
 	 */
 	base_addr = param1 & param2;
 	size = ~param2 + 1;
 
-	if (((param2 & PAGE_MASK) != PAGE_MASK) ||
-	    ((region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
-				!= REGION_INTERSECTS) &&
-	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY)
-				!= REGION_INTERSECTS) &&
-	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_SOFT_RESERVED)
-				!= REGION_INTERSECTS) &&
-	     !arch_is_platform_page(base_addr)))
+	if ((param2 & PAGE_MASK) != PAGE_MASK)
+		return -EINVAL;
+
+	if (!is_allowed_range(base_addr, size))
 		return -EINVAL;
 
 	if (is_zero_pfn(base_addr >> PAGE_SHIFT))
-- 
2.51.0.384.g4c02a37b29-goog


