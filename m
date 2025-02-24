Return-Path: <linux-acpi+bounces-11439-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F90A4303A
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 23:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF80618921DA
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 22:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DEC1DF73D;
	Mon, 24 Feb 2025 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uTPOcOrp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E815B10D;
	Mon, 24 Feb 2025 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437380; cv=none; b=JI2kIqzl8xYScJGykM6kXsCzLelStB8fKrt5JCFhbdCIRpJ7jk4r62rco/EPGvVcIx7MkTL5fbP0OZ2GwM3C0FgisBePF0QRtXHNjoqXsro+37sKVH0fjcYkJnpwBKA4yeS2ewA6o9SJhRfjzqkjfZ72U4t6vCcBT24Or5oUcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437380; c=relaxed/simple;
	bh=Xy9HTvZEt1MPY0q0wd7PjYQMsZnSy2ro8SIqYGa0838=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjBnWNzhMRsVp6mgTSXy0ICpL1XnUmg4vE8PXbGWBtHeB2bSL/BpOiXSQsFJ/1u+FGUOk0l5zYdtroDGogcID684/ak7D6gMpY5e6s9bdgVRkL7kEXqQxv2JO9PfsD04JUf54vVLM05gPsDkVq1U89qgq8LoJkqEpqqKAu889h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uTPOcOrp; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740437354; x=1741042154; i=w_armin@gmx.de;
	bh=Xy9HTvZEt1MPY0q0wd7PjYQMsZnSy2ro8SIqYGa0838=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uTPOcOrpHg3Zs88QyI41k2efFBZ8tahzrpgPQT+PEBf2jQO7dXAWUHA7mXrg+jeh
	 V1hRO8Ng841PNaNHtMc5h3B8/tIrx5wD5EtU2gWv/VVPzEThRcbYgWHTijYRkGBu6
	 QmNYa9mwEjpUvBISMhmqrV/bJKO2uyp7CGgHFhWsjby+wLXBY7RTVgWsuWQebjvXx
	 e0i9Kw4GTC9Zodg8S+LcYGM03vaOpptdyl40f+0aJRGlYbgx1N+ZeEFAdtARa1aZv
	 mtR2RYxFmD/z7xj3Hf/ZuICNa3FY69Ic+5OGJAvsbrJTzmOyzpU+zufm2HUXsjxkK
	 TgIBF8QKr/MeGC7g3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE2D-1u2rCL2KGh-00MLZn; Mon, 24
 Feb 2025 23:49:14 +0100
Message-ID: <9fa91732-3085-4e79-9a8f-b38263ee7d08@gmx.de>
Date: Mon, 24 Feb 2025 23:49:13 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Antheas Kapenekakis <lkml@antheas.dev>, Luke Jones <luke@ljones.dev>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, me@kylegospodneti.ch
References: <20250224195059.10185-1-lkml@antheas.dev>
 <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
 <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
 <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ibwYsx4t9xisw7mRoLddwREaXllX2vD7tbYNXXUX2pSwe3a8m8m
 Qfn0tKhZODeeKi1/xSCZH+e2R10E2kOSjjSek8aiS+lJWVkpcanKSkL2TfuyU+gU/rxzA6/
 3gnIycgtc9EOJxc/OVWab4RgWnfB9aZ2cgpNaNo/rv11ALSKhJSsc9POHDtXN1iaAJpTPQe
 zO93ECOJfLYqBsHUlB2Og==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DMWThMoawBg=;MhipS2UA6kqDN/eHH6TFo+IRh/H
 LrsNO7GGeWOtPO18CG/8megNUxtqgMLKHulDareH9HlDzOKqR58tyeJy0Doc7915BvKDNqLg6
 KgCE/NsRBF/3H84sr/jRj4mnewQtt4cX6xF3jSpUhEJ3zD9fbdNhjhh//0QU4+R7Pfqj8YQmT
 aYfCsdCfAo+H5Tfd1IKt7/A/HSoKtaYJxZmqhGMkf1W4z4YX8XkpaLs5Xx4ZdpxkcHrHll8mP
 f2ppDN0zqcO/0WmmMABRbk2qztYXyafixqJ9ILFvBx3MbbIG8VYnhJpvkd4tEFZFBEV/7RT9e
 DUGyjxRr7EVUAj02fKUv7YwdrwGZjfWXqjXEUElQPQXvUFTXPQeW7u2bZKmXpyOiAns78Dis9
 z1fa38CXmKNAhcubNUuX49sMwj63CRkVU0C7A3L4UrJXt1mt4ETvTpEUTobTn7ZTqI3N1bybm
 UcUVmhTQrCxB/aq005Ji5eKjMvuSYwpxVp2Cw9Z4iOEsQQIu73Noe64MsOlfVwwhDWzIhXlSR
 ILvajRUizozs5w/fiqijx1Ng+ekQXp9OUupBNc8b+CXvX3U5gF0ihO9tN/qepX8+7nNwZQ3Hl
 cEj7XT4W7brUTLwn2wrVmMf3QT8f+zObltFfrT7JM5Mwn0WEDvZCRT5bkAiPXZzmOvSgQUunb
 9uukMv/tSvQyzdEnxUpJEColIaUcDMP454Lh4i7f/uyojY/mSmcSqK+6m8x5W1GucjEXXjDTh
 fd+z4QrD9D1ZaOOQvIfQbIsOsHdeL/FHTYL8sDwrNIiKdfu/yuZBWWgb2BqdCgXj+KAIsYdsq
 +7fp5hyfTznkSJtw1LEZWUmUnYiCmIAOgEMTZPUuFjpeIn74kdEHmWVvJ8Mf9DECqi84UCHK6
 QxUnZSkoU/MI08uM71yqpbV34HXBdW5YjpO2YfEpKb7KxZQKZ56ZPstEXei+YyewEPWMBMP/B
 uyKhZVZUFhXOhNJu/VNyrQTJnE3d3oXTL8xC78YKg1AWK9kIErRcr1cEur6Y7KrtRfFvE9WOd
 NW7HrbuBjPuKKvOaD/UlGTGXr2hoWQb0VYC8271NYKMqkJNiV8XvDsishnbdLu0QK9jI1g7yw
 oqQXkjFF9MzPHKDKyE1YzRbkn7Ntbz7VOo1kbYZu2+GKpnWA2rlfeXwh1Mx7PrVnQVkJMpVyc
 gv+lp7DCT0gy72zaN00PNdjSp9vesgEqv57ddRj/qr7qIRjimW8ADCX375BJgx7edCq4zN2jg
 sxOss0R5Z8cWbtPuKKZar0C9Gwn8aoqvu1O49bSsk8TQp0jJguoVVqkIOMgcUScCvCNGGuzm2
 28MABgIeCw/UIFI45u4Vh1kXwg8LBGp7hZ0jl6N0I3HbGroYOWNp78i3ukYD2tGnEpB1mTEdx
 V67e8d+saXjFw849Ih3F0HDw30c3UeNrhx0SxT4ppbdOcFrflC5jNb/Pbl

Am 24.02.25 um 22:58 schrieb Antheas Kapenekakis:

> I will tell you that compared with other manufacturers, when asus says
> quiet, they mean quiet and not low power
>
> Z13's quiet mode is 40W, not very low-power if you ask me. Ally X uses
> 13w+boost, a source of many complaints. Other manufacturers use around
> 8W for low power modes.
>
> In any case, any rename might break user scripts and there are
> actually 3 types of low power profiles:
> PLATFORM_PROFILE_COOL
> PLATFORM_PROFILE_QUIET
> PLATFORM_PROFILE_LOW_POWER
>
> Then, there is also:
> PLATFORM_PROFILE_BALANCED_PERFORMANCE
>
> Some ACER laptops implement many of those
>
> Obscuring any of those is not ideal.
>
>
> Antheas
>
I see. Maybe extending userspace to support the new platform-profile class interface
could solve this issue without breaking already existing scripts.

However i do not know the amount of work which needs to be done to achieve this.

Thanks,
Armin Wolf


