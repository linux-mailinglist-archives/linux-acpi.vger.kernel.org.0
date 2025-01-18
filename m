Return-Path: <linux-acpi+bounces-10748-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AE5A15ADE
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Jan 2025 02:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CF87A4129
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Jan 2025 01:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E10A10A3E;
	Sat, 18 Jan 2025 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="4uwD3SzZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IguSTfn2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CEEBA38;
	Sat, 18 Jan 2025 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737164028; cv=none; b=VVNI3hfRL+oGEgkLu1j+dFhz1BOqeXHDnHU6BGAzXFn8qHuf2mFhg8SQlfJIpSKv44BtaCa/eJ2v+QnJ0S+j8nbELUcAzEaWF+90vwtuSDanjj2N1n71rkvtnKEaP6uZUvLtXGOihuNI7VILeBJmExxyf+ulCiOahl7l6w+8jEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737164028; c=relaxed/simple;
	bh=hPvVUg835rmwTDkl2AR2vlJSNuVBls8/LX00bGTuJYE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jUVuhLG9oDIHUeIjs9tavoA/7DZOTstFcrAMreCIPyNEaraXQ+MLXmiHPByGZsJCTD/ZEO4nUEnpIhxcFAxdPhoRFP7kPl3SnxJeUtaDPbue6wwCW2UuZGQZs+++tiU2bGy2DG4bIZKR02O5AGN8Z2cQAe8XgXJ18Ju3jB4fFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=4uwD3SzZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IguSTfn2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F4E2114028A;
	Fri, 17 Jan 2025 20:33:43 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 17 Jan 2025 20:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737164023;
	 x=1737250423; bh=qoddUFhq/lgON2Zrn1iVZyM28ggkXNmUyx7bGlTekec=; b=
	4uwD3SzZFOTuBWvSX4NfJKGPzkVScMSn/np/K5qoL9qAi2H24Zx6FK2MOnemKvl3
	wGqo4b0f7Ca2pYrlosPA4cnYQfmJ2na4OHf5CF0tZfUWX86JgZ7NEY26MrUhCXXI
	ZJVw15KBeTpqvgmE9tYLgmYe2TwvVj2hkKvTI42pwa+DXU313xExlw5/sJ1/9HHt
	nYU69filcsOhceAuYe9pEbBwnBuM2Pi6uursxrkiBqeWBwnn72uRghfEGJBCFCB2
	0mKMV+yxAd3wYtOhTcFiej1GtbHO2GBKQubLMCI19i4JOTitYwbQg6Posr8SNv3I
	trsjMvcARdvTTim87Z+d8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737164023; x=
	1737250423; bh=qoddUFhq/lgON2Zrn1iVZyM28ggkXNmUyx7bGlTekec=; b=I
	guSTfn2nmOdymXi8nqs2kLuHO2iSnM6gCzlq9lg9XSSnluonPqp9JOm6/zmLumCm
	0BeG+BK1D/cPik0hdy6xhmHXhFIXRQAaGu1gP9W8p4MBAuB+9a8sxTdt50DGjrCg
	8db0lIQ/janm0L8Z/crwCTgwD8m8BlcQj48q77tovGrUDpHI6H+19lFbiBM6g5BE
	DEAV409ia4y5HcMHVw+m3tcq2tleH47GgupV7IHayqWSo2o2ot2X9G3fZPA/JWxu
	PdZLvn82WFoExupjoOpndYeKbBJYONf+hlzdSKFvcrHsktvJ2y3S2iJTm+0SLRHE
	uDPjEilPkkyK4y9SRQGjQ==
X-ME-Sender: <xms:9QSLZzJDfwK9z9lh4G5tbskSHbo_ZIVlAEPX6NByfe_oiQtIMlZecQ>
    <xme:9QSLZ3KknPx7PNUSKWohxyKmcrWLcDtges34MA3KcwiS4tSjTDSRHiuSyHWNJafo2
    062T79gjLYrj-du5uE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpeegvdegueffhfdtleei
    gfejhffggfeivdejgeelueejuedtudetheejudehtdeitdenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtg
    hpthhtohepvdehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhihrghmqdhs
    uhhnuggrrhdrshdqkhesrghmugdrtghomhdprhgtphhtthhopehmrghrihhordhlihhmoh
    hntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtohepihhkvgdrphgrnhestggrnhho
    nhhitggrlhdrtghomhdprhgtphhtthhopeguvghllhdrtghlihgvnhhtrdhkvghrnhgvlh
    esuggvlhhlrdgtohhmpdhrtghpthhtoheprghlvgigsggvlhhmgeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptghorhgvnhhtihhnrdgthhgrrhihsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepuggvrhgvkhhjohhhnhdrtghlrghrkhesghhmrghilhdrtghomhdprhgt
    phhtthhopehkuhhurhhtsgesghhmrghilhdrtghomhdprhgtphhtthhopehluhiimhgrgi
    himhhilhhirghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:9QSLZ7vI6LaPZIGEBG3Wx6fICiX4NEEO50LWvbd5e2b5L8ReI_htQA>
    <xmx:9QSLZ8blvIBfhB6vykIw_Zll7G0rGIhwZ572oDXZLjcn20Demo8ZYA>
    <xmx:9QSLZ6Z9qUnHa6jMAaQG2-uWvX-BFtZmjg-3ipsp-3JO--PxgVGB3w>
    <xmx:9QSLZwBA_O26KtWpSJ0bPzcPAgGNCCwYNOdLIQKDp4pqr0jyOorOOg>
    <xmx:9wSLZ2KkAQYmdZpST6FqIHbHP9mqkxq-NgMyz_5EclO8zUVH0oYpwfEj>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AAF203C0066; Fri, 17 Jan 2025 20:33:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 Jan 2025 20:33:21 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Kurt Borja" <kuurtb@gmail.com>
Cc: 
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Armin Wolf" <W_Armin@gmx.de>, "Joshua Grisham" <josh@joshuagrisham.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 "Maximilian Luz" <luzmaximilian@gmail.com>, "Lee Chun-Yi" <jlee@suse.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Corentin Chary" <corentin.chary@gmail.com>,
 "Luke D . Jones" <luke@ljones.dev>, "Lyndon Sanche" <lsanche@lyndeno.ca>,
 "Ike Panhc" <ike.pan@canonical.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 "Alexis Belmonte" <alexbelm48@gmail.com>, "Ai Chao" <aichao@kylinos.cn>,
 "Gergo Koteles" <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
Message-Id: <01d3c53e-666a-46d8-b629-ba8a089011ee@app.fastmail.com>
In-Reply-To: <f4e08213-0f42-4f35-a150-a75bf91537bf@app.fastmail.com>
References: <20250116002721.75592-1-kuurtb@gmail.com>
 <1eb2720a-c9af-4e5c-8df2-c4ce3c017d5c@app.fastmail.com>
 <3aab5072-f032-7458-56af-1d45e89a5d44@linux.intel.com>
 <D74IM4AZ87C9.1R1S1KOA89PX7@gmail.com>
 <f8678f9c-56c2-b3a9-f24d-04c9433dba9f@linux.intel.com>
 <f4e08213-0f42-4f35-a150-a75bf91537bf@app.fastmail.com>
Subject: Re: [PATCH v4 00/19] Hide platform_profile_handler from consumers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Jan 17, 2025, at 3:45 PM, Mark Pearson wrote:
> Hi,
>
> On Fri, Jan 17, 2025, at 12:19 PM, Ilpo J=C3=A4rvinen wrote:
>> On Fri, 17 Jan 2025, Kurt Borja wrote:
>>
>>> On Fri Jan 17, 2025 at 11:42 AM -05, Ilpo J=C3=A4rvinen wrote:
>>> > On Thu, 16 Jan 2025, Mark Pearson wrote:
>>> >
>>> > > Hi
>>> > >=20
>>> > > On Wed, Jan 15, 2025, at 7:27 PM, Kurt Borja wrote:
>>> > > > Hi :)
>>> > > >
>>> > > > The merge window is about to open, so I rebased this patchset =
on top of
>>> > > > pdx86/review-ilpo-next to pick up acer-wmi latest commits, in =
case we
>>> > > > manage to squeeze this into v6.14.
>>> > > >
>>> > > > ~ Kurt
>>> > > > ---
>>> > > > v3 -> v4:
>>> > > >
>>> > > > [09/19]
>>> > > >   - Replace error message with a user-friendly one
>>> > > >
>>> > > > v3:=20
>>> > > > https://lore.kernel.org/platform-driver-x86/20250115071022.481=
5-1-kuurtb@gmail.com/
>>> > > >
>>> > > > Kurt Borja (19):
>>> > > >   ACPI: platform_profile: Replace *class_dev member with class=
_dev
>>> > > >   ACPI: platform_profile: Let drivers set drvdata to the class=
 device
>>> > > >   ACPI: platform_profile: Remove platform_profile_handler from=
 callbacks
>>> > > >   ACPI: platform_profile: Add `ops` member to handlers
>>> > > >   ACPI: platform_profile: Add `probe` to platform_profile_ops
>>> > > >   platform/surface: surface_platform_profile: Use
>>> > > >     devm_platform_profile_register()
>>> > > >   platform/x86: acer-wmi: Use devm_platform_profile_register()
>>> > > >   platform/x86: amd: pmf: sps: Use devm_platform_profile_regis=
ter()
>>> > > >   platform/x86: asus-wmi: Use devm_platform_profile_register()
>>> > > >   platform/x86: dell-pc: Use devm_platform_profile_register()
>>> > > >   platform/x86: ideapad-laptop: Use devm_platform_profile_regi=
ster()
>>> > > >   platform/x86: hp-wmi: Use devm_platform_profile_register()
>>> > > >   platform/x86: inspur_platform_profile: Use
>>> > > >     devm_platform_profile_register()
>>> > > >   platform/x86: thinkpad_acpi: Use devm_platform_profile_regis=
ter()
>>> > > >   ACPI: platform_profile: Remove platform_profile_handler from=
 exported
>>> > > >     symbols
>>> > > >   ACPI: platform_profile: Move platform_profile_handler
>>> > > >   ACPI: platform_profile: Clean platform_profile_handler
>>> > > >   ACPI: platform_profile: Add documentation
>>> > > >   ACPI: platform_profile: Add a prefix to log messages
>>> > > >
>>> > > >  .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
>>> > > >  drivers/acpi/platform_profile.c               | 172 +++++++++=
++++-----
>>> > > >  .../surface/surface_platform_profile.c        |  48 ++---
>>> > > >  drivers/platform/x86/acer-wmi.c               | 114 ++++++---=
---
>>> > > >  drivers/platform/x86/amd/pmf/core.c           |   1 -
>>> > > >  drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
>>> > > >  drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
>>> > > >  drivers/platform/x86/asus-wmi.c               |  55 +++---
>>> > > >  drivers/platform/x86/dell/alienware-wmi.c     |  34 ++--
>>> > > >  drivers/platform/x86/dell/dell-pc.c           |  60 +++---
>>> > > >  drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
>>> > > >  drivers/platform/x86/ideapad-laptop.c         |  45 +++--
>>> > > >  .../platform/x86/inspur_platform_profile.c    |  48 +++--
>>> > > >  drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
>>> > > >  include/linux/platform_profile.h              |  37 ++--
>>> > > >  15 files changed, 495 insertions(+), 337 deletions(-)
>>> > > >  create mode 100644 Documentation/ABI/testing/sysfs-class-plat=
form-profile
>>> > > >
>>> > > >
>>> > > > base-commit: d98bf6a6ed61a8047e199495b0887cce392f8e5b
>>> > > > --=20
>>> > > > 2.48.1
>>> > >=20
>>> > > For the series up to v4 commit 15/19:
>>> > > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> > >=20
>>> > > I need to go over the last few commits just once more, as there =
a few=20
>>> > > pieces I need to get my head around - and I'm not going to get i=
t done=20
>>> > > this evening. Hope it's OK to add review for the bits that I hav=
e done.
>>> >
>>> > I, for the first time ever, tested filter-branch and after some in=
itial=20
>>> > hickups on how to specify the commit range, got your Reviewed-bys =
added
>>> > with single command :-).
>>>=20
>>> Awesome! I believe commit 15/19
>>>=20
>>> a213108c01e0 ("ACPI: platform_profile: Remove platform_profile_handl=
er from exported symbols")
>>>=20
>>> is still missing a rev-by by Mark, if there is still time.
>>
>> Thanks for noticing this. I just recalled the patch numbering wrong.
>>
>> It should be fixed now.
>>
>> --=20
>>  i.
>
> I finished my review, and no concerns. For the series:
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Note - I'm building and will give it a sniff test too, but that will=20
> take a bit longer.
>
> Thanks for your work on this Kurt
>
Ran the series on an X1 Carbon G12 and profiles working well. Was able t=
o check the new class and didn't find any issues.
For the series:
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

