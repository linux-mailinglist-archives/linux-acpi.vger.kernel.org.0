Return-Path: <linux-acpi+bounces-8821-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 385AD9A126F
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 21:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD5B28640B
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 19:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2142144AE;
	Wed, 16 Oct 2024 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cvkobwFk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B02139CF
	for <linux-acpi@vger.kernel.org>; Wed, 16 Oct 2024 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106715; cv=none; b=hppMtEcc3+eirbGXIPjZwuosprLATwnZ12EV+1csSq5p++Qbc2saTNNyIWQ79Gr/GnSeuqQvH5gaKt8x2f2qZh0W+LviC3Qsr3Ck7E4WR1vaNgYpPE3svXuYPk0Nfxpnj0YG0WBp1zEcop8uq400RyYju+poeZ+mwZ0dQ4J0oaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106715; c=relaxed/simple;
	bh=aydxmUkA63wDYnemWtt5D14565/Yn90YGLFSu5WU2Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L22vOi5St+8LtGqZbLbqghnVsFtw8UJh9Ip7ziiIQL2gdJnvaQNsYNKJ8YeE0WMrsglPw1UIdFkmGGNsigzKq9g5CzNssApml50fGfx+APIPTQEuTG5AjOyWz/vyfkSg98gNz0KjzruIZqqAO/m2wiDPKHOd/1QpaKlUwoijImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cvkobwFk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45f07eb6f5fso1425181cf.1
        for <linux-acpi@vger.kernel.org>; Wed, 16 Oct 2024 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729106712; x=1729711512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PnTj8Lsaioq+rT9KMPtZOlgLCzamtAdxNe82cXp5oXQ=;
        b=cvkobwFkVgJ5o65CeWrDcr2Barp5oM6cNqMHxJGn4myixLz3+TAwYws/vxY+2Dfjgr
         GS3YKlVQuJkRzVZ59uMgsG7SeC9gX/f3nT7MPZXK0sJi1Pkq7D71xTpM/mReYJs5KYVp
         5kXzFUMSYP/K++CZpGcXhc+RG97hJlWMlR921RRUAKQui72keQ5SBkklOuEiLMKxuZjk
         9e7833sfRmJh3IhcLjwviFeG83s+3Xr8McljJ0KnTa82/UpY+4H/LTAM+CN552Ss6REB
         j2XvokVGGtRSoBJPS2/7A86rtVvaSm7jNs42k7GZGalq+IlPW07Vk/GU6YA+oqtdr3gq
         TEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106712; x=1729711512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnTj8Lsaioq+rT9KMPtZOlgLCzamtAdxNe82cXp5oXQ=;
        b=pI/DDtj6NNZy8qAIybS/TQEBDpFXcy8ZrNETzSVYD1R29ulcWQ6MpYNKzHF7gmlqRK
         4DkAwpK7iVwBNXT/0SQ+/OZwTHApy52WZZjParn+vXuip+kpj32nBGaAw73ezhjHll0u
         25SRs/E5g4ngp+Zi0UiQwc9fiaU+1/XBnozla8hbBxXYgKw0i5hijk11sX/0/CqKaj8c
         2xVGa8qLnOTMsS/Hj4k7YUbHzboI+bsKg+vX03J1Ae2VJldeFZ42DGekrKTKAFas7STI
         Jh8O/zgk3ONW2WHCNFiWOz+2jjP2DACDgiUOc6e51eTXT149nl29W7uxqB9vfWFUxyLJ
         P92w==
X-Forwarded-Encrypted: i=1; AJvYcCWLsAzAJNmlfEbu+V7ztUeJB2E8xBXqBmJT0s30GzvSVkG5KtUSB94Yldn1fjAThoZaEl2+He83pgRj@vger.kernel.org
X-Gm-Message-State: AOJu0YzjnLUjiUd2hMSN+RxgsBuiM6/NpGC5uDcqVwHaZVwFT+mEZuJP
	jKIArkWI36s9TTtK05zujEFGe73BkGHIaFu9XysCijLrwgbB88vGeng/lxfQGgQ=
X-Google-Smtp-Source: AGHT+IFLVilbKzRtR60hRVdAb2iSSymL1i+DXwV1S5+mgYdi39fcAJXLybQT7kl4t9CDE81sORKOAQ==
X-Received: by 2002:a05:622a:551a:b0:45f:890c:5f49 with SMTP id d75a77b69052e-4609b4e7150mr13277981cf.24.1729106712569;
        Wed, 16 Oct 2024 12:25:12 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b38ce69sm20271651cf.90.2024.10.16.12.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:25:11 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	david@redhat.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	rrichter@amd.com,
	ytcoode@gmail.com,
	haibo1.xu@intel.com,
	dave.jiang@intel.com
Subject: [PATCH v2 0/3] mm/memblock,x86,acpi: hotplug memory alignment advisement
Date: Wed, 16 Oct 2024 15:24:42 -0400
Message-ID: <20241016192445.3118-1-gourry@gourry.net>
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
alignment of non-hotplug (special purpose memory).

CXL exposes its memory for management through the ACPI CEDT (CXL Early
Detection Table) in a field called the CXL Fixed Memory Window.  Per
the CXL specification, this memory must be aligned to at least 256MB.

When a CFMW aligns on a size less than the block size, this causes a
loss of up to 2GB per CFMW on x86.  It is not uncommon for CFMW to be
allocated per-device - though this behavior is BIOS defined.

This patch set provides 3 things:
 1) implement advise/probe functions in mm/memblock.c to report/probe
    architecture agnostic hotplug memory alignment advice.
 2) update x86 memblock size logic to consider the hotplug advice
 3) add code in acpi/numa/srat.c to report CFMW alignment advice

The advisement interfaces are design to be called during arch_init
code prior to allocator and smp_init.  start_kernel will call these
through setup_arch() (via acpi and mm/init_64.c on x86), which occurs
prior to mm_core_init and smp_init - so no need for atomics.

There's an attempt to signal callers to advise() that probe has already
occurred, but this is predicated on the notion that probe() actually
occurs (which presently only happens on x86). This is to assist debugging
future users who may mistakenly call this after allocator or smp init.

Likewise, if probe() occurs more than once, we return -EBUSY to prevent
inconsistent values from being reported - i.e. this interaction should
happen exactly once, and all other behavior is an error / the probed
value should be acquired via memory_block_size_bytes() instead.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (3):
  mm/memblock: implement memblock_advise_size_order and probe functions
  x86: probe memblock size advisement value during mm init
  acpi,srat: reduce memory block size if CFMWS has a smaller alignment

 arch/x86/mm/init_64.c    | 16 +++++++++++++
 drivers/acpi/numa/srat.c | 42 ++++++++++++++++++++++++++++++++++
 include/linux/memblock.h |  2 ++
 mm/memblock.c            | 49 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)

-- 
2.43.0


