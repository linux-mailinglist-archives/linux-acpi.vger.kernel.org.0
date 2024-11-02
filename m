Return-Path: <linux-acpi+bounces-9255-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D59B9C3B
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 03:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE005B21A66
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 02:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6770274040;
	Sat,  2 Nov 2024 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="EX5/LjnT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KO5VbYnB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E876F06B;
	Sat,  2 Nov 2024 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513747; cv=none; b=f7V5zg99wvKFJAAN5XpoljZ3FkvhXoM5YTYgcwJePTIvPZR+Vmzb2RsIcxqxE5tTVYPX5v0uBuhAJxfCH+Nm0GFEl91irvtCV5SRctooRKcEQXDnuG9DoV4U9mFEgxBzDouEa024NU0CqWQHD1SSQKVMDwlzprGq4r3ZSV7uEBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513747; c=relaxed/simple;
	bh=4HRyW9usEgJivrqYSxIzLmFyzTbk3OkwzMVmJVuPG34=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ii6MIRLp1BSV7/y4ePmAnD1+PWwFkM6RsQAiPYBYCvJK9RkMto37xYcJB0ZPUA9BKKvI8AH7ILoWHLkvmSgtJameLnsWw6aplGVw3JS8qP/iM+Y5v7fkkYAW+tKCpiqBrZ3I8vQ+EC6pwveVIRQnHLprKaviE39s770TkqU4us8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=EX5/LjnT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KO5VbYnB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 49952114007C;
	Fri,  1 Nov 2024 22:15:44 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 01 Nov 2024 22:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730513744;
	 x=1730600144; bh=JmyUrRjBzHgkkvAgRz/uOrtHBYfuEIrZL234zQOVTFc=; b=
	EX5/LjnTeE95z0qucJ44FBtGT7yyGwr63CLMmdXfXu/gOCAXRcmEzQBgA1TH+cSJ
	22XnyCgIyNigSf8MnyFQ55DU/YJWP0TMIczCv95KEND0RirbOoe/36sAAdQd9pg5
	ph0nd3lhXILA1DRoqDQf6Bg1iGmV6yhvc6lcYguGEyH3iOaKpoS8Zjg3OYUjWO5Q
	fLsa+geaWdhIwqtzK1GggK1Fhqy3prNv0V5UlcmAgLbjnWqbynG8ZPqbdIW8MmJZ
	7OE1FJKtD8mte7CXffqhenH7PMPTzX3UcgEem8AEahM1o2yQ7g+GHmxh60OqgV2p
	1p0z10G1pSZREza4Vs3qsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730513744; x=
	1730600144; bh=JmyUrRjBzHgkkvAgRz/uOrtHBYfuEIrZL234zQOVTFc=; b=K
	O5VbYnBtDvjRCxlge1nLiBEVKyHB5jKozzxnb6fqSTa4NFFnZK+MAyQEgTs9uM0b
	N6oxasnl+fZXvoXMtnBDTlE5kwXR99gyTUEiVd+9xiUSe5YYj3CWCyNB3ALphk3Z
	vxqMiqADxxN5Zo8COgLV+LnUt2QHBCeltybLINXP1a7+HaNjlBzZfPvamjxnTgt9
	0EU0uYKst83FG8vEpsvf/vKPkig8A82kbmDO9JOkcZ79QtJ4Z7NppqAHybED5LVd
	esa2wg4BOwuUBl+JjzWX5OXqljR0o8EtWSvSL0vv9mNnsvUYNr8zaYKDlWHmSIr1
	rmLHTCI1zzm1YJNr+dZ7w==
X-ME-Sender: <xms:T4slZ0chH_GVbtrw6ZRF8zT4dEsVDJ8_2xy_BevuGleO_3VAEQEL8g>
    <xme:T4slZ2MRkSl2q3mhbF5vLPBWA-MFMzmHpToGuJnHej9S5taoyPxTJIdH35wlJFoAx
    SEsD3Hq5yWM22dD6jM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehikhgvrdhprghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoheprghl
    vgigsggvlhhmgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgvnhhtihhnrd
    gthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrgigihhmihhlihgr
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehhmhhhsehhmhhhrdgvnhhgrdgsrhdprh
    gtphhtthhopehsohihvghrsehirhhlrdhhuhdprhgtphhtthhopehlvghnsgeskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:T4slZ1ixB-HzRg-vz_UmyxOcuo0K08BvIv7d4ApaOSA6aLFhu-IKeQ>
    <xmx:T4slZ5_-nsuy9KWFYyjTMFjvxLgRFWz7CJ8BTtsgVhI5I6xg2T_5RA>
    <xmx:T4slZwsITWQ19D14MjN_HcTITZBCpfI4kJPTc57msmYPGfTTpBC9SQ>
    <xmx:T4slZwHrEF8b32z7l_DmQd8ItEKxnaKR8K7ybvJA16JYlig2Y6YVHg>
    <xmx:UIslZxOOq-ER68RDDZ3syEPhV7n095GePArN1ycncqjlUUrZpnXsD-Q2>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8686A3C0066; Fri,  1 Nov 2024 22:15:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 Nov 2024 22:15:23 -0400
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
Message-Id: <c0f02ffd-9a29-4411-8e5e-13a4d93c558f@app.fastmail.com>
In-Reply-To: <20241031040952.109057-18-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-18-mario.limonciello@amd.com>
Subject: Re: [PATCH v3 17/22] ACPI: platform_profile: Add concept of a "custom" profile
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Oct 31, 2024, at 12:09 AM, Mario Limonciello wrote:
> When two profile handlers don't agree on the current profile it's ambiguous
> what to show to the legacy sysfs interface.
>
> Add a "custom" profile string that userspace will be able to distinguish
> this situation when using the legacy sysfs interface.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c  | 1 +
>  include/linux/platform_profile.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index c2bb325ba531c..3128bd16615b6 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -20,6 +20,7 @@ static const char * const profile_names[] = {
>  	[PLATFORM_PROFILE_BALANCED] = "balanced",
>  	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
>  	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
> +	[PLATFORM_PROFILE_CUSTOM] = "custom",
>  };
>  static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
> 
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 6aad98f4abaf4..da009c8a402c9 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -23,6 +23,7 @@ enum platform_profile_option {
>  	PLATFORM_PROFILE_BALANCED,
>  	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
>  	PLATFORM_PROFILE_PERFORMANCE,
> +	PLATFORM_PROFILE_CUSTOM,
>  	PLATFORM_PROFILE_LAST, /*must always be last */
>  };
> 
> -- 
> 2.43.0

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

