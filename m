Return-Path: <linux-acpi+bounces-10559-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E10A0BF13
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 18:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5119167D99
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 17:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B01BC9F6;
	Mon, 13 Jan 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gWD8sduM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BCD18E764
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2025 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790291; cv=none; b=sHz+sRrmsWT3wckslAzXuAM5u3Uj15VYqjf76s4EU2N2gI90iz9rUVYFxHZHZ38kuRgOHxrPY4Ow5lmpw4Ba9n6zsNrf71gEtlOD+diN8WFoKE3ksA40NDJXncafvTcEqR4RnMLpnPDg7P3kjbXoXyld0jRddxyYk3ERZ4mKTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790291; c=relaxed/simple;
	bh=pu7iIprMdueTl2ohHEpNV4okTctQsI90dmSFl4GE6TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3mg8RDQnuDEMAHVoD5V3PDyq17eqqDuxg9AIKFRl1jq9nWpn0XRYJTNMkL+g3lt7XLTtG+xhrDH6dYKkMq/ZGLWJQUiJFDGkY2ZkvqVKWHFQDrTi/c72wDQGNGdBseUwdCtQokljxi3vNeGOh2rSzD5SvXleVNvck4Gm4hrd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gWD8sduM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7bcf33f698dso232638785a.2
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2025 09:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736790288; x=1737395088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZDY+roqlFWFlucPr2s+hwWgkw5ODZbVNYznP3NH7H8=;
        b=gWD8sduMLbWW+Q20AHNqlcJEWvTzLzSr7ZC3/B1ogXzD0/9Bp5Kp1II6hPCRDjCuzM
         ARRqyz9fX62eOeyqlbPwsvZylX+2mVvCRVJVUDAZrMniZvtK/J68DFpaNTSfZj88Kzu7
         qIMaguLEsP80Irw7kKm/yNgzBxlAlfSkCRFjEL1lmZ1OGKdkzgmA8+kS9+5NUoDABZe0
         fLQKGetagvDx0/eXiPTYD0xIPNrWDNVxREaSvNTe+Qoc7WGDdsr/4fuxh2xbyf3QDT+D
         FhwfVDL7TX0S9yoI+tcXdM2bSeKPciX5XS4u0XWLTSXvom6PVX1UAebuHrStnPDMdwdV
         MpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736790288; x=1737395088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZDY+roqlFWFlucPr2s+hwWgkw5ODZbVNYznP3NH7H8=;
        b=YBOuecshddodJRYSD1PfVUQOwBOpSLfbrHMlcj6d1KUTY3Xb9EKdhQqp+M+ljdNfcK
         bkuzOmGdVUSpMLwVkQaN/mWeQCHO/mC6Tc1+x57RBLOqtwEr2ozAucmFIxa27YNpaj/4
         uBa76rInVopetfXPyfwsoFJC1AbQYprnwAnhYb9r1WAoH3qTWPO0spNfJmv4SjFPN/Ur
         Rhn0GcklRC8l1ElG6OtzvDHOJdqfErg85GR1t+EEVPaMCKYXGAbQPBLfuQAT/Ptq8MmH
         hkzLWxT8jfXSx+3ZlJJhLBOCud71uXQiM3cbYMcGgZvIqZXAjGXqcnmXVKwMNfB6PD3O
         wOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxTpKdFXjDc7NMLv7Mq7sA5gh4qFlUkWPP21UJcg8uJov3LiVFcGODvYMEVPp7tKU8Afda03PYG6zk@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqfbS5oqjisamoNHuS8ycTts/nVYRIOXHGY3IfsYXH3iOZJN+
	g2ZCIPpLF91s/lTDA9S0ljNLQpesTgbtv1R7UxpfLnAjrBCyzwaAUQ9FTkCZI94=
X-Gm-Gg: ASbGnct0VEaHcM9SpiIE+Q8yh7WwoEFfh4+tt/aQ7/9YGO4V4qvOCCltLAWQVw3Befu
	g3yDgPVYtLeMnmIsrxroM2BxqWvEIploIV6kbJNm+kUIn1WhVm9zSaWAg9w+S8INFmDI/yRA8fg
	b9i18q/p10qv2yR8gMWPDvvUnBBa3TeHVcpDsPJsrnsLyYOkcBYd/c00qbAPF8dDRQZGLUKgCj+
	FRIBAiB+7AozkaxV0hFALsdWDS2j3rhshXHBx/Qu55HMO/MtZac7iV40P5IKyq3EQwxwkhAKx5p
	sNy6f/lL7/4FaGxLTZHtSGwjUnj4P0xmDm3qt6DjnT4j
X-Google-Smtp-Source: AGHT+IHX1aewgna2tPJ+Kpz+e7MVsUxTNCPKq11aXN8qXChUb+HG4maQWEFLCXjBLN1Qz50JhJ5yWg==
X-Received: by 2002:a05:620a:248c:b0:7b7:106a:19a2 with SMTP id af79cd13be357-7bcd971c3f3mr3611917885a.31.1736790288625;
        Mon, 13 Jan 2025 09:44:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248c80sm511214185a.49.2025.01.13.09.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:44:47 -0800 (PST)
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
Subject: [RESEND v7 0/3] memory,x86,acpi: hotplug memory alignment advisement
Date: Mon, 13 Jan 2025 12:44:36 -0500
Message-ID: <20250113174439.1965168-1-gourry@gourry.net>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resend: Not clear if this should go through -mm or -acpi
	clean rebase on mm-unstable as of Jan 13, no changes


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
2.47.1


