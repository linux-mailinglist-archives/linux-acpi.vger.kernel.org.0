Return-Path: <linux-acpi+bounces-11133-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA1A330EA
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 21:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074C13A88C6
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 20:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA005202C48;
	Wed, 12 Feb 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Bhp3CiOD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQFR/WS8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A02010F6;
	Wed, 12 Feb 2025 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739392928; cv=none; b=fbgSvJZ6A06cKhFAxTz6mVbSExr8nCLNDXNkiWlZNugMRLvQutGJCDHS1UNF/PXjjvyfBYRch1h1izlo6FjuRlu80lzRtGiGX6Ox3oGDLxRJIeMCHbIcpuLptbTw5t/gvcUlgwBQJ1qs9EZWRV2myslXHPdzXThoeaup0tqUWWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739392928; c=relaxed/simple;
	bh=L08+Uf6L/sH1zcaIZyXOJL0XdQ1wrqlMWrFkZKArxk8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VCSmeryc2nnF4gunUWiNuvzUbi5WMTHRbjqfRgw6Spt/htOCwIID5jpeuWjxHuvHBe9H4gC2wf7/Y9yBr3JSK5SWFB+lKqKJ2ZVi2WuDuH9E4R+JDuFtVlIM5vkmc34ivJb1FoipigkCS6FFq9EXEdHri/5cedLTljeG3DQhtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Bhp3CiOD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gQFR/WS8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 265801140109;
	Wed, 12 Feb 2025 15:42:05 -0500 (EST)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-04.internal (MEProxy); Wed, 12 Feb 2025 15:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1739392925;
	 x=1739479325; bh=t51aP4WhW/zTiyDc+WImCazriP69izX0SMtc5AkJXnE=; b=
	Bhp3CiODAqSWps0/NavyftDi/CfgS28mgXK2vJHTXOLQzvooR/a300VvZgq/FILt
	cIJQbv2/0wro9zHBgmpcQAe111dx6QUlfLYctDXghBT4beWJnBZEEOywhGr0MrEo
	yspE9EZGTIG+1nbt+5w5bPaeX5re9fgUkaFchJbyUbyNtaxeIYs57cbTr00Ayaqr
	3QuH+pAJe/F9Uq/3UgyfiBezfYUVevjqSi81PldfzIW21ifDvHQ5Dd0EdShuDVHy
	/zRE+PdpCRxxBxXgj23Kf/VE1qYGAV4Obme7IJQ7+nsG2FM7JZ4wcH1psbM6V42n
	TdEXmOZ+UWUDx4ToBP859g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739392925; x=
	1739479325; bh=t51aP4WhW/zTiyDc+WImCazriP69izX0SMtc5AkJXnE=; b=g
	QFR/WS8myEjMV6mLar7koiLZPJ55BgZ/LIRLmwAgMUz3cyQ1oNNnE/xf/TRM+ZJJ
	11x7dRGlQFoL9ghUOITUbOj5NyoXors1J+bJpsWljdHt4OY5EEh4XFcvUueSNiGP
	84Wi9WxrIIrZ1k9kKN+CYq0YorDqBnDI8uKbtaI4K1tJ3TFvtaJyYwSRCLzFsNvl
	zvch7J9kFt0oG/hueu/UeuvRovNFx4eHPv1hon3rFsgCnj5IZAVjUsVzVU5cEgpz
	9b4+PhqZ+1PYppwsuco/3S2FXib77Ixv8djBxWRj/efMSeqCDGISrbrJtBFxMApx
	+c2ugL4mLCJWy/k8/m9Vg==
X-ME-Sender: <xms:nAetZzVqUlBbE1FjYozA3NTwgMhU9PXfPO4UQT2lIrVxLOU2_J3RNA>
    <xme:nAetZ7nyVGX3fmk6dl1O1APDnbLyk8KkBwiFcotlDFX7ODTdsohvZpxG2tdMRjb6g
    uuwWlhqk0UZyzkgglk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfeuvdehteeghedt
    hedtveehuddvjeejgffgieejvdegkefhfeelheekhedvffehnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdp
    rhgtphhtthhopehkuhhurhhtsgesghhmrghilhdrtghomhdprhgtphhtthhopehlvghnsg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nAetZ_bmKZ91P33jEJK0OEmb8NxLZoEx1rt0ONvSON3pypJxuPVw-g>
    <xmx:nAetZ-XGA-71dUvVzsoyg2JDlcWUofucEHnbw0KZdn0kPVJ2WooKFA>
    <xmx:nAetZ9kxrek14dr5pGMzn81mtTdoKmLDQXZzvPykJzIgs9ZzhCFTqw>
    <xmx:nAetZ7fLebwniLh5VlBejqAaWOpteg6VzKi5xhRtKLPWSEK7at6Bcw>
    <xmx:nQetZzWdtLKaUsXWOhdzjihwD04ubRSMQQ-SCqPdu8HWX45cQ8lb6uYP>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 458371F00077; Wed, 12 Feb 2025 15:42:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 15:41:44 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Kurt Borja" <kuurtb@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Len Brown" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Message-Id: <bc0a60ef-bdf7-4f48-8215-891cb1efbdf5@app.fastmail.com>
In-Reply-To: <20250212190308.21209-1-kuurtb@gmail.com>
References: <20250212190308.21209-1-kuurtb@gmail.com>
Subject: Re: [PATCH v2] ACPI: platform_profile: Improve platform_profile_unregister
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Kurt

On Wed, Feb 12, 2025, at 2:03 PM, Kurt Borja wrote:
> Drivers usually call this method on error/exit paths and do not check
> for it's return value, which is always 0 anyway, so make it void. This
> is safe to do as currently all drivers use
> devm_platform_profile_register().
>
I was worried I had mucked that up with the revert done in thinkpad_acpi? But it's not checking the return there so I think it's fine

> While at it improve the style and make the function safer by checking
> for IS_ERR_OR_NULL before dereferencing the device pointer.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> Hi all,
>
> I made a little modification that I forgot in the last version.
>
> Rafael, please tell me if you prefer different commits for this. Also
> should we WARN_ON(IS_ERR_OR_NULL)?
>
> Based on the acpi branch of the linux-pm tree.
>
> ~ Kurt
>
> Changes in v2:
>   - Get reference to pprof after checking for IS_ERR_OR_NULL(dev)
>   - CC Mark Pearson (sorry!)
>
>  drivers/acpi/platform_profile.c  | 19 +++++++++----------
>  include/linux/platform_profile.h |  2 +-
>  2 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index fc92e43d0fe9..ed9c0cc9ea9c 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -569,24 +569,23 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
>  /**
>   * platform_profile_remove - Unregisters a platform profile class device
>   * @dev: Class device
> - *
> - * Return: 0
>   */
> -int platform_profile_remove(struct device *dev)
> +void platform_profile_remove(struct device *dev)
>  {
> -	struct platform_profile_handler *pprof = to_pprof_handler(dev);
> -	int id;
> +	struct platform_profile_handler *pprof;
> +
> +	if (IS_ERR_OR_NULL(dev))
> +		return;
> +
> +	pprof = to_pprof_handler(dev);
> +
>  	guard(mutex)(&profile_lock);
> 
> -	id = pprof->minor;
> +	ida_free(&platform_profile_ida, pprof->minor);
>  	device_unregister(&pprof->dev);
> -	ida_free(&platform_profile_ida, id);
> 
>  	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> -
>  	sysfs_update_group(acpi_kobj, &platform_profile_group);
> -
> -	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
> 
> diff --git a/include/linux/platform_profile.h 
> b/include/linux/platform_profile.h
> index 8ab5b0e8eb2c..d5499eca9e1d 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -47,7 +47,7 @@ struct platform_profile_ops {
>  struct device *platform_profile_register(struct device *dev, const 
> char *name,
>  					 void *drvdata,
>  					 const struct platform_profile_ops *ops);
> -int platform_profile_remove(struct device *dev);
> +void platform_profile_remove(struct device *dev);
>  struct device *devm_platform_profile_register(struct device *dev, 
> const char *name,
>  					      void *drvdata,
>  					      const struct platform_profile_ops *ops);
>
> base-commit: 3e3e377dd1f300bbdd230533686ce9c9f4f8a90d
> -- 
> 2.48.1
Looks good to me
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

