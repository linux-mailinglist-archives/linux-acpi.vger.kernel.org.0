Return-Path: <linux-acpi+bounces-16272-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A6BB3FC8D
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 12:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F7B4E3574
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678BA2EACE9;
	Tue,  2 Sep 2025 10:33:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FFC2ED148;
	Tue,  2 Sep 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809190; cv=none; b=dfHHfdQ3hoh3LSRxxLZKZ4TWVjDDWJJ/aiH3H2HN+lKJaCvk2CsXrrgMZuDzn/Rp2h67h888fIhX2PhVmEcIgkpzu5TFpnK+h43UrT0zfze0rD8M64oiMWEo2VsP/5TAhfeD2860XOREhbod1BbZGNfggNNEQYJqYZJj4uFNh5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809190; c=relaxed/simple;
	bh=L8JaUs3SOhVHk302t291gHlKh5NKD5qAHGAnGijZbM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azXb57iSNxQajeST1qYtisZ3/3TIw215OeN1HolMp7qM+G+mSjXWrOn9KWpf9/zQgxVXA2aUUD+dybgk03VeZ3k10jX6TqJDHSyB035OI7r4p2BXiuXbPAmkIxBXMxzIX0lIcjqbpZQHnpSPAueAD857K1tLQps5KoDiBSRPnv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3107081c87e811f0b29709d653e92f7d-20250902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3fbf43f8-ebc9-4b27-884e-79c619713230,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:7ac0a2afc203774c376dc034898cbd81,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3107081c87e811f0b29709d653e92f7d-20250902
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1546738643; Tue, 02 Sep 2025 18:32:57 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A718FE008FA3;
	Tue,  2 Sep 2025 18:32:56 +0800 (CST)
X-ns-mid: postfix-68B6C7D8-5510786
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 589C2E008FA2;
	Tue,  2 Sep 2025 18:32:48 +0800 (CST)
Message-ID: <29890791-4ddf-49c7-a4f2-0ac83e6d53c6@kylinos.cn>
Date: Tue, 2 Sep 2025 18:32:47 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] cpufreq: intel_pstate: Use scope-based cleanup
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
References: <20250901085748.36795-1-zhangzihuan@kylinos.cn>
 <20250901085748.36795-4-zhangzihuan@kylinos.cn>
 <CAJZ5v0hu48NrMr6Vkjn_UyHywJMx7F5N6yWf2LiXxykZF79EKA@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0hu48NrMr6Vkjn_UyHywJMx7F5N6yWf2LiXxykZF79EKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/1 23:17, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Mon, Sep 1, 2025 at 10:58=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylin=
os.cn> wrote:
>> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
>> annotation for policy references. This reduces the risk of reference
>> counting mistakes and aligns the code with the latest kernel style.
>>
>> No functional change intended.
>>
>> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>> ---
>>   drivers/cpufreq/intel_pstate.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_ps=
tate.c
>> index f366d35c5840..4abc1ef2d2b0 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -1502,9 +1502,8 @@ static void __intel_pstate_update_max_freq(struc=
t cpufreq_policy *policy,
>>
>>   static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
>>   {
>> -       struct cpufreq_policy *policy __free(put_cpufreq_policy);
>> +       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D c=
pufreq_cpu_get(cpudata->cpu);
>>
>> -       policy =3D cpufreq_cpu_get(cpudata->cpu);
>>          if (!policy)
>>                  return false;
> The structure of the code is intentional here and there's no reason to
> change it.


Got it. Thanks for clarifying.

So for this case the current structure is intentional -

should I also avoid similar changes in other drivers?


