Return-Path: <linux-acpi+bounces-9253-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A919B9C31
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 03:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F69B2190E
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 02:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D20F74C14;
	Sat,  2 Nov 2024 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="hnqA5leK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0vdTR9s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7F6F06B;
	Sat,  2 Nov 2024 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513695; cv=none; b=GaHCsJYERfcZ3zoKNIDRVwqE9EsjKpiyQpVe7DhC7CnVXNIlW0iDx5ieMsUpie/6/q1mWAfSUe2X1fTpa5amTKy9kWgiRsGinan3qrk5Rc3HQk5jIduzrkN1FB/PE8o8UPnuffKlFiTfvpFuS5FAEjxQDKIUIsPlo39DS1X/0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513695; c=relaxed/simple;
	bh=7hIetJ7ZLmuC8PhP+rP6R3U697SB2sqjDj/ChX+YRXo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vAgs29+pSW+foL/55ktMFAKhqgV+bebdsP6GpHi+e6dLF+s7K+U58inTm5R4ssi2BEhiBbRQgjeZoGMqHNe7Tzebri9YOXRfRSAXa6H50UgF4WD9vDmcjsQfnl9E50JreHodOm/VUW2/KcfuMqvpIAAEq0miSyxwe8NEsysY9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=hnqA5leK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0vdTR9s; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B0D325400FC;
	Fri,  1 Nov 2024 22:14:52 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 01 Nov 2024 22:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730513692;
	 x=1730600092; bh=CkrPl1J6C0IRjJJqxSDvwcu6yt6xdBEFuHH1XZwtxT4=; b=
	hnqA5leKwpfDw02iQCa76dsOowb09WlDqiQFWenoB/VjM0L/7gKBFk7EugXuXJcC
	FLuD9hKPuOxPSojdkiiuS2dkfBsdd5fb+uzLAz47y9bNHZsCia//MC+h/atm0bMD
	zuvZZIuL+IJfjocmCl6NtWBJnbB8aXHSVj0qgLRVu7Ou9REZhKdEnIq2EBStgqw5
	tVjoZJAzzWHf1zalkhB5KYBVjZOD7HVc+esvCfoVoPnrZ70Vnn0AmMYxt0afPTwH
	EpNTpY2TsXUik2eU9nShcUQ3lg2GXIODam2uLUhJPs4oAJbxu+GxzyHzMAJu+MNP
	jQoDWOLeZTJnXsWHbgXpUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730513692; x=
	1730600092; bh=CkrPl1J6C0IRjJJqxSDvwcu6yt6xdBEFuHH1XZwtxT4=; b=E
	0vdTR9sQnVY1R8BWJXyoutjE/6jAeOnABNkeJYtuC6f4VufKx/m5l3+Izsphqixx
	TnCEvWDMo4cHZ2ioWhC3YzJPbepVWTYSkSMXar6IfiNwQAz0EpIoaiqSNWHEY0V8
	OuV2BsYvQj3TjkzU9edUX0mJMeOCCE4AWc//RfB0g7A7SBqDlsTTjnc9+PgQbuWZ
	sJFgWZ150Kcw3nsMt69XWlMhTH2AnESGnZv81fox8vCPNZdbeNxq9cPc8acgHgmo
	OTiHbHQ6rvpxU8Ge4kISU8tNxbatMiaa/bUG4w6XwsjNVtKJTBcXii3azPxUnG4e
	Sp+X9qKABrfpDqR4J67YA==
X-ME-Sender: <xms:HIslZ3iu5PxY0x5RPSEf348rdlX1c7ZhVo_bSMGIO7HhfxFFrz4hgQ>
    <xme:HIslZ0A1tFDfcVzfA2yjWcc641HxknWT_wWh2wOD7I-GrXAITRfR-YtPf2jw7dolT
    biJBktwCqCFSw5Tz9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehikhgvrdhprghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoheprghl
    vgigsggvlhhmgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgvnhhtihhnrd
    gthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrgigihhmihhlihgr
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehhmhhhsehhmhhhrdgvnhhgrdgsrhdprh
    gtphhtthhopehsohihvghrsehirhhlrdhhuhdprhgtphhtthhopehlvghnsgeskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:HIslZ3GE8tLHQ7mLkFhtWvhejna9mMMiDDRPFu8yNtxNwvZ6nw44DQ>
    <xmx:HIslZ0RWTw-0cE-YtGdYGMnYu3SrD_vMM6jPCJAqwPUUwA_5v4StLA>
    <xmx:HIslZ0yXPIdQZdkmdKK-OkHZPtzbPXNB4lCGZ2HgQU0tR9KrK9koFg>
    <xmx:HIslZ65PsecglyYQxysPTPtBoW0UaQNZIsB4gaNgfrJDS2gATrMKug>
    <xmx:HIslZxzKy-BimVu7KPudm_WCn59kRDMTvSxXdIyOcS-y3xxlfAVsfox6>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 051323C0066; Fri,  1 Nov 2024 22:14:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 Nov 2024 22:14:31 -0400
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
Message-Id: <2ed34c9d-bd75-4668-b1c8-ac663ad17b25@app.fastmail.com>
In-Reply-To: <20241031040952.109057-15-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-15-mario.limonciello@amd.com>
Subject: Re: [PATCH v3 14/22] ACPI: platform_profile: Notify change events on register
 and unregister
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 31, 2024, at 12:09 AM, Mario Limonciello wrote:
> As multiple platform profile handlers may come and go, send a notification
> to userspace each time that a platform profile handler is registered or
> unregistered.
>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c 
> b/drivers/acpi/platform_profile.c
> index 57c66d7dbf827..7bd32f1e8d834 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -182,6 +182,7 @@ int platform_profile_register(struct 
> platform_profile_handler *pprof)
>  	if (err)
>  		return err;
>  	list_add_tail(&pprof->list, &platform_profile_handler_list);
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> 
>  	cur_profile = pprof;
>  	return 0;
> @@ -195,6 +196,8 @@ int platform_profile_remove(struct 
> platform_profile_handler *pprof)
>  	list_del(&pprof->list);
> 
>  	cur_profile = NULL;
> +
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>  	if (!platform_profile_is_registered())
>  		sysfs_remove_group(acpi_kobj, &platform_profile_group);
> 
> -- 
> 2.43.0

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

