Return-Path: <linux-acpi+bounces-9038-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A3B9B2C5A
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 11:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD21280DC6
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 10:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0414E1CCEE6;
	Mon, 28 Oct 2024 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="pDWyvHNG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mPK1eL2H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A818E18B46E;
	Mon, 28 Oct 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110208; cv=none; b=IP8/tOcJPsrwA06m6gd6L61YCSCPGNEuwkGeoWiC/+uvRkYnIHq/mdOKshEEqk4s9z9lvPhGG+dQRHmgjl9W62TUTEjf2KD0Fg8Am83B0pIVtyAHdGnoyMFPPAi6LN6ACX4YkNHjEKwnukhoW3SV1paukr9JFnWsLGFgFCwAfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110208; c=relaxed/simple;
	bh=amDfWIRE72lHEmiIidnVRXerlCGijx8fu5oD/PpVZ9Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OnHUIDTvGqUR2VtStRqA4eNbwoAPw6LbZa1maMX+4jtZQAyhZGnh1OFzEQVULMsC1r8hbvjk3UVTr+W9xn4qNH0MSz9TvqdXa5DQbWngNcoDyRPnt9v41BJZcsUDatpHNH/3j3ECSJzulMb8SAoj+Gi9wDBhaTpjlHJSrOyOcxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=pDWyvHNG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mPK1eL2H; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 51456254008F;
	Mon, 28 Oct 2024 06:10:05 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Mon, 28 Oct 2024 06:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730110205;
	 x=1730196605; bh=cjA7AzVK8Qp+c8VweVoj7E322QSX3xuFomZv0bAl22E=; b=
	pDWyvHNGQk66gR/qW9Q6dF8KUz0207WVteO8wW4AiXzBT9qxoKKRs1nEVLfVRQ5n
	AWD9cF8tj6uvKamYxSdE76Q2x/ilN6iCitv/J/xI9iF3/b4Skl2dmys1CnYj3wic
	nsKmCNdo9N256Q47Zf/4dORxklJn3wzQ/ncKG+Rs70IvsPfrmvAO3g0y8/c0mPAS
	aOyFk5YY5xhOQW5YxDg4t2J4WjSUyHObf5uKDtYS+71U4RD3kKaEqFBinZU6UBHz
	xBjv7tpbRhCbReFZkG8XmyZRLmt0yrhhp9ODIa6z2MAb4j3pK/MHdULm49RvvFra
	LPwMTrotirMMWYKeIPPtLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730110205; x=
	1730196605; bh=cjA7AzVK8Qp+c8VweVoj7E322QSX3xuFomZv0bAl22E=; b=m
	PK1eL2HVsBrYVqhM1bfJD6WAFZt+3mvi13AqB+WD+i0+dTSAjQ8PkticH4SAisyp
	rWnKxXKEKu3VQBe/BWWDdXtXfR/HixvsaSbzaWvum3a7eooWlLg6L/TdKmdLfPZC
	ofsVFooG1QuiNpt5+yoC55t0tr1ttRazrATQAXES7zUb+7na/HjL2WBF+mOdEmJe
	bjwPUwIoxYysi2htLHQ4Mvtk0BA8+A3p0c8c2r0XyKBL9s7JMZ9MuGFtHqqs3c4c
	J5AwD+dF42lHkNVCfmcd5SErg8pS4sTeVIrT7qB4nSIesbP+djkn35SIkOpCJZKM
	uFHv44k3yPuAVtE4eK/yQ==
X-ME-Sender: <xms:_GIfZ_uEqdJmw8YaPBTvXLNEwvIX1R1h9RyPWS1lbEtrSkPvMb6uhA>
    <xme:_GIfZwc9AYmAgq5-AmrxUjTU6HsHdFpeDvbc4Xq-HPipulyE7-4WX8qcwj1hnUAgE
    8j851UBYA-sqj2AsWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejkedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehikhgvrdhprghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoheprghl
    vgigsggvlhhmgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgvnhhtihhnrd
    gthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrgigihhmihhlihgr
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehhmhhhsehhmhhhrdgvnhhgrdgsrhdprh
    gtphhtthhopehsohihvghrsehirhhlrdhhuhdprhgtphhtthhopehlvghnsgeskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:_GIfZyyeL76sW1P27qSUBBiLlhhV89lKFh4EpzriNY0CFhwUsN2Ofg>
    <xmx:_GIfZ-NM1f-ZxUx3o4OmsFXd_CGtkR0dU7_4GD3FiuAh5MXfMnOlzw>
    <xmx:_GIfZ_9ybYhLXL32RPS-2DVzonsqn7tqNBvfkGzRDMbVDig_IB66ww>
    <xmx:_GIfZ-Ws5RE--gTwCfoj-WUWbH7DUfQlb8-MwrtRMMywrKb6lhTGuQ>
    <xmx:_WIfZ6dvemVNbKvmsw4d4pWKSx4u5Mo53mDZceO0Sr1VPQ9IQnQ4HGDm>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A0AC93C0066; Mon, 28 Oct 2024 06:10:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 06:09:44 -0400
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
Message-Id: <556814fe-15ae-41cd-8b79-183a479cd76f@app.fastmail.com>
In-Reply-To: <20241025193055.2235-5-mario.limonciello@amd.com>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-5-mario.limonciello@amd.com>
Subject: Re: [PATCH 4/8] ACPI: platform_profile: Add a list to platform profile handler
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Fri, Oct 25, 2024, at 3:30 PM, Mario Limonciello wrote:
> In order to prepare for having support for multiple platform handlers
> a list will be needed to iterate over them for various platform
> profile handler calls.
>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c  | 5 ++++-
>  include/linux/platform_profile.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index c24744da20916..0c60fc970b6e8 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -10,6 +10,7 @@
>  #include <linux/sysfs.h>
> 
>  static struct platform_profile_handler *cur_profile;
> +static LIST_HEAD(platform_profile_handler_list);
>  static DEFINE_MUTEX(profile_lock);
> 
>  static const char * const profile_names[] = {
> @@ -198,6 +199,7 @@ int platform_profile_register(struct 
> platform_profile_handler *pprof)
>  		mutex_unlock(&profile_lock);
>  		return err;
>  	}
> +	list_add_tail(&pprof->list, &platform_profile_handler_list);
> 
>  	cur_profile = pprof;
>  	mutex_unlock(&profile_lock);
> @@ -207,8 +209,9 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
> 
>  int platform_profile_remove(struct platform_profile_handler *pprof)
>  {
> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +	list_del(&pprof->list);
> 
> +	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>  	mutex_lock(&profile_lock);
>  	cur_profile = NULL;
>  	mutex_unlock(&profile_lock);
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 58279b76d740e..9ded63a9ae6f1 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -29,6 +29,7 @@ enum platform_profile_option {
>  struct platform_profile_handler {
>  	const char *name;
>  	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +	struct list_head list;
>  	int (*profile_get)(struct platform_profile_handler *pprof,
>  				enum platform_profile_option *profile);
>  	int (*profile_set)(struct platform_profile_handler *pprof,
> -- 
> 2.43.0

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

