Return-Path: <linux-acpi+bounces-20834-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM/jGA3wgWlAMwMAu9opvQ
	(envelope-from <linux-acpi+bounces-20834-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 13:54:37 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FD2D966E
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 13:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EEFB30185FE
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9D5346A04;
	Tue,  3 Feb 2026 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku549Ong"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC027057D
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123273; cv=none; b=Tc6Dz4w6caVgNIZzQxSd7ENmJCNwKg9S1D9uXDovwfsJQwJvxNV08qYB1SbIOzjUeW1pX2lPsv7jyXCw/rbFEK6I0KijaGNcd+N1i1iVHzfLl/Hf96tFILG096ONu6KYC7Ne8Wk+8QbVZFI68j92tmFdhQjV6xembFPi5//gBw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123273; c=relaxed/simple;
	bh=Co1W0er3qP2bsTr8wPseHkrGqCiTC9H5dT9ACv1yd+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adJf8S/hg0ml3iamPc87NXdYt4jea4rkZVoOpC32Tp0+IcGgZudw9Zzb0XCPr3oAq+UA0z4DfN/x8UfV94Ff1VvOdJ2NiiMNFgfhESGC4ZxY3Ioztk2EqDibPFekEO6mzgVeF7dxaSqobDGhp1SNcyu8hmKAIU0nr6fQSFjOeww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku549Ong; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06BBC2BCAF
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 12:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123273;
	bh=Co1W0er3qP2bsTr8wPseHkrGqCiTC9H5dT9ACv1yd+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ku549OngG5aewt0GX7ihKyFwEpeePOrvb7ZmXxr1V0w1j7tC3sHxyuclFX0Jox4i+
	 KQiXEuoebiuqitH3YQdeUCWob4Xz+i1bIgbD0IKzwE+0sjE72BmBpFDy6xwdLO/WIa
	 dZVWtp65+6i/xQ46FGeb9K3d8b9hof0WB3wQB9d9y7Z+iCym5QJbHd206GSPW5Qm3t
	 AHjOj8AtoltlePNKefpZB51SAptkJ5lGwZFpKbOnruSDD5osi9nIN9Iu0W3bleJv/W
	 Ig5TNepoptYzVIgyvG9AzeIA0neWWnUmnthOy7GbtAdSC4D9uG7DGL2mst0JY2HC/b
	 lifVQTCWntaZg==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-45f053b7b90so3653244b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2026 04:54:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6r21nBAdP9aa6edcHSw66Z6upaJzzVa88ZMXooNmh4dkvzHrRUi4Kb6XWo2QN5RxuJrfvd1DPnRzk@vger.kernel.org
X-Gm-Message-State: AOJu0YzVBsdnwPQmFXXhDz1DwHYJluFTeySaDqBHdgkF6ST2TU+9Frj9
	PIDuzWFJKYFHDoz0XqtMMjgEIV2N6itU5E1i5p07pgx8ZsTur/viv0G60nfxvPUKDeXBxFIVqyu
	bwaWrHT/AJyEWabatHwhM+QenF+E/s4s=
X-Received: by 2002:a05:6808:1a19:b0:45e:e52c:8a9b with SMTP id
 5614622812f47-45f34d98b5amr6423692b6e.59.1770123272793; Tue, 03 Feb 2026
 04:54:32 -0800 (PST)
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
In-Reply-To: <CAJZ5v0hUdLsh8UK5G6rHHD49RQGYLAiU1J-11DK-fLTKnuqhUQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Feb 2026 13:54:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ggzD0PEti-r20Sm-8n0gPigPh=NgE2Oa=UKzMmwB0jpw@mail.gmail.com>
X-Gm-Features: AZwV_Qh2_C6NzL0YjzuEvp_eyYEIiFinRoaSQUx14OPXT8iJZ6DvXYU6oH3FyWA
Message-ID: <CAJZ5v0ggzD0PEti-r20Sm-8n0gPigPh=NgE2Oa=UKzMmwB0jpw@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>
Cc: Russell Haley <yumpusamongus@gmail.com>, "zhenglifeng (A)" <zhenglifeng1@huawei.com>, 
	pierre.gondois@arm.com, viresh.kumar@linaro.org, ionela.voinescu@arm.com, 
	corbet@lwn.net, rdunlap@infradead.org, ray.huang@amd.com, 
	gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com, 
	zhanjie9@hisilicon.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20834-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,arm.com,linaro.org,lwn.net,infradead.org,amd.com,hisilicon.com,vger.kernel.org,lists.linux.dev,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 06FD2D966E
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 1:45=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Tue, Feb 3, 2026 at 10:41=E2=80=AFAM Sumit Gupta <sumitg@nvidia.com> w=
rote:
> >
> > >>> Hi Sumit,
> > >>>
> > >>> I am thinking that maybe it is better to call these two sysfs inter=
face
> > >>> 'min_freq' and 'max_freq' as users read and write khz instead of ra=
w
> > >>> value.
> > >> Thanks for the suggestion.
> > >> Kept min_perf/max_perf to match the CPPC register names
> > >> (MIN_PERF/MAX_PERF), making it clear to users familiar with
> > >> CPPC what's being controlled.
> > >> The kHz unit is documented in the ABI.
> > >>
> > >> Thank you,
> > >> Sumit Gupta
> > > On my x86 machine with kernel 6.18.5, the kernel is exposing raw valu=
es:
> > >
> > >> grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:342904018856=
568
> > > del:437439724183386
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:88
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709=
551615
> > >
> > > It would be surprising for a nearby sysfs interface with very similar
> > > names to use kHz instead.
> > >
> > > Thanks,
> > >
> > > Russell Haley
> >
> > I can rename to either of the below:
> > - min/max_freq: might be confused with scaling_min/max_freq.
> > - min/max_perf_freq: keeps the CPPC register association clear.
> >
> > Rafael, Any preferences here?
>
> On x86 the units in CPPC are not kHz and there is no easy reliable way
> to convert them to kHz.
>
> Everything under /sys/devices/system/cpu/cpu0/acpi_cppc/ needs to be
> in CPPC units, not kHz (unless, of course, kHz are CPPC units).

That said, the new attributes will show up elsewhere.

So why do you need to add these things in the first place?

