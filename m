Return-Path: <linux-acpi+bounces-8027-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 335B6966E4F
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Aug 2024 02:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625CF1C21991
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Aug 2024 00:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD0A18E11;
	Sat, 31 Aug 2024 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="QuWLYuJ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l295HFZZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA62C9D
	for <linux-acpi@vger.kernel.org>; Sat, 31 Aug 2024 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725065603; cv=none; b=IfrWsBNKc5xRPbXm1ct8yi+TskqFGyQCf08/euyNWkVrpGlQK58Iih8pY71YB3rgedYcUwKs2oHiVSFXQ2AJ7bWv1n/ODkaIbCdwVw9DNRfnP37cfEzfPhbhKE50xk1vK0Z9feJbtMoAgfJbyOoXHtGt/UB5DK1OdhTQsTl4hGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725065603; c=relaxed/simple;
	bh=RSgAFM+s4NYy28GcS25L7Yvm/ahG56iD8UxHKAviw5M=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nkNXVK/mPiAySiatjYx9HbVvXXGLlFEDuVFRU3GXhwpaWtQ4VeUXAzA4pJRB8ibW5EoNUHiZtHA7J6xXzwBwiv2SyQcQ20MPeGpZ7cxnaydmk0FGG/PF2dOSB+WwOTKS5RIeWFSUkGEqQk+GgcM4lIo5DzpuMKgvDBzWpIgJJfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=QuWLYuJ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l295HFZZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 81C64114028A;
	Fri, 30 Aug 2024 20:53:20 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 30 Aug 2024 20:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1725065600;
	 x=1725152000; bh=2t26mQMc1ANRroYBCeYIG18XlEnyN5pk/pRgDDdenSk=; b=
	QuWLYuJ1vkKPk7pcm0oeu1VkMkgroWXfJu8l1/HwDzb7hBIpJXlln8o6AJN/wf+a
	t6ZBPbeU/amOoNkUul5MRsX3GlDK/JqjavBFpW76xXQkXSQkpWu1eeUSGXxVbrCL
	xUVuaODb7KNRfjJjguOMuWM6oUhlvxH7+n0MtPYChBA/BNqpY0DRRdX51DITv2Ma
	gMvjZdOOhGcZ1dtdg4QzFWub59r+SBJPzzym07Y5X3OwwAQ9WGsMO3wsYgZhQfJK
	WPV/bozJOUQkDRLM98ADXaQ2Izz/5AXgRrGYE8HaorErvKRDuQjHJ2c9FDWF8oqK
	QeJtG2nfgD3MH4fCUAo7tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725065600; x=
	1725152000; bh=2t26mQMc1ANRroYBCeYIG18XlEnyN5pk/pRgDDdenSk=; b=l
	295HFZZ/Md+gAu9HuyI4BXxo5HDeclRdBeboF4YGYS9i6fCHufzMrrZgkU1SUPmN
	NE3aZksQfBc6lrtOeOOkUIY+hms6kKk/XoHHkLUS/aM7AhWSRAc9ODl/ARQ7MXdd
	w0HoboMnYnAD/qXffvLjR1HUNoR+efLTBNKs2YZ8etT38XFWV4iyh5rKXTGf8Vw8
	gvlclYcmA5eeOubGCvb2xQRNsgo0IgtlJ/ug2x7ZxLKOii9XFZvx10c4iavOyE5N
	s0xXtakbq4n6HpwGOa2QUdRuCkYKWgmAfb/eVLedAhi35agl4pzH+7VNBA0mtE6a
	gajwSpD0f5JzWhG4b6OFw==
X-ME-Sender: <xms:gGnSZlEbHUBzINoxOfuFQHffNy7chIZZLzUKlpYZykafG564TlJ0_Q>
    <xme:gGnSZqWDkSeGjD5PzF8oweHYR-4tBlWu8vt4TwKpEL9JNPlU4S_cD9sQYuAuZy9oz
    8x4pZIQXv7iLp588R4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefjedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnoh
    hvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhepfeelvefgleegueevudel
    veekkeeuhfdtjeehjeetteekffelieevledtffetjeeknecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprhgtph
    htthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghilhesuggrvhhi
    ugdqsggruhgvrhdrnhgvthdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gGnSZnKjt_6RaYfHB3rF67LhPqikCSI7-GhG7d2Ud671iCd_J3Qh6w>
    <xmx:gGnSZrFvBD_VGskZIG7eVNKj9NUE6K5xRrzY4EERomPF_S5qiy0NCw>
    <xmx:gGnSZrVYrILX5GSquq7CfXLbXBzhg3KJi3nse8vjjwmtSS2qK8PrRA>
    <xmx:gGnSZmP_1rhdVDFmvu-uWMyVaI6aG-7dydE0Dyma5IXJXhKFwf217g>
    <xmx:gGnSZmTOTKh_VkWFuszv9E4VgnwzRhHDiKKj3awKcRQkrX5VaZFd7mkC>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 44A1A3C0066; Fri, 30 Aug 2024 20:53:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Aug 2024 20:53:00 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "David Bauer" <mail@david-bauer.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Message-Id: <84ec8f08-bc7b-490b-a6f3-0f41ca99dbc0@app.fastmail.com>
In-Reply-To: <20240831003610.89970-1-mail@david-bauer.net>
References: <20240831003610.89970-1-mail@david-bauer.net>
Subject: Re: [PATCH] ACPI: EC: add quirk for Lenovo X13 G4 (AMD)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi David,

On Fri, Aug 30, 2024, at 8:36 PM, David Bauer wrote:
> This adds a quirk for the Lenovo X13 Gen 4 AMD platform.
>
> If booted without the kernel-parameter acpi.ec_no_wakeup=1 the system
> will resume from sleep upon change of AC state. Unplugging or plugging
> the power cable thus wakes the system from suspend.
>
> Disabling wakeups from the embedded controller fixes this behavior.
> Resuming by opening the lid stays functional.
>
> Only apply this fix for the AMD version, as it is unknown if the Intel
> platform is also affected.
>
> This was observed on a system with the following BIOS / EC software:
> BIOS: 1.28 (R29ET54W)
> EC: 1.31 (R29HT55W)
>
> Signed-off-by: David Bauer <mail@david-bauer.net>
> ---
>  drivers/acpi/ec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 38d2f6e6b12b..f00cdcf06eb8 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2252,6 +2252,13 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>  			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Yoga 3rd"),
>  		},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			/* ThinkPad X13 Gen 4 (AMD) */
> +			DMI_MATCH(DMI_PRODUCT_SKU, "LENOVO_MT_21J3_BU_Think_FM_ThinkPad X13 Gen 4"),
> +		},
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> -- 
> 2.45.2

I believe you've hit the issue that is being tracked in https://bugzilla.kernel.org/show_bug.cgi?id=219196

We're working with Qualcomm to get that addressed. It impacts systems with the Qualcomm Wifi chip that uses the ath11k driver. I haven't specifically reproduced it on the X13 G4 - but we've seen it on three other platforms and it sounds exactly the same.

You can confirm by using a 6.9 kernel and it should work correctly. If it doesn't, please let me know and we can investigate further.
This is a Linux certified platform and I'd rather get issues fixed correctly than have to quirk them in the kernel and potentially impact other functionality.

Thanks
Mark

