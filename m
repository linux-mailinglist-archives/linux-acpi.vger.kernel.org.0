Return-Path: <linux-acpi+bounces-9257-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282C19B9C42
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 03:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68395B22002
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 02:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EEA84D3E;
	Sat,  2 Nov 2024 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="NfLsvkjK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnEvG9vL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC976410;
	Sat,  2 Nov 2024 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513775; cv=none; b=KVIW4x9ORdqhVgvmc6I3GUSi39L0JKTOAVlyDFp+9YrcTTN6j0LN0jOlwBpmghTsqrgDDk+CnStI0PJdlnZLRBPnhUUQnwvP4Jv+c9EkCJw4+mWaHVyXxHV6uU018O141HhjqJAIuB0nlBILGUtUbnmbekcjJbJHzr5PEFnRVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513775; c=relaxed/simple;
	bh=IVry5oy+xhuX3GeSLpFHU4zQYEwQEYL9q9M2SE940bs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pO32QrdTz7ITbkADfCmU/M30iul1YtHSl7R25J7GOIxbSMzmsOsRAXg8mc9lgtVuZqrs8OMROLWDmkut74XwgjxsC8KMlbz2VYeMHY6dAfeBhDG2RErqVy5hGpKhQf+CfbIIV49KKwsmtyUBIQNU6Oa3c5OGX9AxRJWZJ/tieBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=NfLsvkjK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MnEvG9vL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F6F225400F6;
	Fri,  1 Nov 2024 22:16:12 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 01 Nov 2024 22:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730513772;
	 x=1730600172; bh=Sqe5h+nWEXB3tXAxjTcRkhhBIT3ZJ93cgqBjduUAUyE=; b=
	NfLsvkjKZgivSdgmqWyWwbeipXUdbEMnr9QJhIDhAbzPz2gTddGFs9UI1RGCCcAz
	87oBpze6FK7BhLm0rNbJUUBMpwDhDPQul97G5Qg67CQ6b1md+FzrIEbnqZyqM01B
	aZ+TdtkfO3tZoh0XLhgVb4PiYM/JXVN98ZPxqgeR/1MxlfLvEuNfliluYTcN6oWk
	5rkY0GNntzVjy90uGGUdUUzRsr2LkwsZvoxFBldOIc15guohZ0WujH8CcLjyoFir
	MbptUf62qWdT9lIpomD8RtKSZW+o47oKN0cdBPE/Gmxdnu7dO55KsA9Vpr0RsKOK
	wXAe8U3ELUYMNO1P2WZ4kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730513772; x=
	1730600172; bh=Sqe5h+nWEXB3tXAxjTcRkhhBIT3ZJ93cgqBjduUAUyE=; b=M
	nEvG9vLHMJdlFt9AD1j9lH6uwuzaolJxDKIQI4ZPIsZ7UAr5tJ56411umaWw5YhM
	ES0NmZPvydkp32BY2stlbJvSogmLgxGz3wGAZCeTh96K+ykREGaltmXWiMJPhMJL
	UzTtyRdLbFwEBIGG04OET9MlbEt2u6ko6UhuqpUQBDmA+hS2V/OTGqNwuhz3IDNN
	nX74t3RfSGu3TqVXTKANB5fRebe0NU62ZAupB0yrk9RdpJGdVii5u/yOOQ0BKFjw
	YtdkXD5NRzIhhjcncInbj6MEB9V7iBvvFdFl6CJ4i67xnpWfL93zDHIt1qX5s8Er
	eBIcUWRLQZd5fWyNr92EA==
X-ME-Sender: <xms:bIslZzHqWROXKS5lraG0r07RwvAMIPSkX27n6FQ2HEfrWknYEkHmVg>
    <xme:bIslZwXZ0rDWzLA-wD2IxRjMXpKZbvOT7y12_tw9e6v8LISIUF_apLAFm11hD6gjg
    Gs8rFKXWAZg3Ryo7Mo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehikhgvrdhprghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoheprghl
    vgigsggvlhhmgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgvnhhtihhnrd
    gthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrgigihhmihhlihgr
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehhmhhhsehhmhhhrdgvnhhgrdgsrhdprh
    gtphhtthhopehsohihvghrsehirhhlrdhhuhdprhgtphhtthhopehlvghnsgeskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:bIslZ1I9vRanhgM0eMzmW6fbiCsI3DKIvc_ZYGI9UTv64n3K8No-tw>
    <xmx:bIslZxE0JpxCF3l1QB5T_5wFR1LhhKjQH6nVD3_Az7KHZcyrFQsSiQ>
    <xmx:bIslZ5U1-8hTO9FZNcCG3TZ0XXWmfruEgGGcbvqRsXRDmUWarV2RZA>
    <xmx:bIslZ8NKXGFktiPoKPQGpJNrF5XvyNwAsywrAh0gGYUs6-j8bjmtkQ>
    <xmx:bIslZ23jLoWdJjMdtNZ3AywLyUj2qN3H4hSxJfOoX4hfH_ydSPXFASEH>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 392003C0066; Fri,  1 Nov 2024 22:16:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 Nov 2024 22:15:51 -0400
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
Message-Id: <34c98d8b-f9b2-41dc-b087-a543f2e897c8@app.fastmail.com>
In-Reply-To: <20241031040952.109057-20-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-20-mario.limonciello@amd.com>
Subject: Re: [PATCH v3 19/22] ACPI: platform_profile: Check all profile handler to
 calculate next
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 31, 2024, at 12:09 AM, Mario Limonciello wrote:
> As multiple platform profile handlers might not all support the same
> profile, cycling to the next profile could have a different result
> depending on what handler are registered.
>
> Check what is active and supported by all handlers to decide what
> to do.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 35 ++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 5baac1f9a9c0e..9b681884ae324 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -187,30 +187,41 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
> 
>  int platform_profile_cycle(void)
>  {
> +	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
> +	struct platform_profile_handler *handler;
>  	enum platform_profile_option profile;
> -	enum platform_profile_option next;
> +	unsigned long choices;
>  	int err;
> 
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> -
> -		err = cur_profile->profile_get(cur_profile, &profile);
> +		err = platform_profile_get_active(&profile);
>  		if (err)
>  			return err;
> 
> -		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
> -					  profile + 1);
> +		choices = platform_profile_get_choices();
> 
> -		if (WARN_ON(next == PLATFORM_PROFILE_LAST))
> -			return -EINVAL;
> +		next = find_next_bit_wrap(&choices,
> +					  PLATFORM_PROFILE_LAST,
> +					  profile + 1);
> 
> -		err = cur_profile->profile_set(cur_profile, next);
> -		if (err)
> -			return err;
> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +			err = handler->profile_set(handler, next);
> +			if (err) {
> +				pr_err("Failed to set profile for handler %s\n", handler->name);

Suggest highlighting which profile failed (profile_names[next]).

> +				break;
> +			}
> +		}
> +		if (err) {
> +			list_for_each_entry_continue_reverse(handler, 
> &platform_profile_handler_list, list) {
> +				err = handler->profile_set(handler, PLATFORM_PROFILE_BALANCED);
> +				if (err)
> +					pr_err("Failed to revert profile for handler %s\n", 
> handler->name);

Suggest 'Failed to revert to balanced profiile for ...'

> +			}
> +		}
>  	}
> 
>  	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_cycle);
> -- 
> 2.43.0

My note from patch 15 applies here with having choices determined during registration/unregistration.

Mark

