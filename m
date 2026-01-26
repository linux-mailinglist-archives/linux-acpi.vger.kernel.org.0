Return-Path: <linux-acpi+bounces-20629-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI/GBc+fd2kCjQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20629-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 18:09:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736FA8B4CF
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 18:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B75A303D303
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26F5349AF9;
	Mon, 26 Jan 2026 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="O8BjJlZT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020118.outbound.protection.outlook.com [52.101.56.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCDF34846A;
	Mon, 26 Jan 2026 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447253; cv=fail; b=TPjvG4kfbwOiGKlRUGjXji5PYzeVc+w6oOuEmsl3twtIc2TNnwDVrkrlrir9gsXLWs4dF7SK3VildhjouNg4+ASsNwkJfRQ/0zZ5SlBRbeezft8qy0d5zufP5LgsrWnSAVM68UuGLhCOJ0I0LpOs+vikVEl+lD/QkaF11x2rN0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447253; c=relaxed/simple;
	bh=dWy0ouJSHfmJy606nvrz9V/FNHa8ahXnZs9n5nMj0Go=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dzzukdcm7XArUupDAaS1qyzo04J9jgtoDIwpO5FJB1T1p+azsCPouf3Mt6WyJhGIw7ZYTUhL2x3q8ax5wQKqRIZ3DvSOXwfT0CIfOneEBX3MeRLISsF7q8DHhVeDyGBOfYxB7M9RjiAAqARYWS8JkDAaDD04Zf9ULZN8l2FF6Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=O8BjJlZT reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.56.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Md0sEkIUj5g4fLiu9j0YcCdgkCG/D1w03NHTMI4ylfKVcgLkXIUamCMiq5vM7NdmgNmqyB5MhkCSGDZFkxhACvua72Qpv+aUcgv5NymH/k9Lfg2kRAv65J3ZxOODDpHJMOPxLrEnTeL0A7EHrfftqLgJx0r0bP8BkrI3DdrpjPEtj1bAeV1qzUUzDm3Xj1/3ElGvpDGxCSjkT+oVgQPwTiOLaA7RudqZmQCJ1/HRouU2Rs6Cy67yrlbiwpTxPamrNA+iCUXYjnH7jksPbQ/xzpacGKtoS+NKCIWaUE/9Yd8QAPocB3PESmyXYzObJw2ZKzr+5d+MX2C+cn6G7NnPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaiczjLHWXjcu7xMvgVtYbjfYjaJ4kbRPA/SHwdrAig=;
 b=SvYm1HJPR4tbYiq9qDv12fEvBYnhPGeBMStl92NGVivP+ntpEe4RTgkc6rviYvQlONEv8CypOvwtzJ36KzuBFOIrh9RfpMenQiryBalaRh+XWc8nQ5oeqfPd48cc+8SF+W+o001lz2kJmF+C6BleKhn5Yp7/u+BiywFAXt/3PJS4OCkVw0RivdPm+WKJ8Tillrz9HoxSW9fPcq9pVjDXIAm3GpMfGJ8O/0AOfwD5KAo0jKQ/974RIQz9hlFGliE7pi2W0PoVo+ZdApSTaKiLQBm185GWqW/sOHsIPxakkF5iz+bOFR09NpVvtiTaUibxUllRu0mjDohzjLjIdxQyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaiczjLHWXjcu7xMvgVtYbjfYjaJ4kbRPA/SHwdrAig=;
 b=O8BjJlZTMQ8P6b6/2vuh5VZNW7mi8RNjKgadAErs8la70lMJfxul7RZ0iY3TTBK3+liOEsuFbjVre0CM2UtCzOu70YxWT9TMIbNCSp+iizrwTdE7ba9Z12vMdeCm0PKpUMLOnm6Zwg3VNkD6fmZWjMKljZRtuNj6+qLHLsF7I6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 LV2PR01MB994348.prod.exchangelabs.com (2603:10b6:408:37b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.12; Mon, 26 Jan 2026 17:07:32 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 17:07:31 +0000
Message-ID: <f30ff47e-2bcf-4239-9f56-c624f4978307@amperemail.onmicrosoft.com>
Date: Mon, 26 Jan 2026 12:07:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mailbox: pcc: Refactor and improve initialisation and
 interrupt handling
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251127-ancient-baboon-of-opportunity-5f773d@sudeepholla>
 <aWUnZJ83_AKQDagu@bogus>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <aWUnZJ83_AKQDagu@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR12CA0065.namprd12.prod.outlook.com
 (2603:10b6:930:4c::9) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|LV2PR01MB994348:EE_
X-MS-Office365-Filtering-Correlation-Id: 23820e44-e53c-4829-4a3f-08de5cfd6487
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXZERUMxdTRadGU4dTJvOWZmdkJmR0l0UmI2WmVldHlkaWIwUU9oQUJoa3JK?=
 =?utf-8?B?dkZpbTlrRFVIcHcrMmhzcjdJSGRQQVRITk5TdVJFNFBZZHRqRWp6dFZNSmE0?=
 =?utf-8?B?SDBrVjIwNmlIVlg2UUpPbXNFYXNTOGV1cHNpZ1VIbkRwK2pmTStlWmlPSUJO?=
 =?utf-8?B?T282OEFSRFdYcTV3bXJyTkorWlcyL3VJM3FkaktHSk9Uc1B5NmtPOEhLMzR1?=
 =?utf-8?B?cHFwVjZUMFRIUGdpSSs3QlQrZ1psa3lsRGFISUFRVjRna0xLa1R0K3BFQW5Z?=
 =?utf-8?B?bGQ5RWE0bFIxRG14SEkxN1BON2FuVXdMQjFFQmNkeVRLdmlZcmN1cWZHRTJE?=
 =?utf-8?B?Y0JGeUFLY2dVTzdzeEc3TE03c1VKTEdPdjZjTFpyZm5qV3VIUzF6eGhXUnl2?=
 =?utf-8?B?Q1A1RmMwU3ViYUNUdEFaK01kZURRWUZ5WjdmTElsUUxOZE1xdFV0SWJhUHJx?=
 =?utf-8?B?cmhiS3NMZkEzWUtYSGJjbURRaHdSOSsrOGY0a0krTUxMQ3FvSndLREtKdWxh?=
 =?utf-8?B?OWdCRDVJanZQNTM2MDMzeEFKcjBoMTVrMU5jTVhXN0NDbTV3U0dpYjhUdlNR?=
 =?utf-8?B?dUQ4a2F0Q3pPTm5KUDdxeEZKaTFjekVBNEhoc1UxVVhxSE1xMWhBWC9VWWdG?=
 =?utf-8?B?SHl0RjlGOS82dTFhWFpLbUdzL3FTeGdGcUhZTzc5RDJqUjFvK0RQZHFtMHFw?=
 =?utf-8?B?bGJSODVvZi9MWDN2SDVoRVJNTUdQRk5yYnp4OTZvQU8xSUZrN3NhSGdodmha?=
 =?utf-8?B?eVl6SUxjam5ZbzNLZEpqVmNjaC9oUkthY3VTT1BpOFB5aEphanlJeC9ReUJR?=
 =?utf-8?B?ei8zTGUzOVN5d0o4L0Y4Wmlxalo5VXkxbWtSb2xHd1RNNDlzYW9xNC9wa1dx?=
 =?utf-8?B?UVpzMkZpNzZNTkh5ejdnUHBobTVxU0NuaDBpNlUrQkVjSmtpYThBZ1hKSGZB?=
 =?utf-8?B?VGhabEV4YTRsYitwbHUyanVkdzlHdzk2Sk9rb3Y3bnFzeTAxMWJkeklwSG4v?=
 =?utf-8?B?QnlHUzVZcFIzdnhyVGx3anM1eHZaWnBYTjQ0cFZ4ZVAvb2hrZ3FsOGlvb0h1?=
 =?utf-8?B?RnBPcTM3RjJ2cWE0cUNIUzJ3YVpORDd5Sm5KY2pIRGZxYnQzM0IzWm1YamxO?=
 =?utf-8?B?aFdzMEh0TFJ6VGIzeHpXTU9PQnNmWG52dWt3c2NtVXdrb0hZaE4rbzJLeGRi?=
 =?utf-8?B?Z2l3WTc2cVdoNTBDUTM2eUR6blVQRjhQUkhobnZJUFk0SE0xV0h3ZXpmRjRt?=
 =?utf-8?B?ek5mVktrQUVZbDRmSml2Z2pTTHFFaUJ2NS9aNzhJMFI3a0Z3eE1ZK21Menhq?=
 =?utf-8?B?VjNWMWV3YmFaaXgvQzgvc292Z3g3MHBBd0hJcHRRckg1ZVNwVmtkdnhWY28w?=
 =?utf-8?B?djYzRWhqcmlINUJ6SGhGMXg0emNmM1lZN24rdTRaczZQVUtRTStRODNHOXpE?=
 =?utf-8?B?dXRENG40Sy9nQ245SXB5VVc2SEk0ZHJLZy9HOWxQeHEvK0lyVWNNcldlR3pO?=
 =?utf-8?B?cUd0SVpjdUtlMGxCL215VG9FUC9GMFhCY3U2WHpWQ0tsckd1Ti80SDhOUkJ2?=
 =?utf-8?B?dXU4MmhoSndMU2JNOWh3cXVrZlpZUVNuV0NTbHlZbUQzM1VCMTRrTFNIT3ll?=
 =?utf-8?B?ZzRFcTB1T3NIaS9QdnE2a1picHZER0psWEZsK3lWRkNqL1FJckFiYWtXK29K?=
 =?utf-8?B?NDhQWVVKa3o3TDBoa04xam04cFlIZW5WeXVQbmZ0eFlJY3ZUSUxOQStLb0Q5?=
 =?utf-8?B?dHE3b2E1UEhoQlJPS2hRdk9paG40bFFEajVNS3lLZXJWNDlTSG01V1FDT2Iz?=
 =?utf-8?B?eDFTZjErT25VbWxNSkVhU256YUc3UWNMKzJOZm9PK3pnQXpQLzN5WXAxR0dQ?=
 =?utf-8?B?amluazZweGdZWUZlUTVSakhKKzFuOFQxMUZReDJpM2szVnA0VCtJdGFIUUZz?=
 =?utf-8?B?QlErNFhrQ21TMVJsMHRvMkNNRFI2bE9CRWUyVXN0UXYvVE9PSjJuemtBRGlJ?=
 =?utf-8?B?Z2FGTTEyTVVkL2txWmZGS3I4c0ZZbDlYSVhhV2piS1hQUlNweU5HYmdXQWlT?=
 =?utf-8?B?bXdFdlFUcXZIQ0MrNFd4NnZLZGo3MlBpZnkvOUdhNHFERElUOGVLZzJpbmRB?=
 =?utf-8?Q?FOjo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWRvZ25CZE1GaUJoMjNaaEZILzFhM2JDT2dIUTJDNWxRMDI1b2pWRnJ3eWFh?=
 =?utf-8?B?TjBnakIxLzBxWWJnYnQzSjB2ZFl1aERVZy9ycmVOMDQ1QlRic0VOYmVpS3lF?=
 =?utf-8?B?ZjJuTWxVRTNUa003U0FlYUJhSVpFL0xqK1ErcWtiNU90UDgxaGtqUGVHaEN6?=
 =?utf-8?B?WFBRVmx5bGxjMDRJcWNVMjF1bDJrUDVWR0hJblZJRXcvYUxvWnptdlNhcjBK?=
 =?utf-8?B?UGE3VVF5RkhzNzY1eEdzY1lKY0hpVmo2YVpEQWlrYWlQSDczQUVMUEtSdVhB?=
 =?utf-8?B?QjA4Ym5qUHJmb1lCSXI2TG52a0puZGhPTFRlTEUrT2JvWFNKb2NWU2d3VU0r?=
 =?utf-8?B?dCtkRlphaE9iR3VwTEJSRjVmamVxTm9EQ1ZGQTdBYVlkVWFIOEFaaHFJL1ZI?=
 =?utf-8?B?V1VZOGVqcjBHdWVML0FjSWhLc29sc3JsM1VMSThyRDVpTEZLV3NQb25IVUdZ?=
 =?utf-8?B?WVRxYW9iMDJYSTZTaGZCZ3JMaU45d2I2YStZQW9ScW5aQ2wvTElHWWJsdEJ5?=
 =?utf-8?B?SDdvK05NeGJ5QzJXYmJhUzJlWGlXcEJoNjg2YXV2d3hqdEF5UjZaYTFUbjFH?=
 =?utf-8?B?Qmg3dmhjSVFGbmJnditCSk5RdmRNTE85c1J0Y0dIRWpyVDRON0dYNHUxNzd0?=
 =?utf-8?B?MjZDb0dWTDlteU96eEtPRG9PNmdGZ0R0SkVYRlJJclF1SVlTTHpvVmZMQ0J3?=
 =?utf-8?B?UWtqbjNsWExXVjdMUUlza1RPQzRqZ0szM05HYVUvdXROWEhxc3kzMGVIZjZi?=
 =?utf-8?B?MDUvNk1Wc3pROUtuYVE1Y1lsdXJ2akVpRXRrMjVjODZzQXFYMmx5c0c3bGdw?=
 =?utf-8?B?VGRONm5KVG52bzNyVStlZUg5Z0IybjNpT3FTYVBmS2JFRFpLeFFGNzA2bFlw?=
 =?utf-8?B?QVhvSWdVTjZTMktCY2RRcTdXWFgxdHMwOFVvdXIzN2RCaDJ0MVBJemtCUk16?=
 =?utf-8?B?U3RrN3hTVEh3NFRVRnpFa3UvTnhZRC9vR1dzd3NSa3NnTFZocEtmYzVvQWhE?=
 =?utf-8?B?MHo3SGZBbng2WlFKeTh0aFN4VEkyQ1FYcWk5Q21rblRMK3duM0pGNWswc21h?=
 =?utf-8?B?Uldjc0xRU1UrNW9aTXBBNFhyV1BCSXkvWHBlZGVYTHFwUzE2eTJzTzNNRjNO?=
 =?utf-8?B?ZTRLeHZ0R1dIb2VoQi9OK3FQb2IweGViT2F4ck1UT0VWRXZxcUtTemZKMlNP?=
 =?utf-8?B?S3lzcUZLNFZjM2ZPNXJlRUdGMjMySjl6ajM5S1pOcWFuYWRJZmlCcDlZMlc2?=
 =?utf-8?B?dVU4N0ppT2IrMERGN1FWaEhpcUlhTVBzS01KY1VEd0VQc091L1kxVTNqUy9O?=
 =?utf-8?B?bEM1OE81cW9RUDFCMzRzSmRJcTBESzlNVSsxQWFmTGkwK3h5K05qZERSNUdR?=
 =?utf-8?B?OE5pdDRVUk91eFFBakVpL3pMRmRGeGw4M2gvTjYxRjVRdlV0bHhtSjdqK1hB?=
 =?utf-8?B?ODBGNXdmMmxRZi9SaW9NVUNVclNwM2JvbGdsZTJXYXVnYkk1K2hMeWZwTEc5?=
 =?utf-8?B?QzM3WkpydnRNa3hFTEY1a0t2TDVrN1FRL1pTSEYzYyt6eFF6RlFkMjcxR3Ni?=
 =?utf-8?B?T212NVZOMjg0OFdDeGpFREZiaFFSTDJFQnNRQmRRakYxQVlTVitOdVMvK3Jj?=
 =?utf-8?B?ZkNkdjMrUTIrbWNnUmoydEhIUkdQSm90SWk2TDBlanZIMmlUcm5rT0lGcDFx?=
 =?utf-8?B?RlJGNmpSenJzODJwRkVYUDJYU2c1Rlk1T3JLZ0FQeWoydGg3U21JMml0Wktm?=
 =?utf-8?B?a244b1NZUjJ5Y2VQZFJYTEhRUWF2RWNld0FyMzNKUXhacldiU1FsdVUraVM3?=
 =?utf-8?B?YTJQbjg3cFM1N1BHeDRnU3NFZUZ6blpYNmtGV29vUVJKQVlOSHR3QjNEbWtV?=
 =?utf-8?B?dENPUWozZW41S0NOMjJoVkQ3dnI5OThsd0VsV1Y3TWt1WExVWkxTSXFMVDFq?=
 =?utf-8?B?Nk9obTNCUzNwWml6RzN4dEdkbk5Yekl1dXVoc0ZraW43NGpPUTVoaU5McHJk?=
 =?utf-8?B?WWNtREVXci9VWXVOYzJWWjArMmxOOTJtK3MzSFgwKzVQRmFyb203akN0WlJK?=
 =?utf-8?B?dnBtU3V6ZU5tWmxhMVQwL1JxTzAwbk41ZHMyWHRYdXdkY0pDV0RzZE1DL1dE?=
 =?utf-8?B?VlRRQ0wvMWlnZ1FNbUt5NERLUDJJcFdsWGowV0hjdmtOUVlTaFVQT3d0Uk91?=
 =?utf-8?B?NGZCVFBiUmZYcTcvM3JnYU1vVDJDbHBpSktJbmg2MElhOU1kdUNHRUQwamhG?=
 =?utf-8?B?SVludFNMcnBUdUR4aUM5anpabHdkYVpqYTN6djdDNkI2OWRCWmtFRHZVcjFE?=
 =?utf-8?B?eGJIY3pINndqTHJJOTdBSUNURnIyQXpLeEtSVHcreVl0RTV2azlNYTN4YWNR?=
 =?utf-8?Q?N7Ls3ugI+UZnzGI4LI/R3Bx3zLVD0ciQX1heJUJ/7bSKc?=
X-MS-Exchange-AntiSpam-MessageData-1:
	+rrezcNuJUVHMS716lfAdZWNumtFirLghC2maMzIOjC36Q+oXp/JQ1a+
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23820e44-e53c-4829-4a3f-08de5cfd6487
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 17:07:31.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqpGRVlcn7pnOHxbdUY+oVsKYsW7OVjgLGWfMk3mjj1Q+PF3XRlCcnhCeTc+v3moXogO4Z4W+PdDfL+wDhJP78Qu0kEuna+be18IuFbX3JZJ0o9d4+z6ACAeATlmV9TW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB994348
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20629-lists,linux-acpi=lfdr.de];
	DMARC_NA(0.00)[onmicrosoft.com];
	FROM_HAS_DN(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	FREEMAIL_TO(0.00)[arm.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amperemail.onmicrosoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 736FA8B4CF
X-Rspamd-Action: no action



On 1/12/26 11:55, Sudeep Holla wrote:
> On Thu, Nov 27, 2025 at 02:40:56PM +0000, Sudeep Holla wrote:
>> Hi Jassi,
>>
>> On Thu, Oct 16, 2025 at 08:08:14PM +0100, Sudeep Holla wrote:
>>> This series refines and stabilizes the PCC mailbox driver to improve
>>> initialisation order, interrupt handling, and completion signaling.
>>>
>> Are you happy to pull these patches directly from the list or do you
>> prefer me to send you pull request or do you want me to direct this via
>> ACPI/Rafael's tree. Please advice.
>>
> Hi Jassi,
>
> Sorry for the nag. I did see these patches in -next as well as your
> v6.19 merge window pull request which didn't make it to Linus tree.
> However I don't see it -next any longer. Please advice if you want
> anything from my side so that this can be merged for v6.20/v7.0
>

I thought you had an approach you wanted to implement for the functions 
that provided access to the Mailbox internals: you wanted to do them 
inline but hadn't gotten to them yet.  Is that still the case?  I will 
resubmit mine as is with -next if that is acceptable.


