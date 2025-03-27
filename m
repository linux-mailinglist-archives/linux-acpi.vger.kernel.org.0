Return-Path: <linux-acpi+bounces-12500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5912A733B0
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 14:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23CB189D1E6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9892C217727;
	Thu, 27 Mar 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CyX9/jAw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5641C215F6C;
	Thu, 27 Mar 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083832; cv=none; b=nKUlAi/vc4LhMg2SmBDudn3nHhC9twwTt89ZebedgpjIrYJsi4bGJ6bBnPW67gt5Oj/1eUevwPBuPYa2ZChj7/mahekyFeBhBcjIK5KOck/WiY5/ZuPnng3FnySCIcBZnHtPMEZW0ewYjSFcu4uQqHyDdL6dzRCOAboWowxRu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083832; c=relaxed/simple;
	bh=mFRits8WggTts301wTs5k6NEDR+SL+UucND0fy8KaqY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=l6eJkYazWnm65RHBOkHrj9WTSAt0BJGvMV8wVyLnXv4kCOewCT1gQ21yb+DUN/p3VmosF7xJflhDx5E0TgQU81/BBmhUunCyukAQnu4Np4wB4CBcMRi/HX5VqswLqFEbSCxvteZL6haLooOXA6TFh3pNThDXbc0zasS2M56aRHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CyX9/jAw; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743083805; x=1743688605; i=markus.elfring@web.de;
	bh=mFRits8WggTts301wTs5k6NEDR+SL+UucND0fy8KaqY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CyX9/jAwabmdSmTRFkiEAJ8IqFkz2cZqDeo96zx02p4dZt8QX+sGqLCPi1UqO1Rb
	 RHi86c+a0g0PP+TOSNHCJ3OaYOz5fIMAgB2nCLeMmkEDsGWh4VxlNxFAerghg+s5d
	 //LUPGcPIs7sAZo1GY9tIronQJvM7tfegYDFIRBXW5oKyf8mn99HbM3qmhZWNDazX
	 q/6evhvM2VnTQolD1lnkNitPOXvdIYm0vk11ajMb7tzOfjeLUVyX/P1oPvHrFsDDC
	 Mt5uA84r/kiJWJd5IMbO3HA/doKKroDq+459+mFMzmjwcbONcXbTXKUB1OS/XkAyt
	 IN5Q7OaE4tNvb6Phvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Vop-1t2Poi2aQb-014Coe; Thu, 27
 Mar 2025 14:56:45 +0100
Message-ID: <1584e54b-8ab9-41b0-8cb3-19ba3abf10af@web.de>
Date: Thu, 27 Mar 2025 14:56:34 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Diogo Ivo <diogo.ivo@siemens.com>, linux-watchdog@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Benedikt Niedermayr <benedikt.niedermayr@siemens.com>,
 =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>,
 Jan Kiszka <jan.kiszka@siemens.com>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20250317-ivo-intel_oc_wdt-v3-1-32c396f4eefd@siemens.com>
Subject: Re: [PATCH v3 1/2] watchdog: Add driver for Intel OC WDT
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250317-ivo-intel_oc_wdt-v3-1-32c396f4eefd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EvYk3iEQ3sWosaeDcI95BtN761v7I9mE2oRYKhKPMSMUVaVcA6w
 tTtv7wriHMkqRkEOPpSGazBSM07laZ24CAHrlMS3LWHHLkv9BjuMNwn8oUYL9+0FQIwmH6y
 XUJ53ZIZI8ECtC13k8YdmldR0lxgtLJzLVDH8H4Rx7w2ZFsV/MW7B5n0fuZFhqDsVTG0d7V
 n3RV1pFdg2DjSmBe4KIYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C1o6m5ZQqxk=;wvb1Uga1pg7245soF5PzykCBPPS
 bq/RSJuYjN//gWz+UI8nz+XKuBl2oUQTxWj2ZzHx9X63NXtKSIlszXpoLalCTRYQfnohRS+Gu
 LwJY6Z9xKp3/tMsafLUZPRP/VT59b9LeEQ5NTVJwDGF9S6Gl3/rjzthal/g96LRlD/I+ZweI6
 DcCng4x//Y+a4X/Q4WYtJ8r3F1SNo1Dmg5CVli6qiLV/xb4qoT46XgDK70Ot21PXZCh4qxyZw
 6TsewjQQbOJ4becKpCMmkYMcW4Qjxtk0IgufuiMGNY9AXD12/gnO0y0ohIufiGwHX0F6wXFY6
 A0Y/zN8kWmmU93do8d00uI7azBj5PNVERCBQt4HJTTNgph/htgxmjxA/X9KX4+DLIW59b6sJS
 AkydvdF+LOJiuD2sj1EZ0Wo2I0gHPPnnFm+DlAou+J/i9/MetsHhioeF+M+LEBgO/+bt2njZ0
 p4S515Gy33hPSa/9PvEYX1QwTWlcoVJU+Maldbv0wagrdUzORJ0VGxXLueW4jyyRmB0qOK1Zk
 7gwqcb4qkN5McEn+oDd7ZuZVd9BuCuskJPU8HnUutIqpGD2OAywAMUzYJ5aMfgPX5SpPY+j9l
 xYmS4P7UpooMIK0YeU24nFHcLfiL0QhceRgdDuE2l86YFA5eF5iaTTdO4dj2qZXD/wqJly2et
 10qTnT7XL7S9jefK+1AM4Gh/Ep3xrB+FnXkxlFbbDh7N4cSQZ131hRtre/JM01gNt1O3IvC1A
 FjFJfTg88nZrpsbR8DXODW8fN3hHwQo0jbi9D8otUhfyaPqQR0aFpV1wgD521xVN8dDA6cEb5
 mgAVpg/Y2EmkVsGkzpeCUi53XoDTcd9eRZ3Fm5aeJCbt7iuhBFm9UmSJGu2dCvTsTHWLCDpoA
 ZPuOrTL+wPwKGSB7nPjyMfed3MU2cYPSgz9i+2IeGzTS90oHzlZB1LbvtHe6T4UeaX0eVw0Of
 U3TjfV47DlkUZ53kJURK4hRiM0TM3/0BzMg+1cFHtiScxnfgJz7H8Gain2lRzm9p1gtbIUH/3
 6D3U6x+qsfUinO73tN20bas+aj9YIcHg3/sIfJZxjZSzculgPIRlmxlOalEifGtfwSyHQiPw1
 XuEIKL14egiTTVvS0QeGTTM7xNjUIa3z0hr0n9GMsXdrIAQWdTft6YzAkfdgdCQmDN3UtlXNE
 63EkJIufrLMm6gCP+iaBSQ6MTJZkXy7y9z/gKImp66IdJmJtpxMeIXOFpuCBSj3Cm1aMUsxTk
 LS9fbqjiZrjhXHZBn/t0Q/0/VOFiv7A2i4FGoZFySHNK1fOBIocOOczWLsEoUNj4CuoqLsose
 uzQneEqlyCGa1cdx2Co5L9vfHVNjuSOqQjMcr7HOCJL8/9TRTIVDE+MQ+6Ej+tyecjX+qrlWI
 rnFFi6cFz4FMxhMgTT8gwjslMwKADQd23DBLccyDrFmJ/l+AH6UoJGrkx7hT0mZnnA2y4cMBb
 QtuiawgNuL5gcq+qAQHNQPEgZ8Bq0t0C/hkxrbeER30HwMKkG

> Add a driver for the Intel Over-Clocking Watchdog found in Intel
> Platform Controller (PCH) chipsets. This watchdog is controlled
=E2=80=A6

You may occasionally put more than 64 characters into text lines
of such a change description.

Regards,
Markus

