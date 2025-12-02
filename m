Return-Path: <linux-acpi+bounces-19381-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30997C9BC55
	for <lists+linux-acpi@lfdr.de>; Tue, 02 Dec 2025 15:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478763A8AAA
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Dec 2025 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297C324B27;
	Tue,  2 Dec 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAof8Qbm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1242222B2;
	Tue,  2 Dec 2025 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685395; cv=none; b=KPKAf4JP7IjbXI8SLNPViLsB3+DS/ifLl+cjroHiGwff7tSg6Q5ize2EwrsC44q9GBYoOpG02UjQXXrPeOjziJgeBTV/W19V5brqNamr9FqTnEfl2u2EPxG4FVCYA/5s0vmxzWA2zsy9lYfF+IkkZqxEXA+/xanerzcddRyfVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685395; c=relaxed/simple;
	bh=UauJHbO0LrbYYHqWPoTmWXfvcSnh2xFdrDoiSwMH5hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQPnEMSgINbj8Vo6ej8NRo09Suq2qxJBiyKsz8emehlIr59nJXJGlYGZ7ik/HB+7BPJ16IZROlBv7yqtn40uyFPjjfBKYFhxDcQquTMxcXZrcDwfINc/tE7qRrm26jrCqwP9psSwRk02uHr25F3g78rjp1f/3IF9RowEQXOlvCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAof8Qbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D9DC4CEF1;
	Tue,  2 Dec 2025 14:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764685394;
	bh=UauJHbO0LrbYYHqWPoTmWXfvcSnh2xFdrDoiSwMH5hA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oAof8QbmBheFZh9ivGsjG3H2LCSmx7IWvIxfUqmBAI3qcsT829o2F7PfalZ1dfK2Y
	 J1s77VHOwVgtDpZrOfr2ZtWKbaMD33PrDhJUdhKWgZjISzTGP+jMk85osiX3rVT7EH
	 qSf96xGyd73WS1TZSlNE+APa3xoKYdSl8kd7YaVvKeVrhI4OUR96fKn/Zq5lFZ7EFO
	 Wnq5Zjip2TtEXTazNk8MdIJ4+sWOmwhUUdJzlZAeEmqM9e4ehHuGn+lzYIpUewpyQW
	 mmjDKPs7qJJi/QclPCrmEKIo1bdUDKfCQOJK9CjhkRR25OUUgYuiYM7519Jh9eBpE6
	 F3Bnyqru4+eiA==
Message-ID: <c7760b2d-c8cb-40fa-b1b1-8715e97e5cf0@kernel.org>
Date: Tue, 2 Dec 2025 08:23:12 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Richard Hughes <richard@hughsie.com>,
 William Jon McCann <mccann@jhu.edu>, "Jaap A . Haitsma" <jaap@haitsma.org>,
 Benjamin Canou <bookeldor@gmail.com>, Bastien Nocera <hadess@hadess.net>,
 systemd-devel@lists.freedesktop.org,
 Lennart Poettering <lennart@poettering.net>
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAGwozwG=F1BC8UF6Xkest5pwZG6iRjNjk5zpjmSV8Yh-0S2tGA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwG=F1BC8UF6Xkest5pwZG6iRjNjk5zpjmSV8Yh-0S2tGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/25 3:32 AM, Antheas Kapenekakis wrote:
> On Tue, 2 Dec 2025 at 05:36, Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> Add `/sys/power/lps0_screen_off` interface to allow userspace to control
>> Display OFF/ON DSM notifications at runtime. Writing "1" to this file
>> triggers the OFF notification, and "0" triggers the ON notification.
>>
>> Userspace should write "1" after turning off all physical and remote
>> displays. It should write "0" before turning on any of displays.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   Documentation/ABI/testing/sysfs-power |  13 +++
>>   drivers/acpi/x86/s2idle.c             | 149 +++++++++++++++++++++++---
>>   2 files changed, 145 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
>> index d38da077905a..af7c81ae517c 100644
>> --- a/Documentation/ABI/testing/sysfs-power
>> +++ b/Documentation/ABI/testing/sysfs-power
>> @@ -470,3 +470,16 @@ Description:
>>
>>                   Minimum value: 1
>>                   Default value: 3
>> +
>> +What:          /sys/power/lps0_screen_off
> 
> Hi,
> thanks for having a second stab at this. My initial series for this
> was kind of complicated, I would need to rewrite it anyway [1].
> 
> I will second Mario on the integer values. The main.c file provides
> the capabilities used in other power sysfs values and an ABI for doing
> string options.
> 
> For me, I have a bit of a problem with the ABI. I kind of prefer the
> one in [1]. There are three sleep states in Modern Standby: Screen
> Off, Sleep, and LPS0/DRIPS (and a fake resume one I added). The only
> one the kernel is suspended in is LPS0.
> 
> So the ABI should ideally be able to cover all three, even if at first
> you only do screen off. This means the name kind of becomes a problem.
> lps0_screen_off implies lps0 (is not the state, is also an ACPI x86
> specific term) and is limited to screen_off (cannot add sleep).
> 
> I used /sys/power/standby in my series, which I think was fine because
> you'd be able to add hooks to it for general drivers in the future.
> This way, it would not be limited to ACPI devices and the name implies
> that.

Why would you want to expose all those states to userspace?  I feel like 
it is going to be risky to have userspace changing the state machine for 
suspend like that.

Since the _DSM call that is interesting here is focusing specifically on 
screen off I have a slightly different proposal on how this could work.

What about if instead of an explicit userspace calling interface it's an 
inhibition/voting interface:

While in screen on:
* By default no inhibitions are set.
* If no inhibitions are set and all physical displays go into DPMS then 
DRM can do an call (using an exported symbol) to enter screen off.
* If userspace is using a remote display it could set an inhibition.
* When the inhibition is cleared (IE userspace indicates that a remote 
display is no longer in use) then:
   * if all physical displays are already off call screen off.
   * if at least one physical display is on do nothing (turning off 
physical displays would call screen off)

While in screen off
* When a physical display is turned DRM would use exported symbol to 
call screen on.
  * When  an inhibitor is added call screen ON.

By doing it this way userspace still has control, but it's not 
*mandatory* for userspace to be changed.


