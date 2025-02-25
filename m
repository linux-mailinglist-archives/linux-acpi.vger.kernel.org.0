Return-Path: <linux-acpi+bounces-11464-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A9A44519
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 16:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B073B0326
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDA61624DD;
	Tue, 25 Feb 2025 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KBfOf/ZZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9591547E3;
	Tue, 25 Feb 2025 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499014; cv=none; b=ASD4sQdJZmDoGUNi4TJMoyNDToA7UH2zgE5MebKNWX31cuMEtFyUcMn1x3CRXR3qVX3scAJNNO5rmqHNu8YvBJC7PhEMSSiFWZfdgDrCZ6G+0lk6oLG30pxH6qNNgiWWTK/DuYUFOTYk355c/zccXKEH3hkQO4apc6jVJm3wAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499014; c=relaxed/simple;
	bh=OYkwmAIKSpghP5IQFeaupaUzK0ZNGLi6KNmWBZ3eaS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lbgp9z4FBP6rfIlYLtB2YK8F5iFgHNiXAoMQ5vrfWmtUUYv7CuaKRv6uKJfAh/lgF5VQUMRpfAs7LZfQgdT0DW/PJjSAQQ3GCQ+1BlzrMs0owTMSpP1b0aaDlvgfIerGlMyU71G+SYD4T55Aen8uaukavhG8NBVj/fOKf/iRS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KBfOf/ZZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740498990; x=1741103790; i=w_armin@gmx.de;
	bh=srZ3cQwVaVpTGG/bBGMZgmA/CakDxnKVsPHw83xHEdI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KBfOf/ZZYQrPM1+MsUR93V2zK0R+zvYFWZpGIVXttFf4dHt7GI/Hnoquxml7NgXB
	 Gaage7oOSXna/tkmF76kv7yX8z8e4XyPP7ohoH7RkkFfULaDjcnmTF9sw9SpiEFXy
	 BHaLFXABmxaw1bOh8CCmnd1MJPpUIJfGvnurTc2jDFcgEPRQErmuRk3s53AyOTOcD
	 Bj4FbPmxvzxHce8wdnysmgxPhSgTtRfHIJxBEOq0dCS7utG4L243Srnrs45PHq2S5
	 JDYh1xfCo5cnfSHcuc/8iqBHNjtbp2dbg0bZntfQgDfXjYvgD99kp46PhVn4wz3yA
	 YG4Qeas0Q48GvLjP+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5UN-1tYvCD0RWB-00GorX; Tue, 25
 Feb 2025 16:56:30 +0100
Message-ID: <5cff4286-2800-4bc0-b243-5244d19a64b7@gmx.de>
Date: Tue, 25 Feb 2025 16:56:27 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Antheas Kapenekakis <lkml@antheas.dev>, Luke Jones <luke@ljones.dev>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, me@kylegospodneti.ch
References: <20250224195059.10185-1-lkml@antheas.dev>
 <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
 <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
 <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
 <f5d39d3c932a78a5021877230c212c620edc586e.camel@ljones.dev>
 <CAGwozwEWZxWzcTjPby4OeUz+CCXbvQAkvCExo-Qc7=r-0-6BCg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAGwozwEWZxWzcTjPby4OeUz+CCXbvQAkvCExo-Qc7=r-0-6BCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wm1BxrcI+H7lLNebIARIG6GX2ucnHDeZiYuD1eUhtXOLYzOTxBr
 DCDJnBJI94nbKfup8euTI880mfhDsfFqcaHVgWBnp2d/+vRxdLc0XM+63wMwb3lhOpgmk/s
 Kh8AvtEM/9WicO2ckN/ZZe8yqEuvZgyP542YiaCpqYAQ376DGVxwwcsH8tfnWsEobw8+N81
 FRM/gPX6F+gLXp/uzEA5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:22hNWHYS/18=;Y4SztS7VQqmm8TTDhaf3aoTyMnn
 bGW9zfEvamUOnBCnMaFD/1dfVnYWiHReI4Ux1dAXMTl7AExAtLcfkndRzVW4pTZ41aICNon1y
 GUJmeYyk+I1AMOstYaq4ZzyOasDMg65iBJdgfll/mA8mKqdVBOjsNLgsDiv9w/ZUZxMlkUfwR
 4Cw1elyXMLaWbjmqIaMLIfpC88kdYmOOsEskJEu9N21bLnFsofIPl2aiNO4ZZC5+d77V51GNk
 Z43QkBG0Cjh88PLs3BNMtOOtpxPsahIIgViF26euDveiPfG0VddfFZPucVMT/sYldfC5y1h1M
 9M2D/z2EQuxDhhCAxvXfMnEg82JAdqT/2sUMCpmPX+y8jiGtBLFYxezIfwjl2YFRLr5WIylAg
 6LthGvKZcMGSODNsaCaAcuk/+Wedsi6VWvBuGwMm6YjkjPMsbEL10PfBp/gVAFaLV7rxxlA03
 7hJK9Ay0JM0sYOyFIQ4FNujvpjVbEeY9WzNejDm3h4/I8i93MBK2hetXqxAMSOpcfxrYpPbXs
 W7SZn2GnOjnUZx1r3psv66NEOyVhPJ9kKFBOULa4aYUtfUAV6RMcQB0D3JDhPs3AgZT1V8Kbh
 2n1kGlkrKRmZ4iKv5hTqdxf7A7ZDx5spH4RFU0QPWhUT19/5Gco5e4iLak45LEdR13/lxLOrZ
 J3pJeu1bec73XGMtgTQJfofzdv3/FHn0z2CU+BjtAjoIAIcyYeJj+YgnKzQdjk3u8jdyLE958
 O1CRC7tyzDf8K+FHVqGF/TQhG/hB81oQLpvwxKL/zvYoSM2MYjRdY1rOfdyf3HSpyWIZCvR3X
 7kDbWZZ/8VfftmiHwJWKYYGRkLYsp0Ni/f2R1Db/MW9R5jmCwzvEqWE8CsM+YMutpotakE1Ez
 II4YJu3t6zJ1yhyE0v1xKNYTU+VEJ4drlIhliNG1V2vMSugSQPQfCAdQbHT0Sd7FyW3OFe+rC
 MIHeOq8uqy2OgOJlqm7wewNTAUd+/yS4r5cmFho0PkGaG0o2WtbDdTUXl0PKeObGIYXjAdZaY
 qx6A4c9Z9C54oZw3lf1hZCgVZ+DhEVUPeeFNgQsViYCWg3h2aKnbgO/FKATjTVPdDFMaJanG6
 FnQLmQIk4bD0O/WaRi4e6n5xxk4bAu6aA3ql2Je2Q4otfnmnUTszd/Aqqu8BD6E/6LvF63UP1
 IgIfIdSk/eT7xswyAmDiGS1qaANVHpsElS0FzOb9sdjlKOUeJYCQ01QZhlrZ7wQoq6VjHvHi9
 yu5RJqiU3nGKdWlaS1pMhyUAlmTqxqYIXLzyYDB7Bs1JHNI66HUmq4UQuuQAd7CXWNzBHDlLQ
 fuYkvaN2bl6Ea9iwtv8NfYY37fpp7OeLmKA2TXJWlcK3fFtfKz9knHsOh67G51BXPzS0q9aBC
 3zpDG4uh5wuhdKx1a4UcvuTUF0w+gi8x7Fa1dHgRYuKpgrgBuVj8Ipgy6s

Am 25.02.25 um 03:26 schrieb Antheas Kapenekakis:

>> If these "scripts" use `platform_profile_choices` to get their
>> selections and verify they are available then there should be zero
>> breakage. If they don't then they should be updated to be correct.
> Yeah, if any Asus users wrote scripts for their laptops to e.g., "echo
> quiet | sudo tee /sys/firmware/acpi/platform_profile" or used TLP let
> them spend a few days finding out why kernel 6.14 does not work. They
> should have written a 300 line bash script instead.

Hi,

using "echo quiet | sudo tee /sys/firmware/acpi/platform_profile" is quite
brittle, as some hardware will populate the available profiles dynamically=
.

Still breaking userspace is indeed not an option here, so we have to think
of something else.

>> In any case I am in the process of finalising an update to use the new
>> platform_profile API including "custom". Please don't begin trying to
>> break things just to be "first". My work has been ongoing for this
>   drivers/acpi/platform_profile.c    | 57 +++++++++++++++++++++++++-----
>   drivers/platform/x86/amd/pmf/spc.c |  3 ++
>   drivers/platform/x86/amd/pmf/sps.c |  8 +++++
>   include/linux/platform_profile.h   |  7 ++++
>
> I do not see the name Asus here. This is a compatibility patch. You
> should try it before commenting on it further. Looking at my ACPI
> database, there are at least a few Ayaneos, GPDs, and Legion laptops
> that have the ACPI bindings for pmf, this is not an Asus issue.
>
> By the way, I have merged your patch series on Bazzite (well... a
> cleaned up version that does not happen to crash your own software...)
> and it happens to work fine with this patch (I know you said platform
> profiles are not in yet). I still use the asus-wmi APIs personally.
>
> sudo fwupdmgr get-bios-setting
> Authenticating=E2=80=A6          [ -                                    =
 ]
> ppt_pl3_fppt:
>    Setting type:         Integer
>    Current Value:        80
>    Description:          Set the CPU slow package limit
>    Read Only:            False
>    Minimum value:        5
> ...
>
>> in my spare time for months.
> Let me comment on this a bit further. Hobbies are good to have and it
> is nice you found one you like. However, a lot of people are spending
> a lot of money on their Asus laptops and are actually starting to
> depend on Linux. If they cannot depend on you or your hobby for
> support, you should at least make sure to not interfere with parallel
> efforts for that support, if not try to be synergistic.

This whole driver was likely written by someone as a hobby, so you already
depend on a hobby here.

That being said, i agree that fixes have a priority over new features, and
i think everyone agrees on that.

> I did not make this patch to one up you or rush it. This issue is a
> blocker for deploying our 6.13 kernel. Since this kernel needs to work
> for the Z13 and pmf quirks are dead ends now (I also got annoyed by
> asus users complaining about their fan curves being wrong because pmf
> blew up), I pulled in Mario's platform profile series early, only to
> find this issue. Botching the asus-wmi platform handler did not meet
> my standards, so I had to make this series. Also, since I could not
> pull in Kurk's series, and his changes were extensive, I had to make
> this series twice, and test it twice.
>
> Good news is this series works and the kernel is on its way to be
> deployed in a few days. Flatpak fix came in clutch today too with
> 6.13.4.
>
> Antheas
>
Maybe the current strategy of the legacy platform-profile interface can be=
 extended
without introducing the "secondary handler" concept.

The current strategy only advertises platform profiles supported by all ha=
ndlers, and
as you pointed out this causes problems for users on certain devices.

I was thinking that be can change this strategy to advertise all platform =
profiles supported
by at least one handler can then do something like this:

  - handler 1: supports low_power, balanced and performance

  - handler 2: supports quiet, balanced and balanced-performance

-> legacy interface advertises low_power, quiet, balanced, balanced-perfor=
mance and performance

When setting low_power, the closes equivalent is picked for handlers which=
 do not support low_power:

  - handler 1: setting low_power

  - handler 2: setting quiet

When setting quiet, the same happens:

  - handler 1: setting balanced

  - handler 2: setting quiet

Basically all profiles get treated like a range:

low_power <- lower end of the performance range
cool,
quiet,
balanced,
balanced-performance,
performance <- upper end of the performance range

The only problem will be that getting the current platform profile would b=
e more difficult, as
the legacy handler has to determine the lowest currently selected platform=
 profile.

Would this approach be OK?

Thanks,
Armin Wolf


