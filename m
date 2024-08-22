Return-Path: <linux-acpi+bounces-7775-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA25795B528
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 14:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253EEB20BB0
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 12:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3791C9448;
	Thu, 22 Aug 2024 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHp+mZay"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3613A244;
	Thu, 22 Aug 2024 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330409; cv=none; b=KE+/fz3z5UFks6C/pqm6BoGdC6r8F3O78xauAPPdmeeoD4ZZzp32K/fUNw8P0o9DvurLXHfSXDBuOMeT+WMYDUQOf6f7sPIWvbIrouHemphXTkR+No17AnZOJVgj1CVXxKNrbyEjlJbtVkCnLZnnzWK+QcNO9wAz/V03MBRFxK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330409; c=relaxed/simple;
	bh=H49+8EkYQypOXjbX3bI2fF++m6LZzdYlbAzkt1huANg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNmem+V9ug9KQPfsYOw/6xzMe2nrupfC7LxNnyHTKTXqz4dPXXw/c+CvzU7jJVdDlld7wxMHZxRQaaVry3BFHHOydVGLoZ/ndzMw1I+6MvTnIZZcpCa7BqWZUtEnl9ULYLU5h6o6RpEVy3MxI6CXBMdb5o5PV9aeGHSPItG4N+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHp+mZay; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724330408; x=1755866408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H49+8EkYQypOXjbX3bI2fF++m6LZzdYlbAzkt1huANg=;
  b=LHp+mZayfhmCrXpCIoNVwQdegpdR8C1cy0culveMjRVD/OQl5UsaeuWS
   Q5/lzOnDCn1c/0xb4cvW10pWh2tGM1EorBQyxWP/oD4Ejak6AzqxPpTFC
   jUk8lX2Utcowrc6DqP2r1b5aw4fbg8TnYnp84mGPUn+LZkVi4uKahUfdh
   GwLBFX1NaqLUgxV394CDrJuOBVMoNPaOLqt5+ZFnx8yWUlEKJbozXKesN
   Wn+pb9h+Uy8S2gZ7CBJPewSFScz/PsRbbeDmwy0hXqvx0AUzDylOm6n9P
   kRL8azDkv5H8W8ZGc8mrLIWdslx1gYjgJYmVPGrgp0PslGOWJFTlFVvY5
   A==;
X-CSE-ConnectionGUID: OwaZECJjTLKiCRoGW7NwzQ==
X-CSE-MsgGUID: 6TtsYkBYShen19MucoHoYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="25635640"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="25635640"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:40:07 -0700
X-CSE-ConnectionGUID: CM6RtH2tTViTzBMYCHv5Qg==
X-CSE-MsgGUID: Cjd4yENYT0+yWdfUrVS6KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61443039"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 22 Aug 2024 05:40:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0B1C62F2; Thu, 22 Aug 2024 15:40:01 +0300 (EEST)
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
Subject: [PATCHv4 0/4] x86: Reduce code duplication on page table initialization
Date: Thu, 22 Aug 2024 15:39:56 +0300
Message-ID: <20240822124000.1171321-1-kirill.shutemov@linux.intel.com>
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
2.43.0


