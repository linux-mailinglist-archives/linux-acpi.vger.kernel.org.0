Return-Path: <linux-acpi+bounces-6530-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1295590F566
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 19:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9321F214B8
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F2155A5B;
	Wed, 19 Jun 2024 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="VKvGlqil"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2CE77107
	for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819092; cv=none; b=gfpP5zOFUuzXLZaNfZ/31CuzzL5t8zrSEIb9e5SbqiNyg8UwQ8Km7kUlW4he/vGmYM2BNxd1r9QqnEUlH2NBmn61w2aJ/lG3SD7MoIvyatLhCtrYjEhifQELvbMhIuM0xU7BEy0dK2CZAem/Yg6VTTKRxCtENh9WXmeHjqkeTIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819092; c=relaxed/simple;
	bh=IZ7tijwmPu33l57WSRVe8VgDgziAy2D6HGPVVYQs414=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac8esgZBcwhTShQ7fKqHIxMSsMzAtTSiXQtP3o84BaS+MVP7ONL1Z4uuUR8rScSQbwPSarLv9cm+ZLxrRdynsZpCguQqcwzQFoBJlTgbFvIeQa5+3j16MYxlcnAxQvsGWGzpAXHkoMbf08nYWX5gxHM4FEA5ikoA6GpAOEmQgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=VKvGlqil; arc=none smtp.client-ip=209.85.166.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-375fb45f465so12498725ab.1
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718819090; x=1719423890; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZDtYVjg0nuJ3RxErOrTffuUR6BB7wcDPlZ1vneeCq6A=;
        b=VKvGlqilhkG2k056wICIpGv25PntPi2ZrcyvakK2YJhljVhuZqwa8rnHwRZCja+qRz
         3SkqZnNvfAzRyWmskfkuGfrYRKTRTAJv0c0ZKIzCsqOB7BHQVXh4uOF6McqB0+03y93v
         kntRo4boIhJxOCaZ97vIhQEzX0YUZS3u2Nlc7oYifq9EnKKq8Lx9eyvtmbxpd4l1GW/9
         5ky5AGTh3jL9fNg8nEI4nqYStA0WZm+Y3rxD42ugeMhgU+b9jGLzLpbP0XICPsToqfgz
         M3D0+xGv5h8ByQH5W7tuzv0ACgRgme3YsmEkhogdwAV4TPQW2NUNf5ixPIb5SLQWPRNb
         Etxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718819090; x=1719423890;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDtYVjg0nuJ3RxErOrTffuUR6BB7wcDPlZ1vneeCq6A=;
        b=NNbxVA+BFHvT6TgGQ+3Ss8Y1E6RIfxDJbfVH1AS/PnF8woLXftJGmNu7qv1m82d5O6
         Dd2U6/WyN3iHWSffb2/GZIFVKeGO8hthN12KS/A/emghSGJEzjqsEwkVsprnRwEsN7bt
         pIoHEsyc81yM2Fw4lTgRB/revg6DBDH6U4XtsUnuXUBDA+fgBpdOl77vF3zzr/vN2LOn
         wKX9gE0dvu5dXEHTwuramLBepJmXTQUDk4+67PtVv5l7NJJb4HZrRywZYeyv/Pb2al2A
         b6zfmeQs7+xfe0KIhwsikYAlGF2ciIzR8r1E17gJGbvS1jJGkklTTOfs+YW3+H1c/DqL
         j0ag==
X-Forwarded-Encrypted: i=1; AJvYcCW0rn7Sj/myHkr/+t+VdeBhbxD5k4odHyfqIOT1ogp9lfMTtJWa3oNb2gMACax6E3Mj5CM/wTULqU1aNZQzc+IjzOsvN6xEyQdnbA==
X-Gm-Message-State: AOJu0YySksosgMGDhLvVX9w/k6ZUJsDZTG3ZtTGT+0nvmCFAMrgfhv5U
	TkhWsvA4fu1V20xhBgd7sh/vIsoWl/u7Kb1AJOF45xYca7Nhbz4ppn1HVqQiTjg=
X-Google-Smtp-Source: AGHT+IHghwTRA/pLNwd8fvXB8PLwzJQod70TgmVv4R9y44bRZgnDppfoaFGL1+0Aw4IyVJB3EzWxRA==
X-Received: by 2002:a05:6e02:1a28:b0:374:ad0f:1b00 with SMTP id e9e14a558f8ab-3761d6db618mr40455945ab.15.1718819090068;
        Wed, 19 Jun 2024 10:44:50 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:212e:5310:572e:1126])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375d8754f10sm28005335ab.67.2024.06.19.10.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:44:49 -0700 (PDT)
Date: Wed, 19 Jun 2024 12:44:47 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lenb@kernel.org, mmikowski@kfocus.org, Perry.Yuan@amd.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnMZD73P5b5CQs4W@kf-XE>
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

That could work, maybe? It modifies the code path that is being hit, but
our systems are not overclocked, and when the patch suggested earlier is
in place things "just work" when the right parameter is set, so I don't
*think* cppc_perf.highest_perf will be equal to CPPC_MAX_PERF. (I know
from https://github.com/StarLabsLtd/firmware/issues/143 that 'ret' will be
0, since cppc_get_perf_caps will error out with "ACPI CPPC: No CPC
descriptor for CPU:X", so that code path cannot be triggered in our case
unless cppc_perf.highest_pert == CPPC_MAX_PERF.)

