Return-Path: <linux-acpi+bounces-16925-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB25B57888
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 13:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2A93B2601
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C342FF661;
	Mon, 15 Sep 2025 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOubP34f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86720304BAB;
	Mon, 15 Sep 2025 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935979; cv=none; b=OttWRK1IF/lG6TqWW1dxl2U6KnnE4+fEaxy3MaOvZL0eqgLhd7RuxYv3zilCnWCAPrbbvBk3ZCPXFA5KXUXswkMSkCRcmDdnhcz/OCejQnwbnonPuLMLa/01BrRkHnyunHRS35Y6VRkC4UiEeyFqlN1VKL8mGaXuF8ItfJ9gfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935979; c=relaxed/simple;
	bh=8oYNqrrAlQEHTxjixTYfzlFOUreIiPXKTs7mp++pE0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFbP7vNfM+8X4LNHPvtN0KPehA1/RX9W8pkbrYq0ajBOT4l3xyfjJm3exlvtTpv9XTC4nuVx7EQ8ZsA7tR/Etbusc5s0rmjpfGwF2bkg0FebX4DM0do7qq6IZo0Jwx0JNPo7LLixeXRl89zjH1PdO3GFxU3iAKhBTMJmcYtOTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOubP34f; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757935978; x=1789471978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8oYNqrrAlQEHTxjixTYfzlFOUreIiPXKTs7mp++pE0U=;
  b=QOubP34fjeg/V+vVNQaNDNf/CV6tCzYNJcmF6LkgDflNnLuVhluvPkRH
   eKKDAZE0z4kdwHgKllZm1A/m45DaWVg/EyschTAUB6QSXiPY8tEIQbJIO
   8EG5f3w7XNEAVXW7KocheY9XFBbkL0lXAH2zQzKNe7KhUgEvou/rWRKtK
   1Y0kQrgXGbq8uDIKP4UQNqb57b63GpadR8N7kOV3oP1xjC8okrGUKU/iv
   TZABjswTf3PsFhjEKL2c22EudUBvSfcsYMOpJNGLOuCnuzvs3w1sHwbvU
   uQ1I0kapi1FyYhYYbwAHmC2AQgM2DRQH2tw+XERSl+vkFEPa4o/p17mvp
   g==;
X-CSE-ConnectionGUID: FZGZljEYQ/KHZ1hJ7buxvw==
X-CSE-MsgGUID: oyOD4ecZSb6VRxvN7TYNDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59882595"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="59882595"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 04:32:57 -0700
X-CSE-ConnectionGUID: CxmrLDUGRdmlr666bRvVTg==
X-CSE-MsgGUID: eFIsTmacTnCX0JgmduWKgw==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 04:32:55 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 2F4DE11FCCF;
	Mon, 15 Sep 2025 14:32:52 +0300 (EEST)
Date: Mon, 15 Sep 2025 14:32:52 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/4] ACPI: property: Add code comments explaining what
 is going on
Message-ID: <aMf5ZNW9t_6tfsjy@kekkonen.localdomain>
References: <5046661.31r3eYUQgx@rafael.j.wysocki>
 <2243680.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2243680.irdbgypaU6@rafael.j.wysocki>

Hi Rafael,

On Fri, Sep 12, 2025 at 09:40:58PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In some places in the ACPI device properties handling code, it is
> unclear why the code is what it is.  Some assumptions are not documented
> and some pieces of code are based on experience that is not mentioned
> anywhere.
> 
> Add code comments explaining these things.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/property.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 2 deletions(-)
> 
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -108,7 +108,18 @@ static bool acpi_nondev_subnode_extract(
>  	if (handle)
>  		acpi_get_parent(handle, &scope);
>  
> +	/*
> +	 * Extract properties from the _DSD-equivalent package pointed to by
> +	 * desc and use scope (if not NULL) for the completion of relative
> +	 * pathname segments.
> +	 *
> +	 * The extracted properties will be held in the new data node dn.
> +	 */
>  	result = acpi_extract_properties(scope, desc, &dn->data);
> +	/*
> +	 * Look for subnodes in the _DSD-equivalent package pointed to by desc
> +	 * and create child nodes of dn if there are any.
> +	 */
>  	if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn->fwnode))
>  		result = true;
>  
> @@ -153,6 +164,12 @@ static bool acpi_nondev_subnode_ok(acpi_
>  	acpi_handle handle;
>  	acpi_status status;
>  
> +	/*
> +	 * If the scope is unknown, the _DSD-equivalent package being parsed
> +	 * was embedded in an outer _DSD-equivalent package as a result of
> +	 * direct evaluation of an object pointed to by a reference.  In that
> +	 * case, using a pathname as the target object pointer is invalid.
> +	 */
>  	if (!scope)
>  		return false;
>  
> @@ -172,6 +189,10 @@ static bool acpi_add_nondev_subnodes(acp
>  	bool ret = false;
>  	int i;
>  
> +	/*
> +	 * Every element in the links package is expected to represent a link
> +	 * to a non-device node in a tree containing device-specific data.
> +	 */
>  	for (i = 0; i < links->package.count; i++) {
>  		union acpi_object *link, *desc;
>  		acpi_handle handle;
> @@ -182,22 +203,48 @@ static bool acpi_add_nondev_subnodes(acp
>  		if (link->package.count != 2)
>  			continue;
>  
> -		/* The first one must be a string. */
> +		/* The first one (the key) must be a string. */
>  		if (link->package.elements[0].type != ACPI_TYPE_STRING)
>  			continue;
>  
> -		/* The second one may be a string, a reference or a package. */
> +		/*
> +		 * The second one (the target) may be a string, a reference or
> +		 * a package.
> +		 */
>  		switch (link->package.elements[1].type) {
>  		case ACPI_TYPE_STRING:
> +			/*
> +			 * The string is expected to be a full pathname or a
> +			 * pathname segment relative to the given scope.  That
> +			 * pathname is expected to point to an object returning
> +			 * a package that contains _DSD-equivalent information.
> +			 */
>  			result = acpi_nondev_subnode_ok(scope, link, list,
>  							 parent);
>  			break;
>  		case ACPI_TYPE_LOCAL_REFERENCE:

I think you get ACPI_TYPE_LOCAL_REFERENCE only when you evaluate a
reference to a device object.

> +			/*
> +			 * The reference is expected to point to an object
> +			 * returning a package that contains _DSD-equivalent
> +			 * information.
> +			 */
>  			handle = link->package.elements[1].reference.handle;
>  			result = acpi_nondev_subnode_data_ok(handle, link, list,
>  							     parent);
>  			break;
>  		case ACPI_TYPE_PACKAGE:

And similarly, the result of an evaluation here is a package when a
reference points to a name object (i.e. a data node).

> +			/*
> +			 * This happens when the target package is embedded
> +			 * within the links package as a result of direct
> +			 * evaluation of an object pointed to by a reference.
> +			 *
> +			 * The target package is expected to contain _DSD-
> +			 * equivalent information, but the scope in which it
> +			 * is located in the original AML is unknown.  Thus
> +			 * it cannot contain pathname segments represented as
> +			 * strings because there is no way to build full
> +			 * pathnames out of them.
> +			 */
>  			desc = &link->package.elements[1];
>  			result = acpi_nondev_subnode_extract(desc, NULL, link,
>  							     list, parent);
> 

-- 
Kind regards,

Sakari Ailus

