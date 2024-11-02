Return-Path: <linux-acpi+bounces-9258-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EDC9B9C46
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 03:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A6B1F20D3E
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 02:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C4913BACC;
	Sat,  2 Nov 2024 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="AvMazv8m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYFtRlZZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95C82890;
	Sat,  2 Nov 2024 02:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513782; cv=none; b=c3KZwl+ifxp1ufe1VWA4TBT2O2hzmCGSk8iTNthS6i2LW+znztDos8c88HLfCsCWN5BwFFUZQZmNKyiv/5FuD1kE6dvRmw19gz257KsaZcM8W8rJDngM0ZEyX7MDkWe0eB9h2IKjSelMEu4BrQukpwwDu8D0xu0mojwRl6930kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513782; c=relaxed/simple;
	bh=gjCEsuEilss2qA8Ve+CbbYkzhQNVe2FO4I8YRyxBe6M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RF9QwKpM894/g+0MBki8O6PDxLQYSqKE0nj4C9hzEBph1dWIto9yP61d0kzLU9F8nUEmBCdkhJyfMVs2A4P77BIlpu3l80R0VFuB/JIDFZrVguX81jWo2PifZWbThz2d/I9uRlv+7kqZ6YU4oxlhk/LOfOdWk2jpNuk8j3Xzpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=AvMazv8m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XYFtRlZZ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CCA131140083;
	Fri,  1 Nov 2024 22:16:19 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 01 Nov 2024 22:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730513779;
	 x=1730600179; bh=vP58K3GxwI0krgh4T0ir8Z/MG0lVm+dJJ+Fi2CLGnkw=; b=
	AvMazv8mZNs30NeyYiQZl5xf3m/cabGz3BGW2m0k1gRRQe5wlHYqyb15FSiVRP9C
	JAqMHhDaWVKy20PZK4M/vTnDDJkBFcIqc2hVzN2TKPugLNSPuVEo3SyFx1KmyvoF
	AHSvg/IQaLMSg5ASe7/glCF92oU3ZOhGkCwS+H9d8BqEHhaXfVpOLkhUXginwj+A
	1UR3zHh5BWBFT2ztOb4qUdYst2I3sTPVdWFRxmj8dEDU54glPGQlyFzZjmz3ITzn
	kqHLt4EFVlNjgx4VO2XqGsLW7Rxj7Ck0fJf+5DNILUdaLhx4gZ7PNFVjKjAAIQgr
	KsH4NMBHiMxzKqvH64nhiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730513779; x=
	1730600179; bh=vP58K3GxwI0krgh4T0ir8Z/MG0lVm+dJJ+Fi2CLGnkw=; b=X
	YFtRlZZljhar3kGcxOmTq5coxi6fYFBL5qa374xFUWSvuQo/P8m/p0I7Dl+rcnxu
	mv1tH9thdotxtlRFvd38CISoaUmaBkErTPHmfU0lyPiAQnt07iDOP8q/RhdweF1Q
	dLcBnnxD4yF89Wm+K5yLX0pLawUqBfI0oRoDaQJS/cWPHHNUPi9yPHgG1vLZce+K
	4qs0KhjMWzjmUPL068b1gRngp80hamA1t/jJWx8bfNIw+kVzgS5owZnBDo+ppAIC
	vekXisygpb+hXtCAVyKszOtN4sd1vtgLWSqcuIkDb5mlKN+kmWuUt7snjczZlu/T
	rfBAm1/9t6HRDMqzusvDg==
X-ME-Sender: <xms:c4slZ4naSnFCvNyYikEXsxdoX9DlAXj2Gx_ao21NqSWopq9eGssAVw>
    <xme:c4slZ30-eAkxATHaFhaZzcAa8arARDiFCZnWB31PK6UEZNZ4luA-Znkizovwoi98j
    u5MuUpgGhXNd5PqFeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddggeegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:c4slZ2pB8wgaA5xjILiv9cTHntVAMxioFLaJFiZMeS9aAvRVhpRBNg>
    <xmx:c4slZ0mC89oZ-_dipp1ym04L1DKP1gsTMSrAG75_zGYSPmNMjbVNIw>
    <xmx:c4slZ23TS6YRhBN4Ho5CZ4gkINr3JqA5AGY3zoeD7bGxIP67imlNww>
    <xmx:c4slZ7uPn928O6Q6X19ex4LZBpuAtboBLJI4tpO2kFFID_Trr_RI1w>
    <xmx:c4slZwWCHN6KzydXs0tC1HHAzilavpKkSTANQ_Wdrf6QbXJia8ZmRpva>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7A17F3C0066; Fri,  1 Nov 2024 22:16:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 Nov 2024 22:15:58 -0400
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
Message-Id: <22e1712a-d5ca-411d-b75c-2cb2288ecbf7@app.fastmail.com>
In-Reply-To: <20241031040952.109057-22-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-22-mario.limonciello@amd.com>
Subject: Re: [PATCH v3 21/22] ACPI: platform_profile: Allow multiple handlers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 31, 2024, at 12:09 AM, Mario Limonciello wrote:
> Multiple drivers may attempt to register platform profile handlers,
> but only one may be registered and the behavior is non-deterministic
> for which one wins.  It's mostly controlled by probing order.
>
> This can be problematic if one driver changes CPU settings and another
> driver notifies the EC for changing fan curves.
>
> Modify the ACPI platform profile handler to let multiple drivers
> register platform profile handlers and abstract this detail from userspace.
>
> To avoid undefined behaviors only offer profiles that are commonly
> advertised across multiple handlers.
>
> If any problems occur when changing profiles for any driver, then revert
> back to the balanced profile, which is now required.
>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 1cc8182930dde..a845524a248b9 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_profile.h>
>  #include <linux/sysfs.h>
> 
> -static struct platform_profile_handler *cur_profile;
>  static LIST_HEAD(platform_profile_handler_list);
>  static DEFINE_MUTEX(profile_lock);
> 
> @@ -212,7 +211,8 @@ static const struct attribute_group 
> platform_profile_group = {
> 
>  void platform_profile_notify(void)
>  {
> -	if (!cur_profile)
> +	guard(mutex)(&profile_lock);
> +	if (!platform_profile_is_registered())
>  		return;
>  	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>  }
> @@ -280,9 +280,6 @@ int platform_profile_register(struct 
> platform_profile_handler *pprof)
>  	}
> 
>  	guard(mutex)(&profile_lock);
> -	/* We can only have one active profile */
> -	if (cur_profile)
> -		return -EEXIST;
> 
>  	registered = platform_profile_is_registered();
>  	if (!registered) {
> @@ -313,7 +310,6 @@ int platform_profile_register(struct 
> platform_profile_handler *pprof)
>  	list_add_tail(&pprof->list, &platform_profile_handler_list);
>  	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> 
> -	cur_profile = pprof;
>  	return 0;
> 
>  cleanup_device:
> @@ -336,8 +332,6 @@ int platform_profile_remove(struct 
> platform_profile_handler *pprof)
> 
>  	list_del(&pprof->list);
> 
> -	cur_profile = NULL;
> -
>  	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> 
>  	sysfs_remove_group(&pprof->class_dev->kobj, &platform_profile_group);
> -- 
> 2.43.0

Looks good to me
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

