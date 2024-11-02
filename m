Return-Path: <linux-acpi+bounces-9254-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 326169B9C36
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 03:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61D61F20593
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 02:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81A04D8DA;
	Sat,  2 Nov 2024 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="F0MNO6YJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jaLeRXxv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881D4C66;
	Sat,  2 Nov 2024 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513726; cv=none; b=GXNUKqxMoCKS+TOF+yBJFZkMvJ7wczxAVrdnXBBlUmQ5XY/rQPbaEWNpr39dqwDR2sQxzycQTdYIdgdcDnaMlv10ENtjL+GXmmby2c2i8TztdrZqTZdp7Mw1wLfTXKMqx7ZB54zdCdm32IukLCiO5uP3iBqXvGOycsNoCUGG19k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513726; c=relaxed/simple;
	bh=7FuObMeMXtj1F+pnKjCDhJqMWiePS2S35NscdZLglB8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bVs+34x2kMCgRD+awSJLAU9sVhMu/cZ+As22DvQLgYZQmQSy5zLCLo2Ru5xZucxmpWEWwLdoWisZqbHtirzmA2I6YyjDbvrFwCVVEHHDewlfEbzMYWutJ/SBZiYy/jB7RomvOeYbCvv8bQPLQRe0zRvWJNl1UuJa/aNbsngb6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=F0MNO6YJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jaLeRXxv; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9BFB825400F3;
	Fri,  1 Nov 2024 22:15:23 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 01 Nov 2024 22:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730513723;
	 x=1730600123; bh=hhPyU/JFVlrGqI50WnmxKT9SwEq0unJ10nYucX7vUhQ=; b=
	F0MNO6YJvsXh1gus8qudnkHnekNanEfYYIa0HP/U32gYtiynXrk3VYTjuA2NOR1V
	QGZG27pFdoO2E6GCg8pdTTtdrzx2PmO1GyT3hyTo/jhYxyWOFt++/WepDr9dn+Fc
	TNzTHsTJz4FXf4ZsFYxiKSggz6+UvzdoDyhtfFQTsZCoym3E5JY3uzLCdMMbC3Hf
	bHVBxywVSnJK8/Hyf/Arf44iEdj75QDpp7Gcc0Xs8TEIOwE1uCb6R4HzZ3KSHt7l
	g8R6EtrtxXfbaXAgAwRiwY59dz29+KzXiP1vLe+I0idbmp9seIxPGFebRozNvlzY
	ZuhR2zPc9RhEz4L6ZQ3/1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730513723; x=
	1730600123; bh=hhPyU/JFVlrGqI50WnmxKT9SwEq0unJ10nYucX7vUhQ=; b=j
	aLeRXxv1X/r6SjEz2Q51eEvSj9G0bEkOkMkh2SlxEHtU7XEwhAD0VXUNTV2JfeuP
	z+acCHfMvSbtmCe4z8cRuWGHT+K3pkNrSEAim2cbYTTslt3gUUGQgFsrw+5L/+Au
	KQ2lb+sWQtZTT2dWRtnkLb2rxve8gJu+wgR0ipS5bOSSYIJ8+ozsOx2Pho312b6e
	agAjbf6K28wvvNNa3DeMY221BQNdRvgpnVDBvRyostfxg4YofTxh8RQKwRvbof5i
	U6gH2yyeiKSeQfWHKwB7Bkc5TFi2+ex7DEHfu/Jp1J4rQHecwXhOgCJZRXW9JJkM
	+dToT9CapNOEUqpdL85GA==
X-ME-Sender: <xms:O4slZ4Bt5O5koNvfVF-8joMpc6AQX9HJZOApuCinczfK_FBECJfZ4w>
    <xme:O4slZ6i7mSuwgjhsGGhzdLvLdlt7T-z1HTRkfAoa0Ovmr66GRcqximn-pq7BI2k56
    HjSHJRzYwsgdKmUgso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehikhgvrdhprghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoheprghl
    vgigsggvlhhmgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgvnhhtihhnrd
    gthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrgigihhmihhlihgr
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehhmhhhsehhmhhhrdgvnhhgrdgsrhdprh
    gtphhtthhopehsohihvghrsehirhhlrdhhuhdprhgtphhtthhopehlvghnsgeskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:O4slZ7kuTlWyFycbiotMdT08c-oqxFSWPwr1eU4q8h9H4_skPZdE2w>
    <xmx:O4slZ-yGs1WRqLzs7DmE-MvvIQaHZ07Bnnw9AzoM6RcGH0mOe0qQlw>
    <xmx:O4slZ9Q-fA4NRlGe_HpJXHvaOMd-lJZJ8DsgaODkV89L59BWzAtwag>
    <xmx:O4slZ5bUrw9nU40b-ozAoTCzx5hso3ATfCzL8ci0ddeh_g10etPg0g>
    <xmx:O4slZ-Rjx8oQsrJIZaofi75QbhuLVKUBsMgilZrR6mu-0-J9EVkiATlm>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 45BE03C0066; Fri,  1 Nov 2024 22:15:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 Nov 2024 22:15:03 -0400
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
Message-Id: <7fec9e68-4cc7-4db9-a6a3-8a2917132ac8@app.fastmail.com>
In-Reply-To: <20241031040952.109057-16-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-16-mario.limonciello@amd.com>
Subject: Re: [PATCH v3 15/22] ACPI: platform_profile: Only show profiles common for all
 handlers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 31, 2024, at 12:09 AM, Mario Limonciello wrote:
> If multiple platform profile handlers have been registered, don't allow
> switching to profiles unique to only one handler.
>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 38 +++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 7bd32f1e8d834..90cbc0de4d5bc 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -29,23 +29,43 @@ static bool platform_profile_is_registered(void)
>  	return !list_empty(&platform_profile_handler_list);
>  }
> 
> +static unsigned long platform_profile_get_choices(void)
> +{
> +	struct platform_profile_handler *handler;
> +	unsigned long aggregate = 0;
> +	int i;
> +
> +	lockdep_assert_held(&profile_lock);
> +	list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +		unsigned long individual = 0;
> +
> +		for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
> +			individual |= BIT(i);
> +		if (!aggregate)
> +			aggregate = individual;
> +		else
> +			aggregate &= individual;
> +	}
> +
> +	return aggregate;
> +}
> +

I realise this is very unlikely but isn't it possible that the number of profiles could overflow unsigned long number of bits? As handler->choices is an array of them. It should loop through BITS_TO_LONGS(PLATFORM_PROFILE_LAST) cycles.

Also wondered if this could be simplified with setting aggregate = ~0 and then & it with each handler->choices to avoid having to scan individual bits?

>  static ssize_t platform_profile_choices_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
> +	unsigned long choices;
>  	int len = 0;
>  	int i;
> 
> -	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)
> +		choices = platform_profile_get_choices();
> 
> -		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
> -			if (len == 0)
> -				len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
> -			else
> -				len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
> -		}
> +	for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
> +		if (len == 0)
> +			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
> +		else
> +			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>  	}
>  	len += sysfs_emit_at(buf, len, "\n");
> 
> -- 
> 2.43.0

This links in to the later patches - but I was wondering if at profile registration/unregistration if building a local choices selection would simplify things.
Then instead of needing platform_profile_get_choices, you can just use your local choices selection to make decisions on what to show, or cycle to - instead of having to cycle thru the profiles and bits every time.

Not 100% sure how well it would work out - but might be simpler and faster?

Mark

