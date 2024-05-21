Return-Path: <linux-acpi+bounces-5912-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347EB8CB114
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 17:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567DC1C21470
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719F0143C58;
	Tue, 21 May 2024 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Fo2YlDE2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89CB143890;
	Tue, 21 May 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304455; cv=none; b=PjEIHcjvJwBHK9XFK+bD+CioMTVS+P1A8v8tSL8B0JDkeBpnzQawxSp+FliRwBweB6m0WjWk5BUzkzqTEuBNZWv2fJzhK/GYSZxNWkPDSyQI3GAl5sebQbGYeVVLvPN2/9XoLM6hUzAMa3bQpPWFgAgO2D3wil9Wi1rKKabVdhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304455; c=relaxed/simple;
	bh=dZIs6EsZwByQm7k8FNr7Iv+xc566yIzAhmYeBDWeyBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1S5FaJ4Uv/rB/WkQEcGmP6kzC/+sAHjfidk3XTUIX/oEi6nYncsfywoBidsVO18xMAy3XQBr+TlW4YWep8Jj+5HYJQsntBZv1j4iw6k4x2wAtR49pw9dreWNwyhG76wuz4L/bVdEqc0i+tVdUFRClLlfSK+5s0H/mmKcbL3a+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Fo2YlDE2; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=q2yG+PFba6HJA1oZYuUDakDRt7qTNLVGKULFI5XS2W8=;
	t=1716304453; x=1716736453; b=Fo2YlDE2lHjNmDEs7VJjHiV2H7oMM8KAuSPK7PqNW1+wdla
	nFMtMBYyiRC0S/Vi+cllU1Nz/4sA5oBVhAa5ifPWl9jLK+egYGmpLMF9mxx/RCQHPTh2kmVqQ5waJ
	83rDAPdTtvXu8tVLBfXN++UGCNmPoa2l7vcmjJQqtp8FvWdvdbWDxH3OILVzVOWWdU1Yzfa7GtGtl
	UDD8ubqMlX57PDq8Z82tYiOjB0anDdNBF/QSqBjP3Gqnb8UtwBjgfWj0OOCPyKz9gTTEEoAJamtbz
	whTbd+m/VTxG9y+p6FWav/7Ur914V61m/944Ab+A1w+JvSiQVzo6w6Xx+it6ugug==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s9RBn-0007aE-OE; Tue, 21 May 2024 17:14:07 +0200
Message-ID: <4f1bcc8b-1795-4e3c-90a6-742cd8443396@leemhuis.info>
Date: Tue, 21 May 2024 17:14:07 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: Move ACPI device NULL check to
 acpi_can_fallback_to_crs()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Laura Nao <laura.nao@collabora.com>, mika.westerberg@linux.intel.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "kernelci.org bot" <bot@kernelci.org>
References: <20240513095610.216668-1-laura.nao@collabora.com>
 <ZkHlLLLoagsYlll7@smile.fi.intel.com>
 <b20b567f-ce96-45e8-aab7-29768f8313f5@leemhuis.info>
 <Zkyo6DL7NQltLLNr@smile.fi.intel.com>
 <c10a77b6-e7b1-43c0-af38-79092eeb34f1@leemhuis.info>
 <Zky1UgJSf_ybRMOI@smile.fi.intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zky1UgJSf_ybRMOI@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716304453;d7632009;
X-HE-SMSGID: 1s9RBn-0007aE-OE

On 21.05.24 16:53, Andy Shevchenko wrote:
> On Tue, May 21, 2024 at 04:26:32PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 21.05.24 16:00, Andy Shevchenko wrote:
>>> On Tue, May 21, 2024 at 12:01:17PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 13.05.24 12:02, Andy Shevchenko wrote:
>>>>> On Mon, May 13, 2024 at 11:56:10AM +0200, Laura Nao wrote:
>>>>>> Following the relocation of the function call outside of
>>>>>> __acpi_find_gpio(), move the ACPI device NULL check to
>>>>>> acpi_can_fallback_to_crs().
>>>>>
>>>>> Thank you, I'll add this to my tree as we have already the release happened.
>>>>> I will be available after v6.10-rc1 is out.
>>>>
>>>> Hmm, what exactly do you mean with that? It sounds as you only want to
>>>> add this to the tree once -rc1 is out -- which seems likely at this
>>>> point, as that patch is not yet in -next. If that's the case allow me to
>>>> ask: why?
>>>
>>> Because:
>>>
>>> - that's the policy of Linux Next (do not include what's not supposed to be
>>>   merged during merge window), Cc'ed to Stephen to clarify, it might be that
>>>   I'm mistaken
>>>
>>> - the process of how we maintain the branches is to have them based on top of
>>>   rc1 (rarely on other rcX and never on an arbitrary commit from vanilla
> 
> Note, besides above reasons the one is (was in this case as you noticed)
> to wait until dependencies laid down in the upstream.

Well, that can be a reason, sure. But I still wonder if Linus would have
preferred to get 49c02f6e901c and this fix for it in the same pull.
Sure, adding this fix would have been a late addition, but when it is a
fix and mentioned in the PR that from what I can see is no problem at
all for him.

>> Something like that is what I feared. And yes, some of that is true. But
>> the patch in this thread contains a Fixes: tag for commit 49c02f6e901c
>> which was merged during this merge window -- and that patch thus ideally
>> should (ideally after some testing in -next) be merge during the merge
>> window as well, to ensure the problem does not even hit -rc1.
> 
>> That's something a lot of subsystem master all the time. The scheduler
>> for example:
>>
>> https://git.kernel.org/torvalds/c/6e5a0c30b616bfff6926ecca5d88e3d06e6bf79a
>> https://git.kernel.org/torvalds/c/8dde191aabba42e9c16c8d9c853a72a062db27ee
>>
>> Other subsystems (perf, x86, net) do this, too. Not sure how they
>> exactly do that with git; I think some (most?) have a dedicated -fixes
>> branch (based on master and fast-forwarded after Linus merged from it)
>> for that is also included in next in parallel to their "for-next"
>> branch.  Stephen will know for sure.
> 
> This part of the kernel is not so critical as scheduler, but in general I agree
> that sooner we get this in is better.

Side note: with all those CIs that "sooner" became more important I'd
say, as I frequently see multiple CI systems running into and bisecting
problems -- which humans then look into and report, which is a waste of
time.

> The other thing, that we have 3 regressions
> now for very this code. And some of them are still under discussions.
> 
> Wouldn't be better to gather all fixes and send a bunch via proper process
> after rc1? 

Depends on the situation. As a general approach I'd say no, but there
definitely can be situations where that is wise.

> This will ensure that everything we know about is covered properly
> and processed accordingly,
> 
> In broader way, the process should be amended if you want a fast track for
> the patches like this. I'm on the second level here, Bart is the maintainer
> who sends PRs directly to Linus. Do we have anything like this?

Pretty sure Linus wants maintains to just fast-track things when needed
by sending an additional PR; he multiple times said that this is not a
problem.

But there is a way to fast track things: just ask Linus to pull a patch
from the list (e.g. in a reply to the patch while CCIng tim). He
multiple times said this is no problem for him, unless it becomes the
norm. This is documented in
Documentation/process/handling-regressions.rst /
https://docs.kernel.org/process/handling-regressions.html

Ciao, Thorsten

