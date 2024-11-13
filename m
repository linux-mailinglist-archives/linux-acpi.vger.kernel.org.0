Return-Path: <linux-acpi+bounces-9550-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4053E9C7982
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 18:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46B71F2772D
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F1F1F9ABD;
	Wed, 13 Nov 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khOkovQ/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46C7083F;
	Wed, 13 Nov 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517372; cv=none; b=ajAuh0Y0kh8slog4xWx4KiecyBiIdqqVkEc6W2QwID5vLJS88H6jlXfK0g41vf+PcJfFJTPB2oDDwDLrO1hSge1jtoxUyygiFH2i4xhiUqHDVooCEXsj1Ii7JilJGN5up3XMQarndtE+g7ZoClnvMsxLYwP6xpwMQxRUSq2sFok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517372; c=relaxed/simple;
	bh=bKvQveUmnw0s3bbjiNCbqGR+1sQAqrRWjJOqqLCKXDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMgLIPMaD1ckIW9JcoWL7F2MgG5jcaEqxbHwYIu67k7DFms5q0s93i5aJ0uHjiwzRD4xos2UpYk5WkRVcvD1TLKhpRyHQ1ddxhnJVGCMZhCTnN5sySmyA1vg9nRxlbPsf9t0CEuWA78GVyw2LMpyrlBiZABHKPPz2QKxeX95MbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khOkovQ/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731517370; x=1763053370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bKvQveUmnw0s3bbjiNCbqGR+1sQAqrRWjJOqqLCKXDM=;
  b=khOkovQ/sK/nSlEmLX2q2zVrn3l0z6sWUkqUdcfxSU9dWvXJAyaRWiN1
   qHm8Y7/paKaLz0VI1o5A5OPD2uPmEayTa/nGcga0EcsXVjW2xEAhZa/0s
   8wBa85vTAg4JfhEUiDqK8pYGYDlyIWppBAdPm69hzEumyU5c72KU3e64B
   hbjM6ZYGS6HanYToxTJ5lxaTuSsFAiVc7WRxUxrBakP1k2f6efBgui3iH
   8XNroeRLwPGWwpj4FzufGdEMCOhNiH9t9MOtoP30L8aCAecva5YzhY0JL
   OvfC1VH0/VLYvVQ2gy6nq4FwZclonfB1FqFxqp6GwYqXZJnmpADa24Eih
   A==;
X-CSE-ConnectionGUID: dVroWS0JTcGoasNtogKBeg==
X-CSE-MsgGUID: Gjhdl4OuQ5KHNZw3agMAcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="56812274"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="56812274"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 09:02:49 -0800
X-CSE-ConnectionGUID: TmNWX73cRzWpQFfza1GHbA==
X-CSE-MsgGUID: LqEBD+yFSge8vce6kk0yfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="92996490"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.237]) ([10.125.111.237])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 09:02:48 -0800
Message-ID: <c69d74f7-4484-4fc6-9b95-d2ae86ead794@intel.com>
Date: Wed, 13 Nov 2024 10:02:47 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
To: Suraj Sonawane <surajsonawane0215@gmail.com>, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: rafael@kernel.org, lenb@kernel.org, nvdimm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
References: <20241113125157.14390-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241113125157.14390-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/24 5:51 AM, Suraj Sonawane wrote:
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
> buf is not NULL and that buf_len is greater than sizeof(*call_pkg)
> before casting buf to struct nd_cmd_pkg *. This ensures safe access
> to the members of call_pkg, including the nd_reserved2 array.
> 
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
> 
>  drivers/acpi/nfit/core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 5429ec9ef..eb5349606 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -439,7 +439,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  {
>  	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	union acpi_object in_obj, in_buf, *out_obj;
> +	union acpi_object in_obj, in_buf, *out_obj = NULL;

Looking at the code later, out_obj is always assigned before access. I'm not seeing a path where out_obj would be accessed unitialized...

https://elixir.bootlin.com/linux/v6.12-rc7/source/drivers/acpi/nfit/core.c#L538
 
>  	const struct nd_cmd_desc *desc = NULL;
>  	struct device *dev = acpi_desc->dev;
>  	struct nd_cmd_pkg *call_pkg = NULL;
> @@ -454,8 +454,14 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  	if (cmd_rc)
>  		*cmd_rc = -EINVAL;
>  
> -	if (cmd == ND_CMD_CALL)
> -		call_pkg = buf;
> +	if (cmd == ND_CMD_CALL) {
> +		if (!buf || buf_len < sizeof(*call_pkg)) {
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +		call_pkg = (struct nd_cmd_pkg *)buf;

Is the casting needed? It wasn't in the old code.

> +	}
> +
>  	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
>  	if (func < 0)
>  		return func;


