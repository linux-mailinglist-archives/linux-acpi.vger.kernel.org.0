Return-Path: <linux-acpi+bounces-9725-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E98029D5567
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 23:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611CEB23DC5
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 22:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E731ABEB0;
	Thu, 21 Nov 2024 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UCCrsNHy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AEB1CEAB8;
	Thu, 21 Nov 2024 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227985; cv=none; b=cr687irprtmt4Bt9ivQvyGN8x95o5SKYksybs0VWuLXLbkk2y8cjAg6jt0OHFFr752Vi5mmAJhgM7xubowN7xn8U6VNyOimo9ZAD3Exk80g+qrwdZPNwIWOOYfMMfrfI1b4i64u74gbD5lG1Lh3JUeY7Hj+04Raf1D/DCyn8Iyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227985; c=relaxed/simple;
	bh=EH/XAb2bLpcT2B2KyuREJ6qvtY0LOfPeILpQHOtsVU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPQy9sw9o+Ezi2GM5JRtev0Tbm+BZjVYkkx+CNhSXO/IruO5Gucg1C+AkR85HxmHsJyO30JWugE5c5cXFfDwB2e1rn09+d6VJgtiQhWCCMEJKXtReKr8fQx9JoJASWxDNDi9VwajBUd1zN4R64rxycNGG84Ct03cuCl57tMDJXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UCCrsNHy; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732227905; x=1732832705; i=w_armin@gmx.de;
	bh=EH/XAb2bLpcT2B2KyuREJ6qvtY0LOfPeILpQHOtsVU4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UCCrsNHyEL2RiOt098Z8FrvU/zcDw1K6E7Zm/F3tgqWhYXibUbXLhnbN16abWJWZ
	 vF9ZY6en2pPyus2Xxk65Gor9ffXANWJP33/4P8lPoAE54QPKjXiApahMtNc/sZhbS
	 BvL8WAhJIettkYZeMArFamSz+pK9TbG8nLwEzSQluVgAysFmNBabrmNFTQ8PZ8s4u
	 /yk4g7TwKy2Wgx3+j1snlrDdZ5viMi+9qLCb4utkEdXpPJxpnhv5UW6dleUE3gQkc
	 q2OO3/crHEaln2Ezd24DLkwVx27h8he23fvPweoJa5ESZmiK9IyFP9GTqEigvtZXl
	 P8B9IZP1LHDGy8yQRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.129.90] ([176.6.148.212]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95eJ-1tpnwk1CaN-014lXw; Thu, 21
 Nov 2024 23:25:05 +0100
Message-ID: <99c47bd4-02f4-46bc-a355-50a0ab1d8538@gmx.de>
Date: Thu, 21 Nov 2024 23:24:52 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/22] ACPI: platform_profile: Notify change events on
 register and unregister
To: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
 <20241119171739.77028-15-mario.limonciello@amd.com>
 <31d48b10-87e1-1064-b25a-71f55736e504@linux.intel.com>
 <46b822e9-8bfd-462e-9f2f-acddd44bba30@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <46b822e9-8bfd-462e-9f2f-acddd44bba30@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7p8ufks7Qmp5C3tLzfCRVWOPDNTRx3CzCPILtm/b+WagWkCJ3d0
 Lyc/wwZqqNRCgun0jtkvGWABsPXzE4G2JEdvx7SrF3x4Xi67VCBqv7+tyUWaLWbdauyQo2q
 siR2/EseX/WhFUOovwFJmPJqdqld28M7LiDbb0h2aoVzwBD+eVksQb5s7FvnBJ52hhK9EZX
 9r/QuQ+rKReMIOTOu1Y7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VNdloLmZJ6w=;pUIx4JRKa+1/cvst9LNEfclYVYx
 +BFVWVmKnLl2vFxqcVGttN0gwnXlrp3DbqwnzGcnFpz03kU5f0+h8jdTRu22KvLyzAulrQyVL
 Gp38xpFaVspf0idn90D/jzFP9m9M80GTNC3X8+bLbrBq3T5UL9EPZjNrmCX6cZWuKuY4WzwT3
 XRowDz7/2HDh3uNgIn1hc19vwqI53ID4AyC1pBkP6/NflZXCNEnEliLbDk1f1iJCoc1RDbeuQ
 6lFGyeIrLwCjtV32VMaaq2bt0Kblabrmy00YNN+0+GfWcwHnNgKK6m6Cih0V3QTKoIbOuW6X8
 vziTaT/+EzdQehxpND23kHVPVW/jU+WOUVoma5XM+Qda8OvQ/vx7icazmROV2xnYV0/ZKmcUk
 UdIOFEDaaW03ueivplRUpYXE9JhS9974dur2+cd/rGP+MZ0mrcAKggR7VbhpTckCycHseVKQ4
 wMZzSQfBUL4U7056xR5rvVPA07DlCmrtkPB5sM7nh06WYidwSTcGYrq7ICOZS29qL5VbPeuZH
 5+RvuZS+b2OuqVgOomVyaWRLK8xjJJc2DZvLWTC0Jqxi8cKvmN54h3pS6jr4V8q1h24MkNYg2
 x/rSxeamrqS4N1SbtLD4PfRlwXVH4bqdxYPi0Exu0yD6xS++CKCqj/F4Xd+BS3vuyYLQUyec/
 RGwgLLU7qKN0EZ3fNhG+oEdWcqVA7gG3p1qDIrIHmbnjT76ETFdJB2h1A/0qmRuZUIA5AcThP
 +gImHcv4ZmVf3cPfvgpD6kvYqdzqXBMBH0BbBoLF1V0cIcmyBaobWTAKYUJLg87YBH1Z4MSgw
 EuyMRtPDAWjapsN+KMtzrxscqfyoxqg/K4UeDUl5PnIOIzD1hvrMt6DDzHFSAGQ4WxQ1zZ2+y
 dwb8sD57O+paD+Od4ZQTrjB8g6upxhdY9tS/z99GcMEBBS3JW0+CC7sT9

Am 20.11.24 um 16:37 schrieb Mario Limonciello:

> On 11/20/2024 09:09, Ilpo J=C3=A4rvinen wrote:
>> On Tue, 19 Nov 2024, Mario Limonciello wrote:
>>
>>> As multiple platform profile handlers may come and go, send a
>>> notification
>>> to userspace each time that a platform profile handler is registered o=
r
>>> unregistered.
>>>
>>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v7:
>>> =C2=A0 * Add Armin's tag
>>> ---
>>> =C2=A0 drivers/acpi/platform_profile.c | 4 ++++
>>> =C2=A0 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c
>>> b/drivers/acpi/platform_profile.c
>>> index 1530e6096cd39..de0804305b02c 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -363,6 +363,8 @@ int platform_profile_register(struct
>>> platform_profile_handler *pprof)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup_id=
a;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform_pro=
file");
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_profile =3D pprof;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D sysfs_update_group(acpi_=
kobj, &platform_profile_group);
>>
>> Is the ordering problematic here, how long userspace has to wait for th=
e
>> update to become visible?
>
> TBH - this feels like an artifact of the earlier patches.=C2=A0 I don't
> know that we really need the notify anymore since calling
> sysfs_update_group().
>
> I'm tending to think drop this patch entirely.
>
I do not think so. A new platform profile handler might cause the platform=
 profile choices to change. It might also cause the platform profile
to switch to "custom" in some cases. So i think we still have to keep this=
 patch.

Thanks

>>
>>> @@ -393,6 +395,8 @@ int platform_profile_remove(struct
>>> platform_profile_handler *pprof)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_unregister(pprof->class_dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ida_free(&platform_profile_ida, id);
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform_pro=
file");
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_update_group(acpi_kobj, &platform=
_profile_group);
>>
>>
>
>

