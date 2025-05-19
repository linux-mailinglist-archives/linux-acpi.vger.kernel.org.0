Return-Path: <linux-acpi+bounces-13814-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CB1ABC8E5
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 23:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83303BAE57
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 21:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55521ABA8;
	Mon, 19 May 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="vWO/bTXT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R3R9zT+M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B95288AD;
	Mon, 19 May 2025 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689168; cv=none; b=sganxfJ6Iq9ac5V0vZ5U1MH78YAL+HpMW4W6a9EyEcIrb4lys86Sa+MH3pHEQKh4OYIOcT2SwfX+e2db4vgjVDdr51A7s9hHYrnWYlUsVsVXBmDfY53xHXWyEpDCTwYBEcNpOKbJFjGIuKqSvdq6fhvdiBYomgvWDjokOmOMYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689168; c=relaxed/simple;
	bh=SPcSBAE7lMi2Sr/cqYhUftX4nKOZ9dAXel+rQnZ8ecQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h6Hhkx3G2dgw+EOWIQJi1npSfdxAXZMnw8KFwvWOumDRAJU+xwv/RSyfvGalrv5xVUNtn+vWoHwhe6SQvH891KfS+6122C/SJP0Y8nNgexTxhsuznFn//k69GvX92rirawHdWxqHrdw4R4FcUtW3hLgsiq2qt7144t87UW6zpYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=vWO/bTXT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R3R9zT+M; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D7BEC11400A6;
	Mon, 19 May 2025 17:12:42 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Mon, 19 May 2025 17:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747689162;
	 x=1747775562; bh=SPcSBAE7lMi2Sr/cqYhUftX4nKOZ9dAXel+rQnZ8ecQ=; b=
	vWO/bTXTt/1Rz4vTS14ENYnY/81Hqx30n+Quj6hdVFttb60/1GpnJJcLLI4HAYi8
	g5HUlJNYHxawTSy68K4JTwt0llTx12p3sHqPNi4BxSRtH6gvurjWepgSu1ncPqF2
	X36po0P7esj8KGCs2cRMS+eimoqvUwKkARSJpytmgf8BzpBkLfpyfJyT+tFh1ERs
	PulmVpU4K+ZLd8vmeFC3a42HqX0+6trmm93dH4B8saVzIQxQfIsHSgln2WyEN/1R
	NQm3DqyFDqqO/fsSTno8ytv+ps5dz/NSPVph5kcfAYn8Zb601ISyvhDsz++VAd75
	XIpbOKl14D+htdxTSdvdTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747689162; x=
	1747775562; bh=SPcSBAE7lMi2Sr/cqYhUftX4nKOZ9dAXel+rQnZ8ecQ=; b=R
	3R9zT+MpTvNgNHhMe28/Ip3dJt6oJkgQtNuE/ro60nxzLbcx/jt1qFMxgEt0eEDV
	ACoS1jDQj18ewT7vDoVTp4+xbGE5omCvQWgxB5M8qzz5fxwlq2Eu6HAh0/e6FNYr
	MfMteyMLMWp25ZYhCU+dNx3BErYGaj8Q4GkdDWsgMAf+TivyivQ4AZopKrSgSfhQ
	IMPWRIHw8/KExH04hvWW9sTOuv6GM56j2FwGpfzfv9E/RjQoqXqzaOasLVriaH7S
	HyFi93sySkUPa8C0XeaBamazfLKKOVtVYCO1k9KVAC7oL0SPY06tfRXzv3u4LE9V
	8Q+hXCam27mmwHqL2q07g==
X-ME-Sender: <xms:yp4raL_HvUbyOmxtihz1MO4pbys4KKH347A2m5kpZwSFWRyq_RmlDw>
    <xme:yp4raHvCTa45ZX4vY7PNpdErbHp7zhMQl52rW7ELnc3VT6TSoq9wKcMDyRn-CQ6sJ
    5BIZOb3pSvXV15gni8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfigprghrmhhinhesghhmgidrug
    gvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtohepsggvnhhtihhs
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghf
    rggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yp4raJComv4gHL125ZM09cOu5dwMOZILZ1aV1RpCu2DH1hEiwzP1Eg>
    <xmx:yp4raHeR7uRi9ud-oFuSEfw9PbZW9SK2M3_Ne2xDyR2HuAwBn4IqMQ>
    <xmx:yp4raAOePFg-1YTIFY563BOf9LkNVihmv6wKBCtcdcet-h4OOz1Njw>
    <xmx:yp4raJmVcM17-rcnc0zD7UKGiVtx_2N5jYr9n28pdyboAYdRsTTGmA>
    <xmx:yp4raHUyl81EyRnfAlv_2wmVYJpUP32U6MAvLFHeDsHT5ly41sz1PCUB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3DCC91060060; Mon, 19 May 2025 17:12:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7dcf237e00daab9e
Date: Mon, 19 May 2025 23:12:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Janne Grunau" <j@jannau.net>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Armin Wolf" <W_Armin@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-acpi@vger.kernel.org
Message-Id: <68e63303-eef3-41f1-9c1d-ac68990b3243@app.fastmail.com>
In-Reply-To: 
 <20250519-hid_lenovo_acpi_dependency-v2-1-124760ddd6f7@jannau.net>
References: 
 <20250519-hid_lenovo_acpi_dependency-v2-1-124760ddd6f7@jannau.net>
Subject: Re: [PATCH v2] HID: lenovo: Remove CONFIG_ACPI dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, May 19, 2025, at 22:49, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
>
> The hid-lenovo driver supports external Bluetooth and USB devices which
> can be used with non-ACPI systems/kernels. Call platform_profile_cycle()
> only if CONFIG_ACPI_PLATFORM_PROFILE is enabled and select
> CONFIG_ACPI_PLATFORM_PROFILE only if ACPI is enabled.
> This should not affect functionality since only the detachable keyboard
> of a x86 tablet with a custom connector has an hotkey for cycling
> through power profiles.
>
> Fixes: 52572cde8b4a4 ("HID: lenovo: select CONFIG_ACPI_PLATFORM_PROFILE")
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>

