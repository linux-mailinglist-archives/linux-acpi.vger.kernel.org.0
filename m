Return-Path: <linux-acpi+bounces-9250-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED4F9B9C25
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 03:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C213A1C20FF1
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 02:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A7E6F06B;
	Sat,  2 Nov 2024 02:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="nFkG4f5z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OwksQrbv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6456B8C;
	Sat,  2 Nov 2024 02:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513634; cv=none; b=J6xKVip7sZ8/mXy+EL9FFB1EfInZ5cgrq9InTxmfxH6qfyulyIKdPTeX7/R1B5ksbk73kbtt7E6ylScdCc5daia8fGLwLljVQ61CW6lGuWFZ0B83OAVdB8Jdl4nvlbf1SpwhCfiPKdY++nmZZnvyATV8aJiKxU54F2nTODjzFwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513634; c=relaxed/simple;
	bh=WUfYaUuP9tFP6jFiAt8HcG9sZ5E/LB342yCiXY2XOvA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XBM1nQCR4NqeXjC+1cL/z8iDzKXkrCxnYPC9+5tjvGlYi/BTYyE6qAr+ZRC0txZpzcouUJiziZ45hPNSPSom2dNLeUs8FbjHP9qeLSlrKNnKhFkqHZoXbmdqLnAJblB8kSi0jmHTWWc/q8mUhInCFwxzbk4qDtZmvDu9STzcf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=nFkG4f5z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OwksQrbv; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 704C925400F5;
	Fri,  1 Nov 2024 22:13:50 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 01 Nov 2024 22:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730513630;
	 x=1730600030; bh=3zJUN+AqHJHOJne5fh45VBxZW11Ozx3k6Eitjcd7/Ek=; b=
	nFkG4f5zueR9M5aKVAPVU1xO8m3iVD1qvACPLbU+XpJqey6mFiPoj16niXRJbRvq
	GjQfN9RdHyvp7S+ReWq+0wkU/dsjlZNU/r1n0FZO4i05x7IYYw1Gtym3fuRpEUqB
	WriRJe8CVA9tszd981W4corZqE36mDhgIZ0A2BRygP5MDmkntY58dAFa4CgFhaFm
	LiZDyAQn9bFMEvXS2btkrHCPq0Y+stn7gAF8tbsQVpE5n7FXsWgSD+z5w1El99fG
	e9jWsP/4EPO/ozWHYiZvI5RnktcehvSqtDvkvNLz+mUd5pwruxieMEGgm3T88+zC
	/fKxe0qV/xYVLB+T2Q5oVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730513630; x=
	1730600030; bh=3zJUN+AqHJHOJne5fh45VBxZW11Ozx3k6Eitjcd7/Ek=; b=O
	wksQrbvambdYYboH3Qnyd9esb4zA9s8bUsZmkKqWEweZHOyoOhJyAaYuUZlhY7wI
	l1syshR1JolfMaKSBrPqDvW/owdHJ6NvRdNKHQwap8m6DQS/nncQ64Xx3B7r1Xvc
	1w5p+7wJS51jEO9ccjSVekZlU6SjdLdRgTES8wTqyfHix/8q1IYeWdH8NPXm+m5G
	K+tgiqNOG6I7yHqdzK1rpRgHt5L3Me/T8Rp7AuBw1Mz00U0cq9SVIU4e8krB6k5m
	lpO11OdEYkIQtyVzGeeqNUlm+PirlFvuW3PFr4Sf6qEGFylDckp2SNKNYeHojfTy
	0cLfEU/1BVOz2/CkeX6qA==
X-ME-Sender: <xms:3oolZ5y6w5da-uMBBDK7UTcTyOgqRPHE0GPHpKB--fH4bJPFdvYMAA>
    <xme:3oolZ5S4xA8mb-NfK_yzhXTqDh1PaJpcZdGtRzkUoAPwu0sXnZ3sppe0PsmRyvvkz
    nO8Q0CMTva0Bld37OY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehikhgvrdhprghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoheprghl
    vgigsggvlhhmgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgvnhhtihhnrd
    gthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrgigihhmihhlihgr
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehhmhhhsehhmhhhrdgvnhhgrdgsrhdprh
    gtphhtthhopehsohihvghrsehirhhlrdhhuhdprhgtphhtthhopehlvghnsgeskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:3oolZzXnZ-yWU6HCPuLOUZFWgJrguwieOy3wn7IeGm_n4v4zW77xaw>
    <xmx:3oolZ7h7tmGWA__uMhNxj7txdCRRtwASPheQ9kOXBoT7hNetSA_t6Q>
    <xmx:3oolZ7DBvWfuabR1GuSy1X-GkSGhP6_DlHzh3PXG_18RioMUm7_JPg>
    <xmx:3oolZ0I09lbvLDJjwQ1dsAy4bcS-RIGsqnCq5ftNdsgxwRNLh0rC0g>
    <xmx:3oolZ6DaS9erh0RU29FWhV7M_Zu5Rto6o_vfjoIb-aJU5_rwbluCNAGu>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 178593C0066; Fri,  1 Nov 2024 22:13:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 Nov 2024 22:13:29 -0400
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
Message-Id: <001da1b0-c81d-45ed-b59b-47700721faf9@app.fastmail.com>
In-Reply-To: <20241031040952.109057-4-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-4-mario.limonciello@amd.com>
Subject: Re: [PATCH v3 03/22] ACPI: platform_profile: Add device pointer into platform
 profile handler
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 31, 2024, at 12:09 AM, Mario Limonciello wrote:
> In order to let platform profile handlers manage platform profile
> for their driver the core code will need a pointer to the device.
>
> Add this to the structure and use it in the trivial driver cases.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c                     | 5 +++++
>  drivers/platform/surface/surface_platform_profile.c | 1 +
>  drivers/platform/x86/acer-wmi.c                     | 5 +++--
>  drivers/platform/x86/amd/pmf/sps.c                  | 1 +
>  drivers/platform/x86/asus-wmi.c                     | 1 +
>  drivers/platform/x86/dell/dell-pc.c                 | 1 +
>  drivers/platform/x86/hp/hp-wmi.c                    | 5 +++--
>  drivers/platform/x86/ideapad-laptop.c               | 1 +
>  drivers/platform/x86/inspur_platform_profile.c      | 1 +
>  drivers/platform/x86/thinkpad_acpi.c                | 1 +
>  include/linux/platform_profile.h                    | 1 +
>  11 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c 
> b/drivers/acpi/platform_profile.c
> index d2f7fd7743a13..5d9f3f7ba71c5 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -179,6 +179,11 @@ int platform_profile_register(struct 
> platform_profile_handler *pprof)
>  {
>  	int err;
> 
> +	if (!pprof->dev) {
> +		pr_err("platform_profile: handler device is not set\n");
> +		return -EINVAL;
> +	}
> +
>  	mutex_lock(&profile_lock);
>  	/* We can only have one active profile */
>  	if (cur_profile) {
> diff --git a/drivers/platform/surface/surface_platform_profile.c 
> b/drivers/platform/surface/surface_platform_profile.c
> index 9d3e3f9458186..b73cfdd920c66 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -212,6 +212,7 @@ static int surface_platform_profile_probe(struct 
> ssam_device *sdev)
>  	tpd->sdev = sdev;
> 
>  	tpd->handler.name = "Surface Platform Profile";
> +	tpd->handler.dev = &sdev->dev;
>  	tpd->handler.profile_get = ssam_platform_profile_get;
>  	tpd->handler.profile_set = ssam_platform_profile_set;
> 
> diff --git a/drivers/platform/x86/acer-wmi.c 
> b/drivers/platform/x86/acer-wmi.c
> index 13a97afe0112d..a5caa529351ea 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1878,12 +1878,13 @@ acer_predator_v4_platform_profile_set(struct 
> platform_profile_handler *pprof,
>  	return 0;
>  }
> 
> -static int acer_platform_profile_setup(void)
> +static int acer_platform_profile_setup(struct platform_device *device)
>  {
>  	if (quirks->predator_v4) {
>  		int err;
> 
>  		platform_profile_handler.name = "acer-wmi";
> +		platform_profile_handler.dev = &device->dev;
>  		platform_profile_handler.profile_get =
>  			acer_predator_v4_platform_profile_get;
>  		platform_profile_handler.profile_set =
> @@ -2536,7 +2537,7 @@ static int acer_platform_probe(struct 
> platform_device *device)
>  		goto error_rfkill;
> 
>  	if (has_cap(ACER_CAP_PLATFORM_PROFILE)) {
> -		err = acer_platform_profile_setup();
> +		err = acer_platform_profile_setup(device);
>  		if (err)
>  			goto error_platform_profile;
>  	}
> diff --git a/drivers/platform/x86/amd/pmf/sps.c 
> b/drivers/platform/x86/amd/pmf/sps.c
> index e2d0cc92c4396..1b94af7c0e0c4 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -406,6 +406,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>  	}
> 
>  	dev->pprof.name = "amd-pmf";
> +	dev->pprof.dev = dev->dev;
>  	dev->pprof.profile_get = amd_pmf_profile_get;
>  	dev->pprof.profile_set = amd_pmf_profile_set;
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 6177fbee60573..1a8c29aafe892 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3921,6 +3921,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
>  	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
> 
>  	asus->platform_profile_handler.name = "asus-wmi";
> +	asus->platform_profile_handler.dev = dev;
>  	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
>  	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
> 
> diff --git a/drivers/platform/x86/dell/dell-pc.c 
> b/drivers/platform/x86/dell/dell-pc.c
> index b145fedb6b710..730f97aab70cd 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -260,6 +260,7 @@ static int thermal_init(void)
>  		goto cleanup_platform_device;
>  	}
>  	thermal_handler->name = "dell-pc";
> +	thermal_handler->dev = &platform_device->dev;
>  	thermal_handler->profile_get = thermal_platform_profile_get;
>  	thermal_handler->profile_set = thermal_platform_profile_set;
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c 
> b/drivers/platform/x86/hp/hp-wmi.c
> index 10a853b6b0514..1b6677e176769 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1565,7 +1565,7 @@ static inline void 
> omen_unregister_powersource_event_handler(void)
>  	unregister_acpi_notifier(&platform_power_source_nb);
>  }
> 
> -static int thermal_profile_setup(void)
> +static int thermal_profile_setup(struct platform_device *device)
>  {
>  	int err, tp;
> 
> @@ -1625,6 +1625,7 @@ static int thermal_profile_setup(void)
>  	}
> 
>  	platform_profile_handler.name = "hp-wmi";
> +	platform_profile_handler.dev = &device->dev;
>  	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
>  	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
> 
> @@ -1664,7 +1665,7 @@ static int __init hp_wmi_bios_setup(struct 
> platform_device *device)
>  	if (err < 0)
>  		return err;
> 
> -	thermal_profile_setup();
> +	thermal_profile_setup(device);
> 
>  	return 0;
>  }
> diff --git a/drivers/platform/x86/ideapad-laptop.c 
> b/drivers/platform/x86/ideapad-laptop.c
> index 6c72d1b6a2aff..feaf98819dc82 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1103,6 +1103,7 @@ static int ideapad_dytc_profile_init(struct 
> ideapad_private *priv)
>  	mutex_init(&priv->dytc->mutex);
> 
>  	priv->dytc->pprof.name = "ideapad-laptop";
> +	priv->dytc->pprof.dev = &priv->platform_device->dev;
>  	priv->dytc->priv = priv;
>  	priv->dytc->pprof.profile_get = dytc_profile_get;
>  	priv->dytc->pprof.profile_set = dytc_profile_set;
> diff --git a/drivers/platform/x86/inspur_platform_profile.c 
> b/drivers/platform/x86/inspur_platform_profile.c
> index 03da2c8cf6789..5a53949bbbf5f 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -178,6 +178,7 @@ static int inspur_wmi_probe(struct wmi_device 
> *wdev, const void *context)
>  	dev_set_drvdata(&wdev->dev, priv);
> 
>  	priv->handler.name = "inspur-wmi";
> +	priv->handler.dev = &wdev->dev;
>  	priv->handler.profile_get = inspur_platform_profile_get;
>  	priv->handler.profile_set = inspur_platform_profile_set;
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c 
> b/drivers/platform/x86/thinkpad_acpi.c
> index c8c316b8507a5..222fba97d79a7 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10616,6 +10616,7 @@ static int tpacpi_dytc_profile_init(struct 
> ibm_init_struct *iibm)
>  	dbg_printk(TPACPI_DBG_INIT,
>  			"DYTC version %d: thermal mode available\n", dytc_version);
> 
> +	dytc_profile.dev = &tpacpi_pdev->dev;
>  	/* Create platform_profile structure and register */
>  	err = platform_profile_register(&dytc_profile);
>  	/*
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 6fa988e417428..daec6b9bad81f 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -28,6 +28,7 @@ enum platform_profile_option {
> 
>  struct platform_profile_handler {
>  	const char *name;
> +	struct device *dev;
>  	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>  	int (*profile_get)(struct platform_profile_handler *pprof,
>  				enum platform_profile_option *profile);
> -- 
> 2.43.0

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

