Return-Path: <linux-acpi+bounces-8441-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D29878DB
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 20:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6404A1C210D8
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 18:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838FD15F308;
	Thu, 26 Sep 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYBfYdyt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533BB26AE6;
	Thu, 26 Sep 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374153; cv=none; b=hmwVY9MqPRPKuc8phfBBUeSGHEI1QmVlizBDovm7b/6sIUPibMJZjSZRUL+uqJXGww0Omqj+DxVW/eIsr3qOvOaygwNOTeooHMjKlilODdJdUGV5XDVG/jbq6SnHKIOcattHUHgJfts59XFgtEHfxpOf9J2WL9EqZa5m8M0ZosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374153; c=relaxed/simple;
	bh=aW4HaPysR4BZas3D4OloyZPYqiYG/jzTmy8XMsvWbl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3LK+zYuVXr5MGoBt8TTaF1b+qU+t2hz4qWlvDbVX6cduCsf0La1GYKj0nXBZT249vK4BZFY2p77HT3uVVas3DwiyuSTQgUtBH0X1SJqih42AQRo/n15M3rjGYpof5w+5feOLgvE9v4/tbv7KzgritKavnZXd3jK+EcnoMEwHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYBfYdyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5C9C4CEC5;
	Thu, 26 Sep 2024 18:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727374152;
	bh=aW4HaPysR4BZas3D4OloyZPYqiYG/jzTmy8XMsvWbl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VYBfYdytYSCzvYc0a63DTb856RytSGeqMrFAn2CjqZqGFIiDvr4h95sEJfF1L7xk/
	 WEEU4HwkhQJ7ooD7JJR0WRi2hsVrRtjjuwDFHPu8EBBCaagN1ga3hvo9n8zqsa2lsc
	 SMu+QP267XP+N2P/sGDSwhkomyceKYOSoTYyUrzDeLtw8MBqyGOul5e7mYZPga6gw1
	 M1nT7TR33X4qeLqb2XVzUXsRnjozivnxTAPLxycsWFbLd3xljC27BgalJhwLBWWcns
	 mq8zVWepdu/kL4InsZzxohTX41Z12s8+HqtIXbVOKqND9r44fofFGCV/O4E9iqfGbC
	 KdEc7PKRg7Vtg==
Message-ID: <f516dd07-7d7b-403e-a55e-6bf21dbea9b4@kernel.org>
Date: Thu, 26 Sep 2024 13:09:10 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] platform/x86/amd: pmf: Add manual control support
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>, Mark Pearson
 <mpearson-lenovo@squebb.ca>,
 "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240926025955.1728766-1-superm1@kernel.org>
 <20240926025955.1728766-3-superm1@kernel.org>
 <5a75b73f-dcb1-4a45-9526-194a3451b5c6@amd.com>
 <CAGwozwGtqwOOfrUpjLghW4JCKqcFk9ut-X0MBvHAm37YVS51tw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwGtqwOOfrUpjLghW4JCKqcFk9ut-X0MBvHAm37YVS51tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/2024 06:00, Antheas Kapenekakis wrote:
> Hi Shyam,
> 
>> I appreciate the proposal, but giving users this control seems similar
>> to using tools like Ryzenadj or Ryzen Master, which are primarily for
>> overclocking. Atleast Ryzen Master has a dedicated mailbox with PMFW.
> 
> In the laptop market I agree with you. However, in the handheld
> market, users expect to be able to lower the power envelope of the
> device on demand in a granular fashion. As the battery drop is
> measured in Watts, tying a slider to Watts is a natural solution.
> 
> Most of the time, when those controls are used it is to limit the
> thermal envelope of the device, not exceed it. We want to remove the
> use of these tools and allow manufacturers the ability to customise
> the power envelope they offer to users.
> 
>> While some existing PMF mailboxes are being deprecated, and SPL has
>> been removed starting with Strix[1] due to the APTS method.

Hmm, what do you think about about offering a wrapper for this for 
people to manipulate?

>>
>> It's important to use some settings together rather than individually
>> (which the users might not be aware of). For instance, updating SPL
>> requires corresponding updates to STT limits to avoid negative outcomes.
> 

The tough part about striking the balance here is how would an end user 
know what values to set in tandem.  I think a lot of people just assume 
they can "just change SPL" and that's it and have a good experience.

> This suggestion was referring to a combined slider, much like the
> suggestion below. So STT limits would be modified in tandem,
> respecting manufacturer profiles. See comments below.
> 
> If you find the name SPL disagreeable, it could be named {tdp,
> tdp_min, tdp_max}. This is the solution used by Valve on the Steam
> Deck (power1_cap{+min,max}, power2_cap{+min,max}).

It's not so much that it's disagreeable term but Shyam is pointing out 
that SPL is no longer a valid argument to the platform mailbox.

> 
> In addition, boost is seen as detrimental to handheld devices, with
> most users disliking and disabling it. Steam Deck does not use boost.
> It is disabled by Steam (power1_cap == power2_cap). So STT and STAPM
> are not very relevant. In addition, Steam Deck van gogh has a more
> linear response so TDP limits are less required.
> 
>> Additionally, altering these parameters can exceed thermal limits and
>> potentially void warranties.
>>
>> Considering CnQF, why not let OEMs opt-in and allow the algorithm to
>> manage power budgets, rather than providing these controls to users
>> from the kernel when userspace tools already exist?

The problem is all of the RE tools rely upon PCI config space access or 
/dev/mem access to manipulate undocumented register offsets.

When the system is under kernel lockdown (such as with distro kernel 
when UEFI secure boot is turned on) then those interfaces are 
intentionally locked down.

That's why I'm hoping we can strike some sort of balance at the request 
for some advanced users being able to tune values in a predictable 
fashion while also allowing OEMs to configure policies like CNQF or 
Smart PC when users for users that don't tinker.

>>
>> Please note that on systems with Smart PC enabled, if users manually
>> adjust the system thermals, it can lead to the thermal controls
>> becoming unmanageable.

Yeah; that's why as this RFC patch I didn't let CNQF, ITS or Smart PC 
initialize.  Basically if manual control is enabled then "SPS" and 
manual sysfs control is the only thing available.

> 
> Much like you, we dislike AutoTDP solutions that use e.g., RyzenAdj, as they:
>   1) Do not respect manufacturer limits
>   2) Cause system instability such as stutters when setting values
>   3) Can cause crashes if they access the mailbox at the same time as
> the AMD drm driver.
> 

Yes.  Exactly why I feel that if we offer an interface instead people 
can use such an interface instead of these tools.

