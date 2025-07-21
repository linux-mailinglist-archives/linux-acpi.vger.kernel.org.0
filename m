Return-Path: <linux-acpi+bounces-15248-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C137B0BB3C
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 05:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE02D18970CC
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 03:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAEF1DF98F;
	Mon, 21 Jul 2025 03:13:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18471E515;
	Mon, 21 Jul 2025 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753067621; cv=none; b=q3vL0G5a2wNgOjqwe8AdNtS9EURC7M3w245btam1NlVNNYRzRHXWfjZBFgK+qxLVwkkZa4mReBaZ3Od0IwMXkCnB3zzdgXnT0nbcAzp2UbYTVF0ots9gx1B3yZ3YcHHI5c86Bhoaud/ypoiqfMuOsLbtQqmwat9vgR120dpzznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753067621; c=relaxed/simple;
	bh=Q/S828N21eNdTYCjDYLacFCB3Swcqk5fgY6jVStw5Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5hAxE2FuaC7ZZI1yvjQmuo0kJg7zlZX3FFNd7kNyiLcAE2JmtAJck3nuKDiNlnc1PDv7ZQr1YzhoIygK34gwiLv0LI/WEwMGBqZ3VerAZBfpMhrNtrHLwsqHxwXB8NfE1y8xek9UFYN4C7Kd0TUiUIbSaGt8OLQoXiQvvnEywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a8aa3f6265e011f0b29709d653e92f7d-20250721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:eed23872-68c1-434e-963e-4b27ddf0ade8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ec9d0ae682b2cba23291e0c9cac5afad,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817,TC:nil,Content:-10|-
	8|-5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a8aa3f6265e011f0b29709d653e92f7d-20250721
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 245598966; Mon, 21 Jul 2025 11:13:22 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 51E6D16004282;
	Mon, 21 Jul 2025 11:13:22 +0800 (CST)
X-ns-mid: postfix-687DB050-9698871801
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 85BFB16004285;
	Mon, 21 Jul 2025 03:13:20 +0000 (UTC)
From: Jiayi Li <lijiayi@kylinos.cn>
To: rafael@kernel.org
Cc: jiayi_dec@163.com,
	lenb@kernel.org,
	lijiayi@kylinos.cn,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: Fix initial QoS constraint application order in PPC initialization
Date: Mon, 21 Jul 2025 11:13:07 +0800
Message-ID: <20250721031307.3451012-1-lijiayi@kylinos.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAJZ5v0jJu2=MbdQ2z8a9JF8Lfz_Mci1+3oncHu8VCb4b3fA_Gg@mail.gmail.com>
References: <CAJZ5v0jJu2=MbdQ2z8a9JF8Lfz_Mci1+3oncHu8VCb4b3fA_Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>>
>> The original initialization sequence was:
>>
>> cpufreq_policy_online()
>>     acpi_cpufreq_cpu_init()
>>         acpi_processor_get_platform_limit()
>>             freq_qos_update_request(&perflib_req)
>>     blocking_notifier_call_chain(...)
>>         acpi_processor_ppc_init()
>>             freq_qos_add_request(&perflib_req)
>>
>> This caused a race condition where the QoS request was added after the
>> initial platform limit update.
>
>To me, the description above is useless for figuring out what's going on=
, sorry.
>
>This is not a race, but an ordering issue.
>
>The cpufreq driver calls acpi_processor_register_performance(), which
>among other things causes acpi_processor_get_platform_limit() to be
>called, from its ->init() callback which is invoked by the cpufreq
>core before CPUFREQ_CREATE_POLICY notifiers and the policy frequency
>QoS requests are added by acpi_processor_notifier(), so they don't
>exist when acpi_processor_register_performance() gets called and they
>cannot be updated by the acpi_processor_get_platform_limit().
>
>You want them to be updated as soon as they have been added, which is
>kind of reasonable, but it needs to be done only if
>acpi_processor_register_performance() has been called by the cpufreq
>driver.
>

Sorry, I didn't make the question clear.

This patch fixes an issue where _PPC frequency limits set by the BIOS
failed to take effect due to incorrect call ordering. Previously,
freq_qos_update_request() was being called before freq_qos_add_request(),
causing the constraint updates to be ignored. With this fix, the frequenc=
y
limits are now properly enforced as intended.

>> The new sequence explicitly ensures:
>>
>> cpufreq_policy_online()
>>     acpi_cpufreq_cpu_init()
>>         acpi_processor_get_platform_limit()
>>             freq_qos_update_request(&perflib_req)
>>     blocking_notifier_call_chain(...)
>>         acpi_processor_ppc_init()
>>             freq_qos_add_request(&perflib_req)
>> +           acpi_processor_get_platform_limit()
>> +               freq_qos_update_request(&perflib_req)
>>
>> The critical change adds an immediate platform limit update after the
>> QoS request is registered. This guarantees that the initial P-state
>> constraint is applied before any subsequent updates, resolving the win=
dow
>> where constraints could be applied out-of-order.
>>
>> Fixes: d15ce412737a ("ACPI: cpufreq: Switch to QoS requests instead of=
 cpufreq notifier")
>> Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
>> ---
>>  drivers/acpi/processor_perflib.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor=
_perflib.c
>> index 64b8d1e19594..3e7fe95c21d1 100644
>> --- a/drivers/acpi/processor_perflib.c
>> +++ b/drivers/acpi/processor_perflib.c
>> @@ -173,6 +173,9 @@ void acpi_processor_ppc_init(struct cpufreq_policy=
 *policy)
>>  {
>>         unsigned int cpu;
>>
>> +       if (ignore_ppc =3D=3D 1)
>> +               return;
>> +
>>         for_each_cpu(cpu, policy->related_cpus) {
>>                 struct acpi_processor *pr =3D per_cpu(processors, cpu)=
;
>>                 int ret;
>
>So AFAICS  this loop needs to check pr->performance in addition to pr.
>

Thanks for the review. I agree and will add a check for pr->performance i=
n v2.

--
lijiayi

