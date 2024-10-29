Return-Path: <linux-acpi+bounces-9096-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3DB9B5346
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 21:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC20FB22220
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 20:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B272207A1F;
	Tue, 29 Oct 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ny86Fd8Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D92076DB
	for <linux-acpi@vger.kernel.org>; Tue, 29 Oct 2024 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233249; cv=none; b=rx+of88JLIJXF8FcgeWrAouerTxXQ25nXK0j6VkWGxuOWWjmSVELiwghcampNwMZwYqo15bS1mTsWfh+KcSc3szlq04x3Lj8uzbY4k3TxqLp2TheF/arDQzkywHaxSzvDc3+9C8iqpLDnLY9ABPAom2uHlApqzteRLBe8k82bgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233249; c=relaxed/simple;
	bh=vp/pABtvn+LXH3AXLSvAztLHPBydYo64dCzxrhZlQjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjEojBui7OeeveZAI8qyvEwt9IsSPYHn8BzmHxTBItMSqmbGt/shd7lyPg9uRPQa0/E6FGJwKa5kZTLQGHwHjUIvXfH+FsFkpd7/kADwbs8vIjAMOrW9anDbyuiGzoS6CZHsXqooGZqHbOeJ3BkJXGD+5ZugrhQjm+tGl0U6t08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ny86Fd8Q; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e291f1d659aso6469132276.3
        for <linux-acpi@vger.kernel.org>; Tue, 29 Oct 2024 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730233246; x=1730838046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLCkoovWy+4BTP/Blm5LQHaaqE7ZHx2x3Kcfu38vCw4=;
        b=ny86Fd8QvtRORo3sA0fckv7mqlt3eK7f3AvAa9o5Kpe/ZiN4ojjYXfF1KmT3CPZT73
         mVJTONfIDIPzw3Y0ObR6sc12Ie9nPHeNVyC+NE+mJBWh8zJN51Z95WENFKcy0R9ZhSMF
         9s38Zji0gCdtP8JVsGPBMQrVf6+1OY+tus0Q535p78rG5eUZiwptV3CfNZ18nnUATkgL
         p2x2N4/0pnH1YazRl0lkgDTNn7MGqe3fHXlLKXsm6LO3r1il+mn7U38AnVlWLhmBB2FY
         7n1vV5GoE5d/k+UdkQoj2ZtWy2qfUAIaI7DDget8u7Akym8sgi5X/hKgyvLmX0fBMQQ4
         zl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233246; x=1730838046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLCkoovWy+4BTP/Blm5LQHaaqE7ZHx2x3Kcfu38vCw4=;
        b=THVn2mGdeiqOPh0DP9xitBLDEnwgNBpWzldhSlQ24cSwtcyBd3jmvvwp1ZCPNLlqD1
         XfUQ/h9SY5Vmm8TZisdvOrKDQDIRYPYT5BIkZ3fzahSzwm66u/ALMvDq7DwithV5le5r
         R5BGuKkNKMq1rrR/lxCQ6rZwXXBo1PM3jMVZa3TdCGqQPQFU7gEAw6ik8wd3mTaqCCJ1
         nAFOaa5DXtQmEIfbiGK3zH4LbJBM8MfZkYZX3D5K+FKSIRaJI6ERGRcpOw5jXfEymqzV
         jOqXoVGI73LIkOQT9vurLqDw5xRw2gbuOuNhWKEey+sWpxZYidjvuuDdFIfN5Saokvom
         7Tlw==
X-Forwarded-Encrypted: i=1; AJvYcCUkpZOMhBOpmU7j6aThxX2cfKeIpuwQZQPaQzww6bV/a+PWJS3Y2/alKv8+QnEP3J6t0+neSB7pWEfh@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBE4LnaDyO6S1vtN0XKblinKXyLrh0PDAopyMmVt6D6rOpm60
	y9LJaxChGtkkRE8wiPfK8rw9kBXvWh4mxhQ7sw6qyORL7lc7bF4OSJUd3+zI8zwj5mVbHOLFQNO
	d
X-Google-Smtp-Source: AGHT+IHrVUT2Y/bn1A2eEhZ3B/4Cio2x63OgV+iZejuf4OHZLNTMyIcoastoD+p+X+Hd1T8kconCzQ==
X-Received: by 2002:a05:6902:102c:b0:e30:c8db:34cd with SMTP id 3f1490d57ef6-e30c8db3652mr2549661276.3.1730233246317;
        Tue, 29 Oct 2024 13:20:46 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798bd8bdsm45071796d6.54.2024.10.29.13.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:20:46 -0700 (PDT)
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
Subject: [PATCH v4 2/3] x86: probe memory block size advisement value during mm init
Date: Tue, 29 Oct 2024 16:20:40 -0400
Message-ID: <20241029202041.25334-3-gourry@gourry.net>
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

Systems with hotplug may provide an advisement value on what the
memblock size should be.  Probe this value when the rest of the
configuration values are considered.

The new heuristic is as follows

1) set_memory_block_size_order value if already set (cmdline param)
2) minimum block size if memory is less than large block limit
3) if no hotplug advice: Max block size if system is bare-metal,
   otherwise use end of memory alignment.
4) if hotplug advice: lesser of advice and end of memory alignment.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/init_64.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..01876629f21f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1452,16 +1452,20 @@ static unsigned long probe_memory_block_size(void)
 	}
 
 	/*
-	 * Use max block size to minimize overhead on bare metal, where
-	 * alignment for memory hotplug isn't a concern.
+	 * When hotplug alignment is not a concern, maximize blocksize
+	 * to minimize overhead. Otherwise, align to the lesser of advice
+	 * alignment and end of memory alignment.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+	bz = memory_block_advised_max_size();
+	if (!bz) {
 		bz = MAX_BLOCK_SIZE;
-		goto done;
-	}
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+			goto done;
+	} else
+		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
 
 	/* Find the largest allowed block size that aligns to memory end */
-	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
+	for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
 		if (IS_ALIGNED(boot_mem_end, bz))
 			break;
 	}
-- 
2.43.0


