Return-Path: <linux-acpi+bounces-13238-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5F8A9B03E
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Apr 2025 16:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127D646190D
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Apr 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0EF18CBE1;
	Thu, 24 Apr 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1L4XZil6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F717A316;
	Thu, 24 Apr 2025 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503888; cv=fail; b=XQdSizppfoOMftixjChQvGD3dA4R2ryuOWoPlodpKNK63Fon+KafYM30aV87HOqlBXVA2hbexfLr4Af+o90IRQ4cHn4DTSSF7mtYqE51TzfxM2JRAFBrsXRKUUyTySLBCMe4pdnUeVmuBwSNsbD6xshXazchlfY5FNocpwM+26s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503888; c=relaxed/simple;
	bh=ysCGWYlI+ap+W9biq+15g38Tz4iwRBkEw4vjtYPfnjE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rno2YlXI8/DCEirqtimifRDMLcG7XIrx/Pc0mmc3Q8rVXgvBlcIvMT0eIGWF9bFsFJaEgVNywksgZhpvSOgw2AQa008+mPqj25CDR4t27ZkiZFNgQzerthT1CW8ElcVeylL/1FE9YeiO1eojeYnBPyERUN+Qnk4o6vZTQmB/J7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1L4XZil6; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOC+cdtFk2rs/luX+FbKX86RNrA8qZIFTAgCELDZrbxsCAFFkycJY79gO99AgGnQHLF3p0ppmkvRJ01kHMvHqRlpMqnbBGxEfCMaAvc9oLVaB/RZzeMUbh3kIFF5zWYVEaWBq3QwnjZ0ifd4ygtVK24t20hHxhuvcU0INAfmplask/UUBbAtU5zdemu8oquXnNyuVCjs/JyZ+QwgkcHHq0dhd/qUQrPmJVu/maHU2Aa+wZBrXiDO6GwcbA2LnObB+/qa/MoUwpNg25xEUIeuVeH42a3qj43xvl1kdPAYsEWn9liEp82APy7FbSz1x589uTsA244s6TG/+MUcKBJJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/tlM4txHA6QlnuwMbtqLnddwee2s8/XbCvBNBfEqZE=;
 b=K3GppEvypxGwnAraIh1R7WK4VfVCzCCo6DGp8XyxL0bjGfc2POnHoy9K7K0yYFaXPLxOYv6itlVMxKNz8AeqUG0AS496YwxAsy5vN9pvC0Fy7WoxAdLdRMQ5jLeQWGpxrTblei/WDQlIt1fIeKubpCSrKPTMIHqJfBwWCxO2fIN8RRSajcS+CjDQld+NLZS6qTxgOwOhHgSbV8Lj+ZC4pfTC6VZ1rlEDHFoWOel82CRIw8U1msU/nJR3UOklZVy01q3acU3zra+vjiHgfi+Z2FtPrQxF2vXdBMBlXysrBGJR0b3ko4Qd8fathLBnkNR3oCtFsAhR+M1mpYiXx4EHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/tlM4txHA6QlnuwMbtqLnddwee2s8/XbCvBNBfEqZE=;
 b=1L4XZil6fY/W91EmR5TPnG1dZUFb106XXj+bRlCNL3peVDi6KQYkAs7DJDKAeE1DRx8AcYJKwYkuHL5zaIxiSO3P+17bOnWhRvl8waAkOlbgffOF6O65LiIkgKY3tiULvuaVgaNRdjcwfqW7Pl4OfuvBL2AFsbY6g4/hUcittI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 14:11:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 14:11:23 +0000
Message-ID: <106bd256-2c08-463f-8498-b68f2d5ccaca@amd.com>
Date: Thu, 24 Apr 2025 09:11:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD platforms
 after suspend/resume
From: Mario Limonciello <mario.limonciello@amd.com>
To: "M. Bergo" <marcusbergo@gmail.com>, mark.pearson@lenovo.com
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 rafael@kernel.org, lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <f5dd019ad4506.2100bf0f83374@gmail.com>
 <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
 <b6fc4e66-b35a-41ce-a633-db3d660b88a2@amd.com>
Content-Language: en-US
In-Reply-To: <b6fc4e66-b35a-41ce-a633-db3d660b88a2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:806:125::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 5626e35f-8538-404c-5b88-08dd8339e4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk40VjdxTEdPUFNsU21jWjl5VHdPcUpSQzdDWlVpbHo5WjBBZU1DbHRHejgz?=
 =?utf-8?B?VUFsYWZpRXJGWGtuZWtEcVR1TDdNTk1iWDh6TnpNT2RFYjJhYjlCNkIvL0Nl?=
 =?utf-8?B?S3ZuUmtYc3FmbHVmK2ZqVGFmZjU1cG1RYS9CWmk4cml3S09tOVJIbjBGTWFr?=
 =?utf-8?B?WVRRdU9xYjF5bkJoN20wWGdUZGtTTE1WMGtSMmgvMXljekxrTXN2TDNacmZo?=
 =?utf-8?B?M0NiUUpCRlNZY2JrWEZPeXBGcE9GaDFRWVpqYjYwbnArS1dmcVo3SlVZWkFM?=
 =?utf-8?B?QTVkMWtBd2JUZmsvOGVyazFpNzRGZXF2Q1pKaGhEZHFHSVZiTWh3cVJjL2Fl?=
 =?utf-8?B?RE1hL2xSbHNGL0ZsTXR2V3ZXRlRyU0kzOXNwNHRoR1NmbFhNOXVpOU44dFR5?=
 =?utf-8?B?OEZHN2hHYm1vMk11NDNONi9SdDI4UDFvK25oWW1ZRFdtczlLc0RaaXdPeXpB?=
 =?utf-8?B?Ymx5VkU3dnY2OElldGZCYXlkdUd2aWpqZDczSDNsQWJDR2NSdUhRbHUvak9q?=
 =?utf-8?B?TGlVZTFWaGFjNHloWXRiMVEvQXdURXU3N09pM01uUW8xOXd0MTNTd2YwSytZ?=
 =?utf-8?B?VEVnVTRFMXE3bzUydnpJVGEyMTVoTkhIOFZUVGVWOEZ2N29NZkVyTGlBdjBT?=
 =?utf-8?B?R3c3YzhNalFwUFk0VVNRdGFDU2hEVUpDUHM1R0FWdkU4Q1lrS0VNelo1bFF6?=
 =?utf-8?B?WEZjTHlDR3paSktJeFlWS1NaYWhGWldmWHkrVkNxSnlwR1llRXB5TXZCOHF1?=
 =?utf-8?B?RUFnd1V2UUNidUpOWU91NXVCbFptWWtWSkJRbHdoeGxGbGVTUjg5eTlRdndH?=
 =?utf-8?B?akdUbjhQLzhtT3RoTG55ZTlNU3Nod2JMbmdReENRWW1mUGgrTHlFTFNnUTlr?=
 =?utf-8?B?bkZPenYvK3ZFdkNuL0dpajJ3eVp3Zm9NblVENnB6RzdZaHIraW9uRjJzU2Zp?=
 =?utf-8?B?WXJmeWw0ZllSRXR2SFpDcGgyc2Uyd2NIajJZVTFNTmcwMGtNVkx2SDk0QVRt?=
 =?utf-8?B?b0Z6TWg3Zit6aERqWTJCT0NwRGE3V0lud2pTbkd3N0FOdDRkY3M0YVErVC8z?=
 =?utf-8?B?MVVTZGo1VjJLbnl6MXAzdTlMNnBvWE1sa09vYzFsd3VreTkyNTBwQkVpcWFU?=
 =?utf-8?B?UDVVWkxQZ0Eya2k2ZkM3Q2xHR1FhMjhpTzcxUzJkeklMT1FUUytZc3VtZStH?=
 =?utf-8?B?ZXRmT1pXcFU5VWRSS3FRd2w2Wk8rWlVMY0srZ3VURVVScGM5dDA5QVpYNGgx?=
 =?utf-8?B?L0M0WU1NeG0vcWNwRTJHT0RjcGZQS2dLZnVSUDdFRWpUdDgzMHlGWDZDemFm?=
 =?utf-8?B?QlhLOWhia0lPTTRXc0kwRloxZG92d08xN3hLZ2JIS09GdEh1MXZubENXYy9Y?=
 =?utf-8?B?cFVlUklBSjdCcFl4YjY2VU5TRVpRZGFVSTQ2VHFsejU5MVpPVGVoa3k1Y3Av?=
 =?utf-8?B?SWx4Smh1R2RMT2pqcEhNampYTTlHVVJhQzQ4bHhMdEM0RW5jakl5S00wUUZy?=
 =?utf-8?B?UTVOWVpnVm9kM3ZTYVJNaHJBNVBubDg1WVJYUmR4MytLQmhUc1hlMlJWNFZy?=
 =?utf-8?B?cVBFdkJMNnEvVEZJaE5TTGtybGNEOU0wbm9LZ21zZHhjZGFQUlpFSW5xeXFQ?=
 =?utf-8?B?OFNNTzlPN0ZPUDRJZ3p5K0Q1OGlmWlg3QzYyczBGYUhYMG1xTFZWT0VETGNZ?=
 =?utf-8?B?Y3lONEwvcG1GWmF3OGpXNWRUK3F2cnBBNzBldjNubk9kT2d3aXMyWFk2S3JN?=
 =?utf-8?B?UjNZL0hmaktlZDBXdFZnVjFZZzJDUGNsVlVKYnlpTjZQTXhpSXBHLytiTFh5?=
 =?utf-8?B?OEZoc3lzdkJhVTVmeHl6bTRlcmpXZTZCdENPdUFidzM5bWMwVjYrNHMrSG16?=
 =?utf-8?Q?LygodxmF5Dmxo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEhLVEZRdjBTMmNPcGVYc3N5WFp0bzQ5cjZJOHpRWHNBZXB4a2hMMU9YZlNH?=
 =?utf-8?B?NnBOaDBreXlLRHptblNUTjJpb2dvdFZna0Z6YjlmMmhYU1NQd3dDazA3MWUy?=
 =?utf-8?B?N2xkREdrV0pPa1JLSFJLamI5UHFJTHFBTldpVlZUb1h3TFNlUmRNRGpTbitQ?=
 =?utf-8?B?V3NJbGd6N04xQW9UMWszWVJ0aHpEWElLU0xyNUZYT3QzemlHQTUySzBHMzlO?=
 =?utf-8?B?eXpkWTlsZ1ZwWVp3WXRFSmFyWlB6cExYbDBWY2MwNEFkMGR1RTBIN2lEcXNM?=
 =?utf-8?B?eGVxRXlGclRUOEgxY1YvNGZMYTRpaUdFMlZhL2JYMDVhOTFldTAxYWR5aXc2?=
 =?utf-8?B?OUF0UDdHZmNlMG9FWm8vaC9QVS9XVlhZd1RUS1pIYWk2Zmo0bG9DVDQrVGVi?=
 =?utf-8?B?ckIwTzZpbDc3dzRPVzV4Vm1jR3NVSkFKZkJzYkozaHVqNFJkUU5uOEVibkgv?=
 =?utf-8?B?UGNrSVEvNTRSRDlmaUlEcm1DTHRIZms2RGl0YWhlWmVvREFvbXlYWTEwRU0w?=
 =?utf-8?B?VFRCc2dvV1JqNEhQK3d3MjZhRjdZeFFLUER3eFpGY2FtQXNSZGpSSE5rRTJk?=
 =?utf-8?B?eWd1YTVQZFdObnF3V3BJeVJLZDM3S1NPRmZrVjdwNFg3N1Fzb09NcG9SdmNr?=
 =?utf-8?B?V3JBNnhORjNPdXdsV05mMXBpM1JjK0NUSVJkeWFHTkt6eGUrTkpYZjhkOWtu?=
 =?utf-8?B?WGpZT0wyNjlicUNsL3hDbFlpa0UrVFU1VWx4MUgxZXAxZXFFVjd2bWVBdGQ1?=
 =?utf-8?B?TU0vM0pnTTlKMHpIUFdyQnBRdjU2ckdXeTRwM3BDa3g0dnNYNGRNd2dGL0xy?=
 =?utf-8?B?OGlJNHpvNXpnc3l6VWdaUG8zMnFOZHNickdqWkFuMW5mYVdISHl0ZUluaUNj?=
 =?utf-8?B?d2E1Um5DT1k2M2hxejVLYS82Z0NrbnFhUWw5aCtHWVNSeHNsUlY4QU13Rzh6?=
 =?utf-8?B?QVZNUHpZUHR2U2wwejJmK3lmdFB3NFB0bFZVMDhtdDk1RnEzcGZ0MEk1TFMx?=
 =?utf-8?B?NzZQcUVDdkJoVlBpaGFxTXphSG4xNHMzVFVnbHpIZFNHOGRlQzExbTJjcFh4?=
 =?utf-8?B?QURra1RsWG9vK2d2MlhHbVFoQzhpei9kRTZRUWF2N3VacFNrNHZTaFNoZkc0?=
 =?utf-8?B?bHhsTFR0dldDV3poV0R2N2hlcXV2Uk5LbWFEQXgzcXhlcFlub0dUaXYzQnhK?=
 =?utf-8?B?bnNsdlRVRGNMOFVxWXFnd1FUaWdKc1FwY1hjaEpSU0dTSW45ajQ3Q09JNm1J?=
 =?utf-8?B?M2h6U3ZtNE9HTTdxZHBRWmJGU0MzNVVhMS9OdDhOTHlHODhlblVtWC9TVHQy?=
 =?utf-8?B?amVUSk04VGlDV0NZN1Z3VGZqQmR4RjFmdzZ6SFY4NGU4bGJ6M1lXNjFVZCtI?=
 =?utf-8?B?YlVHS0p6K214WXhZVFlqMWRkSWxHOUl4UVN6dThhRGlkYVpHMUpwWVhKcHJO?=
 =?utf-8?B?VlNSL3pGL3c5VkFUUUhPQi9JZHFrcnYyUExySFhHLzZyVXl0V2VqMHkyVzU2?=
 =?utf-8?B?citKbmJyMEtzb1ZJdVNDZUpKK1F3My9nTXhFVW9GOTZLdlNqOGlNNGp4YXox?=
 =?utf-8?B?Z1hkV2ZlMzY5L1VPaXBOUFV3NGZubnlTSFN2a1hWTzhWbW1FMnNSMUlPczlq?=
 =?utf-8?B?MHdwZ2dQSzlQV2tYb0hvQ1BlcDdqWVVTUmxVZ1ZVUnhiRGZCS0VReUVUaE1t?=
 =?utf-8?B?SXdKcUE2ZjNMY0ZJYzVXcjdKL0V3Yjc5dDNDQUtkTWh0OVM1QWcydi9JSnIr?=
 =?utf-8?B?T2pXUDZmL1NiY1cydjQyOWRVZ1o0dGRvUjNuTGo1Zlo1UEJJc3lVV0Q5MGh0?=
 =?utf-8?B?OUErcTRXL0xpOW9kK210dVJlek1jUFFsN1phMk9scFVlUkRDV28xeCs2RUQz?=
 =?utf-8?B?cTFOd2lSZDNMSjJYUFJUZHVHSnVtbjF1YkZMei9MY3V6SGdiQU5rWEhyMUlr?=
 =?utf-8?B?aW1FSkg2UzA1WU5zRnQ5WHpRS0w5NUwybFRXSUJLOUI5T2hWVkVvKzdKdUJO?=
 =?utf-8?B?ZUErdG53RGxoZEZybXpzZjkrbmNHL05ubDhwRlV5UFNrd2VDN3ZzV2Z6Tnlp?=
 =?utf-8?B?ZVEzWGo3eElaVGdzeTJUNDc0Z2hIK0U4R2tTWWlGdmVwRzNOYlg3Z250V1ZN?=
 =?utf-8?Q?9CDd6bfDGFn4VwlDrybDx37MB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5626e35f-8538-404c-5b88-08dd8339e4e3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 14:11:23.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSia236ERHBI1wCJkWxGTAExx5qNOv0V2KgroNlkdyzwkLWUD6xk2bygJcgzX+6nElimSfKRyzyd8jBFZPiNxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469

On 4/19/2025 1:03 PM, Mario Limonciello wrote:
> On 4/19/2025 4:28 AM, M. Bergo wrote:
>>  From 881e57c87b9595c186c2ca7e6d35d0a52c1a10c2 Mon Sep 17 00:00:00 2001
>> From: Marcus Bergo <marcusbergo@gmail.com>
>> Date: Sat, 19 Apr 2025 05:19:05 -0300
>> Subject: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD 
>> platforms after
>>   suspend/resume
>>
>> Several AMD-based laptop models (Lenovo P15v Gen 3, P16v Gen 1, HP 
>> EliteBook 845 G10)
>> experience a CPU frequency limitation issue where the processor gets 
>> stuck at
>> approximately 544MHz after resuming from suspend when the power cord 
>> is unplugged
>> during sleep. This issue makes the systems practically unusable until 
>> a full
>> power cycle is performed.
>>
>> The root cause was traced to commit b5539eb5ee70 ("ACPI: EC: Fix
>> acpi_ec_dispatch_gpe()") which restored the behavior of clearing the GPE
>> in acpi_ec_dispatch_gpe() function to prevent GPE storms. While this 
>> fix is
>> necessary for most platforms to prevent excessive power consumption 
>> during
>> suspend-to-idle, it causes problems on certain AMD platforms by 
>> interfering
>> with the EC's ability to properly restore power management settings 
>> after resume.
>>
>> This patch implements a targeted workaround that:
>> 1. Adds DMI-based detection for affected AMD platforms
>> 2. Adds a function to check if we're in suspend-to-idle mode
>> 3. Modifies the acpi_ec_dispatch_gpe() function to handle AMD 
>> platforms specially:
>>     - For affected AMD platforms during suspend-to-idle, it advances the
>>       transaction without clearing the GPE status bit
>>     - For all other platforms, it maintains the existing behavior of 
>> clearing
>>       the GPE status bit
>>
>> Testing was performed on a Lenovo P16v Gen 1 with AMD Ryzen 7 PRO 
>> 7840HS and
>> confirmed that:
>> 1. Without the patch, the CPU frequency is limited to 544MHz after the
>>   suspend/unplug/resume sequence
>> 2. With the patch applied, the CPU properly scales up to its maximum 
>> frequency
>>     (5.1GHz) after the same sequence
>> 3. No regressions were observed in other EC functionality (battery 
>> status,
>>     keyboard backlight, etc.)
>> 4. Multiple suspend/resume cycles with different power states were tested
>>     without issues
>>
>> The patch was also verified not to affect the behavior on Intel-based 
>> systems,
>> ensuring that the GPE storm prevention remains effective where needed.
>>
>> Fixes: b5539eb5ee70 ("ACPI: EC: Fix acpi_ec_dispatch_gpe()")
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218557
>> Reported-by: Mark Pearson <mark.pearson@lenovo.com>
>> Signed-off-by: Marcus Bergo <marcusbergo@gmail.com>
> 
> Great finding with this being a potential root cause of this behavior 
> (at least from a Linux perspective).
> 
> Although this helps, I'm not really a fan of the tech debt accumulated 
> by needing to quirk this on a system by system basis as a bandage.
> 
> At least for HP someone said that this commit happens to help them for 
> the same issue you're describing:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers- 
> x86.git/commit/?h=fixes&id=9f5595d5f03fd4dc640607a71e89a1daa68fd19d
> 
> That was surprising to me, but it must be changing the timing of some of 
> the code running in HP's EC.  Since you happen to have a Lenovo system 
> does it happen to help the Lenovo EC too?
> 
> Mark, comments please?
> 
Someone just reported that the timing delay patch helped their Lenovo 
system as well.  Can you see if it helps you too?

