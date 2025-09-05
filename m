Return-Path: <linux-acpi+bounces-16390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B23B45065
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 09:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB603B0734
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 07:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A89D2F4A16;
	Fri,  5 Sep 2025 07:54:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8132248AF;
	Fri,  5 Sep 2025 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058879; cv=none; b=mc7Yrx3OzTmDwxSUZj2wDJgAP+BGh7xB9YOG/aWWPWJPBRTBWAfPStAyuewRgKuCz/IXXkeGe4hmBOZrYmM80oM2BW7vnqNh8+1ObDUhYwsUp9JWeY3Qs8h0J+KiY6/4MpJ1PUuT73l0jiT+IS00A6iVGRFUmNRY48qnzff+CgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058879; c=relaxed/simple;
	bh=Oo60j/fi4u5fOu814FQ+7xkjFeyOTHjJvjpPWpxNuZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jax/p8HtZTy3s9oBbPXiD9NRJOUp25Nh4tWj/9QeT6sXJ2CMDGt3Z1t/gKEURb7G16XNZcCMdrMRqZBt8Z9LU+pYixHLsawjHlTdxRZ/Ze+ty0JlTPdh1CZlQR5d+M0UUzXzgoDuhp5d/W9E40mD2HRHB0ZkDwWGCsXfjJevSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8b7cd9b08a2d11f0b29709d653e92f7d-20250905
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b8911e54-e0aa-40d7-9e56-019791a9cc88,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:1038342e134dfa48eabc61cf9e37c597,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8b7cd9b08a2d11f0b29709d653e92f7d-20250905
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1912680162; Fri, 05 Sep 2025 15:54:26 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 49564E008FA7;
	Fri,  5 Sep 2025 15:54:26 +0800 (CST)
X-ns-mid: postfix-68BA9732-140429547
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 33213E008FA4;
	Fri,  5 Sep 2025 15:54:22 +0800 (CST)
Message-ID: <2ccca29e-4d5f-44fa-bfc8-d77c659bc9f3@kylinos.cn>
Date: Fri, 5 Sep 2025 15:54:21 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] thermal/drivers/ti-soc-thermal: Use scope-based
 cleanup helper
To: Andreas Kemnade <andreas@kemnade.info>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Alim Akhtar
 <alim.akhtar@samsung.com>, Thierry Reding <thierry.reding@gmail.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
 Ben Horgan <ben.horgan@arm.com>, zhenglifeng <zhenglifeng1@huawei.com>,
 Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Beata Michalska <beata.michalska@arm.com>, Fabio Estevam
 <festevam@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Sumit Gupta <sumitg@nvidia.com>,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Yicong Yang <yangyicong@hisilicon.com>,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250903131733.57637-1-zhangzihuan@kylinos.cn>
 <20250903131733.57637-10-zhangzihuan@kylinos.cn>
 <20250905085726.2bc6fcb4@akair>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250905085726.2bc6fcb4@akair>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/5 14:57, Andreas Kemnade =E5=86=99=E9=81=93:
> Am Wed,  3 Sep 2025 21:17:32 +0800
> schrieb Zihuan Zhang <zhangzihuan@kylinos.cn>:
>
>> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
>> annotation for policy references. This reduces the risk of reference
>> counting mistakes and aligns the code with the latest kernel style.
>>
>> No functional change intended.
>>
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>> ---
>>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 13 ++++--------=
-
>>   1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/driv=
ers/thermal/ti-soc-thermal/ti-thermal-common.c
>> index 0cf0826b805a..37d06468913a 100644
>> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>> @@ -27,7 +27,6 @@
>>  =20
>>   /* common data structures */
>>   struct ti_thermal_data {
>> -	struct cpufreq_policy *policy;
>>   	struct thermal_zone_device *ti_thermal;
>>   	struct thermal_zone_device *pcb_tz;
>>   	struct thermal_cooling_device *cool_dev;
>> @@ -218,6 +217,7 @@ int ti_thermal_register_cpu_cooling(struct ti_band=
gap *bgp, int id)
>>   {
>>   	struct ti_thermal_data *data;
>>   	struct device_node *np =3D bgp->dev->of_node;
>> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpufreq=
_cpu_get(0);
>>  =20
> this looks as it changes the lifecycle from the device lifetime to just
> this function...


I thought policy was only used in this function, so I moved it here.

Thanks for clarifying the lifecycle issue.

>>   	/*
>>   	 * We are assuming here that if one deploys the zone
>> @@ -234,19 +234,17 @@ int ti_thermal_register_cpu_cooling(struct ti_ba=
ndgap *bgp, int id)
>>   	if (!data)
>>   		return -EINVAL;
>>  =20
>> -	data->policy =3D cpufreq_cpu_get(0);
>> -	if (!data->policy) {
>> +	if (!policy) {
>>   		pr_debug("%s: CPUFreq policy not found\n", __func__);
>>   		return -EPROBE_DEFER;
>>   	}
>>  =20
>>   	/* Register cooling device */
>> -	data->cool_dev =3D cpufreq_cooling_register(data->policy);
>> +	data->cool_dev =3D cpufreq_cooling_register(policy);
> and it is passed on to something living beyond this function. I see no
> _get(policy) in cpufreq_cooling_register().
> Am I missing something?

This indeed causes a problem.

Sure,=C2=A0 I will drop the patchset.

Thanks!

> Regards,
> Andreas

