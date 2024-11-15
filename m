Return-Path: <linux-acpi+bounces-9599-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A30C9CF34A
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 18:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F0FB455D4
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54AC1D5AB7;
	Fri, 15 Nov 2024 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCSUJF8u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF191D54D6;
	Fri, 15 Nov 2024 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690667; cv=none; b=HDgx5FVk8Q8B77lv8a+GKIX6O1mnKwCYIFCtHiP7iaslI5J2tb6xjq/E1onuGnHIj9gf8q151yzTC0K3CXRyHRK9DIrHdSCRf5z99rBDgk6MpEwoM7A+a/QCvYCFmjgiQQ9KT/m4AG5flNzEPMN/wfCXuXAgDC4UcRq/IGUjAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690667; c=relaxed/simple;
	bh=2GePdT9W2RDQK7fYcKpl+3TR3oikwFjCXh1Q+ZSj1Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rj2vEv0wPVEtsY3pFqe1Tpirqsji3gaSiEAQpaHyA2kQU0E2zmmwBzpazODquwUqeR8gIUXmgYQ8LZaJUbiys3LwSrD7fDqCtwO+kt0PXO0n7GmtVMSYwIHwowVEQQ6VdK/k7sw3Yq1XmRgvvmvVsTNoFrPqTr84zvAIYtAb+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCSUJF8u; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731690666; x=1763226666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2GePdT9W2RDQK7fYcKpl+3TR3oikwFjCXh1Q+ZSj1Ig=;
  b=eCSUJF8uAEY3jbxjGhwOMYH87a0+e+QDeMNJ5bMO2M0/klgicF3bN+ES
   Z0GXoknGuhNEi/yGuzMZTjHsj6XnBiFm5n6Y6JddKpYb1PoVrdHXiQqiT
   FmnXxCAlNq2WGGdkgJ352irUCyAZ7hY3qt1BQA26Snfqeb5a+qTn2UjVu
   0wqc0+byAQGbCKjr2YVXfdKZktcfF4fMT7LjHUZyhf4SiPX8uWrfwvUPL
   /LrJtmo5wRdtvG8QAZOfBBpO8SHqpvMA2vPLpFtW11EFAYAnn3sw/kP+H
   xGJfLx6SRZ9BIWNYqyhMKREy5NBg79QTeYrYTAVhPUe8KIZlviMVu+7/b
   w==;
X-CSE-ConnectionGUID: Ks6S2O9QQw+eQA9s6v44KA==
X-CSE-MsgGUID: Qtkn4EqHTo6TM17SBE2fQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="31839183"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="31839183"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 09:11:05 -0800
X-CSE-ConnectionGUID: rTcxwufLQL+SQdUSCpm5ew==
X-CSE-MsgGUID: brpXELQwQfe+XK+YnUsjeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="93630795"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.122]) ([10.125.108.122])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 09:11:05 -0800
Message-ID: <41e0baea-94a0-46c4-b24b-f227e9ee5ecd@intel.com>
Date: Fri, 15 Nov 2024 10:11:03 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
To: Suraj Sonawane <surajsonawane0215@gmail.com>, dan.j.williams@intel.com,
 vishal.l.verma@intel.com
Cc: ira.weiny@intel.com, rafael@kernel.org, lenb@kernel.org,
 nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
References: <20241115164223.20854-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241115164223.20854-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/15/24 9:42 AM, Suraj Sonawane wrote:
> Fix an issue detected by syzbot with KASAN:
> 
> BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/
> core.c:416 [inline]
> BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0
> drivers/acpi/nfit/core.c:459
> 
> The issue occurs in cmd_to_func when the call_pkg->nd_reserved2
> array is accessed without verifying that call_pkg points to a buffer
> that is appropriately sized as a struct nd_cmd_pkg. This can lead
> to out-of-bounds access and undefined behavior if the buffer does not
> have sufficient space.
> 
> To address this, a check was added in acpi_nfit_ctl() to ensure that
> buf is not NULL and that buf_len is less than sizeof(*call_pkg)
> before accessing it. This ensures safe access to the members of
> call_pkg, including the nd_reserved2 array.
> 
> Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
> Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
> Fixes: ebe9f6f19d80 ("acpi/nfit: Fix bus command validation")
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> V1: https://lore.kernel.org/lkml/20241111080429.9861-1-surajsonawane0215@gmail.com/ 
> V2: Initialized `out_obj` to `NULL` in `acpi_nfit_ctl()` to prevent
> potential uninitialized variable usage if condition is true.
> V3: Changed the condition to if (!buf || buf_len < sizeof(*call_pkg))
> and updated the Fixes tag to reference the correct commit.
> V4: Removed the explicit cast to maintain the original code style.
> 
>  drivers/acpi/nfit/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 5429ec9ef..84d8eef2a 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -454,8 +454,15 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  	if (cmd_rc)
>  		*cmd_rc = -EINVAL;
>  
> -	if (cmd == ND_CMD_CALL)
> +	if (cmd == ND_CMD_CALL) {
> +		if (!buf || buf_len < sizeof(*call_pkg)) {
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +
>  		call_pkg = buf;
> +	}
> +
>  	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
>  	if (func < 0)
>  		return func;


