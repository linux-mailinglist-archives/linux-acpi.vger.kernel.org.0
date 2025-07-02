Return-Path: <linux-acpi+bounces-14945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA45BAF5E9E
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 18:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3E016F17F
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9311121C9E8;
	Wed,  2 Jul 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIjXtCoc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20E179A7;
	Wed,  2 Jul 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473915; cv=none; b=CGcFNh0e9xB4Nw+qs2XuX2LK+uSrItyD/4IjXLAUKdYxYOT/H52VvDOZyh/s1TLUwfWyxKVm9Nqd29E9fBu3moB+ug2n6G6zrxkgO49NaRYOkbhxnhawVbGmmp6mxTXSeU+7OGke/hPxI41vsdzTFKdcYFOAlRQv23cGTd4OXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473915; c=relaxed/simple;
	bh=IrCNo4PC0NsD0HLz0/9tt4ktA9q6Z/+LdaUaSaX08Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkAD4SV4txE8WCzDXtXdLxCnouMmyzd5kUVjVPO1OrUxQSdIr5xjF9PQyJvi3XRCCh/VpcZHNvcBmsYI7g1F+gvBhcf2iOdovR2gTbrP0vKjdPA7OsElm52/C6PDhJDNUE4zhZCPE0CUBQLuJsSA3z/H6D6LmpK3m8U+kBcuaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIjXtCoc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751473914; x=1783009914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IrCNo4PC0NsD0HLz0/9tt4ktA9q6Z/+LdaUaSaX08Bs=;
  b=LIjXtCocoBCU7G+Yjv+QUsHlFtbec55yYweV31gx53/c3mgR7NlxVn3n
   a5f8jJgS8rc0jqGXxLpjgkv9mQZp/OgwnQuSHpuIP1pmIsSovGPghK5CF
   f64YF6ZSpS2julppBJ+S5mJSJStzhuX/rEcPhfUbn9gv3UAf3oeg3Vmun
   0k/7APO2ZC37apILd3QLI6iz1FibguCrdrlymy8rvlFLiDdJJsQgSbfaI
   NAjWBD8JVWsjgLLB+3WiUdGMND/sYJ1c1OFeT9AsqOKL0p0DHhBvFgboN
   HnbHWvjCoxRNF2yUsQ3S0QaVVpjgAF6k1xYZ9qytQSAYDPrp2GDDLDgCs
   Q==;
X-CSE-ConnectionGUID: xyF0ZTR4TCG7oNhfQSyQ6w==
X-CSE-MsgGUID: zK/D4CSOSq29a1TVdVDULQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53656282"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53656282"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 09:31:33 -0700
X-CSE-ConnectionGUID: o41iukwUTKKgv6CK8P0eiQ==
X-CSE-MsgGUID: TJ1zwm1GSr6100lGBcwqBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153576647"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 09:31:32 -0700
Date: Wed, 2 Jul 2025 09:31:30 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] acpi/ghes: add TAINT_MACHINE_CHECK on GHES panic path
Message-ID: <aGVe4nv18dRHHV16@agluck-desk3>
References: <20250702-add_tain-v1-1-9187b10914b9@debian.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-add_tain-v1-1-9187b10914b9@debian.org>

On Wed, Jul 02, 2025 at 08:39:51AM -0700, Breno Leitao wrote:
> When a GHES (Generic Hardware Error Source) triggers a panic, add the
> TAINT_MACHINE_CHECK taint flag to the kernel. This explicitly marks the

While it might not strictly be a machine check that caused GHES to
panic, it seems close enough from the available TAINT options.

So unless someone feels it would be better to create a new TAINT
flag (TAINT_FATAL_GHES? TAINT_FIRMWARE_REPORTED_FATAL_ERRROR?)
then this seems OK to me.

Reviewed-by: Tony Luck <tony.luck@intel.com>

> kernel as tainted due to a machine check event, improving diagnostics
> and post-mortem analysis. The taint is set with LOCKDEP_STILL_OK to
> indicate lockdep remains valid.
> 
> At large scale deployment, this helps to quickly determin panics that
> are coming due to hardware failures.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/acpi/apei/ghes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index f0584ccad4519..3d44f926afe8e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1088,6 +1088,8 @@ static void __ghes_panic(struct ghes *ghes,
>  
>  	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
>  
> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
> +
>  	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
>  
>  	if (!panic_timeout)
> 
> ---
> base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
> change-id: 20250702-add_tain-902925f3eb96
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

