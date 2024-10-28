Return-Path: <linux-acpi+bounces-9037-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA079B2C58
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 11:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697EA1F22511
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B51CCEE6;
	Mon, 28 Oct 2024 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Uj6S+w3E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m06uzmj6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5635918B46E;
	Mon, 28 Oct 2024 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110159; cv=none; b=IsKB/EDkDv0vcP+7PJ1tHwj0g+908E7axID/enZA959RPM6KqeCYrGCFjO1xvKFXGLoAwGIzdMGXVL9kXogQEClZt8ExoYWVUyAZb/G0gBce5OtlAv+F2m8WVPKOmP0e/XVDSjxYfG9OE1oezbP/47rzHZ1aoXtZw3hu5UxQbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110159; c=relaxed/simple;
	bh=ctBpJEXIXgw8Zs2ARo2OhQ5KKmdvndE9TdmFFNIuhsE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eRBF3LoUCsaM5eDGByHnnRVEQ7SZ1jPW2CFsypJwYXFw/ZZe/1iBRrQVE0umEy/T+MrayMR8q3IHTK/UANfVSPN5/yLPwy+SNdFojM+8bx7nhTsipVsz1VFj3o0HAn6cbGCf47s0x3fThJ+EmqU+G4HxvDV1nKo0RCdW755i/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Uj6S+w3E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m06uzmj6; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A4E0825400E3;
	Mon, 28 Oct 2024 06:09:15 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Mon, 28 Oct 2024 06:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730110155;
	 x=1730196555; bh=sar9VsxVQKkAejXjEiNOhId5O63SyubO6yyvZ3N3wos=; b=
	Uj6S+w3EsK7vBGgYgRiNHAeBCOjO+hluLm/ZDEx16mTCxKPnbtQc8xJN4zWjXo+i
	+ddku4qMcPJ4Jw/zggHuT75VDnU8ZB3nKvJYcDaZDuaS27FunM5GfPsxHW9Tfzuu
	Cro6LlUUFiT3fc3XJjrii9/UpciZIgUsh5p+Z5/uR02KoApd9QNbWhPpOvXPyQ+B
	aQkqN3xyfaRQOw/2BQOwtyWCm79QhePNv0GlARInbliOp54dZEb7ZsyojJbhQPn9
	r6VMhLdWFNeHxR8quV3svsp6W/NBihxCzkHKMudb76Qf7ZODKsfrhJZpf5E/DKuu
	cMoPfN3bYbLpzOAn9uloKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730110155; x=
	1730196555; bh=sar9VsxVQKkAejXjEiNOhId5O63SyubO6yyvZ3N3wos=; b=m
	06uzmj6UrsA6Qz3BrugQ3VMh8EJHifVlKz31dTerIC8Nc/uYJ4vxWwKugOAsdHQc
	ZoIxWHi13/tWPB1tYPW9PQzDqAkk7vYETZ9YVuF0SGdhtTeEr4kR7APZvdpTZGNZ
	LhgaO7P0KHxKCzoKGcZ2Gd/wLN24FIyHAz1CjRPorRe8mkO+R1cNmk3fMp7l/5mq
	Wo0zaS0ei9YUl+ndJbphQ9OGE8UTvPmlt7h+9wWZek9J4PMddY/5TT0P1PUTiRgG
	hV39SjLaYHGOK3sc0cSJqLSgPd7CoFJc7alnXef37CD81ZGzA5ggtuCPwGkY2h2r
	lzQsS58+Gn0bbevWyJeEA==
X-ME-Sender: <xms:ymIfZ7DP-SF0NnlxihdXVJPG84rrLBdEZwOv9RMk9xt6oZPm-6UdbA>
    <xme:ymIfZxiqK0ZpDAGFME6hJUvwyIb-i0TZyjXOTUBUnVJOw2IIJs5qEPhPA4zoOKn6X
    BN07IVqGFvXKw7OlCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejkedgudduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:ymIfZ2lU6bB_nQCB6QBhlau5S4mCOfg0wNDw6Gt1fX5qugpWIGO-vw>
    <xmx:ymIfZ9yy3hjeaciaQQCLZdLt7xqyRPMJLVcbpCZWRpP9RS14dQJNJQ>
    <xmx:ymIfZwSUl5KDdYo8NaAWlKR78KTG9jzZOXYUKjxdAJvmq3Gzox5_Uw>
    <xmx:ymIfZwY6HAZmRpVLn3OBYd6TSHHOTOwv17FI7JRTaJEsJ62XvjaHsw>
    <xmx:y2IfZ5SmE_-4EeWtNR4G_HnlCuKLDtuqjDRmS9XG1jgOSEtuP99Fajk3>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5C2A73C0066; Mon, 28 Oct 2024 06:09:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 06:08:54 -0400
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
Message-Id: <67ce52b7-d63b-432d-8cad-50063c06c394@app.fastmail.com>
In-Reply-To: <20241025193055.2235-4-mario.limonciello@amd.com>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-4-mario.limonciello@amd.com>
Subject: Re: [PATCH 3/8] ACPI: platform_profile: Add platform handler argument to
 platform_profile_remove()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Oct 25, 2024, at 3:30 PM, Mario Limonciello wrote:
> To allow registering and unregistering multiple platform handlers calls
> to platform_profile_remove() will need to know which handler is to be
> removed.  Add an argument for this.
>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c                     | 2 +-
>  drivers/platform/surface/surface_platform_profile.c | 2 +-
>  drivers/platform/x86/acer-wmi.c                     | 4 ++--
>  drivers/platform/x86/amd/pmf/sps.c                  | 2 +-
>  drivers/platform/x86/asus-wmi.c                     | 4 ++--
>  drivers/platform/x86/dell/dell-pc.c                 | 2 +-
>  drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
>  drivers/platform/x86/ideapad-laptop.c               | 2 +-
>  drivers/platform/x86/inspur_platform_profile.c      | 4 +++-
>  drivers/platform/x86/thinkpad_acpi.c                | 2 +-
>  include/linux/platform_profile.h                    | 2 +-
>  11 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c 
> b/drivers/acpi/platform_profile.c
> index d2f7fd7743a13..c24744da20916 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -205,7 +205,7 @@ int platform_profile_register(struct 
> platform_profile_handler *pprof)
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_register);
> 
> -int platform_profile_remove(void)
> +int platform_profile_remove(struct platform_profile_handler *pprof)
>  {
>  	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> 
> diff --git a/drivers/platform/surface/surface_platform_profile.c 
> b/drivers/platform/surface/surface_platform_profile.c
> index 958afd7bce223..0879b739c5e8b 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -228,7 +228,7 @@ static int surface_platform_profile_probe(struct 
> ssam_device *sdev)
> 
>  static void surface_platform_profile_remove(struct ssam_device *sdev)
>  {
> -	platform_profile_remove();
> +	platform_profile_remove(&sdev->tpd->handler);
>  }
> 
>  static const struct ssam_device_id ssam_platform_profile_match[] = {
> diff --git a/drivers/platform/x86/acer-wmi.c 
> b/drivers/platform/x86/acer-wmi.c
> index 53fbc9b4d3df7..71761d4220c26 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2546,7 +2546,7 @@ static int acer_platform_probe(struct 
> platform_device *device)
> 
>  error_hwmon:
>  	if (platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&platform_profile_handler);
>  error_platform_profile:
>  	acer_rfkill_exit();
>  error_rfkill:
> @@ -2569,7 +2569,7 @@ static void acer_platform_remove(struct 
> platform_device *device)
>  	acer_rfkill_exit();
> 
>  	if (platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&platform_profile_handler);
>  }
> 
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/drivers/platform/x86/amd/pmf/sps.c 
> b/drivers/platform/x86/amd/pmf/sps.c
> index e2d0cc92c4396..cfa88c0c9e594 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -425,5 +425,5 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
> 
>  void amd_pmf_deinit_sps(struct amd_pmf_dev *dev)
>  {
> -	platform_profile_remove();
> +	platform_profile_remove(&dev->pprof);
>  }
> diff --git a/drivers/platform/x86/asus-wmi.c 
> b/drivers/platform/x86/asus-wmi.c
> index c7c104c65a85a..f5f8cda7fd19c 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -4885,7 +4885,7 @@ static int asus_wmi_add(struct platform_device 
> *pdev)
>  fail_custom_fan_curve:
>  fail_platform_profile_setup:
>  	if (asus->platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&asus->platform_profile_handler);
>  fail_fan_boost_mode:
>  fail_platform:
>  	kfree(asus);
> @@ -4912,7 +4912,7 @@ static void asus_wmi_remove(struct 
> platform_device *device)
>  	asus_wmi_battery_exit(asus);
> 
>  	if (asus->platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&asus->platform_profile_handler);
> 
>  	kfree(asus);
>  }
> diff --git a/drivers/platform/x86/dell/dell-pc.c 
> b/drivers/platform/x86/dell/dell-pc.c
> index 3cf79e55e3129..4196154cc37d9 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -273,7 +273,7 @@ static int thermal_init(void)
>  static void thermal_cleanup(void)
>  {
>  	if (thermal_handler) {
> -		platform_profile_remove();
> +		platform_profile_remove(thermal_handler);
>  		kfree(thermal_handler);
>  	}
>  }
> diff --git a/drivers/platform/x86/hp/hp-wmi.c 
> b/drivers/platform/x86/hp/hp-wmi.c
> index 26cac73caf2b9..bb8771d8b5cd8 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1692,7 +1692,7 @@ static void __exit hp_wmi_bios_remove(struct 
> platform_device *device)
>  	}
> 
>  	if (platform_profile_support)
> -		platform_profile_remove();
> +		platform_profile_remove(&platform_profile_handler);
>  }
> 
>  static int hp_wmi_resume_handler(struct device *device)
> diff --git a/drivers/platform/x86/ideapad-laptop.c 
> b/drivers/platform/x86/ideapad-laptop.c
> index 1f94c14c3b832..50819ac919e87 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1135,7 +1135,7 @@ static void ideapad_dytc_profile_exit(struct 
> ideapad_private *priv)
>  	if (!priv->dytc)
>  		return;
> 
> -	platform_profile_remove();
> +	platform_profile_remove(&priv->dytc->pprof);
>  	mutex_destroy(&priv->dytc->mutex);
>  	kfree(priv->dytc);
> 
> diff --git a/drivers/platform/x86/inspur_platform_profile.c 
> b/drivers/platform/x86/inspur_platform_profile.c
> index 03da2c8cf6789..f6bc5ca9da91d 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -190,7 +190,9 @@ static int inspur_wmi_probe(struct wmi_device 
> *wdev, const void *context)
> 
>  static void inspur_wmi_remove(struct wmi_device *wdev)
>  {
> -	platform_profile_remove();
> +	struct inspur_wmi_priv *priv;
> +	priv = dev_get_drvdata(&wdev->dev);
> +	platform_profile_remove(&priv->handler);
>  }
> 
>  static const struct wmi_device_id inspur_wmi_id_table[] = {
> diff --git a/drivers/platform/x86/thinkpad_acpi.c 
> b/drivers/platform/x86/thinkpad_acpi.c
> index c8c316b8507a5..619a4db74e5f3 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10637,7 +10637,7 @@ static int tpacpi_dytc_profile_init(struct 
> ibm_init_struct *iibm)
> 
>  static void dytc_profile_exit(void)
>  {
> -	platform_profile_remove();
> +	platform_profile_remove(&dytc_profile);
>  }
> 
>  static struct ibm_struct  dytc_profile_driver_data = {
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 6fa988e417428..58279b76d740e 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -36,7 +36,7 @@ struct platform_profile_handler {
>  };
> 
>  int platform_profile_register(struct platform_profile_handler *pprof);
> -int platform_profile_remove(void);
> +int platform_profile_remove(struct platform_profile_handler *pprof);
>  int platform_profile_cycle(void);
>  void platform_profile_notify(void);
> 
> -- 
> 2.43.0

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

