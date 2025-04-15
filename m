Return-Path: <linux-acpi+bounces-13054-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A392DA8A108
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 16:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40C1188BC67
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9E7292908;
	Tue, 15 Apr 2025 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OY5walNG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74B2274667;
	Tue, 15 Apr 2025 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727206; cv=none; b=A4IveDAd22WXTYLfbSmPcAVlfOro11hhuyDTa7LM/1vYrX571KYBTWBCyLCpzc9fRm8Qd+2SL3Xkot7pX37ZYNUZaWVnQcFv1SP5jf4TjYqe+t84Du5hvb79sVgbA1bWE31BlNJ0af0QmNvb3iFAAEbmqcC5+p2VdpDdcUj9T8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727206; c=relaxed/simple;
	bh=Bq1aX/9x+bBl9UZHPWD8vQa736mPyduikCbWH/1mC4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3Bor0x8TFWJEQdscAX3AHRq3K6Cze/rv7x7PJp0ZOuRqH8CHDBSyCO7DgzePyp+aJwL2LLIEedAdO1upmOqSGgYPuqtTUpeJwQfHFCesFhZgA9HHt4Vw3ZEhCB4uvjHvuv7Zh22gXi/BMWSrgynUKcHPx4dHzSyvhAfxX9GfF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OY5walNG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744727205; x=1776263205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bq1aX/9x+bBl9UZHPWD8vQa736mPyduikCbWH/1mC4w=;
  b=OY5walNGD56w3syaZkQsYddMxP6Um64xRTiZ6e4aUGy0JjWwRUBdEEWS
   79meGIsW6ychxoQq0tKxwYOlr0Uj8PX15CHXnE3WHFLXX0p0E1iqv99Vp
   FrcaB2rNB02hxWeVsOzi9NeNbPEJ/c7wi/ySJ2JN47ETOGJEtz8DCaw6b
   DCczxLmTubK3vfRlJ6Uv6EW/os1SjC7q8ATWcamwBsw/cBT76YKpXmYyy
   ETZz653KuV1zhTnHLT3fApPTRpPj27+UlPfnK9esEsZyquwJUzoJaKxwi
   fymw/vxkCd/nQmMELFSuPzVemh5ag6Di6Yp/77ghmLBdB5FiLl27estZ8
   g==;
X-CSE-ConnectionGUID: Ze1FDUR+TGGp3w7bT/GHag==
X-CSE-MsgGUID: SCF1EKDGS+m/STAFIsnvmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="33854593"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="33854593"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 07:25:37 -0700
X-CSE-ConnectionGUID: k/m1UDE2T5WASAWSIOaJtA==
X-CSE-MsgGUID: fxVpXjCZTpug097XbdwjeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="153321991"
Received: from iweiny-desk3.amr.corp.intel.com (HELO [10.124.222.150]) ([10.124.222.150])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 07:25:36 -0700
Message-ID: <55df184b-ec0a-4274-b60b-37e8ba323cb8@linux.intel.com>
Date: Tue, 15 Apr 2025 07:25:35 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/acpi: fix potential NULL deref in acpi_wakeup_cpu()
To: Chenyuan Yang <chenyuan0y@gmail.com>, rafael@kernel.org, lenb@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, bhe@redhat.com,
 kai.huang@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250411194820.3976363-1-chenyuan0y@gmail.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250411194820.3976363-1-chenyuan0y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/11/25 12:48 PM, Chenyuan Yang wrote:
> The result of memremap() may be NULL on failure, leading to a NULL
> dereference. Add explicit checks after memremap() call: if the
> MADT mailbox fails to map, return immediately.
>
> This is similar to the commit 966d47e1f27c
> ("efi: fix potential NULL deref in efi_mem_reserve_persistent").
>
> This is found by our static analysis tool KNighter.
>
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: 2b5e22afae07 ("x86/acpi: Extract ACPI MADT wakeup code into a separate file")
> ---

Looks fine to me

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   arch/x86/kernel/acpi/madt_wakeup.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index f36f28405dcc..b386ec4b87c2 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -143,6 +143,10 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
>   		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
>   						sizeof(*acpi_mp_wake_mailbox),
>   						MEMREMAP_WB);
> +		if (!acpi_mp_wake_mailbox) {
> +			pr_err("Failed to remap MADT mailbox\n");
> +			return -ENOMEM;
> +		}
>   	}
>   
>   	/*

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


