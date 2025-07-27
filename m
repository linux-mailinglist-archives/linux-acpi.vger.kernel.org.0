Return-Path: <linux-acpi+bounces-15330-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9532B1323A
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 00:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA2367A2E39
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Jul 2025 22:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E424A047;
	Sun, 27 Jul 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hNU2T5RX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005B198E8C;
	Sun, 27 Jul 2025 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655052; cv=none; b=adN8xogCP1YCx+nJ2kpw8/L9tnFomPbwYvrDtlYynpKmkeAQD5a3n2BEkJ3h+w1uhZCXt7XFfMtEtqjvr9C0/iF5hMGEBIYv+eRNgAmU7QX6BcH5O59qaLv3HwZn5RMbcEt+a0PHdoOjF3Gud9YjeBIhO4vdyc+RUgHGawT9ZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655052; c=relaxed/simple;
	bh=ISZBQJUakdaBUwOdxrBWUAiu/Vjs+cOfRQdcsu6fu/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h4JlPoXDhT3jEmmIlNZcZ4zI+gKhVXZaS8WDWB7HZrS1o/bsoN/vsgKZyV7l4E6SXrqNejtJkWGV8JkiHALR7GvTUxFI2SLnOGG1JIj2trZkP/BTOHdaiH0j4Yuh+FyX08b68XsRZ/wJfs1pDQqPYUpwjUYESLWcZeHuv2RgNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hNU2T5RX; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753655043; x=1754259843; i=w_armin@gmx.de;
	bh=ISZBQJUakdaBUwOdxrBWUAiu/Vjs+cOfRQdcsu6fu/M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hNU2T5RXhC8EhZ/FXCtnIW5/9Y1uBITwm73W4k7sMxjLzWoTl/aRPfeJXQurUKRU
	 mvC4fAYpyH7LqQ9ZKGGFdRLJWiMqbxB7G7eDiiLyGHAJ1RRF26o0i8CXfGIgVs/Mf
	 FdbkGr021IRbuHdKcXO0edPupKO8h4fISGcvsuU7XDFebsL3KEo4tLQMZ9hxxRLLW
	 nigg9OMYw5VkcbcUPDyknw9kpgQnQmK2jPFuHwm8JhgCycXlUO6pSI/BJLxs9WSj8
	 PFD3PY2HG5hm2PO2ZOAVwIr2AKpQVJiS0EMowK8xK6pWB5IJLNLDkULlBp7mfXGZv
	 FP6bQeWaPLK/sOrHYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lYB-1ufsXI0q0p-008T6U; Mon, 28
 Jul 2025 00:24:03 +0200
Message-ID: <b4707664-6177-45ff-a284-36e921f316e7@gmx.de>
Date: Mon, 28 Jul 2025 00:24:02 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing ACPI driver for a keyboard button in Xiaomi RedmiBook Pro
 16
To: Nikita Krasnov <nikita.nikita.krasnov@gmail.com>,
 linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux@weissschuh.net, fengwk94@gmail.com
References: <6c7e2d8a-8c79-4311-8126-c888a6519c71@gmail.com>
 <68cc7f60-39b1-47f3-9120-82f8b0f26d9c@gmx.de>
 <b1f1fa0f-fd32-4e5d-a9df-9ac2af428a86@gmail.com>
 <616bdb32-0d57-476b-8ad0-f2be3c5c9fbe@gmx.de>
 <8f3d1015-3bef-4e7f-abea-c6665163af16@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <8f3d1015-3bef-4e7f-abea-c6665163af16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Tuj1I0LqUjg1MkBY7z6AIBTFJGkhEfPWMH0MnLYx2ceSDa0BYaS
 C3qz5pX9Gj3BzwLgDciWnsxt9A69xW6MlizH/wqmBy+ApCg6Dv83nooEuP7LVMEfan22d6G
 YQjJ64c5CX9yZF/DZl3JsCj2LLeiu/9KYoLsHAemwapHxeAC7pE/FASivr49aDKXf6SrBI5
 YFmissVOnSXKZWHC02IoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8q2+l2z9yLo=;Cf1COkLEV6IUXFjLRdEmqOeJCM9
 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

Am 27.07.25 um 13:23 schrieb Nikita Krasnov:

> Hello again!
>
> Sorry for taking so long. Real life stuff gets in the way :(
>
> On Tue, Jul 22, 2025 at 07:09:37PM +0300 Armin Wolf wrote:
>> Take a look at https://docs.kernel.org/wmi/driver-development-guide.html.
> Thanks! Coupled with articles [1] and [2] this was a very good
> introduction to WMI and ACPI.

Please note that the LWN article regarding WMI drivers is quite outdated. Please follow the
WMI driver development guide from the kernel documentation instead.

>> Sure, but you have to develop a new WMI driver for your device because after looking at the
>> ACPI tables (SSDT20 in particular) i came to the conclusion that the xiaomi-wmi driver cannot
>> be used in this case.
> Why is that? Is it because xiaomi-wmi is using deprecated GUID-based WMI
> interface?

No, it is because your device is using a different WMI interface for delivering events. Device manufacturers
are not exactly known for using the same WMI interfaces for a long time :(.

> Btw, it's so weird for me that there are many laptop models, but only
> one *-wmi.c file per manufacturer (be it Xiaomi, ThinkPad, MSI or Asus).
> Is it because most of the time we write a driver for a specific piece of
> hardware that may be reused in different laptop models?

Usually a given WMI interface is used on a wide range of models so that the device manufacturers
do not have to develop a giant number of backends for their control center applications under Windows.

That is why many WMI driver work on a wide range of devices from a given manufacturer.

>> I suggest that you write a skeleton driver first that basically prints
>> the content of this buffer to the kernel log using print_hex_dump_bytes().
> About that... Would you be okay with me implementing this driver in
> Rust? I assume it's you, an ACPI WMI DRIVER maintainer, whose permission
> needs to be granted to green-light this?

Personally i have no problem with you writing a WMI driver in Rust, but currently we have
no suitable bindings for the WMI driver API. Additionally i am currently designing a new
WMI driver API that will make it easier to implement the necessary Rust bindings, so the
whole thing might take some time.

Would it be possible for you to implement the WMI driver in C?

Thanks,
Armin Wolf

> [1]: https://lwn.net/Articles/391230/
> [2]: https://lwn.net/Articles/367630/
>
> --
> Nikita Krasnov

