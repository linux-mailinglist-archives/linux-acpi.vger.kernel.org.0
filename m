Return-Path: <linux-acpi+bounces-9252-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F579B9C2E
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 03:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE5C1F21D60
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 02:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DE76F06B;
	Sat,  2 Nov 2024 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="HkUUd6Dy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nx/Apu0M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5198614E;
	Sat,  2 Nov 2024 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513674; cv=none; b=m5mVTBj2ZWEoJlhhc5H4kg9bU98dTmpSn/u0TnecusphwavRV/v227li6Zntz+X6VRp/oHj3xPTlbGd4EdEYFiZvbPmILGmiuWVv2/rJ5Ln1DrRGuqRIXk5MnDQccQ8KEkpmb9IdHx/L+PtfTK7dAve0SNjYJ5fcZs7oga32mAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513674; c=relaxed/simple;
	bh=wdLmY0BfOVab7xqkRTaYglDeVbq1hYw2AI7aM17dRNY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hXQx5bCp/UnkziesxU0tKhr+qcu7oCNy6D/bxeNhJZOkiHJyxAt/O8bljqx7PjRWmE/vxwt7xxxbaMzOuUTGJ0Ih+2Rqa7YPXa/mbgbAzx5iuOR6ZKREc6BZFTGutCB/NElxTba5CM1DviLAnhqjwB/xtCACin9cmPUwgdIkexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=HkUUd6Dy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nx/Apu0M; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E22311400C3;
	Fri,  1 Nov 2024 22:14:31 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 01 Nov 2024 22:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730513671;
	 x=1730600071; bh=KTD4lt+iLU7cN0yZuhFfops1FCqb+x9RwToKur8jpZw=; b=
	HkUUd6Dychnkm2xHYUjZhzPQSqucYeVq80IBqxI6bSEFhCRALzVlex5EeD5eHjfl
	U73DKRuGDUxv/NRImApMkJIvOhlBKfE8W1t87Ezc3Pav+jaT/upZ9sjKxnzHzwuE
	AZvVPVhTq7org9b/TrQHTjfhjcPKl4MZ0EyiDKgUhVylki2JZpw62I82gS2aMjCn
	YpSL7iQwXOiO6rQoaUIj3znaoFH5aVHCfCcQF38B/mx6Icb9RDRdR0Oh/D3LDw3H
	NmYBsnnFsA6my8DoztlCgnyfTiF7TObKpAxo7bxQvcvW3gKi+24WXmIyCqevQZfI
	K6KGCTXYmpUBo+F0NEgWNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730513671; x=
	1730600071; bh=KTD4lt+iLU7cN0yZuhFfops1FCqb+x9RwToKur8jpZw=; b=n
	x/Apu0MNOWO9/74SQCfSAI5wXGepUHIy/pEBkwYMN0lN11N6Gur4CGCJMH6MxUa7
	d6+s28jeIgO7jUbGINr6XEmM2VMEcGchI6tLyQdR9odppcQTak8dPfETfVyxSWBa
	00WjK7q3CiCuws0/sPbwdwPNq093OJz2RrNhKZSwaHbvfy0A+s9/wu1Mvmg0JaWb
	UhAEJ1czaoFl2dBp6cMV1bC3PHdQVIybP6tnlT5etoJTDv5agnNzttwZM09nxwTi
	u8bAwOuD8520Fr9/MZhzJ17cmJ7112Fs2Qr/aSzIjHI7tfzs4VU25/+IO6m0NkGA
	rLfDLkbvpsIq3EcbeYkiQ==
X-ME-Sender: <xms:BoslZ1Z__YH8k-GK41nBQTxnNO9aIxyIwuZDjD0KN8-8fZG47Yfrqg>
    <xme:BoslZ8aXlFgW8SOpWoUjNMvokkSY_zxhKjPk1q9mer-HmdDy5n_iGbIIx1-8fqsvy
    XQFOwpcdkH58OXKMA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddggeefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:BoslZ3_biM1FFz9eKo_rxileDmUosTKd1k4jvIEq1uEZA__RbhpH1A>
    <xmx:BoslZzr7cDiln-fgfWxxz0RAihswEdC7dJmS5_u3MkFkJqsq9aSz6g>
    <xmx:BoslZwrYjKuPMMLzt3iERHjciuHojvI8ziU6ZFbaglTXLCLw0AXQ0Q>
    <xmx:BoslZ5SUL-twp5Dsnzh1TTjczxETs6oVToHHh8FPjMft_WlEoIfegw>
    <xmx:B4slZ0qbywQ4V5CWnXlCVvtVBHidKg3Nwv606d_bDykCzB0-WjOcjekx>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B689F3C0066; Fri,  1 Nov 2024 22:14:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 Nov 2024 22:14:10 -0400
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
Message-Id: <51a93c87-7192-4df0-b61d-a4da57ac0903@app.fastmail.com>
In-Reply-To: <20241031040952.109057-12-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-12-mario.limonciello@amd.com>
Subject: Re: [PATCH v3 11/22] ACPI: platform_profile: Use `scoped_cond_guard` for
 platform_profile_cycle()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 31, 2024, at 12:09 AM, Mario Limonciello wrote:
> Migrate away from using an interruptible mutex to scoped_cond_guard.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 39 +++++++++++++--------------------
>  1 file changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 63a5f5ac33898..2d971dba2d917 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -124,36 +124,27 @@ int platform_profile_cycle(void)
>  	enum platform_profile_option next;
>  	int err;
> 
> -	err = mutex_lock_interruptible(&profile_lock);
> -	if (err)
> -		return err;
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		if (!cur_profile)
> +			return -ENODEV;
> 
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> -	}
> +		err = cur_profile->profile_get(cur_profile, &profile);
> +		if (err)
> +			return err;
> 
> -	err = cur_profile->profile_get(cur_profile, &profile);
> -	if (err) {
> -		mutex_unlock(&profile_lock);
> -		return err;
> -	}
> +		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
> +					  profile + 1);
> 
> -	next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
> -				  profile + 1);
> +		if (WARN_ON(next == PLATFORM_PROFILE_LAST))
> +			return -EINVAL;
> 
> -	if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
> -		mutex_unlock(&profile_lock);
> -		return -EINVAL;
> +		err = cur_profile->profile_set(cur_profile, next);
> +		if (err)
> +			return err;
>  	}
> 
> -	err = cur_profile->profile_set(cur_profile, next);
> -	mutex_unlock(&profile_lock);
> -
> -	if (!err)
> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
> -
> -	return err;
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_cycle);
> 
> -- 
> 2.43.0

For patches 8 to 11 - Looks good to me (guards are new to me - I had to go read up on them. Very cool and a nice clean-up)

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

