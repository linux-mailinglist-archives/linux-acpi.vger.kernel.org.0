Return-Path: <linux-acpi+bounces-9256-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FD49B9C3E
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 03:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C639B281DD9
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 02:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2681B6F06B;
	Sat,  2 Nov 2024 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Cn/o5Pe4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C1jdaovB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0504D8DA;
	Sat,  2 Nov 2024 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513760; cv=none; b=NQa1lF8eyzz5yxdj++kXcEjOR6bjsIAGpNqvlBIyNjl388N6Pfhfs/FO09pkYGMNuFXCHWm24UmeTtIhxQmyk5QSbJWX6fwGK+oF2Yzx/Q3hjPBemADqVZMvyn25F3Sr1f26f/K6bWbw+78ywgG+jm2F2+0vOR/PK2aiN/b12xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513760; c=relaxed/simple;
	bh=IxbkwyfLq8w3h6bzZfWO0reN9h5HIMoLDYaRhgqknxs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bkhP4ceNMFjYIPay2zcUJQZtPZmLnB0ao+Z4WVaL1Za4Uw8b7DOxoN5B916PAiyWHyIyP58DHcDjJZUOhExc8rMfwovZoqVcezxCVy952Qr7bKy+FX4HqrTSno9WBPkSU0U43VSmNqVnhJZR4wlyci7p/0RO+sfcKPBab6HL0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Cn/o5Pe4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C1jdaovB; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 366FF25400F3;
	Fri,  1 Nov 2024 22:15:57 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 01 Nov 2024 22:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730513757;
	 x=1730600157; bh=y1ZSW/P7hMCHuve2Z4n5mPL2BrcmOglDs3B4Iz+Rs+k=; b=
	Cn/o5Pe4s7wq+mIJHAg20CFYTwguidZPxAPS3mJFYob+Z4HZDMORKKaCDGUrgt/4
	FyT3aUoenNMBKwR6tlya61PpFjt7HJurW4itHqV5/YxxeRvNbCng2erkq6nIJ39l
	b1EieO+9yixU681HwxYAY2F+2q6TC+jLIB3773nMEgzzKw3X7OXHTDfHBeznq3yM
	W89Doaa4ARnVDELv09mgk2/927uxY+wf6EnXbA0R8vODGEfQvA6nyevyjOU6bRqM
	TI6FpcHsAUunmymVkKoVP/t76ZE5Ryh75NFigsgnn87VmKjWdEhZYwWzLHcxJRc0
	CcKVaPhlXaOnwR30tbhWEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730513757; x=
	1730600157; bh=y1ZSW/P7hMCHuve2Z4n5mPL2BrcmOglDs3B4Iz+Rs+k=; b=C
	1jdaovB7FZ+VoONSKOwzWgxgmLfEcBTvb0s79Bqr7IdjjS4DMJq/P7SUdDmlbtmG
	LiIT5mmND5oXCYyUPRDY4daGB3oXvIhfNLIDhMCHa578zCa+M8dMtRlMbbh5Sbtu
	NESFjt/OPpcdhBy5C3W3mxQLOvMZb2HFo8AHt2U4g8mjulu2X10/nuYFPVFKMt4D
	7HBBrQWw8W+SCksbtjsJCKRKHyNsPgjXwSlGHp5rdz4TVb5htEJ8fFfZYrzP6CS2
	1D0UyhrrAEpppSH1BxkMR5LBjAfZyFtRgYLDVX70OBZkA42MjCs7aiOXyK+MjnI6
	Iu5me8dOpPG9GMgQx7S7w==
X-ME-Sender: <xms:XIslZ8W8SKcsWnJV4t9p-HWvCF1r21IjQZHJHBGy6P95gBVcE2T54A>
    <xme:XIslZwl6I7cFfWI7zQe1LdCFIpRantZtA1Munz-9CH1sgYyZkACQSIOMnQ_IG20Zq
    GrtRgiIbYUapOEADCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehikhgvrdhprghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoheprghl
    vgigsggvlhhmgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgvnhhtihhnrd
    gthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrgigihhmihhlihgr
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehhmhhhsehhmhhhrdgvnhhgrdgsrhdprh
    gtphhtthhopehsohihvghrsehirhhlrdhhuhdprhgtphhtthhopehlvghnsgeskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:XIslZwZkax8UIQMb2-cyWSeK7jeuw2shZIOeEovT0-YPSpDxFOlJLA>
    <xmx:XIslZ7VmAoviQg8kACiIqvUY-8SQOL7CHvVQ5wtzzv5kjWy8Z8uqIg>
    <xmx:XIslZ2kdbDnqN3bdm0vWuyxDnBBjXw5c1eu9pxViILtUrB_hb78adQ>
    <xmx:XIslZwd4J0FjN29pUXVs_7vbqjS76vMoieKmH5cYFpaeKh3Ex6zDmA>
    <xmx:XYslZ-GQIbMmWby_TICml60CGaQr4gaogzECGM3sAaiX48IoZkTl_5bX>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D734F3C0066; Fri,  1 Nov 2024 22:15:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 Nov 2024 22:15:35 -0400
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
Message-Id: <5b3a857b-16dc-4db4-aa7f-a104c09dc90e@app.fastmail.com>
In-Reply-To: <20241031040952.109057-19-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-19-mario.limonciello@amd.com>
Subject: Re: [PATCH v3 18/22] ACPI: platform_profile: Make sure all profile handlers
 agree on profile
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 31, 2024, at 12:09 AM, Mario Limonciello wrote:
> If for any reason multiple profile handlers don't agree on the profile
> report the custom profile to userspace.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 39 +++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 3128bd16615b6..5baac1f9a9c0e 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -51,6 +51,36 @@ static unsigned long platform_profile_get_choices(void)
>  	return aggregate;
>  }
> 
> +static int platform_profile_get_active(enum platform_profile_option *profile)
> +{
> +	struct platform_profile_handler *handler;
> +	enum platform_profile_option active = PLATFORM_PROFILE_LAST;
> +	enum platform_profile_option val;
> +	int err;
> +
> +	lockdep_assert_held(&profile_lock);
> +	list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +		err = handler->profile_get(handler, &val);
> +		if (err) {
> +			pr_err("Failed to get profile for handler %s\n", handler->name);
> +			return err;
> +		}
> +
> +		if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
> +			return -EINVAL;
> +
> +		if (active != val && active != PLATFORM_PROFILE_LAST) {
> +			*profile = PLATFORM_PROFILE_CUSTOM;
> +			return 0;
> +		}
> +		active = val;
> +	}
> +
> +	*profile = active;
> +
> +	return 0;
> +}
> +
>  static ssize_t platform_profile_choices_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -81,18 +111,13 @@ static ssize_t platform_profile_show(struct device *dev,
>  	int err;
> 
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> +		if (!platform_profile_is_registered())
>  			return -ENODEV;
> -
> -		err = cur_profile->profile_get(cur_profile, &profile);
> +		err = platform_profile_get_active(&profile);
>  		if (err)
>  			return err;
>  	}
> 
> -	/* Check that profile is valid index */
> -	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
> -		return -EIO;
> -
>  	return sysfs_emit(buf, "%s\n", profile_names[profile]);
>  }
> 
> -- 
> 2.43.0

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

