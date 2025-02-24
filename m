Return-Path: <linux-acpi+bounces-11436-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C0CA42F80
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 22:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1F33B2078
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 21:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0529E1DDC37;
	Mon, 24 Feb 2025 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="kwQY66cv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcX7lF5f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7311A2397;
	Mon, 24 Feb 2025 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433882; cv=none; b=KEnRmetni9sYOi70659zGRFgNNxLGn1g7B/ZceJq7LlcUPobxuncpvvSVYLn8Rb18cGRlAL3Eb5kLGdg/1JsWfg4YwcsuNPp4rtMjHneKqOXDAfr5SSbRbTfpzaLqg6TnLjO20pH47IRQK1/EbuWLfhuqr4i73iF2J9W1l1YX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433882; c=relaxed/simple;
	bh=pKOREHPDUL0kSXZcEXRWTZPn7l4M29EiusZh8QDLwz0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nwv/bk6C+dBXOpvZ2qnY3Ur8eGU5cq7ccaYJYNiL59AlWzAMd0yWs46WdS4hTbCRwzUNpHLTHFlzK59ak4/HX+2BzhMGiWhTsKb25aJjwGsH5ToqhujMME2xWcDSzP5O1C3z4RoAw28dT4Ey3AW3u+lJEjKpd4YcxlR7Drf2DL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=kwQY66cv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcX7lF5f; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 4BEBE11400A4;
	Mon, 24 Feb 2025 16:51:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Mon, 24 Feb 2025 16:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740433879;
	 x=1740520279; bh=pKOREHPDUL0kSXZcEXRWTZPn7l4M29EiusZh8QDLwz0=; b=
	kwQY66cvtIayN/G+uTvBkks0XBStSXLnV5CY1eX8L9rfy9Sclk7HOnNTrOGfscOn
	/t2tq8hKf9JEBAzv6VUBzpxoGrdmsUJxUKqocMRSmVWQZKroaeOJbfQe2UedNvjZ
	IbYDKpA+R4n0BuZSC2GldUOIVcUPrsSZOr0jKXEBpm5P/6J5R/ntTnZ5gy39Ix70
	xy/gJph9QxcwFY7pJdTk1y6KBqqMj8s9dpxktPNbrxh9wp873hmaUx1jXx8QXKq8
	UURkiMAlp57B9ZuiinYLpLar/GoVkU0N/98p5112kgs93TS36l3hIHBaqn/qC5YG
	GxKMckm7q9CnwQg34MPqZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740433879; x=
	1740520279; bh=pKOREHPDUL0kSXZcEXRWTZPn7l4M29EiusZh8QDLwz0=; b=k
	cX7lF5fIgmFIVb/61bg+sZhVWPUlGvu3hG46wtekQHDDtfg5OBxQrh2VLqO83fSi
	uZB8VC4U1SdHRIOVR0ohSPJfa3+za48kGRuoIj49Uu2uPbS9B+C/J2hQhTFTtarm
	EzFBQ4YOotE9AVh6SAVs2bDK84Qv8GREFMrqnuLLJkClQFMNxIjDwPe348Swr4g6
	YvYBhesD0wFFbLJPwipIofyh4I4REEKVg4/zXn4QffIJQvmfEVK8raiWxVix3q+s
	4UXyFXxttC7sFL8J2LE5EwnUeK9j1A9A7E+mozZFd+NRxigHGmLCAqXubVGtP66u
	zN5TVlfxXYLZe2CkR9vow==
X-ME-Sender: <xms:1um8ZwvoRkI6-W7BkBl-ChOEym5agx87iaqlo42V48kNmgFSW_x2OQ>
    <xme:1um8Z9fKxKj-uh5Mxu59116KB7d7gYTKNNRGgg0IG8-DYqHOOp6drcoQhWAc877S_
    ddEAE2DrXEruWN6bsQ>
X-ME-Received: <xmr:1um8Z7zfmxEJ4pGwIeeQslRaLBkeMgIuTsdOEd-EN0-jJhBv8IMn6tU_MpNNOgjg4moes5q6JgsNYCzNJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttder
    jeenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvh
    eqnecuggftrfgrthhtvghrnhepkeefffeujeevueejueegleelhedtgedvledukedttdff
    hfeifeelvdduheefjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohepuddu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvrghrshhonhdqlhgvnhhovh
    hosehsqhhuvggssgdrtggrpdhrtghpthhtoheplhhkmhhlsegrnhhthhgvrghsrdguvghv
    pdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprh
    gtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
    pdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehplhgrth
    hfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1um8ZzOXlBgxhzwakuT4e5GIVcS_sWkbdp6PtllB5WTntPVEIiWlNA>
    <xmx:1um8Zw_3Y9CS4IBcmPJZBk4s6MzYbqNiTSppaP6QmRjw0X8c97sWvg>
    <xmx:1um8Z7VHQs9kbBA1hOlgwx8uzuCgcMRKliMaNEw0MPCqYFOQ4IxHaQ>
    <xmx:1um8Z5e3Hk9WxSL-d5xBdllYHegx-oPQQRmAxDhAKLQOhoRLoT5xKg>
    <xmx:1-m8Zx1rgtRtHlWvtaJsiQwL6ZxOVHO1DWWPxTVy7JFMf_NeNcd6K3eJ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 16:51:14 -0500 (EST)
Message-ID: <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
From: Luke Jones <luke@ljones.dev>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, Antheas Kapenekakis
	 <lkml@antheas.dev>, "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Len
 Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, 	linux-kernel@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org"	
 <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Hans de Goede <hdegoede@redhat.com>,
 me@kylegospodneti.ch
Date: Tue, 25 Feb 2025 10:51:09 +1300
In-Reply-To: <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
References: <20250224195059.10185-1-lkml@antheas.dev>
	 <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 15:52 -0500, Mark Pearson wrote:
> Hi Antheas,
>=20
> On Mon, Feb 24, 2025, at 2:50 PM, Antheas Kapenekakis wrote:
> > On the Asus Z13 (2025), a device that would need the amd-pmf quirk
> > that
> > was removed on the platform_profile refactor, we see the following
> > output
> > from the sysfs platform profile:
> >=20
> > $ cat /sys/firmware/acpi/platform_profile_choices
> > balanced performance
> >=20
> > I.e., the quiet profile is missing. Which is a major regression in
> > terms of
> > power efficiency and affects both tuned, and ppd (it also affected
> > my
> > software but I fixed that on Saturday). This would affect any
> > laptop that
> > loads both amd-pmf and asus-wmi (around 15 models give or take?).
> >=20
> > The problem stems from the fact that asus-wmi uses quiet, and amd-
> > pmf uses
> > low-power. While it is not clear to me what the amd-pmf module is
> > supposed
> > to do here, and perhaps some autodetection should be done and make
> > it bail,
> > if we assume it should be kept, then there is a small refactor that
> > is
> > needed to maintain the existing ABI interface.
> >=20
> > This is the subject of this patch series.
> >=20
> > Essentially, we introduce the concept of a "secondary" handler.
> > Secondary
> > handlers work exactly the same, except for the fact they are able
> > to
> > receive all profile names through the sysfs interface. The
> > expectation
> > here would be that the handlers choose the closest appropriate
> > profile
> > they have, and this is what I did for the amd-pmf handler.
> >=20
> > In their own platform_profile namespace, these handlers still work
> > normally
> > and only accept the profiles from their probe functions, with -
> > ENOSUP for
> > the rest.
> >=20
> > In the absence of a primary handler, the options of all secondary
> > handlers
> > are unioned in the legacy sysfs, which prevents them from hiding
> > each
> > other's options.
> >=20
> > With this patch series applied, the sysfs interface will look like
> > this:
> >=20
> > $ cat /sys/firmware/acpi/platform_profile_choices
> > quiet balanced performance
> >=20
> > And writing quiet to it results in the profile being applied to
> > both
> > platform profile handlers.
> >=20
> > $ echo low-power > /sys/firmware/acpi/platform_profile
> > bash: echo: write error: Operation not supported
> > $ echo quiet > /sys/firmware/acpi/platform_profile
> > $ cat /sys/class/platform-profile/platform-profile-*/{name,profile}
> > asus-wmi
> > amd-pmf
> > quiet
> > quiet
> >=20
> > Agreed ABI still works:
> > $ echo quiet > /sys/class/platform-profile/platform-profile-
> > 0/profile
> > $ echo quiet > /sys/class/platform-profile/platform-profile-
> > 1/profile
> > bash: echo: write error: Operation not supported
> > $ echo low-power > /sys/class/platform-profile/platform-profile-
> > 0/profile
> > bash: echo: write error: Operation not supported
> > $ echo low-power > /sys/class/platform-profile/platform-profile-
> > 1/profile
> >=20
>=20
> I understand where you're coming from with this implementation but my
> concern is this is making profiles more complicated - and they're
> already becoming hard to understand (and debug) for users.
>=20
> I'm not a huge fan of multiple profile handlers, but can see why some
> people might want them and that they're a valid tool to have
> (especially given some of the limitations of what platform vendors
> themselves implement).
>=20
> In patch #3 it states that 'It is the expectation that secondary
> handlers will pick the closest profile they have to what was sent'.
> I'm not convinced that is true, or desired.
>=20
> e.g. Quiet and low-power are different things and can have different
> implementations. One is giving you as much power as possible with the
> fans running below a certain audible level; and one is giving you a
> system with as low-power consumption as possible, but still be
> usable. They're admittedly not very different in practice - but they
> can be different.
>=20
> Would it be better here to ask AMD to implement a quiet profile
> (maybe it can be based on low-power, at least initially)?
> I think that would solve the ASUS issue and not introduce another
> layer of complexity.
>=20
> Mark

Hi Mark,

I've supported over 80 different ASUS laptops in the last 6 years or
so, I can offer some insight.

Across the entire range (TUF, ROG, Vivobook, Zen) which implements some
form of "thermal throttle" as it is called in asus-wmi (which is what
is used by platform_profile) the difference between low-power and quiet
is very much nil - the "quiet" profile is only a name, and the TDP is
limited along with fans to match - so the result is "low-power".

As Mario suggests in his reply perhaps an alias would be best, or, as I
was going to do, simply rename the "quiet" profile in asus-wmi to "low-
power" as I already did but have not submitted yet due to a large train
of patches in progress. It's a single line change and nullifies the
entire issue and this series.

In any case asus handling of platform profile is something I have been
steadily working on for the last few months for both laptops and
handhelds and I will have a new patch series coming soon (version 7 of
previously submitted dealing with this).

This submitted series is a NACK from me.

Cheers,
Luke.



