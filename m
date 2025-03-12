Return-Path: <linux-acpi+bounces-12156-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ABCA5E76E
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 23:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0803AEFC7
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 22:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15691F03DE;
	Wed, 12 Mar 2025 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="fKCD7f2n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022104.outbound.protection.outlook.com [52.101.43.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A0A19E96D;
	Wed, 12 Mar 2025 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818523; cv=fail; b=iyKW57RXxeFuDvdzX0iP6qhra0YNTvYBf25mppvw4I34Xgs7Ask9rD/MDpy0lP3r6nVR86wQJVRS0q14o9s95jtY3fn22T3BY55GSMggkIIrybXdY2fW0f55EN7f9zBcJ+jfUt0yRSutQp1I6crAhTb6iP6LoRDCJnj0F7Y3LhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818523; c=relaxed/simple;
	bh=8WwiKnGI3hYZqkVRTnFGOUk9ccCqt6z8ONEz422Y9qQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CeyrLx1U09svD7u9ltVFjbYyzLKctZbieN6lxVfKkoqEKll03gZrk086PWhlRJ/2Zre0OxjaOf+9XbD2kY9DKRTB5Mhdsy0w/yZiv9ZTKobH/gqZ1aDK+37PIt9JQTYoYGe4vjxWH0EW+yegdJet19YtKqVRf+M+ZebOlX7SVjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=fKCD7f2n reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.43.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krcCCFU0x6fmkPG192PPsRZk5UG7D5oS9QZgXNv+jvJbdFYcHuD8uEeVfU6rJsA916YinRJXhBynOYThTwAsPDxxcEtNwZg/Gtffn/aOandRSh2BPVWUds4XMIhcrmy1m71V80gnJqlycU5miwFCTCjEG4SgSGIblm0MQ9Dq5fetcZezwMNiUtGEscqXU012qGffV5bKdMElEoUHUnnlQVybqEsJn0qaZPTr/LSv/whkQVbsSWdFjBL2NCw6zyZeitCCXk5i59P79ANWcGnCwrSxSVtMDk5uQ+V44Qbp8KAW1lui3dQAEMulTxIL9BHlXoyp/MksQRQBjRrrvzEVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AUmWHCuGPNR1SnCJxwvyMqSBm3z0vaT2oZtrpezuoc=;
 b=gGe+QNtZpDLqvBL+V9cv4tDQHxTADMnExlaKOEgyVYAhELNiHy8etSFCzpbFOC3CdCtUv28csjCx6h8bP0Tbramwpgd7zcvRyvgWgZj1KaJImxZz06k6fXdltX1m7oAMIrr9cayhLu4lupIXflKXgaBVmMNa/6Cd/Y4Is0Mr+KZXjQltadeYnyEanWDiQp2/vSe+psupCIOtNrnYNSPXwFdtam5Z9jHdbgT/wRgQeuxrPOHISuEGsQA1YDcifAo6ZCcnikEC7scUg/ASLohoQiTPHScsyrCOjldcgOW6WVp1XbAV6k3dQeFKi4/nVPlLw6lvgaacl6PuM1EVRQ7Ztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AUmWHCuGPNR1SnCJxwvyMqSBm3z0vaT2oZtrpezuoc=;
 b=fKCD7f2nPFdkvgHhBF4Sx3kht0fwBtK9pdJBy4KC4w+R1jF4BXGLOgu+ZECDyo2Bzq9aylYL7BQ8IjlJDgrQq4+3Kl4ipJbF10pgPtTohnbIzcD/rhWHc/waK/ZZKw1Po3uWwVS/ZFh0M81xtyLGAA8EMbXwTA1u5hAPevNpPNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ2PR01MB8402.prod.exchangelabs.com (2603:10b6:a03:536::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 22:28:37 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:28:37 +0000
Message-ID: <880286ec-b499-4edb-bb22-c42bf5a64e2c@amperemail.onmicrosoft.com>
Date: Wed, 12 Mar 2025 18:28:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] mailbox: pcc: Refactor error handling in irq
 handler into separate function
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-6-1b1822bc8746@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-6-1b1822bc8746@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ2PR01MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: cf5d504c-4b90-4209-d4f3-08dd61b53bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWhEWlV6dDMxbjlreE9yRkRnZGdYeGNsa1E0ZzFHUU5XRnNuQldiN0o1TEUr?=
 =?utf-8?B?MkZkME9HdnBJVUdnVXM0dnBVOGVJb2hmczRkMnVZOHZOeExUYlFpcm13bndm?=
 =?utf-8?B?UW9yYWZ3VncyeVE5Lzk1bVU5bXNwcGR4K2hBeE5NbXZDVElvaTlyRC9oVkpO?=
 =?utf-8?B?a1lCZkhQaElXekRmVmkxR0NjZ2psdklzWEVEd3hxQ0dRRmpDZXFpbHlmWk1k?=
 =?utf-8?B?N3BwVFBmZGc2V1VyV0pXWnF3NWNudDhrTFhhR1daOEZOMVF4Z1h1Mmtqd1RL?=
 =?utf-8?B?UEFma29Kb0kzOGRMeGFiT0ltL1FvaGh3dm5GVTh2RlZLRm82YnMxenZpUXhw?=
 =?utf-8?B?SFp5UlRMQzZYRlJGTExFdS8vdGNyQ1FhMHZ4V01qSnk4QjZhT1pRUXZsS1Bp?=
 =?utf-8?B?T0hMeHYxNVQ2dU80eCtsTHlVMDlKdjFER3lmMEVrT0xaVUpnVzlUK3ZBdWxO?=
 =?utf-8?B?Q1hqVDhOOCsxOTB0U3l2ekJwMUVUdEh1aHJwOTlMRENQbnE1ZTBLTzRGbTdS?=
 =?utf-8?B?MmlnemFId1RJYTllTHRzemk4WnJPTzZNM3VMWDFSNnV2eFMzWEd2b1BxWW42?=
 =?utf-8?B?RkQrQ3RUSG9PelFmMDM0RW04MktTTXk4eVlRd2hIM3RzRW5KZXpvU012Nlht?=
 =?utf-8?B?L0lVb3VnQldUcDFFbURUMjdlT3NXdWpyTmFDSDYvNEk3anFpbjJ6SkZnL2F5?=
 =?utf-8?B?R0JQMzdsUE1RQ0p5QWFia2ZOZmtKbzdtU20yd1hoRFdhNENYQjMyd29zeEF3?=
 =?utf-8?B?UUJibXRnbGx6NEhzN3ZQcUdVaUp0ODFVbXRpWUJsZXJzY0N5eFJUV2Irb1cr?=
 =?utf-8?B?YnBhZC9WN1RnOEN0N3IwOGdyeFE4Yjk5UlpmREE0MUlNM2hjUm9ESzBvQUVh?=
 =?utf-8?B?dGZaeXZiSHM3azdPVTEyMHRTUGt0b0dGVkxoM2R2eWdLcURMbnlqQU9LeTly?=
 =?utf-8?B?M0l1cHBYcHdrT0dIZzZHZ09OK1FKKzUzVGRoeWNjc3piK0VIMFY2WSsvdTk4?=
 =?utf-8?B?YXNLNkhUSHMrb3JSOEN2MUxjVnErUDlyajhPb25xaTlSTG9RV3JkcFVVY2Mx?=
 =?utf-8?B?aE03NnRzU3FIWFdkejl2SGZqUi9ZRHpQNDFoSnRPVWo5bU4xTjJweDhsc2pT?=
 =?utf-8?B?YkhPTFkweFJncnJsQmJoUnJYQ1VhaUJLTTJWZXcyT3NXbko1UURQMWJDbDNK?=
 =?utf-8?B?U0p2Q3d4bU9kYnI0azd2TENtWEVuamJMaHBCSGQrOVA2eG5XYzFrT2krUWE4?=
 =?utf-8?B?cVBQOHBGZWNnVkpFdlBqOGdLcGhQM0pYclFsNU4rbzZLUEtsYnRNQ3RLOGRJ?=
 =?utf-8?B?NVhQTXVpdzVwckhEeW5UdGR5UXBpN1BWVjhkZE9FcEtTWEFyVTFHVURLUHhT?=
 =?utf-8?B?NTh5czJpbFFPeW5TZmRmQzltYlBPcHRieUxtM21KaGEvSUllY1BBejhDUkJR?=
 =?utf-8?B?dmZBNUxUVStnRnV3bVdLbS9la2x3MEVORWJGZk9VTEZvMTNzNDFHdFdlcm55?=
 =?utf-8?B?SjBqbHpZTG1qc0lzMGRtQlV6VHUxN24zRjZWSjRIKzNpMjlUNy9NVXRqVWI5?=
 =?utf-8?B?Rm1VckRCRnFEenY1bS8zZ2RTbHRwakEwMFc0ZjVGWkV0QWdYWFVlTVVUR0lv?=
 =?utf-8?B?QnprRVZrdHdLZEtiYk5odTdLMU9GNnNsZGxBb0NpQktWbVFsYWFZSmF4RGo5?=
 =?utf-8?B?TXg0UjZTR05xd3dndFh2OVlDdk01ME5mZ2N4ZlRnSUJ4UGdxSjkvbWVEeWpE?=
 =?utf-8?B?Q1V0R2tVSWdzMkVGanNBd3NIZXJWUFRucFdWUlNvaGdRbTZNbFVIMFhJVDlh?=
 =?utf-8?B?Uk1RblZYR242SCtXaXNucEx5WlFhQjJ0blBNcW1iOFIweWJGdUp5RnJjaDZa?=
 =?utf-8?Q?ikYZg3jA1jBFr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEN0NnhyRnFpWDNpZG9WUFFCSndUTUhwYUhwTko1ZGppeEU3UHRUa1JhVE5X?=
 =?utf-8?B?NUdNL21pS2JUK01TNTFBU1NFbEZpeExNcGNUQzdvbXNMY2FrN0VNK3l3ZEgv?=
 =?utf-8?B?dnVoeEhQNVo4ekFQYzNETXJCbDh3dU03T2MwR0ZuMXVnZVNvN1lray8rdDVn?=
 =?utf-8?B?dENXQnRJNWozVzI3MDZ3Y1NnTTlqeGlldndOTlpvbDN1c0o4VERCcm5IeXMx?=
 =?utf-8?B?T3QwUEducGlwTW1OdHJTN1RYU2RucXA1SW5GZHlJVWhMZStZZksrUXpvc1V4?=
 =?utf-8?B?VjNZeHRrcnI0MEFDMSt0ckVMN2dZV2s0WXUycU5ib2g3cjl6Vm9oUU1VT3I0?=
 =?utf-8?B?cldsOWt2aEt6ajN4WVNCbjB6RXB0a1p4Y2grV3RMbFFseU1BQmpkZTJ2Qitl?=
 =?utf-8?B?RUJ0R09wMFBXbnA2WEZlQlhFc3pGWi85WkR1OWFkT1pPVEpac2prSTZ4OFM1?=
 =?utf-8?B?bXQyck9wem1QZG5yMUZsSURrZG5XT3NFdU5tVjF2ZXQ5LzVIYUl1OEhFNk9J?=
 =?utf-8?B?QkpqSUtwLzl2SFpSdzlkTkpwNXFDL3B3Qk4raGhTUCtIWEpML3VhUUROVEIz?=
 =?utf-8?B?amZtZVV5TWxJY3J4YVAxR3lmYjlvQ3d3YW5DaTFneXc5aVkrMFUxOGdOSkl6?=
 =?utf-8?B?Q2hBSWQxVlZ5MzFNWTREc09iUWcvZW96UzlTRnNxcHNFcHNEUWdWRXI4OUdm?=
 =?utf-8?B?VFpyamxiampvb0Fzdy9JcGttaEN0RFhzZnRJNzhXSGY5TXRJYjZJMXV3UXdq?=
 =?utf-8?B?TXhNNU1IZjRwRE5ZUUg3Q3puakczdWVjTXBnRzZ1Q3U2dzllSnVKY2hLVTBZ?=
 =?utf-8?B?elNyRm9IMzJUR0JSeXFxd0ZZUTVHazV3VmVFbEpkOFlrUktlbTQvdG5CNGlv?=
 =?utf-8?B?dEtWUU1yeVNidXpMU0o5d09GakZzZHdGYm9UQm56YXlQYzR5WUlrdEQrVWl5?=
 =?utf-8?B?MXpNaHVvVGlLaGsrU2hlSGQybXVINWJpb2RZK2x1Z2VCb2lWZDZFRGNDQ1hp?=
 =?utf-8?B?VGdHY3BqUm5JOW5rY25qTTBOUjVYdElqZDBjaDhjNXBXSXRxNEZBV0kzMXdF?=
 =?utf-8?B?Ni96VzFpR29zZ0YwVko3VTROYmpETC9OaFFFUkNGYzU5L0pTYUVoS1g0Q0ZT?=
 =?utf-8?B?VVFGQnpnNzMvUlFiSEVTWEdUSXZGNnlROHM4MVN0TUdLK3VlWmRMOFpvYzFW?=
 =?utf-8?B?dUl2UXBVK1J0c2pkQTE0VnNhVXRZRDJ6ZVNVYlVSYTBIUk9xSjg3TEtQdGVk?=
 =?utf-8?B?STNTamJqWEJBSE4rNUJzUFk2Y1d2bVVXRllwWlpyYUkvM1lRYTJ2MGk3RURT?=
 =?utf-8?B?Ni9zQ1J5NGNkaUYvTEFKbEdCaGFoVnQ2Yy9KNHRzSE9yMDYyblAyRFByZ1dN?=
 =?utf-8?B?YXlhcTNQRmlXWWpzVC9IKzBKU3N0Z1NUeUdSS0RtQzh3bTV1MGpyLzh5UExW?=
 =?utf-8?B?RXdQOHROT3JoTUc4Q01DVjlEZ25qREVzekZDeGZIOUFRYjlrSGdmakREdE53?=
 =?utf-8?B?djdEUGZrUzZpSmR2OVY2aEtBRE1uM1NOOWFIanlWc2Y0eGlLdGZaQjE4eUY4?=
 =?utf-8?B?L2lwUU15VFZzNTFjaUxobnpNSVNoU2xhcTRBY0hjZkFwMU9UbmRvczlrd0Rq?=
 =?utf-8?B?MGgyUTBFa0IyU2piUVNqa21CSXlScHl0dmJDd0gvcWFLSlpiUDJVMVFOUXUv?=
 =?utf-8?B?TlpaNldxR2p2N2FvUTRRNGpEa01XdW51UHc5cWV3MURQZGV6U3MrUzE5K3Zw?=
 =?utf-8?B?UXRoajdPUDlKUDVOdFkvakxGekgxVGxMYmdlYW12dGFBYjhKQkNCbmhzcW9K?=
 =?utf-8?B?ckN3Zy82VnRVbFE0WXFZdFJnQmJad3JPamY1MmZRc0x4UG9iWmVvc0F0WXdB?=
 =?utf-8?B?RDF0MFRzejBsRUxVYkxQQ2hoK2p0SGtXajBEc1pzUElWcklURHVkMWpadUFJ?=
 =?utf-8?B?MW5Mam5mK3dDK0IxWUxKK1hkblRIWUIyYXRjMm02VW80bS9PKzVTZnRRSUlM?=
 =?utf-8?B?N2p5ZUg4SXRRVDV6TnhWYVZScUN4WlV1ZCtwSGJHMFFidjdCb2NSM0x1ZDJP?=
 =?utf-8?B?d0RHRndzOXBDeis4Z3VzOXBQYkI0U1FDdFhOazVsZ0JlTU13ODVJQk0wSDRK?=
 =?utf-8?B?azJOSzFHSmJDWVB2QVBqR1Bzc1F3RFM2UzltN2VGSkFLWVY4Zm9NM2xEVTll?=
 =?utf-8?B?RDR4OFB2U3QxeXEwZHhzaDNFcjZLcWF1UktzbDBET0tjUE5oSXp2R2tSMGs1?=
 =?utf-8?Q?NtVJIemnw88zQbSHc7mztDZOWd96ocFqzHeW+BUHEc=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5d504c-4b90-4209-d4f3-08dd61b53bc5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:28:37.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRFRHm14QM7VVrHd/pUA70lQzACJU0SOMpuRGdV2QfJEWB6IxUUtJMBf5YldikKIzLhidCyCeS7GvRp+L7gMA0c125H1hHHsjXQieulwsosCQ/I8MNbQNevQTE9yQWSx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8402


On 3/5/25 11:38, Sudeep Holla wrote:
> The existing error handling logic in pcc_mbox_irq() is intermixed with the
> main flow of the function. The command complete check and the complete
> complete update/acknowledgment are nicely factored into separate functions.
>
> Moves error detection and clearing logic into a separate function called:
> pcc_mbox_error_check_and_clear() by extracting error-handling logic from
> pcc_mbox_irq().
>
> This ensures error checking and clearing are handled separately and it
> improves maintainability by keeping the IRQ handler focused on processing
> events.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index b1b8223b5da7002fc522523dbc82f6124215439a..41bd14851216e8c4f03052c81aaf938a5e5c5343 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -269,6 +269,25 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
>   	return !!val;
>   }
>   
> +static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
> +{
> +	u64 val;
> +	int ret;
> +
> +	ret = pcc_chan_reg_read(&pchan->error, &val);
> +	if (ret)
> +		return ret;
> +
> +	val &= pchan->error.status_mask;
> +	if (val) {
> +		val &= ~pchan->error.status_mask;
> +		pcc_chan_reg_write(&pchan->error, val);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
>   static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
>   {
>   	struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
> @@ -309,8 +328,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   {
>   	struct pcc_chan_info *pchan;
>   	struct mbox_chan *chan = p;
> -	u64 val;
> -	int ret;
>   
>   	pchan = chan->con_priv;
>   
> @@ -324,15 +341,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	if (!pcc_mbox_cmd_complete_check(pchan))
>   		return IRQ_NONE;
>   
> -	ret = pcc_chan_reg_read(&pchan->error, &val);
> -	if (ret)
> +	if (pcc_mbox_error_check_and_clear(pchan))
>   		return IRQ_NONE;
> -	val &= pchan->error.status_mask;
> -	if (val) {
> -		val &= ~pchan->error.status_mask;
> -		pcc_chan_reg_write(&pchan->error, val);
> -		return IRQ_NONE;
> -	}
>   
>   	/*
>   	 * Clear this flag immediately after updating interrupt ack register
>

tested-by: Adam Young <admiyo@os.amperecomputing.com>



