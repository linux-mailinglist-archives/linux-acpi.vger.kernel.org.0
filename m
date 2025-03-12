Return-Path: <linux-acpi+bounces-12154-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F102A5E769
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 23:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1AC3A5BE5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 22:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420B41F03D8;
	Wed, 12 Mar 2025 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="jAJ6dPBw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022080.outbound.protection.outlook.com [40.107.200.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4581E9B32;
	Wed, 12 Mar 2025 22:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818444; cv=fail; b=XSZ68wDK5HT8iaAR0Itl1R1vhbMX+qHkjjZNZmhKL5LR4GsWFyQRIQqiW0VsWR+fXuzDEsdsQKfw0ENEYVpWx2NSPFFomXvopfXU0HYh36TmpIHm5vKNmIl+L8ILB7r0t1LUoiwPZPd4424XelIHz9ulqXneHUlnyCZGW6B5Fd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818444; c=relaxed/simple;
	bh=VBw1aSBmKHt54Zw6KU4kKIxiXAQf+jFEiPDjKZY54i8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CrQ0oODXwny1Nrvmi6xhiSrN5oiYeihOtE3LQOHBjKd6oD/QM/t+7k5okz1NxnbmCLTR8pyma029GQO7MoYuO6O0/6ros0G68A2oVuJlZd0fy3ZjHNx97TTI4LMPzuu9sZ+OV7w6J4dRsW02o6tInNm5r79SM+56409lwdXOQCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=jAJ6dPBw reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.200.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y68ZSr32SkMP0EYL5ZO3vNZmIwbTtrlp84i0Xw54UDRLa7hSlmYlIbC5Cno6ocfLc3hG3CYI9MkEK6luEQX6fhDBHN7rlpdN1mtTlg78O0TK/db2csnhtjoxLgPvaxMC8Qr0cbY3ZIZ0WHA4SS1Z2ilO/FX/exVzyeOFteQIPG9C94hlMGhDvKBhWD22JXbpapvc8jEqK0/deCpyNmWlCnb6aUmQK6pqS6HXK7WBywqC0tkNJ9a2ADdyXh4NLbOcrurgEFP5yf4V13+fhnJ0MXbGRq5bFNhUy1XThpJEPz0O/WvD1lhm+FSPFIHlKJik2ntwNQ35faA9XisUNcdkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx11PMYLO00idwqQd1IMBNbiwIxvJgged5UWUV8HqiQ=;
 b=zGf+5Hgj6b/I9AZ+UIv5TK6US1M/kwi3hW8tS6mA6uki+B5Y0/Bdwwq79c/o8e8AvnrtuItxPW+N03ol7t41oegbWf0aX+H08mqg3WQpLdrBJISnPGs0+G2GxX5wn+6KIQR785bQZeHnvKfkVEntPR+Q2tUoBuZ4nDJBgDcovmjNnvS5TUp3X7GqCpWfDpmBSEyNd5G/7KiIeURHUefS93ZPzMhBbwFDu3DYC4XQSUug5lKtr3lGQ+bgTSosbT0ydMCpJUfrDce1PuxRnlQP3MH04Nn4YX2vRVcAGcb50HRhobZq4Pzkt+VslNRnil+zVTiBW/6NRJTqmijcrcfo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx11PMYLO00idwqQd1IMBNbiwIxvJgged5UWUV8HqiQ=;
 b=jAJ6dPBwVqTAQK+znkqSVVZ+R3I46YEQuUIcwCZHWrb/5bMpJ+F59yfIumtTXptKjY1KGtcTbcewJdoA39asOt0EXQDdDHsS96ASCmU2OjjEPaKk8uxHoeTaFMwfKZ2u4+YMOwGuFz+RfQ73BdJh0+9Fe8SSBgZnuB7uJBKci/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BY3PR01MB6788.prod.exchangelabs.com (2603:10b6:a03:360::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 22:27:20 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:27:20 +0000
Message-ID: <8ba294b7-e626-4ea3-af9a-48081f984f17@amperemail.onmicrosoft.com>
Date: Wed, 12 Mar 2025 18:27:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] mailbox: pcc: Return early if no GAS register
 from pcc_mbox_cmd_complete_check
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-4-1b1822bc8746@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-4-1b1822bc8746@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::24) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BY3PR01MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5ef859-cba6-48b3-5451-08dd61b50d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFFmaFE0MTRoZktKNWxuVWYzRG43Slc4ZjVrOXdLVjVDcTI3OGtXaitEQjBK?=
 =?utf-8?B?Tk1YZTVnbW9UUUNvdGh4MXBxYkZ3a0pzelNVeEo5Ymp4VUtPbFJQWTJmaG12?=
 =?utf-8?B?QjdnUHpHRnVEWkJXckdCcEpScndFZ29Fa2xJWmZ0UlU0bnBJbC9uVDRpY0xx?=
 =?utf-8?B?ejdsbmhLK01XOFZmQTJ2Vldma1YxS0tkaFZIb2xYd0hSUnB5OTQ1R1lFb2ln?=
 =?utf-8?B?RnEydkZIWUlJQktjekpPMDdvRStueEJDVFBFcmNhb0ZFR0FYWkYwZ0JVcDlZ?=
 =?utf-8?B?YWUxNzlNUFNweU1wZ3pFK0VDVXpxTm5MVC80dEgrSk9KV1MwV2E4dWg0SkNR?=
 =?utf-8?B?cHRkeXNqZzhiWnlxRWhjcEZUQ2dwRTFoSDhuNlRDWXZYVExyVVZGQlBFZENo?=
 =?utf-8?B?YmJTNG5BYnBMdG00VWY1YXlXOGFXcU5MZmVmNnJxT3pwRW9USGw1THY0Mnlk?=
 =?utf-8?B?N3VOSXBzbDd5OGR2dGhzV2Yyei9vUHdvSlBPYUk3Ly94OUdWYk9wQXgzaENY?=
 =?utf-8?B?QlBLajlqVXhWTkVtczNhQ2JPVkpkT2dsK09kcXdJWnRVTTlCdWJZWDVRQWI3?=
 =?utf-8?B?aldyZHBIMWpLMDRodytDaVY4V1pWM0tBYVFYQlBsU1lRRkl4dXRHZXQrU3JN?=
 =?utf-8?B?USs2THBONXJLWGpBYzI1c0d1U2tiM3paVUxzU0Y5ZjBOY0hLSXkrRytJdDFF?=
 =?utf-8?B?ZFlQbHE4am9QYVBFTEFBQzBKK3c0dU9NRHlkQ1g0dnNUTG9JckRnMGhwMjZR?=
 =?utf-8?B?aEM4dldlbjBkVTZQMlZxekMzU05XcUhwUmErQWhvSFFsMWZ5akd4cjFIQzJF?=
 =?utf-8?B?VUVyaUQzS3U1VVZ0RTRnR2x6cmJTM2tOU3ZoWEIvekxFSURUWVFmWDB5OUpt?=
 =?utf-8?B?MVVMV0NTbVR6OTc4UmVSZTYyREdsNmdQUzRFVmZFNHVvVkVkdXBsRVNxYjk0?=
 =?utf-8?B?R1c3cGlxTjlJbUlnbUdQemZEdks3Y3gwN2Zhd3RYNzB4SCtpOHBHS3FFeVJ3?=
 =?utf-8?B?VHZTQU1Bck8rZjJLODhmUXdmcll1WVZvOWJpZ1VLTEdmVWs0S2RZckxqODFF?=
 =?utf-8?B?VmZlMjdwNURsM1hvc2dMY28rdUY5cUVHYTljd21aRzZ3b3RaOEJSSlVXQmNx?=
 =?utf-8?B?em8wbEFITExWUXhtdUFyQ1ZKbjNYUm9kQUVmbUxkMzE2bUl3MW5JUlVEem9i?=
 =?utf-8?B?NGlPelp4NmFYMzRaOERNaW1mNHE0VWRiTndid1dYME5xc09vQlB3dFBWRHhD?=
 =?utf-8?B?STJGOG05cER6UW9xTm5ZM0N1QlFqR3cwK2ZseVk5T0tyUWVFV01qM0dDbXo2?=
 =?utf-8?B?M09YWi92azJTR0tTZlcxTWVWbWFlaTgwck8wTnY0SzcxWTh6cWxZMnZ3QzZw?=
 =?utf-8?B?eXE4bEJhOFZSem4xVWJSc2JLL3preHdYT3BpaU85TER0UjJrallQVWlaQzQ1?=
 =?utf-8?B?b0NXN0lhZFFtZGNGUjhha0NBQkd3ZXl1bFRiTVdWNEhVWGRHUWpGd0R2Wms5?=
 =?utf-8?B?ejhURlpQS25oVktuMTJGQXc0YzFhZ0tjMVhuVUdKV0NVTGZ3VkJTeWFIOU1K?=
 =?utf-8?B?SEoweVg2QS8ycjVkNlRKdUU1R29nOEFPQ2trY3NaRU9XVjZneE5qbzRPYUl0?=
 =?utf-8?B?eGNYVTRKOGJjSE9GWWJyaStteVAwaHNyU3Vld2p1SGprVEJXWkVNdTBnVWx1?=
 =?utf-8?B?NDJNVmo1UDBVYjV5b2RrQXRyRExYMStBeDRqVUVVZHBPZzdWQ2x4UnJFdFNl?=
 =?utf-8?B?UitlUmlxU250V3dWMm51RE5uNVQydVhYS2dYU20rREE0ek1Yd21mUDFnWHdr?=
 =?utf-8?B?Nmw0bi9qT1U1OWZMdTZIMElMNXRveWt2d091TmU2NDBIVHpjSlh6QWNSam5H?=
 =?utf-8?Q?l2EWRfV0AjUuf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlhNNG1wMC9OUGJyV2tmdUVncVJTTlYzZXI3dTB4T0x1NVFOWTVxLzFWZU42?=
 =?utf-8?B?YVFwNW5TWHZGKzJzb0JwdWVFTERkVlVaS2o3MkZNbjFYV21vU1AyQldwNDh6?=
 =?utf-8?B?c2tnU1FCd3JlVHI1WGQvdGJtTng0VWlFeXkrTUJaNG9jSEIxd0NUYTByMXFG?=
 =?utf-8?B?Ui9DNnU0M3E5bWVoQ3lVb05KYVZGaTZIb0M0R2lRRDdSVS9SaExqVm5nZnV1?=
 =?utf-8?B?UjRZYnp6a0NBUjV2MEtkaFNUR1lOQVJiZlVIa1JkVU9zMTRNOVQ3aHBScFpu?=
 =?utf-8?B?WEg0bXhUUTJ3SEwyUHMwRUxZNmZ6QjA5Mklsd2Z6VUxPT2FzSy9RT0pxaEhl?=
 =?utf-8?B?bUNKd2EzTnExT0RLd2hEa0lvN3gwME1HMVp3di94bFhJSzJLYkt5aTZ6bUhi?=
 =?utf-8?B?US9jWUNzQmFVakxlTjN1d3U3a21YVTRLcXBkL1YvUHoxZmNHZk9QSExoVGtK?=
 =?utf-8?B?cndHS0dMdGlwQkQ0dW1Bbk9IdGluQ1JFbFM2a0p6YlBkc00vWG9Sa2M3bGp3?=
 =?utf-8?B?Q254YURPbG9CWW91Q2dYSEl5RXNEdkRNL1pGY0x3alp2T2tMR1N4T3BqV0Fj?=
 =?utf-8?B?akxpTUJwWkQ4ZCtqOUhiMm1hUkVmcVRNekNnZ0t0Zm5JK0pvWmpBNkpNSFZG?=
 =?utf-8?B?anozVW1LWjVJdFFzL2RaNDdoNnNNZnIrYU9IYTA3MHRLT0F0R3hqVW8rbThr?=
 =?utf-8?B?c3E5V3lqQm9IT29SRHIrUG9jRHdrOEhTRkpSdWZqSXdKb2srRWRyWmZuQy81?=
 =?utf-8?B?c096S2kwSFhXWktSVTB3TlhFd3JFYjIzZ3pJeCtqV01mVUlmOERNWjNiK0hs?=
 =?utf-8?B?bTdVY2RNWDVjdmYxMmNOMkN5M2xDSHNOdk5rZjRScFE5blVsdUQyME1GQU9R?=
 =?utf-8?B?cTVDUHRnb2NMZDFueWVsbnIwelE1OFliSHBVL3lZdXlGMlVpK013Z0dJWTRQ?=
 =?utf-8?B?RnpxQU4wMkpHWVFJY1J1Ny80RzdyNEtKMXhMZ2s3YUpEMkZLazlTOFBadFNI?=
 =?utf-8?B?bGV1bVlPN3RPTzFmdGFQcFJwWGZramZEbzNLbkhlcUdSQWhjbFNJdVN1cVNs?=
 =?utf-8?B?V0NLbXhHYXRadVF5cVdEK3lObmhhczJBQmxieUE4YUVrMlVIVS9oOW1xeVlW?=
 =?utf-8?B?MzE0V3ZXOWE4cGVHUC9kRmtCQ04wYWZCZXk1UXdSN2RGTHJBWGlVWGNSNUFC?=
 =?utf-8?B?c0tId0FlckQvK0JjYkhveWZIa3JvTGhXdTYxVU1TSTJFSzZtMnFNeitmQWs5?=
 =?utf-8?B?MmdndERNcVpza01OdE1uRHlMMElneTlRM3BVRlJDYzB2a2dwNmVVWG5WbVVB?=
 =?utf-8?B?aWFuY25KOGp2clVnMzNUMU52ZHBXM1ZpT0wzMEY5SWNWQmEwNDhYOHlQTWdN?=
 =?utf-8?B?VkV2Z3hzQXlIUVJwM2pqbU8wcnJiS0lOQ0xCb25DdmFlTVA3TzY4VHBZM2lY?=
 =?utf-8?B?d1pyVmRSRExwelBORkJ0bytwaHlSNkt6SWZoTXJnalhYZThKekVpVG1zSWRE?=
 =?utf-8?B?RXovS2MvNjhIalpyL1B3bmQwUlljeVhWMmRaUEZDbkRyYW5IYmE4MXZ0WCtk?=
 =?utf-8?B?WVBRbmdra25kNUYvSFdjRlZvdUVKcDVKU0IrMEhtVmVXdXNBV2thU0ZBL2dX?=
 =?utf-8?B?NVpzc1ZNcnZ3bTBjd2FKKzB6a0xUeUhZaXoxTXZtWmRUcWxwaWlCQm5oL3Bx?=
 =?utf-8?B?TktNakp6R1BGM3BwQ2pRclJPNnpTVksxSlE5OGI2dkVyNW1FZ0NlNzh3K3lO?=
 =?utf-8?B?ZFlWK1lhT1VvWnBYTXErUmdNR3V5dU5HMER5bytxVXp3M1RTSCt5L1Q3VFox?=
 =?utf-8?B?OXlCTldORFNDOE1SSS9yRG1kTFJmRk50aEJYcjBqWVBibEZiRUNBT2ltT0Uw?=
 =?utf-8?B?dEIzNjIzKzFtczgrcjJvNUl4ZzkwdDVkcTd0VFE4ajltSmJQYmw5SmIreHVQ?=
 =?utf-8?B?MHJMWEprVENDVTNBeG1scmo0UHJFM21KVDBoWHZBRmtZdXljbWQxSmRxUUNG?=
 =?utf-8?B?TjUrUkNRTTVKZU4yaGQ1RVBycU5ZeEs4dEtONWxtTkwvV1JyeWwyRDJrWklY?=
 =?utf-8?B?cmRMNjd2d1dQY2VHOFRLaVNIYm02OEc0dlgvQXJ5VEVMQTA2MUdxWmRuTzR1?=
 =?utf-8?B?Q29MeUl6VitXNUpuS3VST05EV0Izdy9jUkFkcXFrbDZFOHNJcEJvT1Exemk1?=
 =?utf-8?B?MTlCb1lPNHMvU1VWLzF6RFI0akFXWUpOK2RndGRyQTh4RUZVQnpnWmlYWlBn?=
 =?utf-8?Q?bvgxL7ur1xFn/w1dapEHMfx9V/TfRGz7C71OtsX/aA=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5ef859-cba6-48b3-5451-08dd61b50d9c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:27:20.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4aKYzKBx43K8Xhp7sVFiCv2pB9uWbYgZr0PEER4w90cha9DDr2tUZiubBwNyjvnG5Jbah1EG1RVMODMjfqxSXfpoE63NJSQ33cUqTcFRs9gJtf74wfrRIzBci4fgQuU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6788


On 3/5/25 11:38, Sudeep Holla wrote:
> pcc_mbox_cmd_complete_check() accesses pchan->cmd_complete.gas to check
> command completion status. Even if GAS is NULL, pcc_chan_reg_read() gets
> called which returns success doing nothing and then we return.
>
> Add an early return if pchan->cmd_complete.gas == NULL before performing
> any operations.
>
> Acked-by: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 42dd405482e407cf90e66917a46fb8e350e0eeaf..5a9ae67f5c50a3e43d30aa368c31c80b81db01f7 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -245,13 +245,13 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
>   	u64 val;
>   	int ret;
>   
> +	if (!pchan->cmd_complete.gas)
> +		return true;
> +
>   	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>   	if (ret)
>   		return false;
>   
> -	if (!pchan->cmd_complete.gas)
> -		return true;
> -
>   	/*
>   	 * Judge if the channel respond the interrupt based on the value of
>   	 * command complete.
>
tested-by: admiyo@os.amperecomputing.com

