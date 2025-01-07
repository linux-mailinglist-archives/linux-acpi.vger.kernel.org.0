Return-Path: <linux-acpi+bounces-10394-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BECA03506
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 03:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F493A4B39
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 02:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A9184D2B;
	Tue,  7 Jan 2025 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="1ey1cL42";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZGt1F8RM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC122594A5;
	Tue,  7 Jan 2025 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216381; cv=none; b=uCS8cG8NgvnUezIdX1R6f15OESB5QZTiKQ1f7r+wiCyREV4PDFaUjA5DP0fPLR/FBqpLN/1OxFG3+fGog1c6fy1a5//i16QmX9e3H4UZwJLesqV2+ks/cOuHDhwEUl9ctHc+Xbj5W7tHZYqqFqHN8eLQz0JRa8Y3xii/s//0nog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216381; c=relaxed/simple;
	bh=whxcJEUUdxrpr853/By+jQ/3XvE0gYgglj51JD5j1jQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=C/8W3vtv6YJ9Fto9tDw5gM3Llf6ez6fEudLLy1yA+H1TYSS6SgsFtDV8MB8qLsSFmH8ICej78DzsXMxnrydRmHHxF/7VHGNV5SSS7bxrcjiZuZ4i2IDqVSt37WM8c3myOyozAWCqYW6N50fSDBhYSpQtb4VOLcBG6F9o4X0EYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=1ey1cL42; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZGt1F8RM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E29D111402C7;
	Mon,  6 Jan 2025 21:19:37 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jan 2025 21:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1736216377;
	 x=1736302777; bh=whxcJEUUdxrpr853/By+jQ/3XvE0gYgglj51JD5j1jQ=; b=
	1ey1cL42WMzvARuyEMRIBMC9LrPdi4v1z8kYxhu9HtWXiDqYgLAPEM/YJYaJepdQ
	42viM+jxqTLa9BjxvMk7vs0pvvyq6Quft1YhdN3rFHa8SO3EcYmNe9WbJkqo9OHV
	CSvRpjpp4tWrAZR6nPlq53fH0FBB93pmYkoSSL09vH5dwl4/nFLSoon7ZSX/dnhj
	FQaHqdPUY4G6n59yzCWOioEOpeB9GHoANzowt4vmpYEP7kb1Y95jJ84JTMnai15S
	oFimElCd6b9YthOfSm9Zh0FnCVELSlI2ERJE16/l6nknsijXgHgiwfJc6LOJIGwi
	nzT344WhGwaBMP8BFyTdpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736216377; x=
	1736302777; bh=whxcJEUUdxrpr853/By+jQ/3XvE0gYgglj51JD5j1jQ=; b=Z
	Gt1F8RM2WkZ6kPyG8jDXCR0gFgMelur824ObxECH0o+99a+rkOUVCwhKT/VgwKgG
	L49JiS1yRKuuCKO22JKT/CHpHLxTcAL67Sp+pneD/kg7mnLUxGvOjB+bSEol8i9S
	uPo5IwvIB9TNe9a9Nofhs2IuARRdHO5/F65oKqXgBN4cFK43sZSNQ8aRgfnTcG9/
	vKZLS0D26ZKxa2t0fQg8OHqJEUl2PxZssQP0A56oEf9jL+vJf+Lz5AJslS4ebaoQ
	45okAxLdEjW2TUMYnnhGAUJhl2jQh1oIpEPEn0uacPjYTDjwnMYaYWo2zyxopMao
	1Rxof4lVitvQfXONL4J4A==
X-ME-Sender: <xms:N498Z2nHU_4oIfOt9pJSv0DjOhtM-b3Zz8jYeDTPrH2CQedZRZX9nQ>
    <xme:N498Z91ZlrnjbDpVHSGg5Crg5q9SyDUtI8q69U7NQvluvKljUn8HFCmU3gF-z1JPX
    zpK3jlSJhI1kPvk3Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehurdhklhgvihhnvgdqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgt
    phhtthhopehikhgvrdhprghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtohepug
    gvlhhlrdgtlhhivghnthdrkhgvrhhnvghlseguvghllhdrtghomhdprhgtphhtthhopegr
    lhgvgigsvghlmhegkeesghhmrghilhdrtghomhdprhgtphhtthhopegtohhlihhnrdhird
    hkihhnghesghhmrghilhdrtghomhdprhgtphhtthhopegtohhrvghnthhinhdrtghhrghr
    hiesghhmrghilhdrtghomhdprhgtphhtthhopeguvghrvghkjhhohhhnrdgtlhgrrhhkse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:N498Z0op3Y51SDYOkqk2ZtRdIMc3zl_Rj4aL8GdpBtAKS1PuWu4WYg>
    <xmx:N498Z6l8XgiHhtNWEO08cmrs6tuPYrtJZ98SACGJ-AgIuRRydvNOlw>
    <xmx:N498Z02uSipbzfLSVNWbIiB5OWdiFHmHWLWaQf4EhhsJw4B18mFmXQ>
    <xmx:N498ZxsBSBBjfGCv60L6kw_rvshlfAmLt26kisLRkmnressUJp1b6w>
    <xmx:OY98Z2HXH_teyoKA0gRjuLXUOjuzfNumWAgrVkQ-X9EycfIIeJIoCg9n>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F00793C0066; Mon,  6 Jan 2025 21:19:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Jan 2025 21:19:14 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Kurt Borja" <kuurtb@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Cc: josh@joshuagrisham.com, hridesh699@gmail.com,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Maximilian Luz" <luzmaximilian@gmail.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Lee Chun-Yi" <jlee@suse.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Corentin Chary" <corentin.chary@gmail.com>,
 "Luke D . Jones" <luke@ljones.dev>, "Lyndon Sanche" <lsanche@lyndeno.ca>,
 "Ike Panhc" <ike.pan@canonical.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 "Armin Wolf" <W_Armin@gmx.de>, "Limonciello,
 Mario" <mario.limonciello@amd.com>,
 "Colin Ian King" <colin.i.king@gmail.com>,
 "Alexis Belmonte" <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Ai Chao" <aichao@kylinos.cn>, "Gergo Koteles" <soyer@irl.hu>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
Message-Id: <33a5b6a2-e4df-4bfc-88a9-a9e8309c7f7a@app.fastmail.com>
In-Reply-To: <20250106044605.12494-1-kuurtb@gmail.com>
References: <20250106044605.12494-1-kuurtb@gmail.com>
Subject: Re: [RFC PATCH 0/3] ACPI: platform_profile: Let drivers dynamically refresh
 choices
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Kurt,

On Sun, Jan 5, 2025, at 11:45 PM, Kurt Borja wrote:
> Hello,
>
> Some drivers may need to dynamically modify their selected `choices`.
> Such is the case of the acer-wmi driver, which implemented their own
> profile cycling method, because users expect different profiles to be
> available whether the laptop is on AC or not [1].
>
> These series would allow acer-wmi to simplify this custom cycling method
> to use platform_profile_cycle(), as it's already being proposed in these
> series [2]; without changing expected behaviors, by refreshing their
> selected choices on AC connect/disconnect events, which would also solve
> this discussion [3].
>
> Additionally, I think the platform_profile_ops approach would enable us
> to hide the platform_profile_handler in the future, and instead just pass
> the class device to get/set methods like the HWMON subsystem does.
>
> I think having this kind of flexibility is valuable. Let me know what you
> think!
>

I personally would love to see how this would be used for the acer issue highlighted to see how it would work out. It feels like the series is short a patch :)

As a side note, I did (many moons ago) propose a change to alter profiles used depending on AC/battery mode (in the thinkpad driver), and it was rejected as something that should be done in user space.
Your use case does seem somewhat different, but it's similar enough that if you get it working I'd be interested to see if I can take advantage of the approach too.

Mark

