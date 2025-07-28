Return-Path: <linux-acpi+bounces-15392-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8696B1443A
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 00:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80AE171BB6
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 22:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072C212B2F;
	Mon, 28 Jul 2025 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="PzCZPpmr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18F51A76DE;
	Mon, 28 Jul 2025 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753740812; cv=none; b=cWEq2Bs81orMvnfom3OOHR6hVHE+NirfCKbzNd3zkEzxZBBpaGkOJHHV2F8UXiuDUQ3VH6V0/AATNGzg45j0CoeEsefRQzLTwm/WSnkHc4JwvRQ8DSxaF+mbJO0j0yoK31goPEUZy0Qa/ThLToQJ7SI8ooWgiEJkDqABEqvRA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753740812; c=relaxed/simple;
	bh=/TLuZ3CPSQL3Qo/GcI7XH17VsD7QZtZ6rwFQgREGAAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFSXuHwORtER6Hj2cRXYiRHUCALb8w6dS24ggtfLP9xof6mKz7ldAJHon4OHqwZAP/ixf61jMZm+hNhlTCkoN4Xs07Y64TVeX7t2bx8CD+i/w4EdVoCfvJ1ltFJv8HlGRqnTP6+ZdNKGR1HilUfepT8vsxm6XlSghrgNoN5DHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=PzCZPpmr; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753740808; x=1754345608; i=w_armin@gmx.de;
	bh=/TLuZ3CPSQL3Qo/GcI7XH17VsD7QZtZ6rwFQgREGAAI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PzCZPpmrujBTB7xLToUJ/kr6kAgWiPf+L2OJ8Lj5CGWZUG1tNPvPa+igA2R8r8Ou
	 nQnrPtKk20m8LtrYX0g+l0PjULyXTQtSz8URSUjST6qrhkBnVuAcMFujtA+jGGgLB
	 9P1o/D8oD8LQpkRAaTzYno7+nsXIIrMKVa//Q9u/qc7UCexSC3ZMS524so9wgDLtK
	 ovAyS5NHPfzvGNA0cCWZs5TAwVewyHzb8h9Eokk5sQrYiUZ1T+hwOGIF48XWbNxfK
	 PzzWMPStFmfGPNrVIJWjuvy9Qpu2Bupaf0QndZ002tMCOqtwaujPfvT7eDMPW+pvd
	 yHZq2M/KEHulXkzM6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlXA-1uEI5p2u7a-00hZmb; Tue, 29
 Jul 2025 00:13:27 +0200
Message-ID: <4e0de0c3-395d-4e70-816c-72a8e75eff8f@gmx.de>
Date: Tue, 29 Jul 2025 00:13:26 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Ignore ECDT tables with an invalid ID string
To: Ilya K <me@0upti.me>, rafael@kernel.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, glpnk@proton.me
References: <CAJZ5v0iWS=tHAuauHNHb+N9_GjJTX2-RY01eAS8-sjS_2UZaoA@mail.gmail.com>
 <9323b4ab-f2c2-41ec-be0e-779d327205ca@0upti.me>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <9323b4ab-f2c2-41ec-be0e-779d327205ca@0upti.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+GDBuVF9BzM3jkyAE12QsXdRzbqNwcHw8WFnWAIpp6zbs9L0ouY
 007iKBw8rix4WrBQfCIHNaLF3LHpdvlKsReTt6k16+dRjYZ/2O6acYqLNfLixV2ZJeXFjst
 aEj8rYNQ/plohMidCIeYD3hW/xxGPnDprY5LHtf03My29BL1C9A4PmVhYdUefQ+KUO8wJqv
 OTbXIG7JmCVGnAHgzusQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k7l9fI4b9+w=;PZFynOMJDoKgsxUKHVR8agNyO5C
 IoO+KXszb8a1+Y7Kxx/dElJQRzpALUTGY96MwPJr9mU5Gh3j1/2lgqo75Zi65xpG3PlRgJRig
 7j7ipY5K5eOy5sLtaUR8pM3+QOwrC5lFpWrZ8iHN1q9XLoT5d0CZBrP3SqallUnKSS8m8huzQ
 dsn1B/f8txSppGLqXcPiabcWTeXJiiwAjPTuQ/BlatQoieNkwl2rUMkCet+fXhcFDU6SJCCNb
 qlGvw/T+jI1r/j/b6m3wZbcVO+sfMJNor1ryhufib+D2fK+mgd2J2/BZAVPvSLp7CZSkknJ4d
 NBjkdbfe2gZev0tWJLkQz62zB4f7DOLpOl7P06XfgF97i7h5laN0tY0WOMLlmWzP6T4JsDiDt
 Fk9bd5tSX+qnYeE/HjSmsRkqBL10crAUcV2cBCoaZQHYagIbk8kLU5YKz+8DrxtqBhAXbq5m/
 Vpoz7IOMXIVCfJ8FpG2HfdoqSrPhfxRc8TaRgSjjn6x4R/bPr+l2jR6CBS6nLXu97F8U97J/I
 PG4ZG1wM+g/4h4w0c+ss6NIFATQyQGrNgY3i7iizHn/T2RSqrch+b/VSL5O0hsHPLaUkzuWPs
 wctI4+baGQk9BahfKT8m0UDtEn4yOsiVzqUiGoTA6Ry/Z1xTQgZSFvEVb95d503KTnNdgZNEU
 5Bd/siKLIg3vOGqDNsVLsRNJKadDRlYlJacvc1gLG9X6ogkJ47LaUAT+FiUuv68iqVti/17E7
 VmnJZuywFlKnENW3hOumrL6iJBrAQBHP+DT3VqpzLrpz17Fy99XVQoCm67cB/hJpro7FLD7rF
 kWReJy1uB5jmNvDC7LKUT9Rjwc/N3jnoQBSAlJ5VX2Esad7YIFOixwWee7QBLCMSO/4Mc+T5L
 1jLpt2oUvetRZNX8LJrnLa5maiQcWxC7mTbJtE1oiMg5klbB2zD9yg6SNbHUZ5r8PfHHHVKM9
 AINuz3+GO8NXlxLGfKO9z0D1SIl1kMISpz6Q8D1BHcdhvVTfmGLQuyo76YzqG6tkyG++WZBdl
 Cu8COxQkwBE23G7IPgLttaUSwY94Ofvp00YRi5Puc9V7nGDf0Mql3lHL8gpX8wVrdrwmfpWCX
 4osxZwR8OkiQPEVoEbxQoaF5dJz1gg4uOedvofSZMFmw6SsAus9LuiiPh30ZKBpJiaqbpY3An
 rKcQqEfD4as0vIhVoAAjHdEl5Gd32La1S+paxjtKxoT7Rs4vPtNIofVIqjEyG21WIVYzg0jig
 3asxT7vrv6w7xRzJ4zsd8fgyipHZuIkuDVn3juJhaV3jR/4xcCnrViylePqbBs0oXxh5WnBsE
 OOxHBVpSBV6/iDlkVxikSIqsGIMzNfy9AAPAar5sojrS81z6vzrStuz+RMfeHV94HGdOW80CP
 zV2RxK1t0nJ4W0j+B8D4EZ82k/+6R4Xh0kSV6N8lK6dVSmIiRMGsY8bbKpLgZ7VBPYsFDJUOo
 tBw8dZGMdTpBxQ63/zXUUj92ODRIUMfADgBO5jUCLIkhqrEB3oin4Ngu/xtlMWzyM1ITiXyNM
 HXVGYjMVVdy//fxFRabhds2WFAL9oARp9DsX1uk++sYtJ6w79fUUophbzqZ0t8E2JCh6w8LGO
 bO2ELl3JrivJSkWyB/cCK45qXNOa+Wqnt+bdlp97I0Shyh1K2KXAnUJrnmyIxXPiZhy21vB3Y
 DinE7/up3OG4LEr07I66eSD9h6tW0U9QRm39GGOYuXkGPYs4VIlrhGvh2+vhQfCDNrewQM4MW
 g4mMw1NY3krexvNgVvbmuuECa74yfcCOykmjZBFBqfVoGYAXnqTnJco8aKhjzo4kJbEHIZpb9
 9eNYOCFoTSUBQ56WiS24hRNEJgBAqbGmFEmNj3JclMKU7nmEarSVnY9igA0MOvgRYHEcnjeSg
 l4NwjOnPBONCE2iWX3OpCknaIoRou/j6lO4V0BmwZbko186sMTETkIscyLhYD8OlqOTFtqdCB
 j9qpQqUbKA/4C8oSBDh+wtLC31UWhJ3xrDRwFux33UCTii0qSqkm2c95/yo92v0WS3aAhUGgR
 Sz+qyXcZGbhVbUtP78JKfbF/VEU/ACtgnuOvbf1Bvilf4+3UVC18KahEIT+fN2CxTwxtoprqW
 MxJk65hQJA/9NvfJdPeCQV1rUHmh0eojkaY0urpN0ZfKfrprZ0zVLWpqlBdpv2jinOoQjgwYE
 scOW/+dXEgo69geYGeBkOPX23oSyNIk7xyoj0XThXEw4HUG2lJRu9oK0dvT/lfnYHtTbzQvZC
 g219ADKl8OrZQF6G+iCiTnkdmRABoMwvnvuri3MlRgDnRs4P3UZ3je0n/9t5YedfkkndFeNs7
 5n5OrDR6VfYizobSNVVmZd1XPbbBdF82ZqGLs5spe+/RREOAJSR4q4IZh17XJjjyczb1jjiNM
 grQoFdqzgvaL9mynU24Z1pxmjs5uX52wB4ObuLYFv7DRZvrNJAce9SQE40lgnhknJGzT8Q206
 KtEUG/AIgssx9kI3pv96VWlKhulsm1XGN8jzYrU8QQjbiyiymzPq0pND7Ho48u+ZGGK8pp7Bv
 tvjxzMCuU/SESFDm2Z9rGrNE6fU7i2AFt1b2NgphaL/GCHxkm4AkCtytP0CB3wUa5ZNS3GxJI
 DwVVrKuh5V4pcDrsoP9JlKoEuh7ZQwsmWVDLlnAjwHtpS+SvZwxO7VOPq3CcZpnZmA/fKtf+D
 qD0FNQPXeDd+Md/IcTb07scbDRfENVLu9+DWsMZOSMxeKWP6uiuMR+nz5T1xcIYcPYs9Svavc
 z2Ilhj6B2+H01djUuQLoskx0ipNdwpOyhwUqpgrmXUbdF/j7EBPXTu2zWrW7FRqXGap/Cwq36
 06hMGoNfC5EWHv76Q0iax8AHiidGsa3BKIjzBTgF70bk2eKAia0xv5+mUcUMzaxKjh1Ao+z3o
 plnrfDuxSC/jzJ05Oc6tIyTzNS4g/BjvS+w1A+KJzNxb94iPqCiyi1vXK+4LIdn3nI6bv8kXV
 WtHXDb0KSu09jcT4B0FX58lUXe6iaD5V/BMpSBFL+/uhOOMmQFUkl4x5xxkfJjUxiVrDK9EZu
 dnnScJUU2FIIoDQnXrmtpteuXUn/98BcLHhZkA3U4OcFfieTPYqB5l9l/CU0b9p3Bb+hp5BTf
 zqBGA6WNoODQgF7b9+nKd9inpy85Fmm0J4dLrioBf80WSp7EwFdbE0XVnGnYUDZgSh+K+Wcgv
 mrcVyCTuFxgrk0F8iSp3RfYel4O4gSJQS8uJVLLEppCF2M/ltCnaZAPLeeh6/+c6KpUtruL2c
 XhM/dAm+cKUkVFOKjKdDNg7FZ4GyJQvECETq2XR0oTmCUqwhDMOco3fOhDny8jwO9xiAthYyF
 Acfw5O3A2nEbypnNHeHqf2YJWtZ3/Md7znmJNxp2Ph8uGH+HSt+3ye9lxHvKosgwl01fS3qUZ
 Kynkq8xYxOONb0VcuY85iTKKATSactrCXWjCEf3dFFUWO4kxuE0XzYvSAXeIMDxlfjHFAgI3Q
 nl+9ppRb7t/dikCmEyNnJ4+QcXSNjZQo=

Am 28.07.25 um 11:57 schrieb Ilya K:

> Hello folks!
>
> It looks like this change makes the touchpad stop being detected entirely on my ThinkBook 14 G7 IML[0].
>
> The kernel log says: > ACPI: EC: [Firmware Bug]: Ignoring ECDT due to invalid ID string "_SB.PC00.LPCB.EC0"
> Which looks technically invalid, but also probably important? :)
>
> Reverting the change makes things work again. I'm going to try a firmware update and pray to
> whatever dark gods are responsible for Lenovo firmware that they fixed their ACPI tables, but
> that requires getting Windows on the machine, so it'll take a bit.
>
> [0]: https://psref.lenovo.com/Product/ThinkBook/ThinkBook_14_G7_IML
>
> (resend -glpnk because my mail server is a shit)

Oh no, that sounds horrible :(

Can you share the output of "acpidump" once the system is running the latest firmware? If a BIOS update
does not solve the issue then we could give the ID string check a more leeway so that only empty strings
are considered invalid.

P.S: You could try if the BIOS update tool also works using Windows PE (https://wiki.archlinux.org/title/Windows_PE).
I used this method a couple of times on my notebook and it worked flawlessly.

Thanks,
Armin Wolf


