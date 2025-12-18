Return-Path: <linux-acpi+bounces-19652-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D9CCCB4B8
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 11:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2697B300BB9E
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5912333122A;
	Thu, 18 Dec 2025 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WCpOtLp/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5B2BE7C6;
	Thu, 18 Dec 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052231; cv=none; b=CpHCsFlHCaazmdoWb5kDacGqGgwDtfB393fsPOSqcypY7P7TUhyZTbNRWsFsbbANtTyaCRszAf+6H5gFfcQFNU72xf3bPKP8N4y2PR2UWCPKE1KvnPs9StqIvG7DCflAY3QXx2RnBZmDV6dFa33PhFgS/Dwz9h0a0j1qeBP8SBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052231; c=relaxed/simple;
	bh=sLr1k2wuzx8896JoIBhYt4Lyxc1jXsFyTuVA4wv56ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpWtAQQECWy5MU3xJxxYI28oAkBuTwHIyp/aUeqKFCZRD46IgIuDUJ6ROzyBvhSoqCVi4TZssDDTYsp/HS+bbAWZ48pqUqchnDYZCnXbPNwZop9tVId1wPhEm5H+ADsBq1ymRxbWNdJAU2R/faLSLkWIFmVGpVaV/z1iLeER1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WCpOtLp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE665C4CEFB;
	Thu, 18 Dec 2025 10:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766052229;
	bh=sLr1k2wuzx8896JoIBhYt4Lyxc1jXsFyTuVA4wv56ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCpOtLp/OpQ4OJZg86Jofg3N9eXlYHKV++q+6AhGJwOUuyD7GmzxyLGN7q5HbK9dn
	 2kkzsPHP/FsmcfRYnoZGNR526cGAsv66umaO3Sy+B8zzgImU7mQfoRx5IVY/vyVgRW
	 tx7yFSG3aMhI0KdGKSvZneMWZoITbbU3MiCxuZWw=
Date: Thu, 18 Dec 2025 11:03:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PNP: add put_device() in pnpbios_init()
Message-ID: <2025121808-grit-earpiece-51ed@gregkh>
References: <20251218081955.548521-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218081955.548521-1-lihaoxiang@isrc.iscas.ac.cn>

On Thu, Dec 18, 2025 at 04:19:55PM +0800, Haoxiang Li wrote:
> If pnp_register_protocol() fails, call put_device()
> to drop the device reference.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/pnp/pnpbios/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
> index f7e86ae9f72f..997e0153d6e3 100644
> --- a/drivers/pnp/pnpbios/core.c
> +++ b/drivers/pnp/pnpbios/core.c
> @@ -538,6 +538,7 @@ static int __init pnpbios_init(void)
>  	/* register with the pnp layer */
>  	ret = pnp_register_protocol(&pnpbios_protocol);
>  	if (ret) {
> +		put_device(&pnpbios_protocol.dev)

This feels wrong, as this is a static structure, why would it have a
reference count?  Something is not working properly here if this is
required.

What testing caused this to trigger?  How was this found?

thanks,

greg k-h

