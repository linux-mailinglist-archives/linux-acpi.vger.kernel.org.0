Return-Path: <linux-acpi+bounces-20594-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4biNGSIRdGnU1wAAu9opvQ
	(envelope-from <linux-acpi+bounces-20594-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 01:24:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D927BA8B
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 01:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29A893014977
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 00:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74994191F84;
	Sat, 24 Jan 2026 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sorz.org header.i=@sorz.org header.b="AQLNIKCa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rxClZ9Rp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA914A35
	for <linux-acpi@vger.kernel.org>; Sat, 24 Jan 2026 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769214239; cv=none; b=ZS44cQiUMBoU11h3fz9Gi93RgzvtKbEz/7fhKGt48LIW6++kSDNtS4kOBvQ6JdYgXvqm7P3UF9lUKDyn4hd9XiN6/1KGYpI7LGT7tfLWD5RVnUIm5lJstK0c1hTndRutfD5wtQg+Dtkm37TzGkhHgT/uz2xqJq34+6C8O6GRoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769214239; c=relaxed/simple;
	bh=ob1lZtTq0h5M5I22SkA1NswFONlvoqyXH+e0UYdZXEY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QIlkjmp6XIunDVyHCCDYbOJuJH1c3km4zHO32++PG8y9YDxbGokS6WxL4ytl2PmsFt413oAMFwtw00c4LfiunPPSoA1RZ0CzPYuDvT2aBPZe/Iw7iXCD0VQAqix6LAZJSw0LfDrpO7Qfn51Sy/UOzpew4Sv3/VH/JgMuA3+vxlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sorz.org; spf=pass smtp.mailfrom=sorz.org; dkim=pass (2048-bit key) header.d=sorz.org header.i=@sorz.org header.b=AQLNIKCa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rxClZ9Rp; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sorz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sorz.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D60F7A00AF;
	Fri, 23 Jan 2026 19:23:57 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-06.internal (MEProxy); Fri, 23 Jan 2026 19:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorz.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769214236;
	 x=1769300636; bh=afX6wr8CRJoHQbnjpR/HLKl4AimKln9pQsGYRV4oB9g=; b=
	AQLNIKCa8r0HCeEeqyxBO59xX8eSB/8xwxmEuyEvXwwO3GWxkdcEVDtjRwx2u2yX
	6OcQJXoe2atxE4cLBcB0J48CDKbfsOIu2qoGcOiI507hg7SWLzn3ipNTa5VqlE9/
	mH0eCaKGccsvJlyFCa8M9GciWEK4YMCGdsPmNz7qQ8DcBvDcIi78Z0zikPUh7d7K
	7E9vHXUa22dlhuWcP8XXr7k8nY3rXCueWg8v7/zv+IbSv/h4nqpzdgV9+CXvmTSg
	ZY8FVdoQd+NzdKoU0QfbpuEWa+AbYrThPtvxM4anrExQOCcQ8ESlZPgIB3ze9RUn
	psyOQdIvVZOAAtQEUwLcvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769214236; x=
	1769300636; bh=afX6wr8CRJoHQbnjpR/HLKl4AimKln9pQsGYRV4oB9g=; b=r
	xClZ9Rpq9JsBxMw0RJrcUwJb+xlVcEWjfmpHrks0D0ihr9OQ8Hmf2HRGELJl/wXh
	z/7Q8uqctIytv/wSxQPctu5XDCn0ELZx8HFJ6RmxNdezhdW/nNkcgS8EwVhR3HkM
	ADXIQjH9CYjf4u5i+RJidRSnl50J2XHIm7j5Aj174I3DQp7aHiPjs4YmmzKRERKX
	yhEyA5XPErH/c+wRBIRTwSa3pBbdUcJgWc++Q63kch7YqEz8z1S0A/x3khNeGgjY
	nVYaq1XmGsFAeoLbarVtiKCHrcAbzyBswDJV/W61lFD67RvLDezDmbCsPDK3a/d3
	wW3Nud7zA1j09HLoLTEEA==
X-ME-Sender: <xms:HBF0ac1pTsYF7FwvR6n-XiIBfsqLHKJfbPSQAIpyLIoPBBo0eIeREQ>
    <xme:HBF0aR4O_Ax6smvBGBpzLXZVdmQ3231egD62fpjLYiM2cOCu061IaSE2oY6tpFw4u
    dwG0TirV2gNs8cSpivUfZx5EZFu78T71DcdLFiAvmIcIjoT03aZbyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfufhhvghl
    lhcuvehhvghnfdcuoeifvdejsehsohhriidrohhrgheqnecuggftrfgrthhtvghrnhepvd
    ekudetteekteegtdefuefhhedvhfekheevkeeivdejveefffdtffdutedvfeetnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpphhrohhtohhnmhgrihhlrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfidvjeesshhorhii
    rdhorhhgpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrughmihhnsehhihhfihhphhhilhgvrdgtohhmpdhrtghpthhtoheplhhukhgvsehl
    jhhonhgvshdruggvvhdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HBF0afyz1p9gztmoijCy8ZOfYikBEn-uOD4KNdZqcn8A5HW9IJzfTw>
    <xmx:HBF0afCNOVF1HnjRSYw-gjYrarBboQgUbqP9deOYUDyULCzoPDHKaw>
    <xmx:HBF0acaKqK7NP2j6o_1yPTgcxbqrpeQigcLERM8o-aNwiZxLZIkQTg>
    <xmx:HBF0aXh7ineCDP4cM-TQabmGhW6e_vrTEtaWcUlrStpSPA0wD32-Tw>
    <xmx:HBF0aTbhJC9FzLh04uthwQxRBFMBDakaMJ73u-PGeETyNNPv2BAS-mzB>
Feedback-ID: ic14149f4:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 95F531B4006D; Fri, 23 Jan 2026 19:23:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADvU0OnrsFU-
Date: Sat, 24 Jan 2026 11:23:03 +1100
From: "Shell Chen" <w27@sorz.org>
To: "Zixun LI" <admin@hifiphile.com>, linux-acpi@vger.kernel.org
Cc: "Luke D . Jones" <luke@ljones.dev>
Message-Id: <dc7fb018-fc95-4976-9a4a-8237280553ad@app.fastmail.com>
In-Reply-To: 
 <CA+GyqeaFsLj7ocLGEuw9mB2f5qChC-dMb-jvLN9BVe=rRU=J4g@mail.gmail.com>
References: 
 <CA+GyqeaFsLj7ocLGEuw9mB2f5qChC-dMb-jvLN9BVe=rRU=J4g@mail.gmail.com>
Subject: Re: Long boot time on ASUS TUF A14 FA401KM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sorz.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[sorz.org:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20594-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sorz.org:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w27@sorz.org,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sorz.org:dkim]
X-Rspamd-Queue-Id: 82D927BA8B
X-Rspamd-Action: no action

Hi,

On Tue, Aug 26, 2025, at 7:51 PM, Zixun LI wrote:
> Hi,
> 
> Kernel boot time is very long on ASUS TUF A14 FA401KM with kernel 6.16.

I got an A14 FA401KM and encountered the same issue.

> From dmesg the kernel is hanging for 36s:
> 
> [    2.164931] usb 3-5: New USB device found, idVendor=13d3,
> idProduct=3612, bcdDevice= 0.00
> [    2.165573] usb 3-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    2.166127] usb 3-5: Product: Bluetooth Radio
> [    2.166671] usb 3-5: Manufacturer: Realtek
> [    2.167208] usb 3-5: SerialNumber: 00e04c000001
> [   38.188085] clk: Disabling unused clocks
> [   38.188644] PM: genpd: Disabling unused power domains
> [   38.191606] Freeing unused decrypted memory: 2028K
> 
> Result of initcall tracing:
> 
> [    1.750332] calling  acpi_gpio_handle_deferred_request_irqs+0x0/0x40 @ 1
> ...
> [   38.126886] initcall
> acpi_gpio_handle_deferred_request_irqs+0x0/0x40 returned 0 after
> 36376321 usecs

This behavior is the same as booting issue on ASUS ROG Strix G16 G614PP reported on another thread:
https://lore.kernel.org/linux-acpi/6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com/

>             While ((Arg0 != RDNT))
>             {
>                 If ((Local0 >= 0x0f))
>                 {
>                     DNOT = Local1
>                     Break
>                 }
> 
>                 Notify (^^GPP9.PEGP, Arg0)
>                 Local0++
>                 Local2 = (Local0 * 0x64)
>                 Sleep (Local2)
>             }

Also similar to G16 G614PP.

I believe their fix (when come) can fix/apply to this model too.

Thanks.

