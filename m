Return-Path: <linux-acpi+bounces-16356-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B1B438F1
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 12:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D72F5882FD
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5162FABFE;
	Thu,  4 Sep 2025 10:38:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65E2ECD14;
	Thu,  4 Sep 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982296; cv=none; b=QsPF9tYokEemUGTPPTwZFxKKur8Y8Wn7LoQ3+bKj4X2Hl+S8dFgjGLo2sFQ4VLOBiQdkGBzdfOX/4lzxE66dkft8L5GizMWE6iwtsp5Ysn+fE8agCZZzR8Js8lOVBPy8m4PUs7Vk0zHtZCUXCz772fAnBqF+MHjfZeGIu8pn1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982296; c=relaxed/simple;
	bh=ix2eo8p54Z5LDsEgINjDis0MKy5IFDdJCHvTNdJdftw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWxiF3YjJLfjNDPg0S9OFrNcYi0VTlQ/4FVLIviXr1a5yWS4+08Uv3wnPI0YRnacZMpm7FCueOah4TcXQcOyJNBNc9Dk8nFw+6V8H1UEGRAH14KB7zb9XDvtxAcbRQ3CWpszTSkiMN5zrEBAzZ82JR2T+Kqo8jm2nfxBZifch/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3d5fbc1e897b11f0b29709d653e92f7d-20250904
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:300f2fa7-17a5-4d38-96a3-11fd4189ac0a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:8818228a5c537eaf9504e99b0c50a8d8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3d5fbc1e897b11f0b29709d653e92f7d-20250904
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1160067433; Thu, 04 Sep 2025 18:38:05 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 93A19E008FA5;
	Thu,  4 Sep 2025 18:38:04 +0800 (CST)
X-ns-mid: postfix-68B96C0C-3265371312
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 0174FE008FA2;
	Thu,  4 Sep 2025 18:37:54 +0800 (CST)
Message-ID: <52e322e5-2dd4-488c-a98e-3a4018f0c323@kylinos.cn>
Date: Thu, 4 Sep 2025 18:37:54 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] powercap: dtpm_cpu: Use scope-based cleanup
 helper
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Krzysztof Kozlowski
 <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>,
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
 <20250903131733.57637-8-zhangzihuan@kylinos.cn>
 <CAJZ5v0hirWzWZiLbAXPWB58SQv3CAW95iHLnsqs=i2twVCcmwg@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0hirWzWZiLbAXPWB58SQv3CAW95iHLnsqs=i2twVCcmwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/3 21:45, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Wed, Sep 3, 2025 at 3:18=E2=80=AFPM Zihuan Zhang <zhangzihuan@kylino=
s.cn> wrote:
>> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
>> annotation for policy references. This reduces the risk of reference
>> counting mistakes and aligns the code with the latest kernel style.
>>
>> No functional change intended.
>>
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>> ---
>>   drivers/powercap/dtpm_cpu.c | 30 +++++++++++-------------------
>>   1 file changed, 11 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
>> index 99390ec1481f..f76594185fa2 100644
>> --- a/drivers/powercap/dtpm_cpu.c
>> +++ b/drivers/powercap/dtpm_cpu.c
>> @@ -144,19 +144,17 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>>   static void pd_release(struct dtpm *dtpm)
>>   {
>>          struct dtpm_cpu *dtpm_cpu =3D to_dtpm_cpu(dtpm);
>> -       struct cpufreq_policy *policy;
>>
>>          if (freq_qos_request_active(&dtpm_cpu->qos_req))
>>                  freq_qos_remove_request(&dtpm_cpu->qos_req);
>>
>> -       policy =3D cpufreq_cpu_get(dtpm_cpu->cpu);
>> -       if (policy) {
>> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D
>> +               cpufreq_cpu_get(dtpm_cpu->cpu);
>> +
>> +       if (policy)
>>                  for_each_cpu(dtpm_cpu->cpu, policy->related_cpus)
>>                          per_cpu(dtpm_per_cpu, dtpm_cpu->cpu) =3D NULL=
;
>>
>> -               cpufreq_cpu_put(policy);
>> -       }
>> -
>>          kfree(dtpm_cpu);
>>   }
>>
>> @@ -192,7 +190,6 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>>   static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>>   {
>>          struct dtpm_cpu *dtpm_cpu;
>> -       struct cpufreq_policy *policy;
>>          struct em_perf_state *table;
>>          struct em_perf_domain *pd;
>>          char name[CPUFREQ_NAME_LEN];
>> @@ -202,21 +199,19 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm=
 *parent)
>>          if (dtpm_cpu)
>>                  return 0;
>>
>> -       policy =3D cpufreq_cpu_get(cpu);
>> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D
>> +               cpufreq_cpu_get(cpu);
>> +
>>          if (!policy)
>>                  return 0;
>>
>>          pd =3D em_cpu_get(cpu);
>> -       if (!pd || em_is_artificial(pd)) {
>> -               ret =3D -EINVAL;
>> -               goto release_policy;
>> -       }
>> +       if (!pd || em_is_artificial(pd))
>> +               return -EINVAL;
>>
>>          dtpm_cpu =3D kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
>> -       if (!dtpm_cpu) {
>> -               ret =3D -ENOMEM;
>> -               goto release_policy;
>> -       }
>> +       if (!dtpm_cpu)
>> +               return -ENOMEM;
>>
>>          dtpm_init(&dtpm_cpu->dtpm, &dtpm_ops);
>>          dtpm_cpu->cpu =3D cpu;
>> @@ -239,7 +234,6 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *=
parent)
>>          if (ret < 0)
>>                  goto out_dtpm_unregister;
> So this change kind of goes against another recommendation given in cle=
anup.h:
>
>   * Lastly, given that the benefit of cleanup helpers is removal of
>   * "goto", and that the "goto" statement can jump between scopes, the
>   * expectation is that usage of "goto" and cleanup helpers is never
>   * mixed in the same function. I.e. for a given routine, convert all
>   * resources that need a "goto" cleanup to scope-based cleanup, or
>   * convert none of them.


Should I replace all the memory allocation cleanups here with `__free`?
That would allow us to drop all the `goto`s, but since this function has
quite a few of them, I=E2=80=99m concerned it might introduce new issues.=
 What=E2=80=99s
your recommendation?

Thanks!

>> -       cpufreq_cpu_put(policy);
>>          return 0;
>>
>>   out_dtpm_unregister:
>> @@ -251,8 +245,6 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *=
parent)
>>                  per_cpu(dtpm_per_cpu, cpu) =3D NULL;
>>          kfree(dtpm_cpu);
>>
>> -release_policy:
>> -       cpufreq_cpu_put(policy);
>>          return ret;
>>   }
>>
>> --

