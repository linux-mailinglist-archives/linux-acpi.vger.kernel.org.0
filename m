Return-Path: <linux-acpi+bounces-16924-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E27CB5779E
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 13:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2936F3BAA51
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734312FCC17;
	Mon, 15 Sep 2025 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ixs91Gl0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC482F2906;
	Mon, 15 Sep 2025 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934259; cv=none; b=Voi1yBfxF9BKqX/eTzEAUiBG0oNiQeVZXDgWqRahVXg0lW4l0zS45Pnzl50/pLf3pqqlMJrT70/nCVrqrAsr17N93/5K+Y5GZSQZazYYdvsB6MqNrUUSFAsLhgJtnUhEMJO2EJZm5AmrZOt0M9wO0pM1Wn1/wA3LeM1nq2jAlGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934259; c=relaxed/simple;
	bh=geaYJfdDPVxAZTo8m/Lqs4JXmiamzZFgQ0ZIKLBfVLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojJSLx7ZigEiawU8YlYwBaTIu9m+VmrJsujYt4zYV1py61FyItNfoHI318PsSne5XumNDWop5odRQMzuO7hr5Jl5kz7+n0HlNu3TxvdQAAHBUNlO+yFWeii++dG1tS5BT0qiV9pJZ1jeh8qml89ykEtA2Ti1HBdP4kE5WH7DcxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ixs91Gl0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757934258; x=1789470258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=geaYJfdDPVxAZTo8m/Lqs4JXmiamzZFgQ0ZIKLBfVLM=;
  b=Ixs91Gl056wEUo7Z3eHeCSPheabq5RFsCHExavGBXafuu/T5b4dV6T3P
   BpdQpRgrlXaqmQUNhCj2zVgs2v0U9SMsrSc7+tgVOwtDWWCNzueGb9GLg
   wzbr+37ftayKTH1tL/BquNindoJPSTRXKQrJGMwG34qnwFQNXMa2ZS3gD
   9C9DEgpEMukjSjvamBLnUcbtJedj+yMbTkPtqDDKU830Vs/r87sECB5IZ
   giy+tCmH2QOGpRuOMUG8BjK44Jk552KyvueekrM9DGz1W8uXvTUmOBsxO
   WFYkE1wjtYJtAs9bGehJf0uWv7igw2Z+rSjKRSgJGFboDd+D/xwCjUBb5
   A==;
X-CSE-ConnectionGUID: G7n9NLJkQPe4m5WjCnNDvA==
X-CSE-MsgGUID: aQUvdDwCTkWEGrkAoOV5nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="71280242"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="71280242"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 04:04:16 -0700
X-CSE-ConnectionGUID: hDOE4qqwTkunWlmB2YVC+A==
X-CSE-MsgGUID: DpzZf2DLQYO2aqTpXsfqbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="179839048"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 04:04:14 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 0ECDB11FCCF;
	Mon, 15 Sep 2025 14:04:11 +0300 (EEST)
Date: Mon, 15 Sep 2025 14:04:10 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/4] ACPI: property: Fix buffer properties extraction
 for subnodes
Message-ID: <aMfyqjZZwozuRmW_@kekkonen.localdomain>
References: <5046661.31r3eYUQgx@rafael.j.wysocki>
 <5017964.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5017964.GXAFRqVoOG@rafael.j.wysocki>

Hi Rafael,

On Fri, Sep 12, 2025 at 09:39:52PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI handle passed to acpi_extract_properties() as the first
> argument represents the ACPI namespace scope in which to look for
> objects returning buffers associated with buffer properties.
> 
> For _DSD objects located immediately under ACPI devices, this handle is
> the same as the handle of the device object holding the _DSD, but for
> data-only subnodes it is not so.
> 
> First of all, data-only subnodes are represented by objects that
> cannot hold other objects in their scopes (like control methods).
> Therefore a data-only subnode handle cannot be used for completing
> relative pathname segments, so the current code in
> in acpi_nondev_subnode_extract() passing a data-only subnode handle
> to acpi_extract_properties() is invalid.
> 
> Moreover, a data-only subnode of device A may be represented by an
> object located in the scope of device B (which kind of makes sense,
> for instance, if A is a B's child).  In that case, the scope in
> question would be the one of device B.  In other words, the scope
> mentioned above is the same as the scope used for subnode object
> lookup in acpi_nondev_subnode_extract().
> 
> Accordingly, rearrange that function to use the same scope for the
> extraction of properties and subnode object lookup.
> 
> Fixes: 103e10c69c61 ("ACPI: property: Add support for parsing buffer property UUID")

I believe the commit introducing this is
99db5ff7fe0b4e1657423d7bbe2aa8f655dd02d1 .

> Cc: 6.0+ <stable@vger.kernel.org> # 6.0+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/property.c |   30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -83,6 +83,7 @@ static bool acpi_nondev_subnode_extract(
>  					struct fwnode_handle *parent)
>  {
>  	struct acpi_data_node *dn;
> +	acpi_handle scope = NULL;
>  	bool result;
>  
>  	if (acpi_graph_ignore_port(handle))
> @@ -98,27 +99,18 @@ static bool acpi_nondev_subnode_extract(
>  	INIT_LIST_HEAD(&dn->data.properties);
>  	INIT_LIST_HEAD(&dn->data.subnodes);
>  
> -	result = acpi_extract_properties(handle, desc, &dn->data);
> +	/*
> +	 * The scope for the completion of relative pathname segments and
> +	 * subnode object lookup is the one of the namespace node (device)
> +	 * containing the object that has returned the package.  That is, it's
> +	 * the scope of that object's parent device.
> +	 */
> +	if (handle)
> +		acpi_get_parent(handle, &scope);
>  
> -	if (handle) {
> -		acpi_handle scope;
> -		acpi_status status;
> -
> -		/*
> -		 * The scope for the subnode object lookup is the one of the
> -		 * namespace node (device) containing the object that has
> -		 * returned the package.  That is, it's the scope of that
> -		 * object's parent.
> -		 */
> -		status = acpi_get_parent(handle, &scope);
> -		if (ACPI_SUCCESS(status)
> -		    && acpi_enumerate_nondev_subnodes(scope, desc, &dn->data,
> -						      &dn->fwnode))
> -			result = true;
> -	} else if (acpi_enumerate_nondev_subnodes(NULL, desc, &dn->data,
> -						  &dn->fwnode)) {
> +	result = acpi_extract_properties(scope, desc, &dn->data);
> +	if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn->fwnode))
>  		result = true;
> -	}
>  
>  	if (result) {
>  		dn->handle = handle;
> 
> 

-- 
Kind regards,

Sakari Ailus

