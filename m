Return-Path: <linux-acpi+bounces-9040-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 942D99B2C68
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 11:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5125428111E
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CDF1D0F44;
	Mon, 28 Oct 2024 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="pYg2H27U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W6hfFa9w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4F18B46E;
	Mon, 28 Oct 2024 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110294; cv=none; b=QJg8n++HMWMb1rLMbD5SDrTH8Epjn2BYtz2m+e+RF0DzSj6vBd4wtNOtqXLhF2oMQs+4n3B9/DdM92UT9wXlchrKknTrpEGnRa/Iw1WjBFGTkhnpudQJltNiLmserFhTJiX68rzNfBc82hieeDNl4T7eBoAsq0sOsMTostlnwqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110294; c=relaxed/simple;
	bh=lmPgyNFfCFxlaUQrdKiBL9jPod5Vd9fIV8Ofc53KdVw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cRjpLqsODFrXUbdY4ossEyp3q6dwV2OvrznGXP1AlCU2pM6im9orlH6XXXhV+9P8SEO+FgdxLKFf9zzAOTv1fqkbdhg54NQIUwaj5gVDPEln6Ljx64bJvbtXuPqsXxjYzI81k1uZ+et5jwWP2qwkqpvxYcZylD8MfwG8+TSNluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=pYg2H27U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W6hfFa9w; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9AA1911400BB;
	Mon, 28 Oct 2024 06:11:30 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Mon, 28 Oct 2024 06:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730110290;
	 x=1730196690; bh=4fd2GiugWLhkGK3uQczaLMZfZLqu046LSGfoE73TvFc=; b=
	pYg2H27UlCkeNgrYRn81VxyUlAbb2HF+uua9bS+17VaZ2fBvkVElyoVL2rm6HD+z
	Oz41en83luNSlILzGIhIOWpxubhTjz4bWa/bPPW1o6jIIqGzXvoCMOjjqSTxwT1T
	Cv6RehiYKwp2HBAAGf+i6913YB3/jjQcOQdFKBmy0RiRvITR6ciFRmpIFEDEzium
	s0IELFy7s6Qiy2nry3XRQWc++WEkuozoww4gIfHnGm5fEHatahW5qq9nW+HqhEYD
	X4v1PSBzufouSriGzcEErUP2sxTqhGFDhA6gWQnWuL6EkZ/wP+H0ROwpAa9Cc0A7
	gUImsUI554pmQu+pDsSiQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730110290; x=
	1730196690; bh=4fd2GiugWLhkGK3uQczaLMZfZLqu046LSGfoE73TvFc=; b=W
	6hfFa9w6v1uydli+kW+zQbHyF4UZZdVAUdchdkvcaXeWS1RRCfFqZaIOYaEPubnk
	G2rxJcdVkXCnS+MjuJen3fJ6B540kFquEnrLw051OC+VVS/93i+j51XtdOIUDH/s
	tdc4BdhtbIrtGdYfkbtF8Q3givhT1D1csIHO1nDR/zc/lz10imt5l5SR2VJiwpQ3
	BzB1w0kAxqLaPAhyi1AxG80883zzHYO2OAEkYPt97YPUs01v7eijy2eezDv0ZcFs
	34BJRMLFnHmBhEGVzK09Wzd7vgKKRHJL36F3fMeO1HkeLOnThf0/ujF/JiBcbA16
	Vs83sQxCHikxRcXvG3Vgw==
X-ME-Sender: <xms:UmMfZzXfdkhkKObsc1l131Z25owPNRvNGQFC1GPApJAcP-q8ptIS8Q>
    <xme:UmMfZ7nD-Kmc3OeyQ_WOScl8UmUSbOZ8sYvdidxEj-nAKWo7WQFuCe_xaYK4gdM7G
    uusHDpcmDxgUX4il5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejkedgudduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:UmMfZ_bjr7LeQb886z_rKTKOzbzwBE6XrshNRluhkoCv9sxQucj8bg>
    <xmx:UmMfZ-V_XtuUBzlmfpS6mJlJORkghSJvko_4-Er0_xwLAU4wro2tmg>
    <xmx:UmMfZ9n2gwftbbhmVlu4J-FF_kt_OPZ7hoNwERJQKUWie6nntYl9LQ>
    <xmx:UmMfZ7es6QFNBic6TewdXoV3TLmmwn7DuQZWLu-SalmbJPv-L8QoFg>
    <xmx:UmMfZ9EpSue5V-onpItkHZgih8kr4rH4Ltz909UAz3v9Kw-WV1UMCr4O>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2C4A63C0066; Mon, 28 Oct 2024 06:11:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 06:11:08 -0400
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
Message-Id: <a6ae2957-b03e-46a1-b7f9-8fe10c41bfed@app.fastmail.com>
In-Reply-To: <20241025193055.2235-7-mario.limonciello@amd.com>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-7-mario.limonciello@amd.com>
Subject: Re: [PATCH 6/8] ACPI: platform_profile: Only remove group when no more handler
 registered
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Oct 25, 2024, at 3:30 PM, Mario Limonciello wrote:
> As multiple handlers may register for ACPI platform profile handler,
> only remove the sysfs group when the last one unregisters.
>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 81928adccfade..091ca6941a925 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -23,6 +23,15 @@ static const char * const profile_names[] = {
>  };
>  static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
> 
> +static bool platform_profile_is_registered(void)
> +{
> +	struct list_head *pos;
> +	int count = 0;
> +	list_for_each(pos, &platform_profile_handler_list)
> +		count++;
> +	return count > 0;
> +}
> +
>  static ssize_t platform_profile_choices_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -206,8 +215,10 @@ int platform_profile_remove(struct 
> platform_profile_handler *pprof)
> 
>  	list_del(&pprof->list);
> 
> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>  	cur_profile = NULL;
> +	if (!platform_profile_is_registered())
> +		sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
> -- 
> 2.43.0

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

