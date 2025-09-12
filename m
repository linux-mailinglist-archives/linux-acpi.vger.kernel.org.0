Return-Path: <linux-acpi+bounces-16701-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D53FB5464D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 11:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC93189468D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73AA27A92F;
	Fri, 12 Sep 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPBHNmrd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B076276028;
	Fri, 12 Sep 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667564; cv=none; b=O7E8xC0y0fjWvG+X/U4Fg7Yt0t/OpYu7VTbSdCF2W5BWkTX7pjnXjqnK76UKqTy58NiU6ZzteJv/TgzTUeNW7V0LzRyYP8n8IouJgDDlbkxhXcijWqzotjMAsnKgZbdEjwwGCh4F+/pDYqj2ehF1lKpGUaYjJXXIowDBKowgs8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667564; c=relaxed/simple;
	bh=T1coyMeV9iN8hoV6MthKaTMIgaPUm4XsdaRfs4UcZSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbtNA8yPDBoW0REuVCpvLc1piEA0bZjbp1qRaps+G6x+2chU5ecxijBL2PeRl05jw4MTZsihQ00sd5ixoiG+E74Th2EIkzc3JGPLRBhkutZCOcY8nUmUu0RfukcKNaISKwV/Oa29HUGuJLUZO68vECu60YVQdSaZRNplW7YMK9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPBHNmrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3711C4CEF1;
	Fri, 12 Sep 2025 08:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757667564;
	bh=T1coyMeV9iN8hoV6MthKaTMIgaPUm4XsdaRfs4UcZSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oPBHNmrd6KwaWO/WvKaH/rkKXkhtkBqt1Nw56tHijMzDqnDWb3HrTLAaXYlO+qYQT
	 nbYqOA5+VFOUf9FrgXs4WTrizhVjuzd+TRClYtH3NBj1+0EyD2k2PDRHUzDLL1Hq5S
	 RH1hsLWTTY4Bb9dt+REoWCxbzrpinbBWgTudjC1GDOMeX0EBVxQ/YMgNOXSVlMFfnl
	 1Z1vUraycgNLWVEXvvzupiL1M/MUedtVvG06ZPUDmzwRXtosJdfu07tu1/8oBbD7Lt
	 64a1aki+LPdF9He9PKupXrfQv7+n7+Jo3bOnOMwFTIdcRJzAgu7YLr7s5uTftYzkqG
	 tHe8VwBuV+wGg==
Message-ID: <17cc74d6-2e49-4370-ae37-39cddfe67d7d@kernel.org>
Date: Fri, 12 Sep 2025 10:59:21 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: video: Fix missing backlight node creation on
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, rafael@kernel.org,
 stable@vger.kernel.org
References: <de4b5ec6-1e42-44b8-b5d3-5a452d7401ef@kernel.org>
 <20250911074543.106620-1-zhangzihuan@kylinos.cn>
 <ae7b139f-dc25-413d-bfc3-3be187ab3a73@kernel.org>
 <365c42f5-56a1-4a2c-9244-7943c3600fa2@kylinos.cn>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <365c42f5-56a1-4a2c-9244-7943c3600fa2@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 12-Sep-25 3:11 AM, Zihuan Zhang wrote:
> 
> 在 2025/9/11 18:38, Hans de Goede 写道:
>> Hi Zihuan,
>>
>> On 11-Sep-25 9:45 AM,  Zhang wrote:

...

>>> Also, on kernel 5.4 these machines seem to work fine without requiring a native GPU driver, while on 6.6+ the backlight node is missing.
>>> Could you please clarify what design change or intention caused this behavioral difference between 5.4 and newer kernels?

...

>> Long story short: The design goal is to only
>> register 1 backlight handler, so that userspace
>> does not has to guess and to only register this
>> once and not do a register + unregister dance
>> of a potentially unwanted acpi_video backlight.
> 
> Thank you for the very detailed explanation!

You're welcome.

> One concern, however, is that the current approach seems to assume the presence of a GPU driver, which may not always be the case. Would it be possible to consider a more generic fallback?

Well x86/ACPI laptops without a GPU are not really
something which exists anymore. A GPU is a must have
for a good user experience with modern OS-es.

And now a days we have in kernel drivers for all main
GPU vendors.

This new way of doing things has been around for
quite a while now without causing problems.

To me it seems the issue here is that GPU driver
for the (CPU/chipset integrated?) GPU on these
laptops is missing from the mainline kernel.

There are many good reasons to have a GPU driver
in the mainline kernel. So ideally this would be
fixed by mainlining the GPU driver for these
laptops.

> For example, if no GPU driver is available, we could still register the acpi_video backlight node.

The problem is how do we know that no GPU driver is
available ?

Note that the DMI quirk check happens before
setting *auto_detect = true; So besides doing
a CPU check another option would be to do
a DMI check. DMI checks can use substring matches
(they do a strstr match by default) so if there
is some common DMI string (part) on the affected
laptops which is not found on other laptops
then we can also just DMI quirk these.

As long as it does not end up being an ever
growing list then adding a bunch of DMI entries
for this should be fine.

> 
>  This way we can at least ensure that a backlight device is exposed to userspace instead of leaving the system without any backlight control interface.
> 
> Do you think such a fallback could be a reasonable option?

The problem is the kernel does not know if there
is a GPU driver for the GPU. If it is e.g. the
nvidia binary driver it may need to first get
build by dkms, so even using say a timeout is
tricky and a timeout is always racy so I would
like to avoid that.

My preferred way of handling this would be:

1. There must be a GPU driver for these laptops somewhere?
Even if out of tree using a laptop without a GPU these days
just does not give a good user experience. So fix the GPU
driver to call acpi_video_register_backlight().

Note acpi_video_register_backlight() is deliberately exported
without requiring the consuming out of tree kernel module to
be GPL to allow this.

Other options would be:

2. Add some special heuristics for Zhaoxin CPUs,
the kernel already has a CPUID match mechanism for
things like this. This could potentially be combined
with a DMI system-vendor check to only do this special
case handling on e.g. Lenovo and Inspur laptops.

3. Instead of adding the CPU-id based special case
just outright use DMI quirks. In this case lets try
to use substring matches to cover multiple models
with a single entry so as to not grow the quirk
table too much.

Regards,

Hans




