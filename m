Return-Path: <linux-acpi+bounces-8281-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E55978142
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE281C22486
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5AB1DB93A;
	Fri, 13 Sep 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CdMs9gNE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149B1DB936;
	Fri, 13 Sep 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234501; cv=none; b=grmE25k1yNsuOKTj98IN5jXHJyw2b3Y2vgh51JXoIHdRrEk/o7jOkADcu/rWISkx7jmv7AcMwvo9ogeBtx+OWkqL3c7NzLA9jPiwq8b6C7QpVZL+N4FMPAEep3ZSkDEga9xKDIc1C5oiZtIQ+DWM+3/Sk9XilipSY3jSL8fSAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234501; c=relaxed/simple;
	bh=DC812cNP2cjU0UjaJrBz8Qs8libYI+MgnRXo4lg77Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVB//cDIIyUg4GDtv+sC5gcftY9uv6NWrK6yEidRQ/M8IwN4uolGZZFiKaGMlinV9lqty/guRihBQ/0ibW5q7u/34Eh6cWJ5ZozpDyN01l4CgWruE03hv3z55hXpSYqoCIYw6wNMY+Lp/9q+2T3oYe9P9m1wCAdDdlPFPZjRkiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CdMs9gNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA23C4CEC0;
	Fri, 13 Sep 2024 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726234501;
	bh=DC812cNP2cjU0UjaJrBz8Qs8libYI+MgnRXo4lg77Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdMs9gNEXxn2HMZjDKQ5dPndDm7rPln8EE6zu6jv50x3A+Vdb18F36xEAPCAamAMF
	 3WWoj44PwexEleU4b42D5Hw+aAWEzO9bD2YR4HQpvJsy3lIugN3hz9mL1LJCGmOS08
	 wLgzhD+6wOo/dxU3g3uw129hN95bAEbwJ/A66glY=
Date: Fri, 13 Sep 2024 15:34:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] software node: Simplify swnode_register() a bit
Message-ID: <2024091300-afford-tamper-1831@gregkh>
References: <20240913110523.3584749-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913110523.3584749-1-andriy.shevchenko@linux.intel.com>

On Fri, Sep 13, 2024 at 02:05:23PM +0300, Andy Shevchenko wrote:
> By introducing two temporary variables simplify swnode_register() a bit.
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/swnode.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index b0be765b12da..810c27a8c9c1 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -908,6 +908,7 @@ static struct fwnode_handle *
>  swnode_register(const struct software_node *node, struct swnode *parent,
>  		unsigned int allocated)
>  {
> +	struct kobject *kobj_parent = parent ? &parent->kobj : NULL;

I despise ?: use just so much, EXCEPT for when it's used in something
like this:

>  	struct swnode *swnode;
>  	int ret;
>  
> @@ -934,12 +935,10 @@ swnode_register(const struct software_node *node, struct swnode *parent,
>  
>  	if (node->name)
>  		ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
> -					   parent ? &parent->kobj : NULL,
> -					   "%s", node->name);
> +					   kobj_parent, "%s", node->name);

Which really is the only valid way I'd put up with it :)

So can you rewrite the change above to be just:

	struct kobject *kobj_parent = NULL;

	...

	if (parent)
		kobj_parent = &parent->kobj;

Which is much simpler to read, right?

thanks,

greg k-h

