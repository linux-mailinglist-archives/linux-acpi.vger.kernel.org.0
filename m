Return-Path: <linux-acpi+bounces-6531-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78C90F58B
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 19:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8DB28294E
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91015665E;
	Wed, 19 Jun 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="qssnXKt/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B3152160
	for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819767; cv=none; b=emItBBfKJqCkEOI7wZgCzVHqR1lgbIlippyjO5FiD49761qn2roW9onXRFxrX5VZUhowqMX6ywI8clgeSVb0D04mr+tYP4yeatDxPPUxV/x1W+eE+qmTD/9XZ+jMxxBhqyPS8cOYwPKflh+qDI7wottb7diG1RXRt7MthtImBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819767; c=relaxed/simple;
	bh=qZLAW1L5M56DwbKoi1/YqdkTRNLosZQ9XhdG7pPvBuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPQslJ5b1e4w/PMXAO6wI1+cdiFetINh579h2rNpMEz6nmIE8RcbNqopiMrvou5eDo4228p52T2RLcYDKjg6FOqkKMSLPte75Uz+dLBf1LsKgYNZt/yfMmgfsw9X4Xc0BOogkZST9rmB3cJpfcBCfYq8Bes02L8xiump61H9SCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=qssnXKt/; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7eb7a2f062cso271229339f.0
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718819765; x=1719424565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mbjif+WJ/551UA6yF5H6wna1Ibvk9vV1Wcfn2sMlCyY=;
        b=qssnXKt/BrjOKDUTCiK3f3cKtEd5fS30IbK3v9TaUs7so1EnQMWguUzWfM5fFHcwQv
         aseKZb/j8S7N1OFjOjwOjpRBxI2NYptCqVeaAqZ/g2+h/dQCy4uD5HVInzvWf9TjQX3F
         9H8EcmId/6tdxjSUS/OIvg95c3qKeDhbg3ZTY6FNEnEngG2OT8XX2jzyZoerUFpfc+hm
         DIJCiu0Lwpqbj//+fvrRUjrpkGn6g+vjQPxVlTfgxIl/ftfKsH7711u/ahwsotzNWmVO
         BEST826VkUWgslJrX7qqp/LB+qU+5NjSsjpT4WwtrDtsr95/oADpBi8clhtDEkHKcQkL
         +d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718819765; x=1719424565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbjif+WJ/551UA6yF5H6wna1Ibvk9vV1Wcfn2sMlCyY=;
        b=i4xxVsqASWl9GKpXdp7XgpwtMGx63ZUFUPQHMJTriD4XzNWyb1QRejWUM4vmaSRG6A
         7sJn5Q8tM17JVu/D+hy0ZaCWfwJfKEAKC/EwAXk94j1gBVoZvNFKzOEGObrGNLo9RVW6
         KiBm4oxSbZfbI4ugfCWlKpBxNXSpF/YiZIaFXdigNiD9iVneFtW+rQvGQuKxNokMpo+R
         tq5JumaRRTfIi1OJ2RwfMCaEaUO6igkgppic81udKDRdsIycyTDvFpu2bBkN2VohJebr
         g4naUVPGeX+zKu1KMldd1R9ZuVlxTG4rbYjxb8WWp3i82k6FzYCbuhbzNCVlP0awbufJ
         gvAA==
X-Forwarded-Encrypted: i=1; AJvYcCXZg41tKAxnUr5PPmKN0jKb0cHxjb538GRxLxfphLWLxFyn6Z7c3MPe9XvOpcgt65nesJRwteGHyjLtoLnpWeuunk9uQhcc9f1SWw==
X-Gm-Message-State: AOJu0Yxlb37nvhv84HzCfUe9ml+zRMp9jJuPvy4/5PbtGBVjGZ8RySIq
	WxMOen5XyA9fedIR5sOAVG8uYvirDZbriYz8hpcbo85c2oHSzVr7JxucRWBaJC0=
X-Google-Smtp-Source: AGHT+IF9TsY8NVv2B42kRpxvrVeMm3R5ONdANb6gDSHycKGPhfTbgx+nCs8+HifwJCTtlx5q0X8U3A==
X-Received: by 2002:a05:6602:640c:b0:7eb:c972:dee2 with SMTP id ca18e2360f4ac-7f13ee0e286mr404164839f.3.1718819765360;
        Wed, 19 Jun 2024 10:56:05 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:212e:5310:572e:1126])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b957bb0c0csm3978084173.87.2024.06.19.10.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:56:05 -0700 (PDT)
Date: Wed, 19 Jun 2024 12:56:02 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lenb@kernel.org, mmikowski@kfocus.org, Perry.Yuan@amd.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnMbshMhyoSKyClb@kf-XE>
References: <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnJfmUXmU_tsb9pV@kf-XE>
 <CAJZ5v0gOBH7OKF3KXwxYfWkGkC45rzDguR4VmSnoZDKpm+KPSg@mail.gmail.com>
 <12457165.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12457165.O9o76ZdvQC@rjwysocki.net>

On Wed, Jun 19, 2024 at 07:30:55PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, June 19, 2024 7:09:35 PM CEST Rafael J. Wysocki wrote:
> > On Wed, Jun 19, 2024 at 6:33 AM Aaron Rainbolt <arainbolt@kfocus.org> wrote:
> > >
> > > acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> > >
> > > The _OSC is supposed to contain a bit indicating whether the hardware
> > > supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> > > be considered absent. This results in severe single-core performance
> > > issues with the EEVDF scheduler on heterogenous-core Intel processors.
> > 
> > While some things can be affected by this, I don't immediately see a
> > connection between CPPC v2, Intel hybrid processors and EEVDF.
> > 
> > In particular, why would EEVDF alone be affected?
> > 
> > Care to explain this?
> 
> And the reason why I am asking is because I think that you really need
> something like this (untested beyond compilation):
> 
> ---
>  drivers/cpufreq/intel_pstate.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -355,16 +355,16 @@ static void intel_pstate_set_itmt_prio(i
>  	int ret;
>  
>  	ret = cppc_get_perf_caps(cpu, &cppc_perf);
> -	if (ret)
> -		return;
> -
>  	/*
> -	 * On some systems with overclocking enabled, CPPC.highest_perf is hardcoded to 0xff.
> -	 * In this case we can't use CPPC.highest_perf to enable ITMT.
> -	 * In this case we can look at MSR_HWP_CAPABILITIES bits [8:0] to decide.
> +	 * If CPPC is not available, fall back to MSR_HWP_CAPABILITIES bits [8:0].
> +	 *
> +	 * Also, on some systems with overclocking enabled, CPPC.highest_perf is
> +	 * hardcoded to 0xff, so CPPC.highest_perf cannot be used to enable ITMT.
> +	 * Fall back to MSR_HWP_CAPABILITIES then too.
>  	 */
> -	if (cppc_perf.highest_perf == CPPC_MAX_PERF)
> -		cppc_perf.highest_perf = HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
> +	if (ret || cppc_perf.highest_perf == CPPC_MAX_PERF)
> +		cppc_perf.highest_perf =
> +			HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
>  
>  	/*
>  	 * The priorities can be set regardless of whether or not
> 
> 
> 

Gah. I can't read apparently. That patch may very well work because I
just realized the "if (ret) return;" means to return if ret is NOT 0. I
had it confused with "return if ret is 0".

That patch looks like it may very well work, and better than what I had
because it doesn't require manually setting a kernel parameter. I'll apply
it and test it. (That may take me a bit, I don't have access to the
hardware with the problem, only my boss does, but I should be able to get
it done before the end of today.)

