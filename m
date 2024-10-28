Return-Path: <linux-acpi+bounces-9036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3909B2C4F
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 11:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBED51F223E5
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 10:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297B1CC8B2;
	Mon, 28 Oct 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Bz3gPrvS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NWdQ7+GI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786018B46E;
	Mon, 28 Oct 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110064; cv=none; b=DC5DVYmspCB6jLYWoRa0Ry/qWQzo6JlirYJxCqR+LsXAskZ+zGwKzPH36e+Qtwf4lGI9OdpKDbF3tH41UT6/jqBTu9lng2dBNteAkbeWPRRPQoNnxZ7QwlAxsny/8nXCLLnK8WtajOgjYy3TVGgi8j4jyag/k3dWk0y+4DiuUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110064; c=relaxed/simple;
	bh=fPb8qQLzBRJvCvTo05/AaCTxKl1g8V/bXqxYAZzNU9E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DxNZoLkAOdcGqCLRmzMwX5KZubL1dfvB8V0lw9u7qDF1D0R3LkIftJVy/mJVN/BUybj4RkknuWo/Thul5BkgHfY8roSoKhAvsNAQqHzAbp/DNpvnxY7BVl61Ubo0bc1++I3d+rmC4zquBj+UCCL4eLM4/wjKXgD0U2TvpUBF144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Bz3gPrvS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NWdQ7+GI; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9990E11400FC;
	Mon, 28 Oct 2024 06:07:39 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Mon, 28 Oct 2024 06:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730110059;
	 x=1730196459; bh=zpVCVnKNAbqxoyZ/9RQal9LIDE3t1qOufDxKPWWH5zM=; b=
	Bz3gPrvSE1u2Jp3zcvNqLIgtS7gDWMUnjYMZwbN9jT0laM+CoThXEGY5b8gRoiHd
	YDzGI+8HQP5xXE77HxV/LglCXiU6zz4fpUExBPX2qEmH+wo8FBMn62SRi1yYfPzw
	Zu4NkaD8cNaiU/0ybJqyCWOl6cPmU029/bQdFAfwma1AhNRF3+bEkwE2TbOdSWgZ
	hKPo3avc4gQ7m5oiGNw+c6ZoJbH/id3P0yeu82lcDCycOSOy/tnNjwgnu7cfosC2
	tU0cRFzIbL4UAkpPudUvI2G8912MlMzd39qaShQusIEQJHoHCPyz+I4yiSXuTztj
	SdAfrJ6EwxOwWzNUH2jOlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730110059; x=
	1730196459; bh=zpVCVnKNAbqxoyZ/9RQal9LIDE3t1qOufDxKPWWH5zM=; b=N
	WdQ7+GI2ygJZ7I+cYyb9tXX8HC6956Uclg4Q3v2NfImYW3tvzkEaKdhbR19Xpp4H
	So+KxxThq2XslwtVrBv0y77qRMXMbAZkxEDEJB7P8y+FGW1x5KdufrocBNvxmIf7
	8sME9CeQOB3EzkyfuUGuDfDrpZ56Llm6grv12lk0DCY05JN1ZAAURpZSNBgAR0gK
	hhTYHkFmu8m1mhy48CwDcGYelv3v7yKM3WLwVbsr+ovV+Qsr8eCQkB0+DaSCn0Qd
	uVRqD+Y8xHbmxjq2oTKuIT/Ib59YPK1IZn3ESZ5FBlwOYjtp5H20IOcq22pUwslD
	RKJSe0Frk5r/1tkXH6Fjw==
X-ME-Sender: <xms:aWIfZ8n4NI9jOTrhs_B-s3cAwpFYqVDbSBoPD_JPNdLAMV5_519pMg>
    <xme:aWIfZ72fVIDaVXnD70Tv6g_0gCGgOt_yCcNYQyT3tG6gq4ETRDKFylefTXImAcyAw
    6W_s1SheLB0GTLkE9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejkedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehikhgvrdhprghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoheprghl
    vgigsggvlhhmgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgvnhhtihhnrd
    gthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrgigihhmihhlihgr
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehhmhhhsehhmhhhrdgvnhhgrdgsrhdprh
    gtphhtthhopehsohihvghrsehirhhlrdhhuhdprhgtphhtthhopehlvghnsgeskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:aWIfZ6opKMutfh8H0IjY5UvPokSKzzK8DOsnhaZH1ZzFzOdXEBky-A>
    <xmx:aWIfZ4nlI68s1IQGm7PiDVmEtktDibFd9EavHboWC_B1PH6EaVqglw>
    <xmx:aWIfZ62VEXeSovcriCz6wwmmyKYd15xgwIywFpBkqFn9D7S33LXq9A>
    <xmx:aWIfZ_vEWAFwfQvS6OoHbqDiF3VXHvLYnMM7HUzKjaaFAl6bpsvp9A>
    <xmx:a2IfZ0WG9t8KGBr82f2tt_TAJ27K_GAnM7KWXlB_lghM0g6sEIZvD_KL>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C94833C0066; Mon, 28 Oct 2024 06:07:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 06:07:16 -0400
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
Message-Id: <c5d52213-cb1b-408c-8fb5-a7401f690d24@app.fastmail.com>
In-Reply-To: <20241025193055.2235-2-mario.limonciello@amd.com>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-2-mario.limonciello@amd.com>
Subject: Re: [PATCH 1/8] ACPI: platform-profile: Add a name member to handlers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks Mario,

On Fri, Oct 25, 2024, at 3:30 PM, Mario Limonciello wrote:
> In order to prepare for allowing multiple handlers, introduce
> a name field that can be used to distinguish between different
> handlers.
>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/surface/surface_platform_profile.c | 1 +
>  drivers/platform/x86/acer-wmi.c                     | 1 +
>  drivers/platform/x86/amd/pmf/sps.c                  | 1 +
>  drivers/platform/x86/asus-wmi.c                     | 1 +
>  drivers/platform/x86/dell/dell-pc.c                 | 1 +
>  drivers/platform/x86/hp/hp-wmi.c                    | 1 +
>  drivers/platform/x86/ideapad-laptop.c               | 1 +
>  drivers/platform/x86/inspur_platform_profile.c      | 1 +
>  drivers/platform/x86/thinkpad_acpi.c                | 1 +
>  include/linux/platform_profile.h                    | 1 +
>  10 files changed, 10 insertions(+)
>
> diff --git a/drivers/platform/surface/surface_platform_profile.c 
> b/drivers/platform/surface/surface_platform_profile.c
> index 3de864bc66108..61aa488a80eb5 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -211,6 +211,7 @@ static int surface_platform_profile_probe(struct 
> ssam_device *sdev)
> 
>  	tpd->sdev = sdev;
> 
> +	tpd->handler.name = "Surface Platform Profile";
>  	tpd->handler.profile_get = ssam_platform_profile_get;
>  	tpd->handler.profile_set = ssam_platform_profile_set;
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index d09baa3d3d902..53fbc9b4d3df7 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1878,6 +1878,7 @@ static int acer_platform_profile_setup(void)
>  	if (quirks->predator_v4) {
>  		int err;
> 
> +		platform_profile_handler.name = "acer-wmi";
>  		platform_profile_handler.profile_get =
>  			acer_predator_v4_platform_profile_get;
>  		platform_profile_handler.profile_set =
> diff --git a/drivers/platform/x86/amd/pmf/sps.c 
> b/drivers/platform/x86/amd/pmf/sps.c
> index 92f7fb22277dc..e2d0cc92c4396 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -405,6 +405,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>  		amd_pmf_set_sps_power_limits(dev);
>  	}
> 
> +	dev->pprof.name = "amd-pmf";
>  	dev->pprof.profile_get = amd_pmf_profile_get;
>  	dev->pprof.profile_set = amd_pmf_profile_set;
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 2ccc23b259d3e..c7c104c65a85a 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3910,6 +3910,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
> 
>  	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
> 
> +	asus->platform_profile_handler.name = "asus-wmi";
>  	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
>  	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
> 
> diff --git a/drivers/platform/x86/dell/dell-pc.c 
> b/drivers/platform/x86/dell/dell-pc.c
> index 972385ca1990b..3cf79e55e3129 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -247,6 +247,7 @@ static int thermal_init(void)
>  	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
>  	if (!thermal_handler)
>  		return -ENOMEM;
> +	thermal_handler->name = "dell-pc";
>  	thermal_handler->profile_get = thermal_platform_profile_get;
>  	thermal_handler->profile_set = thermal_platform_profile_set;
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 81ccc96ffe40a..26cac73caf2b9 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1624,6 +1624,7 @@ static int thermal_profile_setup(void)
>  		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>  	}
> 
> +	platform_profile_handler.name = "hp-wmi";
>  	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
>  	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c 
> b/drivers/platform/x86/ideapad-laptop.c
> index 9d8c3f064050e..1f94c14c3b832 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1102,6 +1102,7 @@ static int ideapad_dytc_profile_init(struct 
> ideapad_private *priv)
> 
>  	mutex_init(&priv->dytc->mutex);
> 
> +	priv->dytc->pprof.name = "ideapad-laptop";
>  	priv->dytc->priv = priv;
>  	priv->dytc->pprof.profile_get = dytc_profile_get;
>  	priv->dytc->pprof.profile_set = dytc_profile_set;
> diff --git a/drivers/platform/x86/inspur_platform_profile.c 
> b/drivers/platform/x86/inspur_platform_profile.c
> index 8440defa67886..03da2c8cf6789 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -177,6 +177,7 @@ static int inspur_wmi_probe(struct wmi_device 
> *wdev, const void *context)
>  	priv->wdev = wdev;
>  	dev_set_drvdata(&wdev->dev, priv);
> 
> +	priv->handler.name = "inspur-wmi";
>  	priv->handler.profile_get = inspur_platform_profile_get;
>  	priv->handler.profile_set = inspur_platform_profile_set;
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c 
> b/drivers/platform/x86/thinkpad_acpi.c
> index 4c1b0553f8720..c8c316b8507a5 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10549,6 +10549,7 @@ static void dytc_profile_refresh(void)
>  }
> 
>  static struct platform_profile_handler dytc_profile = {
> +	.name = "thinkpad-acpi",
>  	.profile_get = dytc_profile_get,
>  	.profile_set = dytc_profile_set,
>  };
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index f5492ed413f36..6fa988e417428 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -27,6 +27,7 @@ enum platform_profile_option {
>  };
> 
>  struct platform_profile_handler {
> +	const char *name;
>  	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>  	int (*profile_get)(struct platform_profile_handler *pprof,
>  				enum platform_profile_option *profile);
> -- 
> 2.43.0

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

