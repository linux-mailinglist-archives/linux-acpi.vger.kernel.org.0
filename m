Return-Path: <linux-acpi+bounces-11442-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB6AA4327B
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 02:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A40189AB48
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 01:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7014F98;
	Tue, 25 Feb 2025 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Ib08FKJL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PrUwU66R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0F199B8;
	Tue, 25 Feb 2025 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740447305; cv=none; b=Nx0L67mILKUCDoD4PNXWz06yfjDHD2UHFooOM1JOHBiMQXp/98wVM9pEQUqnbiBzTY4HBhlwRAk5s6bQ4LdTBcjKXwLDyiW+63DPAyEbD9OXBcouMuEDu+rDdyWjr7oBrbvR1Pz9qzN7Q+nbKextRMVbxyIP97AmDSLDvZCRH0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740447305; c=relaxed/simple;
	bh=ZTPTSfcjuXwUSPi7TPKTnuMsbHr9Y/GRQ70RKFMlkAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XmsgvosfxsutsIz8fhh6yRd6beQe+9Xz2B/4f/F9xDe6a3CuFaJcV6bAxAgmhP9YXuZMZsfPnxTmKU8riR7vS7WIQfi5YOTTToG2xJ8uggP7NLCDH2M22l+SEDc/J0fsQIf25zE/MPXlOfgt25AZarGUs/VNGThQDljFc/GXOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Ib08FKJL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PrUwU66R; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96FF7114011F;
	Mon, 24 Feb 2025 20:35:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 24 Feb 2025 20:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740447302;
	 x=1740533702; bh=En7mhtzIGZYAtdlNeeUGm3RPq0wZ4XfvRF7cD+zY3tM=; b=
	Ib08FKJLgdw4XGaRbXSEfYHYEoIvZDBGCdivuLO9W2IzAr3KxPjfWBujxNp3MNa1
	zVJpdxkrYZ4J/Mryf1ER1P893EurUrE0fsBNn2xtyY4AODrybfubHK2XGvAxjtmE
	y0/VQrnbWSiw59rsZypcGOJ/SssZLa5c5ZuDCLTSEaXvtMbgWAqdnpKj8C9SCD2/
	ZInV57N13ogEvXtC6JAdDmTmTBNzVgOrj6rfQ4DzZqwTZD7p1z+guAyeMQpNf0zL
	vmum+2GK4qgAnf6bPvfnoPk8wMhCLl3i4Wq42Mc3UYlW7Rv0Exa72ZeinkQyGdG1
	Y6vJmnwmAL1QwT2wYNb0Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740447302; x=
	1740533702; bh=En7mhtzIGZYAtdlNeeUGm3RPq0wZ4XfvRF7cD+zY3tM=; b=P
	rUwU66R/zaPO+59QgroLQuCmjl3Z1QESgDk302Z/YwU7SiJlhQTyaAj7G3NQpvuO
	CNlPDRszdCnWw/0ZdBUgcG3Y92meKjUfCQCGoUq6rsy+LwB1W31n/AAo/CmHiCmg
	7X/F+xsf6ykPSBvMLojlG664iJekp2pICiy6cLrhgDAzFv9Q5bTAx79h2yj4ICSD
	3fx4PPsbne1BtKoLJsxcIzesU91t5eIzPjxOyrZRpY7phhEUbzb3agfreOBjKRW2
	Xjw8VCbksQlaq6yjqPa3n5KeSPXaX0OswEDYyhrGcl+mYXutgbHj4chl0egb1BKM
	GYsEIH6aqU6HfqSqs8AZg==
X-ME-Sender: <xms:RR69Z9R64EgaFXDNxFKBTRBS7qlh0NGhupvVATpI5smwnDEWm-v1qg>
    <xme:RR69Z2zgVBFgmnOFSUHOgkRQc0xF-tvOnxhIzHfNYhmJWw-o6594rva8t5eGiD4tZ
    lzv7bgv-To09SjCcaQ>
X-ME-Received: <xmr:RR69Zy3utCV2S9WGCNQVlKyEqb99Rf3anKP5RpXBi-7hmkdGTt3M4VUZzr58kQZ61tJQaAqPJAfIUt38LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttder
    jeenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvh
    eqnecuggftrfgrthhtvghrnhepkeefffeujeevueejueegleelhedtgedvledukedttdff
    hfeifeelvdduheefjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohepuddu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlkhhmlhesrghnthhhvggrshdrug
    gvvhdprhgtphhtthhopehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
    pdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprh
    gtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
    pdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehplhgrth
    hfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RR69Z1BDZXhGk_Q0yqomtIix7frgZ2mT1ITpi1E_BxrWMPvVQ5I2lg>
    <xmx:RR69Z2hNm-fl_ks8dS4-gudWb7wMwKG3JL1cpXK2REFXzhDkmJlhNw>
    <xmx:RR69Z5oBcjGBsXS19TDGEPZmoOI2xGiaJY498VqrtLmKcBA10ucyEA>
    <xmx:RR69ZxickPM0w1BdQCO-GB_RP3WyP8YD3cxRZChAT1cPVRSl1LO6hA>
    <xmx:Rh69Z7YJkKijuhCr5muBWzt5XBvd5UU6O-xfKmYJIT_2woTsG0ZoDxIM>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 20:34:58 -0500 (EST)
Message-ID: <f5d39d3c932a78a5021877230c212c620edc586e.camel@ljones.dev>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
From: Luke Jones <luke@ljones.dev>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Limonciello, Mario"	
 <mario.limonciello@amd.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>, Len Brown <lenb@kernel.org>, 
 "linux-acpi@vger.kernel.org"	 <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org,  "platform-driver-x86@vger.kernel.org"	
 <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Hans de Goede <hdegoede@redhat.com>,
 me@kylegospodneti.ch
Date: Tue, 25 Feb 2025 14:34:54 +1300
In-Reply-To: <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
References: <20250224195059.10185-1-lkml@antheas.dev>
	 <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
	 <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
	 <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 22:58 +0100, Antheas Kapenekakis wrote:
> I will tell you that compared with other manufacturers, when asus
> says
> quiet, they mean quiet and not low power
>=20
> Z13's quiet mode is 40W, not very low-power if you ask me. Ally X
> uses
> 13w+boost, a source of many complaints. Other manufacturers use
> around
> 8W for low power modes.
>=20
> In any case, any rename might break user scripts and there are
> actually 3 types of low power profiles:
> PLATFORM_PROFILE_COOL
> PLATFORM_PROFILE_QUIET
> PLATFORM_PROFILE_LOW_POWER
>=20
> Then, there is also:
> PLATFORM_PROFILE_BALANCED_PERFORMANCE
>=20
> Some ACER laptops implement many of those
>=20
> Obscuring any of those is not ideal.
>=20

In the context of their other modes it is low power. If there is
confusion over what this is meant to mean for all vendors then it
should be clarified in the relevant documentation.

low-power		Low power consumption
cool			Cooler operation
quiet			Quieter operation
balanced		Balance between low power consumption
			and performance
balanced-performance	Balance between performance and low
			power consumption with a slight bias
			towards performance
performance		High performance operation
custom			Driver defined custom profile


"Low power consumption" compared to?

If these "scripts" use `platform_profile_choices` to get their
selections and verify they are available then there should be zero
breakage. If they don't then they should be updated to be correct.

In any case I am in the process of finalising an update to use the new
platform_profile API including "custom". Please don't begin trying to
break things just to be "first". My work has been ongoing for this in
my spare time for months.

