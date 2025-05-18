Return-Path: <linux-acpi+bounces-13781-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6775CABAF53
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 12:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215A03BC98D
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09416214212;
	Sun, 18 May 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OPgAgb5Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vD47HsKk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C11DF973;
	Sun, 18 May 2025 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747564630; cv=none; b=NCCN1bN4uN5Hgs+5oo70DrA2aUULMV8oMse6onXLJNGN+3a4M+ccFqLg/QH7UWl2CT8SicFSvr5EevTYhBGxH6Xoj3hiqNfrXqYOrbEPcw0+AyGnAc6atTeWQPHOLo001Q5W7mFIr79ftDg7PXfE8rACVyXMvWf1wC7RVWzq6fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747564630; c=relaxed/simple;
	bh=Rdr4/LLt19WMj0Jnc4oDWc8eUb/VMHycvcZIIqxGGFE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YA3tuiLRQ3Rr1q0b6ZrBlhuKlVUS5YsdcXeN21nVvqwbkIUbcNCgk2TUh71MEnDCRky+wyT2o+yJZQTCgb2OqERV3tp+9+5FGIH+0z0F65/YhdrivL//Tm/hKbGIC/EVXaaThJ6GVrbdwBD9UgXa4ANmC5Rw+iwg2PlwB1IyLB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OPgAgb5Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vD47HsKk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 274CE1380156;
	Sun, 18 May 2025 06:37:06 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Sun, 18 May 2025 06:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747564626;
	 x=1747651026; bh=asZJIugkMSLeXuWUY+4CGpyc9cFNSY12yXMfKnbFWeA=; b=
	OPgAgb5QcmR8rj7MfCQ3Ct4CjhXcxRpp73Ac3j9Ly8G0frtLC0kuoSoVSg4yuvSN
	JdigRxPyxQyCqUAuMVTgrgyhZmk8tZiijeszrq72VSWHW95BrE2tK7g/WyGX/Syc
	0TYJBqpr/JZITbplPNagiVnOAR5amJxlhfZHeDSyotpBTWjyLVEQktwiEtIIqgS7
	xWH8/s4BeNcy4fZb4iqqBdOV+FkJX9zK8ezks6LJL3+0Pe44fdFNkKamJuUJskGj
	Zn2FRM/vTKMiSTqccnD7M5XqY6wqAFZjmLmFgUNVh4EEYu6h11TfKfIB+UAWM850
	tqhdvA8uhU56x27HRNXQKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747564626; x=
	1747651026; bh=asZJIugkMSLeXuWUY+4CGpyc9cFNSY12yXMfKnbFWeA=; b=v
	D47HsKktiwjoaLyXIWlBhNNSCTAlJRGOhk4P1/RxKnb/JdbA0wytfUtw7QsUdPHI
	R+IFwNMtNWZJ5Bs5vY4nNsCpBGMtQL+4ckqk1mDn3gsbFMDdOPjInlysEH5Oemc7
	LvN6MLkIYq5Kld79CQY7yoSHAQpP3aTr8kOJzqI6gMJhtujzt1aryuqJ6jR2dW0n
	C4CdVhgg67GQpbluslqUvOEGN3LO+az6hLiAAEAoscBefNzHxRdpSa04q2X5eBiI
	DqaKmYSTY3ULDdmGKOCnee3DaQIG13VtU0mRfiqiwnkcomTAd1zA0rdfrhOWtvev
	G4GxNnu9r/VM8ybJ75w4A==
X-ME-Sender: <xms:UbgpaOsv9KCNjTo-a-j4Ffguj_IR7RwnvluaHCQD_NB2pAd5qlGVUg>
    <xme:UbgpaDelnykCGylM2Y6p_bu2rVKqJh1kX9J5xsrBvtb8bunJsBPUunBTeErAuNyNh
    QGYmVqVwzNhu9GpMnE>
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
X-ME-Proxy: <xmx:UbgpaJwafR8SXzG5BIm5oIK3X2vPh7jMrAqpbO7b9Tfw44KGtRgRFQ>
    <xmx:UbgpaJPo3-LqdRbJxJ2x6lfjiNdISu8ssEwVgFUyE-6KOFa8keRrWA>
    <xmx:UbgpaO_cEeJBbR8U1b9AvA5iMN80gs9soxYZCkkxH17SOpx6RrOl9A>
    <xmx:UbgpaBVoVL1J5pCi7wSOOml6YcfLRD0ZYwicLvGBZVyI0cz9b4laow>
    <xmx:UrgpaJr9X-wZb8lP8TUVcnniqLjSnGiOKH9LCG4niWoym3_WS590I0jI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA6001060060; Sun, 18 May 2025 06:37:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T5605245bb69d7150
Date: Sun, 18 May 2025 12:36:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Janne Grunau" <j@jannau.net>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-acpi@vger.kernel.org
Message-Id: <d57ff24a-bf6f-454d-9b00-8abf8071658e@app.fastmail.com>
In-Reply-To: 
 <20250518-hid_lenovo_acpi_dependency-v1-2-afdb93b5d1a6@jannau.net>
References: 
 <20250518-hid_lenovo_acpi_dependency-v1-0-afdb93b5d1a6@jannau.net>
 <20250518-hid_lenovo_acpi_dependency-v1-2-afdb93b5d1a6@jannau.net>
Subject: Re: [PATCH 2/2] HID: lenovo: Remove CONFIG_ACPI dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, May 18, 2025, at 12:18, Janne Grunau via B4 Relay wrote:
> 
>  config HID_LENOVO
>  	tristate "Lenovo / Thinkpad devices"
> -	depends on ACPI
> -	select ACPI_PLATFORM_PROFILE
> +	depends on ACPI || !ACPI

Since ACPI is a 'bool' symbol, the 'ACPI || !ACPI' dependency
has no actual effect. I don't see any way that ACPI will ever
become a loadable module.

      Arnd

