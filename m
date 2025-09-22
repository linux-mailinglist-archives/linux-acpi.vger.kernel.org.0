Return-Path: <linux-acpi+bounces-17210-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCBDB9290E
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 20:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4105441A10
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 18:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1458315D25;
	Mon, 22 Sep 2025 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="vNHj76tu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GBI4bsvx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211762DEA8E
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564724; cv=none; b=m+eiPJARq+fN8oPoZg5wleqh1rC9bBrjH3W/y6u9vXM/cek3huA/R/mZDzzwMp99BGFS5ZfV4Ix+s2yZZTngJHgq0r6scYG5rOB6ti+yV2jZ4NCiTd/mGrJbk1u6YfDWBCf2u7NUrAHU1DoAWT/UctkKHDybeIiuG5uMb/EGmeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564724; c=relaxed/simple;
	bh=AXVidVfETcBYZMdiw7fDesx2tgMg7ob81W9EbTEum2M=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oHx6fFY5nHGbMElB3MThtgPnslgJsfJluLAS2KrPSQLTqxO0L8voF01iscJNwJn/8QUb35rnzu8ohslniszmRbITrS4IqSvrb1yvqD+kO1gLp9xiP0A9phKpO45FO4LetIIYZx6Ly8teUymmT6qBswLcjcj3M/orBe683hLOp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=vNHj76tu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GBI4bsvx; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23F227A01AC;
	Mon, 22 Sep 2025 14:12:00 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Mon, 22 Sep 2025 14:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758564719;
	 x=1758651119; bh=WQmKzpFSKupzYnHgpRR5yUmEVyZ2XjxWVVWteSmtpPI=; b=
	vNHj76tuAgE3mcOKlMe3NS7P/CkrZsu6KP45qTinG3tdF3zmJfHUajP1bgCwy/oV
	n8uYoOwiQWlMKvIKzw+QL7ewxVNmAc+IPtwhzJweAutqxjuYxmWaZgijj5FcTBEo
	zwwOxVBsVKG20w3cvrEjUsJ0SblJqguEkXAhvDxDS63QxY4DyBihG5poW0Bmr5X4
	ObjTJMtnu9ui70+9FeshPGIZ5iI6wvec2tgjSG04MqXLQak4ITL1YLJvrAjSxmNz
	zNV8QljgrqOumjJr8eFjC2xB4i3GY55xhfLOGGxmRBOVGEGhWM4Vv1tXp6yQEjKi
	aeZ33vebp5Fi4DXJI5JU6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758564719; x=1758651119; bh=W
	QmKzpFSKupzYnHgpRR5yUmEVyZ2XjxWVVWteSmtpPI=; b=GBI4bsvxFNpgJNTJx
	8mG12yI4UlhW0axBKtKi7mmN2D+SfI3qP1ckCigkSNCf3kdB7W5uz5U5rUILSaRW
	gvOxlZu1yY46Zy6L2AIRnELwb3QiilObaJapgyfls1pYSktmwEqyGYmzlya3sdg6
	ErLvzux6t9+eLtFIomOMxRKNfVweFVFdfwg/Ge+oFvQLCHv18Ib+wyNlBRSEtjgd
	dJQDwXQee6y3Sb+Y9FLwROLEyF2RRnxfz1N1MQpux/E5L571YkIjBBZ2VATsE+JO
	JtPvEEaz9kD67oBMc1HumcML5wNnk44nhPzjV7xB6ub3fPIyT4hpLU8ghSWP4nPY
	yj+Dg==
X-ME-Sender: <xms:b5HRaOVVxet1rduCKPXPom3aJqBPU3-l-aG9-4INPHFYsnI23ODOlA>
    <xme:b5HRaFYk3E6Rhuk_4PAWjK8mUR3jWAtTtcOK3ghw_GnmS32tZRjfq9FHIwRJ2YVSz
    h6_-JS2Xqk8spue2ZwFHy4TVfXX0E9d2IbQKq-PMsYVqM_Ofc-Cjf9n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhl
    vghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhepgedthedvieegud
    eutedvfeeitdejkeeluddvfeekgeeuffdugefhjeeiteevleeinecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhq
    uhgvsggsrdgtrgdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepmhgrihhlsegurghvihguqdgsrghuvghrrdhnvghtpdhrtghpthhtoheplhhi
    nhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:b5HRaFAA1S4Wp30vZMCIc4670WBrg5DIrYtSLhd1eQL-NP5u3G_ofg>
    <xmx:b5HRaBdLkyBprRAI2MCBr0wDUbKlRIjB0JaA7MWqoGDX5E1xKE8XdA>
    <xmx:b5HRaIIgKEnDbhdem5HwYkPPr03A8K7OajRjv9AIVr1qX6Ass1Y1iQ>
    <xmx:b5HRaMeOuoSOz4KQiNvJMhnITlJKJBXFxZ_iEIrzTXVsdTwypdxQcg>
    <xmx:b5HRaLU_sSdGPvLgAcT8NopKEhKzalkP_spfYnnjHqUVRQqFYAvCeRmw>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 88AA12CE0072; Mon, 22 Sep 2025 14:11:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ac9xkh2THd6w
Date: Mon, 22 Sep 2025 14:11:39 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "David Bauer" <mail@david-bauer.net>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Message-Id: <443087de-fa85-4604-8d92-a577e1048159@app.fastmail.com>
In-Reply-To: <34b11aca-0bbc-460d-815b-82f173974a0a@david-bauer.net>
References: <20240831003610.89970-1-mail@david-bauer.net>
 <84ec8f08-bc7b-490b-a6f3-0f41ca99dbc0@app.fastmail.com>
 <34b11aca-0bbc-460d-815b-82f173974a0a@david-bauer.net>
Subject: Re: [PATCH] ACPI: EC: add quirk for Lenovo X13 G4 (AMD)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi David,

Interesting - I thought we'd caught the impacted platforms, but it's possible that generation was missing.

I had an internal ticket open for suspend issue on that platform (LO-3142) and that notes that you need to update to BIOS 55W. Can you confirm which BIOS you're on just to rule out hitting that issue

Mark

On Sun, Sep 21, 2025, at 5:01 AM, David Bauer wrote:
> Hey Mark,
>
> On 8/31/24 02:53, Mark Pearson wrote:
>> I believe you've hit the issue that is being tracked in https://bugzilla.kernel.org/show_bug.cgi?id=219196
>> 
>> We're working with Qualcomm to get that addressed. It impacts systems with the Qualcomm Wifi chip that uses the ath11k driver. I haven't specifically reproduced it on the X13 G4 - but we've seen it on three other platforms and it sounds exactly the same.
>
> I have seen patches [1] have been applied and gave 6.17 a spin.
>
> First of all, the product number for my X13 G4 (21J3) was missing. I've 
> added it myself to
> the list of platforms requiring the PM quirk, however I'm still seeing 
> wakeups on AC power
> state changed while sleeping.
>
> Does the patch retain sleep functionality on other platforms?
> I'd love to help getting this fix, in the meantime i resort to 
> acpi.ec_no_wakeup=1
> which fixes these wakeups.
>
> [1] 
> https://github.com/torvalds/linux/commit/ce8669a27016354dfa8bf3c954255cb9f3583bae
>
> Best
> David
>
>> 
>> You can confirm by using a 6.9 kernel and it should work correctly. If it doesn't, please let me know and we can investigate further.
>> This is a Linux certified platform and I'd rather get issues fixed correctly than have to quirk them in the kernel and potentially impact other functionality.
>> 
>> Thanks
>> Mark

