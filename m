Return-Path: <linux-acpi+bounces-9791-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3326F9DB6E9
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 12:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1652B217F8
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 11:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479AB19ABAC;
	Thu, 28 Nov 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vcViEFYB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C3199385;
	Thu, 28 Nov 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794595; cv=none; b=KOczwO5m9eGY7UfAXFL0D2RN1YCYSwlnZ2Kueb3Fpz5W5122023eMreZoiX0qe+ssv4+GTVrgaNRxCjXdgXiXGkU4t98zlgewv7x0czkQP54ihYp+r9knK5VAAUKPUjQRdw97HzB3bno3D6Bx3ZVy6dsnmRf2BBH0bDzN+4W7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794595; c=relaxed/simple;
	bh=ZhFuMBHlq3QonHvTwWvCentjuDWHk4WmEzIyakRZtuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l48sj9GIXH9zNy/+8lltnsr1VFmDBuCGhPJv8OEyKuDk0GF3eKP5moslp6yf7jVzY7eCWhQVOgZLZ81Zc5Ykt8lxJujhrk2zIbwxnalBS5tjKhE2FEZ/H/H72ijXlViAH0gb359aAepti/UkzdrAryfvq0LljOfglyM5bBcMsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vcViEFYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B20C4CED2;
	Thu, 28 Nov 2024 11:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732794594;
	bh=ZhFuMBHlq3QonHvTwWvCentjuDWHk4WmEzIyakRZtuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vcViEFYBmCWOqalvl+ViIlBYyPFZvRbQiAjdxt3FqajCD/6JtRbc3smczdcenD7Ft
	 0l+O8na5wO01KSjkaOwqKjlSxFFcuvcVdP3Cxr+Bn1xlIvWJi1JBg/O7roU1MM1mPr
	 Q3gDdk2XvWpEgkd6+mdQ/Xf3t+Tf2n5fVA535haI=
Date: Thu, 28 Nov 2024 12:49:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] device property: do not leak child nodes when using
 NULL/error pointers
Message-ID: <2024112810-drudge-factor-9bc7@gregkh>
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

On Wed, Nov 27, 2024 at 09:39:34PM -0800, Dmitry Torokhov wrote:
> The documentation to various API calls that locate children for a given
> fwnode (such as fwnode_get_next_available_child_node() or
> device_get_next_child_node()) states that the reference to the node
> passed in "child" argument is dropped unconditionally, however the
> change that added checks for the main node to be NULL or error pointer
> broke this promise.
> 
> Add missing fwnode_handle_put() calls to restore the documented
> behavior.
> 
> Fixes: 002752af7b89 ("device property: Allow error pointer to be passed to fwnode APIs")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/base/property.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 837d77e3af2b..696ba43b8e8a 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -759,6 +759,12 @@ struct fwnode_handle *
>  fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
>  			   struct fwnode_handle *child)
>  {
> +	if (IS_ERR_OR_NULL(fwnode) ||
> +	    !fwnode_has_op(fwnode, get_next_child_node)) {
> +		fwnode_handle_put(child);
> +		return NULL;
> +	}
> +
>  	return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
> @@ -778,9 +784,6 @@ fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
>  {
>  	struct fwnode_handle *next_child = child;
>  
> -	if (IS_ERR_OR_NULL(fwnode))
> -		return NULL;
> -
>  	do {
>  		next_child = fwnode_get_next_child_node(fwnode, next_child);
>  		if (!next_child)
> @@ -806,8 +809,10 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  	const struct fwnode_handle *fwnode = dev_fwnode(dev);
>  	struct fwnode_handle *next;
>  
> -	if (IS_ERR_OR_NULL(fwnode))
> +	if (IS_ERR_OR_NULL(fwnode)) {
> +		fwnode_handle_put(child);
>  		return NULL;
> +	}
>  
>  	/* Try to find a child in primary fwnode */
>  	next = fwnode_get_next_child_node(fwnode, child);
> -- 
> 2.47.0.338.g60cca15819-goog
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

