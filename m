Return-Path: <linux-acpi+bounces-13788-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CACABB1E9
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 00:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E39174461
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 22:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE85D1C1F05;
	Sun, 18 May 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="yIZ+wuJr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gNtipnHv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8E188715;
	Sun, 18 May 2025 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747605791; cv=none; b=UklshocIXmttEqM3+ziXuyIHumO4Wjzs0j0RLJKUewNOVOasKCzymumizVOgXkSO1c85nvCdsrijhm7eArt0P2dQKudQXHJ9lSVVFbi5Rt8ieBKtOLY84m5pjSfjOKLT5OvBlxVdF2yq2qANAOoEhtu5SptufxHPp4586GUFYH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747605791; c=relaxed/simple;
	bh=UBCf64IpuYd9aU8GijeqvZEEJzOIENjWdqsdBgx5RuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbqxEH75lsU11ii1FeO3EicKhsMCAWklrxKDMWQPOioU52ZtDh8CJ4ggZ3dZIja2Q30+VL1qdyEAx0hJ2JWBj8DSmP2TjCL7QZfzLyqnrXP0TsgWFVjozEaMfrDjTMpmZaWSIpNbtW1Hy+OK9/zh7NtaKceRZVdWNg0b9D3fYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=yIZ+wuJr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gNtipnHv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id AE6D31380224;
	Sun, 18 May 2025 18:03:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 18 May 2025 18:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747605787; x=1747692187; bh=GmMWzloHA0
	zc/lE1krpWtzRstHZoWgSml9UBorZTh8c=; b=yIZ+wuJr6gEkLp/NWc2QJkd2vu
	WCqInJnPcESPCLR7mX2T4VEdLIhKiAPwFD2RQDVm+PmjBaynCbAHLNf0WvpFSKAz
	pBT8k3FPpISVDktXvumD0KoxV9WwM1zbHIwkZufY6QhdNeuldTZ8/Jt7CVZqRzOT
	Xo3f/2o4eCP7v1F/PVI9PUe2SKLsEL1Bfnf+GnPkJ+biZ/f+rwR0eg4XIz1QEuav
	jkhvZw5r9Di7W+F4RKPVAgdWV6/46VaeXxM7TO94irz/QnYMj3hXowCnszpL7ZNk
	g0O916tcYOXDE4I7g/AGugcyXnbahMKeektAuyX4ZWodAEyGEVXHzWrD2QKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747605787; x=1747692187; bh=GmMWzloHA0zc/lE1krpWtzRstHZoWgSml9U
	BorZTh8c=; b=gNtipnHvbAIUUdRVPaJUKPUqnmeN7J4c+JPcgfs1UMNKuILT/YR
	3p3BSnpKxuzu3r51k8P9shS+fuKY3I/PJ0q6HOZeyEfv0UUMAwMf1SmspUsorEwK
	8DYKmQrfqYopHcmAJUQwh0F8PXcNMuQbUh90tY+2xRjC+VSyXQ2YARMJqoFjDryD
	zZ3t8WS16Si4FFrp8RGcTm3mbymvpIllNb3tvZm49UngWCqVYUNbEGZMX1Odb5bl
	WzyQAC/KqQjbqMrLnlKKmaYDJQrqvuxsFEbiYjWEAw0xaydnWAKOnpjasjaM0kvb
	+fd3jbHJZe974i/OcqT2h2mFVYn6J1Tn+YA==
X-ME-Sender: <xms:G1kqaO4wn8jt6HF936II-4wYvh3bP3stfoa6uHY-9WROoT9lAHr7jA>
    <xme:G1kqaH7FGzls-7wAHBIfjF9Hl6p6U6uqokiBhI5ZupDmG_33ceapY3X60-GZ2_WFt
    TEDttAYkufp5npehPU>
X-ME-Received: <xmr:G1kqaNeiyo_qV8rI66cUqyhfEVm1kdX7VUhn2oyey8BHNHstqu-dmB-TK4RHqY15ezqr3SvDv7jVzXQBnZtS5X-pecHa_M9-MCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudelieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqe
    enucggtffrrghtthgvrhhnpefgvdffveelgedujeeffeehheekheelheefgfejffeftedu
    geethfeuudefheefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopeifpggrrhhmihhnsehgmhigrdguvgdprhgtph
    htthhopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnthhishhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhshhhnuhhotghvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhise
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G1kqaLLrqxyPL2EkRNpEuW-esuH63iFEn7-ualufTBuENn-merWQmQ>
    <xmx:G1kqaCILUYsALkXa7UYrAmn7KCj-3olbDWUFC38rtJ3CMRMzGC7gtw>
    <xmx:G1kqaMzlwGFtd4CKHfBcyNDToZBg6yl1Wo0WFUUBkmrZ1RijNVPuNg>
    <xmx:G1kqaGKxRCBadk0cG6QbcYVBRDW1ujQ4jaQw8zmSk_KWuipPpND8Ew>
    <xmx:G1kqaI6tfuIH9I-eQFLIDgBr061EbypE81sa5D8ZL-PhLqxn_UKm6mqM>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 May 2025 18:03:06 -0400 (EDT)
Date: Mon, 19 May 2025 00:03:05 +0200
From: Janne Grunau <j@jannau.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Vishnu Sankar <vishnuocv@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: lenovo: Unbreak USB/BT keyboards on non-ACPI
 platforms
Message-ID: <20250518220305.GB2575813@robin.jannau.net>
References: <20250512-hid_lenovo_unbreak_non_acpi-v1-1-e9e37ecbfbfe@jannau.net>
 <b77edae0-50bd-4039-9487-15bb69389c6c@gmx.de>
 <20250515230537.GA1556976@robin.jannau.net>
 <b3536162-44aa-40af-861e-07371497ef30@gmx.de>
 <20250518094353.GB1556976@robin.jannau.net>
 <79124489-0a2f-42ca-85ae-6f442e42e2d3@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79124489-0a2f-42ca-85ae-6f442e42e2d3@gmx.de>

Hej,

On Sun, May 18, 2025 at 07:46:12PM +0200, Armin Wolf wrote:
> Am 18.05.25 um 11:43 schrieb Janne Grunau:
> 
> >>   
> >>   static void __exit platform_profile_exit(void)
> >>   {
> >> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> >> +	if (acpi_kobj)
> >> +		sysfs_remove_group(acpi_kobj, &platform_profile_group);
> >> +
> >>   	class_unregister(&platform_profile_class);
> >>   }
> >>   module_init(platform_profile_init);
> > thanks, patch works on the affected system and the HID device for the
> > Lenovo keyboard probes successfully. We still need to stub
> > platform_profile_cycle() to get rid of the ACPI Kconfig dependency. I'll
> > send that out separately.
> >
> > Reviewed-by: Janne Grunau <j@jannau.net>
> > Tested-by: Janne Grunau <j@jannau.net>
> >
> Alright, i will send this patch to the ACPI mailing list ASAP. Please keep in mind
> that merely stubbing out the affected functions is not enough, as the platform profile code
> needs to be moved out of drivers/acpi/ as well.

Thanks. I will go with patch which #ifdefs the platform_profile_cycle()
call out. It is only used for a special detachable tablet keyboard which
is ACPI enabled device anyway. So it will be hid-lenovo local change.

Janne

