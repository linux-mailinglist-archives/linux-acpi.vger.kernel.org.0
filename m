Return-Path: <linux-acpi+bounces-8603-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350BC9950DC
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D57285512
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF021DF743;
	Tue,  8 Oct 2024 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ue8L2V6z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912301DE89A
	for <linux-acpi@vger.kernel.org>; Tue,  8 Oct 2024 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396050; cv=none; b=C26SsZatif1uZC2juQdmKSloqpZfn6MKz0/WAMkshmYY6GX3wFOoZwQqN62yMLSFScrpXZ7+YNyhQLq9hdplJBYPtaaMYs5BXWefv7oaeuE+rvGoMRtWi0mE7sntuhDbmkhrnFrPH3p84/6cA8MaOTDrbJZop2en2zxgp0kM/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396050; c=relaxed/simple;
	bh=UNjIPY8+xoRAvxxrDhOF6tnBMwK8Oogqz1I8b8ngD+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5WK8Fkt2bKkP+gUpK+KkbdkwIcOXmkVHiKUacKGPNPgTy/6HZZSVu2XR00JDtoSCIvd1i0shKOVuqXomxl/6NvuPQEi99D/wHGhsfNToMRJtD7MYmH7AOku0xKeACIkxhJsL8ZSik+cS0MwY0hx97AeYO1BsrHJHMoXX19z5Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ue8L2V6z; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-45d8f76eca7so57928011cf.2
        for <linux-acpi@vger.kernel.org>; Tue, 08 Oct 2024 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728396047; x=1729000847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWPfeq8jzkffwKXmR9I3LKRrKqlhfBH5YIi7C0BC88U=;
        b=Ue8L2V6zQCfYuv6Qr/VBwq6yoq5RjjrmOoExa5RBIhJFVtUSfexQSqxsMBSPwPd7xm
         Y3UpcPCYQ/7Q932Mt6hLVPzKVZu5jbg3RsRKXkgFuoNqHVXlUNmxZUFyNv8Xk5qx/uip
         spHVbc22PgjaAzdpxFqB1kKJgkd6upmP9GHLrFOAmwVmES3jkPkIAvRV9MjuybmqzOxk
         msyR7w0jjQuyDCMHlWq9KzC/S5SDZVRAyVfO1+il8ISqYHPUGtPzgvMVjPMjTlqGWoQJ
         hmXhokJ4Wer6+2l73BfLvh2vQmm+QgY4V1BnUcwBFbgQlZbQSiWkdfIQFPBqAIxI9dNm
         SJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396047; x=1729000847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWPfeq8jzkffwKXmR9I3LKRrKqlhfBH5YIi7C0BC88U=;
        b=HKDJ0NriuBT5FSVokVucxuPjLNkQxEIoRp4SH94ltW48um5frDWhhyKYl+OJwIld2L
         MpLQ/SBjwbyeyTgjUonPFlnlsvYy//z9ji0pAJbZ+tyxUyn4M7QkOeWQxKAkt4IHWKVN
         Xfi+fy6pglVf4stN3VnLAiE+dxhVy0Z7nJBaLz+XZGVzvzRySQzartK+KaK8Itj4OPyp
         9tPy12+29G44Bl1TXLQgvdDOWJTbqlDb5I1eeEN8v6p4jsG52FMy1ukxIb4GXMlAfs/F
         0cdFUgxK8X4un3rdsrMxzW4X+BVaoT3oXUgI2Jz+vMEDx31ohzAmM3tnhg5ECfwgYgkv
         8t2A==
X-Forwarded-Encrypted: i=1; AJvYcCUcBkOGqDhEOPlh71u13MaBDEKQX6m7GVYwbaC4CgJZG5B+APvrzaX6tVperWyztedfcptOu9zEJ3Qr@vger.kernel.org
X-Gm-Message-State: AOJu0YxUx7cMLJi24sqytqYxQ9m7JIimUj2y4sjgSR+s3Je9eglX27B4
	jcp7EUQq/JOSQlm9xwJNJmh4oZ5QuTiDcD2PLhlzr1Pk0xr+YWKQrrKtogStisQ=
X-Google-Smtp-Source: AGHT+IH75tlHFY+xDD0L05P6I4e5i4mq/QT/nf3Kc4ckvIK+23NRCaD0FQ2upLKZkK1gutE6MZuxCA==
X-Received: by 2002:ad4:4ba6:0:b0:6cb:a286:5807 with SMTP id 6a1803df08f44-6cba28659afmr160226446d6.24.1728396046336;
        Tue, 08 Oct 2024 07:00:46 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbc78650efsm698396d6.39.2024.10.08.07.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:00:45 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@Huawei.com,
	alison.schofield@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com,
	lenb@kernel.org,
	dave.jiang@intel.com,
	ira.weiny@intel.com
Subject: [PATCH 0/3] memory,acpi: resize memory blocks based on CFMW alignment
Date: Tue,  8 Oct 2024 00:43:52 -0400
Message-ID: <20241008044355.4325-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When physical address capacity is not aligned to the size of a memory
block managed size, the misaligned portion is not mapped - creating
an effective loss of capacity.

This appears to be a calculated decision based on the fact that most
regions would generally be aligned, and the loss of capacity would be
relatively limited. With CXL devices, this is no longer the case.

CXL exposes its memory for management through the ACPI CEDT (CXL Early
Detection Table) in a field called the CXL Fixed Memory Window.  Per
the CXL specification, this memory must be aligned to at least 256MB.

On X86, memory block capacity increases based on the overall capacity
of the machine - eventually reaching a maximum of 2GB per memory block.
When a CFMW aligns on 256MB, this causes a loss of at least 2GB of
capacity, and in some cases more.

It is also possible for multiple CFMW to be exposed for a single device.
This can happen if a reserved region intersects with the target memory
location of the memory device. This happens on AMD x86 platforms. 

This patch set detects the alignments of all CFMW in the ACPI CEDT,
and changes the memory block size downward to meet the largest common
denomenator of the supported memory regions.

To do this, we needed 3 changes:
    1) extern memory block management functions for the acpi driver
    2) modify x86 to update its cached block size value
    3) add code in acpi/numa/srat.c to do the alignment check

Presently this only affects x86, since this is the only architecture
that implements set_memory_block_size_order.

Presently this appears to only affect x86, and we only mitigated there
since it is the only arch to implement set_memory_block_size_order.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (3):
  memory: extern memory_block_size_bytes and set_memory_block_size_order
  x86/mm: if memblock size is adjusted, update the cached value
  acpi,srat: reduce memory block size if CFMWS has a smaller alignment

 arch/x86/mm/init_64.c    | 17 ++++++++++++--
 drivers/acpi/numa/srat.c | 48 ++++++++++++++++++++++++++++++++++++++++
 drivers/base/memory.c    |  6 +++++
 include/linux/memory.h   |  4 ++--
 4 files changed, 71 insertions(+), 4 deletions(-)

-- 
2.43.0


