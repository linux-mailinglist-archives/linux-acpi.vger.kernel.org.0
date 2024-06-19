Return-Path: <linux-acpi+bounces-6532-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B40F90F891
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 23:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E181C21392
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 21:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA84115AD99;
	Wed, 19 Jun 2024 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="Yn0KyH3R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E4D1586CF
	for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718833181; cv=none; b=tkFDaDHuJVqjPAKXLuA6a0tUSE7eFcwqZKpm/AjHIiOiXxclgsIPW2cvaVQxPgokFa25+M1irmfXqqRaCTI8YD8SbqXjMPe1zqLA/UaE8pBZE3qe3iAGyj8w3cNwkfxOoGwRqozNnFxgpx+mE9eom9Jdqs8FRvhAJcEojp4B06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718833181; c=relaxed/simple;
	bh=W+anAt20EGRZVFKzpD76Y/OqfiPApnoplAdX8AMISno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azteJsyB8/Ar+hzUN+adV7UDtrvSmccLH3yfoz7RTOvcHmc67hcz8M/nOeOoRXblrHT2zX/DuYAuYwG/Jg2Eg680t2TKfDBz7PP4xl2TZHnlMHFa95ECSSZWKCPqOwz7POqP8Mv5kh7/xhnM53p00Hmk6hH4gZT3xQngDRZ2Zrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=Yn0KyH3R; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7eee7728b00so6262039f.3
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718833179; x=1719437979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c7tGRLKrGc6OgGWImJ/uYEBqxWissmKQjKNBWsuhVCQ=;
        b=Yn0KyH3RBdXZifaNP3RnI7LPOjNnOwaK15hRjilYx+TNBo3BhG+/sJFrSxQhQT+jLs
         PRW3sFYmDwPI9SgdE6iDvOcCdCHljGxx2dfucoYt9+qXbezW83OA9L7YpqPBTMBs7bq4
         GVW4fcJs095evTcRQwLjOjgx3sls7VeeqaanxN9PBWTj8SexLbE/dkLeEvcU7Z6RzuAv
         m7azuZnBF9CCvt19FMToJPp5aRCAGvGK1CcbdwJbVWmy3c/qHsTClxlOka3XCLX2u4Fb
         1rEnZnYUozsJYi5e3FHcCugEkzIjC1VHwk2wvC5uhcOGoINyW9OJDW4CxD9Ex16YwpdQ
         CIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718833179; x=1719437979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7tGRLKrGc6OgGWImJ/uYEBqxWissmKQjKNBWsuhVCQ=;
        b=RgCNyeMPP0GPjKAPnIl/56NvnYi2mTe76LPJgejeTFn9P9f9BfSf+gp5szIgX9ggSq
         TExuk3wMifX7HVO3sk8ZvEcXckBBZ/u5nJXWhP9S+mxed5DnL5kN2Dz982M4dBjuFlHk
         MvBUz103X0pyE9QL5cGo2i9zNtUXHJ54i/BGe2DRqEuQecjpIl3dtZDBC+ZKmqLtaaVH
         E1RbWHo5NE4OoKQrcSDqNH1kAGlyGCYSC0Xv8t7bVuh0zqtGTcstgx7XswjEbid5Oh8t
         WKhhsbtYbr0o4vNIMFkndBvTvcC2FBarFiLxLx4elzLixv2fi05lDNx0TwwvvMIhWEdA
         UPng==
X-Forwarded-Encrypted: i=1; AJvYcCXTiMDGgEttrIqz7Z1mdiYMjFtNcUgOqtLQnKuBpQrTiTd4VSZk8leGLkpIad24BqDxr/FQ/snqvqjIIjyFoqJF/Y9dEIkE4ZpgtQ==
X-Gm-Message-State: AOJu0Yxygll00AeMRYJhlWiXnjJ/OyZx83Cf8+Ov59y4L8bxHaF3U5ga
	2a2IZtsDrwyulYFdIuCnqgXimg9DRvpH6BNZrmD1ilReqWMV3/JBJX/D4zvRxh7+RTlRV1NlEZA
	qcNBpOg==
X-Google-Smtp-Source: AGHT+IGkdDZC+RExE+prPoHZuIg2VP7EK/gbvWWUQwJpe6TkHACdm1Rq8oMGE5XKDlQ4aI6cGr5m1Q==
X-Received: by 2002:a05:6602:2c8c:b0:7eb:c85b:f19b with SMTP id ca18e2360f4ac-7f13edd0004mr458718339f.7.1718833179434;
        Wed, 19 Jun 2024 14:39:39 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:212e:5310:572e:1126])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956917131sm4119193173.44.2024.06.19.14.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:39:39 -0700 (PDT)
Date: Wed, 19 Jun 2024 16:39:35 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lenb@kernel.org, mmikowski@kfocus.org, Perry.Yuan@amd.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnNQF0ussBRSAt1g@kf-XE>
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

Alright, our team has compiled and tested the patch.

Results were mixed - with my patch, both CPPC and ITMT were enabled. This
patch appears to enable only ITMT. (To be specific, running
"find /proc /sys | grep '(cppc|itmt)'" shows only ITMT enabled under
/proc, and no CPPC directories under /sys.) This causes a performance hit
in benchmarking - using my patch with 'ignore_osc_cppc_bit', we were
getting Geekbench 5 scores of at least 1907 single-core, and 10500
multi-core. With this patch, we only are getting approximately 1700
single-core, and less than 9000 multi-core. (With an entirely unpatched
kernel, we were getting less than 1000 single-core, and about 10000
multi-core.)

Ultimately this is an upgrade over unpatched performance, but a
downgrade from the previous patch. It seems having CPPC and ITMT
available at the same time made things work noticeably faster.

Is there some way that can get both CPPC and ITMT to work with an approach
like this? Our hardware does support both, it just has an incorrectly set
bit in _OSC.

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

