Return-Path: <linux-acpi+bounces-12630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7B3A78672
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 04:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9BB16DEBD
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 02:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA673176;
	Wed,  2 Apr 2025 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="LJzQRq9d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010005.outbound.protection.outlook.com [52.103.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47644645;
	Wed,  2 Apr 2025 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743561407; cv=fail; b=ZXBGbbHCQYvurs7IVFPUQzkyjgZ4OKLZbJ9GgcVBTVCDjKBm8jliqu670uIwuSmctJh37IUYe0L71AbUcQXlGwbrZPf5soMQy8Q52xrZHk1ghGdpgxkPaRI8siH4aYC2D/HPzMneLqlYdZhP3tN3Dbs6bMW0qggazKW6C4rKtuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743561407; c=relaxed/simple;
	bh=72w52ftipQyVNpGYpTUh4vKPuGYSEG8jt4UXAsrl/78=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AtShVH9sbvrQIvcLUPSBZMaoAApKOmCt59L4ir9YxfL/SfnYZP1IHxKeI1cCa2FWBH7HuS0VeNo1WcfeISd7SpFT6xxPq9Ha3pshyZzI5skGLp/gWKiqq0a18LvF6XhLZotBm7z0FdXCxxtxR4k/5UrPRMkbF4x0SykCxUB8z7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=LJzQRq9d; arc=fail smtp.client-ip=52.103.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDi9Ah7h1jYwbewahpJco0fCO0d3uGec3RSo6OgLC7rLWbC7TjhmIYFKj7wFn/1zyQXo39FUitMOnqJuzQfasKTMMcCnF5ku2Wockxi0t52xR+PdHRa+Fqv9m3UlYZ+lv3N+F/v/bjA3tGGTjGy3WouUHx52x/G8JMPsVRqb1UTgHER4roOEVkUkwsHaIcNFH5DCq9YqEBmq7w0eK5ECwGZRrlbYj3eBHrmwKMoF6r5JBfI51BnNjRdvVqj3+Za9kaZPRsgasiD39EWE+dYc3Kp6Cvo4Y9TLKrSiESRaHuFEEseBRdf1Ra+nSmHKAjmRn3eo6NZn9Q54MQ5OCzHa9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC6DX2UmSar7VPefwgrH5PmZLyeGRuSb+gGjvWX8qZw=;
 b=sdoubldWJCf2pF29FD4/qMNY5FVzTe1/siE0X6D1TcA/MVip2jCFuzeN860mT+cmRqiKKhUWvklSXUU6tzlt59/0wxcHilFVAHfDNBrrFcT43gne3jAAIp7FjhjCh8Ukl+BxV8f/xI4BGyL9Hjr9vdvhUE6+0rf4JRqsvEUt0NaPYf/JkWC8aLNIepxWL94UbANijc3VsA0SREI3w1wzf0t+XGOqM0/NDo3VAxfYhXAgOh7o1RGHc+gC16hSzf3nXUCyAb2T/xCkkTktjcSYjBF+NRvzmpdWeH9nkfhXN8E9LArCWZc2u9VD3NKGTsl+pgTm2F7vhFwif6pOjnRVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC6DX2UmSar7VPefwgrH5PmZLyeGRuSb+gGjvWX8qZw=;
 b=LJzQRq9dppcdZhbW9RbaXi6F/ISyG9n3xQHH7tOk2JUt+iWy/YCAOUHC11wudHzGPMz1aMWu+wnxEpANsWgYxZQN8/4FRi8KUyuw5jdorRHhFX/N+bAvCcINbBcOfiIXkHQFDQ4SWZqEv7rgDgAoVgq6F9HQqX0ciIAnse1AAfMbMYZSdX09gIYiZXBgkHzsYO3XoNo6DiRtb39hxMOcuCVn2koBLWJkfYuaObzXCjLwpRIYgZA2s3n5nD7ItATBNUKb22rtRzu2076BCLbupaqj1S7DDBIrAKVasVS9cp/ijvxQL8yMcC0oaW08i+s9tYZ3XGtVaOLItA+mdIrxTA==
Received: from TYBPR01MB5470.jpnprd01.prod.outlook.com (2603:1096:404:8025::8)
 by TYCPR01MB11375.jpnprd01.prod.outlook.com (2603:1096:400:3c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Wed, 2 Apr
 2025 02:36:37 +0000
Received: from TYBPR01MB5470.jpnprd01.prod.outlook.com
 ([fe80::a7c3:4e82:38ff:65f3]) by TYBPR01MB5470.jpnprd01.prod.outlook.com
 ([fe80::a7c3:4e82:38ff:65f3%5]) with mapi id 15.20.8583.033; Wed, 2 Apr 2025
 02:36:37 +0000
Message-ID:
 <TYBPR01MB5470E7F3F1E80FF9842AAF75B1AF2@TYBPR01MB5470.jpnprd01.prod.outlook.com>
Date: Wed, 2 Apr 2025 10:36:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tools: Fix compile error of pfrut/firewire
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>, lenb@kernel.org,
 robert.moore@intel.com, linux1394-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, k2ci <kernel-bot@kylinos.cn>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, yu.chen.surf@foxmail.com
References: <20250328074750.3524280-1-luriwen@kylinos.cn>
 <20250329010721.GA11319@workstation.local>
 <TYBPR01MB5470C91FC2902D16D3FB9707B1AD2@TYBPR01MB5470.jpnprd01.prod.outlook.com>
 <CAJZ5v0jy21xWDSrTxSzg0YPBQYrntXvDYK-GZtH2we+qGjw3Bw@mail.gmail.com>
 <88a36c5b-8dc0-47b8-832d-366f0214dd11@intel.com>
Content-Language: en-US
From: luriwen <luriwen@hotmail.com>
In-Reply-To: <88a36c5b-8dc0-47b8-832d-366f0214dd11@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To TYBPR01MB5470.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::8)
X-Microsoft-Original-Message-ID:
 <40a19e1d-98df-4286-bfb9-ea0d405e22ad@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYBPR01MB5470:EE_|TYCPR01MB11375:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d638fc-7bc9-4888-2840-08dd718f3027
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|461199028|19110799003|15080799006|8060799006|7092599003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1VxbGNRVmZTT2ZWREtoOXBhakJSUmRYYlp6SXFTcG51OUNaVW1BdXhjc2Iy?=
 =?utf-8?B?b0wzVEZ0NTl4dk16TUttM3VLdGxWUXJOOHJRWTBBZVM5YkVMOGE4U0trdU9P?=
 =?utf-8?B?bklIU1pXS0w5WXFqMHRBZ2N0ZW9mV1hIUHBZMTlubjV4MkZ6OU8yTDJTcFcw?=
 =?utf-8?B?UHhOd3hkemo5YW5IcEpvWmllbVNNVGU4MDY4ekFHMFRjNXN0NGkwV3BsNHVn?=
 =?utf-8?B?V1QwbWZjaWxzYm5xNjJDY1VZSkMzM1F2djUxZCs4M3lsNkNua0FrdVhOUmtX?=
 =?utf-8?B?NWkxMmF6bk04eXN2ak85SnZKcTU5N1ZRTk5oWjlzZmRIQkloNjlDUTN4cU1R?=
 =?utf-8?B?VHFSRTFoVDdxVEVMeVRveXlIUWtXN3UwRjI1RmNGcFR0STVEdllCSTlIUVZJ?=
 =?utf-8?B?N2R4ZmRvazV6b1k3K2xZRmxHM1VodGtEUitQUmxFZlNrV0IzSWdSN0dOdXkz?=
 =?utf-8?B?dzJWYUgxU3FtWWpJdm9zakhCQ3FiQVVFQndEek5yRGFGUE5DQnJnRmJhU1pa?=
 =?utf-8?B?M0JqallmV3NlamJTdFJia2ZPTlFjM01Ga3VaSjMrVnRlblNyT2svL3k5V3lB?=
 =?utf-8?B?VzVVNG5uNHNWVG1hRk9HOXhISEtnNW5qcGY5TTZScmlQdU9iQTBQazdJcEI3?=
 =?utf-8?B?NG52eE9IMTRVcUFJRTl2cnQ2N3AxZzhteEJ1M2YxaGFvdDY0bkUzUmxlcitt?=
 =?utf-8?B?Z0dlUVZtWHUwZUI4U2MyWUdGTGVldFlrWGpXN0lIekYydTJGdFcvTE1OUnJ0?=
 =?utf-8?B?YW51S1Q1MU91VnU5anJRRUhMTXFuMUt1UXNsWU9zQ2VXYnp6L29iQnZHYWdY?=
 =?utf-8?B?MGtha0dZUDRCaE9Gdm9JWWduNVpFbE1PTE9ObUlOMFQyMFRNR2kxK3BnWk9N?=
 =?utf-8?B?RkUzaXpsOHNoVGtrb2F0VXdGSm9DVHFCYVcyeEN0bEQrb092MHpMcUE1c3hS?=
 =?utf-8?B?OVlGMVNtODEyaEVvSlc2UCswQXV6Qmo4a040T1MwdUZxS1JUUXdqK05QcnJX?=
 =?utf-8?B?VmZnbXoxMlRsRis0TXZ3aGFLZ1hkYVJId0dZTzBKMGo0YnNpWURzaUQ4YnhK?=
 =?utf-8?B?dUFZUWxLNEF3dWdTYVc4QUZrd3A0dWhaeEJFTHZRWXd5cXMrZGJMN285YVJp?=
 =?utf-8?B?ejByNU1xTUd4cnNlazc0bngxNi9xUmhxT1JmWFVYYWZiSnppY1R5NzMyS01u?=
 =?utf-8?B?cEExZmJscG1aOW9CNzQ0QjhzQVFLbTV6Z1paMHlpMUxoallWU09mU2lKMm1x?=
 =?utf-8?B?b055VUZQVDBVZ1EvR0p5am5iUzlSNGx2bmJJWE5tYzMwZ3hiQWRzalhOdkFp?=
 =?utf-8?B?ZFFNMEgxSVh6djA4QSt5WHlIN2FLUHA4MzMrakR6TVhBaTZzd3d0Zmtndy9j?=
 =?utf-8?B?a0t6ellMdkFKOEptY1ZGWUorZXJNUUNFdXdHRVhrcEJHS2JVdlpmZW5lRVk4?=
 =?utf-8?B?bEJzaFBJN2VjN3JxaHlIWUIrNDRJZ2FxdTZnZnNxWDhpNkF6VnUrZk5sdWgv?=
 =?utf-8?B?NFVvcGJpSGNKMTdjR3VxcGVnTnNnaTZmSGNnZTh3VElpc2wvN0QwY0dOYkpV?=
 =?utf-8?B?NkQrQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTZOSE9XOEE3bGRSTzBFdy9KMWxMVVVDOWVycTl0dzZvV0dRWXhwRlBHbStX?=
 =?utf-8?B?bHhjVmVLZG5PR25FUTVEK05Wa0tzLzRuemlINWQvOG1yUjV3ajVjRmZ5NGhF?=
 =?utf-8?B?S3cyeWU2NlE0OTB5MC9TcFNUZUE1bWFIS3B6WEN2YjJDNDdycHUvS3ByTlMy?=
 =?utf-8?B?WFA0Sk5tUmpPZEFjdHpWVlhBTEYxcTZOczh5M3pyMVAwdkhVN3Jsb0dqbzEw?=
 =?utf-8?B?bUlUbmdWWWRXZ3hYdVpZU1BiVDNQeUk0b2pINnZwK3Bjdnp0UUYrZk8vbGdK?=
 =?utf-8?B?UEtVbjFhekJ6OFM1QjZSN1EvV0dVVDFiNUY1OWVGcitPVElaT2hBYU5EdEpT?=
 =?utf-8?B?U0NVOWFuMW1DYytMdmkvL25CVytJUWVWRWhXTUhxSkJTczRRb3hSK2FkL3hi?=
 =?utf-8?B?SEYwaUR1QW5vc1lHdk5jblFVQzRkVlJsbUkxS01Qbmw0UDFLVXZhTGVPVTFx?=
 =?utf-8?B?WHBLc3p1bUwxUUxReW10MmN6Tk16eVlrbkMyY3ArQ3I4eC9nVWZPQk5DU2Z3?=
 =?utf-8?B?STA5bVRYTy80ZFM5OHVYdnFHRVdKY1VQbjZTUGlCTXpXTzhCME1qSkFqOUlt?=
 =?utf-8?B?bm5wOWhFNGFqY0hPWTRTa3ZOVktlT21YbnJmUnhPRS9DZU9NSmdDcGZFZ3Nq?=
 =?utf-8?B?ZGlpL3lEWWJRZUhvemJPRFhXczhqb2RpNWxHWWJCMFBTQ2tDNEtwTTJXT2hI?=
 =?utf-8?B?cjh3Z1ZoVmxDZm5VbGFzckxXbU40bFNHRmk2cjRVT3NoWUNKNHVwYzBmV01V?=
 =?utf-8?B?RWY3S1IrVGxuSjVSOVhLTDJiRnBNMW44YlRUSmNxaER1QTViUVlIV3AyUWJj?=
 =?utf-8?B?VCtkWkVyV1ZwaFFYQ2J5eSsrWXVxZkFHMmpOZE9Ja3luUnBFV1RnUlpUSG55?=
 =?utf-8?B?OVZpY1VOYVJVL2RuN2UvWUhYS0Nlc3RxTmF6SVRKWU10Q05ZN0s3RWJMY0VR?=
 =?utf-8?B?dlB2U1E1Q2dMWjA0Ulg1eC9LK0hFeWl5MXRMRFBOaFBNQXNQRVVBNG03aVg0?=
 =?utf-8?B?bnkvakpTWWJ3RE10c1h0THpsMWk4WHJSRy9WRTJlT2luK1dGeDIyTENTdHI0?=
 =?utf-8?B?UjNVZk55SVdsWnFEMWQ5N2MyMC9MSTVoNm9YTXcwQisxR0t5RW5lYmh2VnBm?=
 =?utf-8?B?cDZCYXFDTlFUVENISWFMcjZQdEhrbUd4L3lwKyt3WE15dUR2bFhud200U3Zl?=
 =?utf-8?B?d2dJVlFMOFdaR2k3MnlpMVEwaEw1Njc4RHByc0Vjcm9xUDNkMUl1dGw5TW9Y?=
 =?utf-8?B?c3N4Zyt0SVdhcnVubzY1UUNsV1N5VE5lSzJCNEc3R3h3aE93Q3VGWm8xKy9U?=
 =?utf-8?B?M1dFMUxpd0JDTzA4RzAxVDJXcGFxZ0FaNWJMa012amdZUHpWak5uSlVZSzVw?=
 =?utf-8?B?TVVta1YxdUgvMW5vMVA2cmR2YTc3V21Sbmdnc0huK3RqajBqZFRKaUlGaGlB?=
 =?utf-8?B?VWFlTFQra0lWc1BiaU1Sb2JXMUZJanVidDNpK2hvVU5uZkNSOTdtaE9uUjdz?=
 =?utf-8?B?Ym5mNFhKVDFleGdJWVZpa0Q0aGxqSGRSb1ZxL2VrNWx0OTZGdXoxWGc4Ym1B?=
 =?utf-8?B?dDh1YXZFN2JmQnpNSGRBc211ZEc5UUxHVkNVY0NuWVIwSGZ4WlVuL1QwSWxn?=
 =?utf-8?Q?v1h2uGOAfXD+4vjSgSUorpA/TKUdZPGrOZFq9BTNJP+Y=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-15995.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d638fc-7bc9-4888-2840-08dd718f3027
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5470.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 02:36:36.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11375

在 2025/4/1 14:56, Chen, Yu C 写道:
> Hi Riwen,
> 
> On 3/31/2025 7:52 PM, Rafael J. Wysocki wrote:
>> On Mon, Mar 31, 2025 at 11:15 AM luriwen <luriwen@hotmail.com> wrote:
>>>
>>> 在 2025/3/29 09:07, Takashi Sakamoto 写道:
>>>> Hi,
>>>>
>>>> On Fri, Mar 28, 2025 at 03:47:50PM +0800, Riwen Lu wrote:
>>>>> The value -rR of MAKEFLAGS implicit do not use make's built-in 
>>>>> rules and
>>>>> variables. Previous commit d1d096312176 ("tools: fix annoying 
>>>>> "mkdir -p
>>>>> ..." logs when building tools in parallel") removed the MAKEFLAGS=
>>>>> command for tools and caused the built-in rules for pfrut/firewire
>>>>> failed to take effect.
>>>>>
>>>>> Reported-by: k2ci <kernel-bot@kylinos.cn>
>>>>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>>
>> Yu, can you have a look at this please?
>>
>>>>> ---
>>>>>    tools/firewire/Makefile               | 7 +++++++
>>>>>    tools/power/acpi/tools/pfrut/Makefile | 2 +-
>>>>>    2 files changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> As long as testing with v6.14 release, I can not find such failure. I
>>>> guess that some one has fixed the issue between the commit and the
>>>> release.
>>>>
>>>> Would you please recheck the issue?
>>>>
>>>>
>>>> Thanks
>>>>
>>>> Takashi Sakamoto
>>>
>>> I have reconfirmed that this type of error does indeed exist when using
>>> make tools/all or make tools/firewire at commit 4e82c87058f4 ("Merge tag
>>> 'rust-6.15' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux") in the 6.14
>>> kernel.
>>> The relevant error messages are as follows:
>>> $ make tools/all
>>>     ...
>>>     LD       pfrut
>>> /usr/bin/ld:
>>> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.o:
>>> in function `print_cap':
>>> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.c:179:
>>> undefined reference to `uuid_unparse'
>>> /usr/bin/ld:
>>> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.c:184:
>>> undefined reference to `uuid_unparse'
>>> /usr/bin/ld:
>>> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.c:189:
>>> undefined reference to `uuid_unparse'
>>> /usr/bin/ld:
>>> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acpi/tools/pfrut/pfrut.c:191:
>>> undefined reference to `uuid_unparse'
>>> collect2: error: ld returned 1 exit status
>>>
>>> $ make tools/firewire
>>>     SYNC    include/config/auto.conf.cmd
>>>     HOSTCC  scripts/basic/fixdep
>>>     HOSTCC  scripts/kconfig/conf.o
>>>     HOSTCC  scripts/kconfig/confdata.o
>>>     HOSTCC  scripts/kconfig/expr.o
>>>     LEX     scripts/kconfig/lexer.lex.c
>>>     YACC    scripts/kconfig/parser.tab.[ch]
>>>     HOSTCC  scripts/kconfig/lexer.lex.o
>>>     HOSTCC  scripts/kconfig/menu.o
>>>     HOSTCC  scripts/kconfig/parser.tab.o
>>>     HOSTCC  scripts/kconfig/preprocess.o
>>>     HOSTCC  scripts/kconfig/symbol.o
>>>     HOSTCC  scripts/kconfig/util.o
>>>     HOSTLD  scripts/kconfig/conf
>>>     DESCEND firewire
>>> make[3]: *** No rule to make target 'nosy-dump.o', needed by
>>> 'nosy-dump'.  Stop.
>>> make[2]: *** [Makefile:72: firewire] Error 2
>>> make[1]: ***
>>> [/home/kylin/remote/kernel/kernel.org/linux-git/linux/Makefile:1438:
>>> tools/firewire] Error 2
>>> make: *** [Makefile:251: __sub-make] Error 2
>>>
> 
> Maybe add more background in the commit log that, the default
> MAKEFLAGS in Makefile under Linux's root directory is with "-rR".
> Before commit d1d096312176 is applied, the -rR is overwriten by
> the subdirectory's MAKEFLAGS, so it will not cause problems when
> compiling the sub-directory of tools. After commit d1d096312176,
> the -rR takes effect, which prevents the tools from using the
> built-in rules and variables. Maybe also added Fixed: tag.
> 
OK. I'll enhance the commit message and add a Fixes tag.
> Regarding the prfut Makefile, we have fixed the LDFLAGS issue,
> but the CFLAGS += xxx will not take effect, right?
> 
Correct. The CFLAGS += xxx is not take effect.
> This reminds me that, is it possible to just remove -rR for the
> sub-directories? In this way we don't have to change the code of
> every tool one-by-one, pfrut, firewire...
> Cced Masahiro for guidance.
> 
> Something like below:
> 
> diff --git a/Makefile b/Makefile
> index d138b17b8840..853be42ca1a1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1431,12 +1431,11 @@ endif
> 
>   tools/: FORCE
>          $(Q)mkdir -p $(objtree)/tools
> -       $(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C 
> $(srctree)/tools/
> +       $(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter-out rR,$(MAKEFLAGS))" 
> O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
> 
>   tools/%: FORCE
>          $(Q)mkdir -p $(objtree)/tools
> -       $(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C 
> $(srctree)/tools/ $*
> -
> +       $(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter-out rR,$(MAKEFLAGS))" 
> O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
>   # 
> ---------------------------------------------------------------------------
>   # Kernel selftest
> 
> I believe this modification is more appropriate.


