Return-Path: <linux-acpi+bounces-9775-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF359D8DB3
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Nov 2024 22:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0244828558E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Nov 2024 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0341BD01D;
	Mon, 25 Nov 2024 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CICBsAyf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D98E1BC062;
	Mon, 25 Nov 2024 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569165; cv=none; b=eAIV6N0siezZt6OCjDvmi/klEX2+DSErlpb064LzL8jKjI9BmBxUmfVPbpQ563pkRjrh/WRqpBfw4cHNb4Cgi3qFPrwbXTyMVGR/WX9sFUFgABcdkxP4CcFbfF/S1dG+Y38b5QxZ0uQ0+gq9279fmVxKBrg2sJJe/6MSzMoiPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569165; c=relaxed/simple;
	bh=WNx2agDQWlLacRGpk2pApXqxX6NLQt32EOVREGQEaTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMUbOu7OzQVWyvxtajM+8aoodAbQoGmCq3pk8YWXVrmU9vmJ2yI7r5OS2xM3PVTfzG3RQ+ByXBZ1dgHngMoPOu6t73ep71reXMgNYaXafPxUxe7Xz94TQXpYzTySkysCacA8B9Lz1O09Da+LprJcdOUFGwGaWSXD29L6Kjwp374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CICBsAyf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732569163; x=1764105163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WNx2agDQWlLacRGpk2pApXqxX6NLQt32EOVREGQEaTo=;
  b=CICBsAyfjL5IGIEGUMu55KD/ZdB5INAuqlRios1RIKCMIDEoVFcEoyLL
   cHMwx2t0XUhltkOLZlEbwBQ2gzhLEB3+TttdWqpl0pbJo4zTTBZ8jfU+b
   H8YZJVu0M+cdF77zMP4LWneA+esHkMIgHanY1yl5T1ZdmpZUye4tMemil
   Jks1YD1LGmWeHtJfMLfOd17HuhBTc09dcgDjRTKpfxRHv3YPshPFLMv1X
   mzXS6yyZFd9yanmLwQBCAetH6KptEO26Z71g6ERn5SD0rm29hln63gNiU
   wf38/Orw5Mutn0hTn2smp5ygxfTgtdd4/hPxv3CWa2tmZMHQ14S1xofex
   w==;
X-CSE-ConnectionGUID: pi8yld8sTOq/k4jYeSopMQ==
X-CSE-MsgGUID: w8Bui4VSScyPbZJ7Qcwnvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32853526"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="32853526"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 13:12:43 -0800
X-CSE-ConnectionGUID: YL7aPKirSTeuo8Gs3wEKow==
X-CSE-MsgGUID: adKSnD2iRti/kJe3HWMZ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91194398"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.188])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 13:12:41 -0800
Date: Mon, 25 Nov 2024 13:12:39 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, ira.weiny@intel.com, rafael@kernel.org,
	lenb@kernel.org, nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Subject: Re: [PATCH v6] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
Message-ID: <Z0ToRzLyx5L5xDGu@aschofie-mobl2.lan>
References: <20241118162609.29063-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118162609.29063-1-surajsonawane0215@gmail.com>

On Mon, Nov 18, 2024 at 09:56:09PM +0530, Suraj Sonawane wrote:
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

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
> Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
> Fixes: ebe9f6f19d80 ("acpi/nfit: Fix bus command validation")
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
> ---
> V1: https://lore.kernel.org/lkml/20241111080429.9861-1-surajsonawane0215@gmail.com/
> V2: Initialized `out_obj` to `NULL` in `acpi_nfit_ctl()` to prevent
> potential uninitialized variable usage if condition is true.
> V3: Changed the condition to if (!buf || buf_len < sizeof(*call_pkg))
> and updated the Fixes tag to reference the correct commit.
> V4: Removed the explicit cast to maintain the original code style.
> V5: Re-Initialized `out_obj` to NULL. To prevent
> potential uninitialized variable usage if condition is true.
> V6: Remove the goto out condition from the error handling and directly
> returned -EINVAL in the check for buf and buf_len
> 
>  drivers/acpi/nfit/core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 5429ec9ef..a5d47819b 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -454,8 +454,13 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  	if (cmd_rc)
>  		*cmd_rc = -EINVAL;
>  
> -	if (cmd == ND_CMD_CALL)
> +	if (cmd == ND_CMD_CALL) {
> +		if (!buf || buf_len < sizeof(*call_pkg))
> +			return -EINVAL;
> +
>  		call_pkg = buf;
> +	}
> +
>  	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
>  	if (func < 0)
>  		return func;
> -- 
> 2.34.1
> 
> 

