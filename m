Return-Path: <linux-acpi+bounces-9792-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43519DB85F
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 14:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD681624FC
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27751A0B04;
	Thu, 28 Nov 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNtNnSbw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162C19EEB4;
	Thu, 28 Nov 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799613; cv=none; b=u6NaECOaSn8rhz4bzjWjNKyGnGz1PF4IQoD4I/QzfFzymgp/uqFJllWDaFgKUlSdoLJ8MBv9BLtJmKLMbBN2bf3B5nPNP04TCeDz/KTVfwaKEdxV4pqSuXrB82iWKlwMvFSiPR1uznA9c9SXnr+ufoGchzOA5uEY4hzlm7qmZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799613; c=relaxed/simple;
	bh=kTDf+2YDrwIh0Mz60DV0j5nrN9wMfqDg1VVSUrckaKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVnWF1wSbzfYhAal5GtyZY5zk7FIhU0zfKEMdKaCxpPQXdzIpXhxr9ToyFfb0QCC8YeQQvFKSUWe8lsAEJzGWdX20B83OM+UDDKj+0zpLfGsJmmnGF2opLNnlHHu5K06M4Jq79XGFPnnA91LXiigqSDrUf3Im05UseNzbgHavRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNtNnSbw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732799612; x=1764335612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kTDf+2YDrwIh0Mz60DV0j5nrN9wMfqDg1VVSUrckaKc=;
  b=cNtNnSbwahxQsxwq4r+qrsSbuSonJdpmOzRBdTcBRA5iy3A1l7iC5vp3
   2mEdm1E/YczW9so+v63TDZwo1rv+zVGuldH7+G20GPpvbRbwkQ/J3XJNm
   Sa/XRJMZIXOWBervzq2eCaJvn0t7gMtNwvkfxiCbt4svvNvEElaeHBGvT
   c4Y0aD32mK45PZWkOCvc74pT8nW7rk1v9Cypwe+sJvtThjRwZykL02mj9
   qp6HkTExkwy5vER3Pq7c9BJ0n1xrPOtZq8PwdkE4A9fkn4X/xM7EWYWDj
   v8/AJlTf1UOZ2+Arn+dP1+GD/bbzuLlgUJ986ElkwXTlvyDG2Do5H1uMu
   A==;
X-CSE-ConnectionGUID: 4Yv3ukK7SuuHtEePMcUZAw==
X-CSE-MsgGUID: zCEJPzQMTBCr0wqHmurDMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="32397392"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="32397392"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 05:13:22 -0800
X-CSE-ConnectionGUID: BUCQwED1S6KMVTZevbOKqw==
X-CSE-MsgGUID: gv+tq33IRR2oyWVvpXdZWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="123201100"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 05:13:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tGeKb-00000001vo2-0nkp;
	Thu, 28 Nov 2024 15:13:17 +0200
Date: Thu, 28 Nov 2024 15:13:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] device property: do not leak child nodes when using
 NULL/error pointers
Message-ID: <Z0hsbNqXSkQjsR1v@smile.fi.intel.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 27, 2024 at 09:39:34PM -0800, Dmitry Torokhov wrote:
> The documentation to various API calls that locate children for a given
> fwnode (such as fwnode_get_next_available_child_node() or
> device_get_next_child_node()) states that the reference to the node
> passed in "child" argument is dropped unconditionally, however the
> change that added checks for the main node to be NULL or error pointer
> broke this promise.

This commit message doesn't explain a use case. Hence it might be just
a documentation issue, please elaborate.

> Add missing fwnode_handle_put() calls to restore the documented
> behavior.

...

While at it, please fix the kernel-doc (missing Return section).

>  {
> +	if (IS_ERR_OR_NULL(fwnode) ||

Unneeded check as fwnode_has_op() has it already.

> +	    !fwnode_has_op(fwnode, get_next_child_node)) {
> +		fwnode_handle_put(child);
> +		return NULL;
> +	}

>  	return fwnode_call_ptr_op(fwnode, get_next_child_node, child);

Now it's useless to call the macro, you can simply take the direct call.

>  }

...

> @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
>  	struct fwnode_handle *next;

> -	if (IS_ERR_OR_NULL(fwnode))
> +	if (IS_ERR_OR_NULL(fwnode)) {
> +		fwnode_handle_put(child);
>  		return NULL;
> +	}

>  	/* Try to find a child in primary fwnode */
>  	next = fwnode_get_next_child_node(fwnode, child);

So, why not just moving the original check (w/o dropping the reference) here?
Wouldn't it have the same effect w/o explicit call to the fwnode_handle_put()?

-- 
With Best Regards,
Andy Shevchenko



