Return-Path: <linux-acpi+bounces-15289-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D73BB0EB44
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jul 2025 09:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676C66C6977
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jul 2025 07:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B5326B75B;
	Wed, 23 Jul 2025 07:06:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB952AF0A;
	Wed, 23 Jul 2025 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254371; cv=none; b=ux+YMYU/CUKOvzNcaRNeat3rCl6PMtnnqLUnb9UxuZBIxF6l4If/OqgSxx+asLwSs+uLTn5ZVhis8u20PKdy42pWVe6uL+PEwjmEMhRAu9S1Rbobc7A5zYnvglxAuwJaibWE0X0ksQrOQI0RvPc0/bVrD0YQSQyjOcTG9C6gnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254371; c=relaxed/simple;
	bh=XA4vplFibDGvZGTZC0XMytlQ3j7xbkHH4TaNp+bBKgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=geB03xTzSp01IfxZC9ldGr5Ph2LUghwi+D5WfW44R5ScxtxUyA/iIzx1JkbIisEUUgAAa+MpstS//vSZTu92BiiDFvvpFxvbhxPKr2lTel4pqV/1yyU4geHSlBmDiJtcuCIsKVc4uyE5n+rZu++Znh04r/R+EOoIalTzwx7PBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7b840d74679311f0b29709d653e92f7d-20250723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1a41166f-0e66-4c81-bdae-caf56488a794,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:10261a4102752deb1fa961640421017e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7b840d74679311f0b29709d653e92f7d-20250723
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 721445601; Wed, 23 Jul 2025 15:05:57 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 61D2D16001A03;
	Wed, 23 Jul 2025 15:05:57 +0800 (CST)
X-ns-mid: postfix-688089D5-3080892398
Received: from [172.25.120.57] (unknown [172.25.120.57])
	by node4.com.cn (NSMail) with ESMTPA id E61A716001A01;
	Wed, 23 Jul 2025 07:05:56 +0000 (UTC)
Message-ID: <4697e3bd-9954-45af-a4a4-e542760102d7@kylinos.cn>
Date: Wed, 23 Jul 2025 15:05:56 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: Fix initial QoS constraint application order in
 PPC initialization
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250718020312.856168-1-lijiayi@kylinos.cn>
 <20250721032606.3459369-1-lijiayi@kylinos.cn>
 <CAJZ5v0gf5wb1cNS0CJm9-vhMF63d2BzTEfBciiO9ZhdJHYpDnQ@mail.gmail.com>
Cc: rafael@kernel.org, jiayi_dec@163.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?UTF-8?B?5p2O5L2z5oCh?= <lijiayi@kylinos.cn>
In-Reply-To: <CAJZ5v0gf5wb1cNS0CJm9-vhMF63d2BzTEfBciiO9ZhdJHYpDnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2025/7/21 21:27, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Mon, Jul 21, 2025 at 5:26=E2=80=AFAM Jiayi Li <lijiayi@kylinos.cn> w=
rote:
>>
>> This patch fixes an issue where _PPC frequency limits set by the BIOS
>> failed to take effect due to incorrect call ordering. Previously,
>> freq_qos_update_request() was being called before freq_qos_add_request=
(),
>> causing the constraint updates to be ignored. With this fix, the frequ=
ency
>> limits are now properly enforced as intended.
>> The original initialization sequence was:
>>
>> cpufreq_policy_online()
>>      acpi_cpufreq_cpu_init()
>>          acpi_processor_get_platform_limit()
>>              freq_qos_update_request(&perflib_req)
>>      blocking_notifier_call_chain(...)
>>          acpi_processor_ppc_init()
>>              freq_qos_add_request(&perflib_req)
>>
>> The new sequence explicitly ensures:
>>
>> cpufreq_policy_online()
>>      acpi_cpufreq_cpu_init()
>>          acpi_processor_get_platform_limit()
>>              freq_qos_update_request(&perflib_req)
>>      blocking_notifier_call_chain(...)
>>          acpi_processor_ppc_init()
>>              freq_qos_add_request(&perflib_req)
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
>> v1 -> v2:
>> - Modify the commit.
>> - Add pr->performance check in acpi_processor_ppc_init loop.
>> ---
>> ---
>>   drivers/acpi/processor_perflib.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor=
_perflib.c
>> index 64b8d1e19594..56f2b8354d62 100644
>> --- a/drivers/acpi/processor_perflib.c
>> +++ b/drivers/acpi/processor_perflib.c
>> @@ -173,6 +173,9 @@ void acpi_processor_ppc_init(struct cpufreq_policy=
 *policy)
>>   {
>>          unsigned int cpu;
>>
>> +       if (ignore_ppc =3D=3D 1)
>> +               return;
>> +
>>          for_each_cpu(cpu, policy->related_cpus) {
>>                  struct acpi_processor *pr =3D per_cpu(processors, cpu=
);
>>                  int ret;
>> @@ -180,6 +183,9 @@ void acpi_processor_ppc_init(struct cpufreq_policy=
 *policy)
>>                  if (!pr)
>>                          continue;
>>
>> +               if (!pr->performance)
>> +                       continue;
>> +
>>                  /*
>>                   * Reset performance_platform_limit in case there is =
a stale
>>                   * value in it, so as to make it match the "no limit"=
 QoS value
>=20
> Applied, but I have consolidated the pr and pr->performance checks abov=
e.
>=20
> I have also made some changes in the subject and changelog.
>=20
> Thanks!

Thanks for the review!

>=20
>> @@ -193,6 +199,11 @@ void acpi_processor_ppc_init(struct cpufreq_polic=
y *policy)
>>                  if (ret < 0)
>>                          pr_err("Failed to add freq constraint for CPU=
%d (%d)\n",
>>                                 cpu, ret);
>> +
>> +               ret =3D acpi_processor_get_platform_limit(pr);
>> +               if (ret)
>> +                       pr_err("Failed to update freq constraint for C=
PU%d (%d)\n",
>> +                              cpu, ret);
>>          }
>>   }
>>
>> --


