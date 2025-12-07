Return-Path: <linux-acpi+bounces-19471-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4ECAAFC2
	for <lists+linux-acpi@lfdr.de>; Sun, 07 Dec 2025 01:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E6403043F51
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Dec 2025 00:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E63B1B3;
	Sun,  7 Dec 2025 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/CciXnx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95F3B8D41;
	Sun,  7 Dec 2025 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765067510; cv=none; b=QxsVWgkUAh26g23MWwuQqqaNQEs2YRGF+/4mOPkBKzCkZRyUivwgTIvl+ppV9DYSNOKUiZdGV07CHXOksLEKfxOjn4Dy1atFUOU3tJ9Ek3HjQgmDGZ1EUGM7uTiN5Y0VR1GAZLOEW9NMv9Y1MJuaBLok1QgCZZtA/04OWGwDMmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765067510; c=relaxed/simple;
	bh=yQrL+MqX0uilNbeGDZawsbEsYHJ+ZLk9MmBgka8Q7M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0TVnUzKcQj9aEmbCXuytkr57y79Q83/e4jlhX/rYGTE76dZoYU3pmXt2+aIbQLb3cpSg5OyJUTdq36oQg3pl2Z9VJpIZ6EKlB7ryh4Ro/QQ3g/P38S5Nd9+DI5f3seJfmLtEcUb15GPo5pfO+MO2WgP0MzRgKtPz5EC0BEsu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/CciXnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA95C4CEF5;
	Sun,  7 Dec 2025 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765067510;
	bh=yQrL+MqX0uilNbeGDZawsbEsYHJ+ZLk9MmBgka8Q7M0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c/CciXnxWSbAtdqwWY4UlDewnqhHE0JTBWWrPnSnJz4p7alDkYkepBDZrGvJEdKWk
	 lPSjKhcSWbI4iPkfoVjl/AjgQdt/07C0WUf/lJL6LnnW4vOiLjXjVMH+aF57iWOZ6U
	 cHgK49wqiFVdM5uT2FlUSa1pOMocgniSluKJk2Fz785ETXtkt/SBItABRPOnSpE+UP
	 kUcBlAc9G5JXilpGII5jQFytWvVCENCac/iCL9Y6XF9QJOXdD7ezGlwFjSwkof1Cq2
	 s5FMAUnoBC7vvj4iB79ZNdmVjTYvgQj+dWCYeLHGmfNO2E9EZBDB0OA01DwNWcgXa1
	 Nnhxiix18frjg==
Message-ID: <edfc3586-84fb-4dee-a047-9f204054e6f2@kernel.org>
Date: Sat, 6 Dec 2025 18:31:46 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Richard Hughes <richard@hughsie.com>,
 William Jon McCann <mccann@jhu.edu>, "Jaap A . Haitsma" <jaap@haitsma.org>,
 Benjamin Canou <bookeldor@gmail.com>, Bastien Nocera <hadess@hadess.net>,
 systemd-devel@lists.freedesktop.org,
 Lennart Poettering <lennart@poettering.net>
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com>
 <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
 <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
 <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
 <a0d91fa6-bf95-4bbb-a4f9-9d8cceae5543@kernel.org>
 <CAJZ5v0hkkurEK6X3_d_AErKMOn9uicusEb1OhDAv5sFHr7_ahQ@mail.gmail.com>
 <411ea5f1-7cc7-4a2e-99b4-2891f3aa344e@kernel.org>
 <CAJZ5v0hQMGarx96oU-OHXh8665FJ2UP4dJpVKoxCgdyi8fZ1QA@mail.gmail.com>
 <6d7b916a-8c37-499a-84a6-5facbe0e3bd4@kernel.org>
 <CAJZ5v0jqdQw57t7Moj4o2eWt54t1wBvn8_0N9L-orn_JzFGWyw@mail.gmail.com>
 <CAGwozwGafykCaiEa+EUS+QQsFBXR53-D4aYpW-SPRX=Ax1-F2w@mail.gmail.com>
 <CAJZ5v0g5dwWSOQCTUFeD+ztFLyYrRR1Z=vt2C+c48SRbaNLJzg@mail.gmail.com>
 <2711fe57-1963-483e-b8fa-0c5ed0bd2ea9@kernel.org>
 <CAGwozwEp3Xc_pv-YGb_Xc46CcLKPppYaZbphV24kiNHM4Eqb-w@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwEp3Xc_pv-YGb_Xc46CcLKPppYaZbphV24kiNHM4Eqb-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/6/25 5:35 PM, Antheas Kapenekakis wrote:
> On Sat, 6 Dec 2025 at 21:50, Mario Limonciello <superm1@kernel.org> wrote:
>>
>>>> I will reply to the earlier reply from Rafael with more context, but
>>>> runtime suspend of the GPU is not part of or related to these
>>>> notifications.
>>>
>>> Of course it isn't.
>>>
>>> What we were talking about was how to get from the "displays off, no
>>> GUI activity" user space smoothly into system suspend and back.
>>>
>>> You are saying that this has been done already on AMD, so I'm not sure
>>> why you want more.
>>>
>>
>> I'm not aware this existing in any unique way for AMD.  The decision of
>> displays off; start a timer and enter suspend would be the same for any
>> vendor.
> 
> AMD retains CRTC DPMS state from userspace to s0ix currently, and you
> fixed hibernation recently too. Intel sometimes doesn't, the screen
> will sometimes flash while entering suspend.

I was talking about what Rafael said.  "What we were talking about was 
how to get from the displays off no guid activity user space smoothly 
into system suspend and back".

> 
> There is also runtime suspend on most components. Is there a case for
> powering off the iGPU completely to improve energy use?
> 

I don't really *think& there will be much of a difference.  We already 
go into GFXOFF when GC is idle, and SDMA, VCN, JPEG and VPE will be 
clock gated when not in use.

Someone would have to do power profiling to see if it's significant 
enough difference to justify it.  The easiest way to check would be:
1) Turn off all displays
2) Connect over SSH
3) Collect a RAPL power measurement for the package.
4) Unbind the PCI device from amdgpu
5) Collect a RAPL power measurement for the package.
6) Compare 3 and 5.

> The most expensive component in this process is unfreezing, then
> runtime pm freezing the GPU IP blocks after s0ix exit, then unfreezing
> it two seconds later to perform runtime checks and freezing it again.
> So for multiple exits from suspend where the IP is inactive this will
> keep repeating.

I think we would set the auto-suspend delay appropriately if we did this 
and use DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME in this case.

> 
>> But GPUs aren't only used for display.  If you're actively running a
>> different workload (for example an LLM) using the GPU and happen to turn
>> off all the displays you wouldn't want it to suspend.
>>
>> What you would want is to key off:
>>
>> 1) All displays are off.
>> 2) All GPUs are unsused.
>> 3) Some time has passed.
>>
>> I feel that if userspace is going to adopt a policy like this kernel
>> drivers need to use runtime PM when displays are off and the GPUs aren't
>> being used for anything else.
>>
>> At least for AMD this doesn't happen today and would require driver
>> work.  But the same kind of work would be needed by any GPU driver.
>>
> 
> You could potentially do that, first you'd need to show that there is
> a latency benefit to powering off the GPU over entering s0ix (as
> userspace will be frozen in both cases for the GPU to suspend). Then,
> you'd need to show that there is an energy benefit over just staying
> unsuspended with userspace frozen and the GPU being in runtime
> suspend. WIth both of these, a case could be made for powering off the
> GPU completely for a marginal latency/energy benefit.
> 
> These notifications do not affect runtime pm though so this discussion
> is a bit tangential.
> 

I'm not worried about the latency.  We can change the policy for the 
autosuspend delay if latency is a problem.

If we added runtime suspend support to integrated GPUs this sounds like 
a really good thing to key off for that "display off notification" that 
started this whole thread.

Some infrastructure could be added so DRM core could monitor runtime 
status for all GPUs on the system.  If they're all in runtime PM it 
could use an exported symbol to send LPS0 screen off and when any one of 
them exits then send LPS0 screen on.

