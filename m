Return-Path: <linux-acpi+bounces-16445-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD5B48806
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 11:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC057AFF47
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 09:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A562EA72A;
	Mon,  8 Sep 2025 09:13:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C71FF1BF;
	Mon,  8 Sep 2025 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322782; cv=none; b=QYgF87ua7zRwdeNN+JSGIX6TMByJbcPWBh6iRAAZtnXmy7ymNBAALzfIyOSlQYZmPrnmPcuw8S5YfohQIoSBvNvfsMA0u9/AwoOOHsKm4B82SR2JupDKz2TFXwg4IN+m2H4B+jHUaqnfWdRq2xND/iNyJr/RkS2RSXXo5BVJfso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322782; c=relaxed/simple;
	bh=ukh9KltCtNWgocUMmE8ReWaVb4Wu7TjADySQktith44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EItMxjE6jTQzBFe2Zf3knvo2qS5GnelrWs7rUvoxPfu/NqdsRRnEQwbHqsOWFDwHnuZyUflevrzQvaoXQlNpLtDzCNxhsbQ5ZWAKeFyBb1ha8axGkrhcr5NcUELG53G22zeFMuzp+VVGfEB3T8UcXyhMWusSiaDQe+GHUSHDBKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ff62280e8c9311f0b29709d653e92f7d-20250908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e2fab22a-c7aa-4216-90ca-404e6fb63c6d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:046415f91e77839f7ce3c5f8880d4853,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ff62280e8c9311f0b29709d653e92f7d-20250908
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2046176838; Mon, 08 Sep 2025 17:12:52 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A0BDEE008FA7;
	Mon,  8 Sep 2025 17:12:51 +0800 (CST)
X-ns-mid: postfix-68BE9E13-43449476
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 8B40BE008FA3;
	Mon,  8 Sep 2025 17:12:38 +0800 (CST)
Message-ID: <a968c6da-265a-405c-8f79-cf0474c80bc5@kylinos.cn>
Date: Mon, 8 Sep 2025 17:12:37 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] cpufreq: use __free() for all cpufreq_cpu_get()
 references
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
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
References: <20250905132413.1376220-1-zhangzihuan@kylinos.cn>
 <20250905174928.GFaLsiqKV36JDowX94@fat_crate.local>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250905174928.GFaLsiqKV36JDowX94@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/6 01:49, Borislav Petkov =E5=86=99=E9=81=93:
> On Fri, Sep 05, 2025 at 09:24:07PM +0800, Zihuan Zhang wrote:
>> This patchset converts all remaining cpufreq users to rely on the
>> __free(put_cpufreq_policy) annotation for policy references, instead o=
f
>> calling cpufreq_cpu_put() manually.
> Sep 01 Zihuan Zhang ( :8.6K|) [PATCH v3 00/12] cpufreq: use __free() fo=
r all cpufreq_cpu_get() references
> Sep 03 Zihuan Zhang ( :  65|) [PATCH v4 00/10] cpufreq: use __free() fo=
r all cpufreq_cpu_get() references
> Sep 05 Zihuan Zhang ( :8.3K|) [PATCH v5 0/6] cpufreq: use __free() for =
all cpufreq_cpu_get() references
>
> Please stop the spamming. While waiting, go read how this kernel proces=
s thing
> works:
>
> From: Documentation/process/submitting-patches.rst
>
> Don't get discouraged - or impatient
> ------------------------------------
>
> After you have submitted your change, be patient and wait.  Reviewers a=
re
> busy people and may not get to your patch right away.
>
> Once upon a time, patches used to disappear into the void without comme=
nt,
> but the development process works more smoothly than that now.  You sho=
uld
> receive comments within a week or so; if that does not happen, make sur=
e
> that you have sent your patches to the right place.  Wait for a minimum=
 of
> one week before resubmitting or pinging reviewers - possibly longer dur=
ing
> busy times like merge windows.
Sorry for the noise. I=E2=80=99ll split the patchset and avoid CC=E2=80=99=
ing=20
unnecessary people in the future.

Thanks for the reminder!

