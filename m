Return-Path: <linux-acpi+bounces-10338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1172A9FEF4B
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 13:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9C41882EA0
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Dec 2024 12:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27C21925AC;
	Tue, 31 Dec 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gevbjIkI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4319049A;
	Tue, 31 Dec 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646556; cv=none; b=D2Z0NlKEyjGC75yTvK/Jbg+kVE3rmsma3eFhBs7lEFj5gsfO4MJCuwsWzGDNpBn/6S1Ffunvg3XFcTBq1sMykuQL3qRqodKovFMFZiFHNM46l5MugwijeeWyeaU8c4EM97IU78CQ020yJIAz9omk4dw0ITVMNuobqtpeksBFvMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646556; c=relaxed/simple;
	bh=BRMwr0tD/EDS63uSqMel2bgwJOll8h/EKxPt1K+A6tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq8osi5/rz1LIAFBcCUvQRpS4KWaVTXGMKmk/Qr+qlcS8P5NzA8ik6iOoeJP/HfpF7Nzo6AnwnpOwASbqoiW1g8lxBmyWt1Lc+lBFLIILIdgtQd5SKO84erhx6hHLi1pYT00CoSC6KPBt64XkJTFHCN3kaE+gAYV1WsOA5IfCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gevbjIkI; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735646545; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=B0UM772O9bO7L4Z4ZE4r5opoivM6rAlavF/wwK+mgIs=;
	b=gevbjIkINtBLWleVvc0KLD26i6yL1IEUgsE1FpUc277DEK+oUhJjlivDph4+/lopLt3xlXeoAh6OUx4xW/KTyxUHYTWmuG8zvnOnyMxR/FcPoJ+mfEbE0YQnMwsA1haKWA1kBJNFafwhYv2lHtz7ajlkGaU86rTLY4QV31jJ3nw=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WMdzj2U_1735646543 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Dec 2024 20:02:24 +0800
Date: Tue, 31 Dec 2024 20:02:23 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>, rafael@kernel.org,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] acpi/ghes: Make ghes_panic_timeout adjustable as a
 parameter
Message-ID: <Z3PdTzoQ7Ry17Qwq@U-2FWC9VHC-2323.local>
References: <87wmfhjusk.fsf@DESKTOP-5N7EMDA>
 <20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
 <Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
 <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
 <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
 <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
 <Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local>
 <20241231092358.GAZ3O4LroNtlnztneC@fat_crate.local>
 <Z3PEXxFTGXW2j2F3@U-2FWC9VHC-2323.local>
 <20241231111314.GDZ3PRyq_tiU002p5d@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241231111314.GDZ3PRyq_tiU002p5d@fat_crate.local>

On Tue, Dec 31, 2024 at 12:13:14PM +0100, Borislav Petkov wrote:
> On Tue, Dec 31, 2024 at 06:15:59PM +0800, Feng Tang wrote:
> > Thanks for the hint! IIUC, you are mentioning the set_arch_panic_timeout().
> > One thing is, most ARCHs' default timeout is 0, while in our case, the user
> > will also set 'panic=0' :), so we can't easily detect if the 0 is the user-set
> > value or the OS default one. Originally I even thought about adding a flag
> > of 'timeout_user_changed'.  Any suggestion?
> 
> Ok, enough talking. Let's get concrete:
> 
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 31 Dec 2024 12:03:55 +0100
> Subject: [PATCH] APEI: GHES: Have GHES honor the panic= setting
> 
> The GHES driver overrides the panic= setting by rebooting the system
> after a fatal hw error has been reported. The intent being that such an
> error would be hopefully written out faster on non-volatile storage for
> later inspection.
> 
> However, this is not optimal when a hard-to-debug issue requires long
> time to reproduce and when that happens, the box will get rebooted after
> 30 seconds and thus destroy the whole hw context of when the error
> happened.
> 
> So rip out the default GHES panic timeout and honor the global one.
> 
> In the panic disabled (panic=0) case, the error will still be logged to
> dmesg for later inspection and if panic after a hw error is really
> required, then that can be controlled the usual way - use panic= on the
> cmdline or set it in the kernel .config's CONFIG_PANIC_TIMEOUT.
> 
> Reported-by: Feng Tang <feng.tang@linux.alibaba.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>


Looks good to me, thanks!

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

> ---
>  drivers/acpi/apei/ghes.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 07789f0b59bc..b72772494655 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -173,8 +173,6 @@ static struct gen_pool *ghes_estatus_pool;
>  static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
>  static atomic_t ghes_estatus_cache_alloced;
>  
> -static int ghes_panic_timeout __read_mostly = 30;
> -
>  static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
>  {
>  	phys_addr_t paddr;
> @@ -983,14 +981,16 @@ static void __ghes_panic(struct ghes *ghes,
>  			 struct acpi_hest_generic_status *estatus,
>  			 u64 buf_paddr, enum fixed_addresses fixmap_idx)
>  {
> +	const char *msg = GHES_PFX "Fatal hardware error";
> +
>  	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
>  
>  	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
>  
> -	/* reboot to log the error! */
>  	if (!panic_timeout)
> -		panic_timeout = ghes_panic_timeout;
> -	panic("Fatal hardware error!");
> +		pr_emerg("%s but panic disabled\n", msg);
> +
> +	panic(msg);
>  }
>  
>  static int ghes_proc(struct ghes *ghes)
> -- 
> 2.43.0
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

