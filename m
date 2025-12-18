Return-Path: <linux-acpi+bounces-19665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 276D0CCB9C8
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 12:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86E4930E4134
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 11:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06BB318146;
	Thu, 18 Dec 2025 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iHS6+wDi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986F30B525;
	Thu, 18 Dec 2025 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057038; cv=none; b=kjN61Uzk894n+B9mTCtZ56pjCgX8G6OcW05Jq36yC6c+pLoJlUz9kXfnkOz7jPikRO8o/9mfJU4fCqw4goOAfXqp6u2cEgfcJq6+8/kKsgakbvxUAMjGBlH9Mnk6FuE6iBSWMJ2DvyBW2VAH8Z80t5OLM4Kf5zLW2kPZO+H/VmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057038; c=relaxed/simple;
	bh=FkkqXsVoHmkdbWsbJd4zrUN2xND3vt8Ll+ugq4rSExM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWjVo1P1tqZ/qJL9BCNBR0Rw8uS22ZwcOTDO4OjF1FOw/NCmIcz6UAplJOGXWwH+YtSRO2fm6zhGM705xCg8RXrDpiorLumJfabP8Rmr/O5UUQF02xCDGcG0OA7KzTvGFwOZCSEFzddpJ236c3nFjrheFvXCGeiPtHLLXQT3ulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iHS6+wDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9475C116B1;
	Thu, 18 Dec 2025 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766057038;
	bh=FkkqXsVoHmkdbWsbJd4zrUN2xND3vt8Ll+ugq4rSExM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHS6+wDiAOwki2gz2oGFMVFxUPWPyCnTYHkPUZfOW5nFfW23y0eRsvmt2vQpFVo/s
	 pqODm9E6uFZP1DFNoBdDDrQ+QCjnP4gVFWENeibddnlw45IYQdJTSX0icRDwosEDZP
	 MdhTTspJBgFwX73jEZJUmrTuLUkjqCPBTSg6Y91M=
Date: Thu, 18 Dec 2025 12:23:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: perex@perex.cz, rafael@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PNP: add a put_device() in isapnp_init()
Message-ID: <2025121835-flattop-july-3c62@gregkh>
References: <20251218083646.553049-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218083646.553049-1-lihaoxiang@isrc.iscas.ac.cn>

On Thu, Dec 18, 2025 at 04:36:46PM +0800, Haoxiang Li wrote:
> if pnp_register_protocol() fails, call put_device()
> to drop the device reference.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/pnp/isapnp/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
> index 219f96f2aaaf..d6daab7ed59e 100644
> --- a/drivers/pnp/isapnp/core.c
> +++ b/drivers/pnp/isapnp/core.c
> @@ -983,8 +983,10 @@ static int __init isapnp_init(void)
>  		return -EBUSY;
>  	}
>  
> -	if (pnp_register_protocol(&isapnp_protocol) < 0)
> +	if (pnp_register_protocol(&isapnp_protocol) < 0) {
> +		put_device(&isapnp_protocol.dev);

Same here, this feels very wrong.

How was this tested?

How was this found?

thanks,

greg k-h

