Return-Path: <linux-acpi+bounces-6533-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E3590F8E8
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 00:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD211F23210
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 22:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE247F476;
	Wed, 19 Jun 2024 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="CeMVbRON"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BAA7710F
	for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718835593; cv=none; b=hyiZcTnTwFL8AGwIPIwOFSx8IiCRLkXD9lXitAFefN+48D/jk8L1FtOCI3pbeCxh4HeTP5KC6nD+iCnSFUaP145MkrLAjxIIzt1f51vdAOyUGXOcTe8YXIpYNaimVkP00mDhozgcOzXJiqLT2cPd287jhd1V322QtJxyPXnjb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718835593; c=relaxed/simple;
	bh=kJRM/ELVa+gV0lUsJziOY8E6JBtM0iqhPIkpF2ZQg0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuMASMyvyTg5vlHLNOzEJ8/ZwjiyPZbkMTSPZ1aau6g3QpbBS73wCOIH0pwsPotBLUapnRW8nG3I4nA2WQ/IWyvJSPicpe6Y0foFo1Rx1UP1mkrn0rd8uxT6JeaJCyqhbuP6FBbtEWUBf/940R4RjonFSl8vDymL+WjXlnwAUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=CeMVbRON; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7ebe508fa34so8399639f.2
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718835591; x=1719440391; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KG480fQUMb/iwFPAa7yRB9qBEzUj3CMQO+rDJzrV95k=;
        b=CeMVbRONUrXH+MqZXkR/3rOlo7kBgoHm8+7QqyHlqjaeE8IYOgh24L/HqOqW9FNWSy
         +HMqSMM9qvLPsaokbk+4FBfZf43YXFRDjBpjlZFt5YWCYNEvaypszb+gxVH1NyIX2KEU
         l2bHwGCDmoCFXOXhYqAhldE+G5Kee0itaDrvkpm1yrlDCRntlkDBiDhWvZdG5UZSNj2S
         pu7INKVGgLQVvTEp1K1oQNOddMIvMcTrOOeCwDzj1/Yq5zCHXT1q8s/1BKvbYhpVrYAH
         ZZrpthOzcFzZ9KMllcTKqDKxCGgA8FAC1G1TKhPj22mP+j237Ae44fbPFyJjsRrbuhQs
         0trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718835591; x=1719440391;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KG480fQUMb/iwFPAa7yRB9qBEzUj3CMQO+rDJzrV95k=;
        b=XjAgq5/5F7CjKNph7VCx7dCUHLcnZneKe6njiKptslcqX/0GJS9ZzavU9gBpWSvjvs
         XSCPCEf8Tvte+0ZzQ+zMUd0BRhuMOATdqsoJaAg0DjPkoSItZLmQfAb4hXEmsc7ez47h
         Xx4Xwcca6F6JbAtYBFerEhyZPEazlEH6G/HA1UWJLFnCUBQRQ52aGmzunLx0duOJniCg
         cqzE6RrHtUFCGapmk4tNO/LisES3AfVnNlP/mnYQothXTciQMHo/2pKb53hbBGNfehJJ
         HWNJoh1XZG8BHKtz6qJ8l2kILvRBQww+a8I716JsD4444PWbXsQC6yyiqwj1iZuLgUCa
         unzw==
X-Forwarded-Encrypted: i=1; AJvYcCUeKBQH5vfN0X4mwOS8riSkJBlwUaZzdNIo2OufhlRJFLg7VXkHUEywo3+h1taPvARLtXwv5oBYL3wwsUsXV74H+4CPatMNew2I8g==
X-Gm-Message-State: AOJu0Yw9HVFovBvqRR6L+45foMVNpOXZlapFkBZyg2eC6O6cgNZilESP
	6aTeDGpz3YMPPvV8WKNOAq1XV/bn5Q1iGNkGahGKQ1qkmwWfECLxHzWwCSqw8AI=
X-Google-Smtp-Source: AGHT+IFCsEnPtfZ9ZgaACIlgcLgihr7oRuC2JD0KxcpPlHyXLv/9683wrKIN9qniobYT5e+BQq/kgg==
X-Received: by 2002:a05:6602:6d13:b0:7eb:5250:a54a with SMTP id ca18e2360f4ac-7f13edcf588mr470064039f.7.1718835591231;
        Wed, 19 Jun 2024 15:19:51 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:212e:5310:572e:1126])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956a4ec4dsm3997960173.158.2024.06.19.15.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 15:19:50 -0700 (PDT)
Date: Wed, 19 Jun 2024 17:19:47 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lenb@kernel.org, mmikowski@kfocus.org, Perry.Yuan@amd.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnNZgxDaXoCqkkJq@kf-XE>
References: <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnJfmUXmU_tsb9pV@kf-XE>
 <CAJZ5v0gOBH7OKF3KXwxYfWkGkC45rzDguR4VmSnoZDKpm+KPSg@mail.gmail.com>
 <12457165.O9o76ZdvQC@rjwysocki.net>
 <ZnNQF0ussBRSAt1g@kf-XE>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnNQF0ussBRSAt1g@kf-XE>

On Wed, Jun 19, 2024 at 04:39:39PM -0500, Aaron Rainbolt wrote:
> On Wed, Jun 19, 2024 at 07:30:55PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, June 19, 2024 7:09:35 PM CEST Rafael J. Wysocki wrote:
> > > On Wed, Jun 19, 2024 at 6:33 AM Aaron Rainbolt <arainbolt@kfocus.org> wrote:
> > > >
> > > > acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> > > >
> > > > The _OSC is supposed to contain a bit indicating whether the hardware
> > > > supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> > > > be considered absent. This results in severe single-core performance
> > > > issues with the EEVDF scheduler on heterogenous-core Intel processors.
> > > 
> > > While some things can be affected by this, I don't immediately see a
> > > connection between CPPC v2, Intel hybrid processors and EEVDF.
> > > 
> > > In particular, why would EEVDF alone be affected?
> > > 
> > > Care to explain this?
> > 
> > And the reason why I am asking is because I think that you really need
> > something like this (untested beyond compilation):
> 
> Alright, our team has compiled and tested the patch.
> 
> Results were mixed - with my patch, both CPPC and ITMT were enabled. This
> patch appears to enable only ITMT. (To be specific, running
> "find /proc /sys | grep '(cppc|itmt)'" shows only ITMT enabled under
> /proc, and no CPPC directories under /sys.) This causes a performance hit
> in benchmarking - using my patch with 'ignore_osc_cppc_bit', we were
> getting Geekbench 5 scores of at least 1907 single-core, and 10500
> multi-core. With this patch, we only are getting approximately 1700
> single-core, and less than 9000 multi-core. (With an entirely unpatched
> kernel, we were getting less than 1000 single-core, and about 10000
> multi-core.)
> 
> Ultimately this is an upgrade over unpatched performance, but a
> downgrade from the previous patch. It seems having CPPC and ITMT
> available at the same time made things work noticeably faster.
> 
> Is there some way that can get both CPPC and ITMT to work with an approach
> like this? Our hardware does support both, it just has an incorrectly set
> bit in _OSC.

I was premature in sending this - we reverted back to the previous patch
and are now getting similar scores to the new patch, meaning the benchmark
results may have had nothing to do with the new patch. We'll test further
and report back once we have conclusive results.
 
> > ---
> >  drivers/cpufreq/intel_pstate.c |   16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > @@ -355,16 +355,16 @@ static void intel_pstate_set_itmt_prio(i
> >  	int ret;
> >  
> >  	ret = cppc_get_perf_caps(cpu, &cppc_perf);
> > -	if (ret)
> > -		return;
> > -
> >  	/*
> > -	 * On some systems with overclocking enabled, CPPC.highest_perf is hardcoded to 0xff.
> > -	 * In this case we can't use CPPC.highest_perf to enable ITMT.
> > -	 * In this case we can look at MSR_HWP_CAPABILITIES bits [8:0] to decide.
> > +	 * If CPPC is not available, fall back to MSR_HWP_CAPABILITIES bits [8:0].
> > +	 *
> > +	 * Also, on some systems with overclocking enabled, CPPC.highest_perf is
> > +	 * hardcoded to 0xff, so CPPC.highest_perf cannot be used to enable ITMT.
> > +	 * Fall back to MSR_HWP_CAPABILITIES then too.
> >  	 */
> > -	if (cppc_perf.highest_perf == CPPC_MAX_PERF)
> > -		cppc_perf.highest_perf = HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
> > +	if (ret || cppc_perf.highest_perf == CPPC_MAX_PERF)
> > +		cppc_perf.highest_perf =
> > +			HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
> >  
> >  	/*
> >  	 * The priorities can be set regardless of whether or not
> > 
> > 
> > 

