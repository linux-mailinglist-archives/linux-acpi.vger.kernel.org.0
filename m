Return-Path: <linux-acpi+bounces-8814-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24749A0820
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 13:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CCE1F2297B
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3BB2076BB;
	Wed, 16 Oct 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kt1PV4HQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D372076B0;
	Wed, 16 Oct 2024 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077307; cv=none; b=uG6zhqvMYElAC/M8D8gRt8l79+33yocr12GxulJUGu2xMEwnM40pVWtUeKKYn9n4G3QPVHJW4zotehmoQsjPhkOICAvGD1W9nZWCJvIMiebwUB546Pw3/vtRs9CbEiLfQwubhve6PJFdHU5bKTQ197S9btR1fmQAcmwJM5AwLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077307; c=relaxed/simple;
	bh=i1FXqX7vaFlbEdo4x8UD9t358ydTprqjpOUrdWda5UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txx3IKEQoABjj/R3mLMZKDlXWn6AOMNk/9Rl1pKc2uNHsutgVThjFf1I6z976zWp2CUlSq3VNzaPUIp3w9I+77OH+z6EJUfC+w64AcMIVnmLRf3DPUfMNwhlGxbSvDUFruClnc+LBZoK0WKJB9oeS546Hdcvtb0s3FqA/LNto5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kt1PV4HQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729077307; x=1760613307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i1FXqX7vaFlbEdo4x8UD9t358ydTprqjpOUrdWda5UY=;
  b=kt1PV4HQNGzz1N4UYSvrery2NjneY+TzB/N+d2XHOrSQwEncxBuCQCCH
   9ySsix2Z5iVsvbeNZ1RDhR4ETBllWRWY5QBkZvF/3otL8oCvUd+/tNWBx
   2Vyu2KwlEucq8+OO/Kmqyntglx7JtZUdiuitrVqiso11I2HyQegtfzw0P
   lmOT/ohxx813Y3wwX0cCFfe7TTBiWMB9Z1Ej/DfUP2z2vswRdAvZuHUYr
   3LDBAC+ePguI+VGdgKMf1Jud2TwOn31OMLM9Y9bvfZz0IlhqsXIgFi4gL
   LSbHw8lCUDsUC0iSMqDdG4cVbv31fGdFyISzxBc6mAmSttuWkE3xMPNd+
   Q==;
X-CSE-ConnectionGUID: kV0A8A5pSk2q1uYOC2zDZA==
X-CSE-MsgGUID: 6V1WvbRaSuqhHihHIuAxNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51054353"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51054353"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 04:15:06 -0700
X-CSE-ConnectionGUID: 18NRXo91QLy0WV9KmO1Htw==
X-CSE-MsgGUID: 7/8WkNt8SfKBK2g9azrWHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="108937898"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2024 04:15:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D265C165; Wed, 16 Oct 2024 14:14:59 +0300 (EEST)
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
Subject: [PATCHv4, REBASED 0/4] x86: Reduce code duplication on page table initialization
Date: Wed, 16 Oct 2024 14:14:54 +0300
Message-ID: <20241016111458.846228-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kernel_ident_mapping_init() to initialize kernel page tables where
possible, replacing manual initialization, reducing code duplication.

v4:
 - Reviewed-bys from Kai;
 - Fix comment in acpi_mp_setup_reset() (Rafael);
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
2.45.2


