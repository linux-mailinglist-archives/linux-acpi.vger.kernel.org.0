Return-Path: <linux-acpi+bounces-19342-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C5C904E5
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 23:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA0F3A9202
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 22:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10703191CE;
	Thu, 27 Nov 2025 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="RwyeBq37";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WFrYCzrK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E955F1FF7D7;
	Thu, 27 Nov 2025 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764283740; cv=none; b=Lt9hEm4PDp5oAc4ep9FMGyGQrfYpuxGlf9Mr7HjvjQzslZqBBwJNoYn1HiAqEcxO87krc7uxT+kGtsqI3zft5ZcbkCi81hzgheGCvFYGV6kjayfZoE1f+aZ6Y+VzHruBESyN8AeYAsZE0M4oKiYVsVX36UeJ/sdlyaN+YXSORsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764283740; c=relaxed/simple;
	bh=HGs/c5PPffwHSRJka96fP7JSTP/89kfA/cICTdfPCbw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SjXhz+mnsMMjxY4ZHU5jgEyW+XgDFapnTLlVEjU6bqbCh4NU030tyj+ua4Kik/qdaAIco9r+6hn1Zl0O9pB9IH0HLwHNrzhjFh8peS95svExog+itmuUS2c4I9ChHs2PqyPmXOBE/+DHHgPQ/J1lR7Dvje+fTZyw1JmWZYRn1ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=RwyeBq37; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WFrYCzrK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 01E11EC01CD;
	Thu, 27 Nov 2025 17:48:57 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Thu, 27 Nov 2025 17:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764283736;
	 x=1764370136; bh=4LCrl8bx5It8r0TMBNBQaLJ/qadECKvrJ82mQP+rBT0=; b=
	RwyeBq37ggZ0cMcrnmtb2Dll9zXF+NUMNXX9wcUOStcd0q/WAPWt3JCMtSVgNk44
	DH4GJw151IpLF42R5Zo2k8VNE39pgV/S4pHP+L7Rmdw+hqiglo8NOqQ9ShKh6y3r
	f97uJvw/cdVj242YdmGeMBdk/u8/us4HiMYme7PGt4lV/1f+XBGL7seemOh51SjZ
	moMIx0zH0uu52l3Bil8yyr3WpLdidZfQEjGvuEgkwXYN3QAMjaPeNcNxWvttNCii
	prBgpo5sEswFRVgdnBTE7EEQD0ltyzoCZ9lc5PYV3kBQEgz/zV9gisok7UKXMOTD
	xsZ7ElXkK8KdPUs/rFHG8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764283736; x=
	1764370136; bh=4LCrl8bx5It8r0TMBNBQaLJ/qadECKvrJ82mQP+rBT0=; b=W
	FrYCzrKkt2JRQQQjrZcOmlwg2qrKJXlrYu700dEjstkcT0tOTFRj2gDk9WQEKI7K
	JWNFXVwqWxajUgozUdk/C2wtm/iM4Xu6tnJS/EaLHz9AxaWnaK/7nEKMZuKTlKDj
	ZnFXRR7CUerbnYnicPE8y/KSYvXAmusv6jKPd1XA4K6MhNPp2vJOBiOwS5N0i4HX
	QbsLB0is0xkv9s94Y08RgN7JH5HEtto8X+pGdxbh7jC01Bb1obuG5Ca5akqMpp39
	K2b+KllO7uivrkJiSB6Biz+NhCzNqbPHGjHxWAAdjWN4I6gdIlizJgvA7TxNK3B9
	NmrtuI8gV1g6UuMJCoaow==
X-ME-Sender: <xms:WNUoaUGyQmFsMyDevvYtIcCFnxc5BU5kbJqsnExyAND8lEC7VVdlkQ>
    <xme:WNUoaYIfB-MJE6FCVDjHlnXRZVNWqXfxNzffFScSuxXfJ2Xgza6kLoJeEaCkqBqT-
    3UO8-RfzkJ9iWO2PgbVNPTh0DTNpm4ObjCls1QKoDIySXVL6legd2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeekgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpedtffevgfethfevteduvdefleevkedtuddvlefghefg
    ieekffejteejveffkedthfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhn
    qdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepudehpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopeguvghrvghkjhhohhhnrdgtlhgrrhhksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepkhhuuhhrthgssehgmhgrihhlrdgtohhmpdhrtghpth
    htohepfigprghrmhhinhesghhmgidruggvpdhrtghpthhtoheplhgvnhgssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepshhuphgvrhhmudeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhrghohhii
    udeslhgvnhhovhhordgtohhmpdhrtghpthhtohepiihhrghnghiigiefieeslhgvnhhovh
    hordgtohhmpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhn
    thgvlhdrtghomh
X-ME-Proxy: <xmx:WNUoaVqOH5nJg_RStfKKbWP-iQ2lzUePQ52B9b9C8O5r1W2qHRacxw>
    <xmx:WNUoadPX_4Z1QepNQKjWPmNxi43hzYN2_epRjlUpFXFv2uXq4cVRFw>
    <xmx:WNUoabz-q1vR04iTHAXiBiFg9drf2cAiSP-x2lGvSaMuiljN_SPM-Q>
    <xmx:WNUoaRyc7kvUMda0gwhbSot9dSzrcZh62ukE1rdt1161uo1-97iYmQ>
    <xmx:WNUoaWxLxkv_CfJ3cTOKcI31iwqEPpuO_oWANnBHMAbatoK6iGicHxRg>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5A2F62CE0072; Thu, 27 Nov 2025 17:48:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFwPr5mXVruN
Date: Thu, 27 Nov 2025 17:48:36 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Armin Wolf" <W_Armin@gmx.de>, "Len Brown" <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>
Cc: "Mario Limonciello" <superm1@kernel.org>,
 "Zhixin Zhang" <zhangzx36@lenovo.com>, "Mia Shao" <shaohz1@lenovo.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Kurt Borja" <kuurtb@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Message-Id: <3a24c5d6-c7a1-4aea-8fe9-847526226efe@app.fastmail.com>
In-Reply-To: <20251127151605.1018026-1-derekjohn.clark@gmail.com>
References: <20251127151605.1018026-1-derekjohn.clark@gmail.com>
Subject: Re: [PATCH v4 0/3] Add max-power platform profile
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 27, 2025, at 10:16 AM, Derek J. Clark wrote:
> This series adds a new "max-power" platform profile mode and uses it for
> the lenovo-wmi-gamezone driver. It also adds the Lenovo Legion Go 2 to
> the extreme mode quirks table.
>
> On some Lenovo Legion devices there is a thermal mode called extreme
> that corresponds to setting ppt/spl vlaues to the maximum achievable by
> the cooling solution. This correlates strongly with an overall power draw
> that exceeds the DC power draw capability of the internal battery. This
> mode being mapped to performance when extreme mode is detected as
> supported, with the actual performance mode being set to
> balanced-performance, has led to some misinformation being promulgated
> that performance is always a bad setting in Linux for these devices.
> There is also some confusion that the mode labeled performance in
> userspace, which corresponds to a red LED in Windows, shows as purple
> when set using the hardware extreme mode.
>
> I'll also note that as the hard TDP limits are refreshed when on AC or DC
> by the ACPI notifier of lenovo-wmi-other method driver, no special handling
> of the battery is needed for safety limiting extreme mode.
>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
>
> ---
> v4:
>  - prevent  platform_profile_cycle() from selecting max_power.
> v3: 
> https://lore.kernel.org/platform-driver-x86/20251113212639.459896-1-derekjohn.clark@gmail.com/
>  - Rename the vendor specific "extreme" to a vendor agnositic 
> "max-power"
>    to better allign with the "low-power" platform profile.
> v2: 
> https://lore.kernel.org/platform-driver-x86/20251106212121.447030-1-derekjohn.clark@gmail.com/
>  - Drop patch 3/3, keep extreme mode quirks table
>  - Add Legion Go 2 to quirks table
>  - Fix nits from Mario
> v1: 
> https://lore.kernel.org/platform-driver-x86/20251026081240.997038-1-derekjohn.clark@gmail.com/
>
>
> Derek J. Clark (3):
>   acpi: platform_profile - Add max-power profile option
>   platform/x86: lenovo-wmi-gamezone Use max-power rather than
>     balanced-performance
>   platform/x86: wmi-gamezone: Add Legion Go 2 Quirks
>
>  .../ABI/testing/sysfs-class-platform-profile  |  2 ++
>  .../wmi/devices/lenovo-wmi-gamezone.rst       | 31 ++++++++--------
>  drivers/acpi/platform_profile.c               |  7 ++--
>  drivers/platform/x86/lenovo/wmi-gamezone.c    | 35 +++++++++++--------
>  include/linux/platform_profile.h              |  1 +
>  5 files changed, 44 insertions(+), 32 deletions(-)
>
> -- 
> 2.51.2

For the series - looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

