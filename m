Return-Path: <linux-acpi+bounces-8370-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C7197F191
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Sep 2024 22:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED785B211EB
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Sep 2024 20:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273CE1A08A6;
	Mon, 23 Sep 2024 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="CJYiXrts"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A11CA84;
	Mon, 23 Sep 2024 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122497; cv=none; b=aYGIK+E8wnhFKdVKlPQ8RcArXKHFxwsEfOnTFuoSAqsGL7QEamtRIWMmByxUxBL6uf+R8+8EM/HjRyfPcUrtkhaW5IMamQnRjEx/+BSokiFavhiUs7WV4QfFEr+2vR3HE/OZiH/hZ4PSxiyppQlOBOPbaxMhvtW+76K0Y8uawMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122497; c=relaxed/simple;
	bh=9+kfOVxJ+qMKojjS5j1te2JbrQlQLUUS3TJqA7LFI1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZ+vE690W7ZotOzuRn55J/3qMFTz/NXnKOhbLqdTSyjN6IjmSQdoEF1UUjgMveJ6hmisEbGUzlK7feE/OL8x5tHptuj05A9Ya28TwrbDXxxFl0Va03XGo5tYx3IsjrnC0gxT0qR76C4gpZRqwDqtmlSS+Rtkfj7BfqxgrEcOidw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=CJYiXrts; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727122480; x=1727727280; i=w_armin@gmx.de;
	bh=T/aGqZEDlREEwCYifDT4fqocykpAlFW8hsEpBx9aX9E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CJYiXrtsWP0L2jhX7bJCwUYu36Fru/lrQnd0WbHwAm3zBEUGoYJg+6fi8FCU03pM
	 yas5FGcJqKgtzIaN1nn23B/g1XoUVUo1ENNC2yJlwHcrokq4nbfLeG44EzWq38vL8
	 2djbeJ0fDjXdZs7jtBiAHJnHYC0QawJyRqQdX/1ee1yJV5G7IO2EBm3FApYHv0myz
	 lVPNu2qK6u1gvI2W0caUdG3v4KvEE41u1+JQouSmq/fPHAk6UESYO9LCUHl7vgfPl
	 wVTNMDjftWPmfp8MnmrOYFSHxBzSm2z7zDAbSAYLTH3ZqTKiIixIgAdr8WgUxKXjX
	 e+7+k6HdHl196uJpGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1sjn1q3n61-0085O0; Mon, 23
 Sep 2024 22:14:39 +0200
Message-ID: <69e63476-e166-4231-9986-54d10418c940@gmx.de>
Date: Mon, 23 Sep 2024 22:14:34 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] platform/x86: dell-laptop: Battery hook fixes
To: Andres Salomon <dilinger@queued.net>
Cc: mjg59@srcf.ucam.org, pali@kernel.org, rafael@kernel.org, lenb@kernel.org,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240922064026.496422-1-W_Armin@gmx.de>
 <20240922034513.330343fb@5400>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240922034513.330343fb@5400>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JNbqXuB0mviDPTUfqIJlAeHJLrgBkgxvWGPWjFkCRhXOMEoLdXz
 f/bWsHyepXq+Bn4o8qDt3T8gvQSw9lcUzvfiR16dbydFEIjfiSbltFESRX/gpUkFmJtV17J
 ibg8b6/hak8Fn5/o6IsUfVeafUyD2QVDsv3zJtsSp8wK0sdxwzn7Pc3pVAPtLVy0P46drOQ
 fMaIaBUU4fDlS3ze6YLAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1YAm6a0hjd4=;9kmuUECL+iuCVvC0b+VONoT2Cne
 DvGVe9k76AUWVH6RsJsQaeP2ZhnjDOjfznoUSi6PIN2rptODDIvXVGG+D3JMg8ukMMGRmNg2A
 feSCoRBbKoLs8ElpxHGYsbd+ZS08bzxsAhytAoXQqs6oBoAgTNACDamgEDPpsMRS6PcE7GyPy
 q5cAaE8AH2W2jkpAnIaSe07jkcBkGmn7UoHiRCj46tmYrlBcul7GZvB9lx5o9v8Ii5XWZo8U1
 Zf2g/kFPaBdoFw0Myc4zJ9faq9jmWEBIu1gG4GgmoetKwBbQO1/zY0PLz6Aj/6YHsaeqv2HNQ
 WON69SmrfSPHmsqhYHQ6brjOcjKRu0TRQeZ0K1Jl5AehE3Vdm/cnX7jyDsYSKkNTywDo0CyFg
 n4GtGrM6Sb1hgnC/roXV6bSbRBtxXeHZHIwnooPYeevqx5DQ+RG1vQX28gKQOY7wPbhzDG2T8
 qTmA1WZTyg42Z7sUxMSi4E3XgSXOdr0+4gejW3WvJM3sSz4ekjxgAKz9+UZnwXOinw3OZCO+k
 XanMaTNQQdMbNtjCTapUE4eB8S9u5GZx8/GUVxQQ7r32xkTqv5/B0Jfg3JnLf0FLcnGZfr8Cc
 HQgaHxK8CquINKA9uO6U7g0wulzhqWcF0KJb8/VNFiqGUZs2frG7pQsT+vcIdJJPQrcwitdcY
 0TPoSJ9rQlEhYEyeCKR5DhE0DFHvabzF0sxJ7FbstaTUE6dtlXqTdSXFLCJYrcwddZ8UqHnPr
 pAk8wTAqBZ2SmFHVV9q3x1X16ea6FZmghKViEtpfWVIge5P3Qi80hItZkZrv34Ot7/R/+L03I
 5q47WFrt5z3IZFDjUWOTp/7g==

Am 22.09.24 um 09:45 schrieb Andres Salomon:

> On Sun, 22 Sep 2024 08:40:23 +0200
> Armin Wolf <W_Armin@gmx.de> wrote:
>
>> This patch series fixes some issues around the battery hook handling
>> inside the ACPI battery driver and the dell-laptop driver.
>>
>> The first patch simplifies the locking during battery hook removal as
>> a preparation for the second patch which fixes a possible crash when
>> unregistering a battery hook.
>>
>> The third patch allows the dell-laptop driver to handle systems with
>> multiple batteries.
>>
>> All patches where tested on a Dell Inspiron 3505 and appear to work.
> Can you tell me more about the system? What type of battery is the second
> battery, and how is it attached? What do the kernel logs look like when the
> two batteries are registered? I'm still confused as to how the same
> battery->dev ends up being reused for multiple physical batteries.

Hi,

i think there is a misunderstanding here, each battery->dev is associated with a separate
battery. The issue is that the ACPI battery driver responsible for managing battery hooks
does not correctly handle battery hook errors during runtime. For example:

1. Driver registers a batter hook.
2. New ACPI battery is discovered, add_battery callback of the battery hook is called.
3. The callback returns an error for some reason.
4. ACPI battery driver automatically unregisters the battery hook.
5. Driver unregisters battery hook during removal.
6. Crash since battery hook was already unregistered by the ACPI battery driver.

This patch series fixes this by adding a boolean flag to signal that a battery hook was
already unregistered, so the ACPI battery driver can ignore those battery hooks in
battery_hook_unregister().

> The patches look good to me, btw; feel free to add my Reviewed-by
> if that's helpful.
>
> Also, with the caveat that I'm not quite understanding the aforementioned
> battery->dev conflict - worth noting that dell-laptop isn't the only driver
> that could have this problem with multiple batteries. A quick glance
> through some other drivers:
>
>   - asus-wmi.c does basically the same thing in checking for just the first
>     battery, and the comment implies that there may be multiple batteries.
>
>   - system76.c claims that the EC only supports one battery, so maybe that
>     one is okay? But to be on the safe side, it should probably do the same
>     thing.
>
>   - thinkpad_acpi.c actually supports multiple batteries, so maybe it
>     doesn't have the problem. But if tpacpi_battery_probe() fails for one
>     of the batteries and the battery->dev is shared between the two
>     batteries, then same issue?
>
Good point regarding asus-wmi and system76, maybe we should provide some documentation
for writing battery hook providers.

Thanks,
Armin Wolf

>> Changes since v1:
>> - fix the underlying issue inside the ACPI battery driver
>> - reword patch for dell-laptop
>>
>> Armin Wolf (3):
>>    ACPI: battery: Simplify battery hook locking
>>    ACPI: battery: Fix possible crash when unregistering a battery hook
>>    platform/x86: dell-laptop: Do not fail when encountering unsupported
>>      batteries
>>
>>   drivers/acpi/battery.c                  | 27 ++++++++++++++++---------
>>   drivers/platform/x86/dell/dell-laptop.c | 15 +++++++++++---
>>   include/acpi/battery.h                  |  1 +
>>   3 files changed, 31 insertions(+), 12 deletions(-)
>>
>> --
>> 2.39.5
>>
>
>

