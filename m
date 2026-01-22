Return-Path: <linux-acpi+bounces-20529-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO6fJGv+cWmvZwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20529-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:39:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE7E655CA
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72762866BEC
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 10:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF3A3D3015;
	Thu, 22 Jan 2026 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="11LfwkKq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D58A35C1B6;
	Thu, 22 Jan 2026 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077681; cv=none; b=dSsbxTAR9QbigJsah3M0i3sWE7xwEEaCDrdeVlC4s8XY/G4vV8UUChE7QC4RtmcbsHcCvF06TXFmyS8Ky25Pf1AfohYYyqXOTvg1o3pVRRqNiQw32zPAj85y6qZgHTYsGWb/rdiR5YUac0w1YouQB+4yuoueAhLNaHeJED7FdCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077681; c=relaxed/simple;
	bh=6ckSUwc/iIKoCmY09RXbCNVzp3fPEqGJSThtHhnQ2zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWN2iesoXkk3SfbjyuMfPSNd+W87IjeyjNu5zf2wXUs5wU/dywzgODmzqNjVwnSeDF/gtDtvOeZ/IHU8pA/pn0HLA/gszNUjbiLy6ydfWZgIr/TQD/HdNVyuTPY54T39LE1ftcfM63xFSLZ50ofMPEOmPAbssc4GN7oI+HxicKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=11LfwkKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82534C116C6;
	Thu, 22 Jan 2026 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769077681;
	bh=6ckSUwc/iIKoCmY09RXbCNVzp3fPEqGJSThtHhnQ2zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=11LfwkKq9xyMb/7AnGfz7QVFZ2bVm87rZ671wyPXqcy3phbUQsO2Z/BX6GTck5qIp
	 xL8PAWwbyn4AkP9CfPjpDp/5yKdvseSTmviy9uZM+U4pNag3ga3YOgRKnZARxteJf0
	 m88bT1JvGyGtcOuIMkSZ2JhPlHoe9hWiNTCxgFko=
Date: Thu, 22 Jan 2026 11:27:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: rafael@kernel.org, lenb@kernel.org, tglx@kernel.org, dakr@kernel.org,
	akpm@linux-foundation.org, apatel@ventanamicro.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	geshijian@picoheart.com, weidong.wd@picoheart.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] init: Move console_on_rootfs after
 async_synchronize_full
Message-ID: <2026012217-opium-grit-2295@gregkh>
References: <20260122073446.45628-1-yang.yicong@picoheart.com>
 <20260122073446.45628-3-yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122073446.45628-3-yang.yicong@picoheart.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-20529-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,picoheart.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BE7E655CA
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 03:34:46PM +0800, Yicong Yang wrote:
> Currently the console_on_rootfs() is called before
> async_synchronize_full(), the console initialization
> could be still in process in theory due to async
> probe, etc. Make it after the async_synchronize_full()
> to make sure the initialization work is done.

Please wrap at 72 columns.

> 
> Log the error code as well if we failed to open the console.
> 
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> ---
>  init/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index b84818ad9685..c37ba5f89b96 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1578,6 +1578,7 @@ static int __ref kernel_init(void *unused)
>  	kernel_init_freeable();
>  	/* need to finish all async __init code before freeing the memory */
>  	async_synchronize_full();
> +	console_on_rootfs();

Are you sure this is ok?  Messing around with init levels and order is
_VERY_ tricky.

Your console should NOT be on an async probe path, if you really need
it, then do not do that at all.  Make it sync, and then it should be ok.

>  
>  	system_state = SYSTEM_FREEING_INITMEM;
>  	kprobe_free_init_mem();
> @@ -1647,7 +1648,7 @@ void __init console_on_rootfs(void)
>  	struct file *file = filp_open("/dev/console", O_RDWR, 0);
>  
>  	if (IS_ERR(file)) {
> -		pr_err("Warning: unable to open an initial console.\n");
> +		pr_err("Warning: unable to open an initial console, err = %ld\n", PTR_ERR(file));

Why is this changed?

>  		return;
>  	}
>  	init_dup(file);
> @@ -1690,7 +1691,6 @@ static noinline void __init kernel_init_freeable(void)
>  	kunit_run_all_tests();
>  
>  	wait_for_initramfs();
> -	console_on_rootfs();

You just delayed the console output for many (i.e. most) systems out
there, are you sure that is acceptable to them?

thanks,

greg k-h

