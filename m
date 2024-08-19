Return-Path: <linux-acpi+bounces-7648-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA3E956415
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 09:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57436B2152B
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 07:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F20157472;
	Mon, 19 Aug 2024 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzgJkNqn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694D1459FA;
	Mon, 19 Aug 2024 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051318; cv=none; b=WE0Ak6gAR/OASF88OKak7tMFnG6HtTq6y1mBv4sQiRsC16kUIuFtvv4QnUtOY+g8goZCf6vfqgdFQcTZkBMWcJ5TzhsCxcNB3w+HgQNieFfnCCJ7hI/PxBSfcdM46syQvemw8H+tH5H7l6QvUPsN3Kk+FfpFFadujIn/o8NaYp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051318; c=relaxed/simple;
	bh=EdzA0t1Rwdo/359oMIkrXU1yMk7yXLkrn4xOvK7DWLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJ+wGp3aLT7pZ3rQeKisaiRBsaI/3QOb/Y0hVHGPR40GhvMjnvRqJUgdNtVYCNrLUfW8COMxzRxXzuQEsIznztMqZt3jGM7Axjfd7lLaHs7/pfxHQ0SRS0L902OGOfCef3j+VMiKGxuM/5j57CNCq6fEZOuxaEzUB0S7M0DAxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzgJkNqn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724051317; x=1755587317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EdzA0t1Rwdo/359oMIkrXU1yMk7yXLkrn4xOvK7DWLY=;
  b=NzgJkNqnlLPjXQcuUvLfTxdElDeQxHrOYLzd7iXr5D04QH8oosfAL0Ap
   JtDxHl7TwsYoFN94MWyCkGWfo4FzS0egYeadTZrJbQDLzMyKagHMnKWA1
   cxil51Wqj9mm1Bbx2tKW0bCdFwr1s1rgI/i+MWekpw/sIJFzla5RsLjte
   RhUD3tzUklGBtIuDxnTnumUUI/GSjLg+66ept2GlV/BwSvtod/OxaXW/n
   X/zz8XOnwTZxiB+U1VI1xUz63nvcNOAkxA2438a1kEoiXwWjPWyMdZo0P
   DR7AwbYS3Bp2GeQ9xCPTYvU+P6WIo1nfxXah8ezmnUlzGGE/bDZOliFXr
   Q==;
X-CSE-ConnectionGUID: uc7N6mdpRU63Tr3d2Rg4aA==
X-CSE-MsgGUID: BNCoVUyTSveVv98kzXWlPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33697334"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33697334"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:08:36 -0700
X-CSE-ConnectionGUID: nhr+42U5TkOFqWlcTtDISQ==
X-CSE-MsgGUID: wQYjRlVeQd2Kz/IjrB6etA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60273931"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2024 00:08:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3DE4D330; Mon, 19 Aug 2024 10:08:30 +0300 (EEST)
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
Subject: [PATCHv3 0/4] x86: Reduce code duplication on page table initialization
Date: Mon, 19 Aug 2024 10:08:23 +0300
Message-ID: <20240819070827.3620020-1-kirill.shutemov@linux.intel.com>
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

v3:
 - Reviewed-bys from Tom;
 - Improve commit messages;
v2:
 - A separate patch to change what PA is mapped at relocate_kernel() VA.
 - Improve commit messages;
 - Add Reveiwed-by from Kai;

Kirill A. Shutemov (4):
  x86/mm/ident_map: Fix virtual address wrap to zero
  x86/acpi: Replace manual page table initialization with
    kernel_ident_mapping_init()
  x86/64/kexec: Map original relocate_kernel() in
    init_transition_pgtable()
  x86/64/kexec: Rewrite init_transition_pgtable() with
    kernel_ident_mapping_init()

 arch/x86/include/asm/kexec.h       |  5 +-
 arch/x86/kernel/acpi/madt_wakeup.c | 73 +++++-------------------
 arch/x86/kernel/machine_kexec_64.c | 89 +++++++++++-------------------
 arch/x86/mm/ident_map.c            | 14 +----
 4 files changed, 50 insertions(+), 131 deletions(-)

-- 
2.43.0


