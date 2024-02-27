Return-Path: <linux-acpi+bounces-3979-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F575869993
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 16:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AFA1C2416F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11E7146E87;
	Tue, 27 Feb 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mUZYdLeK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA849146E8D;
	Tue, 27 Feb 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045804; cv=fail; b=RWQdUV+1AhHrSTq2GqSewcpAk5J50fberEaEIueYLGOetl8ZWthFXszPfDqMkKVeqbonSLaS1btvUm9d+kLtMWjMnFl//3nEtBETqIrqiDxKxshJu9C89XlYnMjrY5v7XKL19M1ERrM5MaMTV1wG4SG1Yc8y8gfMjkUn1kt8FYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045804; c=relaxed/simple;
	bh=Q83eSQsvd3r/QqU1Ande0RR9V23B4pQZZXsze9L//b0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RDc3TrCHmIRDnoVHH+gcB6hkv5Gq8eseMifXzK8iV6hz2UsvZ+gzP1mhVYZ9lSveKobOspTr3jJuMO8W3wXpFvLe/hxeaGdIXXJNYbmzC851w5rRNjPObLfSRiPst+3g4Lov9kyPqR/IGuT+PH2LmBybt0vOpZQTHdn7VJxaTfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mUZYdLeK; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7NNsUFa24u62cd6sJqfR7EyzFxNHmnfLFfDtEn8AesMCS/deS4uz0m9aDL0+mxlmhhC9vxv70e1dpAkdTZ9v7R6iWXGKRe8M3wdgN2kXydKu61mZOS4tAhz593GiVOVdkMoRSnTlNbGB0w0Hjs6zDKIx3KlTRmlGTsRGkUuFoTEqizhIhOT/QSbMCSNjimIOlD93jDHH6pAROyXV88t/5RGmRpX2m/kaRI98McRDRZIy24nCGwO+PAyz8Ktf+JYWT52sPqCofE8D958uLcH1LPsVkMNqViDqiL6Gdz0Hkjnmx1VgvdFh3Vex4eGfPuTiigl/jXLmLwGoeB45CW+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRfSNdNftWU6/9IzMw74r30UFhXx4qfv3LNlADTSfYw=;
 b=GZQSbTqT6guNL2Uu4gJKUEI/7Uzy5Dwi4F6Yk40xXctCiDNlaXqtt7jr55x+qauiPRMzYAtE+5vpradrbX+x9PEGvXXJrGxccwBNq/+jc1pdB8pIp0S6tBS7pmXdZQh3Tmjwdr4ipysaOQ7/tmSIIkh6FHLKS9y/bgZUaW1K4/60OVwFnHoMPs/tM/BQ5L/w8XIIlc3RWgeCEGzJRIHTykd4oMlPMwItpFq/V9v1L7ngLeJTDs2tE20IZtBJjSpoIkae5gx4tng+7sV2CIgXCYD8YXAw25tJ8Nn7b/nJQFQ5OzrtcmwnfFJT8Hw+nsf/CMPUQKpfdhE4gXL9V6/0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRfSNdNftWU6/9IzMw74r30UFhXx4qfv3LNlADTSfYw=;
 b=mUZYdLeKb9zWO71i5wUiECQkNNPkOXKLAlIeB59fZB874uGxaGusFhQNwEulEqeA5ybrsGi4hRUaD6xWJ7gvfqEhkN6JhcMtOck+yknnLIx5snFNACoRWwS2J+S/WkNwprwZ6E9DBnRVCOtT4F9Af6uYPouvdWpPyUdutxfqeLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 14:56:40 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 14:56:40 +0000
Message-ID: <d1a9cca2-72fa-4bca-947e-5eaf5ecb530c@amd.com>
Date: Tue, 27 Feb 2024 08:56:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/4] EINJ: Add CXL error type support
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "james.morse@arm.com" <james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>
Cc: "dave@stogolabs.net" <dave@stogolabs.net>,
 "Jiang, Dave" <dave.jiang@intel.com>,
 "Schofield, Alison" <alison.schofield@intel.com>,
 "Verma, Vishal L" <vishal.l.verma@intel.com>,
 "Weiny, Ira" <ira.weiny@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
 <20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
 <SJ1PR11MB608331BA3F58C3E6559697F3FC5A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <SJ1PR11MB608331BA3F58C3E6559697F3FC5A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|BN9PR12MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd0da81-855f-4230-d929-08dc37a44ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q3r6/nqVUUVp6aJpNDyGNdNHy0fYdDYIy+c7iCQNX9Atsu7sER9+yNLfqkoQ56vK4Ae/FvOZHrLhhMsmFikE7iRcV04/uBcULFB7mqaRbPt+i3TobPtFkjZbmQgBudCMWx1nlnMH/hi7wEYsTbKlzy43g36e27bEROhGTY+yjle2mYjP2D/zWkZ22fSd5PrP9gs2Ca15PfIG2NYzgWTqNYxHq8Kt7sfGfcoCQBW7cXH8EfpHia+fcTuamdrL6DgaKLy+ZrwYzqw/qHXhywDWeCcTltCWQHlLPWiukU4LaCfJ0Zzyb5a2hjPQaA3U7haz3bQ7j61/1EQkHXGdwsDbPp2CaIbDI+szfD+RuIoEPZNxjkIMcgGRkKJ6bnsmaz2LbFEI1eQOG3D7ttJsrYTd4Ec47FF8+WXATG9gGzg1J4ZwRKUp4Wj57jwI4swIegMbHE9cFELUYr7Z0q1GQMVLF/S5Wa/I6g1Ou2XAZqnY6kgZABMVVq73bPJ00R+80Uv7zjsTUZWK6U0DtPb8T2/l9gb202onJ0mSL9rPMQfQkhcyF2BV+jwtAuxn6nw+4xfDUWBarR4RMrN3Yy2eWXARveeV/n9vU9Bi7HKQuC6Pwcm+ZFFZfFW7XMPpcTaPqesGwBY2C5aok9T99m5Y+BHJ6w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEFJU2Vidi9BVER5Yk1aTm81Qk9tcFVWZjZZalFYVVZQb3lIamF0OEZJV0lY?=
 =?utf-8?B?L09FeG91Nkl6M3pKZlp6WmIrNThxdmd3UjZ4bVJGQlEyeDlPMnlvS0pLRXli?=
 =?utf-8?B?ckJTaDY5OXI1eEMxY0tvZm1lOFc5Y3gwTkJTOHgrRlVDUFl6TkRZa0IxUU1w?=
 =?utf-8?B?QnNkbWROaTBsZzRBTytUeTQ2T21GdVV0aE8wbUh1MEpqMFZhejFDREVYTkl5?=
 =?utf-8?B?QUlrc2Q1MWZXN01ZTGVRdkJ4VWUzL0ZqcFpuZzNxTFBSbWxZUkpBLzl2Y0Fv?=
 =?utf-8?B?SCtWdjB1aDhId3JOTVpvaG8vQ0xtTE9zNjk2SmxaVmRKeHNQRzdFa2NLMGNy?=
 =?utf-8?B?RzBkWThBSDFIQW44aUtNUXByMFpNSlBpcE9TT2lsNjVPa2xVc3NJRElPdjNw?=
 =?utf-8?B?UFNvdkE3Q3UvTStSUzZFZXdrUzcyZFZTMmplRVBzWlRIamtSczNNdWJuT0Zq?=
 =?utf-8?B?WjBDUVo4RVlQTHdNaGlGaXZaaDFPa2hocFJiQU1IbkJSZ2hmNXJtOS9RaTJN?=
 =?utf-8?B?elRLcGc2TlRiZEdwWVBEbGtab0JjdmNEOW9QYVF1RkFPMld5WUE2bklkRzUw?=
 =?utf-8?B?Y2RwZ040WGhFeHl5dXVVMUllWEdLTytyeUJYY1UxRk5nRUFpY21BbHBReE5E?=
 =?utf-8?B?dVNMVEl0NDZzWEtGamVKWmtScTNZNDFKbkU0RG5NYUpqQnRLMVI2WXpHNDJq?=
 =?utf-8?B?MjlOR3ZrY2NQRDVuZWswK0Jud2ZHRWRkSExMdWpEM3dZQlFBMXk4V2w0a0s1?=
 =?utf-8?B?V3I1ckYraWIybjBKN2k0NGJCc2VrSVFObE50MmxVWnhWWElsaGJ4dStkV2Nj?=
 =?utf-8?B?dlhmbjZRRXo0WTVEdjI3WVNaRVd2bWJUMGhxWlRsUkdSTmpic1dTd1lDb09n?=
 =?utf-8?B?MG1nQittSnhvV1BRYi9qTnZKTVExL2xYMkN2cDZ5QnU0TUgraEFsT2E0Rm5V?=
 =?utf-8?B?cDc2bmplQlJwQkFScDB4bW9EQTZXZUtGY1BlSGtWWGRoR21CcUhYZEJaaU5W?=
 =?utf-8?B?TlRYVytFTG44VHhMVUdZWmUzeER3bEpjeDZZd1hvSFptQml1SEdHaW1aNE16?=
 =?utf-8?B?WlpwRENyZXVzOExUMS9XeHdTL1B6M1lSZ0RyMzhEU2NESmExZXF3ckhDM0Ry?=
 =?utf-8?B?dzV3S3R1akFZYyt3UjNUcDI0WlMwWnV6TERzSFEyOFZWekhGTlA5SWluUWRZ?=
 =?utf-8?B?ZVQ0Q0xONjBWTTRtTUVEUHpjU0FmSms3NFcvZmRGVEF6d0RvZWtKRGw4RW1R?=
 =?utf-8?B?dkxoK0dNOWVoTk5pVGZRdk5DaFJjQ0xxdGgvQ04ycEliY1F5SnRCRW5CZGZU?=
 =?utf-8?B?dElRVUhzWnpXQ1p1eU9ucTJ3OUI0ck5SREtxdzVqNjJKTXJicjhpaXdWT0cy?=
 =?utf-8?B?Vi9NN0JEQlYrNmMzdGRpK0lsR2RFUlpQV3lFOTZrY2libXMyUjVEbFFZSGl3?=
 =?utf-8?B?KzhGN25ZODVWZ01Qd0NQZlN1UFJsMUllT3FIY3ovNXhQTzFTL3BIdHBjT2pE?=
 =?utf-8?B?OEUyYkc4RGpYaHhmQ3JRRTEyaW9ocGVuTzQrdHJwVXRIUTRHR2wrVXd4RzRP?=
 =?utf-8?B?UGZpS21UU0MxeFJHS09peXVHUENCQy9ZQWNGVmc4MkFZbzl0Vmh5andKcXFO?=
 =?utf-8?B?UzRJTGlXRjFwZFZ2aVMxeEFrYTZZZlVTMFU0YndmdU9oR1NhQkRZekF3WDYy?=
 =?utf-8?B?MjhzMnk4RXIzMFdxeTBCUzMyeFpkR3R4TTFQNm1DMEdMOXNTTkhwL2U0U0dz?=
 =?utf-8?B?eGM2NjVTdlRLNmVqQ1FIMjZyUmxiUjhBb1RUQ1Z5dy81TWd2czh4ZUFvSnVR?=
 =?utf-8?B?cWtKQUxGV29jem4vcFZmWndFM01yWWwwZnRlUE1aNTZiYm9kRk5EbVRlYzhw?=
 =?utf-8?B?dlE3VU9vSjZKaUxsVlJRcGd6VlVtYnd5SW5odlRJV0loaHVxUmVKalNRdXdQ?=
 =?utf-8?B?QjlqbzlRWWx6UGdMT2Z6TnRXUXpDY2tKeUxOb2dZQzFRcWdSdUNmaVB0Ri9w?=
 =?utf-8?B?T3gzc1RlTytKcnZSNFlGTWs1Q3ZFRGNQREVLNjl1TEg1djJ5N1lzV1VlSlZu?=
 =?utf-8?B?VHc5Ykp0aVF0a1BQbk14bkJRKy9lYVBYRjNaOERTY0ltMnZEek5XSHdHUDN2?=
 =?utf-8?Q?jNSAcSblyWfRLzLwIIfd9Bai4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd0da81-855f-4230-d929-08dc37a44ddc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 14:56:40.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKuYLxwsnDMpNaI+9VEaC4YqpfOMsbzHNj/AssJjvw8z9tkLVu1Fi1UMM6HkvRK4KgSyHIUNnrmJG/ea9TF8Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368



On 2/26/24 4:47 PM, Luck, Tony wrote:
>> Remove CXL protocol error types from the EINJ module and move them to
>> a new einj_cxl module. The einj_cxl module implements the necessary
> 
>> +config ACPI_APEI_EINJ_CXL
>> +	bool "CXL Error INJection Support"
> 
> It's not really a module anymore. Need to update commit messages.
> 
> -Tony

You're 100% correct. I was in a bit of a rush getting these out yesterday and forgot
this message (and the next one) need to be updated. I'll send out replies to those
patches with the updated messages.

Thanks,
Ben

