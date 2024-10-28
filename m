Return-Path: <linux-acpi+bounces-9039-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F79B2C62
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 11:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D031C21A1F
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71941D1F7E;
	Mon, 28 Oct 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="G1uZnGi8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ItjedI2I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD921CCB34;
	Mon, 28 Oct 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110254; cv=none; b=egklRHEg1vz68pEP7VkC3TSP9p8sOi+iflXHm9QRXfx2i9qFOPNBBwtOm2cHasYFSoPVNhWWQmbYyKMng/4GOAraFKl+0rATIzr/JU66GwZZ5zfg2kGEjk7aHL2x/1kXwvlZO5IMT1tSN+DID1AoN5f9UrqeGnpErKtitojY7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110254; c=relaxed/simple;
	bh=suhY7JzHcnxAB4X0N8051t7f613gB6CeMqDIXcWYUw4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rxFsbCO3QEG4zvwUAb5MzGNlPS7i+cje5JbVdkfOUi0999R4eHzy3DYuwCMLq4pHiWFbTGKmFXPMnOJpIXwnAb5bJ0bFdXCEN1AVAzcm/iAkAn/huFZ0Vu8NpUQPsoMORiuXny5BZYl1j5936ZVKK4FKfNa6c3xLwuUY+ihx8do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=G1uZnGi8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ItjedI2I; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DC4625400C4;
	Mon, 28 Oct 2024 06:10:51 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Mon, 28 Oct 2024 06:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730110251;
	 x=1730196651; bh=mkCCNsasirTb2gwbpaxzIv4zvvheu4d4dmMbXzeZbwM=; b=
	G1uZnGi8tOj2Tc0gOX4lv35M0u9wABHEpAeWLLB54RrVLtA3zPREUXHnQi2Vi5lb
	esiIL2QcHagSih6gyl+R4vt4j2CP4Kk1leJkbILlSRXN8vNBrZDM1RgSzt9hGQq9
	wJIPIgooOzZHUmkvngwQaNn7DZ7za3xyM8AB7B9+Nl5+vhmIOFlVV33cqutIdCiS
	vZmy+SBxwp4OywZJ+RidSZN0AK2qcCzGHRVQTtIX5vWscaux0dIg6ctUZl+ik1h3
	dz/5TycMKy57lDBX4Wj6xqWKGVNd9TGghSzlRgbkfKwNskIWZUzZYn2mJuHOpC8c
	MHbiwDs9l0GafbklAPCC8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730110251; x=
	1730196651; bh=mkCCNsasirTb2gwbpaxzIv4zvvheu4d4dmMbXzeZbwM=; b=I
	tjedI2IVm6uDHa4PAaYKBF9DRtLQ7iaiTVs3dwVUQ5FHCDzH0Pr8df3s1VPrNEoz
	C0d4HzXKjywmNZUsY7K2YGuDG9TMAI2Xp2V+h7aTFknHp7+yox7HtVOEuiLyASkG
	noZtn+tLJUuVL5F0CMSddca4MhO2Zeg9+GS5QoBInnBA4yQWaQsaIru8QZxXUA2x
	fRp5KOb2h12QO7Z52KbVoR4+MQ1tzj3uWaXDIIVWUBOTR9Ny6fxjhjR3RL6q7NLX
	4KyEgAPmKe9G954ax5wC1Ku+nZImUy2JjqWhEl9fKPix0mVy7Niei/erd/hfPiLb
	AoL0F5prxmzFuRaXZIzGw==
X-ME-Sender: <xms:KWMfZ03j36ZsvZvaer7yTFyxjrRM8DanlN_ufRdfh6sBbbjfmpXkUg>
    <xme:KWMfZ_ERfcwtp6TjCuF_GbLFG-_CaaxjRCbbGW9K4j-gpWLQChqEDklcEdb8zAp_A
    cngJwGKfCNgE4TYZo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejkedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehikhgvrdhprghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoheprghl
    vgigsggvlhhmgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgvnhhtihhnrd
    gthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrgigihhmihhlihgr
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehhmhhhsehhmhhhrdgvnhhgrdgsrhdprh
    gtphhtthhopehsohihvghrsehirhhlrdhhuhdprhgtphhtthhopehlvghnsgeskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:KmMfZ86B6-5f_bTg5e3eBwUqePHFK-WSmAAxMDsyxWr4AolDjNDUUg>
    <xmx:KmMfZ93EsONvpl3_DPK5P7z0zTa7pEySjDZs-Ajxy_sjF5-E9uYLKw>
    <xmx:KmMfZ3EkIiFghrQ2L9dBoBr4S7JH4o7kfUF-eXfWwSFb4yCNYYixeQ>
    <xmx:KmMfZ2-mWd8WJclAuWmS7l8kLwhGjlS0QJjWQD3P88BwmmPdE-EPRw>
    <xmx:K2MfZ_MouRpC_2g2Bhx4TEaudkcEZSs0TRQqZF6ciaxdrq0I8dbikEGd>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E16813C0066; Mon, 28 Oct 2024 06:10:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 06:10:29 -0400
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
Message-Id: <bac1b29b-91db-409a-b07a-55a183b6d686@app.fastmail.com>
In-Reply-To: <20241025193055.2235-6-mario.limonciello@amd.com>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-6-mario.limonciello@amd.com>
Subject: Re: [PATCH 5/8] ACPI: platform_profile: Use guard(mutex) for
 register/unregister
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Oct 25, 2024, at 3:30 PM, Mario Limonciello wrote:
> guard(mutex) can be used to automatically release mutexes when going
> out of scope.
>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c 
> b/drivers/acpi/platform_profile.c
> index 0c60fc970b6e8..81928adccfade 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -180,41 +180,34 @@ int platform_profile_register(struct 
> platform_profile_handler *pprof)
>  {
>  	int err;
> 
> -	mutex_lock(&profile_lock);
> +	guard(mutex)(&profile_lock);
>  	/* We can only have one active profile */
> -	if (cur_profile) {
> -		mutex_unlock(&profile_lock);
> +	if (cur_profile)
>  		return -EEXIST;
> -	}
> 
>  	/* Sanity check the profile handler field are set */
>  	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> -		!pprof->profile_set || !pprof->profile_get) {
> -		mutex_unlock(&profile_lock);
> +		!pprof->profile_set || !pprof->profile_get)
>  		return -EINVAL;
> -	}
> 
>  	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
> -	if (err) {
> -		mutex_unlock(&profile_lock);
> +	if (err)
>  		return err;
> -	}
>  	list_add_tail(&pprof->list, &platform_profile_handler_list);
> 
>  	cur_profile = pprof;
> -	mutex_unlock(&profile_lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_register);
> 
>  int platform_profile_remove(struct platform_profile_handler *pprof)
>  {
> +	guard(mutex)(&profile_lock);
> +
>  	list_del(&pprof->list);
> 
>  	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> -	mutex_lock(&profile_lock);
>  	cur_profile = NULL;
> -	mutex_unlock(&profile_lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
> -- 
> 2.43.0

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

