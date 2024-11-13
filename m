Return-Path: <linux-acpi+bounces-9529-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318D39C6823
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 05:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA64282110
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 04:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5134016EB76;
	Wed, 13 Nov 2024 04:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeYUUxzh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50666157A48;
	Wed, 13 Nov 2024 04:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731472701; cv=none; b=HUi8wxP1MKUL81Pb6hGq2zFRQCl+UE4vt71eyzur0o20VzXRTwA9/dNmtQEJPuXl5mwZ30e9W/rDn27w8iEV4eg9G+1lcwPLTgv+IcI+2NNDHW/bh0DEDoKBlhJypMtEzLKij80kL8ZM7GfS+1nWyg3Vk+Oh1t4MVgkhTf5a1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731472701; c=relaxed/simple;
	bh=AcCyZU+sGfKI+NBCS604ev/S94TuTZpBGN+VbMQUj5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO3LnHdxD3kP4jb6kAXhlroIezsq50xv/zcs03uKHJm2Tcsh3AvZiGYJgpALMOP1DfelkCk3wl2Zm/i+SxZzjhoaZzeiBWoi6TFN7PWxPQlFf+pOEmVvEvPiudn7l5niF1xXZ7iYdCY+QW3ZVIqqRWIvSbp2JJa6Ka5Qq/AcU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeYUUxzh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731472699; x=1763008699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AcCyZU+sGfKI+NBCS604ev/S94TuTZpBGN+VbMQUj5s=;
  b=QeYUUxzhvtYqW4hzhgf6LuY2Q620i7pbAWsoqCu6Wzs4UfGGDcON41uV
   7vPH2xULnwcRjn954+4ah+3MDxHWJgAl580gAitt8+upSMKJvFNkym2Vq
   vEoVwDZgKni3AJrwf31O2XZGutrs5yHMBS0LMF7NeQ4YCtdwby+lXWFhw
   LikSS7mKoAI0C5XT7Sraaellhut+encH5Fyz0kT//61jLhr1AkiVMjW9i
   Nv7Q0HoCQgUHmD9J7ACOB7oyhNAue7NNAgcrD2bnTymRINC2ae+RDl0Ha
   AXTFggZP/2C7NIaCnyyA2WxsXpbNrSU13HwZZxHnYYKwLtxaSK6T9EFJz
   g==;
X-CSE-ConnectionGUID: BrNCY7apTwG3qxNgK3RRXQ==
X-CSE-MsgGUID: BRWuthFQR4ymjvDvSGBhzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="41955252"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="41955252"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 20:38:19 -0800
X-CSE-ConnectionGUID: o3uMUgp6SseI/i0lnO2VyQ==
X-CSE-MsgGUID: s+d35522SXO67uYhejK/7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="125265572"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.153])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 20:38:18 -0800
Date: Tue, 12 Nov 2024 20:38:16 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, ira.weiny@intel.com, rafael@kernel.org,
	lenb@kernel.org, nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
Message-ID: <ZzQtOFiW1G4jAIzf@aschofie-mobl2.lan>
References: <20241112052035.14122-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112052035.14122-1-surajsonawane0215@gmail.com>

On Tue, Nov 12, 2024 at 10:50:35AM +0530, Suraj Sonawane wrote:
> Fix an issue detected by syzbot with KASAN:
> 
> BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/
> core.c:416 [inline]
> BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0
> drivers/acpi/nfit/core.c:459
> 
> The issue occurs in `cmd_to_func` when the `call_pkg->nd_reserved2`
> array is accessed without verifying that `call_pkg` points to a
> buffer that is sized appropriately as a `struct nd_cmd_pkg`. This
> could lead to out-of-bounds access and undefined behavior if the
> buffer does not have sufficient space.
> 
> To address this issue, a check was added in `acpi_nfit_ctl()` to
> ensure that `buf` is not `NULL` and `buf_len` is greater than or
> equal to `sizeof(struct nd_cmd_pkg)` before casting `buf` to
> `struct nd_cmd_pkg *`. This ensures safe access to the members of
> `call_pkg`, including the `nd_reserved2` array.

That all sounds good! A couple of coding conventions fixups suggested
below -

snip

> @@ -439,7 +439,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  {
>  	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> -	union acpi_object in_obj, in_buf, *out_obj;
> +	union acpi_object in_obj, in_buf, *out_obj = NULL;
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
> +		if (buf == NULL || buf_len < sizeof(struct nd_cmd_pkg)) {

Comparison to NULL and sizeof() usage preferred like this:
	if (!buf || buf_len < sizeof(*call_pkg))


-snip
> 
> 

