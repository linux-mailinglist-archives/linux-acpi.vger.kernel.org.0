Return-Path: <linux-acpi+bounces-19743-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8424CD4630
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 23:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65A7C3000B5A
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 22:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D11274B55;
	Sun, 21 Dec 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZi+ABd2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04878F4F;
	Sun, 21 Dec 2025 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766354397; cv=none; b=Va0ne/ZPb8taS28k+rSTN+6fVhQsoMTVoA59lnEruEKcc5oOkcve+ffLyXm6nuNYqWmFT1tjxD7Xok85VZLF41xodCbA2f5ziRTR0YwN3uG07y7JXATfiogk+z+tcuDcIccMN+CY83gyRdw20tnteeeh2Bdcu7iElW/1fpJzbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766354397; c=relaxed/simple;
	bh=0sbZ9LeRhYVW4/ryrWO1r2rUfhj1QmqtW/qTXTUBcoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufmsMHNP3sE5x6i1dv/OUpiHauIxTUyv1kgWcBE5TrDJWE9YievCQB7+YoL7TIiuM745jndldjdoa9UmIJj0c6890b2YZLqIxCbm/i1kPYX0Xwqn/4LiBpOUcK2Y+bqbpDWTCc4xKEUxex27gPOGYU8y4kBXf0M911DIVYJDIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZi+ABd2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766354396; x=1797890396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0sbZ9LeRhYVW4/ryrWO1r2rUfhj1QmqtW/qTXTUBcoc=;
  b=EZi+ABd2x8wh5koH+qnhDwLHkhgqTlD2p36Og2DQwywwfvoHM1tLjlF0
   7Fqlx259SxQPT7GSZyK1z62NGl7Vcn62ZKNG90hJ5vqbiHetGvJXuv8dj
   zc7aUk0FFfsd6t4uAId5dkncyoN8/5CTUFrECKQ82w0s43kfmattyhgOd
   HgW+AZIuTtO7cJaNS4C4DtPr+WnFDP3k03jXsdoc3qZlXggpDveoFBISv
   Kvl+BSHsz8wZIZvbESAlGFk7qwdMXLl5PkhlPfyLIvupWay9HFCY/wSeQ
   G8cuo9wn2tmKpiB37vFzXemqkz8K6ssLUw/T3n+VBva6kfolS0rdE7nb1
   Q==;
X-CSE-ConnectionGUID: 8/Lv3R78RTeTKJsjPpfYfQ==
X-CSE-MsgGUID: dnZVaqEtQLCVbdlXJyf5Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="68373581"
X-IronPort-AV: E=Sophos;i="6.21,166,1763452800"; 
   d="scan'208";a="68373581"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 13:59:55 -0800
X-CSE-ConnectionGUID: LL/9NGAcR4e3Q0cCacWsYg==
X-CSE-MsgGUID: JIDseJxjRca54yy4cvoZjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,166,1763452800"; 
   d="scan'208";a="204439442"
Received: from abityuts-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.161])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 13:59:51 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 046A6120927;
	Sun, 21 Dec 2025 23:59:52 +0200 (EET)
Date: Sun, 21 Dec 2025 23:59:51 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Lucas De Marchi <demarchi@kernel.org>, linux-acpi@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH] software node: replace -EEXIST with -EBUSY
Message-ID: <aUht13bTn-lEnNM-@kekkonen.localdomain>
References: <20251220-dev-module-init-eexists-linux-acpi-v1-1-af59b1a0e217@samsung.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220-dev-module-init-eexists-linux-acpi-v1-1-af59b1a0e217@samsung.com>

Hi Daniel,

Thanks for the patch.

On Sat, Dec 20, 2025 at 04:55:00AM +0100, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> The -EEXIST error code is reserved by the module loading infrastructure
> to indicate that a module is already loaded. When a module's init
> function returns -EEXIST, userspace tools like kmod interpret this as
> "module already loaded" and treat the operation as successful, returning
> 0 to the user even though the module initialization actually failed.
> 
> This follows the precedent set by commit 54416fd76770 ("netfilter:
> conntrack: helper: Replace -EEXIST by -EBUSY") which fixed the same
> issue in nf_conntrack_helper_register().
> 
> Affected modules:
>   * meraki_mx100 pcengines_apuv2
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
> The error code -EEXIST is reserved by the kernel module loader to
> indicate that a module with the same name is already loaded. When a
> module's init function returns -EEXIST, kmod interprets this as "module
> already loaded" and reports success instead of failure [1].
> 
> The kernel module loader will include a safety net that provides -EEXIST
> to -EBUSY with a warning [2], and a documentation patch has been sent to
> prevent future occurrences [3].
> 
> These affected code paths were identified using a static analysis tool
> [4] that traces -EEXIST returns to module_init(). The tool was developed
> with AI assistance and all findings were manually validated.

This might not be the only case where -EEXIST may be returned by loading a
module. The patch is fine IMO but I'd just change -EEXIST to -EBUSY in e.g.
do_init_module() to avoid this being an actual bug elsewhere.

I wonder what others think.

> 
> Link: https://lore.kernel.org/all/aKEVQhJpRdiZSliu@orbyte.nwl.cc/ [1]
> Link: https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com/ [2]
> Link: https://lore.kernel.org/all/20251218-dev-module-init-eexists-modules-docs-v1-0-361569aa782a@samsung.com/ [3]
> Link: https://gitlab.com/-/snippets/4913469 [4]
> ---
>  drivers/base/swnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 16a8301c25d6..083593d99a18 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -919,7 +919,7 @@ int software_node_register(const struct software_node *node)
>  	struct swnode *parent = software_node_to_swnode(node->parent);
>  
>  	if (software_node_to_swnode(node))
> -		return -EEXIST;
> +		return -EBUSY;
>  
>  	if (node->parent && !parent)
>  		return -EINVAL;
> 

-- 
Regards,

Sakari Ailus

