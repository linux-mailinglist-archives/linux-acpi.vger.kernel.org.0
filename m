Return-Path: <linux-acpi+bounces-10843-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44807A1D99C
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 16:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C397A15C1
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 15:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C23113541B;
	Mon, 27 Jan 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nnXoQoaV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA31B1CD3F
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jan 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737992055; cv=none; b=cuZs3bX5MrQCvKaTfaF98ebgIhvix4G29e9hZIzCeaWiaIaLvcDYXv2asNHNex3tPGt/i1oc8X07vvW//zkQYqwXGOxUdzYU6W+8XUlC/AuP6WHFZ7ytyIMgjq4HYvKrLdbjbob6wjKNNuQDaZ//8jKBrX9pWPNYPoSa8q2VZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737992055; c=relaxed/simple;
	bh=wRhc4hFy50uw6hCcpFRxz5bovNco5MdtO2e1ujJZDfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckZuechaLadSX8okHqYPPSroT/52D5LMUBLus7LHZryzJcsw7kxwmdu2n6esQ9sUf8EeXYF/i/vSD+BdMqH1ivVKbCb7GjWTuaapWNCBFswY6Si74PF0qomeBCDkIUjQwaFrnBh7aUrn/zrGuUi7ILspx+z7N4ZFNbPnHRQqJNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nnXoQoaV; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8fd060e27so33885536d6.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jan 2025 07:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1737992052; x=1738596852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHMo2pdCBxV+82YYOBuucA32rs979HfFZCyG5MwB/hE=;
        b=nnXoQoaV+CszNH9pP/HPqjTiRQpRyTY133LMO3+tf72QedE95m8nut7+jIkJshstR1
         +8pOJsQdV6nA8leKhQpO7mrjUcLVCuN/klq1svkvH3b5LNue881Uuj3VwrsHS2LHGOhD
         phEvf4MMyNfbRqMMeUaqMQ9WOdCiWB9HY4pCmWZSW9SeZ1V4oTuZUnwRbig5I5ddYU7H
         FYPte1Yvcjm+R6wRNe3ityU13ojAH3+ocpZRCQbGBM5Pnj1ZpLq2fsTelX3Os9SvZq+l
         iUnCT8XDzr/hrkCF7Rr8KxW8uVgCFu6wTuQkoCMW831iGzXRZl3FwbzLyG9UT2Zpr+tE
         EyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737992052; x=1738596852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHMo2pdCBxV+82YYOBuucA32rs979HfFZCyG5MwB/hE=;
        b=XR4nRRAFQzBmzHulHDpX7cNfp932J/OsxCnPp5rTulXTHJU46vZZv3GkptAflN0hji
         +TF8huTbV7TsJFAd0IyXoCZh2By1+5rpqQ93MyK0OaeaZVi6CTnX74Hr2zP/woYJPbvV
         xFbIZjVJJX9EkDnwajdAawZLLCxFon8qtUHqT/YUZHi6UdKZS/D18x/fDxmazmWF+0W0
         cpSe1yW6QUkPyEVRjuRytJtEC9eQeB7Srhb1G/95qLnZ15gEH8d5Tl92KhUIoFLdNY7X
         waHBs1qfkXQOPFba6ncR/jkhrM/n1JQb+qEc2M5vcYr4SmLiVTCpGI5y/E9L8mquym9W
         F1dw==
X-Forwarded-Encrypted: i=1; AJvYcCUo6z3p+OfL/FanXJiYyLLqEy3dNRHIhjlPJhO3N128JLnLSy0F+7LaqCID3If/fN2vvjoGhkT+4fW3@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqFMCtU8vNMtJ/wx1CriJ6Da4YpCBnndsD2sGd/oxvUEuKAZ4
	ajK+HSlWn2iVOjOjrGbGxF0gwZaidf1jk6VCmIp8fJkYDjMgmgCroCtotwKMzgg=
X-Gm-Gg: ASbGncuSQGB8EJuZ6s5U52YSFuLw/I5u/Pr4SnwfkTRL621z750TRxV2wCCgkQ5+5wD
	dLKmnTLUDyI5dXtjtoJMga3W/ehcQESnlLUtd79td/YwagCsi4C6myo/1pxhOKns5uplhy+EcnS
	6LpgSe3LX48LiJvrj6sLqj8+0xNV7RtkxKCtTHXJ+MZT3hr1gsgaL2H95LLgn4o7VJHwjE6i9SX
	lCdbXz06rp14HC997uVtnEmHXzT7V2Z9Ixh+D3ahSRG6j8Hy1+5Mriwy/F2XM07ZZrLj2oHZvkW
	i1ET5KPZDTZ9V0ekI54hoTLHniYyGzAX2x2SO4RzbqR9t90MyDOk1f6ay4Q8b23kmjqa
X-Google-Smtp-Source: AGHT+IFS5f0oDJpQ1PqRj+UQN+nYxWLut917CGhIXe5wKYcWsl9bjwQofmwkzOyRAnQ+ap2ftR9Sig==
X-Received: by 2002:ad4:5c68:0:b0:6cb:c54c:b782 with SMTP id 6a1803df08f44-6e1b222f390mr706562676d6.32.1737992051647;
        Mon, 27 Jan 2025 07:34:11 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2058c2a51sm35380476d6.109.2025.01.27.07.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 07:34:11 -0800 (PST)
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
Subject: [PATCH v8 0/3] memory,x86,acpi: hotplug memory alignment advisement
Date: Mon, 27 Jan 2025 10:34:02 -0500
Message-ID: <20250127153405.3379117-1-gourry@gourry.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v8: nits and tag pickups

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

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Tested-by: Fan Ni <fan.ni@samsung.com>

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
2.48.1


