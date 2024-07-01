Return-Path: <linux-acpi+bounces-6698-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83B191DFA2
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 14:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D0D1C2156D
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB47158D8B;
	Mon,  1 Jul 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eo5HqoFc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B977115;
	Mon,  1 Jul 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837828; cv=none; b=dy73FMz8HwfqXyRBu3eUskYtZsZGNAdhkaWg1FXlDgHaxrWXvZaLnZYuboovmZTN7A/PeeMIh9ICB/5sdomTB/rKC2hTkoch889xF4KV7b4ceSpZxC0ZYoc5pD36asNH+gMTuXc5aO6N/dcmvzAhmuj+tiEjQoufGRQRu8SOwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837828; c=relaxed/simple;
	bh=fuZHtYepSjJ+dKAML5RqYEDMwlfQw1MHuNoSf5j7xF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oh8FCbZkVknzrP+VGlnFZKJdFPa91ORQPWZecKUjgGvJBLJECZmcvsI9x0isR0esnhxZ59kRk4CzZ/2B0CDHGIkVUXBQgPuaQEz6xY9xpszJZ3JHbfNnDqK8czuj7SYlV7tWvVw1i3HMNmEEqFNysWxIVC2X6bODlEg7FOw5Vs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eo5HqoFc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719837827; x=1751373827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fuZHtYepSjJ+dKAML5RqYEDMwlfQw1MHuNoSf5j7xF4=;
  b=Eo5HqoFcdUb9hYVr91ZRgXiR/NCa/oBU4iCSMHmTuKAuzn3mO4MVoWgn
   WL4+hMBDIj6VKhfQBtKtA3VQkeuIWD1McN2UmAXzhSS5/kkQcyvDtRLAK
   vVaQeNeq54/PTUYQaWITCUQIlutJA+mBOBf9yI3fAwGoGPY0RoU0mlEnR
   RC5UAlXYdcEZsPtTDOERwXeG0NJuWr3Pfl6kDUznllj9GSFOPZseSJIjW
   l0HRCZMAilq2NSHxnfB6HKK99mno3mJzlvmJJ1OzDQYfXrNXeIguu86ED
   2Z+NM67Kx8l9zzT9qSX/qErPG5yUtfImQJBX49d8bkMyy/0WFWHiOT5I9
   Q==;
X-CSE-ConnectionGUID: 4zTatBpMRO+AANSc5WEm0Q==
X-CSE-MsgGUID: jU9SInQ+SL6+YKX3cxavsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20717559"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="20717559"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 05:43:46 -0700
X-CSE-ConnectionGUID: G9gf8jThQLa1r9xw+cDMjg==
X-CSE-MsgGUID: gMdY0FQ4RDGnKzBUvYHueg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="49971716"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 01 Jul 2024 05:43:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3C686341; Mon, 01 Jul 2024 15:43:41 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Baoquan He <bhe@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/3] x86: Reduce code duplication on page table initialization
Date: Mon,  1 Jul 2024 15:43:31 +0300
Message-ID: <20240701124334.1855981-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kernel_ident_mapping_init() to initialize kernel page tables where
possible, replacing manual initialization, reducing code duplication.

Kirill A. Shutemov (3):
  x86/mm/ident_map: Fix virtual address wrap to zero
  x86/acpi: Replace manual page table initialization with
    kernel_ident_mapping_init()
  x86/64/kexec: Rewrite init_transition_pgtable() with
    kernel_ident_mapping_init()

 arch/x86/include/asm/kexec.h       |  5 +-
 arch/x86/kernel/acpi/madt_wakeup.c | 73 +++++-------------------
 arch/x86/kernel/machine_kexec_64.c | 89 +++++++++++-------------------
 arch/x86/mm/ident_map.c            | 15 +----
 4 files changed, 50 insertions(+), 132 deletions(-)

-- 
2.43.0


