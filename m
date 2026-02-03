Return-Path: <linux-acpi+bounces-20833-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMjVHjbvgWlAMwMAu9opvQ
	(envelope-from <linux-acpi+bounces-20833-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 13:51:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B91FD957B
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 13:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79B813014A03
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 12:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCECB345CDA;
	Tue,  3 Feb 2026 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fibgC65F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27E3451BB
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123058; cv=none; b=mJY+ygC7NPD7SVhifMVNdk/CMv/ZxnmRNKa3yfdCCH2niN7x50qLTKgmisYPE3VgZ99Y5eW8g4XpuJYZbSEebPezO1iRxK3hTKAz4+36hBUsHjstYMUAUDIuvxB+QUOz7OdgN9OzU38C2eqvb1S8parw/2W6XgJcqB/29bprqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123058; c=relaxed/simple;
	bh=V5oUKRaNj8zfaVSK89Uwq3C3MIcd+hKDDyHLLXvhamU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQ95hAGJAHzujNnTMulkdty5Ygoj3pmOXJwP0edWsWem4bv0P5b+oeRxwsRKMY8hbbWFIVx+m2NQ+aquX/Y5X/mhtYOd8XGT/lL+geoj6rfeaJtpa1MEAK2d6n/3EiHCLL2W6AJHqVXkTUl3c36MBK+fdQuIO6vIdXE0zy5vOs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fibgC65F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79126C19425
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 12:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123058;
	bh=V5oUKRaNj8zfaVSK89Uwq3C3MIcd+hKDDyHLLXvhamU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fibgC65FCFkGvprqqOdQAumC7I3p0dI1Z+GXy+Rs2Zu/wq7s8hY5trxio7WJBL+sm
	 KZZ+Mh8eXQTzJyIjLREi+DCab9727FwILizEK6a1XZfkgXf8iVotOmN/hVPilXHn+X
	 TTG/JMLuDeOVUoK4BmS8l+XEGocJCEi0e9pGyBlZUXqN75VL5i02CUJ6vztF2//lCV
	 eDs/F1NE/2V49yAYg+o9bMwzOqxSAjHyOwSurPjOjCut0V1hClDKWklKKTPjSYlaPb
	 MEIVuzhjSEt7O9tac0J2VEfDIxYcmm11GCWvgLKsYwNWtd726yw61ZmKOhyk3YoxCI
	 AMb9BQUZVryNg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-409521ba360so3616602fac.2
        for <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2026 04:50:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrbYaD3vBNfWy20Tr9Keto0NbgdNGBnY9kdZVFOGuvHbQ9bLgokB4dVpFDfpB9Rax9re3AFe2wvUem@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30rZQAQp1RGePisbv+qhf6+3x62PoDPFGio2Y9II7JLkw/DXN
	q73Kj+w7MfxjK2n74Ldm9fiWqBu0M8L0waxaTTr/x50UejBIFo+qGjrbAglYhAo8HTSaho6C6Py
	W424l/Ghb35SpivXv/rQglTbhz067UqI=
X-Received: by 2002:a05:6870:670f:b0:3e8:44ec:3416 with SMTP id
 586e51a60fabf-409a6fa44f9mr8489886fac.46.1770123057599; Tue, 03 Feb 2026
 04:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129104817.3752340-1-sumitg@nvidia.com> <20260129104817.3752340-5-sumitg@nvidia.com>
 <CAJZ5v0gBHrGf4TpjqV+W5YynM+9_xWpepgrOiRegSYS9CvPV1g@mail.gmail.com>
In-Reply-To: <CAJZ5v0gBHrGf4TpjqV+W5YynM+9_xWpepgrOiRegSYS9CvPV1g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Feb 2026 13:50:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jUHUf_h=GA+71NyynT+Fym2ihzety4EMaTiGOkJskJHg@mail.gmail.com>
X-Gm-Features: AZwV_Qgu227UTDtr8TTkbpsEWgdQTwyBTnvvGzE1lKTt4jjfaBPdfqbnp67vyAA
Message-ID: <CAJZ5v0jUHUf_h=GA+71NyynT+Fym2ihzety4EMaTiGOkJskJHg@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, zhenglifeng1@huawei.com, 
	ionela.voinescu@arm.com, lenb@kernel.org, robert.moore@intel.com, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20833-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 1B91FD957B
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 1:43=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Thu, Jan 29, 2026 at 11:49=E2=80=AFAM Sumit Gupta <sumitg@nvidia.com> =
wrote:
> >
> > Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read an=
d
> > write the MIN_PERF and MAX_PERF registers.
> >
> > Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
> > to expose these controls to userspace. The sysfs values are in frequenc=
y
> > (kHz) for consistency with other cpufreq sysfs files.
>
> But this is not cpufreq and it is not consistent.

Scratch this, sorry for the noise.

