Return-Path: <linux-acpi+bounces-20862-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJXTFnVHhGk/2QMAu9opvQ
	(envelope-from <linux-acpi+bounces-20862-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 08:32:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E77E9EF70D
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 08:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E43A0301A501
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Feb 2026 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8403F149C6F;
	Thu,  5 Feb 2026 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="Asxq8s4U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021142.outbound.protection.outlook.com [40.107.208.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF6EACE;
	Thu,  5 Feb 2026 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770276721; cv=fail; b=uwqJEdPMqZY0TTWB4d7MagbqzvAsa7voebRtu3Kz3FEToSt1ofAfNJl9knNDjsCCrjd1jIFiTFqvKod6oBCgRr/uQzlgYRwpAu/fyH/3m8IvT2GFmOiqJQqB2XdiEYtojwRnM3BLpawqViNvxt2HHxLdNL//G8VGAWcAFHboUWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770276721; c=relaxed/simple;
	bh=dgBv2ViOBSysNbtejgtq59U4zbXzUrjr1b7vOUNL4HU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ta9qy9YGtskKL457cCgnE6GjOWtGAU0Wky+zFHzqGUM+ly1MotoLli1DmqU4xtkT5uECRXlTEZN5AMdSkV5ljBa85tkhLOlLyudhn4KQVSt3QqhGCr5qYXpESVHqd+ol8DNYUtLZguk2BzIvSmdsr2a9B2XLKlYDFzmyWUzdfxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=Asxq8s4U reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.208.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kh+BqYpxedrDRDw3sb0jDSRcMqaPIdV7zVDs2Yav3kvKRkB71wFUYd64FDAZrL5Q5tjbCO9+D+CWWnR4BUm3r7TbMiV/kAu+v32VgmQuTFdl6sxgwWUrcVVzIbkt1x1sU3/jknhv8O8VopNPnlXOKQNEYUnqoI+oZOPfLWx88Oowjn+r9m5hYAd4Km3XiOmDTGphj5HCGqsm3AEimALrYBRBkvDLoDMEvH/yOiOJwC9/O/Vibn7kddoHNUH2oq13lA/tn2UTmR7UtkGCp9f+h02ULnNdhfojBVvF4u5IyinvAWwX4b+Qe0SWMRo3Rfe+NTDAVCRTKXCUvyK6IQ87KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtNZ58xqcjYQLAW+HBgxIGUWeSKFiYOHiS542TY3UHI=;
 b=Y8VnNFmJGJrqCFGPE0dL/r5cyZOOlYOuMApbyAYyiWRVXetseFaP0LEJX4ev2QrcNnhCLZ6j++8i39ibRqU45qC1vQla6uc2Xf7IyK0u9ZYY0zEnz9LXOS7x25j3XO1qK5n3lLtkhfyrydAq5S479rzkF5/rIyMxmYXuaKoGANGy89FDYBQMEvTUWr5kAcS5tTbmk3yEunjnNi+54IZYQ83FX1Y+oCXxy0t7zb5rEkDn1gwO76hPDPXYgjTuJ+C5AXwP3TUFYAeM8xdiKqSbH9uMb8Hs4N8Y2grDs5U4Hh0jkWwNUrs4JFEGowPLTjy824sd59yIxuaZe9d9as8PUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtNZ58xqcjYQLAW+HBgxIGUWeSKFiYOHiS542TY3UHI=;
 b=Asxq8s4UIMppujJ3uxz5TEH/xXJlDUflpcG/e0v30QBU0/Q3AOHMAUIGjNDzJocsVe+enojC+sTqCiZG1PUMmP28S3mowJh4x+xUCa7VXU4hw+8455TcE4Gga+uOYjsXlGBRBTA4w99tbnjtwqv7n8r8lA4vXWYj1OM1GCnUaa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA0PR01MB6346.prod.exchangelabs.com (2603:10b6:806:e4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.14; Thu, 5 Feb 2026 07:31:57 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 07:31:57 +0000
Message-ID: <ed1963c8-207d-4003-bff8-800b76c30b29@amperemail.onmicrosoft.com>
Date: Thu, 5 Feb 2026 02:31:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mailbox: pcc: Refactor and improve initialisation and
 interrupt handling
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251127-ancient-baboon-of-opportunity-5f773d@sudeepholla>
 <aWUnZJ83_AKQDagu@bogus>
 <f30ff47e-2bcf-4239-9f56-c624f4978307@amperemail.onmicrosoft.com>
 <aXiFlkKAuV8QSgcM@bogus>
 <cb6b0b57-c5b7-46c4-8909-e6955ceee401@amperemail.onmicrosoft.com>
Content-Language: en-US
In-Reply-To: <cb6b0b57-c5b7-46c4-8909-e6955ceee401@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:930:a3::21) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA0PR01MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4e2a70-9ba5-4096-43ab-08de6488a48f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTdJUHdHcnFrZHYvUVNvcnBaSTc3K0FIRUlqOXZucnlZeHF5Q3g3OFhIbFU5?=
 =?utf-8?B?cjZRa0F2Mm8yblBTV3MxMzRJdVVJd21DMTVOTUQ0Ym1KOVgzQ2Q4NFFFaDQ3?=
 =?utf-8?B?SEcwVlhna21tSDZFeUhtS2J0RXlwL09WMlo2enZHdFQzbElMZWJVTWVmbDBz?=
 =?utf-8?B?andGc1FUcFdlR0NCQzFkYmFkTjMwVGVNVEpvY0k0MlFYQ3V6MXh1Y04yeUFL?=
 =?utf-8?B?Sk9rb0ZNcnN0aEFwRjJOTWYvY1RTa0h2SDhLbHdBM01hQXhJUmVxK0Zrd3Mz?=
 =?utf-8?B?MUVYMnVvRzNvNnRjVk8wSkhLMk5vc01nSTRXNzRZTmRnczRaYmRYN3dHSlh0?=
 =?utf-8?B?MVZpMDZGZWh6czl5cUFnL3lPbDY1UWZicEViUzJldUNXaUtMc242RzNsMGZ5?=
 =?utf-8?B?ZTlZYmdpeUdueURyM0Njdk1aVGxaNGRMSS9jRXhSL3pVdk8vbllnNmx6UHdl?=
 =?utf-8?B?anE5MzZjQUlsUUQrSExIMjlHZkk0bFh6cmd4N29mUzNoOGNtZVE0dEZ0OEw0?=
 =?utf-8?B?Nkh5VkxuWlNRUFhYTVdHSU5uKzVxenlXTGNWNXE4enBiQ2R4RkkvdEh2Y1VD?=
 =?utf-8?B?cXRPVzFjaEc3b0IvUDBwSHRGNEdXa3BHU09Lb25HVk5CcUY5MEdEM2MzNGZV?=
 =?utf-8?B?bDhwY0pZSklSdGlaODhqbWdodnhQaDBTYnZ4L3RzUTFOOHJwQlR0UGI5aVhX?=
 =?utf-8?B?UjBiNzZWbmF0TjdKRUF4OXBZOUdWRXgzcHRGak40TlNZVlE2SXFZcmUyNzBn?=
 =?utf-8?B?cmZwRUdta2paM3hvTy9CYkVoVHNWelUwR3V6cFNhZnhMMEorVy9UbkRvaStv?=
 =?utf-8?B?ZjlRd3Uwb1BITnJSWTZqbFNJR1NoOHVPcjlHc1N3K0ZOY2ZDaURVN3M0ajBO?=
 =?utf-8?B?dnJ5L1N4eVB3dnRQOHVoYVhOQisxYmVoeURZQ0JLeFJ5U3p5RFFoWm5EUDhp?=
 =?utf-8?B?S1NPWWN4czNHUnhyaXhLQnpUUXBTQzdGd1BQMWZzODFJdTNHOCt3cWRESkJq?=
 =?utf-8?B?MjAzNXhRTEJjMWxadXgzUk1LcnZtZ0crQjJUdFU5Sjk0VWxGU2R3Sk9vWG45?=
 =?utf-8?B?WE9Id1FHSkw2TXU1U3Z5TG9GUGZreVpmRVcvYjNhN0d3eUhqMWVvdGhBUkJs?=
 =?utf-8?B?T2xkbnc5ZDlrOWxJMFBrTjdzOXgxZzhpV0tUbi9DbkRvRDNHUkVJZUNiN090?=
 =?utf-8?B?RjROQ1lmaXhia1RKTVE5bWt2Y0VORkthc1Btc2U0ZEltYk5WbU5pYU1oMlI5?=
 =?utf-8?B?ZzVEQ0ZKUkxnUk1QQUtOeHYwMFFuQkRROUg1aVoyaGNTV0tKcG5qR25KU2JE?=
 =?utf-8?B?TXJuSUlORWJlaUx3NTE3bDZ4WVprTXNNbytXekgvSmlGSUR3N1N0N2lKQjNB?=
 =?utf-8?B?M0pnK3NKaUtENFdBS2E4Wll5WWJzZ1hMc0Y3ZVd2aWkwY2ZHU0Z1RkttdHkr?=
 =?utf-8?B?WEVoWTh4cElyaVdmdXNRYk5nNE4zVkJpT2JvVFFnbmlrVHNDRU9vNkthbUJ0?=
 =?utf-8?B?N0JBYjFOaVgrbllmNkZvdmVMOGljYUpOT0FhMCttOTZRNWN4WEE0QTdycnFV?=
 =?utf-8?B?S1BVd0FJc2RnVHpJRnRtZ2Y0cVRlSytRejZ0dU0rYnYvV2lwVzFxbGl1MGlZ?=
 =?utf-8?B?TkxBWjUvMVpxaStRbk1laWpmQ1R2eWh4Q2w5eDNxZzFLY01GU09xTXg2QS9v?=
 =?utf-8?B?c0FXN1M5SUxub0YyclNwaWtzZHJscXFSYkQwMlhFMktTU0NQVER4TnVSR2xQ?=
 =?utf-8?B?UVc1R1dOalR0V2h5b1VuRDhtZStpbitta2ZJREkxRk1kWVdxSkdBelB5RzZ2?=
 =?utf-8?B?cGtMaTFSeGhTbUY2NnNjTmhGZnBFK2I2QWlKTTdoQlpkTUdqZGlQWlZsdktJ?=
 =?utf-8?B?Q09EeG1Pbi9ONFBva1FvVWdJcENtQytRbFFvTi9xODF0TThsM2hIVWxlc2Rs?=
 =?utf-8?B?aE9SbURkY1ZuN3NSOWNqYXoxbGtaV3NIeERsSkFncFVMU2pTNVhMalBleHkv?=
 =?utf-8?B?eWszOTMvTEsyZ2VVU211VHZHK1lwZTlMa0gwVFA0aFNISGZDd2JDZ2JFNEVm?=
 =?utf-8?B?UGJSejVjaXprd0ZnRkdrWXc4enFFSjZMdVNyZE9IKytmVFRjNklNcURHdmM1?=
 =?utf-8?Q?uGME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L25tLzhLSk81eVY5cFdjOVV4dlY3VnhIcWNhMG9VaWtEV1NSaXBTQUVYU1lW?=
 =?utf-8?B?VDBCZ21TV3JpRDBNbVJDeVJqYnFZSmsvaW9Rb2V5VWZWei9OZTgvWVhCSDI5?=
 =?utf-8?B?bm1vWkN0Wko1eDVWd28xbzA4UEVTd2M2WFJwRWN3OENBVWhRSkVoQWk5V3pL?=
 =?utf-8?B?NFV2RkZkYWNEY1J2cVpqY1ZlT093d1NzVmZySHpIdG16NGxGR0EvdDVxb1JQ?=
 =?utf-8?B?OXFsNnJxNFVObW15eEdjVC9KeEFUQVVZanRQbHA5TEVVSWJlWFJFelpwYjc2?=
 =?utf-8?B?OGZucnQ1MjRQODV4RlNiU240ZXRUNTAvZ0tYWGJ6QW5mcnZZKy8zUS9LcnZw?=
 =?utf-8?B?NTEvcmNya01uTm4yTXZiWlNWMmdRUkVYb0p4NUVsbE5JbWVFaHY2d2QxbjYr?=
 =?utf-8?B?d1NwUzIzc3pOcldVK3czSkh4dHk3ZTNhNmpWcXNQYnpOWFlxckNzbVNZL0FH?=
 =?utf-8?B?Mm13U3FPR2kvd05YUVgyeWJQSndQR2NlT1RPcTBMdG8xVUMrdG94d21RRWNk?=
 =?utf-8?B?ejVETXVCdkt0NjNEaGxoZm1TSjlYUWhhTWJ0Q2p6NDhjTDRXSXdoUktmU3Y1?=
 =?utf-8?B?VXF6NlVXd1BJak9Pb1Y5UTR1UE51UCtEcTU2WHdGTzBkcm5CMXhVRythcCtI?=
 =?utf-8?B?b3FmTVE0VXc2djd1b2ErbnNIVlFMSTEyTEllaDNMcFAvc0tSSE1OREdzM3o0?=
 =?utf-8?B?c3V2bmpTY3FRSERqREdBV1oyVzBPcXB6cnJhY05xeitoOGdnVk1Za2RKY1Nj?=
 =?utf-8?B?TkVlVzd5eHo5Z0ZVUkJJK2NGZGI1Nmp5aXhKejhEeWRja2pZUzNhVktBSito?=
 =?utf-8?B?K2taWFpQYkUxL3dLUXVScXJua0FVcjVIWU1WZjR3MzZVM1RkRWU1czZmWVdM?=
 =?utf-8?B?WW0xeGU0ak9nRFJIUzhJSnlEcUorL25KSCtCM2dBaytQUzd6UVZCV1ZlTGtr?=
 =?utf-8?B?VnIwL2pwYzhKb1c2VDlla0ZNL1JzS0U5cnkxNkJHQ0FLYXBXS2pVTHhHc1VP?=
 =?utf-8?B?eEFHVjFBbFN0aXpaVEhaZXdvNlZnMnkrREc5MFFDbWp0M1FBc2JZZGlMVFV0?=
 =?utf-8?B?K2pJd1lYUXdWQmZpdWhwdyt4cGlUbnR4VEdnNmd3YVordUZSS1o5c04rT2U1?=
 =?utf-8?B?RnltQ25TVVZLOWVTTVpKNmI4eVJuRXg4MGNhVmVuZHBCWWYyWEtjd0IrWWRI?=
 =?utf-8?B?YjNRVU9MT3I5OExHR2JaM05NbS9qVXgvWXBoSnIvaFdoZVN4SjVISVc0TGlk?=
 =?utf-8?B?R0ZBbjFpUE5LSGRQcVpGbzRwd0sxNFVZaEdXMXhZREFzb2tveVd1Z0tIMXpV?=
 =?utf-8?B?QXlHbXlqSmw2WUJ3djd3TklyWXpJd0greGJQeTlSVWpXcVNzd3REek1wUUQ0?=
 =?utf-8?B?RUkxTjZyMXJTSm9HS0lKQmw3ZWY2UEtyTCtvZUNrU1U4VnMvb01zVnNlSDUy?=
 =?utf-8?B?cXB3UzdQUVF4d0hNb3hsVVAzTmdMeG9xTlJ2RWZqdEI3T2cybTBOUUJBM3RH?=
 =?utf-8?B?cmNIVDdBeFZnOGtEa3hKUzViQ252TU9sNmJldms3bjZkZlRKRFg4VktkNnNJ?=
 =?utf-8?B?RkZiekV2NUpVTDZvSjZqVFlRQzYveHo1STZXVzExZkg5RTMxVVNPT0xLR09s?=
 =?utf-8?B?N3dJYnNRM3Nzbk1VS0xrL1RIaHFDQlRmcmREUU1GQUpwSGxyWVZpZjV5Nktt?=
 =?utf-8?B?UktJdjBjbFlscm1XK2Z2WnI4RTRVczJ2ZlJ2b0Y0UEVaaW51MEc2dGFIUzM0?=
 =?utf-8?B?ek5wK1B4Nm53Z1ZkSE9xNUM4OHdPWTI5bWNuRmdRWXNET1Jnek1QeDRKYnF0?=
 =?utf-8?B?Sk9iVTBDK3pzMnNQZzF2dzh3aU1CbU5pZzlhaWh0Tmh4U011Y29kNCtRV2RF?=
 =?utf-8?B?UGZISjFIb0NnNVBkOFdlWTN1Z005bmkreDBJcTBib0pSWFFDSU95V0s0R1pQ?=
 =?utf-8?B?YWhiaE9ybm5vaGhDODBJV1BPN1FwSS92VGdiWUVIVDZ3OXNxZGxiRCtYalZh?=
 =?utf-8?B?YWNEUXVyN0l0Q2FKdUVpWmY1ZmNQcDQxOURKVG1scG1OYjdpaVQzT1gxOWs1?=
 =?utf-8?B?ZEpFN3VSL2FDTzZ3cWNteW1yajBCajFhTThoTGJjRG0xL2pZUTYxdHROTzJm?=
 =?utf-8?B?MFZBM1dXcm9HWDRTTXdMcUtlUnAwVC9pbXIzVE43NkYrcGEwY3dCZkVGRTZs?=
 =?utf-8?B?OGdFTE1lK1ZiRkhaR3FNZXpDdUg5RnZiUG5hTGJwb0p5Y296aDZTTGpTUHgx?=
 =?utf-8?B?TndBckFHN1U2S3ZKR0Zpc2ZPTVBpMkwvdm9oOFlIVExpUks5MkNOMm9kbWxp?=
 =?utf-8?B?T2tKQmg2SG9EWTNpRm9yZUJabm9sUVBLQnhmQ00vbm0rcjlWSjhtTHY4OVdu?=
 =?utf-8?Q?x2gNxRXQaqVvXH8Q1DQWPAOnTDaD//lPrQpbo+VKQ/ZHD?=
X-MS-Exchange-AntiSpam-MessageData-1:
	/aQGBCCJCf002yfmdoyhPfqRhyhRySEnYDgODT6ZZ2wHosucp6XJR9rk
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4e2a70-9ba5-4096-43ab-08de6488a48f
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 07:31:57.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSFNQK3bI382z4aGmVWw/z9LA2MlKUqOhN7joO2JTGrJTk+W7kQIyMKTvyuwscDrJvoTrxTKKNy/tAwd5UlYdInxsmuIAb+HpuVOV8kv6sC41W5too6CHNbwc84mGC3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20862-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[onmicrosoft.com];
	FROM_HAS_DN(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,os.amperecomputing.com,xsightlabs.com,huawei.com,arm.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.916];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E77E9EF70D
X-Rspamd-Action: no action


On 2/4/26 16:40, Adam Young wrote:
> I was just looking at it.  I think reposting might cause too much 
> churn, when the  crux of the matter is what to do with these three 
> functions I added:
>
> extern struct pcc_mbox_chan *
> pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
> extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
> extern
> int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, 
> void *data);
> extern
> int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan);
> extern
> int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len,
>                               void *data);
>
> In my last patch I added them as EXPORT_SYMBOL_GPL.  You mentioned you 
> wanted them as inline.
>
> We can do that, but it does mean further exposing the ACPI header 
> file.  THe simplest is  pcc_mbox_query_bytes_available which I have 
> posted below.  As you can see, it needs the struct 
> acpi_pcct_ext_pcc_shared_memory  which comes from 
> include/acpi/actbl2.h.  If you are OK with adding that to 
> include/acpi/pcc.h  We can inline the functions in there.

Actually, I just looked, and the more significant issue is that they 
need access to struct pcc_chan_info, which is inside of mailbox/pcc.c, 
and thus not available to client code.  While we could move this 
structure to the header, I think the better approach is what I 
originally posted, with the 3 additional functions exported as symbols.

I can resubmit it this way, if you agree.

>
> These three functions are requied as a result of the direct access to 
> the shared memory buffer.
>
>
> int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan)
> {
>         struct acpi_pcct_ext_pcc_shared_memory pcc_header;
>         struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
>         int data_len;
>         u64 val;
>
>         pcc_chan_reg_read(&pinfo->cmd_complete, &val);
>         if (val) {
>                 pr_info("%s Buffer not enabled for reading", __func__);
>                 return -1;
>         }
>         memcpy_fromio(&pcc_header, pchan->shmem,
>                       sizeof(pcc_header));
>         data_len = pcc_header.length - sizeof(u32) + sizeof(pcc_header);
>         return data_len;
> }
>
>
>
>
> On 1/27/26 04:29, Sudeep Holla wrote:
>> On Mon, Jan 26, 2026 at 12:07:26PM -0500, Adam Young wrote:
>>>
>>> On 1/12/26 11:55, Sudeep Holla wrote:
>>>> On Thu, Nov 27, 2025 at 02:40:56PM +0000, Sudeep Holla wrote:
>>>>> Hi Jassi,
>>>>>
>>>>> On Thu, Oct 16, 2025 at 08:08:14PM +0100, Sudeep Holla wrote:
>>>>>> This series refines and stabilizes the PCC mailbox driver to improve
>>>>>> initialisation order, interrupt handling, and completion signaling.
>>>>>>
>>>>> Are you happy to pull these patches directly from the list or do you
>>>>> prefer me to send you pull request or do you want me to direct 
>>>>> this via
>>>>> ACPI/Rafael's tree. Please advice.
>>>>>
>>>> Hi Jassi,
>>>>
>>>> Sorry for the nag. I did see these patches in -next as well as your
>>>> v6.19 merge window pull request which didn't make it to Linus tree.
>>>> However I don't see it -next any longer. Please advice if you want
>>>> anything from my side so that this can be merged for v6.20/v7.0
>>>>
>>> I thought you had an approach you wanted to implement for the 
>>> functions that
>>> provided access to the Mailbox internals: you wanted to do them 
>>> inline but
>>> hadn't gotten to them yet.  Is that still the case?  I will resubmit 
>>> mine as
>>> is with -next if that is acceptable.
>>>
>> Honestly, it has been a while and I have lost the context. Please 
>> post what
>> you have or thinking of on top of linux-next or jassi's -next and we 
>> can start
>> the discussion fresh.
>>

