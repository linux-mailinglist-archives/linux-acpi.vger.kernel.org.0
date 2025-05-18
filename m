Return-Path: <linux-acpi+bounces-13782-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24032ABAF61
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 12:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63A847ABA6B
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 10:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6B217670;
	Sun, 18 May 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FAoF7bED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="daCwVe9p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF3215F5C;
	Sun, 18 May 2025 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747564980; cv=none; b=VWHbX7NitUuUj0Bzc+o9uSGFfrUOaP0iH7uGSycVY2++oZaQzL0Jd7ghG1oWF8QqcFc30S+MQeBCdeqAl6AvBMquH/f+8Mpi3nWga4znZYAvsknAZE72iT5M3+1Ia5PzeDqG2AsvUAWuDa1zY7/V4Zfy6VFGg6aqqksCRrGgFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747564980; c=relaxed/simple;
	bh=nP0a9n5f2g55G3/Q0IkNUusWuZFEawDCs1BGvFlBf/w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hmZCzP4ezVSneEDvZWGwOyFFikBvRoig1cfkRFvXzg7ukAYoJ+GCZYygQQH/pL0ZzcqCJ9K3e5aX79LXM63QI+wGP30iCwCEiwvc5IHC82NtCiMOkvwOAZqecWBJ5vY7YvL1cqY4wnPwS+Ixc1vKBbXBA+jmmgxsLFyGIaiKkQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FAoF7bED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=daCwVe9p; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E5E911400B5;
	Sun, 18 May 2025 06:42:56 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Sun, 18 May 2025 06:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747564976;
	 x=1747651376; bh=mB5qhGsxIkPKIMXl6hejx8K7RJaj9pVG2JCO3mcm4Qo=; b=
	FAoF7bEDGQQk1B0VCDFla1zrt6ze+f0nIHDetw3urARsQIY1xlZZL2ont+DsVAYM
	UiCyo6JLy84bDZTZzd3BPLb4UDIPQHKVwZVuIoOrUuMTZTM+wd/I1HxBeBm21Bq1
	t7fF5aRnwRQjZKkQLvl7SkyrRzdxJ6IDCNqgtSUNUZms4M7aU8821W2qXbDdEmNL
	1QAKz19tei9DWGenRdqfdLIUvauDjtW23tpz2QrSeQzuznaCOiGTfad9NP66R+j/
	tul3XjxkWm0Ik0avkQu268sNRzD/qxauQvAsbIoL/823qUDoQwmXALapMrM872vC
	2vzWIMip5RvEiNRks8VjGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747564976; x=
	1747651376; bh=mB5qhGsxIkPKIMXl6hejx8K7RJaj9pVG2JCO3mcm4Qo=; b=d
	aCwVe9plbzUjTN/ZXdzbI8sa6d9gjuubf/6P9A3jY0sbYZqQjdq0wTbyE9mWw+zq
	8NAaV8hloUwoEhUE4UgFVzY4fJeZYBseCqqA2K17TaiK+HL76Do9WPkUFZKQ8/3t
	TxbFJXJPQPswSWgcyZjShte5CWStH28nOYaIaYxIPwb6diEIW5nFVFQWlISFhJtM
	WD4IISc64F8oa30Heseq49N2m8MBVV8CMK31XeG04R9isRe7FmAE95V5QJDEvEUJ
	EK47xp4EuX/OkdGohmJmIaQ7vT/QssfDOXcOwV6FbS2o37GViij1x6zZbvQ2e0YK
	4/7uq+O/JxGUqm/a/OGLA==
X-ME-Sender: <xms:sLkpaIj1QcrmpLC6pmzAIwy_60E4WceOeptpNcs5Uowj3HDH0s0tjA>
    <xme:sLkpaBDXA_I8dnnc-Zh7BHtkKARm2euQwrI2r6JrX7S2ORkouZW-Q40P3CSRvg0DX
    8s8eIrlmTefHfrLG1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudekvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpd
    hrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhi
    khhosheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sLkpaAFK-5hAA0VK1Avek018Gl8lhGvKuYwQe1pD3dEj2BvzQaoPnQ>
    <xmx:sLkpaJTUSkMQpeamhQC_uvhv9JYyEnG4sjEghmmeFSEgf5BeLcpGig>
    <xmx:sLkpaFw_jW5uOAwYkvh0e2Dh-FC3-QHSkTb4VUL9fNIdHyI-bIJKJQ>
    <xmx:sLkpaH4-x6orfJnXoe3FoyM9_PLm7c5wmogoZ-po99Q-G3IMv-l4SA>
    <xmx:sLkpaGvr1oaaLqw5IAaCmOxw8HPMZ4q_qZ1MZq57idGAxNDhmNYirl18>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 687D71060060; Sun, 18 May 2025 06:42:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7866ccd830be9021
Date: Sun, 18 May 2025 12:42:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Janne Grunau" <j@jannau.net>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-acpi@vger.kernel.org
Message-Id: <b939dc57-74cd-42e8-b1f3-54ea32829212@app.fastmail.com>
In-Reply-To: 
 <20250518-hid_lenovo_acpi_dependency-v1-1-afdb93b5d1a6@jannau.net>
References: 
 <20250518-hid_lenovo_acpi_dependency-v1-0-afdb93b5d1a6@jannau.net>
 <20250518-hid_lenovo_acpi_dependency-v1-1-afdb93b5d1a6@jannau.net>
Subject: Re: [PATCH 1/2] ACPI: platform_profile: Stub platform_profile_cycle
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, May 18, 2025, at 12:18, Janne Grunau via B4 Relay wrote:
*ops);
> +#ifdef CONFIG_ACPI_PLATFORM_PROFILE
>  int platform_profile_cycle(void);
> +#else

CONFIG_ACPI_PLATFORM_PROFILE is a 'tristate' symbol, so the #ifdef
check is wrong here when both the caller and the platform profile
are in a loadable module.

I think what you want here is

#if IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE)

Alternatively, you could move that check into the caller
and do

      if (IS_ENABLED(CONFIG_ACPI_PLATFORM_PROFILE))
              ret = platform_profile_cycle();

which makes it a little easier to catch build failures in
drivers that are missing the 'select ACPI_PLATFORM_PROFILE'.

    Arnd

