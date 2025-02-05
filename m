Return-Path: <linux-acpi+bounces-10896-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E26A283B4
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 06:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B8F3A634B
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 05:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F4920C494;
	Wed,  5 Feb 2025 05:34:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13352F46;
	Wed,  5 Feb 2025 05:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733659; cv=none; b=EmV2BehETkBrEzgKvIm9ciuK0650Lfri9RgPXb5oQ4MUq/3mRkms11hF67fxnLGc8P5vx0ZxzX9PLCiVI+rb6dMCOabnE0fQT2UceHK2D+QJ+dcyds+JNhFUUxMRsoJ/ilzdOwDCQTsgH+ou5ViDMj0yIcwb+xSLJSj4hTemSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733659; c=relaxed/simple;
	bh=tVo6KyRYgklzOc5jF07ElkZiK+jTHyaGO/F2qJOCIwM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R8u5sROmpXQE3ePWcCh7JrEx2wtAfzKDn4qJQHGN9+AWYwOK81pon/qUSwwOImk3YXbQnvGAvXp3kZwHe3sLJr4chK1Kns0N8SDANuTLKmZgsmaYlbRcYSUyYEKRGRLGpqK02z0auR/Ln5NTPhCBr57DmJhFbpsRLm16rdty0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-46-67a2f84f118f
Message-ID: <92fb15d4-b8fe-4b73-ba2c-2ded3c9bd4ca@sk.com>
Date: Wed, 5 Feb 2025 14:34:07 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
 gourry@gourry.net, hyeonggon.yoo@sk.com, rafael@kernel.org, lenb@kernel.org,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org, rakie.kim@sk.com,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
 horen.chuang@linux.dev, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
Content-Language: ko
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
References: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>
 <87ikq8h0w4.fsf@DESKTOP-5N7EMDA>
 <147aba6e-7e23-4ad1-9bd2-1ceac0f3d55b@sk.com>
 <87a5bjiqtk.fsf@DESKTOP-5N7EMDA>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <87a5bjiqtk.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsXC9ZZnoa7/j0XpBsv3GFjMWb+GzWL61AuM
	FiduNrJZ/Lx7nN2iefF6NovVm3wtbvefY7VYtfAam8XxrfPYLfZdBKrd+fAtm8Xyff2MFpd3
	zWGzuLfmP6vF3C9TmS1Wr8lwEPA4/OY9s8fOWXfZPbrbLrN7tBx5y+qxeM9LJo9NqzrZPDZ9
	msTucWLGbxaPnQ8tPRY2TGX22D93DbvHuYsVHp83yQXwRnHZpKTmZJalFunbJXBltK+Zz17Q
	JVOxdfUq5gbGo2JdjJwcEgImEtc2HmKEsXdsmssEYvMKWEq83XmRBcRmEVCRWDblOVRcUOLk
	zCdgcVEBeYn7t2awdzFycTAL7GeWuHZ/PVhCWMBcYuKMrawgNrOAiMTszjZmEFtEwEDi75XJ
	LCANQgJbGCVW7DrJBpJgE1CTuPJyEtgGTgFdiXMzt7BANJtJdG3tYoSw5SW2v53DDNIsIXCK
	XeLj7itMEGdLShxccYNlAqPgLCQXzkKyfBaSWbOQzFrAyLKKUSgzryw3MTPHRC+jMi+zQi85
	P3cTIzBql9X+id7B+OlC8CFGAQ5GJR5eB8ZF6UKsiWXFlbmHGCU4mJVEeE9vX5AuxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgXFdzj634zYtJzgdJ3o9
	XXF38dX+TRMDLI569N957P84sP3em8NBsrv6kmZc7G1tnNK4zM4xf3VJtlbxuVfnz4XYm/5N
	mjTPLb5g6szM8/EW4aeUM+9f+HVZSMLlyImF7mdbJGImMwR1bnHZ+cAqLF1rltCxsv64lSI/
	Nl5oMl+28fXa0+8OhUUosRRnJBpqMRcVJwIAxdgo+dYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsXCNUNLT9f/x6J0g+/X5SzmrF/DZjF96gVG
	ixM3G9ksft49zm7RvHg9m8XqTb4Wt/vPsVrMXJtksWrhNTaL41vnsVvsuwhUf3juSVaLnQ/f
	slks39fPaHF51xw2i3tr/rNazP0yldni0LXnrBar12Q4CHscfvOe2WPnrLvsHt1tl9k9Wo68
	ZfVYvOclk8emVZ1sHps+TWL3ODHjN4vHzoeWHgsbpjJ77J+7ht3j3MUKj2+3PTwWv/jA5PF5
	k1wAfxSXTUpqTmZZapG+XQJXRvua+ewFXTIVW1evYm5gPCrWxcjJISFgIrFj01wmEJtXwFLi
	7c6LLCA2i4CKxLIpz6HighInZz4Bi4sKyEvcvzWDvYuRi4NZYD+zxLX768ESwgLmEhNnbGUF
	sZkFRCRmd7Yxg9giAgYSf69MZgFpEBLYwiixYtdJNpAEm4CaxJWXk8A2cAroSpybuYUFotlM
	omtrFyOELS+x/e0c5gmMfLOQHDILyY5ZSFpmIWlZwMiyilEkM68sNzEzx1SvODujMi+zQi85
	P3cTIzA6l9X+mbiD8ctl90OMAhyMSjy8DoyL0oVYE8uKK3MPMUpwMCuJ8J7eviBdiDclsbIq
	tSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgZH19GbRRIsrLFw+LKff
	792v3Su+TO/6pttftqtYu6dHxE5tzlBamrI567DU5ttpNkxMXnMvdPspbFO6XBP8yPk75yLx
	NYL/G7+XivwrdL0p9CyzrsAiMpStyCLvfJjnsdobL8ptPkhO6Z2vdPIY++tzF1c+nrXvikXM
	tX1/djDMcny8sIctr1eJpTgj0VCLuag4EQCBVzE/ygIAAA==
X-CFilter-Loop: Reflected

Hi Ying,

On 1/22/2025 10:24 AM, Huang, Ying wrote:

[snip]

>>>> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
>>>> index 0b7972de04e9..d30dc29c53ff 100644
>>>> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
>>>> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
>>>> @@ -20,6 +20,30 @@ Description:	Weight configuration interface for nodeN
>>>>    		Minimum weight: 1
>>>>    		Maximum weight: 255
>>>>    -		Writing an empty string or `0` will reset the weight
>>>> to the
>>>> -		system default. The system default may be set by the kernel
>>>> -		or drivers at boot or during hotplug events.
>>>> +		Writing invalid values (i.e. any values not in [1,255],
>>>> +		empty string, ...) will return -EINVAL.
>>>> +
>>>> +What:		/sys/kernel/mm/mempolicy/weighted_interleave/mode
>>>> +Date:		January 2025
>>>> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
>>>> +Description:	Auto-weighting configuration interface
>>>> +
>>>> +		Configuration modes for weighted interleave. Can take one of
>>>> +		two options: "manual" and "auto". Default is "auto".
>>>> +
>>>> +		In auto mode, all node weights are re-calculated and overwritten
>>>> +		(visible via the nodeN interfaces) whenever new bandwidth data
>>>> +		is made available either during boot or hotplug events.
>>>> +
>>>> +		In manual mode, node weights can only be updated by the user.
>>>> +		If a node is hotplugged while the user is in manual mode,
>>>> +		the node will have a default weight of 1.
>>>> +
>>>> +		Modes can be changed by writing either "auto" or "manual" to the
>>>> +		interface. All other strings will be ignored, and -EINVAL will
>>>> +		be returned. If "auto" is written to the interface but the
>>>> +		recalculation / updates fail at any point (-ENOMEM or -ENODEV)
>>>> +		then the mode will remain in manual mode.
>>>> +
>>>> +		Writing a new weight to a node directly via the nodeN interface
>>>> +		will also automatically update the system to manual mode.
>>> IMHO, this interface is somewhat hard to be used.  Users need to
>>> know
>>> which value is legal.  So, this will become something like,
>>> $ cat mode
>>> auto [manual]
>>> $ echo auto > mode
>>> $ cat mode
>>> [auto] manual
>>
>> This is exactly I internally proposed to Hyeonggon, but couldn't share
>> the idea directly here.
>>
>>> Unless it's possible we will add more modes in the future, this is
>>> kind
>>> of overkill for me.  How about something simpler as below?
>>> $ cat auto
>>> true
>>> $ echo 0 > auto
>>> $ cat auto
>>> false
>>
>> That also makes sense, but I feel like somewhat vague what "auto" false
>> means. The "auto" might be better to be "use_hmat" instead and this
>> makes "use_hmat" false more meaningful. "use_hmat_weight" or
>> "use_hmat_info" might be another candidates.
> 
> As Gregory pointed out in another email.  hmat isn't good because it's
> platform dependent.  We may use something else to get default weights on
> another platform.

Sorry for the late reply.  I prefered "mode" contains auto/manual and
"hmat" names were my second thought, which may not be proper here as you
mentioned.

> 
> I'm open to other platform independent naming.  For example, use_default.

I'm also fine to your another proposal "auto" with Y/N, which is used in
v4.

> 
> [snip]
> 
> ---
> Best Regards,
> Huang, Ying

Thanks,
Honggyu

