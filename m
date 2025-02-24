Return-Path: <linux-acpi+bounces-11438-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC47A43035
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 23:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C5B189BD93
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 22:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC720550F;
	Mon, 24 Feb 2025 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WR3lJllh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7B1F4177;
	Mon, 24 Feb 2025 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436970; cv=none; b=Uerxtp5EIQZKNzuPBqcP6pCiRHM5xaPVudmZvT2WhvZyQy3z4SQVb7X3yq7Rzq0spoGO06hzESzJ/wTTiYXM9wGAy1X3Sbr4BLELV21xUEKCKKmiq3IpXUVNE8s+fe8l1kD/QE/WmW2IkkSvDS8Sj9nyJkYdZy/v/iA2Y2uwJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436970; c=relaxed/simple;
	bh=XyuyVHNb2+CkpYqNzWK/5pg3Wvn/xddEKgnovpSrkaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQDRMyxuPX2JqkIXKXNEDIvZLswvet0gWpcGo6mp3upMCZ9RF6m3HpVlnxdpQIhaqdy+ZToIbJ1spPxgd3Favm0KR03N5nIl8bXMbvkh/J9h81ILwndPdgo5OUsZEwJ1eUipiaoLBoWkF3LmSOohIZ29d+sYr5E3gyO9gmmM12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WR3lJllh; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740436951; x=1741041751; i=w_armin@gmx.de;
	bh=XyuyVHNb2+CkpYqNzWK/5pg3Wvn/xddEKgnovpSrkaE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WR3lJllhCy34/Jzz6mo3ko1aVNsFMqmCI7ul/gVazeYr/NylWcu08CS9099OsZ+f
	 VVOzIK3tiaDSMMYfPYMqZoWJBHIHc6PNuRt2Vvu38RK3Pn9PR652llUIMiptll4fT
	 o8XSJJHtAdSkNvNrQskhWprAKJsayG3NLAPLZCBxb6I5h7V3tPsCZkeFJxDPYa/Zf
	 WYDZqLPdGQ1/ZuVkx9ffnKEFHn9yaGUaX7fMj2lL1+nwyaN9hSy/OjpAPmyj+4zzb
	 frNJTsG+e6MPzN/Nsv3+F3lilguolmxhe/BTFcN/ovclwqO6LAcTmjye+ncvLsFGF
	 ASFyeK0Xkea3EO8cBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDp4-1tOHTr20C0-00rZLs; Mon, 24
 Feb 2025 23:42:31 +0100
Message-ID: <e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de>
Date: Mon, 24 Feb 2025 23:42:27 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Luke Jones <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, me@kylegospodneti.ch
References: <20250224195059.10185-1-lkml@antheas.dev>
 <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
 <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uzeV9poWYcFbi+jm4YlbaNQ7IdyJOmSgqebE5VBi/2q/HL6w9hr
 rtx4zovQNRbe5P+i5rXKddy9PKbOAbrVYL2NHoaX7vCj85RZ92z1zHqiuYxr93ig1+s68/4
 mNdhyoxFB/uhU5lflSN/pUnwnZx7iLGAShulZm28RWjF45E4pe/yAOpaFgnBjeMZcAa4ci4
 hI2iWoO0rAtPQVdNOXj/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8IKFC8+DXp4=;1l5AQvMheWFJLoANwvLr++LDMGs
 cVFUM4hNEZ3yS77inhY9DteWVJGj5uz1qq74mXzXKFxghaeH52J8Md20ILkWYmbOTp5xu24/I
 cVirYz0JNqCGPQPsP2Z1eE/yqrjRhfEhfr2FDBIrKD2qm4IilbfMDtFo9LK1A4ai5O9u6d1Hg
 wrbFkBIjcTutRhFMpFEWAe1/QIXH5leR6vzGfHBg8R7crfAKs7miEuH5YNwZ9xorJ4qlRyCMO
 E160AubvL8xnH4dwYtH3LMMYla16WCE3DZyWapW3FUyblhILTZINN8BfoVA/gGTVD9UFdQDJ/
 /7JbpzlTs6dFdEWjnjHwfoo44vxl86TlKXzIc4Ik+x71j81cvnslmwHHR/6GbplazqVFrq5jQ
 cTTDh5cwp6D6ZtocaCxcdlaObnDXN9zHRYN0HWJ7pHlp6Zmd9r9V3dyY8bFCRquxrjXYRYsl7
 aB0QjauS4ys0ZbkwaAF8kEppJ1uTZdpCP7rqJXKUku5FCIvsBdEiafFH7R71aksoYj7s8ydno
 A32ciiYxfXKzfA42mvpHWYLRnUn9kwCZQpK9ykynKSfPrmRhnwpUWcGIiv2TBDelvmYrilF4a
 7umOpn96aYrVg78BmUe+dhfYd+6GAssgioMxAMZyaxANHmWwR96ORvgV9w41af1reOeMhVleE
 o3cv4384v7IwwTwuxRkPjhwgMHeGholijkIE9/yuzIOQ9nzrYkFfNMzcWQtRyGoOvzg+2jz9v
 u0cRX0XcmZIbwA7+Voi2B3WFu4ay/1gOYmjWdelcz7AJWiyfoOqh7/JLZ4mBMPJgP4ghQKe3M
 FiFzFYnwCgl+Vay5gCtyKLocHhnUiepbQ9KJGIcR2mpoQqRRG1c8VjIyPbMi3djYSpazOolxZ
 X5kfjVq4GjBOSB5ZcA0drTiYbGTaX6rWbaHIfGZXqqoryfZokS4FFNM1vKxL3Qdk3l8jUsy1O
 Hine1+pntI3B9OZSsAr4ChIukgf652M3U2kuFpWfBmIjmAM2dUaBFHLKhdhz035r4mxo6/dW9
 FgeZdCWJiB9aTeDdDwk7ZuKVM+HO2rpkOH8SBWKyu1FkBSfMWnnFuhbdffXASXPv9HWekQe+M
 dt8FawY0g+6YxUg56bW6yxXOR+Buy8OGkHu+IltxQD5Q0uPSsJJ0vE5VzCr4YGa1VLguxdj7T
 8usf9tZhpb/kk3jNte1xInSvOAaDbDSiPcAeCmHdiL1zupw+icnD0WxfQN4Phzh0CHy7Cb0p2
 zF6rVQF+7N1sA79FJi5ZuYbZh1LHGCD1/5QY899ajaZd3SSKteNOa6+oxND5/urk1ubb8sigo
 Z/iAyajjuBKCjNeWGGEiNA1zjSeMSLFAbwTkAz/7LfHKJThsVL7JOTVU/ZWf3A4vGFjwP+y6O
 MeUDSW4iCz+syz8vm5XW2Yx1HvyBZe44EQ3V/uK1ZpwzjZTU5zRt6SVFp2

Am 24.02.25 um 22:51 schrieb Luke Jones:

> On Mon, 2025-02-24 at 15:52 -0500, Mark Pearson wrote:
>> Hi Antheas,
>>
>> On Mon, Feb 24, 2025, at 2:50 PM, Antheas Kapenekakis wrote:
>>> On the Asus Z13 (2025), a device that would need the amd-pmf quirk
>>> that
>>> was removed on the platform_profile refactor, we see the following
>>> output
>>> from the sysfs platform profile:
>>>
>>> $ cat /sys/firmware/acpi/platform_profile_choices
>>> balanced performance
>>>
>>> I.e., the quiet profile is missing. Which is a major regression in
>>> terms of
>>> power efficiency and affects both tuned, and ppd (it also affected
>>> my
>>> software but I fixed that on Saturday). This would affect any
>>> laptop that
>>> loads both amd-pmf and asus-wmi (around 15 models give or take?).
>>>
>>> The problem stems from the fact that asus-wmi uses quiet, and amd-
>>> pmf uses
>>> low-power. While it is not clear to me what the amd-pmf module is
>>> supposed
>>> to do here, and perhaps some autodetection should be done and make
>>> it bail,
>>> if we assume it should be kept, then there is a small refactor that
>>> is
>>> needed to maintain the existing ABI interface.
>>>
>>> This is the subject of this patch series.
>>>
>>> Essentially, we introduce the concept of a "secondary" handler.
>>> Secondary
>>> handlers work exactly the same, except for the fact they are able
>>> to
>>> receive all profile names through the sysfs interface. The
>>> expectation
>>> here would be that the handlers choose the closest appropriate
>>> profile
>>> they have, and this is what I did for the amd-pmf handler.
>>>
>>> In their own platform_profile namespace, these handlers still work
>>> normally
>>> and only accept the profiles from their probe functions, with -
>>> ENOSUP for
>>> the rest.
>>>
>>> In the absence of a primary handler, the options of all secondary
>>> handlers
>>> are unioned in the legacy sysfs, which prevents them from hiding
>>> each
>>> other's options.
>>>
>>> With this patch series applied, the sysfs interface will look like
>>> this:
>>>
>>> $ cat /sys/firmware/acpi/platform_profile_choices
>>> quiet balanced performance
>>>
>>> And writing quiet to it results in the profile being applied to
>>> both
>>> platform profile handlers.
>>>
>>> $ echo low-power > /sys/firmware/acpi/platform_profile
>>> bash: echo: write error: Operation not supported
>>> $ echo quiet > /sys/firmware/acpi/platform_profile
>>> $ cat /sys/class/platform-profile/platform-profile-*/{name,profile}
>>> asus-wmi
>>> amd-pmf
>>> quiet
>>> quiet
>>>
>>> Agreed ABI still works:
>>> $ echo quiet > /sys/class/platform-profile/platform-profile-
>>> 0/profile
>>> $ echo quiet > /sys/class/platform-profile/platform-profile-
>>> 1/profile
>>> bash: echo: write error: Operation not supported
>>> $ echo low-power > /sys/class/platform-profile/platform-profile-
>>> 0/profile
>>> bash: echo: write error: Operation not supported
>>> $ echo low-power > /sys/class/platform-profile/platform-profile-
>>> 1/profile
>>>
>> I understand where you're coming from with this implementation but my
>> concern is this is making profiles more complicated - and they're
>> already becoming hard to understand (and debug) for users.
>>
>> I'm not a huge fan of multiple profile handlers, but can see why some
>> people might want them and that they're a valid tool to have
>> (especially given some of the limitations of what platform vendors
>> themselves implement).
>>
>> In patch #3 it states that 'It is the expectation that secondary
>> handlers will pick the closest profile they have to what was sent'.
>> I'm not convinced that is true, or desired.
>>
>> e.g. Quiet and low-power are different things and can have different
>> implementations. One is giving you as much power as possible with the
>> fans running below a certain audible level; and one is giving you a
>> system with as low-power consumption as possible, but still be
>> usable. They're admittedly not very different in practice - but they
>> can be different.
>>
>> Would it be better here to ask AMD to implement a quiet profile
>> (maybe it can be based on low-power, at least initially)?
>> I think that would solve the ASUS issue and not introduce another
>> layer of complexity.
>>
>> Mark
> Hi Mark,
>
> I've supported over 80 different ASUS laptops in the last 6 years or
> so, I can offer some insight.
>
> Across the entire range (TUF, ROG, Vivobook, Zen) which implements some
> form of "thermal throttle" as it is called in asus-wmi (which is what
> is used by platform_profile) the difference between low-power and quiet
> is very much nil - the "quiet" profile is only a name, and the TDP is
> limited along with fans to match - so the result is "low-power".
>
> As Mario suggests in his reply perhaps an alias would be best, or, as I
> was going to do, simply rename the "quiet" profile in asus-wmi to "low-
> power" as I already did but have not submitted yet due to a large train
> of patches in progress. It's a single line change and nullifies the
> entire issue and this series.
>
> In any case asus handling of platform profile is something I have been
> steadily working on for the last few months for both laptops and
> handhelds and I will have a new patch series coming soon (version 7 of
> previously submitted dealing with this).
>
> This submitted series is a NACK from me.
>
> Cheers,
> Luke.

I agree with you here, changing asus-wmi to using "low-power" would be an
appropriate quick fix here.

But i think the real solution to this is to extend tuned and platform-profiles-daemon
so that they use the new platform-profile class interface when available. This would
prevent such issues in the future.

Maybe someone can open an issue for both projects to notify them that an improved API
for controlling the platform-profiles is available?

Thanks,
Armin Wolf


