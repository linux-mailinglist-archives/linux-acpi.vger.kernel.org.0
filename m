Return-Path: <linux-acpi+bounces-6495-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C6190DA63
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D3EB222FC
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 17:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF0613BC20;
	Tue, 18 Jun 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hhu7EJ27"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001482D6D;
	Tue, 18 Jun 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730567; cv=fail; b=f9O3X1WxvkYiEfDAfnIHm2PaHMRGjZtZGVITRN3ux7N7Gz6DxkfemEFEvb+A7MOI8lNYTGaeFWkRcwP3LG8x0vBfqwotATFoXXi2aW+fK0Mwi957oQ1kbuK3IdK7DmkpheU4FPqgV7eCNWtdrGOo5cL67mlsaFcQ0fLi99r3LfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730567; c=relaxed/simple;
	bh=9zvUNMdOhkpt97B8pjywb62iIAUkKHe1wiA8ZtFCIWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NfNU9Rs4Q2ODdNSBSHMHwNtDFoQ+LyqBCT6BRAifxDy5OljmxYyds7MiIJ7WkoDpX0VKkJG6//0fOMFWM5SbOnMOFDp3BS7w42K73kTjRsD0TNmYGd8cC+ouxvxvCqX6DJ81BMhdD9Shhyab6GVQAIcH3sYaxRg9Svps73GizM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hhu7EJ27; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMpkZDRniPwDXkc6LcYdj2p/YfHaT9p9i/kJg9RIU4ZOdzZHIaK7LC76BXE4Fu+w3wfHzA+9TVqdSkxzNyXgiWaTSLFFuEI+kKlmcVdeF2ohJxJmm/hNCm0nImpT6pKv8jYRIIQRLkrCjq90FNZOIBwlVHVUuBK/oWR1KmrJxOW0Eh8587Lf95mEpOL/RbdzFz5YW7h/IhqslAfqpF1DOWiTiXiG8wo+K60ghfr/aIxgyS5tVj3lhJuXexHa3z9d+XqpL7REVht5UjHJzPXSF3cfvmLxH1flGeeLunoW62ebKrg4L1SaFlOcCKmYyv3MHPNmk1svW1f73PXoWVanqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDi5lSnO65OPwoT0cQlbBKHkQYqjvUxS5/21/SBCj+U=;
 b=P0uIu1BVFQxSmdX9HyOAfNek+Z7wH/4o67MnJbcZg/fu44eee/zEghSw/3WZIbNnmRc6WrNMO4mfgDrbR0+DLYyinC87PZUKmaAbGa9880mON8UG2aL8fJUF4hAHgZ/fQeu8i5pelCLHYN0a6SrbVMBoVU3xQi2R4Sq/wBKQH+OVSMx5IKVcxVDB98VKWljJ+Q4fnibOzvy8crKaAZKcJOHFUjbZzuCEElRf/DWdguldL8fWOv0nmsBRK1rvkscfeB0NcDRqyudEyjtdbALMDBmad77dAPMic0h0Wi6mWnXuG1V1xmenc7XOJBDDQJcPAgZlBe38vtxnq0G/ZC1Mjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDi5lSnO65OPwoT0cQlbBKHkQYqjvUxS5/21/SBCj+U=;
 b=Hhu7EJ271cu602sxhDuukrxioOcPu83oVvWXZp92Pvqg7HfLOvEjl+ISOnhyxbbrWAxlWShpuvn8lpoRTojRjNUTaWTkz1xv1FBc5bw+c+uqOKPo9C+UJvSUjESVDSwtvWvCKbbNr1vfSorvLXO83BvU1AXfEiDp85s3/Yp+xBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 17:09:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 17:09:22 +0000
Message-ID: <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
Date: Tue, 18 Jun 2024 12:09:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
To: Aaron Rainbolt <arainbolt@kfocus.org>, linux-acpi@vger.kernel.org,
 rafael@kernel.org
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, mmikowski@kfocus.org,
 Perry Yuan <Perry.Yuan@amd.com>
References: <ZnD22b3Br1ng7alf@kf-XE>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZnD22b3Br1ng7alf@kf-XE>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:805:ca::43) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb20a0d-dbf1-4b25-c005-08dc8fb965bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXZPV3AzTllRRzV5UzhzS3dOM01rdlowekVTQURXbFI3UVZDRUI1RnNQU08y?=
 =?utf-8?B?Qjd0cVJUWjNUbkhacnBxblBMa0V5clJXaHRJZzRIU0RIV3lSWkJpVlpUWm9a?=
 =?utf-8?B?eTdObnc5Vk5aN1RmRG91M05nQ3dKZkdHWE1JQmZNMzRFdGVWSmxBOUIxWUxr?=
 =?utf-8?B?TGtyMFZRUWZYdHordTF3MHVVWGZmSitqeEhaUXZTV1gzV3R4dUg1bEJGbkYw?=
 =?utf-8?B?dkNid3EvMHBsNG8wczg5UzVMSHZ3YzJmTGwwcnR0ODh4VEw4Rm55T21DYTVK?=
 =?utf-8?B?ZG44N0ZMb29BRXU2ZVBmRjV5a2NlZUpzbmRQeVIzVTRleEV3WjhEVVFyM0Vi?=
 =?utf-8?B?UUdTNDZpMlJoa0R0V21EdGs0S0ZiSEtjUEZBVzhiV1ArSzBqUDd4V0FYejVu?=
 =?utf-8?B?bU4vQnV4bkdVSGR0UFhCMFFYRmduRnZ4Qjkza1p0RVFGbkEvTzk1OHlmOXpU?=
 =?utf-8?B?cU90SGlKekxSbGJBamNQYmQrWkh5aGZYRUl1S2FaOUpqeVpEbUYyOWNHZ0Vv?=
 =?utf-8?B?Wm9OUTU2Rm8vdi9BNU1HeDFITVpxOEFWV0NaN2RxbUlLbk55czVKeHZoUWh6?=
 =?utf-8?B?WC84Q0JyK1phSEJGTGpyM3pPb2xGZGRuazVsaUo1dWNMaFd2RmNCZUFTMlZK?=
 =?utf-8?B?emZzRUFqdmxPS3h5dVQ4VkxpUG5WR3JNRTZKd0RsSXh1alVpZnVibDJWcndK?=
 =?utf-8?B?ckpSRmsrNW1TN2V2eXFHM25MVUd0NzkyYWxxSXU5d0VFWFllNGJlYTNIaDNT?=
 =?utf-8?B?ZnNvVzBkN3lYd0gzQ3YwdVFrWGVNb2Q1WDRZaWpwdEk2QmlPbnF1Kzc1K2xh?=
 =?utf-8?B?bWk5ZzhtS1plcERnZFNtR1NUdjg0RlJzMUZtTkZ4djVLUzNaWmVSSUdqRFdC?=
 =?utf-8?B?aDI0d1hrUVJHNUQ5eDA5VWpYa3ZLWFpFbXNqSjhKdWFTU2FBWWlEVnVFNW9M?=
 =?utf-8?B?WGdEcnlLV1dORUt2ODFPeEc4M2NJZzBZR1o2akJjVTNFVDBjL292ZUVIckVG?=
 =?utf-8?B?dnhSWG96NG9rbWFya1JXaUZod3dPc3M3a1QzdXF3MzBBZTR5bDgvUFlzazJM?=
 =?utf-8?B?T2FZZjM4UzZadnM3YkRaMEZ4QUtjMmN5RUJtS2ZnMFVKWEprVk40ZW15ZURY?=
 =?utf-8?B?a1VtZG1oTGgrMzF1ZU1qaFFWWUpNQ1hqWFA4aVRMRlZoemEvL3A2U0NycExr?=
 =?utf-8?B?dndBVnNTcmNXRjR3Ym9vMWFWRG5UdFVaT2puRFkyZ2kvclNkTmxXOUM4c2s4?=
 =?utf-8?B?VHRWVjhPcGYzZVdkME45TVJQbThpUS91YW5YZkhUd1FGWUpvOCtnekpRbGVj?=
 =?utf-8?B?dldzMWhiVVVQNjlIVkhlemJhRTg2b0VOSi9qTEpDMnRKTjZqaHlTV0t6Vnkx?=
 =?utf-8?B?QUNGZVdVbEpPUFZZQkpCR09rcTU0aXg3R2p3ZVhJeWFlSnVObXJXRUthSVBX?=
 =?utf-8?B?amppL2lEU1FzZWV5TFRsN1YzZnVSZXdyUDBaYkU3Zk1xTzA2MHJmSWxVOEc3?=
 =?utf-8?B?YUFPZDVMVEEyOVREYWxsYndGMjJ6UDE2ZVFsQUIzUHprNmplKzJyOEE1OXhr?=
 =?utf-8?B?YUZtNEtTdUVzVmkrVjU0RDhad3k0Z3pZa0FUdHYweEZsMVNzR1ZvNEFsYmRV?=
 =?utf-8?B?YStValEzTnh3d3AzYlhIdG9zRzhVZ21pVTc4UmlBaEM4dGdwU2pJd1hDOUxX?=
 =?utf-8?B?L3NiQXk4bnNkS01tNXBOanRZRldCUFRia0xRc0pVUC9NdzJJUm1MWW5ZL3BM?=
 =?utf-8?Q?7YqMaO6O5rZWvaq3EkxY/3/5u453du98Ueq+lQ+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vzd2M1JPUzZwUEVVbndBdExpZnhEbFg0SG5UMmE1S1dVMm1nTXAxQlZPb2Jj?=
 =?utf-8?B?eGpxRUJjdVhpb1FOd251clhiNEppUUEzVGZNZ2RKWVdrVXc1M3dKOWVhUTVt?=
 =?utf-8?B?bllOY3pOZXBFMzBPNW1vSDV0LzVtelVIaUVlZG9yL21yTEZxWWpENFRKN2ZO?=
 =?utf-8?B?QUpJMnNZR3dCMnpJdUwwck5FeTJJT2ViRnZWWEZ3OEZ1L01CYU9MQU9JWkEx?=
 =?utf-8?B?a0IzQTd0K2tjd1hZMFdQSWlaSFFIcnh4dFN4M3c5V0huZ0lxaGN5YjdMN3Y3?=
 =?utf-8?B?Y3gxMU0xK0xEbTdqeGd5cnN4dzFBalVzeWZEcEFocUJ6M1NXQTY1Ky9kbWxC?=
 =?utf-8?B?elk4OS9vUitkNStSYjJRNHhPMTc4Mkw5RWw4b0Z4T0U5RTg3dDJsSXExWTA5?=
 =?utf-8?B?UllnSGNLUldGVjl3a016Y0VvNFZKNmJuMGFFcm1iejhTeEFJaVdleTFSTWQr?=
 =?utf-8?B?Tm5rSEkrTWkxU0IxZWg5Nld6djZCNjh0dHJraGI1b1NzdXhCeGR2VUtYa25F?=
 =?utf-8?B?TFRIRUhTc1JpNUJLblI2NDBudkY2NDIxT1MwWEF6L2NQV3RHTlVaUlBiK2t4?=
 =?utf-8?B?TEJaQ0FFNm1DcE5EOFZpTFluYUM4ZTFPb3RlbEEyZ096RjJCakFld0NONTFl?=
 =?utf-8?B?azMwbzlidUJpRXhLbEN4QmFzVHM5emxTVVQzZEhFNHhlWE9GdW5jamhCMEo2?=
 =?utf-8?B?aEE1eldxSkw4QmJUM0pmeFk2R2ZYdll5QzBDVVg5aytWR2EzRE9OZW1wSEw0?=
 =?utf-8?B?UkVtaUVTbnJqcjlrWTJtMmFadnQyM1U2VnVKSW8xNTZ4eU5tTnY2SW9MVXI5?=
 =?utf-8?B?dU5ZeWNIWVA3RDRlQkZ5R0lGWGRlcDBqMExwYzUySWplQWt1SENJekZZWWVT?=
 =?utf-8?B?UGIyRnhhUyt2TjRsczhTT2djTXpaQ1ZTZUp0QTIxcldqWTlCTEpMOGE5U2Rs?=
 =?utf-8?B?aDRTMEZvSjEwbHFSZHBmMUM5M3c4ZU9hWlZWbUF2NWxvbjZzeThjaEYyaldu?=
 =?utf-8?B?dWNVUmE2UElaZzgydUw1dGdlMm9SR0Uya3hPYnp2S05pMnRDaHJwbzliNXN6?=
 =?utf-8?B?czkybXdUUzlpL2YwVUZvWTJDS1NnOElvR21TTUlFNnJMVUlveDI5RlgwalNu?=
 =?utf-8?B?THJ2YWNCaU4xWkNIbG9idjlvM2thQ3o3Unk2MnFCWWtwMGE5QlFWMW1kZnNl?=
 =?utf-8?B?TkVJekkwY2VuUWRKSk1WbHJIcloyUkllWCs3ZHVCV0dQTjB1dU10cXdwRzdi?=
 =?utf-8?B?NnNMUDNSaHlzQ3o5Z29qczBLUHRJUWY1M0hZaUErQnMxcDlrMUFFNURWanBN?=
 =?utf-8?B?ZCszVkxLWEovNVZEQWtxSUZUamlWemtCekN2L0JFejFBSVpTQmdCdHRsTFlS?=
 =?utf-8?B?dFdGa0JVRlJRQ1FMSUx4ZExRRzBhTHllbUZxeVpaN1poUXpwblA3bmJ5emZ5?=
 =?utf-8?B?NnNOUFlXaHdtQmRUaEhFVVdicXViYzVDTUJPV2FaTlZYelQ1dnhMUFhVQ1VN?=
 =?utf-8?B?anF2V0NuSThETU9MZit0UC9hZ0M4b1RzNU1TM04xZXlBK0ZOK1V1S09vNksw?=
 =?utf-8?B?ZXFuUGhURXBJUG5GMlp0eHFJVXN2L3N6RFpyanVpeHdkN0ZQZ0s3TktkbTVi?=
 =?utf-8?B?OVozQnZFV3p0VDhpdm9JTTJGTnhOODQ4WGY0dktGZGFGVDV2T01qbGhINW51?=
 =?utf-8?B?OGZQZ1gwUmtSSFpIQm9ldnRNV0hTUXI4Y2RQbFNudkZzV01ENlVqaGdGS0FP?=
 =?utf-8?B?OTA1ZEx4dWpmQjdvNU1pNXRiNy8vU253TWlrWWdYWVBjcDJQV2UwTVhTb09x?=
 =?utf-8?B?c2RvWFVobWRodzlTcXd6SzIvTDJyVFVpaW1ybWkvZU0zeTBlemlucEFiaWY2?=
 =?utf-8?B?M050V3cvZ1dGTnFMQnJuRmx0MjVlSHJnSzJ1MUFvaVhZZkdtN1BpOHdwKzl6?=
 =?utf-8?B?aW9ldjVnRkx1VVNHUWwyVjRjNjBFWUxwbUZ1WjI1WEsvd3BFR3hXbGxBaXVV?=
 =?utf-8?B?dnhMelViOG1LNFRqblo2YVJBN3Q5RkhaK09aZWhENit1M2tsZDhuTUZraWhv?=
 =?utf-8?B?REZhVXlXaVpjVVg3WnJsKzhFeFZzTFVQZWZvdnJWTWNhT3ZPSC82bVhucUhP?=
 =?utf-8?Q?64Yg3aJ9lVROEQu/1sItKc2Vs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb20a0d-dbf1-4b25-c005-08dc8fb965bd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 17:09:21.9961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxCqHNoNna8g6HzxQ6zItrL1aZfwEW2C0FA5zDq/2wze8SCcDf7YHQS9Fq5YRBxvut11Jn01G2Vl2SNtvsNF5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432

On 6/17/2024 21:54, Aaron Rainbolt wrote:
> acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> 
> The _OSC is supposed to contain a bit indicating whether the hardware
> supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> be considered absent. This results in severe single-core performance
> issues with the EEVDF scheduler.
> 
> To work around this, provide a new kernel parameter,
> "processor.ignore_osc_cppc_bit", which may be used to ignore the _OSC
> CPPC v2 bit and act as if the bit was enabled. This allows CPPC to be
> properly detected even if not "enabled" by _OSC, allowing users with
> problematic hardware to obtain decent single-core performance.
> 
> Tested-by: Michael Mikowski <mmikowski@kfocus.org>
> Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>

This sounds like a platform bug and if we do accept a patch like this I 
think we need a lot more documentation about the situation.

Can you please share more information about your hardware:
1) Manufacturer?
2) CPU?
3) Manufacturer firmware version?
4) If it's AMD what's the AGESA version?

And most importantly do you have the latest system firmware version from 
your manufacturer?  If not; please upgrade that first.

> 
> ---
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1d857978f5f4..53406dd6cb87 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -671,7 +671,7 @@ static inline void arch_init_invariance_cppc(void) { }
>    *
>    *	Return: 0 for success or negative value for err.
>    */
> -int acpi_cppc_processor_probe(struct acpi_processor *pr)
> +int acpi_cppc_processor_probe(struct acpi_processor *pr, bool ignore_osc_cppc_bit)
>   {
>   	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
>   	union acpi_object *out_obj, *cpc_obj;
> @@ -686,7 +686,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   
>   	if (!osc_sb_cppc2_support_acked) {
>   		pr_debug("CPPC v2 _OSC not acked\n");
> -		if (!cpc_supported_by_cpu()) {
> +		if (!ignore_osc_cppc_bit && !cpc_supported_by_cpu()) {
>   			pr_debug("CPPC is not supported by the CPU\n");
>   			return -ENODEV;
>   		}
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 67db60eda370..a183bca6c1c5 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -33,6 +33,11 @@ MODULE_AUTHOR("Paul Diefenbaugh");
>   MODULE_DESCRIPTION("ACPI Processor Driver");
>   MODULE_LICENSE("GPL");
>   
> +static bool ignore_osc_cppc_bit = false;
> +module_param(ignore_osc_cppc_bit, bool, 0);
> +MODULE_PARM_DESC(ignore_osc_cppc_bit,
> +	"Ignore _OSC CPPC bit, assume CPPC v2 is present");
> +
>   static int acpi_processor_start(struct device *dev);
>   static int acpi_processor_stop(struct device *dev);
>   
> @@ -170,7 +175,7 @@ static int __acpi_processor_start(struct acpi_device *device)
>   	if (pr->flags.need_hotplug_init)
>   		return 0;
>   
> -	result = acpi_cppc_processor_probe(pr);
> +	result = acpi_cppc_processor_probe(pr, ignore_osc_cppc_bit);
>   	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
>   		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
>   
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 3f34ebb27525..79fd61b3f537 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -358,10 +358,10 @@ int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id);
>   int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
>   
>   #ifdef CONFIG_ACPI_CPPC_LIB
> -extern int acpi_cppc_processor_probe(struct acpi_processor *pr);
> +extern int acpi_cppc_processor_probe(struct acpi_processor *pr, bool ignore_osc_cppc_bit);
>   extern void acpi_cppc_processor_exit(struct acpi_processor *pr);
>   #else
> -static inline int acpi_cppc_processor_probe(struct acpi_processor *pr)
> +static inline int acpi_cppc_processor_probe(struct acpi_processor *pr, bool ignore_osc_cppc_bit)
>   {
>   	return 0;
>   }


