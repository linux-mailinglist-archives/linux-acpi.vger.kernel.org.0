Return-Path: <linux-acpi+bounces-12036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3B7A5A3FA
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 20:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4B23AD51C
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FF41DE2A4;
	Mon, 10 Mar 2025 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ5fxrU7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D11DDC1D;
	Mon, 10 Mar 2025 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635945; cv=none; b=WW1rdUmPOYJ/2qJOtWbcTCAXLE76GA/cTk4P4/Ps1mkSD5I02Qf/JphApVjGIoGNfzwXB2xV1VBeKf3WYfKB1ypN9HTeFmcf9BBUOxW990GH1C2zWipZjxwC5Y6ozp/usfSp2yh0dU0KPJQUJ00sVv+enFrGXwd/NpEqvRrgS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635945; c=relaxed/simple;
	bh=TxvOlHkzSUtLhp0SC2wxUj4g9B1ax/MHJBU7K9Vv988=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdRlEp8mlpakgVTT4UnVZrdiubsAUO5J7VD1JSmubwlcmv/vQyGqO7LxbnU8VPUvDae6sg782DglomQTBP/QfPDcnoez9x2gbmqDS/tINp4q1yjsAPVCKngXpTwgC/eWG3DyMTkEgcPy6Cd1yD+/f4lXWbCnmFDsdpyclKPsSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ5fxrU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BD2C4CEEC;
	Mon, 10 Mar 2025 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741635944;
	bh=TxvOlHkzSUtLhp0SC2wxUj4g9B1ax/MHJBU7K9Vv988=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZ5fxrU7iDWSu33xD4ohuQdXHoIGbutYoC+CmImigBoMf6F4Lyl7Wh/RC6q4A3TD3
	 iKrp2FzwTpa+l0btny9W6MjyGMcX8mEVH29dG2XMMBFPXgTw8eR3BEkOlq+fc8J4QS
	 LZHXf60gPWOTPWnqgf+5zLn4o8kALR6V9elm/OrGYQcJ3t2wQ/+i3o81hL6ijC5XAv
	 GKZcU7HSZt7fXcyc2r8bJnrthYfaflORyMoom7GshynKsZgD95MXAWq/GQG391ZPid
	 ZrYKnSIQLgPjU0en2FcRdnx+cesz5bvLRjseiFHCuyFe6dLLixHMHI860WCbI3vdj2
	 tqb+MO1VX3t+w==
Date: Mon, 10 Mar 2025 20:45:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Baoquan He <bhe@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCHv4, REBASED 0/4] x86: Reduce code duplication on page
 table initialization
Message-ID: <Z89BYeK3diXVDJxx@gmail.com>
References: <20241016111458.846228-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016111458.846228-1-kirill.shutemov@linux.intel.com>


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> Use kernel_ident_mapping_init() to initialize kernel page tables where
> possible, replacing manual initialization, reducing code duplication.
> 
> v4:
>  - Reviewed-bys from Kai;
>  - Fix comment in acpi_mp_setup_reset() (Rafael);
> v3:
>  - Reviewed-bys from Tom;
>  - Improve commit messages;
> v2:
>  - A separate patch to change what PA is mapped at relocate_kernel() VA.
>  - Improve commit messages;
>  - Add Reveiwed-by from Kai;
> 
> Kirill A. Shutemov (4):
>   x86/mm/ident_map: Fix virtual address wrap to zero
>   x86/acpi: Replace manual page table initialization with kernel_ident_mapping_init()
>   x86/64/kexec: Map original relocate_kernel() in init_transition_pgtable()
>   x86/64/kexec: Rewrite init_transition_pgtable() with kernel_ident_mapping_init()
> 
>  arch/x86/include/asm/kexec.h       |  5 +-
>  arch/x86/kernel/acpi/madt_wakeup.c | 73 +++++-------------------
>  arch/x86/kernel/machine_kexec_64.c | 89 +++++++++++-------------------
>  arch/x86/mm/ident_map.c            | 14 +----
>  4 files changed, 50 insertions(+), 131 deletions(-)

So looks like this series feel between the cracks during the holiday 
season.

To help move them along, I've fixed up the first patch with the review 
feedback clarification requests, and applied patch #1 and #2 to 
tip:x86/mm:

  4f10ec03fe1e ("x86/mm/ident_map: Fix theoretical virtual address overflow to zero")
  376daf20eda4 ("x86/acpi: Replace manual page table initialization with kernel_ident_mapping_init()")

Patches #3 and #4 don't apply anymore, due to interference by other 
work with commits like:

  4b5bc2ec9a23 ("x86/kexec: Allocate PGD for x86_64 transition page tables separately")

If the remaining patches are still relevant, mind porting them to 
latest -tip?

Thanks,

	Ingo

