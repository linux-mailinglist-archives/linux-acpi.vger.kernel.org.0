Return-Path: <linux-acpi+bounces-9234-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D343E9B924C
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 14:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621821F21FE5
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B6A19F101;
	Fri,  1 Nov 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EINromA1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988819BBC
	for <linux-acpi@vger.kernel.org>; Fri,  1 Nov 2024 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468834; cv=none; b=F/4pakzx4kEKiWStlZj9ExaORYFM52NJTVl35MfcW6fQBmKU7wOea4k/nZVg6y0c1tkqutdRNGbHbIGxFCK7M8Ndo3+UW8GoVM4G6V1o9NvJqeZK+NNNqLE1trJZ4tH3GXxHw+M0xpmp9gJlSWWPA43GaEZSA1U7iQHKr/9yOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468834; c=relaxed/simple;
	bh=DORnpLlSSPTvlRU0Z176w+GuOM3Fh07/etpOUsmN1co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lo5Xyfj9aGBrPz58mBtrsLMpJnPbNaABeMczYD9ORS71iKxae1XUQw0XVzU48nBPtdJL6XMAKwqC4dTkPlehpVZ6yeWYFWQiG7AnBCQR6NymswDGp0VsXkgkWUimWlExyysPIfAO8C49Hc5Pgja/EBaU8FEkxeNgK7csB+SEwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EINromA1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460a23ad00eso25381511cf.0
        for <linux-acpi@vger.kernel.org>; Fri, 01 Nov 2024 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730468831; x=1731073631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pgZpdUoTAWBGW8HPZFX/sXBtOGTucTxkHn+L83ATAH8=;
        b=EINromA1glYoEM83OqIk1FqMVBGC44SFElJ2giR/k4eQfq5Yyn07uLQ8mtVm30mAjC
         Q86IkC+eh+ZwZvT/Tz1UcALFxpcl5P6O2t1fx/iEMSbLqGOFCecTS62s/JqlygQW/KHw
         Qt3SOjxUCOKZSGctqnJqY8wgRKn5hBmgrE49WKc+0BjWiREbhtRvuOPu21a7xA7oMDin
         1LI1YPyjifkUNTLkJYQUm8lGfL8r90v5gaIA/FaZGTatYPf3s15vd4KtjIrHIhUlnQZx
         QclWnEUo6csvwgK42HSqlkVWM/f1jCxXLtcfLbJzl15LJm2dH9n3qVaaXAyZHcRdENHY
         bRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468831; x=1731073631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgZpdUoTAWBGW8HPZFX/sXBtOGTucTxkHn+L83ATAH8=;
        b=wbLNNbU/arVLragZwvI8tjxfbMvdGoG2zYWDKDCBGkZrraL9GMuGqcQ4QSOHcv8bK5
         5aSxNgz56iATGBn8pOL94K99u6h/GRWevLj0BPrZaZ2Dnpv/TS54hAhNRSItOVThd5JU
         zrL5A9GeEf9TtBZC35WxYboxJwftOkBj/i8j4BeFUp3wStmo0SiaI9VFvJet/LxaI9TJ
         7a/jRha6OlxGnxYHp6Ehjbxi1h47ifLA/rM6BJR47S7Pj1vRrxYG8qIXJXN9ngoDt3ko
         PLJWPhxBJrierdDl6qNgFr1WdjHQzLCq/HNRFniZIm/oXZHk46NTtssJus/2mMw0FvHA
         4+sA==
X-Forwarded-Encrypted: i=1; AJvYcCU3d6CiyMBbVn016he7SQgvF+6UfYFDsfPbG1cCi7/WYomyklR8xaRb3LDiNtr+hiqNATEZ9Qsg/b9g@vger.kernel.org
X-Gm-Message-State: AOJu0YzMumMs8ETijr553f5oejwR+utmiTjM56dP1fcmbOJMdLGBX252
	R+JUr6sWf0cW21lGQoBOP9naCQM89sALVMRIc96nfmIN+sXieB6oYQd+GoaKGQo=
X-Google-Smtp-Source: AGHT+IFO7TPVt3YP/4LUm5QV2ItbjgKfbOmnapBUP+AyArR90OJPmLDKIteJ7SrM/lUFaW2ItVhwSQ==
X-Received: by 2002:a05:622a:1a97:b0:45d:ace1:a44a with SMTP id d75a77b69052e-462b6ebae38mr51618591cf.30.1730468831023;
        Fri, 01 Nov 2024 06:47:11 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com ([50.193.156.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0cac07sm18840631cf.48.2024.11.01.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:47:10 -0700 (PDT)
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
Subject: [PATCH v5 0/3] memory,x86,acpi: hotplug memory alignment advisement
Date: Fri,  1 Nov 2024 09:47:02 -0400
Message-ID: <20241101134706.1185-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When physical address regions are not aligned to memory block size,
the misaligned portion is lost (stranded capacity).

Block size (min/max/selected) is architecture defined. Most architectures
tend to use the minimum block size or some simplistic heurist. On x86,
memory block size increases up to 2GB, and is otherwise fitted to the
alignment of non-hotplug (i.e. not special purpose memory).

CXL exposes its memory for management through the ACPI CEDT (CXL Early
Detection Table) in a field called the CXL Fixed Memory Window.  Per
the CXL specification, this memory must be aligned to at least 256MB.

When a CFMW aligns on a size less than the block size, this causes a
loss of up to 2GB per CFMW on x86.  It is not uncommon for CFMW to be
allocated per-device - though this behavior is BIOS defined.

This patch set provides 3 things:
 1) implement advise/query functions in driverse/base/memory.c to
    report/query architecture agnostic hotplug block alignment advice.
 2) update x86 memblock size logic to consider the hotplug advice
 3) add code in acpi/numa/srat.c to report CFMW alignment advice

The advisement interfaces are design to be called during arch_init
code prior to allocator and smp_init.  start_kernel will call these
through setup_arch() (via acpi and mm/init_64.c on x86), which occurs
prior to mm_core_init and smp_init - so no need for atomics.

There's an attempt to signal callers to advise() that query has already
occurred, but this is predicated on the notion that query actually
occurs (which presently only happens on the x86 arch). This is to
assist debugging future users.  Otherwise, the advise() call has
been marked __init to help static discovery of bad call times.

Once query is called the first time, it will always return the same value.

Interfaces return -EBUSY and 0 respectively on systems without hotplug.

v5:
- nits and renames
- kdoc warning
- change to everything `unsigned long` instead of size_t
- memory_block_advise_max_size marked __init
  - both cannot be __init because the query is called from non-init
- simplified alignment code in cfmws iterator

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (3):
  memory: implement memory_block_advise/probe_max_size
  x86: probe memory block size advisement value during mm init
  acpi,srat: give memory block size advice based on CFMWS alignment

 arch/x86/mm/init_64.c    | 15 ++++++++----
 drivers/acpi/numa/srat.c | 12 ++++++++-
 drivers/base/memory.c    | 53 ++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h   | 10 ++++++++
 4 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.43.0


