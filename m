Return-Path: <linux-acpi+bounces-10341-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380929FF59F
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jan 2025 03:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EA2161582
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jan 2025 02:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB823522F;
	Thu,  2 Jan 2025 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wBaaA+rG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65DF6FBF;
	Thu,  2 Jan 2025 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735786349; cv=none; b=brpgXzcKLw4RdF+2iMpbwa6RMsUrO3yiWL60eqaUod2Y6hw7yOG2iFxLk2eYFRy1wHC8mTpksZS3gVE7+6nUdOi8JqeF08/ECjXG6rubteQdGpSNSsaUg+XUvfeKZ++cs+QGnT6MFqYU3VAtJytkQZBYij9Gn1cKd3oVNOMIuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735786349; c=relaxed/simple;
	bh=oHvxO/5cTNEe9l1oJLbBxIsRtx/T9EZ4sKxQLC30xBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cSEvKl1+g+MrWtGIm2rlWuBmvjKMp5c2RzcIO+cczbTULe7qA54wvWA7W+2Vlw2NAJCbB7/BG3ghXETH1xkgWoCNn+4267DYCra1nyUq7yOwTDfsckVjYDkascsOH5icfGbV0zsE5ZY785iClInE7wsvaZF2dWoeHpEeAe2u+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wBaaA+rG; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735786338; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=C+bMjV6YJCPfo+u3s9L7X3/PVE7kWQR4dSrIXgeY5ys=;
	b=wBaaA+rG51AvWu7fRPhvAFsbKsXeexbljdyl/kUHQ9RJPayoA88tMstow9Xjv4aTsYk409y38ERVsRsKOEErDmrfqSTjrk01ihNWpVaLrbGklvQPywwuWC/9bjUsNy07P7swRc5ZrVVcRYSfgsGQb4sXnAVQl9mlmjNGuwk6+XM=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WMidez-_1735786016 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jan 2025 10:46:57 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Feng Tang <feng.tang@linux.alibaba.com>,  rafael@kernel.org,  Len Brown
 <lenb@kernel.org>,  James Morse <james.morse@arm.com>,  Tony Luck
 <tony.luck@intel.com>,  linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Ira Weiny <ira.weiny@intel.com>,  Dave
 Jiang <dave.jiang@intel.com>,  Dan Williams <dan.j.williams@intel.com>,
  Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] acpi/ghes: Make ghes_panic_timeout adjustable as a
 parameter
In-Reply-To: <20241231111314.GDZ3PRyq_tiU002p5d@fat_crate.local> (Borislav
	Petkov's message of "Tue, 31 Dec 2024 12:13:14 +0100")
References: <20241230101658.GAZ3JzGhRjn7UtoJPt@fat_crate.local>
	<87wmfhjusk.fsf@DESKTOP-5N7EMDA>
	<20241230112608.GCZ3KDUNU2OVZanpFb@fat_crate.local>
	<Z3KGopUvilZLwsBK@U-2FWC9VHC-2323.local>
	<20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
	<Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
	<20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
	<Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local>
	<20241231092358.GAZ3O4LroNtlnztneC@fat_crate.local>
	<Z3PEXxFTGXW2j2F3@U-2FWC9VHC-2323.local>
	<20241231111314.GDZ3PRyq_tiU002p5d@fat_crate.local>
Date: Thu, 02 Jan 2025 10:46:54 +0800
Message-ID: <87ikqydja9.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Borislav Petkov <bp@alien8.de> writes:

> On Tue, Dec 31, 2024 at 06:15:59PM +0800, Feng Tang wrote:
>> Thanks for the hint! IIUC, you are mentioning the set_arch_panic_timeout().
>> One thing is, most ARCHs' default timeout is 0, while in our case, the user
>> will also set 'panic=0' :), so we can't easily detect if the 0 is the user-set
>> value or the OS default one. Originally I even thought about adding a flag
>> of 'timeout_user_changed'.  Any suggestion?
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

IIUC, the hardware error will be written out on non-volatile storage at
the same time with or without ghes_panic_timeout overriding.  The
difference is that after rebooting, the error information in
non-volatile storage can be extracted and reported via UI, SNMP, or
MCTP earlier.

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

---
Best Regards,
Huang, Ying

