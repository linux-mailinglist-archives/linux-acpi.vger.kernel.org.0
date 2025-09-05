Return-Path: <linux-acpi+bounces-16389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D0B4502D
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 09:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5510B1C25350
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0271D26F47D;
	Fri,  5 Sep 2025 07:45:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401D271447;
	Fri,  5 Sep 2025 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058310; cv=none; b=Enjhs5Xa9nyEjzLcLbNwkhhJ8D1a3b6IP/zXzQAESVY+s5StrcbEzR5EvRnNBzFJ4nm8yPyFW1wy++Do5Pa8KM2w2YgPN9hUhsTcHNM1CnfZ+LoENZOepZ1iYwk3x+Ju3w2oxuMzOA81i9SEZ797aVx42GyXifyoNHixccQNTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058310; c=relaxed/simple;
	bh=3XX5fgVfIt8H/eWkB6Y8cCGVwctszDhoX3FKONvJFag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENe2t41mVhsggzYGDLPjJqQljKagpa0evt0+UzWW1vQxpcgdCb+71L1TMdNTihN2oMgq/n4ltsMd5a2/Xbpv9lOLWuEVi2QmOBo904Vquz+gmVSCGLmVasgUhss8nFJUjirUvamwRxAiIozwqNNPPxLPovztU/Do1dGQiI3nIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 397b25d28a2c11f0b29709d653e92f7d-20250905
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f87db68f-3c30-403e-8904-d7166b6f16d2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:07aa7fe718078e46c5eacd4bb0c408a3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 397b25d28a2c11f0b29709d653e92f7d-20250905
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 541260558; Fri, 05 Sep 2025 15:44:59 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 29A5AE008FA4;
	Fri,  5 Sep 2025 15:44:59 +0800 (CST)
X-ns-mid: postfix-68BA94FA-497226507
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 27E5DE008FA3;
	Fri,  5 Sep 2025 15:44:40 +0800 (CST)
Message-ID: <11bcb7cb-2169-479f-9247-a48e48e9c54e@kylinos.cn>
Date: Fri, 5 Sep 2025 15:44:39 +0800
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
 <20250903131733.57637-8-zhangzihuan@kylinos.cn>
 <CAJZ5v0hirWzWZiLbAXPWB58SQv3CAW95iHLnsqs=i2twVCcmwg@mail.gmail.com>
 <52e322e5-2dd4-488c-a98e-3a4018f0c323@kylinos.cn>
 <CAJZ5v0g__9g_dfA3=4GVi351f4CKBegKkW9nU81j+Qu=2Hfg1Q@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0g__9g_dfA3=4GVi351f4CKBegKkW9nU81j+Qu=2Hfg1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/4 21:17, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Thu, Sep 4, 2025 at 12:38=E2=80=AFPM Zihuan Zhang <zhangzihuan@kylin=
os.cn> wrote:
>>
>> =E5=9C=A8 2025/9/3 21:45, Rafael J. Wysocki =E5=86=99=E9=81=93:
>>> On Wed, Sep 3, 2025 at 3:18=E2=80=AFPM Zihuan Zhang <zhangzihuan@kyli=
nos.cn> wrote:
>>>> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
>>>> annotation for policy references. This reduces the risk of reference
>>>> counting mistakes and aligns the code with the latest kernel style.
>>>>
>>>> No functional change intended.
>>>>
>>>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>>>> ---
>>>>    drivers/powercap/dtpm_cpu.c | 30 +++++++++++-------------------
>>>>    1 file changed, 11 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu=
.c
>>>> index 99390ec1481f..f76594185fa2 100644
>>>> --- a/drivers/powercap/dtpm_cpu.c
>>>> +++ b/drivers/powercap/dtpm_cpu.c
>>>> @@ -144,19 +144,17 @@ static int update_pd_power_uw(struct dtpm *dtp=
m)
>>>>    static void pd_release(struct dtpm *dtpm)
>>>>    {
>>>>           struct dtpm_cpu *dtpm_cpu =3D to_dtpm_cpu(dtpm);
>>>> -       struct cpufreq_policy *policy;
>>>>
>>>>           if (freq_qos_request_active(&dtpm_cpu->qos_req))
>>>>                   freq_qos_remove_request(&dtpm_cpu->qos_req);
>>>>
>>>> -       policy =3D cpufreq_cpu_get(dtpm_cpu->cpu);
>>>> -       if (policy) {
>>>> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D
>>>> +               cpufreq_cpu_get(dtpm_cpu->cpu);
>>>> +
>>>> +       if (policy)
>>>>                   for_each_cpu(dtpm_cpu->cpu, policy->related_cpus)
>>>>                           per_cpu(dtpm_per_cpu, dtpm_cpu->cpu) =3D N=
ULL;
>>>>
>>>> -               cpufreq_cpu_put(policy);
>>>> -       }
>>>> -
>>>>           kfree(dtpm_cpu);
>>>>    }
>>>>
>>>> @@ -192,7 +190,6 @@ static int cpuhp_dtpm_cpu_online(unsigned int cp=
u)
>>>>    static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>>>>    {
>>>>           struct dtpm_cpu *dtpm_cpu;
>>>> -       struct cpufreq_policy *policy;
>>>>           struct em_perf_state *table;
>>>>           struct em_perf_domain *pd;
>>>>           char name[CPUFREQ_NAME_LEN];
>>>> @@ -202,21 +199,19 @@ static int __dtpm_cpu_setup(int cpu, struct dt=
pm *parent)
>>>>           if (dtpm_cpu)
>>>>                   return 0;
>>>>
>>>> -       policy =3D cpufreq_cpu_get(cpu);
>>>> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D
>>>> +               cpufreq_cpu_get(cpu);
>>>> +
>>>>           if (!policy)
>>>>                   return 0;
>>>>
>>>>           pd =3D em_cpu_get(cpu);
>>>> -       if (!pd || em_is_artificial(pd)) {
>>>> -               ret =3D -EINVAL;
>>>> -               goto release_policy;
>>>> -       }
>>>> +       if (!pd || em_is_artificial(pd))
>>>> +               return -EINVAL;
>>>>
>>>>           dtpm_cpu =3D kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
>>>> -       if (!dtpm_cpu) {
>>>> -               ret =3D -ENOMEM;
>>>> -               goto release_policy;
>>>> -       }
>>>> +       if (!dtpm_cpu)
>>>> +               return -ENOMEM;
>>>>
>>>>           dtpm_init(&dtpm_cpu->dtpm, &dtpm_ops);
>>>>           dtpm_cpu->cpu =3D cpu;
>>>> @@ -239,7 +234,6 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm=
 *parent)
>>>>           if (ret < 0)
>>>>                   goto out_dtpm_unregister;
>>> So this change kind of goes against another recommendation given in c=
leanup.h:
>>>
>>>    * Lastly, given that the benefit of cleanup helpers is removal of
>>>    * "goto", and that the "goto" statement can jump between scopes, t=
he
>>>    * expectation is that usage of "goto" and cleanup helpers is never
>>>    * mixed in the same function. I.e. for a given routine, convert al=
l
>>>    * resources that need a "goto" cleanup to scope-based cleanup, or
>>>    * convert none of them.
>>
>> Should I replace all the memory allocation cleanups here with `__free`=
?
>> That would allow us to drop all the `goto`s, but since this function h=
as
>> quite a few of them, I=E2=80=99m concerned it might introduce new issu=
es. What=E2=80=99s
>> your recommendation?
> Frankly, don't use __free() in this code at all, at least for the time =
being.
>
> There is a problem with dropping the reference to policy at the end of
> __dtpm_cpu_setup() because that policy may be subsequently indirectly
> used in set_pd_power_limit() which calls
> freq_qos_update_request(&dtpm_cpu->qos_req, freq) and
> dtpm_cpu->qos_req->qos is policy->constraints, so using it will cause
> policy->constraints to be dereferenced in freq_qos_apply() which will
> crash and burn if the policy goes away in the meantime.  So AFAICS
> __dtpm_cpu_setup() shouldn't call cpufreq_cpu_put() at all and the
> policy should be released in pd_release() without acquiring a new
> reference to it.
>

Thanks a lot for the detailed explanation!


