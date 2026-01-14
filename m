Return-Path: <linux-acpi+bounces-20330-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B4ED200A0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 17:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93A42300B03D
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EA43A1D03;
	Wed, 14 Jan 2026 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOdjlux8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049C3A1CF8
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406556; cv=none; b=jSvs3wfKhyZ6dp0o3Masv9t/MwrBSj7f3asYeYBOrFHMSLt767ZYuS4qGmNWk0DHYQGUxIQfgb6kXweIUtNJhQs37eo1DchwwTgyVrqst1gS9dtiArYdG4F1jvTbB0Pqi+XukgQXGi88VDeSJm6tJZIqtwqsXWIu7RHvpGNQ3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406556; c=relaxed/simple;
	bh=AXktR+ufjv+ZPvWBMJl3y25kMlbF4/kkzq3ciTf68sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLdvZuUHvjwd8lMyRJHrEmnxl06iiWH7PcZp8TQgY6rkvtjxqM6GMpP3dgll8eh0kDhUp1Sk8bOy1VSuBG9sYlHtcV7chZxsFdHvrqUrXSKG+/jw9g2J2LpcbAqtg5lItquH0nWKa08QOEnI2I7Ae+MAHEndreruCLje1u3y4cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOdjlux8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044E3C2BCAF
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 16:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406556;
	bh=AXktR+ufjv+ZPvWBMJl3y25kMlbF4/kkzq3ciTf68sA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hOdjlux8arlMa79v1IKqnfQQ9nP7lVnts0pHJiVD9SvJZAVrLw+y+Agy56pT7WOp7
	 IVphb8OGaTxI81gdZhFje539Cu7QUPZzBMnoJH19iAvUge0AMH9OmtHe9vZUGoxNDU
	 lK7Jjb1Ve/8Y/5kGxatNM8qyxnEX1TVVThX3flshdBTafC4Rt6Wys8qRNS2g9ycK1l
	 LbPvQWGCMgQOohEnHUAVStcK8b3+D23AIddYoPfyYBcg5f+FNkEensVZLRsubIA6FM
	 U0moCnxcHYjSRrVPuj4OnZ/XOVlJoT8tBVUHIXHliK0foWZiXOMImz4kDNwuYOW1Tp
	 dB2ow07KvkpCw==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4507605e19aso5854531b6e.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 08:02:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWixfLdv88mZlD12wua/gQ6UpTQ7bJpydpMwfuMGzfgyIIPwg3AmEXHSy8FV0eml6n3dBCtqJoZky8i@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49kvO90LWXp2W65JvfQ1wJzCv2se1yIzcgvXLY/nFhHn/ZCF/
	4ZrCOXw3Axw4ZSeCmxcM0HGNnd7zzCGQV9Dyx+57GX0RgDifCzo9VYeveF+GC/+KOwJ4QDo3vUK
	5YUt64O2vTKajugqhjy34FZR2rvi2ohc=
X-Received: by 2002:a05:6808:1798:b0:45a:6d11:9895 with SMTP id
 5614622812f47-45c715f7907mr2196996b6e.64.1768406555005; Wed, 14 Jan 2026
 08:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112032239.30023-1-xueshuai@linux.alibaba.com> <2a212d70-9752-fecb-a388-d854269a0ff9@huawei.com>
In-Reply-To: <2a212d70-9752-fecb-a388-d854269a0ff9@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 17:02:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g6eWtNahgiMuzDnPMHs2CS9Pd5TuZB=XuHkk8oqv_aeA@mail.gmail.com>
X-Gm-Features: AZwV_QgarXOy7rSgjFqFc6d7z_Wf5qeNEsyNdZo2N-xLu5H5XAlPxUp-Njj6_Gc
Message-ID: <CAJZ5v0g6eWtNahgiMuzDnPMHs2CS9Pd5TuZB=XuHkk8oqv_aeA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] ACPI: APEI: GHES: Performance improvements for
 error notification handlers
To: Hanjun Guo <guohanjun@huawei.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, mchehab@kernel.org, dolinux.peng@gmail.com, 
	yazen.ghannam@amd.com, rafael@kernel.org, dave.jiang@intel.com, 
	Smita.KoralahalliChannabasappa@amd.com, leitao@debian.org, 
	pengdonglin@xiaomi.com, baolin.wang@linux.alibaba.com, 
	benjamin.cheatham@amd.com, bp@alien8.de, dan.j.williams@intel.com, 
	james.morse@arm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhuo.song@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 12:12=E2=80=AFPM Hanjun Guo <guohanjun@huawei.com> =
wrote:
>
> On 2026/1/12 11:22, Shuai Xue wrote:
> > changes since v2:
> > - Use `guard(rcu)()` instead of explicit `rcu_read_lock()`/`rcu_read_un=
lock()` per Donglin Peng
> >
> > changes since v1:
> > - add Tested-by and Reviewed-by tags from Tony
> > - change return value from AE_BAD_ADDRESS to -EINVAL ghes_map_error_sta=
tus per Hanjun
> > - remove unnecessary blank lines per Hanjun
> >
> > This patch series improves the performance of GHES error notification h=
andlers
> > (NMI and SEA) by optimizing how they check for active error conditions.
> >
> > Currently, both ghes_notify_nmi() and ghes_notify_sea() perform expensi=
ve
> > operations on each invocation to determine if there are actual error re=
cords
> > to process. This includes mapping/unmapping physical addresses and acce=
ssing
> > hardware registers, which causes significant overhead especially on sys=
tems
> > with many cores.
> >
> > The optimizations introduced in this series:
> > 1. Pre-map error status registers during initialization
> > 2. Directly check for active errors using mapped virtual addresses
> > 3. Extract common functionality into reusable helper functions
> > 4. Apply the same optimization to both NMI and SEA handlers
> >
> > These changes significantly reduce the overhead of error checking:
> > - NMI handler: From ~15,000 TSC cycles to ~900 cycles
> > - SEA handler: From 8,138.3 ns to a much faster check
> >
> > The initial idea for this optimization came from Tony Luck [1], who ide=
ntified
> > and implemented the approach for the NMI handler. This series extends t=
he
> > same concept to the SEA handler and refactors common code into shared h=
elpers.
> >
> > Patch 1 (Tony Luck): Improves ghes_notify_nmi() status check by pre-map=
ping
> >                       error status registers and avoiding repeated mapp=
ings.
> >
> > Patch 2 (Shuai Xue): Extracts common helper functions for error status =
handling
> >                       to eliminate code duplication.
> >
> > Patch 3 (Shuai Xue): Applies the same optimization to ghes_notify_sea()=
 to improve
> >                       ARMv8 system performance.
>
> Looks good to me, and did a simple compile test on both x86 and arm64
> machine,
>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Applied as 6.20 material, thanks!

