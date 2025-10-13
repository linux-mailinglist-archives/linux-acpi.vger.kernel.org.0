Return-Path: <linux-acpi+bounces-17945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8F3BED589
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 19:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77A3434D555
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D90257858;
	Sat, 18 Oct 2025 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLmL5UWU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776B16F288;
	Sat, 18 Oct 2025 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808866; cv=none; b=pIpDUYWaRGae75grz/9SaFB1F+Mg9kw2fMBX+/Qp6X+bX9DVBlCX6ANOxniWjjZzs7o7jhVVwBtZMN+Ny8ohJvmZGXqDkgQhogML7qY565DuNpa75c1bfFI0wstFzWojg9o6ClfJSWqIXh3OJtaBxOFkHOvbHLdMoAemGcfybfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808866; c=relaxed/simple;
	bh=FhzneSEG98kjl4JWWkFvuNZc+PeM/SaDeI05zCVy+oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYNEDloZ8YiRHVd6jbWR7vngIxNOiDBGriBkC+k57J9elRFgbiMHKw3HMdQbS9sEM9+MRsHWnetCg5PKdrhOAJ+HtEklfu3Rck/FDIUCw0jynpJ/9wlCtGN5TPrnqpVh7DOt7qFmmA/8p+piOPHI5amV08JnjhHpZj4FyT62sw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLmL5UWU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808865; x=1792344865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FhzneSEG98kjl4JWWkFvuNZc+PeM/SaDeI05zCVy+oo=;
  b=dLmL5UWUjtMInCzYL0U60/xuP6VhDl7POZ4wEQogeJ9ENf5xUIFuC/hX
   orB3CubwPYjcxWb15nmnKDU5NloK2SBuaSfdLRLQwpuH34Ce922m+T3Pr
   4rheiRdlNaJrSX3m5pk7nUtfGuOwLC1FvJNY4M4TSB2pR7uI/JxoXxtE2
   mRFbLZkZUGhuQ+O63HEX1AvMg8oRhIVU+vYA16ya7uTZ8h6w2EjtxXqTW
   LdQcGsEypO3zSACQbGiEloTipKgVr1cWv5203C0wxDcw52zSyWHOS+XWM
   W4s0DdPa271DzOOWCbRH9qN/xtUGjk/Nh21MFbsvK2kcGqUlSsgBGaBeW
   w==;
X-CSE-ConnectionGUID: h36upWhOTCek/EJmO8Hihw==
X-CSE-MsgGUID: WD6M1kD/RuimArXLw0EBvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63086759"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="63086759"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:34:24 -0700
X-CSE-ConnectionGUID: FLA/hIcwRUi0VrCtn9m6jA==
X-CSE-MsgGUID: qltFQbB9SOq+tlbSxVaklw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="206700908"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:34:22 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1v8Otb-000000002cP-0hIv;
	Mon, 13 Oct 2025 23:11:51 +0300
Date: Mon, 13 Oct 2025 23:11:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/9] software node: allow referencing firmware nodes
Message-ID: <aO1dBgPZfDJTsPfE@smile.fi.intel.com>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-3-6d3325b9af42@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006-reset-gpios-swnodes-v1-3-6d3325b9af42@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 06, 2025 at 03:00:18PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> At the moment software nodes can only reference other software nodes.
> This is a limitation for devices created, for instance, on the auxiliary
> bus with a dynamic software node attached which cannot reference devices
> the firmware node of which is "real" (as an OF node or otherwise).
> 
> Make it possible for a software node to reference all firmware nodes in
> addition to static software nodes. To that end: use a union of different
> pointers in struct software_node_ref_args and add an enum indicating
> what kind of reference given instance of it is. Rework the helper macros
> and deprecate the existing ones whose names don't indicate the reference
> type.
> 
> Software node graphs remain the same, as in: the remote endpoints still
> have to be software nodes.

...

> +enum software_node_ref_type {
> +	/* References a software node. */
> +	SOFTWARE_NODE_REF_SWNODE = 0,


I don't see why we need an explicit value here.

> +	/* References a firmware node. */
> +	SOFTWARE_NODE_REF_FWNODE,
> +};

...

>  /**
>   * struct software_node_ref_args - Reference property with additional arguments
> - * @node: Reference to a software node
> + * @swnode: Reference to a software node
> + * @fwnode: Alternative reference to a firmware node handle
>   * @nargs: Number of elements in @args array
>   * @args: Integer arguments
>   */
>  struct software_node_ref_args {
> -	const struct software_node *node;
> +	enum software_node_ref_type type;
> +	union {
> +		const struct software_node *swnode;
> +		struct fwnode_handle *fwnode;
> +	};

Can't we always have an fwnode reference?

>  	unsigned int nargs;
>  	u64 args[NR_FWNODE_REFERENCE_ARGS];
>  };

-- 
With Best Regards,
Andy Shevchenko



