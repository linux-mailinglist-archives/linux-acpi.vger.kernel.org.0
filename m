Return-Path: <linux-acpi+bounces-12549-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1B9A76306
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 11:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6323A6A90
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF20C1DD0EF;
	Mon, 31 Mar 2025 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="r6+4up/F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010009.outbound.protection.outlook.com [52.103.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037621D6DBB;
	Mon, 31 Mar 2025 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412510; cv=fail; b=h1cMAz18uI1nIMRqzl6EiBPYJLYSGLXMKJsRsPFEtXQsuyU+xSSTSQppWO3dBGCx5eq62AWvvdKCRXiMGmU5f7/gm2IVk+wW7Nk1uDncfsmQBRccVytqFcNzcVfNBlKdm1obnKE9HsdbPJjcFtL+NVUAJaf6imHGc1TkTCDidd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412510; c=relaxed/simple;
	bh=UYlQXGWufs4XT9FSJqP1PlhoDY42tpNZNEbBby2aG+c=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HagqAlHNAOGQ2tvE6QVbiyRIYK1uYO5gZMLucFA1a9ucnlBHEwXs1IKgAjrwwaUA7ZxeaUgewi1nNtQTuaZWaQAewSRoPcqg2iCphZPJeQNMCBum/RHIj5ed2sKe29yhu+l+kMEk/xD0/ZuborQpmIGv+YRsq33/51qwQw+AlAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=r6+4up/F; arc=fail smtp.client-ip=52.103.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPCbS14t91gaS5+Hf2HlA3ZGPZxm9QvU9uP9qlpFSm09wa32Kz8wpJuO54LhS//7to4DZeWV7dfZEf7yWe7pZF5Jkf1yljtgnMDZ3fICKser528/abl4WIAFHIhB49DytrPFG0pDmIo4mHPv0PhFrz5zS8di5LgRTeooqeKiQa25pn0lqzs1oEY0PAYl0T2JApQ3kcbyYiy4S+4JVEz5fLzASUKKc+/+as1EElZfXRo7Of85YkJc/0r0EWHS9AiWJz0YDJ0Lds/j0BmeL78sbEA4L4UGnHLFGHwfrF33D8h7qTW2OnvrHsexF4hg3SMSSFle4WlHJgrGi9ZhWqqKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ81FctvxVw1zePeKIA9qRQTQX115vh08qBVar7KpqQ=;
 b=FdeJGCoq+gI047WdpmvfC88FJDzV6qVu30BjkrNNI9pfPSnspDQnxxr4CtA+pOim6YCv3F6pdpGM81L7A4a8nF2Y/VbiG5GBXXk9rLyNt9znpI6ODZ4wQR2TFGw9657iwR2pb2kTixdpmZoZWaTcNhcHLkupXqadHDyT8eXXKdDp3nSqLcYhmt9Jxs7d6xEh7r0h5cBHPw8/M1kQ4Vjq/nu31CjiCBFOzZ7wy9D6wwtMYb+jT+6OKZ6x5ZAHzsNSeWxx7yRIf3j9lntCP6HH7PjWVFPOCEx4cNx8if7obj8YzgH757ppmeWRdLXPr/NGPYyXsUbValXVfCbaEJx9xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ81FctvxVw1zePeKIA9qRQTQX115vh08qBVar7KpqQ=;
 b=r6+4up/FEi0MLv4rIbtthzXYNKFxHpZyAa3+w7Y2TLXPot3JO0CVCHVYZbIw9XXd6SyNMI0RpFDGhaEa0Xx1F3ajCTbRJQiXcALoPnG4itIQ1ar11XWmbZruBIB9w2OI8JA9JBdDAd6FLGlFgykpvHRvWv+1Rck82EqdnkCnKVn8a/3bwttsEYIiAuVFB8P5LWIiHBHHqmRiTq815uzgN+5cZjngqfm+No5ax+Jo5sScZD/ARJfnVy3Ipm/TcvhNixDPmNibGZ3XicQyBsl4jfa7aelE3BO5OuJVfNPk5dcV25TnPzUaxzZdqh5/lbUUr9Y9iPx/4qNZhZa6fmeWlg==
Received: from TYBPR01MB5470.jpnprd01.prod.outlook.com (2603:1096:404:8025::8)
 by OS3PR01MB10137.jpnprd01.prod.outlook.com (2603:1096:604:1e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 09:15:05 +0000
Received: from TYBPR01MB5470.jpnprd01.prod.outlook.com
 ([fe80::a7c3:4e82:38ff:65f3]) by TYBPR01MB5470.jpnprd01.prod.outlook.com
 ([fe80::a7c3:4e82:38ff:65f3%5]) with mapi id 15.20.8583.033; Mon, 31 Mar 2025
 09:15:05 +0000
Message-ID:
 <TYBPR01MB5470C91FC2902D16D3FB9707B1AD2@TYBPR01MB5470.jpnprd01.prod.outlook.com>
Date: Mon, 31 Mar 2025 17:14:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tools: Fix compile error of pfrut/firewire
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
References: <20250328074750.3524280-1-luriwen@kylinos.cn>
 <20250329010721.GA11319@workstation.local>
Content-Language: en-US
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
 linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 k2ci <kernel-bot@kylinos.cn>
From: luriwen <luriwen@hotmail.com>
In-Reply-To: <20250329010721.GA11319@workstation.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To TYBPR01MB5470.jpnprd01.prod.outlook.com (2603:1096:404:8025::8)
X-Microsoft-Original-Message-ID:
 <67a464e3-874d-4c81-8cda-c44ded0863f2@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYBPR01MB5470:EE_|OS3PR01MB10137:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6b36f1-834b-4573-3e7f-08dd70348548
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|19110799003|6090799003|7092599003|15080799006|8022599003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHRQSWxZNzQ0MkdOVldSclJLcGtGRzBZYlpMdnh2TGFRREZ5OHZSK0xNcmpx?=
 =?utf-8?B?ZmxjN3pobEZ0TUZMZnZEbWhhSHo4ZW95SEF0SDk3SDVYYjZJbHRVYzl3MGFY?=
 =?utf-8?B?NGcrRHgycFZtQkZoUm5BWldlNzA5Ti9RTHRVUFF2K1A4Nk5HY3pQQmw3dXUx?=
 =?utf-8?B?UmljTjlWOXVZZHRxNVQ4S2thYzRuOVgxT3R0SzhqQjRNRTlBSDhxUFpVeUdM?=
 =?utf-8?B?N3Z2c2dGYnIzamptUVR1aU9sengwU1BpNzY5UzhhbmlmaGYrcnFyazlyNG1m?=
 =?utf-8?B?TVNVSDI1RHdwZ0Z2U0l6S2xLeFpVV0R0ZHl4VitTWXZZZWpWeVFHVFFaU044?=
 =?utf-8?B?dlVhN3huVGJCWmRudnJXeVRiVml1ZVNoUTd4SGE1emI4MUFrRFhmZWdmZS9J?=
 =?utf-8?B?OExYT2tncVA1bUpVSHJYem1hVkd5Y25STjI4NHBQZ0pGSytKZVU4M2xKblAx?=
 =?utf-8?B?UjNpTW5FSXAwWUdnUnFUTkR2Ull5V3VqZEtvcVpQYVNubnp0KzZsRkYvNnBl?=
 =?utf-8?B?SExzell5SXUraVg3WldnbktxeEhtZm91VzV6amhqb3FTZHczdHUzT0JuL1Nv?=
 =?utf-8?B?TVlBaVVqZ2VHY1RpVUVrMEpneWNLck5WbFpSUEFuWC85SHdlaUh3TXVNeXln?=
 =?utf-8?B?N3lVVHNsMkErbWNEYVYrU0pJcy91bjlZZC9rbUJ5QWtZQS9yOVVoNlhhOWky?=
 =?utf-8?B?djVydzk3TVlFMkpoUWtyWFhpNDhud1FIdmFsSVh0M0Q0a1RIa1h3RHlaazA5?=
 =?utf-8?B?bDZkN3dpbkFkeU9CMW1kaEtTc2tBTHIvU1l0VERtalFoWGRXTVdkUHMvWGpN?=
 =?utf-8?B?TTE3Z3lqUVVFZGZ5aE5lVDh5aU8zSkJCc2pQUG9QMkhUNWFCREtJUVV5aHFz?=
 =?utf-8?B?QUNxd3Y0SDFiSEU5RUpFcE56WlMwamF2K2QxbXVBL3R2UzFJR004S0tzM0Z3?=
 =?utf-8?B?b1djbTZPR0tXaml1RGZVTitVM3RxR1BscE0yejBHaitYT2Nud2FUOHhMbUhE?=
 =?utf-8?B?WTR2TFlSZlk3L2hMWDJWbEE4RVkrMjViL05ieVUyYW1vdDhTRzZmR1czSHcw?=
 =?utf-8?B?b0srVkNWa3lDY2Fwc1ZPeUhpWkg5bERNVFdTbE54YVBuU0xiU3BWTmM4dXIz?=
 =?utf-8?B?Zk1LYUorOU9aaWNDek5CZkxSQ2FqWktQMjEya3JNQmFVQlRXNVBBUHdoMEE1?=
 =?utf-8?B?SjFGSTFQSysrZWEvMUtSSEEyTWl0Z1lEa1kwS05ZMm0yQlZYSTlnTmFNV3Er?=
 =?utf-8?B?YlQ5UmtmdXprK3VjR00rbXBkV2JNNU04d20xS0gzZHlnalc5WUlaM2pjN1Nq?=
 =?utf-8?B?TWwwczN6TTVyc1Q2VFgyYVp3blFrd2NMaEV0enMxQVZwV1orcjZ1UUdHQUor?=
 =?utf-8?B?Ynh4R1N0RWgxbmVGMWRnUDFNRW1EajYrcHFHM1hESERsSzJBUlFocks1NHpD?=
 =?utf-8?B?cmxuL2RFS0ZsS3dmb1NBMVFRY0NQWHB5ZlA4VkZZakdpclg5RE11SlRyQmpQ?=
 =?utf-8?B?ZEc3MlM4aXJXbGJsZjA2R3NXdVpiNnlGNEZnKzNNWlk2VllSUUM1Qng0dVdF?=
 =?utf-8?Q?4Qnx4G8QH+9fUUlbLQalBwqlU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2JWQ2pDTktmTnNqajg4NjkxUUdUV3dNZzJSU0l2TllMNW1VU1BHQmVMajBr?=
 =?utf-8?B?T0hmUmEwejBTcTZHbEx3cnhzSTRncC9PeGR0eFo4VFVYYTN2cll6TzhKSTlw?=
 =?utf-8?B?bmNxNWVYcytnOUl4N2NXYTk2VVdEeS95Nk9aNjAreVhRQ2VpSHoxWTJXNWtQ?=
 =?utf-8?B?NDhTZFdoQ0ZNY2JEY25yaTRmMFZtMm9NUkRTSGxDcXdkWFNEei9MZlhUK0Fz?=
 =?utf-8?B?RlJhS2tLUUN2Q1BPR00xZEdma201eXdmZnJCZVlSQk80MkRRenFCMjZVb1Iz?=
 =?utf-8?B?MWhyRThZU0ZYNlFJaEdCTjhScEhyWWpIOWZ6bnZ3ZFQ0ZlRBaTVOZGpWVXJG?=
 =?utf-8?B?VkgvUFVYNzV4UHlDcGVSclZhM1FaeXVkZ0F2WWpVUU1FSmpyVUJ1Wkw2aFZ6?=
 =?utf-8?B?WjBQejJIQ1RLcHhORVRZcWRFdWE1VVIydVg4S0o3dDI0aVh1aWQybGdWMFlJ?=
 =?utf-8?B?dHFtREV1b1QvcmF5NVJnT1RGTWdXdnFvNVlTRmpIK282dkkvd0VpTFlFMHpD?=
 =?utf-8?B?ZEZPQTJJQ0U1WDBJaldlYWIzNWM4Q1F5SVpFZ0tDaXJPWWZ1OUNJQVRzSDZ4?=
 =?utf-8?B?Q0ZBUEY1d3R0UUJ1NWJKYVBtMUhqSTZ3OUVSYmxENTdIY3lvSVphNVBiMEVQ?=
 =?utf-8?B?Nk1Zd3Q2UGNEM0dPaS9vVkxlNE5tV3QxT2lUZWdyUzhERXRDUU5vRktBcm9x?=
 =?utf-8?B?c01QNlpJN0ZkT1BIUkNqM25yTmJRbVkvK05XWVB4OUxTdlh3cDdsRkRvcytX?=
 =?utf-8?B?ck0vYmVQQVUvYjV4VVN6a3hpU2ZLeThBVmFXTCtGbUtxQU5HeU5Gd1EvdWJY?=
 =?utf-8?B?RkVuRnJqd3JRQm1SWlFmeDlad1JCU1RSNnBQbEg5ZlowT1Ira0JmNmFibncv?=
 =?utf-8?B?R1Nqd3RlQUpGRG00dkk0VzNicWxWem8xdGlsTGo3MFoyTWVBRGtyajY1WTQx?=
 =?utf-8?B?aVpMYmNmbHQxQkhpM3QxRll1Y2hrU21FRWtYWitRTkduOUFRZEhBa0R3cWVt?=
 =?utf-8?B?YUY1SDdXRzZRbHJOYnNUN0ZMWnNNcGdGMHdvOUZMaGlYckxlVzd3NTl2b0lh?=
 =?utf-8?B?MGVxS0VNR3l5VVlCTlFiWlZ5a3h3Zzh6YkkvTHlERml0eWk2aEZUNXA5TDdR?=
 =?utf-8?B?WlRSRWJvck1VVFZxaVVBM2h1d0RBQitEWmFPR1AvWDFsWTJ1alRRMG9DeXpO?=
 =?utf-8?B?b0V2b1ZQTGlpOHd0RlZtSVFrMmpSRndQM2FLallhSXc0a2srWGFvRlJUdlNR?=
 =?utf-8?B?WmFjYitOMTgrL2dKMmRmSzN4RGptcHVoRmFKWmEyRFJxeDgrT2dmRWR6UE50?=
 =?utf-8?B?MkFQdURGU3Z5b0IzZU45UlNJdlQ4bHlEclJEZUtDT3RYa3E3UVJpQTdOdjhu?=
 =?utf-8?B?SDkxc3crei9yRlBjS1M3MGhjc3MyVWp4bzVwZWF2enJCQTVCL1pnWklDTHpU?=
 =?utf-8?B?eGw1RDliRDRYM2RXUXU2WE9IQlFGdTk0S2p2aEFCVWpid1NFOVk5dy9xaU1y?=
 =?utf-8?B?WExjL3BCU1RvQldzN2VuMlRtdjUrdHc0MWdsMDFHVC9RNXdPbEtjNnJJeHJU?=
 =?utf-8?B?aWRITU9uRmxDUDVhREd4N05qd2x5UzZBR2YzbWpxR2ZDeTZybGdOaGtFeGw1?=
 =?utf-8?Q?542ieCREwS85/3vhTuB1Nt1COAcwSF+qUfgvTuMVpuyY=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-15995.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6b36f1-834b-4573-3e7f-08dd70348548
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5470.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 09:15:05.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10137

在 2025/3/29 09:07, Takashi Sakamoto 写道:
> Hi,
> 
> On Fri, Mar 28, 2025 at 03:47:50PM +0800, Riwen Lu wrote:
>> The value -rR of MAKEFLAGS implicit do not use make's built-in rules and
>> variables. Previous commit d1d096312176 ("tools: fix annoying "mkdir -p
>> ..." logs when building tools in parallel") removed the MAKEFLAGS=
>> command for tools and caused the built-in rules for pfrut/firewire
>> failed to take effect.
>>
>> Reported-by: k2ci <kernel-bot@kylinos.cn>
>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>> ---
>>   tools/firewire/Makefile               | 7 +++++++
>>   tools/power/acpi/tools/pfrut/Makefile | 2 +-
>>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> As long as testing with v6.14 release, I can not find such failure. I
> guess that some one has fixed the issue between the commit and the
> release.
> 
> Would you please recheck the issue?
> 
> 
> Thanks
> 
> Takashi Sakamoto

I have reconfirmed that this type of error does indeed exist when using 
make tools/all or make tools/firewire at commit 4e82c87058f4 ("Merge tag 
'rust-6.15' of 
git://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux") in the 6.14 
kernel.
The relevant error messages are as follows:
$ make tools/all
   ...
   LD       pfrut
/usr/bin/ld: 
/home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.o: 
in function `print_cap':
/home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.c:179: 
undefined reference to `uuid_unparse'
/usr/bin/ld: 
/home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.c:184: 
undefined reference to `uuid_unparse'
/usr/bin/ld: 
/home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.c:189: 
undefined reference to `uuid_unparse'
/usr/bin/ld: 
/home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.c:191: 
undefined reference to `uuid_unparse'
collect2: error: ld returned 1 exit status

$ make tools/firewire
   SYNC    include/config/auto.conf.cmd
   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/kconfig/conf.o
   HOSTCC  scripts/kconfig/confdata.o
   HOSTCC  scripts/kconfig/expr.o
   LEX     scripts/kconfig/lexer.lex.c
   YACC    scripts/kconfig/parser.tab.[ch]
   HOSTCC  scripts/kconfig/lexer.lex.o
   HOSTCC  scripts/kconfig/menu.o
   HOSTCC  scripts/kconfig/parser.tab.o
   HOSTCC  scripts/kconfig/preprocess.o
   HOSTCC  scripts/kconfig/symbol.o
   HOSTCC  scripts/kconfig/util.o
   HOSTLD  scripts/kconfig/conf
   DESCEND firewire
make[3]: *** No rule to make target 'nosy-dump.o', needed by 
'nosy-dump'.  Stop.
make[2]: *** [Makefile:72: firewire] Error 2
make[1]: *** 
[/home/kylin/remote/kernel/kernel.org/linux-git/linux/Makefile:1438: 
tools/firewire] Error 2
make: *** [Makefile:251: __sub-make] Error 2

Thanks

