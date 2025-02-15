Return-Path: <linux-acpi+bounces-11203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9C0A36B68
	for <lists+linux-acpi@lfdr.de>; Sat, 15 Feb 2025 03:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B937A4321
	for <lists+linux-acpi@lfdr.de>; Sat, 15 Feb 2025 02:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1D9770FE;
	Sat, 15 Feb 2025 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="BGWeaSuI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dt3EUNBN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF84D531;
	Sat, 15 Feb 2025 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739585916; cv=none; b=COnE3pQXfARWzvJ01FnbnWOjoc27jchW1ASAoq3z+RT3cGCC2s/WqP48ZImIDLueUAxrroMyo4TgOHM3N5G7sajOSZpyGjXwy88bralYThJxA69jarVLlfAtx+tfDxxiqtvZEVQV1jcvpBacl6cqxmzUoO2+WllDTpSglEEGQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739585916; c=relaxed/simple;
	bh=4C1B8IsBhRqb49TH63Utggw8L3oBxRdkOnxFEleZItE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kXUO3khmgEmVgYc4G1FRUi3NSX7VWRbeygysxOht57N5UwxLL88Qp4Vk6w7edR2w+iToS/mudanR6eEUlC+pTMz4PhmnSPgFhjAKgVMCZyLG3lIcjEIClq51FO2A9witKEZLA3zHdgmFs2G4k40D4qA8P1x5PCmhpUr02prbfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=BGWeaSuI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dt3EUNBN; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3E68E254010D;
	Fri, 14 Feb 2025 21:18:32 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-04.internal (MEProxy); Fri, 14 Feb 2025 21:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1739585912;
	 x=1739672312; bh=omhDKWPHUaEQkAzY0LeNukJciihkvBdoVj6M3o5CeGg=; b=
	BGWeaSuIni8UcpgWiNlO4gEwIskI2QhiLWPJj3bUhgIU0rjdU1ASIDPAB7DTZq3D
	zhIUD1ygvwc81j3fYXqnKVtgLHsTEZiwpuiiQdQCxEKMcOOKR6WhIoDWGSAtFE3Y
	1ASOVMmBn+DY0ourg1Hzhi4qOe3EQMOjECYurIomMPIz4UxrdbtQ9D8T6UY9No6b
	zjpHzweo9Bas3BvOpM0TjyK+dkcqKmBDtuQOB61ZSvOV7isqzfC1kMCZVH0hfSpq
	e5dBPVnYSQGJCLT5GL1TwdhVfGpKCzzotX4Pk9fePtSo4vnxdTCMqzirLZpFq0Da
	Jbh+xq56fsR3+U0pUtUkmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739585912; x=
	1739672312; bh=omhDKWPHUaEQkAzY0LeNukJciihkvBdoVj6M3o5CeGg=; b=D
	t3EUNBN0n1ifg5zBsjiFS2516t/KN8QkOYogmVExQw94WxqUzHrbj5BxyTK4pBxi
	aM1N5LZFMtRjgM04JUzZXaOstzHYCE+2j44CQt6WRMH3EZ+isx3mhB8AECWOHspZ
	jA8tiYbi012S7ntTkSUh2cZij52m1DAnw3ziNNQPKR/5IFEGrElKujrcJt42eiAI
	7aFlSJ+/3oe4KL5DmtReg/rtSlhLug9qQclgOH1j6SXlxfg5E384Yo4JaqP8Bdwf
	fvPw9hDNVXGX6YdAHdsmGzSIqf4bDaQzLU1vugzc9o+6rRXLA7trKnIXvKgb3MZ4
	o5kf1LCazWpQZk5kXSOhA==
X-ME-Sender: <xms:d_mvZ5dLG-6NSjKr4bJBF44z3znNpjir56kWw2DeLSLLi_WVH2ZTBQ>
    <xme:d_mvZ3P1stDRggKgGtxsYO7Z5hQfIYRACgeCj1JuoeSSzQD7sxVBbLWBe31ae88y_
    tIyy2iZuRSK7_vB3tc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfeuvdehteeghedt
    hedtveehuddvjeejgffgieejvdegkefhfeelheekhedvffehnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdp
    rhgtphhtthhopehkuhhurhhtsgesghhmrghilhdrtghomhdprhgtphhtthhopeifpggrrh
    hmihhnsehgmhigrdguvgdprhgtphhtthhopehsohihvghrsehirhhlrdhhuhdprhgtphht
    thhopehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhig
    rdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:d_mvZygsHJwrDeNN_6CQ5oh5OtJYbJ3VzpbhYl4FkUj4PZNJqiC8BA>
    <xmx:d_mvZy8pbnF3Rq-dxETbzvAL4RVf-lkTB3E3tl9-96YWxm19thJwSw>
    <xmx:d_mvZ1uHfzr61kH7JfViQF6uQnrRRmLzaf_UI3O093RJHf489AKfpw>
    <xmx:d_mvZxEAs64XzTTEqIyWrTm2C8O0iGtYwDtV8z2K2NNvarNIBOwSHQ>
    <xmx:ePmvZ7BuThXFhSIEubQ4WgoXKgVj69Ud62Rg5Ik1xUlvC6ajW2rLcn2j>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E8FE33C0066; Fri, 14 Feb 2025 21:18:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 21:18:10 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Kurt Borja" <kuurtb@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Len Brown" <lenb@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Armin Wolf" <W_Armin@gmx.de>, "Gergo Koteles" <soyer@irl.hu>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <9a8a5084-589d-4c45-a011-5bf4d0dfc8ba@app.fastmail.com>
In-Reply-To: <20250212193058.32110-1-kuurtb@gmail.com>
References: <20250212193058.32110-1-kuurtb@gmail.com>
Subject: Re: [PATCH] ACPI: platform_profile: Fix memory leak in
 profile_class_is_visible()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Wed, Feb 12, 2025, at 2:30 PM, Kurt Borja wrote:
> If class_find_device() finds a device it's reference count is
> incremented. Call put_device() to drop this reference before returning.
>
> Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI 
> platform profile")
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/acpi/platform_profile.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/platform_profile.c 
> b/drivers/acpi/platform_profile.c
> index fc92e43d0fe9..2ad53cc6aae5 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -417,8 +417,14 @@ static int profile_class_registered(struct device 
> *dev, const void *data)
> 
>  static umode_t profile_class_is_visible(struct kobject *kobj, struct 
> attribute *attr, int idx)
>  {
> -	if (!class_find_device(&platform_profile_class, NULL, NULL, 
> profile_class_registered))
> +	struct device *dev;
> +
> +	dev = class_find_device(&platform_profile_class, NULL, NULL, 
> profile_class_registered);
> +	if (!dev)
>  		return 0;
> +
> +	put_device(dev);
> +
>  	return attr->mode;
>  }
> 
>
> base-commit: 3e3e377dd1f300bbdd230533686ce9c9f4f8a90d
> -- 
> 2.48.1
Good find. Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

