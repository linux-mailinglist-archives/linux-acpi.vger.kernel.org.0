Return-Path: <linux-acpi+bounces-20832-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN53IuXtgWkFMAMAu9opvQ
	(envelope-from <linux-acpi+bounces-20832-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 13:45:25 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D4ED9394
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 13:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C349E3064675
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F6E3451DC;
	Tue,  3 Feb 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaRNbUqh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35EE344DA1
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122722; cv=none; b=lLk43O93R43YgmDUOVkJrLDZF0opNtdCseZpsPF8anRQnk77cvpoYjUq3rb8EhTV4ZukSMndbiC9cW8bwXIVaPsmTspIHvJedrnSIYSiAKeow5QISaxGultkSNXLXrVEJvzFjaJbDAFB4H1alPawEpLrZn1GFxZRQanuqvqamkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122722; c=relaxed/simple;
	bh=+82RPlBYDQHhn4O86HZF3vxIxA0tssEvTGqVmKABwno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNmon03aOJYMqO9FzLnznYK1cLOKbki8JEGAXujud4x+EbyGH/MgrZvYnxQ/ve2k+rrup17zJbSH4tl99p65KmbTYhC/nJ+p0vi/YwtI1Nn18XBkGl2Jr/7Zz0r9KMBh7V3gLjYOz/z2K86gkuuQ+zHOWCzBsyJo+3KBWpAQOfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaRNbUqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876DBC2BCC4
	for <linux-acpi@vger.kernel.org>; Tue,  3 Feb 2026 12:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770122722;
	bh=+82RPlBYDQHhn4O86HZF3vxIxA0tssEvTGqVmKABwno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XaRNbUqhYPj9cmZVqJT5P2uwkLY63Aw+AvlTDvf1dX1N7qUvhpe5bWNNL48dHXQdK
	 wf2L5f/VPg+pzhbJ0B7VRiHnNqhbiEp/btQuZHCssCBkWp1atTb9VVzP+ebDquGSSx
	 FpYo8kb8c3KojUfnJut/npM8Fe2nMxBtJAXzcWVjFLkHY5aVKD7/lzb5eHRPQZ7sKh
	 7/XK8NTOHvHcYOCXGBArCR/fwqgrH8gv0WX7XBNp4oPZcBRn2KCYnX4Jq7kDItyXy4
	 dfUkQ/WTAmTdIqUbd1yFohu9VgOFxuyYfA8g8PhnRgH9oWQ/xhm9Ib2wqFLJmtkRLx
	 f1AV/RcQQElGQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d1890f7ee4so3422680a34.0
        for <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2026 04:45:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUelMNhVj1fOy9YpE4JkUppTSq30V4QXoVaiiA+1UrsvfLKOoya8nD683zpQBsue63icjVoNib7LWES@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyz+X5lyoiH2z8Wif6C/AdwR9jp5iHWrR3jChHNcq04PkegGHT
	cq/DVwNcJ79bpN9YBrwN5q+HMA9Vtln3yDZj/veGvQkpdmfBndLixMofiQkKwh5lW3X1vR8IkBE
	QW6BHP6SxjFdef1pm7xP9uZy4YU6l8YU=
X-Received: by 2002:a05:6820:623:b0:662:ffc5:cedc with SMTP id
 006d021491bc7-6630f01c0a5mr5982202eaf.1.1770122721539; Tue, 03 Feb 2026
 04:45:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129104817.3752340-1-sumitg@nvidia.com> <20260129104817.3752340-5-sumitg@nvidia.com>
 <4432fa04-e67c-422a-aae4-2938be431985@huawei.com> <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
 <74f3e6cf-7c13-43e6-a8f6-2b46184b8ad6@gmail.com> <944fc140-e5c5-425f-a6ad-883e87eed8a3@nvidia.com>
In-Reply-To: <944fc140-e5c5-425f-a6ad-883e87eed8a3@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Feb 2026 13:45:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hUdLsh8UK5G6rHHD49RQGYLAiU1J-11DK-fLTKnuqhUQ@mail.gmail.com>
X-Gm-Features: AZwV_QhB065_tKI7QjTUgxYReeYNGWgeu7zDKGuhRbpPyUYQlroYk6sWK9959V4
Message-ID: <CAJZ5v0hUdLsh8UK5G6rHHD49RQGYLAiU1J-11DK-fLTKnuqhUQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>
Cc: Russell Haley <yumpusamongus@gmail.com>, "zhenglifeng (A)" <zhenglifeng1@huawei.com>, 
	pierre.gondois@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, 
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20832-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,arm.com,kernel.org,linaro.org,intel.com,lwn.net,infradead.org,amd.com,hisilicon.com,vger.kernel.org,lists.linux.dev,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 08D4ED9394
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 10:41=E2=80=AFAM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
> >>> Hi Sumit,
> >>>
> >>> I am thinking that maybe it is better to call these two sysfs interfa=
ce
> >>> 'min_freq' and 'max_freq' as users read and write khz instead of raw
> >>> value.
> >> Thanks for the suggestion.
> >> Kept min_perf/max_perf to match the CPPC register names
> >> (MIN_PERF/MAX_PERF), making it clear to users familiar with
> >> CPPC what's being controlled.
> >> The kHz unit is documented in the ABI.
> >>
> >> Thank you,
> >> Sumit Gupta
> > On my x86 machine with kernel 6.18.5, the kernel is exposing raw values=
:
> >
> >> grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
> > /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:34290401885656=
8
> > del:437439724183386
> > /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
> > /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:88
> > /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
> > /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
> > /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
> > /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
> > /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
> > /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
> > /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:1844674407370955=
1615
> >
> > It would be surprising for a nearby sysfs interface with very similar
> > names to use kHz instead.
> >
> > Thanks,
> >
> > Russell Haley
>
> I can rename to either of the below:
> - min/max_freq: might be confused with scaling_min/max_freq.
> - min/max_perf_freq: keeps the CPPC register association clear.
>
> Rafael, Any preferences here?

On x86 the units in CPPC are not kHz and there is no easy reliable way
to convert them to kHz.

Everything under /sys/devices/system/cpu/cpu0/acpi_cppc/ needs to be
in CPPC units, not kHz (unless, of course, kHz are CPPC units).

