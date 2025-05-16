Return-Path: <linux-acpi+bounces-13743-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 627D2AB9D19
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 15:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A971BC3FC1
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502AD11CAF;
	Fri, 16 May 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDb+IMC/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EEF17548;
	Fri, 16 May 2025 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401568; cv=none; b=RLFMSXw05F3Iu2PBgGFNiqQOk1kIreKEoqI2q0J7Inv0Ta0AJynUVRdumRpplyJYidoLIiivvjm0n0uGQ4pcZ5CYugFRsnf/lNNdzPZZAiKwDaKYr3cIbC+PpelaIqzOHdT87123OHYF73QSzxfuhHCtswB2BqsXhYzL15adUGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401568; c=relaxed/simple;
	bh=oaUy859dTcPr4O32A6D5WWt1R4OnjuyJMMmb5wlJIm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAphg8uhdTh8VFMXviIzKcOI437dFdakaPrh4nCPpkQLcFgjKqNeQx6Dwqb9JD8HexAHTJxoKQVDAp5Hyfxq9KfZBa40KYiWsracIfSmNW6t6xNZ+mZ3sMp/B6XO92eWld9XRmZUDouNXiqdkxYar0lJkx4Fk+WibjhHoKtwS0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDb+IMC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A561C4CEE4;
	Fri, 16 May 2025 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747401566;
	bh=oaUy859dTcPr4O32A6D5WWt1R4OnjuyJMMmb5wlJIm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDb+IMC//aX/x5nhjvb58hALgb2f9WnP8dQdFi/IebqgY5NZyymEASPMa46QOmkWZ
	 UwZIAvwWdTMFwlWSD1mbNEG3NbjSq/QjvKT13dtrEo1aUk2O8tRxHucWSK5dk6kThQ
	 bipJC1UdM2t4QT3UqsmsOb3VzB/qCF3/JW9p5hVp3y4kRdiSUIZikQrfMyi1Xhvf4J
	 d20/f+L6D11ww1wFQ0jhbLfou8JcteHWU5X5taApXcwEULk8fY38p2DN7OE5RJUhmU
	 suyOC+HV2K0rQH8RccDoV8gFbBjEj6AK8VkT4BudkAqXTIsT8s3XdSfw+bo563odYv
	 SVS86C9BWl1ow==
Date: Fri, 16 May 2025 15:19:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-acpi@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
	rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH v1 2/3] x86/xen/msr: Fix uninitialized symbol 'err'
Message-ID: <aCc7WG9eniyTCgHl@gmail.com>
References: <20250512084552.1586883-1-xin@zytor.com>
 <20250512084552.1586883-3-xin@zytor.com>
 <aCYIblffvBGUuxWf@gmail.com>
 <30affad5-4f26-4e22-9d64-b8ece1199773@zytor.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30affad5-4f26-4e22-9d64-b8ece1199773@zytor.com>


* Xin Li <xin@zytor.com> wrote:

> On 5/15/2025 8:29 AM, Ingo Molnar wrote:
> > 
> > * Xin Li (Intel) <xin@zytor.com> wrote:
> > 
> > > xen_read_msr_safe() currently passes an uninitialized argument err to
> > > xen_do_read_msr().  But as xen_do_read_msr() may not set the argument,
> > > xen_read_msr_safe() could return err with an unpredictable value.
> > > 
> > > To ensure correctness, initialize err to 0 (representing success)
> > > in xen_read_msr_safe().
> > > 
> > > Because xen_read_msr_safe() is essentially a wrapper of xen_do_read_msr(),
> > > the latter should be responsible for initializing the value of *err to 0.
> > > Thus initialize *err to 0 in xen_do_read_msr().
> > > 
> > > Fixes: 502ad6e5a619 ("x86/msr: Change the function type of native_read_msr_safe()")
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: https://lore.kernel.org/xen-devel/aBxNI_Q0-MhtBSZG@stanley.mountain/
> > > Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> > > ---
> > >   arch/x86/xen/enlighten_pv.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> > > index 3be38350f044..01f1d441347e 100644
> > > --- a/arch/x86/xen/enlighten_pv.c
> > > +++ b/arch/x86/xen/enlighten_pv.c
> > > @@ -1091,6 +1091,9 @@ static u64 xen_do_read_msr(u32 msr, int *err)
> > >   {
> > >   	u64 val = 0;	/* Avoid uninitialized value for safe variant. */
> > > +	if (err)
> > > +		*err = 0;
> > > +
> > >   	if (pmu_msr_chk_emulated(msr, &val, true))
> > >   		return val;
> > > @@ -1162,7 +1165,7 @@ static void xen_do_write_msr(u32 msr, u64 val, int *err)
> > >   static int xen_read_msr_safe(u32 msr, u64 *val)
> > >   {
> > > -	int err;
> > > +	int err = 0;
> > >   	*val = xen_do_read_msr(msr, &err);
> > >   	return err;
> > 
> > So why not initialize 'err' with 0 in both callers, xen_read_msr_safe()
> > and xen_read_msr(), and avoid all the initialization trouble in
> > xen_do_read_msr()?
> 
> Yeah, I should make the change in xen_read_msr() too.
> 
> However xen_do_read_msr() should be implemented in a defensive way to
> set *err properly as it's part of its return value.  Actually it was so,
> but one of my previous cleanup patch removed it because err is no longer
> passed to pmu_msr_chk_emulated().

Maybe. It's up to Juergen though.

Thanks,

	Ingo

