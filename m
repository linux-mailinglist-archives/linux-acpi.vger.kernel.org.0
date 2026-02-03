Return-Path: <linux-acpi+bounces-20840-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJRPMaJZgmliSwMAu9opvQ
	(envelope-from <linux-acpi+bounces-20840-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 21:25:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCC6DE767
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 21:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9917A3038F20
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 20:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABAC36D51E;
	Tue,  3 Feb 2026 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUsGp35S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CC936D4FC
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150302; cv=none; b=kIHOO5msmZqWD+8sGk3S79LlloUNkGalC7Wo+3CYNV/y3h8ZqDTSOhWC/GWm3OaRbkgk8M9/vizp0RfE6qJLKxdENBA4ZB/zVwWk/MjLHvV2eVEhzPbI/CVOTsbv113C0GPhI/j00YKmCdun4eiFzMwtUdF2hjFgDew2Z0XlMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150302; c=relaxed/simple;
	bh=BTjXD26SYyc+9FHq9itXaZBWEZ5WY9RIwmpBHoxp8hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNgFwKleunPqsljOSdFgbOHkX98J/DqHgPCScmcoyCMvQpivBTvg+GOYX6Y5uc3o6Cuk2wgcFOAgrgbK2mcDPv+Ah/WPu465rTbNg5BhIs7cx8QTG8kGnTH4pajw8+3W1cVzI8R9OQ/FuQa43a9160trbeOXCWSo8CORgl1SALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUsGp35S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536FBC2BCB2
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 20:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770150302;
	bh=BTjXD26SYyc+9FHq9itXaZBWEZ5WY9RIwmpBHoxp8hU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GUsGp35Sih8cc0hh9rnacnQMEoFDWdpsvnIBcCFeBHdBBqAQPw+YTr2jjbfYVaO+h
	 J/bK73vgxdViQE6PON0ys/JULJi5X4bGSWwF5zKnX3ug8S87ROi5PEZh5RNi+fMCn/
	 r8W7Nw4dzs93zCnKROoHmLncCE4KuZ6mZdbDBDAt7Pd5N8HUzBuZM53SwlIxD5LaZh
	 dSowLOD7wEcpubBwWnWssw4nxf6KFtfPnZYgSan+qXuXSa9vWBzKy+IUy+kixMIqyI
	 pA1S9YAWQNlT5cabsw2sWf5MfzrxAfNxNiRXbXpVmtSCXY6vO+RyjAltUCKGB+N3RF
	 8H5SFKwKvUESg==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45c733ccc32so3839751b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2026 12:25:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXG8z/aIN7hW3Pu2X7bp+wpe4/NuTKQ4kRnhzBmwrVy0tDmwhuJHtQG2lowcfEYTJC3aVeWFdkyQQDv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Ru5LnfOaj/T/he/nJ5gZHtnmj13Rv42yZgVmZLo8e/e+fUQn
	tBDO9sj4H9pB58C+jR1LSx2HGmSjXSsAH6JL6qso3JM5objVnfJ9EIQiMB5mkrfh1kaL4u3LHda
	t7G0llQOhySSR6yo9a0pfNVw0TpsARgk=
X-Received: by 2002:a05:6808:1905:b0:45c:8bc0:fcdf with SMTP id
 5614622812f47-462d588335bmr361499b6e.10.1770150301081; Tue, 03 Feb 2026
 12:25:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129104817.3752340-1-sumitg@nvidia.com> <20260129104817.3752340-5-sumitg@nvidia.com>
 <4432fa04-e67c-422a-aae4-2938be431985@huawei.com> <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
 <74f3e6cf-7c13-43e6-a8f6-2b46184b8ad6@gmail.com> <944fc140-e5c5-425f-a6ad-883e87eed8a3@nvidia.com>
 <CAJZ5v0hUdLsh8UK5G6rHHD49RQGYLAiU1J-11DK-fLTKnuqhUQ@mail.gmail.com>
 <CAJZ5v0ggzD0PEti-r20Sm-8n0gPigPh=NgE2Oa=UKzMmwB0jpw@mail.gmail.com> <211d9dfa-26e6-4fc3-b70b-f5fbca49e5fd@nvidia.com>
In-Reply-To: <211d9dfa-26e6-4fc3-b70b-f5fbca49e5fd@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Feb 2026 21:24:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0if=tMiyLB-efkzB67SniJS-2pCVv1-eN+vzZxqrdAM8Q@mail.gmail.com>
X-Gm-Features: AZwV_QjXaHsQZ2uAWLZvX1hT_RYnLifph_oQl3U2gGF9mLZZdm4jux8kCljAbGs
Message-ID: <CAJZ5v0if=tMiyLB-efkzB67SniJS-2pCVv1-eN+vzZxqrdAM8Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Russell Haley <yumpusamongus@gmail.com>, 
	"zhenglifeng (A)" <zhenglifeng1@huawei.com>, pierre.gondois@arm.com, viresh.kumar@linaro.org, 
	ionela.voinescu@arm.com, corbet@lwn.net, rdunlap@infradead.org, 
	ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com, 
	perry.yuan@amd.com, zhanjie9@hisilicon.com, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	nhartman@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20840-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,huawei.com,arm.com,linaro.org,lwn.net,infradead.org,amd.com,hisilicon.com,vger.kernel.org,lists.linux.dev,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 7CCC6DE767
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 3:32=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wrot=
e:
>
>
> On 03/02/26 18:24, Rafael J. Wysocki wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Feb 3, 2026 at 1:45=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >> On Tue, Feb 3, 2026 at 10:41=E2=80=AFAM Sumit Gupta <sumitg@nvidia.com=
> wrote:
> >>>>>> Hi Sumit,
> >>>>>>
> >>>>>> I am thinking that maybe it is better to call these two sysfs inte=
rface
> >>>>>> 'min_freq' and 'max_freq' as users read and write khz instead of r=
aw
> >>>>>> value.
> >>>>> Thanks for the suggestion.
> >>>>> Kept min_perf/max_perf to match the CPPC register names
> >>>>> (MIN_PERF/MAX_PERF), making it clear to users familiar with
> >>>>> CPPC what's being controlled.
> >>>>> The kHz unit is documented in the ABI.
> >>>>>
> >>>>> Thank you,
> >>>>> Sumit Gupta
> >>>> On my x86 machine with kernel 6.18.5, the kernel is exposing raw val=
ues:
> >>>>
> >>>>> grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
> >>>> /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:34290401885=
6568
> >>>> del:437439724183386
> >>>> /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
> >>>> /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:88
> >>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
> >>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
> >>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
> >>>> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
> >>>> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
> >>>> /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
> >>>> /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:1844674407370=
9551615
> >>>>
> >>>> It would be surprising for a nearby sysfs interface with very simila=
r
> >>>> names to use kHz instead.
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Russell Haley
> >>> I can rename to either of the below:
> >>> - min/max_freq: might be confused with scaling_min/max_freq.
> >>> - min/max_perf_freq: keeps the CPPC register association clear.
> >>>
> >>> Rafael, Any preferences here?
> >> On x86 the units in CPPC are not kHz and there is no easy reliable way
> >> to convert them to kHz.
> >>
> >> Everything under /sys/devices/system/cpu/cpu0/acpi_cppc/ needs to be
> >> in CPPC units, not kHz (unless, of course, kHz are CPPC units).
>
>
> In v1 [1], these controls were added under acpi_cppc sysfs.
> After discussion, they were moved under cpufreq, and [2] was merged first=
.
> The decision to use frequency scale instead of raw perf was made
> for consistency with other cpufreq interfaces as per (v3 [3]).
>
> CPPC units in our case are also not in kHz. The kHz conversion uses the
> existing cppc_perf_to_khz()/cppc_khz_to_perf() helpers which are already
> used in cppc_cpufreq attributes. So the conversion behavior is consistent
> with existing cpufreq interfaces.
>
> [1]
> https://lore.kernel.org/lkml/076c199c-a081-4a7f-956c-f395f4d5e156@nvidia.=
com/
> [2]
> https://lore.kernel.org/all/20250507031941.2812701-1-zhenglifeng1@huawei.=
com/
> [3]
> https://lore.kernel.org/lkml/80e16de0-63e4-4ead-9577-4ebba9b1a02d@nvidia.=
com/
>
> > That said, the new attributes will show up elsewhere.
> >
> > So why do you need to add these things in the first place?
>
> Currently there's no sysfs interface to dynamically control the
> MIN_PERF/MAX_PERF bounds when using autonomous mode. This helps
> users tune power and performance at runtime.

So what about scaling_min_freq and scaling_max_freq?

intel_pstate uses them for an analogous purpose.

