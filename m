Return-Path: <linux-acpi+bounces-18129-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F5BFE554
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 23:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAFA3A2A06
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 21:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE73301027;
	Wed, 22 Oct 2025 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qYP0kvWR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26688301486;
	Wed, 22 Oct 2025 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761169315; cv=none; b=ppyCYoGSfadAJzkUW/zlfetDqvHUGb8H2s04nH3ix2QZoPb+bOu75wNWuCaV2dS1BXTMmWFy7OaARkr4/ebCq5tnHEis64kHdulxRVP+tucaficApyAkrQqxft+VDGin6Mh8krmNXsKxKdtIJhcLd414SO5C73oZwRNtcW9kYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761169315; c=relaxed/simple;
	bh=p/mAYt43J0W6iqg63P0K25fa940k8v1dIFzHLOIhXJY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KMiVIfQQPJL6FdqtaVf7VwHyaoN08haRRxHelIxXpHkr917JVw21GGPX5SA174tTUwPHlMxJYyv5pkAl0TltbPPdeG9T3J1keRqTpu+0pv04v+Qoa+1gjP8AIuz/m8SZRLFB7BlnivZmOA0fPIHLHW4dzt8pbVPuXxLjdP4nA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qYP0kvWR; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761169305; x=1761774105; i=w_armin@gmx.de;
	bh=0A2xiVitmtPNzCKvmEya6TA8pQzQ8Q65w4mjQ+YGMNk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qYP0kvWR0HsJ522LPbI2crmGLSlmzGX+UZDwRK0INpRFOXqS7WP8ZSWYD01R3nEu
	 yFxS9JVg4U1aNwBkRrmRp0V0uXTSL4+iWZ7WV95IsdG4lkO0Es37lJUqxoXIwu9gQ
	 Mi5G34DFRb3BsARA2anSpYYL5tamiO4cEHbdKVS491ZxsLS0mEZSMLULB29IzEHbQ
	 aHAb5Daa4WUgjEr1w9wEr5gMsM00TrvUYE/Qt1VQLaYWhnfAAio3uzjgPbIk24ggF
	 noOqAzlDJRM7CLw8x+cVVDEB31HqHJ3UNTIAcwalZh7lThPDqAcj54ckSfh1j9PHb
	 /KYhiJNOUkPAvGhTBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Mj-1uctfW1I15-00dtSb; Wed, 22
 Oct 2025 23:41:45 +0200
Message-ID: <ec099f39-89a2-46ee-a10c-1350ecf7fc83@gmx.de>
Date: Wed, 22 Oct 2025 23:41:44 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] ACPI fan _DSM support
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251007234149.2769-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20251007234149.2769-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+0/bPmpeNKAh/1P46KpapQx4KSU49BLsflC3V18GstLnmW9ALMN
 wirJDyyptLOwiycbZ6vIuOWg2xILDTJcX1dPs4IJt2nHM1K2ewO4KX9NEeKMVLB5pN8FcxS
 bBjxzTAkWa/340SWBPJEdoIX2ElrR9twXt97EnV2iLp1GQqwH/50E3DIFtyzbigdurOVLoI
 o1BoGlJa8/+rsJmAO8RHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9M/O/dwkGHw=;dzRwNA1RfgDx+kHBhHpmm8xNUOz
 64eBPPXGL2CI5XoSInGN56J8EJnnwllEnFaUKl8zQyyzWKAwZo8Ut1Rwf3DtnwC+h098yViRS
 cE5wn095A+PdSvTYElqfHYj+w06/4+XSoAfcTKWCrwVogz7w8TPHfSE8AFDNpGHKdIKA/74Wy
 x+riBZB71mv0lhHd7YRsvWTdGv2kwS3WVGrdlRc8clRz7Fk+Bu68uaCJKdb7pAnXtmZPq+gVl
 F9m0VAnzPMWy2QYtgCFvrsEq9/u2G5P9wZT/aVtws4M4qxbcKe54UfXCBj0S0uhQ7Vxsiremx
 OzAkpfzCNzSkNn/sxUS/VQoT20ubcPToCoaeHhP3xOeRm063lMUIxOIqQDWwaAmTUEr61N7Vk
 ZoK+jRzD9ivR1uOfJXUlG2L4Ijd+KBeEb4LOSZTbJexcoFu0hy5cBRJThFOZdgJVBO0I40AoT
 Vaa6AWxnGxMRMZgVSCMGE1ioXaJIrWRB68cNMsjGsG+8/5DV5+GEDCXtQakfA0RXne7Xe8FCv
 q4n5oH+IlL4cSsbSUL8kvmfZTDjyq0nPpVFYimB3xBeYv6qCuW85TQJirXYa05haMsYBx1HjV
 oG6LqHlBPbFhcxZkRfmNad2f/Qnxz3QzN0G9/VWnx8zCr5vCvmtP7XlSMJIN3MGmqNKmcRAjZ
 0MfVrNTHvgRtudgoP+MALIEKZTpXrIsiHjPit697sTzmjKit+SIcXNbMm9QmIG1Pd30sPSVob
 ujv0Xq1ow74SYDtG7/y1tq1GiC81xeXUMd8DOBzqDBsVJ1P2MvnobS/kRdw51NvNpGm9X6Cgu
 Jp+sf/lac6vIeZFhy6cHlRW1xlNxC1UvpHCo4cx9lnJEpmwd9+IW5hGoalsnPPcIuq/ExkVQG
 WTOrWiExZgywFw6iuYuhlKyN4J4OMDkLpZfrwjFYN0mcCYQjLlJfuT8r8sIyiG8VD+wI1ie01
 a4hsMcMaa/lSF5NUgmfQ1czEJzLLkWhlNMoPlPGpymcSBWmV2ZBn9T9up3CVXfGv0EDizh856
 Zfqds2wCZebU+Eyhj/E94hnUdj8Zyg8H0rJ1/onHIcWTmCJEA9hGICcC6d5kR+PuPjUGhpbpE
 ZWnNlLRmrn1LD2JC3oTF7yDj8bTZWbU2n5EV5FEdyTsMXYCMBnx1mCE6kfENPbTcQ1r2FhXPG
 oH3lnpc6Gt/JHtk0b4ty/MRFu66uhFQBdvOGhO8wQCtmYxytx1+lFv6ebW/UArSYx2ZeXBfQE
 UvgDy87pR5WTXAGFN7uhfnjRuyO3U+POfhFtsrjpYYezdNtMLAnA9ga/cnX6lntTi+8yQ/ZYq
 ReXwBSDkJQqwcS692ifyy6sXYkOUBcA3hRamcOKeZiis8rGh9cROTTgMEYaSExMyszPaOGrMM
 +L1GjjQkDssgiH6QcOqEuvvKAxZI9wsjwp5fct/io6+NW6YmqB4ukqivTztlyNXppS7zPLVtc
 T+KpKdKnf2LNmxjXmxwfCY+JV0cRBf01kI+ULH67x81sdvpiIjxOhrHGHehqATnE7SoBFxIU9
 xy0B6B+mNzMztSDnM4zYqSzMiCs/ZqXREWjp1ANfJMMUF5+Q/IlWlfWjJPf4YI4386nNpotGF
 X/d3WgDm2HiKiYZUs9lhcnzsg5sLbQJp8GZzX9raFahbDMFBH4oWuah0doyWHb48FC/yNBMRu
 ZI5s/JPNjoCwKYNfoA/av18rtY4i5n+jVGwTtRo9hZ91uab25vwBlJXqyhsgJEldu3pDYZCG4
 /Muf/rSVhx6sKm4FNQjHNSSU5j9cmTRMAyeCnxkis1hgGjJFk7ISJviRImIrjrmkGMqAP1RMx
 z7XxCcbVYtJvKHzBytGoZnGpY2naq/0HhXdqc4ybC4v9ZbU6B50Z0S/BTZPtBYTmEBovtboJp
 W0QkVVl4DhKYPNnYGjE16Nl7Lvjc9YW39BIfEHGz6gDIWWT+r2L6my86Qna7mwGKd1yDTpbdE
 m0Z/JNcsc5gJVfgw3tXaHZmxzBlxP5GG/zYrV1FFDhaG+8V/1IQdhdeTp1okNWSTOW/ZyMuWg
 dPI5pGJIl1BjymVV6zyv9kyrTrJi/Gj5bu8KSGC5mR7FBnhW6N79dmYVyrvlEwj47+WcoF/mw
 HORHU77+TBaESTczClg+pwcHxZszMorK7Vp1d4FX3lBe5oggBUeaGDy+0W/Uzv9E44Kcxs80d
 E6yeceBhrX/m2s/euhfJvECQNGWRIxe6I2s5dVzGUuStvSX7LDHcrE/lhtZHU3Iz32Xji2bMZ
 BTRxRoTFXZ4WXw6yRulPgj1Obrsdvi9VKfUfzkLiuJdpNPQ2MjEtQn/wRDXBANuDgIbrK0Z5d
 0gGQqLZB6k/ybQbmPN6mDRpU6XKZuINoLov56igkxAKaX4VVPHwWqSAL1nKSO2F+ykF/6DeQ2
 gqUTim7eHi9oyz3+blAyOBVxjdHq5o6JNyZEvzTZ0RtTBE5OJ3wkleaW5hGzXjomzWukRxeUS
 Tc62X9FmSsu7COif3JihV1JCNkq6ZXuKUFE50gaZLMBz8q+Tg8EaGgwXdPVm8Kk00wmEwDsGH
 gF1+u9VG0pSk6h8AoMBVpgK+lm8hIZlJ/4O0pwSg52dfqU7kbOxVxnUrnquOp3qdDFijFFkYe
 4zSA78oUkYAUPbW9zWYSGXZGeNcq7E8/lkMa42GTZTsKAK3Aokv9JsxOuiabupcU4USV21fo9
 crkSPXiMAc8bV3q5xfF8xd/+PgIqHvfD4X53e/pDCEW7PhWHDne34ip9LejIZ1VvYhkUzulWr
 1thvTOyevmR9RxITKNZVRr8MhlzE+LkhAbHGvqQkzU12PmgE1d6whOM8WslTd9ogri++UkHVB
 pmEg2tyFdV1nC27bd7y0OXvKokQssVCAgjCCIzA9Z8+aZUBxVcU++eXXOduXqYVvZa9/DPb8Z
 H2qM4cvZraXK2V/18a1MfQhGfMNGsrN+41vpI9J4ILAEVdB190VMopI3UIH0L+80iEYbbkOFU
 2oDrNxCw+QvBmdTSOBclfh5zHc3JOtzy9UseY/ur7NUcORTcyNPAruc/UbA3mKgI9cKt5hUgc
 +tXkU5GL4841g9822Nxh0/0p55gFeXWNNVZWZTi9ME6JHYq7QJ0qzGq6mXFh3rJeoPwP7aC79
 f2N+0UkJzh48218yFIv9MJWbZfS3K9l+FzWzORAIvgxCQafXtfZNKFNGOJgWQi8n2hz55nJGn
 K0xVILa/xmcAZEJ3O19vUySU0aN+Y1nGRqz8APxV1px0VGGqbGD61QesGlAe9o+YMUTt2lCe6
 4e8r/GMeUcXMXFzZGIxKo+H4JhyXIUUv8LUOFXMuCaT48/f50Lgdn74zbIm8hrzZs5sQdAu7t
 BvwPknwOqpgJcYExEWPAtnmE3Ba2X1jFMGgZJYZEek4rgLuJkXE5Q4zr+a/WneuJJwcdKMn7A
 zBjOyICYp6q4amPL0y8qp7Xd6vlR+zM8j0OYSLzz8fSfIgtFaj24N0Ef2rNFLH0Mag6Go1h78
 6pj8VUbjl1mZRlDkmLcXfY3jyf3l0drmHgPgCKFZZVSheHiWXh9nZgZC0tKP4bV93k4oPi1nE
 Ygr656uQwTwGjGpyBHOb7+9l2WsoDXSL7+uBjZPxFWA8phbLUq+sCorzJsgwXDzYfzEnMIWm2
 nRongylpArSf3HSI/UxrgWuREaKU6qYbvKssakit4bpFFrZTybZ2qbfVd51m8cUF3+YyR517k
 FIQYlYQlwMIVac9UyczCDUvhOrqV4TL8Y/JnOSNZhsbaxNPciBog2/9X1EaV3SbIvQ5ufw+9V
 KX3CYzqPl2W4H5PPF7AVB9GlyhAJOQl+mRKCFVTpkUgNgeCXLk7tGml7+Fy1778y8k1ss1WuA
 j46/92pUpPXfTbhDUjV7eFicyheovvDWePwWltfLlCptSZfX3FcPHwF7QTf/yRXJcHfhqUNeM
 3pWh8xQ0Owhbj5FGPeLKxJdd0h7FvXN6jIM/o5clHwofHAhQD/dUlsk4NgcgBBHF/pt5Fdu/Y
 xEV0L5oIvf6GjSAZHD/PSFm0XS/KMx/KtxkEb5VY/NgNQz51Jz04CR9lEAhZv/+wTbH6M/BW0
 2QBa63AWkvZ9Q5ina/LbCUnMYrEQu85KUPkUmP8XLRSiRD7cOszkKYAsQvOX6w0996nGqdvsu
 sDXu8w46mOpQaS/PQJct2dFdwIdxiiCsniNWXDdCerNsCa+RbvYh3FNRU6xsRU7oSDAj8AfcF
 3BerYXD7lQqioH1TbKwZxDhRZqD/dcWbB1TyKGt7kjeDKgaLfonOwOXNW0DTjUWIyT/PFU97/
 zLO0DFfb3TkPrj1DxcqpIcnoNniXzrzWv0rjKrLUJnpg6xauOey5KrhcLdiouOY84VTE2W88z
 /hVbbtYjdb9CTFH5+BeRY76XtyWev6Pt4rThikPGCLz4q7Va1vIyZipBdNF/76+adKKylpIrB
 7R7FrrrfgxtYEwjt2Gc0i84Ln7U1BxA0DzmGrgdJwlXXfz/JzwNNxNzJRwpv9swn5G+v3zBvz
 9Sempu+IFTLM9RBG2iLnccazpvdTOyFXMhDIWKLlWJJBXmKj2tjH1MhTLjSfxznh8s+V+O2ii
 Rq4RgRVnhf2ie9UTtT19+zYtjK6R14hn8JsOuhsZKuaovwcyReqhhzxnKFSguyGn3jctG95gQ
 f6HH7m7FkjrDPaPf17sHwRECQtZjMbsig7xvr49gzMfgCO6L35Nv9vvAEObray3CTMHDRbsts
 0aCaTuHJWhbrEzSA+BRyg4lxhqTVliAah4fIgQcJPUaHbJbP04dKOIyJCrrvjzkwijqPv2GjV
 patNxXxBrACH4TuOWhlR22+lHdfKBK+AaUw0uqrzHk1be8HEffh5dRiddwyM2uPSwxMdNyb8i
 gRN0ZQPmR+LziH/UdYBSeXR7ViGTV+F0winbe0KfN6v7maUtDKFn9PSWemVwERvthxucgAv4G
 g

Am 08.10.25 um 01:41 schrieb Armin Wolf:

> Microsoft has designed a _DSM interface for the ACPI fan device [1]
> that allows the OS to set fan speed trip points. The ACPI firmware
> will notify the ACPI fan device when said trip points are triggered.
>
> Unfortunately some device manufacturers (like HP) blindly assume that
> the OS will use this _DSM interface and thus only update the fan speed
> value returned by the _FST control method when sending a notification
> to the ACPI fan device. This results in stale fan speed values being
> reported by the ACPI fan driver [2].
>
> The first patch performs a simple cleanup in order to reduce the usage
> of the acpi_device struct. The second patch fixes an issue with some
> 64-bit ACPI implementations where an invalid value was reported
> instead of the standard ACPI placeholder value (0xFFFFFFFF). The third
> patch fixes an unrelated issue inside the hwmon support code while the
> next two patches add support for the ACPI fan notifications as
> specified in ACPI 11.2.3. The last patch finally adds support for the
> Microsoft _DSM interface.
>
> All patches where tested with a custom SSDT [3] and the acpi_call [4]
> kernel module and appear to work just fine.

Any thought on this? I tested it with a custom SSDT, so i can prove that
those patches work.

Thanks,
Armin Wolf

> [1] https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/design-guide
> [2] https://github.com/lm-sensors/lm-sensors/issues/506
> [3] https://github.com/Wer-Wolf/acpi-fan-ssdt/blob/master/ssdt-dsm.asl
> [4] https://github.com/nix-community/acpi_call
>
> Changes since v1:
> - use acpi_evaluate_dsm_typed() during _DSM initialization
> - send ACPI netlink event when after handling a ACPI notification
>
> Armin Wolf (6):
>    ACPI: fan: Use ACPI handle when retrieving _FST
>    ACPI: fan: Workaround for 64-bit firmware bug
>    ACPI: fan: Use platform device for devres-related actions
>    ACPI: fan: Add basic notification support
>    ACPI: fan: Add hwmon notification support
>    ACPI: fan: Add support for Microsoft fan extensions
>
>   drivers/acpi/fan.h       |  47 +++++++-
>   drivers/acpi/fan_attr.c  |   2 +-
>   drivers/acpi/fan_core.c  | 254 ++++++++++++++++++++++++++++++++++++---
>   drivers/acpi/fan_hwmon.c |  32 ++---
>   4 files changed, 302 insertions(+), 33 deletions(-)
>

