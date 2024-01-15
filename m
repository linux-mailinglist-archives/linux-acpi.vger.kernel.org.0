Return-Path: <linux-acpi+bounces-2863-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F582DE17
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 18:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752151F2250E
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325D317C67;
	Mon, 15 Jan 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="PWkwHeXw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB317C61
	for <linux-acpi@vger.kernel.org>; Mon, 15 Jan 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705338015; x=1705942815; i=w_armin@gmx.de;
	bh=RrXFuJTd9CKoDZa4MCv9a84/horjRj8qbjEmykYkj+Q=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=PWkwHeXwl0+eVVx82Vpz5fUwcYpfQwfmd82n71wyX9hNAIeXbgZJaoJu1n+sD9Kg
	 Xe38VFSIohDKtZ80GaWeasQouJox9EsPExQLD5I2GabbQeu6RJ2ScMxvFGdFPLLu+
	 khdv0t2gsW/HUzXzyxN3FW9E/SonN1vpJhsTTpDQKogwFqGrMqCAQ7ret1hHjdDwj
	 FejTjJrS32ZfrXGy6BNkQh/J5wxZGr8H21eRI/O5l2AIvDKUEm6NO0l5yLLqqjgvY
	 OSDM96g1jtrCz32L6KAmsjTxfE3w8kG4ftKog5yflyccRuxZaynQZJNIkbTTuWN2S
	 iZoW7cn8v3L7eYbU7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzyJ-1qrkG00gON-00dal7; Mon, 15
 Jan 2024 18:00:15 +0100
Message-ID: <138c98d9-6a00-4b26-bdea-c7ac3cd3e94d@gmx.de>
Date: Mon, 15 Jan 2024 18:00:13 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI INT340E PTID device
To: "Zhang, Rui" <rui.zhang@intel.com>, "rafael@kernel.org"
 <rafael@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 srinivas.pandruvada@linux.intel.com
References: <14c6f480-66f4-4683-92d6-55a58eb98585@gmx.de>
 <fec103c301df89c630d894d7c1f6db6f7ccea540.camel@intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <fec103c301df89c630d894d7c1f6db6f7ccea540.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9pzsLIbHpRm/+kvkodUsvzlosAFN7WJ1kECkaev30ZQF70nzR7E
 i0prSjWPooPdVtk/oJlf1pxvSalYNG3Q+8IJ0BXzHvBIbASRVGzoQdlwjSAPYhun7KSXepM
 bNvWbHYsL/DYrVk+6r46UVNN9XY8mGZoaVhQNC8qcHAjrpczHk93TzfAURBlVekX+fK5D0l
 LHph31T+RTY/GxpgRpvIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NvB4/BZGAqw=;zn+RgqZb1N1gO+VE2vn5fo/6ArD
 CQ+vPz6gEjxMuBrb1lMCIxbwteJ0ZPjhGkVNNyK9PDoFV0ABoKgXN7DHM93ov9498ZEBtPkvA
 4hMS/oQCuD7BsfagzWx5jG3KDjQLKi3ViPzurhCUj3GQLhccXBWwDqweEVQUeaHRK203iVaid
 YaYqRv+NJlRD2m0gXFDDmW7Kc5P/8FWQNMBC7rYP9/QzFcr5QOgPP6o0guIdLmW+OwWXBZ/Zn
 4Zt+wo4a+aw2zSJOyu4/r67zYWp9dVAaJIA7/SGRA8sTp/5LZKB4kYVYh199XXM9OYtnmWA0b
 22/F4sdHV+8ME1klKUwaKeHM+xsUu8uv4+2/Rh+5ywxOD873BgqPAa4zCjtbHnwcKIBxpCnoB
 oJ+9LHoFjyFMGEZru0zJl0GTekEt2N6Ez/XmTZcxxkjRwbqzqGceFaMLN43rPidp/AySMhtpQ
 JJ37zdXVP27vPWftdzMO7g6QyQJElRdMsDUVUoDGui9HWT14NpzM+hA/LJN/40+bNOZLPoyRV
 lEovXgL3zfAZPy+AYQCwrhoLZeAm/PTKNsCcx4Su2LVELPc8d8jmaMAv2Olg731H6DNy24HKz
 6E/Zlr+CkoXMyxjbGV6h6n80HVWjZPC+L3b9od4sotFtKtakHvcHl3wAQ4ZH0E+0uhRkgoPk8
 cCIZWNrgsz05MzNFbx06CdOqzfSvved1DKm3Va1Efw3mWAkitfXxAkxi02kmFRm/dc8gikZUF
 VyRvK7Tk9sQRosp86nOyhV+R0XoYNCv1u/mLrXrlg4UWyu3kz2urIxB6X0lgYAO/nWTpdrkce
 pH1LjEzjaJ+39Kg0gv4K9J0TAI/x3QgS7ztMTqblyVhlgwSmOmViCHU0a/oMRQavwV0QblYrC
 oJxQlPDC3775SI2/THxt7D+zg5zoYb4R19a4tcBWqcToNn/TF0LtWpVb7cZxP8wvFgz0hL823
 CbXAjskDcdrn3IfMyleljhnAClo=

Am 15.01.24 um 15:13 schrieb Zhang, Rui:

> Hi,
>
> On Sun, 2024-01-14 at 13:42 +0100, Armin Wolf wrote:
>> Hello,
>>
>> a user has asked if the ACPI INT340E device could be supported.
> What does this device bring to the user?

He wants to be able to monitor the fan speed on his MSI GF63-12VF, see
https://github.com/lm-sensors/lm-sensors/issues/475 for details.

>>   Its seems that this device exposes
>> thermal and power sensors to the operating system, plus some general
>> purpose "OSD" sensors.
> Hmm, I don't know what this device really means. At least it is not
> related with the other INT340X devices.
>
>> The device is already supported by the Hackintosh community, see
>> here:
>> https://github.com/RehabMan/OS-X-FakeSMC-kozlek/blob/master/ACPISensors=
/PTIDSensors.cpp
>>
>> Back in 2014, the INT340E device was mentioned in message
>> "1408622934.3315.8.camel@rzhang1-toshiba" as:
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0The PTID device has _C=
ID PNP0C02, but it is also represents
>> an
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INT340E device, there =
is a platform bus driver for this
>> device
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0which will be introduc=
ed by myself soon.
> Interesting, I cannot recall what happened, maybe that device ID is
> deprecated later.
>
> CC srinivas, and we will make clear what it does before doing anything.

Thanks,

it would be helpful if Intel could provide some documentation on how to us=
e this
device (ACPI control methods, etc).

Armin Wolf

> thanks,
> rui

