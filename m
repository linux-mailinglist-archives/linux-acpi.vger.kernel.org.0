Return-Path: <linux-acpi+bounces-13784-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3485EABB094
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 16:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB21176A67
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 14:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFF22AC17;
	Sun, 18 May 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="W+FVNV4m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tml9LWxA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F681854;
	Sun, 18 May 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747579556; cv=none; b=RwDEj+oLkZBtEfM3n0rixU5vzwkjHuDAnle7vlP/lphdnD39H+u8fNNcz+3Jp+3JBSeg8KpGi5TFIQ9QLaK2j+fsb8e/B+IQ67nZplCSECsQmrGl1ZWAQqqh7Z9SrjdZgm9z0hAsW+q+AaFa0+Ck21WZ8a6QWK7+s/m8G74txBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747579556; c=relaxed/simple;
	bh=BQETk6Ggkdsgb2g4ES16VK86IgSB5STx7Ub7+zQmQUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tiia/dAQixIMedE4xH06wYSjVAh88YaRn/opOphHWnUeOfJCNF4KmFHNLIbZJq7plm72zR8yWQYMvVCP3Xqr02PMKqTUhG+kvgju08t/51WGMFknyWFRIx51OiYAYYC6HGLSbjErF0aMZF19+bMtTL4eVCQZ+IcHAqijAX/K4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=W+FVNV4m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tml9LWxA; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF14525400EF;
	Sun, 18 May 2025 10:45:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 18 May 2025 10:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747579551; x=1747665951; bh=Py4G3MDxeu
	igMengKWoY19c5Uvu7Jo6Z75bc0ItCy8k=; b=W+FVNV4mBj5mWKJAWfnutg3T8b
	YTRCKiRWZxdt7tx46lBC5+H4WLPcJaBkFWsnRWvKrDte1sJfKBCV8JA7/rNTsPG/
	C+WuaK8Z1lvN9qu788Jjf1B28H7M1G0xYl4XlpkK0dI5v81pU5styi4c+TZ1DLHr
	8yMA5Z+/8uc0rCKLarO8fqO2A3Qf+q2v3+B/sdiSMAbm++S82IKBMWaQbYVd9n5l
	kfJ/vBxD+JnWkQTSTXIIhfVUbislJq6pm/BAx18Af88ZN+nNaRh8V/PXpXP4V2aW
	wWKfZxIUBd0NklrG9RdS8PCTbd3/iyiK366HcUePMHmGN0X0AOTwWgFaPkSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747579551; x=1747665951; bh=Py4G3MDxeuigMengKWoY19c5Uvu7Jo6Z75b
	c0ItCy8k=; b=Tml9LWxAymB9N+SPBcrPXWDr+ofhGNpeH/sOkvpfXlhJuMtjcvZ
	AFnh9Jjww9QScLGsp+ZPv/co04NPoUfvX+CzDCuOFmBcaHM063ghNLjjW3cuP7eP
	Y57I98v0zubVS9NoPx1NM2XJMGtqHGOMBRXzNbIWpsFuSHlZ0M20JWDvmXvrjPDP
	fTKmlQgDmEIajS/4Rpr5WwneJiSTpD8jlv8xY5S29w6sabUabXvQy9rS7pAhhX0e
	aNXeZFK3lxlss82MpuruXiIdnN2e1OK1HDggxt1OabDgQXOcjfjHTqlEpl+QH2By
	59LP10uIjuFVFHKmsZ925ksIA/OGhGOBQAw==
X-ME-Sender: <xms:n_IpaM8o3eJuDXoauJDc-9EVatbbI2sA8XQxxJrCMm4Cgem9QCr2GA>
    <xme:n_IpaEt2nrPWJBHZ373TpqkYLOjpn3qN2ieu_FVQXtjU_-Qoo9WF74uz0P3mn9JaV
    HhT5X0TZwMA7zzhVEQ>
X-ME-Received: <xmr:n_IpaCAYROeYtE6XyuE4hLfkKrOAKuRklaqwPbGkvCEEiCEXx5JNH1n4jvVo4ZrCPlVluUwHGuMS2AeyK0KMqrgg1Typ7JHNwxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqe
    enucggtffrrghtthgvrhhnpefgvdffveelgedujeeffeehheekheelheefgfejffeftedu
    geethfeuudefheefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtth
    hopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnthhishhssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:n_IpaMdxDui99Fg3uwvgRjM5iEB2YV4-sN_iV9eHoarzJ_GiXq8bSA>
    <xmx:n_IpaBMAF3rvsPtqPX0QoCCMAvHvoWz8Rix7cAYZ9XzQhtJhg0BLJA>
    <xmx:n_IpaGm2RrIu7t6LUckfV1g5GYEoq7FJthXw694ym_y5LT6gNtccqA>
    <xmx:n_IpaDuSZxkPM65kVfz-rBJWfbj0Y1xHZhJeAuFNsSWb8kskbs4X_Q>
    <xmx:n_IpaEcLgTLz9zA9TerOaxy1YObYRaSoleOzGMWdn3HkIPj4IXBsL-Hs>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 May 2025 10:45:51 -0400 (EDT)
Date: Sun, 18 May 2025 16:45:48 +0200
From: Janne Grunau <j@jannau.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: platform_profile: Stub platform_profile_cycle
Message-ID: <20250518144548.GA2575813@robin.jannau.net>
References: <20250518-hid_lenovo_acpi_dependency-v1-0-afdb93b5d1a6@jannau.net>
 <20250518-hid_lenovo_acpi_dependency-v1-1-afdb93b5d1a6@jannau.net>
 <b939dc57-74cd-42e8-b1f3-54ea32829212@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b939dc57-74cd-42e8-b1f3-54ea32829212@app.fastmail.com>

On Sun, May 18, 2025 at 12:42:36PM +0200, Arnd Bergmann wrote:
> On Sun, May 18, 2025, at 12:18, Janne Grunau via B4 Relay wrote:
> *ops);
> > +#ifdef CONFIG_ACPI_PLATFORM_PROFILE
> >  int platform_profile_cycle(void);
> > +#else
> 
> CONFIG_ACPI_PLATFORM_PROFILE is a 'tristate' symbol, so the #ifdef
> check is wrong here when both the caller and the platform profile
> are in a loadable module.
> 
> I think what you want here is
> 
> #if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)

ack, kernel test robot already complained

> Alternatively, you could move that check into the caller
> and do
> 
>       if (IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE))
>               ret = platform_profile_cycle();
> 
> which makes it a little easier to catch build failures in
> drivers that are missing the 'select ACPI_PLATFORM_PROFILE'.

I think I'll go with this for v2 and remove the "ACPI || !ACPI" from
Patch 2.

thanks,

Janne

