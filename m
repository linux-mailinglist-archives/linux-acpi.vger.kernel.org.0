Return-Path: <linux-acpi+bounces-17949-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0781BEDA62
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 21:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9254934D4C2
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6AE245022;
	Sat, 18 Oct 2025 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8mFSVWu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484831D618C;
	Sat, 18 Oct 2025 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815713; cv=none; b=Lkc7g4dMqxuqiGnHKwBauC8udQGugf8ycnl82h8nmXWbcZ0zbL/bX9GaVGD43iKIi5yZ3EfCW3caDLai6woJO/fQ4LIYqt5yH/7XosbZ0HlyyDucj8GW3rVPw6isQzeZfXOmg0zCyLt6RwsKZEogcRbWcSh/ILMOUkn4LunLWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815713; c=relaxed/simple;
	bh=XpY2mx+vjXtuq8pN0qviTyu0gyG+YdhQYqXD85RT+WE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pkTGUKkFEWxAJm7X+UDPzX+xkzcI/Ncu0Scszw+Pdv6pEZLaKmkxf4LYU0fZbhuESZE9Rzvfnlr8ev6T/xctD1CX3opWLZu9QL189JvVjAqsfO4dS5QkiCut4JwJs/0uQDcV3ktL9LnCslaHmxsQ0WmL2Q+zOlRxFZnC2jdjquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8mFSVWu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760815712; x=1792351712;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XpY2mx+vjXtuq8pN0qviTyu0gyG+YdhQYqXD85RT+WE=;
  b=J8mFSVWutl/KYi6Ro2Lhw27FFFMu2jxZsp2FdpXj0awazWw2MXc4hb3I
   sZwSc5c82RR8cWBfyPjwRSOjGS2gLC4T/zohgUEPPLdEqT23+CIA5MN/f
   Iy/spfzuog3vajM4F3UrK9clmH+U3fFS0KQygvmzIZYDkMtQcwvNes/00
   tgNz6DlXufAl9Mg2bMZcAMGAJrJjtZWFASP/DiV4rnqyz6ea53ook/+/K
   8qjtG9wKQteFcS0CmPg7XsveWNrXZLk94EpZ2u0ZXPlZkPlnrKykgC0Sr
   cSrjgXtK2KBZORqlsKxjed/1DJHUvyu4SULHnx0662voGxDVapGS9fTJb
   A==;
X-CSE-ConnectionGUID: OBhNDeRTReWWSTBQapE4VQ==
X-CSE-MsgGUID: FTWibTkpSOSRhJrzbK/z7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62904417"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62904417"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:28:32 -0700
X-CSE-ConnectionGUID: MgMyDK5BTQycOBtM+C/p1A==
X-CSE-MsgGUID: APS26fxRQkeF5iOwxj74qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="183485485"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:28:28 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vACbJ-00000000xXA-1xLG;
	Sat, 18 Oct 2025 22:28:25 +0300
Date: Sat, 18 Oct 2025 22:28:25 +0300
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
Message-ID: <aPPqWTohCi-Huvfq@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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



