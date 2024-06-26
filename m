Return-Path: <linux-acpi+bounces-6623-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A3C9180CB
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 14:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A79B26D2C
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7C3180A7B;
	Wed, 26 Jun 2024 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mL9OoxX4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067FD181322;
	Wed, 26 Jun 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404240; cv=none; b=rluZfUT5RizWhuv3uC1n1yucSknnt/DYQOXk29pGLCF0O/rOPJA2ZedpAPvbsx4yqUEu9+DBgKH5RMT8VaHClogjaDr0OyV6VIit5lyx3FKm/RV7p5YIlomNUXP3nINgK/bb7k7qH0kehSFZO3oMHfMNi4bKU9UYd3175N21xFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404240; c=relaxed/simple;
	bh=NgHQJ/f7ZMOymE04cazuO98/ZYo4mHfGTUGjnrhn5Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUTE1lMhwD851C73LcVl704un7xcnQ1cD2p94HrsSRDwb00bLbdwfWvEIhc0t88490i/I4XegGA20gQsmvphR5iTIQQOK7fIyBNCEuiD+I00DD0x0dTAfVu8wVskSGsXvkUfR8svJgZUauxvZmyltWr01Bt638R8wf+435gW9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mL9OoxX4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719404239; x=1750940239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NgHQJ/f7ZMOymE04cazuO98/ZYo4mHfGTUGjnrhn5Ns=;
  b=mL9OoxX4AZ7qRSen/K7yE8PhQ4Qqw4LsCZcnvOzEmZth+n9pORKNLStz
   SX+kEywzmq+Pn6gqO/eqZlVMj3BbB4AiwVMhdD0Z/SQNWAuYG+x8VFI+r
   KLeq+wWIZFddpCqZXPNZYcxJIQERjxO3wQt+GXe9wvQ5qpZTn6rffnd5o
   SzRtHzMZ8DtSuTEuK0ICpA9flnLYIWFmM3ZVZ/73FEi0Gl6pHI1mijkFw
   xCO5/VQyp4UW0C6WqYpjpU0aLgnVejzf56ASbEc81nAImMn0/RdM/wzQj
   mHMCm6k13D0sjG4Vh+21kSRjVWz/p8JfBxwf0z14NTQMqmtUdNYsu9gD6
   Q==;
X-CSE-ConnectionGUID: nqPjZ4lPTRG6WHI6fhDDdA==
X-CSE-MsgGUID: 33A4v9NAQpe2nulsiIdQNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16154116"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16154116"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 05:17:18 -0700
X-CSE-ConnectionGUID: VmGDXlRHTO6ON8CSwkIhRg==
X-CSE-MsgGUID: +LvSAK+zSaSNHKz+srMAzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="81529479"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 26 Jun 2024 05:17:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9E2DB346; Wed, 26 Jun 2024 15:17:14 +0300 (EEST)
Date: Wed, 26 Jun 2024 15:17:14 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Zhiquan Li <zhiquan1.li@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org, hpa@zytor.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/acpi: fix panic while AP online later with kernel
 parameter maxcpus=1
Message-ID: <qtd7pvvw7vgev5ecqjmrvcule7eqyyqxbqg4bu3k37bwhyxtzt@gdp4sjr6expl>
References: <20240626073920.176471-1-zhiquan1.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626073920.176471-1-zhiquan1.li@intel.com>

On Wed, Jun 26, 2024 at 03:39:20PM +0800, Zhiquan Li wrote:
> The issue was found on the platform that using "Multiprocessor Wakeup
> Structure"[1] to startup secondary CPU, which is usually used by
> encrypted guest.   When restrict boot time CPU to 1 with the kernel

Nit: too many spaces after period.

> parameter "maxcpus=1" and bring other CPUs online later, there will be
> a kernel panic as below.
> 
> The variable acpi_mp_wake_mailbox to hold the virtual address of MP
> Wakeup Structure mailbox will be set as readonly after initialization.

  The variable acpi_mp_wake_mailbox, which holds the virtual address of
  the MP Wakeup Structure mailbox, will be set as read-only after init.

> If the first AP is brought online laster, the attemption to update it
> results in panic.

  If the first AP gets online later, after init, the attempt to update
  the variable results in panic.

> Not like the physical address of MP Wakeup Structure mailbox, the
> readonly attribute is not necessary for its virtual address.

This sentence doesn't make sense to me. Just drop it.

> [1] Details about the MP Wakeup structure can be found in ACPI v6.4, in
>     the "Multiprocessor Wakeup Structure" section.
> 
>   BUG: unable to handle page fault for address: ffffffff83086978
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x0003) - permissions violation
>   PGD 3832067 P4D 3833067 PUD 3834063 PMD 80000000030001a1
>   Oops: Oops: 0003 [#1] PREEMPT SMP NOPTI
>   CPU: 0 PID: 175 Comm: systemd-udevd Not tainted 6.10.0-rc4+ #14
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
>   RIP: 0010:acpi_wakeup_cpu+0xb2/0xe0
>   Call Trace:
>    <TASK>
>    ? __die+0x20/0x70
>    ? page_fault_oops+0x80/0x140
>    ? exc_page_fault+0xdc/0x180
>    ? asm_exc_page_fault+0x22/0x30
>    ? _raw_read_unlock+0x18/0x40
>    ? acpi_wakeup_cpu+0xb2/0xe0
>    do_boot_cpu+0xeb/0x1f0
>    native_kick_ap+0xcb/0x150
>    ? __pfx_cpuhp_kick_ap_alive+0x10/0x10
>    cpuhp_invoke_callback+0x2d0/0x480
>    ? __pfx_trace_rb_cpu_prepare+0x10/0x10
>    __cpuhp_invoke_callback_range+0x78/0xe0
>    cpuhp_up_callbacks+0x28/0x100
>    _cpu_up+0xb9/0x120
>    cpu_up+0x91/0xe0
>    cpu_subsys_online+0x4d/0xe0
>    device_online+0x5f/0x80
>    online_store+0x8f/0xc0
>    kernfs_fop_write_iter+0x125/0x1c0
>    vfs_write+0x35c/0x480
>    ksys_write+0x5f/0xe0
>    do_syscall_64+0x63/0x170
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e

The stack dump doesn't add value to the commit message. Drop it.

But it is worth noting that the memremap() function that initializes the
variable cannot be moved into acpi_parse_mp_wake() because memremap() is
not yet functional at this point in the boot process.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

