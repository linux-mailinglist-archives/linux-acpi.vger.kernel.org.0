Return-Path: <linux-acpi+bounces-11647-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC21A4A2E5
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 20:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502CF174DFE
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 19:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D41F875F;
	Fri, 28 Feb 2025 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mew5pbYV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD111C175A;
	Fri, 28 Feb 2025 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740771891; cv=none; b=Ai55osaqe4w/Xk01TdxB0ckya5CCGUdiep5B/TPWJoWVggJvsOCVqfwHjz//HFDnadEdOtF5uhiqisc1cLgKcL54iS1CwdZRLq3LybGxHhrE52/Epj6HGwL59QAn0glpm8v2vXiozy9oKuCSpefH+IQ4jFe5k9h9N6Y/hJa+RNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740771891; c=relaxed/simple;
	bh=424Fkn4nNOCM9Y+dMU7/oT2OuRdwLB0LtXdfrXQYFT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZGyMGV4LBoE3oF554ioexkybmMzNe9ekeELRyE22aq1aqw5kUsTnmiJ1efvDEN7HCpXD1Lb9BA9kyePIauHwPIS2D6mAhHKI9SQqXEtuW46lGbl1Qmblz7B04KnCcvtbAgf7P00rw4r0JcokfDGFPwbIJ4i52LyImFjZ6kCZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mew5pbYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158BCC4CED6;
	Fri, 28 Feb 2025 19:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740771891;
	bh=424Fkn4nNOCM9Y+dMU7/oT2OuRdwLB0LtXdfrXQYFT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mew5pbYVg3EwYGrCytG89O+ckCtqo2Tg44sbp9jb5U87yFSdfqajIqtHQlgwx8Hz2
	 7u2gim0UuqVIHDzNPoXkScKdgYYFLY/nAC7CEse8dRbpOiL0mwW1Ea3RsLN4P/4gQe
	 7ya6h/1hZTN6BsNi0z0TrPzAqlxpzyupMl/ExgZjoUtHfxdWaUUefnSMncK9NfqM7e
	 DyYdDFSadn0Xd+v30O0u7zNkmzNWjldYFfc6OLr/6j0rFJT7EYYZZAEKeYHVkI9g6f
	 tbAdoUKyRXjiIky332OnPWfSSaaOLYBi6bD1MGmjzME1ZQR8lRcg/mUTNI0bvWyHaX
	 6OC03Om5038tw==
Message-ID: <7d76a774-9dad-4c94-b4df-7c040e9dbc47@kernel.org>
Date: Fri, 28 Feb 2025 13:44:49 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for hidden choices to platform_profile
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Luke D . Jones" <luke@ljones.dev>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>
References: <20250228170155.2623386-1-superm1@kernel.org>
 <fcf58c76-2c0b-4892-96aa-c9b5b35c3e68@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <fcf58c76-2c0b-4892-96aa-c9b5b35c3e68@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/2025 13:39, Mark Pearson wrote:
> Hi Mario,
> 
> On Fri, Feb 28, 2025, at 12:01 PM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> When two drivers provide platform profile handlers but use different
>> strings to mean (essentially) the same thing the legacy interface won't
>> export them because it only shows profiles common to multiple drivers.
>>
>> This causes an unexpected behavior to people who have upgraded from an
>> earlier kernel because if multiple drivers have bound platform profile
>> handlers they might not be able to access profiles they were expecting.
>>
>> Introduce a concept of a "hidden choice" that drivers can register and
>> the platform profile handler code will utilize when using the legacy
>> interface.
>>
>> There have been some other attempts at solving this issue in other ways.
>> This serves as an alternative to those attempts.
>>
>> Link:
>> https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#t
>> Link:
>> https://lore.kernel.org/platform-driver-x86/CAGwozwF-WVEgiAbWbRCiUaXf=BVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com/T/#m2f3929e2d4f73cc0eedd14738170dad45232fd18
>> Cc: Antheas Kapenekakis <lkml@antheas.dev>
>> Cc: "Luke D. Jones" <luke@ljones.dev>
>>
>> Mario Limonciello (3):
>>    ACPI: platform_profile: Add support for hidden choices
>>    platform/x86/amd: pmf: Add 'quiet' to hidden choices
>>    platform/x86/amd: pmf: Add balanced-performance to hidden choices
>>
>>   drivers/acpi/platform_profile.c    | 94 +++++++++++++++++++++++-------
>>   drivers/platform/x86/amd/pmf/sps.c | 11 ++++
>>   include/linux/platform_profile.h   |  3 +
>>   3 files changed, 87 insertions(+), 21 deletions(-)
>>
>> -- 
>> 2.43.0
> 
> The patches are all good - but my question is do we really need the whole hidden implementation bit?
> 
> If the options are not hidden, and someone chooses quiet or balanced-performance for the amd-pmf driver - does it really matter that it's going to do the same as low-power or performance?
> 
> So, same feedback as I had for Antheas's patches. I understand why this is being proposed but for me it is making things unnecessarily complicated.
> 
> My personal vote remains that the amd_pmf driver carries the superset to keep everyone happy (sorry - it sucks to be the CPU vendor that has to play nice with everyone).
> 
> Mark

Well so the problem with having all of them is specifically what happens 
when "only" amd-pmf is bound?

If you advertise both "low power" and "quiet" it's really confusing to 
userspace what the difference is.

The fact that it's actually 100% the same brings me to my personal 
opinion on all of this.  Although I spent time writing up this series to 
do it this way my "preference" is that we permanently alias "low power" 
and "quiet" to one another and update all drivers to use "low power" 
instead.

Granted that doesn't help the case of balance-performance being hidden 
that Antheas mentioned for acer-wmi and legion-wmi but I don't know 
serious of a problem that actually is.

