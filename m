Return-Path: <linux-acpi+bounces-13734-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E224AB8ABA
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 17:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5E016767B
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9121638D;
	Thu, 15 May 2025 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzEkXjNf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31429213E67;
	Thu, 15 May 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322996; cv=none; b=s8kbzyL+rYrtKRBkk7VQYa7hsgImsLjVYDRFFtdJt+IZUuWp3lk7BleFZV12WopO/BYJn3SlT/hzFNCC3KbAD6Bb2bvsid5szzxTiH635M+HgL8luAp/2cF7MjN7WXrYC3fTwO9jaOBgWVCNEU+LYBwMyAxtBTq9Tt3HI+b45HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322996; c=relaxed/simple;
	bh=r+vgoHyPQBXrDnAequwJxZxOTi6XM4s7SidDK1toDMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX94czfAn2YQXl0CrCi488J6Eq3+zPodR3J39F6UX4iN6vkkvM31u3V7ZsSOa2eaVidg6I2BVe/PTXaNQkT9BI0OqBPkWa5yFpgF3CC+5Bo3mk+dcDfbdnoubQ7K27tPtGJ6ZfJ/1356bFQXX4Q0gF+Qv1uzxbOGcIw8lnhnAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzEkXjNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88415C4CEE7;
	Thu, 15 May 2025 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747322995;
	bh=r+vgoHyPQBXrDnAequwJxZxOTi6XM4s7SidDK1toDMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzEkXjNfRDfzQ5GSc7NDBYXzLq2U2bw/Gp4vlC7jEmo5kdO/vJmkmRqKjBbvtvSHE
	 IpmoYfwa4Yw2qifam3LOs0zBS1KEzYLQhiFDffdShYwPtRqVZdiEycadwv7r+PYk5h
	 F4VQ5ffWzzIpOVhb5ugdL/SHgPikVYUBu3BQB8RlWW9b5RVdNuZdwYR/j3G2vIqYqj
	 326h4/FYdiMslKMxeL1TVkHX4WyXFkMbVQsztMT2WgWln04f/pMRIiiyzSARV6zxqK
	 9VzzFrxMxdRi85vDhkSPA6Gs6VcIhSvLUzfyL3pZKhpVKV1IfIDw4C5nguWIlY7ZYC
	 lGmUajFVTt6Uw==
Date: Thu, 15 May 2025 17:29:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-acpi@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
	rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH v1 2/3] x86/xen/msr: Fix uninitialized symbol 'err'
Message-ID: <aCYIblffvBGUuxWf@gmail.com>
References: <20250512084552.1586883-1-xin@zytor.com>
 <20250512084552.1586883-3-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512084552.1586883-3-xin@zytor.com>


* Xin Li (Intel) <xin@zytor.com> wrote:

> xen_read_msr_safe() currently passes an uninitialized argument err to
> xen_do_read_msr().  But as xen_do_read_msr() may not set the argument,
> xen_read_msr_safe() could return err with an unpredictable value.
> 
> To ensure correctness, initialize err to 0 (representing success)
> in xen_read_msr_safe().
> 
> Because xen_read_msr_safe() is essentially a wrapper of xen_do_read_msr(),
> the latter should be responsible for initializing the value of *err to 0.
> Thus initialize *err to 0 in xen_do_read_msr().
> 
> Fixes: 502ad6e5a619 ("x86/msr: Change the function type of native_read_msr_safe()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/xen-devel/aBxNI_Q0-MhtBSZG@stanley.mountain/
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  arch/x86/xen/enlighten_pv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 3be38350f044..01f1d441347e 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -1091,6 +1091,9 @@ static u64 xen_do_read_msr(u32 msr, int *err)
>  {
>  	u64 val = 0;	/* Avoid uninitialized value for safe variant. */
>  
> +	if (err)
> +		*err = 0;
> +
>  	if (pmu_msr_chk_emulated(msr, &val, true))
>  		return val;
>  
> @@ -1162,7 +1165,7 @@ static void xen_do_write_msr(u32 msr, u64 val, int *err)
>  
>  static int xen_read_msr_safe(u32 msr, u64 *val)
>  {
> -	int err;
> +	int err = 0;
>  
>  	*val = xen_do_read_msr(msr, &err);
>  	return err;

So why not initialize 'err' with 0 in both callers, xen_read_msr_safe() 
and xen_read_msr(), and avoid all the initialization trouble in 
xen_do_read_msr()?

Thanks,

	Ingo

