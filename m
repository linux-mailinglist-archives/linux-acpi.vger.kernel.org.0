Return-Path: <linux-acpi+bounces-11670-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35043A4ACBB
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 17:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5BA3B57E5
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED3C1DF252;
	Sat,  1 Mar 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pkgc1cuW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE31487D1;
	Sat,  1 Mar 2025 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844995; cv=none; b=uof1r+RfL6l1Er7iTvBiP+rgaD1hsxXHHsW4F8VTH3eqjZaJopIcSIvROqw0+3ohZ8fdu5docxKkaxoEa2oBfQ6nzJR8iT99SmCvyiWGRP6HDrhxtiSWjllYUq7g/Puxdrf1RSMYdYa8dFC0ZIdn2ywcACRdU4JFNE6gmtxcGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844995; c=relaxed/simple;
	bh=eFuOUuXJbMPwC2kemdWKpdpEneyzzQTSTYZreEr9L2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TS0De1hGQR2yYTrU1xv9cMaJox//8czwZeD2b43cqMNe22lu0sBlpBYjGUAbWhjeNt2gLKrthQPDj3tkO/mSVfNEWkgNvBNSGQ8MgkXblAStbQcM2IY2khOXtvtBLnKOtvMLy+dbHQkcnOfuvmUPMJsMdkgIOxX6rOH6CgtYuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pkgc1cuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE927C4CEDD;
	Sat,  1 Mar 2025 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740844994;
	bh=eFuOUuXJbMPwC2kemdWKpdpEneyzzQTSTYZreEr9L2o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pkgc1cuWOPS7Pv9Wu+g3FoX4QxSUT5NP1s7ezesjiN5UR/n8okP9f9A6ESQ525Vsr
	 aHcP/S2AaMIPGNVCSgI4AuGVRlwlMi/CohWdmchPOWm/A0ogfbXKAVZGxovvp0lWob
	 FsEj5t4OWgZdb4bzjYA2GDv5M7yTBoohiQVWnfp0iz9z8bXBL++lLMF5qXBv9CPlgn
	 GML8VQnIBqi93HnAED8jdJur77hrfSKSU6yDUwxisfVFIyLt/wVPPcWxP35roPhP6N
	 9gbJaqnx3s4sTWU3snk8fqwcbWBA507yQFTslTfDVTNiOKTQLnSvoAMGU4MaDF6lWN
	 RgYr90Dtxb2sw==
Message-ID: <59634335-9365-454b-8f07-1b8f564e5f29@kernel.org>
Date: Sat, 1 Mar 2025 10:03:10 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: platform_profile: Add support for hidden
 choices
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Kurt Borja <kuurtb@gmail.com>, Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>, Mark Pearson
 <mpearson-lenovo@squebb.ca>,
 "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
References: <20250228170155.2623386-1-superm1@kernel.org>
 <20250228170155.2623386-2-superm1@kernel.org>
 <D84F6QF8EU3D.3RUI1PKXP2DZ3@gmail.com>
 <6f56571a-3090-4323-a29d-008b916abf39@kernel.org>
 <CAGwozwGFLQxGEQ-nb+d9yrikz=fx+u48mpTYUyUtvgFD-9ypQg@mail.gmail.com>
 <09674d15-d639-4cb3-837a-9575f0028a76@kernel.org>
 <CAGwozwFm1HeLNtJNGOdQCe_poWeNNeOB=3EzizFx_p2rB-RXbQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwFm1HeLNtJNGOdQCe_poWeNNeOB=3EzizFx_p2rB-RXbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/1/25 08:06, Antheas Kapenekakis wrote:
> On Sat, 1 Mar 2025 at 14:52, Mario Limonciello <superm1@kernel.org> wrote:
>>
>>>>> Let me know what you think!
>>>>
>>>> I don't really like that profiles can get out of sync, this is asking
>>>> for a non-deterministic behavior that can be difficult to diagnose
>>>> issues and also difficult for userspace to work with.
>>>
>>> I agree with Mario here. Imagine two drivers, one with low-power and
>>> one with quiet. They both begin at performance.
>>>
>>> Then, userspace software gets confused (incl. ppd) and sets firmware
>>> profile to low-power. The latter gets left in performance, causing
>>> excess drain.
>>>
>>> I do not believe the legacy interface should be deprecated. Right now,
>>> amd-pmf is a NOOP in most devices
>>
>> "Most" devices is not accurate.  There are a lot of devices that it does
>> enable.  In the gaming space right now it's often behaving as a no-op.
> 
> That would be a fair description. Can you give some examples of
> devices that use the interface? Devices with and without vendor
> software.

Off hand the Framework 13 and 16 AMD both use PMF exclusively.  So do a 
bunch of HP commercial laptops.

Mark can keep me honest, but I want to say the Strix Thinkpad laptops 
have both PMF and vendor interface (thinkpad-acpi).
  >>
>> "Power mode" is a concept, it doesn't just apply to configuring sPPT and
>> fPPT.  I envisage that a vendor that actively uses PMF and their own
>> interface would be changing different things by the different interfaces.
>>
>> For "example" PMF may reconfigure sPPT, fPPT, STT and STAPM but their
>> driver may notify their EC to change a fan curve.
> 
> No. If PMF changes these values it also needs to change the fan curve
> itself via the BIOS notification. Doing otherwise would lead to
> situations where users do not install the vendor driver and cook their
> device. 

Fan curves are just that; curves.  They just control how quickly fans 
ramp up not whether or not they "work".

But in any case; that's a firmware issue not a platform profile design 
issue.

> So I expect that when PMF controls things it controls
> everything. I would expect if vendors fallback to the pmf firmware
> notifications while also providing vendor software there would be some
> synergy between them, such as changing which fan preset is selected by
> the PMF interface.
> 

I can't control what vendors do; it's their decision how to manage their 
systems.  All I can do is provide infrastructure to help.

