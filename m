Return-Path: <linux-acpi+bounces-7571-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD0F951B19
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 14:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C20282C7F
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649F01B010C;
	Wed, 14 Aug 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyoCX+hc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD81AE867;
	Wed, 14 Aug 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639582; cv=none; b=H+L7WmTQG8U9BgEMUtaFDWavy0rOnQQqSiH8vaSwsQDkWrG4fa4hIVvt+g0ej6LQsVBZjrfTnQYPqPLUd0yS+MZ636kPk3xouNKs1CGlW2agKJFEzRpIqcxTiF57UXfxqU0CswsisJe2hoEkdHeKVZq7+ZJiy3X33zmyFf/zu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639582; c=relaxed/simple;
	bh=a0cCXRi68g4JiVRXEPB/LHB19CLSrWcy7nXvdAn6thM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlUWg5fAODOH4MdE4id2poAz68wJdsoOKhxuZEvsuheDu5YehBPh6bxbX3HJRFxwU8qWruboBtN9gQRByLGGu2L0SowkyVbqUPF5rdhKuXY/ipUJKPFiBjUQliSjxlMNWIWa7yQ+jrjdugIVC3xNnIT++mxJp5uBZZiSG1zfmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyoCX+hc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723639581; x=1755175581;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a0cCXRi68g4JiVRXEPB/LHB19CLSrWcy7nXvdAn6thM=;
  b=GyoCX+hczLgCISNveMyhPSTSEpFKE92HyrkzGXKJx48GG+5R4mcE47Tj
   cOW5HA35QaV7yCV2+uE3fTshCJYXZB5qRnHc/O5NeIyF/W3b2MeyzAD3R
   AhlkkS/ffl52RMM5PjySiYohlGmxXnE8dl8WBs1neLY4ueQy+oYCt5Tlw
   O8UN42vwAghYKqFcJcJslFxcdGuRR4wFsGRC/7p0aCvIdmAIKl5rwdgom
   nx0SzOurKdD3UCtfaSOUbwk/TXsTKb2/+zca0AeJ0iNTtceH5Oir4KYTr
   PMibzCyQ7D4iTuIB6s7QTnXub7sqy5NcQUFH4H0NuYqdn68qi/5iYMavi
   g==;
X-CSE-ConnectionGUID: zf5eLbBRQjOltGXvVc3hQw==
X-CSE-MsgGUID: 2oAsVdZFThCRgV5rrizS1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32426951"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="32426951"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:46:20 -0700
X-CSE-ConnectionGUID: 0eWIGw1pRiCxJzuiAc9g0A==
X-CSE-MsgGUID: hSAcZ2LQQWufLfnd8HGOVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="58886401"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 14 Aug 2024 05:46:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 63F2B2CC; Wed, 14 Aug 2024 15:46:14 +0300 (EEST)
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
Subject: [PATCHv2 0/4] x86: Reduce code duplication on page table initialization
Date: Wed, 14 Aug 2024 15:46:09 +0300
Message-ID: <20240814124613.2632226-1-kirill.shutemov@linux.intel.com>
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


