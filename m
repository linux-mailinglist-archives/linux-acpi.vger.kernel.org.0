Return-Path: <linux-acpi+bounces-10065-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5D69EBD71
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 23:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD1B164C75
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 22:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD04C23D420;
	Tue, 10 Dec 2024 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EKyqi0SA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790E2397BE
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868347; cv=none; b=jbCfspncdJmFT+NaifRy3+jwvs4De7kynCrz2VIU+nrak1PpKLHU/OgXjW3Lbi2t94fiav5NblN9+FRtGZyZzq66nAlbWFWjFog90hnacXujRramfGLPqXO5P0bmJ1hEB4eHSXyHkIiAHg7S0kITF1UjrO20g4eKBbV7AsjnH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868347; c=relaxed/simple;
	bh=KBDt8XQ6WNq8J6YT/YXtGkmxgvjSQrEexeJW45WGLKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkM+H0nm+zKCAzuUMowzRwsv+P+KnlkoStmSYf7FuY5e2NACZuoj8rw+II+1VHmsvtxFbc+sOai+po5iwvzMrdfsnn6LCAnYuoGHo+HUKUo2GBzrnHH3HPWcgnFN7h+aQtFanvSv0zLe78bIPCE5uKj2HoRoe0zJDkwdk5NMyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EKyqi0SA; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d884e8341bso44095696d6.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 14:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733868344; x=1734473144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UvgUsC8+OSYl1zj6uOGNQd8LMwZ5SWRB4r93/t1srT0=;
        b=EKyqi0SAOzaLREivAT5m86LSRa8vpURY+dfI+Hak+CWSxB+IGJwwyRjxHtyvXXqXlr
         woAloMsCwaMpcvVE96l0aXgOTXXkJWc4AaPatHolzpf/qorAf3stHaV7Cd5hIUtTS1Gj
         UsrYBv+3ajzOxvS/6OxkmDq2oyi/S85L0B4rPHrHIqswwk6PSKh6cWb1JQ89U0m7LLaT
         FvbSwLTv051+JsrVtV86eJ2lEI56yi9fLwuaQ2PQ9y/aOEqkjj6zUdYXtp7HfGHJ2p8u
         xHKI0dHw04H22IKv2P3s/VH5l+OHw5Z4gFIIgZYmZFLKAykTjrTnfm8burSC5Usxvz85
         q98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733868344; x=1734473144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvgUsC8+OSYl1zj6uOGNQd8LMwZ5SWRB4r93/t1srT0=;
        b=TH3mTS6OxfsqjnWqdtYxOD8Enyh4H8K1JaYFmdtaV2xflObeD1oKUQkb2Y6B9yzYAy
         mCyMrgYYYKUCq4g3+IOKV+ZZg6CS9Dr4zP67stpDPXR3y9zZ5yqYOhGdy7PrV+pDfQ4K
         n+xcGPy6iqywj9f0kJR1nTHT3Y4oc/214WfvKBcN3Y1ZpYt4/aboe/FJ/4nGr08u9Tr/
         ovRi4mlvwzPt5s80eXNj72DOS2HzKUObUkZdeivw9FTnP57iWgQBk8QDObV3IwbOoPkR
         km73ZvoEwrRlR3gPOHgHFbvSwEAACWlGsin67k7SJv2EPcA5YboRzY6SIUuMRnekaZny
         Mw2w==
X-Forwarded-Encrypted: i=1; AJvYcCW12mW6cgkmu/L3vyenTQXTF+2HTZrYPVjwh5OXVI/vpckAzbTCw9ggr2gFnY8iOs09Tu06B/2vo09b@vger.kernel.org
X-Gm-Message-State: AOJu0Yx173vr1MukPnViZ8ezZDXdxNukAzdrF+HHZu37BwtLrAkKDn8t
	W0btGTTeOQEPSf4/C/QStBjE10OmXtdN46REGGWnSxgUhWBK+2Bnz2x2fgAXePg=
X-Gm-Gg: ASbGncuu5prVLBhJeuvAQTMD2YLGWmnjzYvs9xbG3aC2sZcqfXjyXy/gWXCWEWZM99i
	HuRQo91OLZ8S2LNNjTuoCkdpYFhXXwBCP9/hY1DGYQ/PzcKJcuX+m6svlLee58cFhLDQEp7EsrN
	fvj0iL/2tu5iKArEeicwRXhm5tRi2jgULTtXaJ5a14DvSfjSSW/+gHe1OuO3xnzgxMkqkyK2Me5
	NOBc9ASYQs4tOMG0SpLt/kB1mMgamzhMI6ajaK4gdIsJAAcdvCZuMjsG0uwDSVF5hjJRozPQA3v
	WEoCxiOoqQJbGuI7loOtDd2o7/sD4OyTp8YRwZ4=
X-Google-Smtp-Source: AGHT+IE5ydpoL70LSKM9Nla3l7Xx3LL3OIA9p7ihHnld0+zQW3qbNmeKX9aX6FlxL/xgIC54FK+x8g==
X-Received: by 2002:a05:6214:20a3:b0:6d8:b3a7:75a0 with SMTP id 6a1803df08f44-6d934c161d4mr12732836d6.47.1733868344301;
        Tue, 10 Dec 2024 14:05:44 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8eeb132e1sm49707756d6.35.2024.12.10.14.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:05:43 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	osalvador@suse.de,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v7 0/3] memory,x86,acpi: hotplug memory alignment advisement
Date: Tue, 10 Dec 2024 17:05:14 -0500
Message-ID: <20241210220517.3744-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7: collect tags and rebase on latest mm-unstable.
    ACKs: x86 MM, Memblock/MM Init, Memory Hotplug, and CXL
    Missing any critical acks? Best merge target seems -mm

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
2.43.0


