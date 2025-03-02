Return-Path: <linux-acpi+bounces-11676-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44608A4AF0E
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Mar 2025 04:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A2C3B24DE
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Mar 2025 03:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3D82C859;
	Sun,  2 Mar 2025 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="mFjvI+9Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tC10bKHw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149981C695;
	Sun,  2 Mar 2025 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740885814; cv=none; b=NlK/Zn/FdvShzR6a4m06IXf2ki+3Ps3YWQ+419Z+yl0DeYzCJLOcwyDmohjXclM7LnpzlTvJgtyQLluk4T+KkYConVEzCvsIuzqZdCSWAAWQbedwsRCtcfZq+LHouLfEJnN1NL4AiyDompvXTBFAyQNi4AhRv6EU8gLgvHxjuqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740885814; c=relaxed/simple;
	bh=WPf+KF2WIzKDClC0rl7S2pBiWMZDE5SaCG/7d4ehSZM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tt06+6RFGq3mRhyIa+4Tz1QUpJYezcO+yoSZis5Vh60RPwR/VRyDWS45A2DBOFHrjwG1dn1W1VcFAZ7+J212c7bhKrPmZ0EXjwanVZ5NJ/D7tM6YjOucDThTWT6Zh8NzGqv2w1T4AYV1zuQ2HCjRPJ4KmhwZ6wpd/CJ2wlEV6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=mFjvI+9Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tC10bKHw; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D2C3F1380EF8;
	Sat,  1 Mar 2025 22:23:30 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-06.internal (MEProxy); Sat, 01 Mar 2025 22:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740885810;
	 x=1740972210; bh=EXRTfR75mciVRw9h+kwh8V3AdBDrsScfn1nZm7ynIwE=; b=
	mFjvI+9ZCIccdQRgeTPptT6mGMP6fJlsFLO2YXF30av7M8rQ4607+2PWau2QmL3g
	2vVzkKIEa/CfmJDP4grDSValCiC06H5096nxvB4snJZlBWKRVs1oYFrJdPDQRzoM
	bOOPRcGvUIUVswMUEDRfHBEzLxZyXzr18i0BjykYo3HQFcBIBvB6CV1Ub7JsZpTL
	i1fxRNgnesrwfWsiqBeugCpEISRVSZjtqIOM3YfVkErXSemop7jzLjek+KRSdlpn
	xUw/DA9Siq2s46wAHeDRYuK3NpUwqE8bQTG49OXrrx+xDj+2lGjYcbEbTU8gsqlK
	WHOZwxFeoYgMfwg82p+1nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740885810; x=
	1740972210; bh=EXRTfR75mciVRw9h+kwh8V3AdBDrsScfn1nZm7ynIwE=; b=t
	C10bKHwRA9SSuttTEQ5i8DMhI6eD5LBZqNe+OPDKsdfkByAvh+mJDzVi/FtpTxUg
	ncL1jFT117LdloGuTZAxzyx4jBvJxBtJjuC9SKWp6j0YRDBI7R7NgrmGqkHn94om
	9DKdU6iWIyVvRYCljIBubRn/jtaJLTrftzk9sGMV9dgjUHWColVP4dMTfhPLDC4S
	h7CIS9IjIhjSToyS+9A2QjQGZB6PMHY2Pd8vMIQFjb7EneljeLLxMc+C+FrvN+MK
	3M3bSzeovPHYRiaA0F9VtWAxKStPHJGwN7vIN4GNMrcwG4knFa6CikW0UBTFa8vO
	Eqcj8oD01iiQcAms9KaLg==
X-ME-Sender: <xms:Mc_DZ8eAiEn6lMIMZRxqOmjnFuSNx-6tjyJs5TS6wpPPopqstsMgoA>
    <xme:Mc_DZ-O6O4TWUrys-LicX_D61IFOgnInetd-cXlF8oBwIqx5EhdWsSWGrkbCnEpwR
    GDBpfRxYFMKHEBVN5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelheduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfeuvdehteeghedt
    hedtveehuddvjeejgffgieejvdegkefhfeelheekhedvffehnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehshhihrghmqdhsuhhnuggrrhdrshdqkhesrghmugdrtghomhdp
    rhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtg
    hpthhtoheplhhkmhhlsegrnhhthhgvrghsrdguvghvpdhrtghpthhtohepsggvnhgrthho
    rdguvghnihhsleeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvrhgvkhhjohhhnh
    drtghlrghrkhesghhmrghilhdrtghomhdprhgtphhtthhopehkuhhurhhtsgesghhmrghi
    lhdrtghomhdprhgtphhtthhopeifpggrrhhmihhnsehgmhigrdguvgdprhgtphhtthhope
    hrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhuphgvrhhmudeskhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Mc_DZ9jc-hHUDaNysPljslLlAiq_lB9WM610a9leVQXbIO5B_lST0A>
    <xmx:Mc_DZx-EPTYawQQ4H6Xgqsx1fOezXl811108F8pWa-LbGzBOQAWieQ>
    <xmx:Mc_DZ4vfvEcP5lGH5LDMGjKbrZp7BE8x1xMsPQ_OssygLRVaSmLcgQ>
    <xmx:Mc_DZ4GsTFv1IHporuaPaw1QUjme83th2U5rZfaopuKEbD3RKkUznQ>
    <xmx:Ms_DZ8PMXtWZtHEPhiGecT1QBcN-VgGqkCvNCIvIYAaF7JsMFOJ0_rkS>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CECCA3C0066; Sat,  1 Mar 2025 22:23:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 01 Mar 2025 22:23:09 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Antheas Kapenekakis" <lkml@antheas.dev>,
 "Mario Limonciello" <superm1@kernel.org>
Cc: "Kurt Borja" <kuurtb@gmail.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 "Denis Benato" <benato.denis96@gmail.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Armin Wolf" <W_Armin@gmx.de>
Message-Id: <299cc6b8-a43b-4bc0-a7dd-ce3bde5f1a48@app.fastmail.com>
In-Reply-To: 
 <CAGwozwEVDkArYZLg+pvZrh02TtGM4+6EH5GCRpjxEAwMH4xZ+A@mail.gmail.com>
References: <20250228170155.2623386-1-superm1@kernel.org>
 <20250228170155.2623386-2-superm1@kernel.org>
 <D84F6QF8EU3D.3RUI1PKXP2DZ3@gmail.com>
 <6f56571a-3090-4323-a29d-008b916abf39@kernel.org>
 <CAGwozwGFLQxGEQ-nb+d9yrikz=fx+u48mpTYUyUtvgFD-9ypQg@mail.gmail.com>
 <09674d15-d639-4cb3-837a-9575f0028a76@kernel.org>
 <CAGwozwFm1HeLNtJNGOdQCe_poWeNNeOB=3EzizFx_p2rB-RXbQ@mail.gmail.com>
 <59634335-9365-454b-8f07-1b8f564e5f29@kernel.org>
 <CAGwozwEVDkArYZLg+pvZrh02TtGM4+6EH5GCRpjxEAwMH4xZ+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: platform_profile: Add support for hidden choices
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Mar 1, 2025, at 11:15 AM, Antheas Kapenekakis wrote:
> On Sat, 1 Mar 2025 at 17:04, Mario Limonciello <superm1@kernel.org> wrote:
>>
>>
>>
>> On 3/1/25 08:06, Antheas Kapenekakis wrote:
>> > On Sat, 1 Mar 2025 at 14:52, Mario Limonciello <superm1@kernel.org> wrote:
>> >>
>> >>>>> Let me know what you think!
>> >>>>
>> >>>> I don't really like that profiles can get out of sync, this is asking
>> >>>> for a non-deterministic behavior that can be difficult to diagnose
>> >>>> issues and also difficult for userspace to work with.
>> >>>
>> >>> I agree with Mario here. Imagine two drivers, one with low-power and
>> >>> one with quiet. They both begin at performance.
>> >>>
>> >>> Then, userspace software gets confused (incl. ppd) and sets firmware
>> >>> profile to low-power. The latter gets left in performance, causing
>> >>> excess drain.
>> >>>
>> >>> I do not believe the legacy interface should be deprecated. Right now,
>> >>> amd-pmf is a NOOP in most devices
>> >>
>> >> "Most" devices is not accurate.  There are a lot of devices that it does
>> >> enable.  In the gaming space right now it's often behaving as a no-op.
>> >
>> > That would be a fair description. Can you give some examples of
>> > devices that use the interface? Devices with and without vendor
>> > software.
>>
>> Off hand the Framework 13 and 16 AMD both use PMF exclusively.  So do a
>> bunch of HP commercial laptops.
>
> I will ask Kyle to check it out.
>
>> Mark can keep me honest, but I want to say the Strix Thinkpad laptops
>> have both PMF and vendor interface (thinkpad-acpi).
>
> Hm, yeah that would be interesting to hear about
>

Yep, support both.

>>   >>
>> >> "Power mode" is a concept, it doesn't just apply to configuring sPPT and
>> >> fPPT.  I envisage that a vendor that actively uses PMF and their own
>> >> interface would be changing different things by the different interfaces.
>> >>
>> >> For "example" PMF may reconfigure sPPT, fPPT, STT and STAPM but their
>> >> driver may notify their EC to change a fan curve.
>> >
>> > No. If PMF changes these values it also needs to change the fan curve
>> > itself via the BIOS notification. Doing otherwise would lead to
>> > situations where users do not install the vendor driver and cook their
>> > device.
>>
>> Fan curves are just that; curves.  They just control how quickly fans
>> ramp up not whether or not they "work".
>
> The APU reaches a similar temperature (Tctl) across a wide TDP range,
> so temperature cannot be used on its own to determine fan speed.
> Manufacturers that provide different fan curves depending on the TDP
> mode usually cap the maximum fan speed on low TDPs. So you can get
> funny situations where the device is set to 30W, but the fan runs as
> if its using 10W leading to thermal soaking. So it is very important
> for those to be inline.
>
>> But in any case; that's a firmware issue not a platform profile design
>> issue.
>
> It would be a hypothetical scenario. I do not expect such a device to exist.
>
>> > So I expect that when PMF controls things it controls
>> > everything. I would expect if vendors fallback to the pmf firmware
>> > notifications while also providing vendor software there would be some
>> > synergy between them, such as changing which fan preset is selected by
>> > the PMF interface.
>> >
>>
>> I can't control what vendors do; it's their decision how to manage their
>> systems.  All I can do is provide infrastructure to help.
>
> This was more of my intuition of how I would expect amd-pmf
> integration to be done in Windows where one of the drivers might be
> missing.
>
> Since only thinkpads are expected to do both, perhaps Mark can check
> out how they work. I have a thinkpad that is 11th gen intel.
>

I'll do some checking next week (away this weekend). Mario will ping you offline for best testing to do.

Mark

