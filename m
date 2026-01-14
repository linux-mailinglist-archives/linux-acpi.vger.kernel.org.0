Return-Path: <linux-acpi+bounces-20350-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE18D21AD6
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 23:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64A643016347
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 22:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0C038B98D;
	Wed, 14 Jan 2026 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="frEznJBD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731443557E5;
	Wed, 14 Jan 2026 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431457; cv=none; b=KZRKxuS9sHE8ZXwiqNFdWkq0OAQRui1bvfaisMbax4P8S42nQtBk/rV3d7S/MltfcM37bXLcv6WsPZIykWB8uL1GEVTSMFmyMcFqM0kSkeYj8WhC8JAShMqVR0J+dgGfYZKfsB2GTr+dyhFi+HS3LAeqLA2S1o41laFxJn8MJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431457; c=relaxed/simple;
	bh=5GaCR02o6yis9+VMJsN6pHzUNBuAKEKtt/AinpAdwtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F53fccZRd5DyysNKgnC6g7sRctIYb+obuHmNTS5SNpzRXPReZ8JSQwMyBvS4cQtCXAJKws3dNC4vHgd31zGW184f5F5ACV9kPhnCCvJKRR8+HUjqPYSikdE3d0l449chRBEg/PsemhuAzEiFP8UR4PO78hOaA63xhezzmtLTIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=frEznJBD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768431448; x=1769036248; i=w_armin@gmx.de;
	bh=5GaCR02o6yis9+VMJsN6pHzUNBuAKEKtt/AinpAdwtE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=frEznJBD3/zmTaiFY4k+zMlZhfsT6oTUC+FkIYX1HKUtnrvqqmImFTzYZdoOY8R7
	 P4YGmFJtj59S6HUg1JQ5/KeyFyfH69C9hnAHCuuE7yHih+I/XDJx77OomV4ZJ5SMk
	 IuNYdBCulSZUON/tYjnqEVI8JcF5XSLpCf0o1rUvZIEs1ohu0EJdj2nqIsws2ybea
	 KjS4hKRxWVt5uERFKu60V8S4v/G8M6GnONaTtPXwFABhXRhWlGKi76AqIg2EYlE4c
	 c+q9pB8/liBlrzb/zBTxgv/KyNiRD5YXylw8owj5U2EigGF1+3exoOgkRGxxcCAfS
	 ZZxQi3vqylvSbUCOgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1vSRbN3JwU-00ICeR; Wed, 14
 Jan 2026 23:57:28 +0100
Message-ID: <63582fd0-8c18-48bb-b402-5d3c08b104bd@gmx.de>
Date: Wed, 14 Jan 2026 23:57:26 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 0/3] ACPI: video: Convert ACPI video driver to
 a platform one
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
References: <12824456.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <12824456.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bQ7T1OHqf4LUZ98LA0isuG2AgXZaJjUXx4Ys/7lieAhgokuMbIz
 zzoZPHMZR/vE2uHDPY3SCJh9wpj9CFuVHA4Lz2GBVZvZ3XiwWg2/0ikG5jHwUTU4OtwT3pT
 9L1CXkv5NRqY2+UL6BECi9qTNG/tPJar6crxpmyyVxhUgZf7tS/Dh95cK18T2h1OeqT6Fgw
 t259ll4e7NtiNYPGjhPKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mqLWsT1M3Ak=;qRxCliaW+nKmlTxjd8lsvd/yBm/
 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

Am 02.01.26 um 12:48 schrieb Rafael J. Wysocki:

> Hi All,
>
> This is a resend of
>
> https://lore.kernel.org/linux-acpi/8617910.T7Z3S40VBb@rafael.j.wysocki/
>
> due to the lack of feedback.
>
> It applies on top of the ACPI patches in linux-next.
>
> The original cover letter still applies.
>
> Thanks!

I finally found some time to test this series on a machine that has a working
ACPI backlight implementation. I only booted inside a minimal console environment,
but i was able to still control the backlight using the acpi-video driver.

I also verified that acpi-video was bound to the correct platform device, and that
the backlight device was still associated with the correct PCI device belonging to
the integrated GPU.

So for the whole series:
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Thanks,
Armin Wolf


