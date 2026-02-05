Return-Path: <linux-acpi+bounces-20869-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JkXHTvvhGkU6wMAu9opvQ
	(envelope-from <linux-acpi+bounces-20869-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 20:27:55 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC4BF6D84
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 20:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2B23301F4AB
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Feb 2026 19:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0218B3271E3;
	Thu,  5 Feb 2026 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swl6Bhwm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347932694C
	for <linux-acpi@vger.kernel.org>; Thu,  5 Feb 2026 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319661; cv=none; b=g5DblXo19i0Vtx0ks+hLPRP68tyN5y9Dct+pxVrkIvYedT9ZHEj+5DaCIW7TAapgmiuOl6hoaFb7YN0N7EBCDuLnT68YHOIIJtPzbg2utXiTXcKjb/v1yclryVr1cEpddpKvcrnCtqIysux9byqxTcMoiLjJThOgPzirmf2GRwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319661; c=relaxed/simple;
	bh=lVqH9YXUENR1THUynMSza+9sAUW6necQO2XQfXpawAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwxJ7LopTXcMXefydxBirWoIz9p60YwAfmu8VM2NGti+dj3p75SOWWwxn9jOAN7InUC0hy8PGO8CdgzdtmGFpFsqMzZqkJo8SxrWdNecwW20+k+/vGcWCsM4yixKaQcj/rdLSU6lKNGz6HJc9sbZYPY3YZ8zdcMvBnIbal9DeXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Swl6Bhwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7CAC2BCB3
	for <linux-acpi@vger.kernel.org>; Thu,  5 Feb 2026 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770319661;
	bh=lVqH9YXUENR1THUynMSza+9sAUW6necQO2XQfXpawAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Swl6Bhwm61In1+nItp1x7MaE5aIHKD1M0B8TgOGljboJRPxhQaKAnL6ptkSQ8GimH
	 2eYkMNQobZ8NhGphqW8y/QLZBx1zJnEnnQocdmRBzbl5fmCihrm1Txusbgz7OYleWK
	 5AiHzQQqOREwWy3PSqJQGA16W2LPoHaGEpCa9KdrBdYAil8LPwzIQZzBgXLBK+cAbp
	 0KQQ54mc1ef/JWMTkkMoTXz7M0cnoCkSl86oSjf0P2h3SRz/DO/feMDG9wmFHgWMVt
	 RgmtVo1qjE+8qpWKqG72RUX7Slj8xQ+ADOHRl/DyOOLHHyOvoTyHG4Vdn9oFmKEgMz
	 oMF9sVU/GdEAw==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d122733808so563327a34.2
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2026 11:27:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW772HX3mt8k7OdvIeSMm5c1K04dRh5Bu1UrLZYeq/ADZKjqCeQjNLVEpFCBdCTyczoWOd5bKGynNDJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwcoZUPKNwSGt+0dKafoEqCOjVS4ovWV0Z53+wMi+YmSeHrMSDf
	aUstMSo2DG6wBXIUQCeOKBhRCUj70PH2uOQrV6ASauUBqnvF6jGGf5RkJBTerLm6XW9X5k+rTga
	ydKhInYbYdkRzIOenADmvqf3JbnIpvdQ=
X-Received: by 2002:a05:6830:828e:b0:7c5:3c7d:7e65 with SMTP id
 46e09a7af769-7d4644296ebmr58017a34.16.1770319660609; Thu, 05 Feb 2026
 11:27:40 -0800 (PST)
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
 <CAJZ5v0ggzD0PEti-r20Sm-8n0gPigPh=NgE2Oa=UKzMmwB0jpw@mail.gmail.com>
 <211d9dfa-26e6-4fc3-b70b-f5fbca49e5fd@nvidia.com> <CAJZ5v0if=tMiyLB-efkzB67SniJS-2pCVv1-eN+vzZxqrdAM8Q@mail.gmail.com>
 <e7570bc3-5420-4743-8a75-8602559ca235@amd.com> <b8603fcb-b0ab-47da-ae90-e82f7b9bcd67@nvidia.com>
 <CAJZ5v0h4yOAW5y-B76EooeBLdMBmmL1hRf3PZ0udA+FYR4EPKQ@mail.gmail.com> <a1cdc4ee-1aaa-4685-b1a9-a6961a486cd8@nvidia.com>
In-Reply-To: <a1cdc4ee-1aaa-4685-b1a9-a6961a486cd8@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Feb 2026 20:27:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jCT5exCOz1gmHN+gXaamn-W0Yg0g8KN77vB5tUmsGFOw@mail.gmail.com>
X-Gm-Features: AZwV_QjYbWmk9CpFs4_fQbMfpghyGM5juCTPanm_jBC_7JecsACmsCoO-gdsJcQ
Message-ID: <CAJZ5v0jCT5exCOz1gmHN+gXaamn-W0Yg0g8KN77vB5tUmsGFOw@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Russell Haley <yumpusamongus@gmail.com>, "zhenglifeng (A)" <zhenglifeng1@huawei.com>, 
	pierre.gondois@arm.com, viresh.kumar@linaro.org, ionela.voinescu@arm.com, 
	corbet@lwn.net, rdunlap@infradead.org, ray.huang@amd.com, 
	gautham.shenoy@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, treding@nvidia.com, 
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com, 
	sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20869-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,amd.com,gmail.com,huawei.com,arm.com,linaro.org,lwn.net,infradead.org,hisilicon.com,vger.kernel.org,lists.linux.dev,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CAC4BF6D84
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 8:21=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wrot=
e:
>
> >>>>>>>>>>> Hi Sumit,
> >>>>>>>>>>>
> >>>>>>>>>>> I am thinking that maybe it is better to call these two sysfs
> >>>>>>>>>>> interface
> >>>>>>>>>>> 'min_freq' and 'max_freq' as users read and write khz instead
> >>>>>>>>>>> of raw
> >>>>>>>>>>> value.
> >>>>>>>>>> Thanks for the suggestion.
> >>>>>>>>>> Kept min_perf/max_perf to match the CPPC register names
> >>>>>>>>>> (MIN_PERF/MAX_PERF), making it clear to users familiar with
> >>>>>>>>>> CPPC what's being controlled.
> >>>>>>>>>> The kHz unit is documented in the ABI.
> >>>>>>>>>>
> >>>>>>>>>> Thank you,
> >>>>>>>>>> Sumit Gupta
> >>>>>>>>> On my x86 machine with kernel 6.18.5, the kernel is exposing ra=
w
> >>>>>>>>> values:
> >>>>>>>>>
> >>>>>>>>>> grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
> >>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:342904=
018856568
> >>>>>>>>>
> >>>>>>>>> del:437439724183386
> >>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
> >>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:88
> >>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
> >>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
> >>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
> >>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
> >>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
> >>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
> >>>>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744=
073709551615
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> It would be surprising for a nearby sysfs interface with very
> >>>>>>>>> similar
> >>>>>>>>> names to use kHz instead.
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>>
> >>>>>>>>> Russell Haley
> >>>>>>>> I can rename to either of the below:
> >>>>>>>> - min/max_freq: might be confused with scaling_min/max_freq.
> >>>>>>>> - min/max_perf_freq: keeps the CPPC register association clear.
> >>>>>>>>
> >>>>>>>> Rafael, Any preferences here?
> >>>>>>> On x86 the units in CPPC are not kHz and there is no easy reliabl=
e
> >>>>>>> way
> >>>>>>> to convert them to kHz.
> >>>>>>>
> >>>>>>> Everything under /sys/devices/system/cpu/cpu0/acpi_cppc/ needs to=
 be
> >>>>>>> in CPPC units, not kHz (unless, of course, kHz are CPPC units).
> >>>>>
> >>>>> In v1 [1], these controls were added under acpi_cppc sysfs.
> >>>>> After discussion, they were moved under cpufreq, and [2] was merged
> >>>>> first.
> >>>>> The decision to use frequency scale instead of raw perf was made
> >>>>> for consistency with other cpufreq interfaces as per (v3 [3]).
> >>>>>
> >>>>> CPPC units in our case are also not in kHz. The kHz conversion uses=
 the
> >>>>> existing cppc_perf_to_khz()/cppc_khz_to_perf() helpers which are
> >>>>> already
> >>>>> used in cppc_cpufreq attributes. So the conversion behavior is
> >>>>> consistent
> >>>>> with existing cpufreq interfaces.
> >>>>>
> >>>>> [1]
> >>>>> https://lore.kernel.org/lkml/076c199c-a081-4a7f-956c-f395f4d5e156@n=
vidia.com/
> >>>>>
> >>>>> [2]
> >>>>> https://lore.kernel.org/all/20250507031941.2812701-1-zhenglifeng1@h=
uawei.com/
> >>>>>
> >>>>> [3]
> >>>>> https://lore.kernel.org/lkml/80e16de0-63e4-4ead-9577-4ebba9b1a02d@n=
vidia.com/
> >>>>>
> >>>>>
> >>>>>> That said, the new attributes will show up elsewhere.
> >>>>>>
> >>>>>> So why do you need to add these things in the first place?
> >>>>> Currently there's no sysfs interface to dynamically control the
> >>>>> MIN_PERF/MAX_PERF bounds when using autonomous mode. This helps
> >>>>> users tune power and performance at runtime.
> >>>> So what about scaling_min_freq and scaling_max_freq?
> >>>>
> >>>> intel_pstate uses them for an analogous purpose.
> >>> FWIW same thing for amd_pstate.
> >>>
> >> intel_pstate and amd_pstate seem to use setpolicy() to update
> >> scaling_min/max_freq and program MIN_PERF/MAX_PERF.
> > That's one possibility.
> >
> > intel_pstate has a "cpufreq-compatible" mode (in which case it is
> > called intel_cpufreq) and still uses HWP (which is the underlying
> > mechanism for CPPC on Intel platforms).
> >
> >> However, as discussed in v5 [1], cppc_cpufreq cannot switch to
> >> a setpolicy based approach because:
> >> - We need per-CPU control of auto_sel: With setpolicy, we can't
> >>     dynamically disable auto_sel for individual CPUs and return to the
> >>     target() (no target hook available).
> >>     intel_pstate and amd_pstate seem to set HW autonomous mode for
> >>     all CPUs, not per-CPU.
> >> - We need to retain the target() callback - the CPPC spec allows
> >>     desired_perf to be used even when autonomous selection is enabled.
> > intel_pstate in the "cpufreq-compatible" mode updates its HWP min and
> > max limits when .target() (or .fast_switch() or .adjust_perf()) is
> > called.
> >
> > I guess that would not be sufficient in cppc_cpufreq for some reason?
> >
> >> [1]
> >> https://lore.kernel.org/lkml/66f58f43-631b-40a0-8d42-4e90cd24b757@arm.=
com/
>
> We can do the same as intel_cpufreq. CPPC spec allows setting
> MIN_PERF/MAX_PERF even when auto_selection is disabled, so we will
> have to update them always from policy limits in target().
>
> However, this would override BIOS-configured MIN_PERF/MAX_PERF values.
> Since policy->min/max are set from hardware capabilities during init,
> any governor would overwrite BIOS bounds with policy limits (hardware
> capability bounds) on their first frequency request - even when user
> hasn't explicitly changed scaling_min/max_freq.
>
> Does intel_cpufreq also override BIOS-configured HWP min/max values?

Yes, it does.

> Should we preserve BIOS-configured values until user explicitly changes
> scaling_min/max_freq?

Why would that be useful?

> Is there any mechanism in cpufreq core to detect explicit user changes to=
 scaling_min/max_freq?

Not today, but since scaling_min/max_freq have their own freq QoS
requests, it should be doable if need be.

In any case, I would very much prefer using the existing
scaling_min/max_freq interface, even if that would require some
additional plumbing, to adding new sysfs attributes pretty much for
the same purpose that would only be used by one driver.

