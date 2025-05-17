Return-Path: <linux-acpi+bounces-13767-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D51ABAA52
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 15:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8FD9E5C01
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 13:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D530515E5BB;
	Sat, 17 May 2025 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3kX9IFD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC40517BA6;
	Sat, 17 May 2025 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747488067; cv=none; b=JUR5sPVK7+jwzv4CblQY7jnA7/WqoMzeWMxpRSHT7dlooysyZ3zTeUaWCz82b1T3lG7Gzjl/KGcYS5hU/pntI+kDFGY4JziDjjW7ABDCCo0DnHhdtamijJzlnz+ggvZFZhJPxnWZ3kdK+6obuPB1QfTbnjPPazeM5N74cBd5L+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747488067; c=relaxed/simple;
	bh=sPP8XL7tHXh/bsZIzimqagY+xJVixQzy2ZkOpaT6d08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgZz0c35HH6uGo1OmLpIj7mFuqx0iLl5aNsXPwgKIJywoMR5uLaj0KjIGk+OaJjImqjsUQM+rkIjQ3EM1PHg5bFaY/1hbCAI0x7dDaDkWO8FDoZiObSGXfuEL0oGw1oxB1/FxUjtJ2RfokMyiuCrVzubqoWk6aASU/qnDOZdks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3kX9IFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8448AC4CEE3;
	Sat, 17 May 2025 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747488067;
	bh=sPP8XL7tHXh/bsZIzimqagY+xJVixQzy2ZkOpaT6d08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3kX9IFD3icXogFTLh29FQJgZReIlia2+XrTPBHaiHQWcNHeoYu+rzqDCHPZT5Kx9
	 JuDKi0OdRi9fPMVlRnibMl25ZT+ATpWI2LPAbIxiWdcfH1G1mtOaunDWfbb4Dqxh4F
	 W+nDEAwbfsXvdhray4cosHnqyHWgB8+7DetXkWALXdG8YkSdBLJzqCzB7yHbe8yphw
	 MURfgfhqLyuUW8kpTqgrz4wXYQBSGXe2+pkdnXaeT5auhc6If7QqKCAI5wT9Rh+hPy
	 w+kiiyQmIBlFr93WiLuS4Skd0EK09JEqYRUuaUjkSJFw9ygNhgoEbMk4KSizz4ilyo
	 GmmpO83wkiwgQ==
Date: Sat, 17 May 2025 15:21:02 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-acpi@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
	rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH v1 3/3] x86/msr: Convert a native_wrmsr() use to
 native_wrmsrq()
Message-ID: <aCiNPuwTtrepFc3x@gmail.com>
References: <aCg27zLhBM5d0dAI@gmail.com>
 <EAEB5A61-F19B-481C-B6F0-49B3D509B70A@zytor.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EAEB5A61-F19B-481C-B6F0-49B3D509B70A@zytor.com>


* Xin Li <xin@zytor.com> wrote:

> 
> >>> On 5/15/2025 10:54 AM, Xin Li wrote:
> >>> On 5/15/2025 8:27 AM, Ingo Molnar wrote:
> >>>> 
> >>>> * Xin Li (Intel) <xin@zytor.com> wrote:
> >>>> 
> >>>>> Convert a native_wrmsr() use to native_wrmsrq() to zap meaningless type
> >>>>> conversions when a u64 MSR value is splitted into two u32.
> >>>>> 
> >>>> 
> >>>> BTW., at this point we should probably just replace
> >>>> sev_es_wr_ghcb_msr() calls with direct calls to:
> >>>> 
> >>>>     native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, ...);
> >>>> 
> >>>> as sev_es_wr_ghcb_msr() is now basically an open-coded native_wrmsrq().
> >>>> 
> >>> 
> >>> I thought about it, however it looks to me that current code prefers not
> >>> to spread MSR_AMD64_SEV_ES_GHCB in 17 callsites.  And anyway it's a
> >>> __always_inline function.
> >>> 
> >>> But as you have asked, I will make the change unless someone objects.
> >> 
> >> Hi Ingo,
> >> 
> >> I took a further look and found that we can't simply replace
> >> sev_es_wr_ghcb_msr() with native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, ...).
> >> 
> >> There are two sev_es_wr_ghcb_msr() definitions.  One is defined in
> >> arch/x86/boot/compressed/sev.h and it references boot_wrmsr() defined in
> >> arch/x86/boot/msr.h to do MSR write.
> > 
> > Ah, indeed, it's also a startup code wrapper, which wrmsrq() doesn't
> > have at the moment. Fair enough.
> 
> So you want me to drop this patch then?

No, patch #3 is fine as-is in its -v1 form, I was wrong.

Thanks,

	Ingo

