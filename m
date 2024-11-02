Return-Path: <linux-acpi+bounces-9251-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE79B9C29
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 03:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E3C2843DC
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 02:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350255FEED;
	Sat,  2 Nov 2024 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="DHCBpbU3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fIU/EIsU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F05588F;
	Sat,  2 Nov 2024 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513650; cv=none; b=F7qIgQcC1CNGYPKfEQv/N++/yENdfnp4GL6g5xvIsbCA5X8yiWnr1DUZoWVCIp7MFElwY12W2+ugSEhqOR0jycQtxn7AqIuepeJPaJTiyzzJSRsugkhAciQ0dwxJL5XV1ducv8HkkhN3iJolzWPm5RtIS2fokU5Ii5hlQLOpKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513650; c=relaxed/simple;
	bh=FBFcKMIeU1kUg7mFvTOLs1cdAkmIqnY7f+sJLEwrdOU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=L4UVAZoLOLBFD8DTZYfSm5Oe+oBAxsgiq5uCwljSxRraRLbw7r3bTvMX3k5JIQ86eANT21a1uAWED76DdoOBJh63GbvEms4k0qg+ulAfI6Ek/Xmf/eaPi6xdPTWTtZJki/hM6nkscdxqAnMZ1Rjrw/WCbIsVeg8KJ4f36OqiVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=DHCBpbU3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fIU/EIsU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C40E0114007E;
	Fri,  1 Nov 2024 22:14:06 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 01 Nov 2024 22:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730513646;
	 x=1730600046; bh=YQ+eU7FFr74dJaScVAyAyc16wc8vDYsMV3egRAzYsnY=; b=
	DHCBpbU3T2/azr9ri1YMl880bxwgyKpoT60a3ZZcGL0eUgPTahqbo6PSqjclo1iU
	neXDpIFBhPRtqcbpbxAKUTr8S3HGxGlfT9OY2FmpgBGxs4XY6bAP88SHakSM1n/7
	8/EJYBIt3fmHGi5lNy3HN/GOeTB0V/Q4fYF5RsR8vvwYJYmJsRpJkKtHchOxSlzH
	eU9rgo+jfaq/+8tAAFiq0hgkJ5AlOqgr6ONnie4IGqHyj3eslPo3p2IBE55JjFWb
	8L9Kq9LSvA+3ATr73lxlWjEXd1Dg+gPKjIohfLCppwGqeiz0xlYAms3X0lqnLrfn
	qLS368Qa7Q/SqlAg5k9ugw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730513646; x=
	1730600046; bh=YQ+eU7FFr74dJaScVAyAyc16wc8vDYsMV3egRAzYsnY=; b=f
	IU/EIsUiH6AAx/3Lrt6HH0P9HDe1pdp8ROHsFmqojrnvZiPmw+cPPXgJ29NvOTQl
	apJW/H7xDLCYvVBFxK6WGy+fEoQnj1QYrWBDbd6rCwYRIGF8XxNmMez3bzmCj1TY
	+j+511sSkJH+nM2xDZv1D0PoDo7jMH+r9eWIpcUloGVtKDRUsMcsyoVbrkApQTTc
	7hj8qg5Jb0HoRQnDf0PM3Z0vdNknVN9fO8AfF1HLym1v8qqomgxKMgtaKMxpu+uS
	vdsP9TK+Gk6d9HBm92n+LmshRMr0tELFZTPfeiDtOqg6XQpouNgtRUyCfxHkIB6o
	TF3KwxvqFT55M8IXZ9MiA==
X-ME-Sender: <xms:7oolZ4-l8CdADSXDCjt0TcDCRqkBvFsCouEXXDmHX8r5tZXd7ypb6g>
    <xme:7oolZwsU_x_rchAz5LxXj-xydCs6JsPba94yLgWwqLoaSWXAk1uMmWnGVwj8V0HAb
    _UGbhJ6iOzHdHpD_90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddggeefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:7oolZ-DCIccRORhaTo9auB9xaiKIt_v8KvWFyU2g46dgn76c4uI4Rg>
    <xmx:7oolZ4el2ElSAkL_BQPYRnL6gIcUVEUNW1OtchiINtgIy_KMx_GagQ>
    <xmx:7oolZ9OIrfx99ohXlSQI73X_JfZ6LtNglEHPsSOwO2BJuI2S4S_D6Q>
    <xmx:7oolZylwOxxGxOeJNT5pFgffNcBRqC4CLe6Lw8cLHbK9ehr4YAZEQQ>
    <xmx:7oolZxs79KZQuvEJz4MjNMaVgM5B66CdLIzF6lQAMcaZoXfLtHwScaiT>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 714FA3C0066; Fri,  1 Nov 2024 22:14:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 Nov 2024 22:13:46 -0400
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
Message-Id: <26396791-6a7f-4f07-b939-e7b9874ae34c@app.fastmail.com>
In-Reply-To: <20241031040952.109057-7-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-7-mario.limonciello@amd.com>
Subject: Re: [PATCH v3 06/22] ACPI: platform_profile: Move sanity check out of the
 mutex
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Oct 31, 2024, at 12:09 AM, Mario Limonciello wrote:
> The sanity check that the platform handler had choices set doesn't
> need the mutex taken.  Move it to earlier in the registration.
>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c 
> b/drivers/acpi/platform_profile.c
> index d0198d2ccb551..f2f2274e4d83e 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -180,6 +180,12 @@ int platform_profile_register(struct 
> platform_profile_handler *pprof)
>  {
>  	int err;
> 
> +	/* Sanity check the profile handler */
> +	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> +	    !pprof->profile_set || !pprof->profile_get) {
> +		pr_err("platform_profile: handler is invalid\n");
> +		return -EINVAL;
> +	}
>  	if (!pprof->dev) {
>  		pr_err("platform_profile: handler device is not set\n");
>  		return -EINVAL;
> @@ -192,13 +198,6 @@ int platform_profile_register(struct 
> platform_profile_handler *pprof)
>  		return -EEXIST;
>  	}
> 
> -	/* Sanity check the profile handler field are set */
> -	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> -		!pprof->profile_set || !pprof->profile_get) {
> -		mutex_unlock(&profile_lock);
> -		return -EINVAL;
> -	}
> -
>  	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>  	if (err) {
>  		mutex_unlock(&profile_lock);
> -- 
> 2.43.0

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

