Return-Path: <linux-acpi+bounces-9209-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B599B84D7
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 22:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EE51F21837
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 21:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B371BBBC1;
	Thu, 31 Oct 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="eTRi7RP7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2813A87C;
	Thu, 31 Oct 2024 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408567; cv=none; b=bUW+CBM8G9JmMvX1tw88BjY1YOkw6lrUYWHfnv8noyKZo8IJZN/SScDuDh1DdWv20ODgKZTCKFBXB6EtyMQ83boIq3N3c7Zb/FwGoTapVEnjktfAZARaFE6jn9CFSX5oHnTqmKZH/KErx1daWd7wKGfnwDcWcn0tbMEzYynPmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408567; c=relaxed/simple;
	bh=9ogiSBCPi/Ij4wMiM+eoF11Iv+v0ajw3Tj9OgF3t5Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caJNhmoRGI24gzc+fBTg2lecmkMdLDh/z4s9uaOljpnPxMSO7qObz32JKPa/YYMiOp1gaKxaavdSSqtg0CkPTftVblUsAcG3s1bYZ1XblS06FgfWlBFP5kWWbFyEbS9Ryht6ROQM0cWue8WY/ZEErSs2BEkcvice3UzKEJUKzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=eTRi7RP7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730408489; x=1731013289; i=w_armin@gmx.de;
	bh=9ogiSBCPi/Ij4wMiM+eoF11Iv+v0ajw3Tj9OgF3t5Sc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eTRi7RP77Ygg02U+HR4RNIURv0CPfFS+gr/6KBPTgL29U6KivvfXKeCnelXcjzqZ
	 uK9D6/lM/3fE2qy6uPcwrL3kAY00HtRZLR4CEvCg6OAA2+SXHwelu+s4kWLVt/xeo
	 cTNQFqm1qSOmUmLX6VbClmandKMYFaFFTvISVA4T5Y17Sg5AguyMPynhVuXTDZiT0
	 S6nSJAd/eNo7PxprADFvwHKH7cOs+Ml+XGOT/NHrvB7+/gIJ5WPV6XzdoeQe+NeZl
	 7GgE9w43sPbvID52LgR5GxQbZvKkFQGh4QhwjLkffgyNNvPd56wTPLyLZ9COxt8ul
	 iPESOMcjFvHO9SOwXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9UE-1tyJPZ1LYy-00xRjz; Thu, 31
 Oct 2024 22:01:29 +0100
Message-ID: <62756516-21cf-49c8-851f-f7fe3a0b0345@gmx.de>
Date: Thu, 31 Oct 2024 22:01:27 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/22] ACPI: platform_profile: Require handlers to
 support balanced profile
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
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
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-14-mario.limonciello@amd.com>
 <40b52d41-e3d6-4223-b9e9-0db6b2a19265@gmx.de>
 <a95ed9c4-a112-4087-aca9-8323902273b2@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <a95ed9c4-a112-4087-aca9-8323902273b2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nitKPwsm+sUk2qj32a7KZXTO6fRl2IGCIeJa6oeRmAD/QaIdEuV
 kRFfmKCcyfuA/OF0tlJ61iaV6JZdYbCTQ+3f6TgeKy/qdUmFVsqBZzphrix5TocM8lzsxB4
 GwKNUG1OQJK0e58sCDS0UFMINU9/HPg0pAN6EGbhEgFtJKqSpof8EJsiMVSokyjF7dDPGq9
 Ti0XteIFJRPARmXtcSHpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CFqAKbzVAnA=;lw0Sn/3Uk9uFo1yIrORsxptSK1E
 mSNOEI3qA3RAm4A5aOvFAcVeFeLw+bKB0brwaSN+QkCeNVHZ2qzq9L8CGDlWNnDiEI5MgvH7E
 qKs4fqTI77Cq2izn0crt75vACM6AtcEFE7ACXpHZJ8sd6DdnarUNkWQwvvgTjtWM1zDp/u+3q
 sdrgqd7uXtKHu0YcaPJSXpdu/wlEQT0/BfslABk1u4XLSD5bQBCd3I+WnnJTsIdwS6HuES+An
 ep06dqPPdNughd/ZNizvIsaecpDg4mdQdDVRMR8Q0fYwkQa81BmPEWq/rl4il8Y28vTAQvmHS
 +i6dt2JfiMweYL2Xtu8sfJsN93wn1sntnLsy3xAVcSnsiZRzKg2ElL4S9rMYlm8B/1g8anq45
 brdmXNFNWC1xsvVLGpjEOorNd9fEWw/Y0a9/WXRIRYbFskTCVDz8NPPE8ELTg1bfrsN9C35hX
 fk3SzGr3Asj2nlU649HRqX4VbPRWrHaEW9Un6uspekTsX0FpQAh42ZRwXdLaPknXkonQK7PiF
 6KOLRS2m1BtPeYStg4Tp0v+H5rfaOToHgOkd3oXWcF3aHjWYaIhHmVdxDa/Ll/VJTvqu9dQm1
 IrZRi7Fvhkza0p0ViiFrqDa0o4v1wOXixffNJuemRvL0DXfT51PHE3EuvUInNQ9OlRQfEYvgF
 IZ5yrLjjlmFWdJU6iuQrRmfEYepVDGCfZGA+FAYXjBxQTeUTnJgMdCdrPXMQfqEzQiPJ0UPsI
 VpuHV/U16FBQn9J/O8Y+ApOJcqHETAqywtxpcRU/UoXGwR0ZepnhWblIMlmtuZu31r5U3CbR1
 DYqdR6HGPvvrB3rSmicyi+fA==

Am 31.10.24 um 21:43 schrieb Mario Limonciello:

> On 10/31/2024 15:39, Armin Wolf wrote:
>> Am 31.10.24 um 05:09 schrieb Mario Limonciello:
>>
>>> As support for multiple simultaneous platform handers is introduced
>>> it's
>>> important they have at least the balanced profile in common.
>>>
>>> This will be used as a fallback in case setting the profile across
>>> one of the
>>> handlers happens to fail.
>>
>> Do we actually need this patch anymore now that we have the "custom"
>> platform profile?
>> If setting the platform profile fails for some handlers, then we
>> simply display the current
>> platform profile as "custom".
>
> Yes; it's still needed because 'balanced' is used as the fallback of
> something failed.=C2=A0 If you fail to write to a handler it gets you ba=
ck
> to a known place for all GPUs.
>
> Now I suppose it's up for discussion if that's really the right thing
> to do.
>
> Maybe because of custom we don't even need that.
>
> If I have 3 profile handlers in
> low-power
> balanced
> balanced
>
> IE I'm already in 'custom'.
>
> If I try to write performance and the first two succeed but the third
> fails what's better:
>
> performance
> performance
> balanced
>
> Or
>
> balanced
> balanced
> balanced
>
I think the first is better, as we cannot really guarantee that setting "b=
alanced" for all handlers
will always work.

Thanks,
Armin Wolf

>>
>> Thanks,
>> Armin Wolf
>>
>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> =C2=A0 drivers/acpi/platform_profile.c | 4 ++++
>>> =C2=A0 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/
>>> platform_profile.c
>>> index b70ceb11947d0..57c66d7dbf827 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -164,6 +164,10 @@ int platform_profile_register(struct
>>> platform_profile_handler *pprof)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("platfor=
m_profile: handler is invalid\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (!test_bit(PLATFORM_PROFILE_BALANCED, pprof->ch=
oices)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("platform_profile: =
handler does not support balanced
>>> profile\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pprof->dev) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("platfor=
m_profile: handler device is not set\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>

