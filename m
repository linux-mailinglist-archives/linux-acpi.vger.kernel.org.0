Return-Path: <linux-acpi+bounces-8444-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38AA987997
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 21:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D6C1C21AED
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42038156C74;
	Thu, 26 Sep 2024 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="RO7K1jOI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Er+FWCAP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915621D5AD0;
	Thu, 26 Sep 2024 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727378425; cv=none; b=oERG7lvUQVP6vXXze5gIUgzdqF35HuxL7ySpz/f6p3BcjZDqGE35iE2HPOZS7Bf4plvSIkuKTVx945+2WfZh7kaLuSrIrltJU6iPB1aIAqtw3DZDW/v2iV6hUWzybCVM4DhQCnfqlu0UFalf7fIbmgr1WRraEcM/7SEAOQZHOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727378425; c=relaxed/simple;
	bh=UOkur/1A7Seaqvn1shshZsNSOd7/I6bA60OFOnWJE7s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mPnPezIM5Mx0akeCBwQBpkkpEEs9Q8ahJXB8pIhsAIjQRp/TqklPS/I/mWjlFZsWTrtvhdbvLaygZwGF6NlflBP5nrdwqafMk4TtdC4nDpOQKL6QcjUXDLgE20qZOAbTmC7ULYknkwrtlv8AYaBLxafAQuIuIigPUna/HwQEXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=RO7K1jOI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Er+FWCAP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A371F1380180;
	Thu, 26 Sep 2024 15:20:21 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Thu, 26 Sep 2024 15:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1727378421;
	 x=1727464821; bh=e8Y8P0MwuqOH+7/U/uwcpx/9iFt9UW2UW2wwK3qS/GM=; b=
	RO7K1jOIRWMGZZI2HULzijR6g5OVcrrt5gUBlC7mC9Q9ZCWyKZTr4XFV0j61X1SV
	zRFZGmOv3PqW+g57Isq/XfAeNup7Fd34JczXPC/DjkmTaqDgVJi2sGC+JyojrKwf
	NhNM/nOJs2acWblgfBu1QuJTDsUAgdODMvaz6+Uf10R4ydp5BpJ9iDxD9phhQEkc
	NJKrNHfwQhDiuWMGRcTrVY0wLHM8GXUEUQH366VyG4/M6DjgUhfOMYVr4TKnA8w6
	/OAxT0o0/PQoTI+9nspmLg4my1hY1Ubh6cONIW7uI+a3PSxIPc47LEXSOS0BcjZC
	26PAFWvmWver8yGUPuAggg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727378421; x=
	1727464821; bh=e8Y8P0MwuqOH+7/U/uwcpx/9iFt9UW2UW2wwK3qS/GM=; b=E
	r+FWCAPTjUO/K/6MQ4UuGwu33UUqA0wfECzLiqsPTr/34A541SbplEXRHfCtqABI
	+fYpi/MBFT7YFoVx+FluXYBZbxte2XhHx+Kdn5vwApwwb0T1TTskn2QQ5xjNfn11
	XLynjImUouJFWZFroAVLi6AfmtjXWZig+rOKEuu+aKzX2S10juhOKhCecdQlc7Ao
	j6fuQCsYKAAgP3AjWC0uJ0J22vYpYMEPPBboVN81aqwCpmxnaSzQBj0lcM6VD18U
	qDijvFc4G2+3aQaf9+mWv7txs0LqJokawGUrwnGbfcqzis4s79n5wrnXiubi8Imb
	I8gyrijH470aoLFo4q5TA==
X-ME-Sender: <xms:9LP1ZnYlcRMlMTRugqRHQmW8We_mm9fR_xulcpZKRnKX0GTWfJcyWw>
    <xme:9LP1ZmYTkxOM8JC5HJy49NgSjMTgf2a0LINTTiz6zPC5ISXwuB4n6zbnLN2rNg73Q
    7rLFLHUwXSrTmq0Q_k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnheptdffvefgtefhveet
    uddvfeelveektdduvdelgfehgfeikeffjeetjeevffektdfhnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprh
    gtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhhigrmhdq
    shhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimh
    honhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehlkhhmlhesrghnthhhvggr
    shdruggvvhdprhgtphhtthhopegsvghnrghtohdruggvnhhishelieesghhmrghilhdrtg
    homhdprhgtphhtthhopeguvghrvghkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuh
    hpvghrmhdusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgeskhihlhgvghhoshhp
    ohgunhgvthhirdgthhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuh
    igrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:9LP1Zp8-dcYIVfT-82ojxhChPOVfuyJv248aFu8id_jbMZAg-7Usjw>
    <xmx:9LP1ZtrvpbdEn2wEUI1wQ3uZIS4djspQbIdKeMZJwtczm6FrmCfVSw>
    <xmx:9LP1ZirAYKxnQ5Ve8e9afTbG8kHFGxzH-pq9kRAn9CwZd0DiezeXRA>
    <xmx:9LP1ZjQqdmVTAPI-j21wnbynxauZXW_q3hdS4vDnHGCgSeoYrivl8Q>
    <xmx:9bP1Zn7lCzHQKay07DURk51UhyjlStKBb-aoPyQTMwkr3YCaonMGY3Wu>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4701F3C0069; Thu, 26 Sep 2024 15:20:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 15:19:32 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Mario Limonciello" <superm1@kernel.org>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>
Cc: 
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Antheas Kapenekakis" <lkml@antheas.dev>, me@kylegospodneti.ch,
 "Denis Benato" <benato.denis96@gmail.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>
Message-Id: <5dcc2f87-e8c0-4f33-9b75-054eb0acb81a@app.fastmail.com>
In-Reply-To: <7bfba4ef-0f42-4482-874f-77a4434eb338@kernel.org>
References: <20240926025955.1728766-1-superm1@kernel.org>
 <2d07d31e-87f6-4576-977d-336f3d0bbc81@app.fastmail.com>
 <7bfba4ef-0f42-4482-874f-77a4434eb338@kernel.org>
Subject: Re: [RFC 0/2] "custom" ACPI platform profile support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Sep 26, 2024, at 2:14 PM, Mario Limonciello wrote:
> On 9/26/2024 08:58, Mark Pearson wrote:
>> Thanks Mario,
>> 
>> On Wed, Sep 25, 2024, at 10:59 PM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> There are two major ways to tune platform performance in Linux:
>>>   * ACPI platform profile
>>>   * Manually tuning APU performance
>>>
>>> Changing the ACPI platform profile is a "one stop shop" to change
>>> performance limits and fan curves all at the same time.
>>>
>>> On AMD systems the manual tuning methods typically involve changing
>>> values of settings such as fPPT, sPPT or SPL.
>>>
>>> The problem with changing these settings manually is that the definition
>>> of the ACPI platform profile if supported by the hardware is no longer
>>> accurate.  At best this can cause misrepresenting the state of the
>>> platform to userspace and at worst can cause the state machine into an
>>> invalid state.
>>>
>>> The existence and continued development of projects such as ryzenadj which
>>> manipulate debugging interfaces show there is a demand for manually tuning
>>> performance.
>>>
>>> Furthermore some systems (such as ASUS and Lenovo handhelds) offer an
>>> ACPI-WMI interface for changing these settings. If using anything outside
>>> that WMI interface the state will be wrong.  If using that WMI interface
>>> the platform profile will be wrong.
>>>
>>> This series introduces a "custom" ACPI platform profile and adds support
>>> for the AMD PMF driver to use it when a user has enabled manual
>>> adjustments.
>>>
>>> If agreeable a similar change should be made to asus-armoury and any other
>>> drivers that export the ability to change these settings but also a
>>> platform profile.
>>>
>> 
>> As someone who supports customers on Lenovo devices and hits the occasional situation where a user has made strange tweaks to different power related settings, and then complains about power or thermal issues - I love the idea that it can be made clear the system has been 'adjusted' in a non standard way. I can also see why users would want interfaces to do those changes.
>
> JFYI we're going to do something really similar in amdgpu when people 
> have enabled overclocking.  That's part of the inspiration for this RFC.
>
> https://lore.kernel.org/amd-gfx/CADnq5_M+vxGV6y8oEQHC+-CcqV-vW9ND4SsRHqHKbwR_b0iJ9g@mail.gmail.com/T/#m1d69399c3e799ea1ef2014a27fd6e555f9e70ba0
>

Nice :)

>> 
>> Some suggestions:
>> 
>> I'm wondering if we can make it so a driver can register only a 'custom' profile as an extra profile handler?
>> 
>> The thinking here is the custom setting in this series is implemented for the amd sps driver, and therefore on a regular Lenovo laptop wouldn't be used, as the thinkpad_acpi driver will grab the profile slot, Users on Lenovo systems aren't going to be able to get at these extra tweaks (unless they unload thinkpad_acpi, which has other side effects).
>
> Well the RFC was just to show it for the AMD PMF driver, but I think 
> that thinkpad_acpi, asus_armoury etc could all potentially implement the 
> 'custom' bit too if they offer an ACPI-WMI interface to similar settings.
>
>> 
>> If the sps driver can offer a custom mode, separately from thinkpad_acpi, then users can tweak settings to their hearts content but get back to regular mode when done.
>> 
>> I also think there needs to be a way that when you switch from custom back to a 'regular' profile that it would do a clean up of anything tweaked. e.g. when switching away from custom the ppd driver should call a 'custom mode cleanup' function, so things can be undone and returned to how they were when it was started.
>> 
>> Mark
>
> I guess what you're proposing is that multiple drivers register as 
> profile handlers and they might not all export the same features.
>
> If we did something like this we could instead have the core call 
> callbacks for all platform profile handlers.  We could also drop a pile 
> of quirks from amd-pmf where there are some ASUS systems that advertise 
> SPS in in the PMF framework and also asus-wmi provides it.
>
> If I'm following you right, I generally like this idea.

Yep - that was the idea.

This feels like a step towards giving more control to power users - whilst keeping the basic simple for regular folk.

I can imagine utilities that would use this to enable specific configurations, via the custom profile mode, for many different scenario's; whilst still allowing a user to get back to the tested and vendor approved setting if things go badly.

Mark

