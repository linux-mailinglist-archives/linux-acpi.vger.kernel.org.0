Return-Path: <linux-acpi+bounces-9333-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897399BD913
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 23:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF6BB2168A
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 22:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0447216212;
	Tue,  5 Nov 2024 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Otca8lJL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BpfhZV8R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2E1F8EE4;
	Tue,  5 Nov 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730846988; cv=none; b=W7CYS9XZsKlT70mQxeJtHhNprpDhcdonFptC4zYW5YZpYRVKHJx1KmDtNk9geUFH8w1gwFYyJszfJ7EALZ1ztaxmrSarMFge3twkTVL+ddEQz3z/NFGRqZ0UEWKspNC6KMX7XhIl2VGWozE6+d2zXea+ALCe1Wz861ArJE2PFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730846988; c=relaxed/simple;
	bh=+qrt0SnHMoXax5cx51hAMaNMH9X+fYL3dIuvoqA1Ph8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TaVeT3keiKH8heP4T+tY7sEXLrEZgCFO7gcCdPQPCo/hBq5Y9N9lYNnoM95dLkUSRGN8abCk5KSmlohxcBumB3z3TDgsjz0Zqb7aFMx+qPbT07YTu0MXlcwzqw/OQDiVp9WFj8Q+fNCIU3rBcyMPbBPIekHdXgyvVrvzvYz341I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Otca8lJL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BpfhZV8R; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 356F52540167;
	Tue,  5 Nov 2024 17:49:45 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Tue, 05 Nov 2024 17:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730846985;
	 x=1730933385; bh=iUEnUbiKHm7hBg4xQi/z/U9mNVNxeKdQypXGGIH3KZs=; b=
	Otca8lJLeoySiSUIS2wTsg2ijN0G2lGe05lUHAhThP6VP4GKQUj6X8prXwdbOACS
	FxryAWHdTLyoG3+hJrXw1klaFfI5Sj2MdPKKY2Wms98fCqDi97c0q0QITHPhataH
	TOhZLxcvYNtJ4JLlH2eMdggjIapq+w8GDBmPsWVbB0Xd5pjTQefulrdbawrL+u8o
	+3+8DQZTf1bnYwVeQrgqy3wD4u3TOkFLHpX2jtxBi5tZ9myhf7+6GYHfNBqjwPj+
	4Q1Vbo98GaAX7Hq5aHyfelpzjsNxtcql/lVbO4Mdpa9/TWltVbkdDNImch4RqOnH
	4gRIJQdEGden8FB4pfYjMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730846985; x=
	1730933385; bh=iUEnUbiKHm7hBg4xQi/z/U9mNVNxeKdQypXGGIH3KZs=; b=B
	pfhZV8RhBiTDKAPIagIdHMCA2XCO7hW1Z2EyIO1pExpkmwyGPSARx70DHieozEeU
	Shfc9hjpPLqKHmH/leZQQK2aZRoQCiPHIwmEBdO77qxhY+2QCt2c7QbK7IUt5afV
	P1souhqQyMnuyxIvW3cTtThQG2ISt17xHMAvdX43r2ArcYgQS4IOnCRl2nFOX2t2
	c4uTtF5QQS+TynXLm2hI4xSwe45CGQezyjaLHSM35lc7DOxqbTCK3amb6g5ZRTSR
	/Ojcz/N4v23EqQxMpPUZMCGkabC7Up6FXxrx/9BRX2N9bLcJSWTbW08xYHBg5IZm
	DuiiE52rBZ9SZImrdQjMQ==
X-ME-Sender: <xms:B6EqZ7JuMiZZkN_YUWWr1mgetoP6YbT8ygPff_CE9-cAZido3u2utg>
    <xme:B6EqZ_Ip-0JKwFN-ly5V0jYQgvG0k0DGmX8ffIS7wxiObXyYOMk-6iy1qzwyNrFZ6
    WpB_z8KAGisv2uq4iU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnoh
    hvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfeuvdehteeghedthedt
    veehuddvjeejgffgieejvdegkefhfeelheekhedvffehnecuvehluhhsthgvrhfuihiivg
    epudenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohes
    shhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehshhihrghmqdhsuhhnuggrrhdrshdqkhesrghmugdrtghomhdprhgt
    phhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpth
    htohepihhkvgdrphgrnhestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopegrlhgv
    gigsvghlmhegkeesghhmrghilhdrtghomhdprhgtphhtthhopegtohhrvghnthhinhdrtg
    hhrghrhiesghhmrghilhdrtghomhdprhgtphhtthhopehluhiimhgrgihimhhilhhirghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhmhheshhhmhhdrvghnghdrsghrpdhrtg
    hpthhtohepshhohigvrhesihhrlhdrhhhupdhrtghpthhtoheplhgvnhgssehkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:B6EqZzugGKsIQBZiZsoGbZiYOU_kL2pm2lhoWFQYJqWCfsMdEl8fuA>
    <xmx:B6EqZ0anuB4vF9-bBX9i2lNPOOPO-tDFq1jf1_ACtLJzoRCTMfr4GA>
    <xmx:B6EqZybhsx_O5afOsUh6b9LMAOfMzIG9GVOBqAnr1w84DFkwDi3doA>
    <xmx:B6EqZ4CdzR9OOU9DVVt53_JDQ-FObiVGCTIdiUGcSPbizRxas-MgUg>
    <xmx:CaEqZ0b6ol7zOnfVvjwtrFIguck8vclh8egUKEaaQrd4eQ4_riV96KPM>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AD6153C0066; Tue,  5 Nov 2024 17:49:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 05 Nov 2024 17:49:23 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Maximilian Luz" <luzmaximilian@gmail.com>, "Lee Chun-Yi" <jlee@suse.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Corentin Chary" <corentin.chary@gmail.com>,
 "Luke D . Jones" <luke@ljones.dev>, "Ike Panhc" <ike.pan@canonical.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 "Alexis Belmonte" <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Ai Chao" <aichao@kylinos.cn>, "Gergo Koteles" <soyer@irl.hu>,
 "open list" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>,
 "Matthew Schwartz" <matthew.schwartz@linux.dev>
Message-Id: <ab676d6e-30aa-45ac-85c8-32d093eeb5e3@app.fastmail.com>
In-Reply-To: <20241105153316.378-21-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-21-mario.limonciello@amd.com>
Subject: Re: [PATCH v4 20/20] Documentation: Add documentation about class interface
 for platform profiles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Mario,

On Tue, Nov 5, 2024, at 10:33 AM, Mario Limonciello wrote:
> The class interface allows changing multiple platform profiles on a system
> to different values. The semantics of it are similar to the legacy
> interface.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  .../userspace-api/sysfs-platform_profile.rst  | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst 
> b/Documentation/userspace-api/sysfs-platform_profile.rst
> index 4fccde2e45639..418c61b096304 100644
> --- a/Documentation/userspace-api/sysfs-platform_profile.rst
> +++ b/Documentation/userspace-api/sysfs-platform_profile.rst
> @@ -40,3 +40,31 @@ added. Drivers which wish to introduce new profile 
> names must:
>   1. Explain why the existing profile names cannot be used.
>   2. Add the new profile name, along with a clear description of the
>      expected behaviour, to the sysfs-platform_profile ABI 
> documentation.
> +
> +Multiple driver support
> +=======================
> +When multiple drivers on a system advertise a platform profile 
> handler, the
> +platform profile handler core will only advertise the profiles that are
> +commong between all drivers to the ``/sys/firmware/acpi`` interfaces.

Typo (commong)

> +
> +This is to ensure there is no ambiguity on what the profile names mean 
> when
> +all handlers don't support a profile.
> +
> +Individual drivers will register a 'platform_profile' class device 
> that has
> +similar semantics as the ``/sys/firmware/acpi/platform_profile`` 
> interface.
> +
> +To discover available profiles from the class interface the user can 
> read the
> +``choices`` attribute.
> +
> +If a user wants to select a profile for a specific driver, they can do 
> so
> +by writing to the ``profile`` attribute of the driver's class device.
> +
> +This will allow users to set different profiles for different drivers 
> on the
> +same system. If the selected profile by individual drivers differes the

typo (differes)

> +platform profile handler core will display the profile 'custom' to 
> indicate
> +that the profiles are not the same.
> +
> +While the ``platform_profile`` attribute has the value ``custom``, 
> writing a
> +common profile from ``platform_profile_choices`` to the 
> platform_profile
> +attribute of the platform profile handler core will set the profile 
> for all
> +drivers.
> -- 
> 2.43.0

Thanks
Mark

