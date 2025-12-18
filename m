Return-Path: <linux-acpi+bounces-19666-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5CBCCBA9D
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 12:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 697223095ABC
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 11:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCE731D362;
	Thu, 18 Dec 2025 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eyXtuoZE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FDD31B82E;
	Thu, 18 Dec 2025 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057589; cv=none; b=hspRtEc877kAn5w4VmUGNgI0C/baer7c2KmB8UV6WtQDrLhjs6H8/kXdmZRbHGXOTykb2CIASSnIUEtXprpJxhQYKUcvncRNSVcRGEA27DEIknQokc7pNZ8gj+lv57/cOVHhn3IxtjpTsPM80FAb7nl3EiIDCIiPmcRfkBHKo+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057589; c=relaxed/simple;
	bh=x56vGhs99iUAGeSHiBDacCNHmj7BMmiZ4yuWTG6NNws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzVChonl7TJuMePLztYbHfbxteN7fRWIQZjH47KBTNA9Jk5zGf1d5KVFv66rWH0Si8xQwY1fw6yPFi8P9WT8O751oAWwvW24SjUO/UYzfEtfaNUIFmglHLATgwwqTzw8romS1ok+gCT+QnCLsDj9DYdwkY+zoXjeUBNyFwgFJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eyXtuoZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE641C4CEFB;
	Thu, 18 Dec 2025 11:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766057588;
	bh=x56vGhs99iUAGeSHiBDacCNHmj7BMmiZ4yuWTG6NNws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyXtuoZEYeceLgAJYDLi/YjVNgt7Ipw33aNg5RGJIqNVOOEMQQzO6wmGyhBGYkTNq
	 /nbU9kTXW5AI4CYtUar9wl9/tShyCWJ8ORMJRgU6Iv8adcj/qLOvromtmgDT7abxsH
	 G+844avZ+WnmbQ9Qpzza7EVANBF3U39Vu+fZqrbg=
Date: Thu, 18 Dec 2025 12:33:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PNP: add a error handling in pnpacpi_init()
Message-ID: <2025121841-unwoven-twelve-e65b@gregkh>
References: <20251218082903.551296-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218082903.551296-1-lihaoxiang@isrc.iscas.ac.cn>

On Thu, Dec 18, 2025 at 04:29:03PM +0800, Haoxiang Li wrote:
> Add a error handling for pnp_register_protocol(), and if
> it fails, call put_device() to drop the device reference.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/pnp/pnpacpi/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> index a0927081a003..0b63e1748b7c 100644
> --- a/drivers/pnp/pnpacpi/core.c
> +++ b/drivers/pnp/pnpacpi/core.c
> @@ -304,7 +304,10 @@ static int __init pnpacpi_init(void)
>  		return 0;
>  	}
>  	printk(KERN_INFO "pnp: PnP ACPI init\n");
> -	pnp_register_protocol(&pnpacpi_protocol);
> +	if (pnp_register_protocol(&pnpacpi_protocol)) {
> +		put_device(&pnpacpi_protocol.dev);

Again, this looks really wrong.

What tool are you all using to "find" these issues?  Why aren't you
properly documenting it?

thanks,

greg k-h

