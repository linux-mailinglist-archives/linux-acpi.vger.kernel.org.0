Return-Path: <linux-acpi+bounces-8915-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204B29AB8BD
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 23:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAAD1C2337B
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CC51FAC42;
	Tue, 22 Oct 2024 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QDYqcKik"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED61F8906
	for <linux-acpi@vger.kernel.org>; Tue, 22 Oct 2024 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632893; cv=none; b=W6cawdilGNrAjG4LxX3MQAuNvfuBQSKUZM8ZLfU0BDUF67nHQenYZGC8gKskF6Hcze0RjxiJLePFaxfgDWe6KJxDBc0krukXcXsIW1qomHcRdigt6wWX+N5e1RlVYXvid0KB2v899EVUO4x3CFK+Bv2YzkTIB23hJghbzKksmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632893; c=relaxed/simple;
	bh=xwfDDQbTCLThpNRe0og1fkpXD0IC3c3zlQRhmU/wbmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qh8V9PNcFu1Qy2SJ5iN+Xye7goYmQ0Uq/m3rVXuzuDuC4xEqOGQx3CH76DwUBFDcewM5EN5JhxWhoyMeFRCdmNeWqaeoKBW/fBtxA9icXubA2YfXK9NsWMo3d5WbywRhx/fPaie5PO7b7+Jb2/xBu15xqyRe0cfj7WNtpDF0RbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QDYqcKik; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460ab1bc2aeso34843181cf.3
        for <linux-acpi@vger.kernel.org>; Tue, 22 Oct 2024 14:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729632890; x=1730237690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBYLsYsNywobQxK/h1515j3uFY4kB27yt4x47cST8Cs=;
        b=QDYqcKikiaIl68bKlX7dJmixgJ0oI64hlHvlnvMjSf5iDw5F1/asSWU/V4ExC2eK0b
         aqmub1u1/2yq8SfscHp7gyP8/qKaP/Zl7c+zpy+2KRns1hhb8v9Mi6baVp7NTRkqo6bp
         1KJEPZdCPyJ4oShZD/jG70iCHF51zDaUYlpNzJYKQJAIt5zLCn+8ehhamXPoN236Kdoc
         FaopIAM2vsAZWCAQhfAdhdYybIRtqCC+z5H/NuTNdMFGSM60D1XomxJAuWrVZ/BBGGrw
         UzsqeX2gVR5kg/eTPV/weON5fdlwsW+rtOYSL8Ytj50er558hTWzM3qN/JSbDY4Jizjw
         /3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729632890; x=1730237690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBYLsYsNywobQxK/h1515j3uFY4kB27yt4x47cST8Cs=;
        b=YdAd0pcjxcc3d6phnenJ1gIjLBD/t8GD4YcO3uZCnMf0kHF515cONcnCxoj6YRoFI2
         LWZWW9sviRXjM//WCOc3hyd/gMxk7GXoSeDLvWxGy/IO2EIt+ueAyZi9HH72hnnW5mGe
         bcrd6NXmp7qLaOB+Ip+Uiw97Y7mYDTOOq/X1bRsby11GyXwQd6LE8GkETZIxavLqmUYx
         QOoC2oZxy6Ng/xVFVTa2bf0L+VT37bavK69N557XhoyPbWxNTn/GXN+MdvQlfIj2UCGF
         HP+ndd+f5ktzKQgmOzD27rJPDfwHZIWrru5x2lP3HwECL95plpK1l6u5urpHuhGbIvQ6
         ftOg==
X-Forwarded-Encrypted: i=1; AJvYcCXQcfLNP2PqJDjSm3SHN73C3vzyhFQtI/hgVPyL7h1RlVpbMZ0bzoimZ0oedjkNjg+93QZJcnedl12h@vger.kernel.org
X-Gm-Message-State: AOJu0Yypsd8dx3wjI35IAj9m5zxoGBWE4T5KCmUvlSiQJNJQIYftYnd2
	nE+qt15YC0tyvLK9ZduK2MieqG1OlFZPCDEI7EzwbKkarlAYri3hpEcBdfTZUzE=
X-Google-Smtp-Source: AGHT+IHM2E05s+anctMoYNkUuZe4zTvXeeDfOgrPz64DGCsYwykO2+8iSWDjYvWyYxuMCWUxh0riuA==
X-Received: by 2002:ac8:7f53:0:b0:461:13ca:b2a with SMTP id d75a77b69052e-461145ba9e8mr4394361cf.15.1729632890514;
        Tue, 22 Oct 2024 14:34:50 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c62f4dsm33845841cf.28.2024.10.22.14.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:34:49 -0700 (PDT)
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
Subject: [PATCH v3 0/3] memory,x86,acpi: hotplug memory alignment advisement
Date: Tue, 22 Oct 2024 17:34:47 -0400
Message-ID: <20241022213450.15041-1-gourry@gourry.net>
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
 1) implement advise/probe functions in driverse/base/memory.c to
    report/probe architecture agnostic hotplug memory alignment advice.
 2) update x86 memblock size logic to consider the hotplug advice
 3) add code in acpi/numa/srat.c to report CFMW alignment advice

The advisement interfaces are design to be called during arch_init
code prior to allocator and smp_init.  start_kernel will call these
through setup_arch() (via acpi and mm/init_64.c on x86), which occurs
prior to mm_core_init and smp_init - so no need for atomics.

There's an attempt to signal callers to advise() that probe has already
occurred, but this is predicated on the notion that probe() actually
occurs (which presently only happens on x86 and acpi logic).
This is to assist debugging future users.

Once probe is called the first time, it will always return the same value.

Interfaces return -EBUSY and 0 respectively on systems without hotplug.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (3):
  memory: implement memory_block_advise/probe_max_size
  x86: probe memory block size advisement value during mm init
  acpi,srat: give memory block size advice based on CFMWS alignment

 arch/x86/mm/init_64.c    | 14 ++++++++-----
 drivers/acpi/numa/srat.c | 33 ++++++++++++++++++++++++++++++
 drivers/base/memory.c    | 43 ++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h   | 10 ++++++++++
 4 files changed, 95 insertions(+), 5 deletions(-)

-- 
2.43.0


