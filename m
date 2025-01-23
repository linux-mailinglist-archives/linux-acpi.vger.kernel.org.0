Return-Path: <linux-acpi+bounces-10807-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFEBA1AD56
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 00:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1A4162E0D
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6281D5CDE;
	Thu, 23 Jan 2025 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikfobtSV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE31D5AB2;
	Thu, 23 Jan 2025 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737675805; cv=none; b=PRUt2TKCM+3h2jNnHmal2ahEKjniujgnr2s7ORp1scR1r4wZtAh1eMnWbgdUm/iZS/hXoRTE/SEGIVcroSsRpLTICUBCANx7DZBD/weQtDia7TvJKVTzKjMuB5bKsR1IHh0HOkuMW/pHGELGcE8jh7q0Xd0X/7townrZ79oiHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737675805; c=relaxed/simple;
	bh=pd8v4DJXn+nrkFcg3+sLe00ManGxlnYRoHhRl4IITgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMQo0arpqxFUdukNaZcneUwaIuTqyqrI6icryEKAlqH1puVQeh3nndSQQ+/86zh/bffkXekYsNylYnvH5Z8wOtzw3omTBO8e5Ap9aA51lQky77bbUrAKQVQk8UcvbNwC4kTcqLfNRRISbUWNlxZj625LUkzN9YzsasxXde4a2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikfobtSV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737675805; x=1769211805;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pd8v4DJXn+nrkFcg3+sLe00ManGxlnYRoHhRl4IITgs=;
  b=ikfobtSV0luyXRl3Tgunn13m0b1mB6VEDsvX2u3ZMuoTjrmU0wbIPWJs
   ATYeU/YH2T1sj7+bGYKmFNMvqOoXHnaqYbOapchOOPytpnxkZu7L38n5a
   PEMLOQEc4pJERAYE7Xc6K6j2ldWbsQY5A6GkYQtBfcKQWG4schjUfw0Fl
   Xj5nfgzYs2wNVwFw/zWt3v1poIm3+vPias2lMiXmxonU90KIa4gTM5EGE
   o5CnEJnnUfro+1gjr9vT+7kXVvDXIFA0zsu3hXGJU5KuVJ94Ge6Qz/KeZ
   H43WxFPx4iDjJy6nC1uMadB1Jbs93hQoritLHsVa5d6cEFVKASrYQRlRU
   w==;
X-CSE-ConnectionGUID: 44F0E9nXRbaNmgsipzo3JQ==
X-CSE-MsgGUID: 7e87NDQ0Q2iQqwKzF9g5pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41869751"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="41869751"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 15:43:24 -0800
X-CSE-ConnectionGUID: JJN88XbhS7G6dqcCUx695g==
X-CSE-MsgGUID: J+j8P9r4TLy8qsDDg4I4zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="107426311"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.229]) ([10.125.110.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 15:43:23 -0800
Message-ID: <649ed1bb-0686-42f0-802f-9f1909aeed8c@intel.com>
Date: Thu, 23 Jan 2025 16:43:21 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
To: Murad Masimov <m.masimov@mt-integration.ru>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org, syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com
References: <20250123163945.251-1-m.masimov@mt-integration.ru>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250123163945.251-1-m.masimov@mt-integration.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/25 9:39 AM, Murad Masimov wrote:
> Syzkaller has reported a warning in to_nfit_bus_uuid(): "only secondary
> bus families can be translated". This warning is emited if the argument
> is equal to NVDIMM_BUS_FAMILY_NFIT == 0. Function acpi_nfit_ctl() first
> verifies that a user-provided value call_pkg->nd_family of type u64 is
> not equal to 0. Then the value is converted to int, and only after that
> is compared to NVDIMM_BUS_FAMILY_MAX. This can lead to passing an invalid
> argument to acpi_nfit_ctl(), if call_pkg->nd_family is non-zero, while
> the lower 32 bits are zero.
> 
> All checks of the input value should be applied to the original variable
> call_pkg->nd_family.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 6450ddbd5d8e ("ACPI: NFIT: Define runtime firmware activation commands")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c80d8dc0d9fa81a3cd8c
> Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>

While the change logically makes sense, the likelihood of nd_family > int_size is not ever likely. Given that NVDIMM_BUS_FAMILY_MAX is defined as 1, I don't think we care about values greater than that regardless of what is set in the upper 32bit of the u64. I'm leaning towards the fix is unnecessary.   

> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index a5d47819b3a4..ae035b93da08 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -485,7 +485,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  		cmd_mask = nd_desc->cmd_mask;
>  		if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
>  			family = call_pkg->nd_family;
> -			if (family > NVDIMM_BUS_FAMILY_MAX ||
> +			if (call_pkg->nd_family > NVDIMM_BUS_FAMILY_MAX ||
>  			    !test_bit(family, &nd_desc->bus_family_mask))
>  				return -EINVAL;
>  			family = array_index_nospec(family,
> --
> 2.39.2
> 


