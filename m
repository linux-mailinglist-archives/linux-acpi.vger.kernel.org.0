Return-Path: <linux-acpi+bounces-12595-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C00C0A77E51
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 16:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB41418918B7
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43F204C23;
	Tue,  1 Apr 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5QrwX6h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059D1EA90
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519490; cv=none; b=fabtgv2YWN4cZeq1wGQq1UVbDOYgiIJxQpuZx01qeMWMtT715xeLuU7DJRZt0CAEMC03gBB2ZxaMf1WK1Or5ytTFq7rzbJdW/iIN+SHd5651oTLnK6Ni1UIEu1cRz28UNGL5K7lUF8gbW77xyF3E7axuqoJYAYxJ7Iw18yZ/Z5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519490; c=relaxed/simple;
	bh=9L9w/RXAyICDDpshugAeJZvuxA3x+oBB0vBvuHUKXkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHpYskMTc0drvp56wdu1gGE6YaLma/JlDKgEi4hRxbzMo+e+Ec3PyqM1wL47cUhw5jbtxjTq2itAGqEHQqHCqGspdy47RfzjrECo5JLHySbQm/ytcRxsiZA+f/1z6VnOJMcStvt5K8xTj4wE/xk5hhPpP/MWPRe95c3409kazuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5QrwX6h; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2255003f4c6so101987815ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Apr 2025 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743519488; x=1744124288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egFg3uJvCZMIiw39C5iZpgNhTpttJjT/Mxf3yBT8fTI=;
        b=D5QrwX6hXKY1/utWzZDdddSL2XKf7fFyyt6D2oR9IQXqctkW1XbJaqBWU7aAlETkzj
         MuaXrwtfJ7DlKERirBBxGxS0DVNxn5mEpBi7Wq4+7uAP6ivMdOoBT5V7w0NQMY6zuoY0
         p62kx4cFEwjqff0h2yWB0kqaKDpqZEf5ZjCAqWi6gaWpaDNKXVg3LBrwTOUeVYgMOyGV
         8Ye+LDp41CA4m8cDoNo71VCDMzen1DGXTtnE5mnRySe1xZt14iWDktcJHaNe8EKA/AYs
         t5P/Dha9k3Ytf8zmd0c1UW+FgFTx+Rd05JapmTxE2L4mGwvs8TRF/pLbaoVSPAz5Eexp
         qBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743519488; x=1744124288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egFg3uJvCZMIiw39C5iZpgNhTpttJjT/Mxf3yBT8fTI=;
        b=G0L2Sur6m0ctngZDTHAWi+/VUfK29AklBlnHf9bapEK4XwD562jsnKYvcMbxxBpyZj
         /euPwtvwDVt+QUVbHhCd5a5OpjGqwSVSSYpnkoA0TtIzUvIaoTGnptxIeLTqWNRNazuF
         GeaY9Wv5CLoqAOL6SY45iwL7Q6mBEkjspir7pyYrTo1fhGbZlscYzw/AH7VXK7QqQzlF
         iAxMR8BDYxlBwEcZ05R1pCpZqMpVGdWgRTk7CJL0f36F6APKk4OAplf8AMc4ypl9dalg
         RzpdNUqYSWbkQEUsZ1TVvBsJRN1PGdjc0Rzv4m4WnlBz1w3rr4QciN3KUT4bDR1V2Kv4
         7SsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH8qSERwe6buzGJpXyTRW3gDY75vqRyoGkno77elJ4ns4XoH1OyKau+qnhdnc6RZNNuF5aWygOvo0f@vger.kernel.org
X-Gm-Message-State: AOJu0YzAUwMsHfO1BlXvyyvb2FwytwGxi6DUBI7NMPpJppaa7nDJZUud
	RnCJwXaMQx6b4UR0sUlNzdhjdbxUILY2XXbLkPfBSUKudtrlhgPl
X-Gm-Gg: ASbGncuR1UtSgEhpxQ72k2yHliW5/GiywdrcDXWHRrbYfcXh7TIvS9yDceM75xO0V8U
	3zXgAhZdqRYD4A8Jame8tHlzEN2Pym/jMDqDnMKm+mMjZOBHEeTba114bStPNFRhNVaPbIgr2nh
	eko6Gm8EYEAWsKSnmmh3srnXKUc3ofhh1XHC2RCb5saf4xHGvOuEYSCA4s8kxu52v7aEW6ZZZoe
	nwE3LFlW6RQUWvJMpksphd+783Fp4X8IUfT9kT02ns1y77cROE/h5QOI5fvEMpOgRIX+3KJis1V
	8vHu1s2zcVfJ0QHWW9mCr39j7apHHTC4lqOgaW3V4QBB7TWgkXKF2g==
X-Google-Smtp-Source: AGHT+IFZfSDWG5XvYrujDXld4Gy/hpCiDZH0PXZUoctRK8lfpnaRBXpqT4aGFFhmekMUy2QMBSujLw==
X-Received: by 2002:a17:903:19ec:b0:223:5945:ffd5 with SMTP id d9443c01a7336-2295c0ec4cdmr51518865ad.32.1743519487471;
        Tue, 01 Apr 2025 07:58:07 -0700 (PDT)
Received: from [0.0.0.0] ([156.226.172.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf8f3sm89561475ad.120.2025.04.01.07.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 07:58:07 -0700 (PDT)
Message-ID: <cd7ca9d3-0ff9-4492-95e9-3d9d615ed027@gmail.com>
Date: Tue, 1 Apr 2025 22:58:05 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
 Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org,
 Mario Limonciello <superm1@kernel.org>
References: <20250331204442.1727618-1-superm1@kernel.org>
 <CAGwozwHyRiyVkX8rsc69gkALScWdtXNAvAGn7c2aEXW_qgdWsA@mail.gmail.com>
 <CAGwozwEiCXFDi73qAPSm2K9A8OZutE7dbjFfCmbUSAOTaz8SEA@mail.gmail.com>
 <50cc3227-93eb-4cb8-8151-23e52ca91f80@kernel.org>
 <CAGwozwH7r-7uELUB1fiftAf3ziU6irgW92qiHHNOpuJ-87=WJw@mail.gmail.com>
 <90d704dc-51ea-4c98-ba4a-f95460f65061@kernel.org>
 <CAGwozwEoCc_nRodt2=6R5K5UOzhW+5Gx1uLS3H3ON4ZS_12gBg@mail.gmail.com>
 <dbfd11bb-9cde-4ec7-a9ef-0c28b7961419@gmail.com>
 <CAGwozwFodjNMxPkM+=CcBPtR4uuj73cSSqrBfpLvhL+a=U6f9g@mail.gmail.com>
Content-Language: en-US
From: Xino Ni <phnjs211@gmail.com>
In-Reply-To: <CAGwozwFodjNMxPkM+=CcBPtR4uuj73cSSqrBfpLvhL+a=U6f9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Hi Xino,
> no problems from my side. We tried our best to have it work but
> sometimes life has it some other way. There is also no problem with
> submitting the patch now, a month before or a month after. The
> attribution is how it should be now, and that was the only problem, so
> it's ok.

Thanks again.

I'd like to share more progress in the debug:

After the BIOS implement standard _BTP method, the sleep-to-dead issue
is not happen again when battery is fully charged, and the fake sleep
heat problem is fixed also. But we observed OS crash to reboot directly
when wake up, same as you observed.

So you are right, the issue can be divided into three parts:
1. _BTP make the OS wake up time to time
2. Touch Panel signal gating device sleep again
3. something from EC/BIOS crashed the OS when wake up

We failed to resolve below two issues, and thanks to the ec_no_wakeup
quirk, we never encounter below two issues after introducing it.

Xino

On 4/1/2025 10:46 PM, Antheas Kapenekakis wrote:
> On Tue, 1 Apr 2025 at 16:17, Xino Ni <phnjs211@gmail.com> wrote:
>>
>>
>>
>> On 4/1/2025 5:01 PM, Antheas Kapenekakis wrote:
>>> Anyways, you got what my problem here was. You nacked and bikeshed
>>> this patch for 2 months, and that was after I did all the background
>>> research, testing and deployed it [1], so you could find the real
>>> cause, which I let you do as a _professional courtesy_. Then, out of a
>>> sudden you are the primary author on a patch I authored and you nacked
>>> and started testing after it was done [2].
>>>
>>> I guess a nicer way of saying this is that you make it hard to
>>> collaborate on kernel development. When I bring up issues to you, do
>>> the background research, bisect, and general grunt work for them, you
>>> do a minor cleanup which is easy for you as a kernel developer, then
>>> strip the credit for them and I have to hunt you down to get some of
>>> it back. This is not a productive environment, I cannot work like
>>> this.
>>>
>>> I think this is the 6th or 8th time this happened but this time it is
>>> particularly egregious, because you had me spend 20 hours debugging
>>> offshoots after my patch was already done in random directions trying
>>> to find a real cause, only to see me get dropped to a normal reported
>>> by, and that is after I told you off very harshly because of [2].
>>> Otherwise the reported-by might have been missing too.
>>>
>>> In any case, there is no point in rehashing this over and over.
>>> Authorship in this series is mostly fine now, so it can go through.
>>>
>>> And to avoid having this conversation again, there is another Legion
>>> Go S [3] patch you nacked and froze the testing for, so you could go
>>> on the manhunt for the real cause of this one. But it will probably be
>>> needed and you will find that as you get TDP controls going. So if you
>>> want me to prepare that in a timely manner, because that one actually
>>> needs rewriting to be posted, now is the time to say so.
>>>
>>> Antheas
>>>
>>> [1] https://github.com/bazzite-org/kernel-bazzite/releases/tag/6.12.12-201
>>> [2] https://gitlab.com/evlaV/linux-integration/-/
>>> commit/6c5a3a96be9b061f07bf9a1bcc33156c932ddf67
>>> [3] https://gitlab.freedesktop.org/drm/amd/-/issues/3929#note_2764760
>>
>> Dear Antheas,
>>
>> Thanks for all the amazing works and advice you have contributed to
>> Legion Go S not only in the kernel but also the HHD, I'm honored to have
>> you help on the product.
>>
>> I'd say it's unfair to blame Mario for this patch submission because
>> it's actually my request to him and it's my failure on ODM management
>> that cannot fix these FW/EC/BIOS wake up issues, we have to submit the
>> patch to upstream as next kernel cycle begins.
>>
>> Further more, I'm very grateful to the specific issue you have spend a
>> lot of personal time on it, you gave a very important guidance in issue
>> debugging and help us clarify the root cause.
>>
>> As the project is the first time I work with the community, definitely I
>> have a long way to learn how to work together and manage the
>> development, so please forgive me on it.
> 
> Hi Xino,
> no problems from my side. We tried our best to have it work but
> sometimes life has it some other way. There is also no problem with
> submitting the patch now, a month before or a month after. The
> attribution is how it should be now, and that was the only problem, so
> it's ok.
> 
> Antheas
> 
>> B/R
>> Xino
> 


