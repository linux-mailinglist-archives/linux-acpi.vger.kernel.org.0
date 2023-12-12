Return-Path: <linux-acpi+bounces-2316-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7A80EA72
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 12:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D921F21D1D
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CC5D4BD;
	Tue, 12 Dec 2023 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EAbRdmqa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC5BD3;
	Tue, 12 Dec 2023 03:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702380775; x=1702985575; i=w_armin@gmx.de;
	bh=xPGk5VnPnUwvPLpm6IAhcnnK/GipENIGWxMGcKHWdws=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=EAbRdmqaI8ve8OvZ5qDTIz1sn8Rj1lto+utMAP9Y7O4wfYWlwpnWlrlMeXyoaUVo
	 NltY2C8yYLnrKgWpskXoutDaSVp6dNR5kf2mXoOgHAVp0+NzDKOM3f7SAFErl4b1M
	 UygGd1dha9IScTXsY70YHZ2az1XbWrfoH2X1X1GE/d85gNRvGrzunFBG8xgHAQ9ff
	 I6cZ3cd/xz/1nloIYcxrLgq2m/oJGqqbBVwSZWpykHs00ySAGRRyFbCAcbqwWduPu
	 jJjFHpaaBJCJbRmR6VREifB3bHz7ODIMsbeVqyovLkytU8xyebI17pTJ2OiRQCH9L
	 Dhj6I3XvQEdHJ5NWrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.61.40] ([141.76.179.210]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeMj-1qj1mu1RbP-00VdyG; Tue, 12
 Dec 2023 12:32:55 +0100
Message-ID: <a96ae23e-3c48-44c5-ba4b-dee2c40f3b76@gmx.de>
Date: Tue, 12 Dec 2023 12:32:52 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Deterministic device paths for ACPI instantiated hwmon devices
Content-Language: en-US
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <9d52cc19-062b-4b8d-a9a0-bc2101dccab4@alliedtelesis.co.nz>
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <9d52cc19-062b-4b8d-a9a0-bc2101dccab4@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HYm+jii7thqSibYajAGvq0koYgGW6NLKP6OZW38AGOrqbPajaMg
 Us475e6IQUkVE6Mw3QR2DyioTv5JQCeSV7ZRpWeDrHalyxuSKT3B8E7i/f8jeuPY9nwuZ7N
 dpJQWnEI1PmeaNBGoaVg48Hru7NuQukXBIcwsjEz94iiuueOczRQdtGnYmclQFGQBNcXSUO
 st+I5xAVuyHOUrNBatCdw==
UI-OutboundReport: notjunk:1;M01:P0:QuE+5+yKgcU=;7MHyOkXwq0pd7dYzf4JUerZKkRW
 Gj0PeN4rKNkWPRd/CY1o1sItBgfgobdYjXEpbELH7duMPZ0YHrVVRxLMWqqvUvy91suBtHUSm
 k7Tcln9JlW2PK+P34jDrV1Q+jnYS3qnQm8Cr5RndNXPaANxx8JE9HNqZ0rPmdjf1LvhWHfnZV
 OdPC/vLpPFWwlQ5YvyqBh3sn/8ijeG8z4SygBfa8VukR62WLPnUSIT9UTJVY45NPCIiTKL7AU
 i3n7QM1o+X14qS8LUBqKMJxNoZY568lZFk6slwrWvxeWalKWQqAKzg/vJD6HHVrwAbATa7dal
 WpDyIeHFn2QgOWRs/o0IPJJaHfnMhjQtcnO8yDY3q+bAU4Se8QqMeFuZ/Zium/B5dUu9quFDu
 4H2+sgOsDqDrxnS6t8Kla6DEpketla0UTD6AdI1xBZSX0g1ixYIOf/6n0h6Qi8kBgOmzX9oq2
 KdHCTaIonf5B2u4LS/aI/5FqNw/7UQeteb4si7Ks1R4pDEZgTE3XKrhw62OrsBJEKFh0rM8XC
 DEfXM6M7zxcw0WzzBgZCjPafaTuihxVlOEJDoFQK1H90K3HtgaQNVldLiVUDpWLgVePm4oF6y
 nCXxrccDz6kHkuEWkRlz9ihRORhWY6yosaK5GfqXRaIJGrZQUyjtu9eZQAwiSog3WjIMzApux
 SgrLVKiY/b5/dBcbdID6ZY0tCVHPW89Lxs1dWuZ+OWfInjS9zSiochjnBBw1kh3AZ8C74SzHw
 jwRLzSYa3gTsB7u7AD9rPgEOJTZAyGZp4ZR3XDhBjcYM2UkSZLw1K6r5or39kE5fFsi/mtVt5
 fiiBYiDOZmb/5/mOXRR40C2W4YMg8a4Gzfe1vjc5P3oJapHcpgLxFWeiQj9ZRuicmakboJBfZ
 nMiNhQ9tNT9EZVU2LY+b6pZQZa1AmFrPIemsx6TmhdR20LdyIuKkLZ1Rj9noOCVKrfZogr0w5
 d20+O7eIR8ITEv/bPsNvH7Hyt7U=

Am 12.12.23 um 03:52 schrieb Chris Packham:

> Hi,
>
> We're looking at our first in-house modular product using an x86_64 CPU.
> Previously we've done other products using other various embedded CPU
> architectures which make use of a device tree for describing the hardware.
>
> We've got some userspace code which tries to present end-user consumable
> names for various hardware monitors on removable modules (e.g.
> "temperature sensor 1 on the card in bay 3").
>
> We do this based on knowing the deterministic path of the device in
> sysfs (e.g. /sys/devices/platform/soc/i2c0/lm75@2e) that works fine for
> devices instantiated on a device tree aware system (using device-tree
> overlays). However we've yet to find any way of getting a deterministic
> path out of devices instantiated via ACPI overlays. For now we've been
> using the `/sys/class/hwmon/hwmonN/device` paths but the N depends on
> the order the hardware was discovered which may not be the order the
> end-user expects.
>
> Is there a way of inferring/influencing the numbering that gets used in
> the `/sys/devices/LNXSYSTM:00/LNXSYBUS:00/AMDI0010:00/` paths that
> appear when the devices get instantiated?

Hello,

if all you want is a way of attaching a label to an ACPI device, then maybe you could
implement the _STR or _MLS ACPI method for the device in question, see
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html
for details.

Armin Wolf

> Thanks,
> Chris

