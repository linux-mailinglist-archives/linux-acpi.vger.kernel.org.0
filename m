Return-Path: <linux-acpi+bounces-6857-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B7492E060
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 08:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8438AB20FA5
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 06:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECDD12E1C7;
	Thu, 11 Jul 2024 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXx3rhj9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B29712C54A;
	Thu, 11 Jul 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720680997; cv=none; b=Lkm0qJ8QGaweLx+2YOxsnUKUF61sR02miQEEOmzhBnkPaItjBu6mJ4mcPzuJJbGAMldIv8zUwGj3K6ms3Yy031lejf8fu347Uj/cyQ8nwpOQ24JaXfCLPr+s5F2guGF05asUMXczr9f32zXYt5GtgTFXpmfMn+lvEPNJiep+FD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720680997; c=relaxed/simple;
	bh=7PdI6dGb0scfg3lG1tvlmkvFOJyPIaXxnPjFo6A1gQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mc416RFKabQKQUwFkZt1h9bzU8Y5C41fpWq/dKhqqiu+0Td4fjRFjP7vs45fiRRPXVNHz/A5EtnuV94myGe68bScIl0sPXBfERLNl3kvDXuSEt+r76gyDDNzI6EHRE18sQAKwYw+NLOiZNUkFSEVNBxknrI2D2rzLYeCd2jbPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXx3rhj9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720680997; x=1752216997;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7PdI6dGb0scfg3lG1tvlmkvFOJyPIaXxnPjFo6A1gQA=;
  b=HXx3rhj9g2+ke0pA1yW1kOJb/2ePkn/M/qEPc0/ru3GLBV0nYEiXajA0
   LNWksR6M97pIsDW0Hp4S65QTgvjNAl6esQcuo6hFOX3XZ0DmqAASe6Icl
   rACU8nSKbSPmV/eMr9T8xJWG1WFtGmml1G/M+tw9m6dh+RbwR9NF79ktp
   3GL3kanvbbgxzaXq6RLllvX0KU70lbRwkW9rjWvXSvf/tv9xFGKEbfsSE
   bsW/0AjSX9y4qS3JHmXZt6XY3Hi4tLIYV6puXsosGxv6K/RDmVeKGqGhC
   lPyzEEHZugD1LZK8NtnC+6Vxmajkl84XawbjWGcHR7AVADecdntHxkfgM
   w==;
X-CSE-ConnectionGUID: tfuBTGTVS0Wcnbh7uMO1gw==
X-CSE-MsgGUID: X5tIQrPsQl+6YiQm7IddTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18177119"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="18177119"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 23:56:36 -0700
X-CSE-ConnectionGUID: zc9BorrXTNSYgESHKXov3Q==
X-CSE-MsgGUID: 7poP+vrFS9i8o6vwFQ1pRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="53401877"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 23:56:33 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,  Ho-Ren Chuang
 <horen.chuang@linux.dev>,  Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
  linux-acpi@vger.kernel.org,  linux-kernel@vger.kernel.org,  kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH] ACPI: HMAT: Mark hmat_set_default_dram_perf() as __init
In-Reply-To: <20240710-fix-modpost-warning-default_dram_nodes-v1-1-8961453cc82d@kernel.org>
	(Nathan Chancellor's message of "Wed, 10 Jul 2024 09:29:57 -0700")
References: <20240710-fix-modpost-warning-default_dram_nodes-v1-1-8961453cc82d@kernel.org>
Date: Thu, 11 Jul 2024 14:54:42 +0800
Message-ID: <87jzhsa05p.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Nathan Chancellor <nathan@kernel.org> writes:

> After commit 4dc70b711dbc ("memory tier: consolidate the initialization
> of memory tiers"), there is a modpost warning when
> hmat_set_default_dram_perf() is not inlined into its callsite, as it
> appears that default_dram_nodes may be accessed after its memory has
> been freed.
>
>   WARNING: modpost: vmlinux: section mismatch in reference: hmat_set_default_dram_perf+0x18 (section: .text) -> default_dram_nodes (section: .init.data)
>
> The single callsite, hmat_init(), is __init, so this warning is not a
> problem in reality but it is easily solvable by marking
> hmat_set_default_dram_perf() as __init, which should have been done when
> this function was added in commit 3718c02dbd4c ("acpi, hmat: calculate
> abstract distance with HMAT").

Good catch!  Thanks for your fix!  If it's necessary, feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406292310.hlRATeZJ-lkp@intel.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> I left off a fixes tag as I assume this is going to be squashed into the
> former change mentioned above, as it is still in mm-unstable, but feel
> free to add one if the patch is going to be standalone.
> ---
>  drivers/acpi/numa/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index a2f9e7a4b479..ca0c0ea3e1ef 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -933,7 +933,7 @@ static int hmat_callback(struct notifier_block *self,
>  	return NOTIFY_OK;
>  }
>  
> -static int hmat_set_default_dram_perf(void)
> +static __init int hmat_set_default_dram_perf(void)
>  {
>  	int rc;
>  	int nid, pxm;
>
> ---
> base-commit: 17bcc624e67da6383060ee24483db77aa17276aa
> change-id: 20240710-fix-modpost-warning-default_dram_nodes-38b6faffe3da
>
> Best regards,

--
Best Regards,
Huang, Ying

