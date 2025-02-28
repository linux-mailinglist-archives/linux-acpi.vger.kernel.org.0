Return-Path: <linux-acpi+bounces-11650-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4537DA4A394
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 21:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7984117C6FB
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEB225179E;
	Fri, 28 Feb 2025 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="eEKFrIBw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5ovHJHK1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D9251793;
	Fri, 28 Feb 2025 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773035; cv=none; b=d7rWsWxPS6k/tJ48srmrjTnJ75Rfg5mH2ZlJUkgM4F3GKU4fotCU7hFswQkAmYrLGd1/sdC/ROH/n7wXcd4MJMS2B+4HzT7DSf3J3lcPw6gGEVlAQfVWfkJQxMV8gj8l+HD9rHGZdZsk01rrPVHyZgnWiK1AAghBss2CfTT6A/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773035; c=relaxed/simple;
	bh=nFP+C540tk3X6xmpiQ6nE9j425j4j6sXR0rZTPN2pB8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hU7hkIFH5RTGbjgcG9I5a0my6PZmRzT8Ihskw+UeS+uEsBfr6QbSieSNz+5pG0p5IUemMUOz/Zyrul6rZXaZ/S5x5WyfM2m8K4a7bSP9rAjkNE5/pt653oFkIe4VY2vMsWOBDCOsRrSo4Rb+RWtodXq8F8R7Tx2vF24bvnDNYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=eEKFrIBw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5ovHJHK1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F008A1380A2C;
	Fri, 28 Feb 2025 15:03:51 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-06.internal (MEProxy); Fri, 28 Feb 2025 15:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740773031;
	 x=1740859431; bh=wPYXLIBT+Wmadp6rYziFldTcVGulm1uvonrgbV8TXWE=; b=
	eEKFrIBwrIFEhG4tjJhhXUrW1nNf0rWs/ioC0iuTxIODGWMfMBVY9PDSVUTkUElT
	z9NPTtaXwwCH63YJ4+ayq/IG8r8W3M1QgWYjTtW2E75UZzido1HVcx+fAy/+Wm8N
	doZLvad/JFMoXBcuX9kbdz0ajrVsGJndTjURiTrZ1pmqq2feMkBow9Ue3JkOwn9B
	c99ZXtXTTaTzK9QgOWzQunhI6mKRUfaiF1JUqsS+YT665nJBwVYaugGjXQMgr5NJ
	H0IcA1Hxhq0yGlzIGQRvIuc7rGeQVcuQAHJc0WW6RAO707R2GNxARID4wZGPcc/J
	elmf8Lsq205P4cPJKsgvZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740773031; x=
	1740859431; bh=wPYXLIBT+Wmadp6rYziFldTcVGulm1uvonrgbV8TXWE=; b=5
	ovHJHK1xYYDjVF/+yOGMI80utAj0qxLXxHf3EkvSjrsnOMx06+1NpLk7sJRj3oCS
	O2H5oCQJtm2I0r7gnwHX+//V+vQHlyNF+0qSbj4dsbA2qA9lyIHXUssaNlvP5Zbl
	kcLC5bvsHz2mJEJt91o6gqC3xtB6gLC9iszsl/8aPOvdSRQJEW73KwW5IrMUs0Nn
	R3vkJza10QbCCTb91JXhCi6k20dIW3fCIP4T+VaoLOlGG6bpaq2+IosIkd+BZsp9
	ZMJI88kb8wsuXV0ErkIphYEjVq8RUtq94D+0L2f+21QFnyZk+i/8WrYB/d+aenYW
	kdC4+JIKnhH+tRB1aenLw==
X-ME-Sender: <xms:pxbCZ0uxmrDcWy7jcwTR9JMmiuNfxUeGHoaIoHRqw4oguDm3gzLiNg>
    <xme:pxbCZxf7QPBkSHO-Pknd2BwkVr1iw7gXodxYHPYTbsPwqTmmrgUYn5bQ2MFCMmtY9
    FzbXutLBR7bSIysQ7M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeludeftdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:pxbCZ_zq1Q_6WSAOpzbGxbIsogjrm5YU1dOY84la9kSO2yhBJE-ljA>
    <xmx:pxbCZ3PhZlzd667izWOhQ7SB9YsnKoar1b2WScqol4MI00YyiqsCTQ>
    <xmx:pxbCZ08Uo5JJhGV6yXMfRPyW5yZi8AqWD5acDFAf0zMLxXKg34NMmQ>
    <xmx:pxbCZ_U7aa9KQ5_EUdC9_4C8sXx1MgRF1RWQa7Mtogf-RhzF_NYjFA>
    <xmx:pxbCZ-eT_HMrhA9ZOQ0Hv4Frd075xGRHdRyAQ7Ak9bHu-2iIaUlktlzQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 31B093C0066; Fri, 28 Feb 2025 15:03:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Feb 2025 15:03:29 -0500
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
Message-Id: <07a94bc8-ee1a-41ea-bfd9-44c7f7188680@app.fastmail.com>
In-Reply-To: <7d76a774-9dad-4c94-b4df-7c040e9dbc47@kernel.org>
References: <20250228170155.2623386-1-superm1@kernel.org>
 <fcf58c76-2c0b-4892-96aa-c9b5b35c3e68@app.fastmail.com>
 <7d76a774-9dad-4c94-b4df-7c040e9dbc47@kernel.org>
Subject: Re: [PATCH 0/3] Add support for hidden choices to platform_profile
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Feb 28, 2025, at 2:44 PM, Mario Limonciello wrote:
> On 2/28/2025 13:39, Mark Pearson wrote:
>> Hi Mario,
>> 
>> On Fri, Feb 28, 2025, at 12:01 PM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> When two drivers provide platform profile handlers but use different
>>> strings to mean (essentially) the same thing the legacy interface won't
>>> export them because it only shows profiles common to multiple drivers.
>>>
>>> This causes an unexpected behavior to people who have upgraded from an
>>> earlier kernel because if multiple drivers have bound platform profile
>>> handlers they might not be able to access profiles they were expecting.
>>>
>>> Introduce a concept of a "hidden choice" that drivers can register and
>>> the platform profile handler code will utilize when using the legacy
>>> interface.
>>>
>>> There have been some other attempts at solving this issue in other ways.
>>> This serves as an alternative to those attempts.
>>>
>>> Link:
>>> https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#t
>>> Link:
>>> https://lore.kernel.org/platform-driver-x86/CAGwozwF-WVEgiAbWbRCiUaXf=BVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com/T/#m2f3929e2d4f73cc0eedd14738170dad45232fd18
>>> Cc: Antheas Kapenekakis <lkml@antheas.dev>
>>> Cc: "Luke D. Jones" <luke@ljones.dev>
>>>
>>> Mario Limonciello (3):
>>>    ACPI: platform_profile: Add support for hidden choices
>>>    platform/x86/amd: pmf: Add 'quiet' to hidden choices
>>>    platform/x86/amd: pmf: Add balanced-performance to hidden choices
>>>
>>>   drivers/acpi/platform_profile.c    | 94 +++++++++++++++++++++++-------
>>>   drivers/platform/x86/amd/pmf/sps.c | 11 ++++
>>>   include/linux/platform_profile.h   |  3 +
>>>   3 files changed, 87 insertions(+), 21 deletions(-)
>>>
>>> -- 
>>> 2.43.0
>> 
>> The patches are all good - but my question is do we really need the whole hidden implementation bit?
>> 
>> If the options are not hidden, and someone chooses quiet or balanced-performance for the amd-pmf driver - does it really matter that it's going to do the same as low-power or performance?
>> 
>> So, same feedback as I had for Antheas's patches. I understand why this is being proposed but for me it is making things unnecessarily complicated.
>> 
>> My personal vote remains that the amd_pmf driver carries the superset to keep everyone happy (sorry - it sucks to be the CPU vendor that has to play nice with everyone).
>> 
>> Mark
>
> Well so the problem with having all of them is specifically what happens 
> when "only" amd-pmf is bound?
>
> If you advertise both "low power" and "quiet" it's really confusing to 
> userspace what the difference is.

Ah - I guess you get platforms without profile support where amd-pmf is the only thing. I hadn't considered that.

FWIW, I believe we (Lenovo) have both low power and quiet on Windows...and they really don't make much difference (which is why the thermal team didn't do them both on Linux). 
I don't know if Windows users are more or less confused (or maybe they've just abandoned all hope and are migrating to Linux...)

You have a better feeling as to how many issues you'll get raised if they behave the same, and have to support a wider ecosystem, so I'm happy to be over-ruled. I just wanted to wave my flag that I think the driver is getting too complicated. I'm slightly dreading having to debug customer issues at this point.

>
> The fact that it's actually 100% the same brings me to my personal 
> opinion on all of this.  Although I spent time writing up this series to 
> do it this way my "preference" is that we permanently alias "low power" 
> and "quiet" to one another and update all drivers to use "low power" 
> instead.
>

Guaranteed if you do that some vendor will have something that differentiates.

I can see having a 'use as much power as possible without needing fans' for quiet, and 'make the battery last as long as humanely possible whilst keeping the system usable' mode for low-power. Don't think anyone has done it...but they could.

> Granted that doesn't help the case of balance-performance being hidden 
> that Antheas mentioned for acer-wmi and legion-wmi but I don't know 
> serious of a problem that actually is.

I really have to go play with this on the Legion-Go. I need a time-machine.....

Mark

