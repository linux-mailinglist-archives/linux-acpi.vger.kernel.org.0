Return-Path: <linux-acpi+bounces-5943-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB75C8CC528
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 18:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7FC1F239BD
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBFB1422C8;
	Wed, 22 May 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="40E8FMkL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBEA1420BB;
	Wed, 22 May 2024 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396657; cv=fail; b=ERxncZbSpsAP4kInKOkpSUrfuupPsElCBTgUWNWtIZCmxhmVAD7IjXwIexKiX88743zu31GaV9kR04u7oPE545OzHCDkKp236X66Ms+uFi8Am3CIZTmmJxCWrFOd24i1SG7dXdSXWBBWflkWwf1NDMxfmyfL76jXO0iVs1761kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396657; c=relaxed/simple;
	bh=UzIIT9RWwa60KRC+OeZX5yqXboi/DFJQvh/ZhyQap/4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gCYd0+Ux3+kLPV7N4IrPHM7elTqpv9QmotPCUiaFGd9WCiiMalZBm4vQFTt0epp5OP40OJBXq32Zfm1oSXHs7rv0sbnAaEU/BUSRpVZGOra5g2VORM9lZge3aWBQDVmEJf4RD8ICbOVyo66yhXyUDSY1LnGNqjsAMQqpO+z1ZMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=40E8FMkL; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er9t2FlfKpRb5Tv29UObVfy+gHEAwKd08iScQldUy9yWOjDTXHH+XmubIc/dwlwRxiLegWa1vPf4J4J7dWOz6G0Obs8cOwFimitqHyX3Ms3gA+Yv+dY/4+YD/4ocU68CXpogtmwPQXRsiFq4CuBHWsxQH2Ji04SRwRTsMQaOnb+D25QLc1mryMileJ4jrUYCHyOSw4DY9xcZlhjZcm0DDC9e3YC0AlLwKMj5t+9yha5JPLoLtkLJPdg8b1+jM6eVvFfPusCbaLZeWd7J33Ru43gYccvMgfAQEmt5mvxaUEviq2euT4MTvl7p4aeayjxLF4t0H95AEzf2W3E/P2ve9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvVg0gxCpddypgD3qS/OcBNwUilVKxRz2VMkKQDC8y4=;
 b=R1SKtPJpGBW3+q1xMGocXkw3/OJBaBCPF5ngW7pLGcLgZwZYa6Uu9W1rx8edK8Hzs98YS7fC7iFH991PO/I5Ey/87Wr0qfX3kamAmTMgg4YNRylApe2NOVSlAICtGjHLwSAQQyJiBgIo8E1vSR+GWSRFYlnP2uz1Uq+3dYo1fyrAglggmX6m7lB4TKNucTL70rieyO+iGn0wNAUNNvwyzmql6mzLAPjCrxOM0kSPb2FLglqqY/xKPyLuYkR9OPDhvez8kUtSDtuKSUj0R+HmxrNILMyKdBssdpKZLJBI41FoBvFPdzGu9ptfXL+rCyYPMRCMh0N+RgZhgNRVyjwHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvVg0gxCpddypgD3qS/OcBNwUilVKxRz2VMkKQDC8y4=;
 b=40E8FMkLMWi9+LvEVC2nJNE9gEmddVEGU17HSywVrLBbdnStae4Wpns31DkL9KOUATgNPwN/EdgTYfZJCgmtclJtr+ZZLf25bh0pKs5lpFFS0YdjZK6Wv5taUhyaCEbjR+U2q2jPd8qajLfR/V4PIGPBVFNbG/4ANjq5GKc+dwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 16:50:51 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::ad89:457b:e4bd:b619]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::ad89:457b:e4bd:b619%5]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 16:50:51 +0000
Message-ID: <df4a01cc-859f-4b86-aa86-58bc03fefb02@amd.com>
Date: Wed, 22 May 2024 11:50:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 7/8] ACPI: APEI: EINJ: Enable EINJv2 error
 injections
To: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
 lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
 robert.moore@intel.com, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
 u.kleine-koenig@pengutronix.de, john.allen@amd.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
 <20240521211036.227674-8-zaidal@os.amperecomputing.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240521211036.227674-8-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0906.namprd03.prod.outlook.com
 (2603:10b6:408:107::11) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 7900a27c-342e-4ce4-c720-08dc7a7f56a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|366007|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWs0N2xuVlh3Q0tvNDVvaHZ2V3cvcmNHZGJoQUJKSFpLUjRYdlcybmpjKzBS?=
 =?utf-8?B?SnZsYUpFbjdvV29mUC9tT01UV0RJZWtBcHltUHJGUDVVQlYrRXRoU1BxSm01?=
 =?utf-8?B?SktOZHJxdVQzTDdvSFcyazRzQVJja2lzSG4wQVFYZUpCempDK3F0dWt6QTdC?=
 =?utf-8?B?N2puZ2ltZ2ltMUtRTFJqUXdMV2dnU2JlQ3BtSGZPbGk4K3NIQlBCdEhmOEJC?=
 =?utf-8?B?U1BiVmpJanJEZE1SemJEeDFiN2ZJaW5JNXNneWFuNFhGNUdvMjlqZWZmZHVN?=
 =?utf-8?B?eGRhYUZYNUVQMCtHbHRPWEYwck9XQkVxdHhwMTRRUHJVOUYvdEhlcXVvS3dD?=
 =?utf-8?B?ZHNoaDRERXVKWTdwTlJ3aDVGbEk1TURYTkhVWGpobERzNDJLc0RETW1sVFRQ?=
 =?utf-8?B?R2U0M3ZuSmdFcmJVQ3FSdk53aU0xKy96Z1BqN0NOUG1Da09CMnZFZUIzY3lT?=
 =?utf-8?B?TVVET2dzekhpYXZEQXRMYW1kNnMvMWJnUHUwWEoyZUFkdTdQRUhmOHYzbW9o?=
 =?utf-8?B?cmVNUHpCbmUxUnM1NG1WTC8rSVo4R094UmE4U0RsUmFJZmQzYXZqaEpTQ3d6?=
 =?utf-8?B?MVd3SFNDMy84NzdFTDhtSzlseDdpRE5zK1BHakx1TkNrL043VzBaUzhpdUlz?=
 =?utf-8?B?Qk1XMEVRckp6dmJDbzVSOVYzQllyK2RpWGdtaHZKMHROQVRJRkg3VVZYTldk?=
 =?utf-8?B?akRiWnBVeUwyRVVLcTZ0OHlaUHVtMXIyalA0NU5aakU2NnUwWE9YNSs3eGZ2?=
 =?utf-8?B?dWoxQjZKN2lGTHA5emFDenJVcU82dEM4NVZDLzVRVEQ2NnBqOFFwelBIcWpE?=
 =?utf-8?B?WW5TYjRyZ2Y3QzF6Z2MrVjhTRE9vRHFPbm5WQlpwUHZJWEJBT1JpSXpHUVhZ?=
 =?utf-8?B?ZmhtazZ1YkhuQ3QyZ0VvOUhhUEZ5bnJuditoSEVPYzFYbnVUMmRmOWwrNGVw?=
 =?utf-8?B?eHFxb29zcVZsazdvMVZOU0VYZXJ2a0Z1RlBJT1I4Sk5TYU1abmhiNEQ5eDRR?=
 =?utf-8?B?VU12MWhUZXh6R2tFdHBUVVU2cjJTUjB2M0ZWWklDVWJZUUJ4RDlwbVF1a3ZO?=
 =?utf-8?B?elVDTFgwanJzZ1loRHZ1WUN2b0krbUo0VEtYdmhnWldHRnVwU0c5eG9xeS9R?=
 =?utf-8?B?ZXVBYnlUWkhNb2ZCYmxUVWhIZlBEMVhVSmdRL3FYZE82ZU1WL3RlRkdwSnRa?=
 =?utf-8?B?ekJnWWtnNEZQc3YyanA5a2R5N0M0bGVDOWlFT212aVl4djVwSHpxTmNWMlRE?=
 =?utf-8?B?R1ZzeEJmWUtLc2VGaGJlTVkxTVhxTkhjbFRVenpDcGYvM0c4U2E3M0lOdCtx?=
 =?utf-8?B?Y3U2ajJOdlU4OThaUEJIMjlqa0plbnA1ZjlaTmJNUjFKcTZZMU1OTTNWTFBn?=
 =?utf-8?B?b0ZVcjJEUFlSR2I4SnV2TVMxbEdkWjJYb3U2VDBaVDkrNnBzQ1J2QjZ0bk50?=
 =?utf-8?B?R2IwbnN4Umw1VkhYTlpQNStra25TekdJSkIxeUM5QjIvYWxmY3I2T284elkr?=
 =?utf-8?B?NFR5MldJcnR6SUxsaEl2NzI5MkhpVnZObk9ld2l4Q3daNmMvQTRXVUhvaXlu?=
 =?utf-8?B?QVdXOXYycmtSeCtDMlBla0VVdG0xVi95MmFYb3BWV25MdzJFanhEUGN0Zy9w?=
 =?utf-8?B?eUk4OWlJaDc5ZmpodENCYVJnT1pTSmI0dnFPdzRIYnlXN2xaUE9xVTRUMGJp?=
 =?utf-8?B?Sm5KRWR0UE5nMGlmK2QyOUh2MFNLY3BqeEEvUkV2dUJNTVJvS3YrMjVwRUc3?=
 =?utf-8?Q?Mj+e+zHyHVqEgCzJ2BrzLAWU7apFwJvTmA+qfbE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZitpSGFrYTFYVEs5TDJSbHZFeTBXRlhlTmNVMjJJSHRNYTBVVy9iUVR4bmVs?=
 =?utf-8?B?bVFCUUJmQjYyZnc5NnJsUzN5K3FtUUp6anhhZmhnektkSE5VQ2pGNDg4OW9m?=
 =?utf-8?B?VWxxS2FWNGQ0ZXFWRms5aUZqeTZLM2F3Z2FFaDlaSk4vS1NUZ2ppeHUrdnB2?=
 =?utf-8?B?MEtuMFM0WThMOFdtOEJOclBKV05oWlZqYmw2UFVVeWtpNEFKOHg2WVd1cDZu?=
 =?utf-8?B?THlpbHlZY2FJZ3cyZFVUdkRMOVRIT3pvN2Z0b3Q1cTh3dHR4WndEbUZKRDdn?=
 =?utf-8?B?NEN0TUppN2tCVFBrZGlQWmRBYUgwME5zbmplaWJtR01ST1gzd1Q2VXArZkF0?=
 =?utf-8?B?T3NGQk1peGdsc0JSQ24wL0pZdW45UnJuZVNLaWhVdHFKcVVpbkcwdTV3YTZa?=
 =?utf-8?B?cnV6KzFGSzFxdnBmUzFHSTFoUmh4RWpRcWo1bEJhSkl1SVBBS0hHeXpxNXla?=
 =?utf-8?B?QWhYQjAva3JjNlpDTURaeGdSTld1clRtWTN5d21kRWtzTnlFeW5WK3ArLys2?=
 =?utf-8?B?ZGN6S0EyaWE3R0ljRDhtTHVFVmtSbi9DbVFudTlpRVh3b1NacjZKWEtkek9L?=
 =?utf-8?B?cVBPb0gyR0xwUHpoU0xpRW54cm5IRzRLOUNHR0FVa1hFOFJ2L1BKUU8vczZL?=
 =?utf-8?B?Mkh0NU1qK2pIYTdyNzNjeEQ5Y0d6UExqNHptSHpWaFBpdGpiMCtieWdva2xO?=
 =?utf-8?B?dHZoQ0pGYi9EVlUxcFlGVWZsWVVzcVdSdUY0cFJGNWRRenVYUE8yWUdMKzRQ?=
 =?utf-8?B?dHE5U1pENGd2RVZMUUZEdGx2YTIzMGxrQ1dMSFJYOS9Wd0t6Q0xMK1JrNWJU?=
 =?utf-8?B?Mmh2M0dLbTR0MnRCVzFycmVDalNHZndxY1ZZMXdPUEdtNkxxRlJQZHZLZFZ3?=
 =?utf-8?B?UmRKaWd2V3Q4TkRHRURSOUdhSFVKN1RUYmpzS3BKK2dqWUlFajhuYjlRdGpx?=
 =?utf-8?B?cW4zOFZTV1ZsR05KR3MyYk9rajVZbHdsZnM5WGdPd2p4Vks4bU9IeWd3SlV1?=
 =?utf-8?B?VlpLamZBMDNCbVBzaVBxYlFZakhITU1sTkd4cnVCK2krcXFCQWplb2pUdUlO?=
 =?utf-8?B?eDF6NmFzWndhRlV0MFZ0aVM2Z0pDWDZaUVJEeHkzQVpvUHF5R1JxYkE3aENO?=
 =?utf-8?B?OXVxclZaZnMwd2FmR2QxcWRCNmsvL2RMMXNGbXFuUk53dnAraVNES2dvSnA1?=
 =?utf-8?B?aDh4M09EdmJTRkRVdFF1QUMwYjhmb3Jrb3grSmoyd1RFUHU0ZWtqM29ucnYw?=
 =?utf-8?B?YnBMN1BLRDFJaDRlMytlVGFvaTcxN2lUWng3RDYreFV3b0tuaDE4bUpBTFZ0?=
 =?utf-8?B?Mkg3ZnlzNFpVbmFieHBwZFcwR1gyT05TejN2NmxxSVJKSGExa0luZWR3ZDNM?=
 =?utf-8?B?ek5teVdZRml6OUZQNDN0cFkydXZSdHd1SlN4T0hJNjJqRHdJUHh0NkN4WDU1?=
 =?utf-8?B?NDVhZ09pZzJLVnQ1djBTKzZYcSs1b0FBQjRCUjFCSG1WekVndWIrenlBVWp6?=
 =?utf-8?B?dGF3dEEwaDU3OEh1OVozZTdLMnNlaFdtZzZsK2hhN0lKQ2IyNldUTERJTzBX?=
 =?utf-8?B?Q0JMVUJEblZ5TlRVSVVNSUN4VlQrRkN3RGNvNjZab0o1eEtzVnp2QnhMZXhU?=
 =?utf-8?B?VUFNVVBOYVljaXcwLzBhMjJkTVhBQ3ZWZDhlOG5SNllSZ0dmTVhGY2pUekNt?=
 =?utf-8?B?WFhrZ1U5d3Q4L3ZpRy96OTBKTFRoc3RSenFucXNjODdQYTN3eTh2SXF1SGpE?=
 =?utf-8?B?MHhvQldiSFJ2L0h4eDFVZGc2NkNUdHk1NE9yWktIT2lhOTVRRXJqejh0ZXBW?=
 =?utf-8?B?MWIwQi9odWZldmUxRXp5RW5GRGZVc1BTbVlJOTVaZkNHN2RDZkJUMld1dTll?=
 =?utf-8?B?eFR4LzlvcmJDSmZXT2JCcGRlc1RUOFExKytKNzBMdFNjbFFVVUFBTmxVbFd4?=
 =?utf-8?B?ZjJvejN1V1hXVzF0T1NXZjB5ZXRkdi9IaHdZbG0zZlFHdmZxVDB2TjFlK2s2?=
 =?utf-8?B?YUVtaVZwUlEyVVVTaS9UKzB3Q0R2M2tMbUxyR3FtWDRFU0ZaajM5NGVqT1Jk?=
 =?utf-8?B?Q1g4SUFUMUlwdzBNY1lTaDRjZlY4dmdTa3ZRVEhzMmdkVnRmVjVrMFpBdDZk?=
 =?utf-8?Q?PsTXg7f0iKI5haN2uM5NBhsUR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7900a27c-342e-4ce4-c720-08dc7a7f56a4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:50:51.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C21kQgX+xmC/g/0HqA/VSKPJQ/do6BIx2tIG4ERJswRV2yP0muPmmH/LKNrRiLgzshda+3dTKvDcnoTf0a2kNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570

On 5/21/24 4:10 PM, Zaid Alali wrote:
> Enable the driver to inject EINJv2 type errors. The component
> array values are parsed from user_input and expected to contain
> hex values for component id and syndrome separated by space,
> and multiple components are separated by new line as follows:
> 
> component_id1 component_syndrome1
> component_id2 component_syndrome2
>  :
> component_id(n) component_syndrome(n)
> 
> for example:
> 
> $comp_arr="0x1 0x2
>> 0x1 0x4
>> 0x2 0x4"
> $cd /sys/kernel/debug/apei/einj/
> $echo "$comp_arr" > einjv2_component_array
> 

I think it would be good to change this from being newline-delimited to comma-delimited instead.
So instead of your first example above it would be:

component_id1 component_syndrome1, component_id2 component_syndrome2, ...

My reasoning here is that it's less error-prone. For example, if I run your example but forget to
quote the comp_arr variable in the last line, i.e.:

$ echo $comp_arr > einjv2_component_array

I would effectively be running (at least in my stock Ubuntu 22.04 terminal):

$ echo "0x1 0x2 0x1 0x4 0x2 0x4" > einjv2_component_array

Which would result in an error for something that isn't necessarily readily apparent.
I also think keeping the input on a single line is nicer on the eyes, but that's a subjective thing
and I'd understand if you think differently.

> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 81 ++++++++++++++++++++++++++++++++---
>  1 file changed, 75 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 2e30ebed079b..2e5c00b34a4b 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -87,6 +87,13 @@ enum {
>  	SETWA_FLAGS_APICID = 1,
>  	SETWA_FLAGS_MEM = 2,
>  	SETWA_FLAGS_PCIE_SBDF = 4,
> +	SETWA_FLAGS_EINJV2 = 8,
> +};
> +
> +enum {
> +	EINJV2_PROCESSOR_ERROR = 0x1,
> +	EINJV2_MEMORY_ERROR = 0x2,
> +	EINJV2_PCIE_ERROR = 0x4,
>  };
>  
>  /*
> @@ -111,6 +118,7 @@ static char vendor_dev[64];
>  static struct debugfs_blob_wrapper einjv2_component_arr;
>  static u64 component_count;
>  static void *user_input;
> +static int nr_components;
>  static u32 available_error_type;
>  static u32 available_error_type_v2;
>  
> @@ -287,8 +295,18 @@ static void *einj_get_parameter_address(void)
>  
>  		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
>  		if (v5param) {
> +			int offset, len;
> +
>  			acpi5 = 1;
>  			check_vendor_extension(pa_v5, v5param);
> +			if (available_error_type & ACPI65_EINJV2_SUPP) {
> +				len = v5param->einjv2_struct.length;
> +				offset = offsetof(struct einjv2_extension_struct, component_arr);
> +				nr_components = (len - offset) / 32;
> +				acpi_os_unmap_iomem(v5param, sizeof(*v5param));
> +				v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param) + (
> +					(nr_components) * sizeof(struct syndrome_array)));
> +			}
>  			return v5param;
>  		}
>  	}
> @@ -494,10 +512,52 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  			v5param->flags = vendor_flags;
>  		} else if (flags) {
>  			v5param->flags = flags;
> -			v5param->memory_address = param1;
> -			v5param->memory_address_range = param2;
> -			v5param->apicid = param3;
> -			v5param->pcie_sbdf = param4;
> +			if (flags & SETWA_FLAGS_MEM) {
> +				v5param->memory_address = param1;
> +				v5param->memory_address_range = param2;
> +			}

I don't think you need this if statement since the values will be ignored
when the SETWA_FLAGS_MEM bit isn't set anyway as per the spec.

> +			if (flags & SETWA_FLAGS_EINJV2) {
> +				int count = 0, bytes_read, pos = 0;
> +				unsigned int comp, synd;
> +				struct syndrome_array *component_arr;
> +
> +				if (component_count > nr_components)
> +					goto err_out;
> +
> +				v5param->einjv2_struct.component_arr_count = component_count;
> +				component_arr = v5param->einjv2_struct.component_arr;
> +
> +				while (sscanf(user_input+pos, "%x %x\n%n", &comp, &synd,
> +							&bytes_read) == 2) {
> +					count++;
> +					pos += bytes_read;
> +					if (count > component_count)
> +						goto err_out;
> +
> +					switch (type) {
> +					case EINJV2_PROCESSOR_ERROR:
> +						component_arr[count-1].comp_id.acpi_id = comp;
> +						component_arr[count-1].comp_synd.proc_synd = synd;
> +						break;
> +					case EINJV2_MEMORY_ERROR:
> +						component_arr[count-1].comp_id.device_id = comp;
> +						component_arr[count-1].comp_synd.mem_synd = synd;
> +						break;
> +					case EINJV2_PCIE_ERROR:
> +						component_arr[count-1].comp_id.pcie_sbdf = comp;
> +						component_arr[count-1].comp_synd.pcie_synd = synd;
> +						break;
> +					}
> +				}
> +				if (count != component_count)
> +					goto err_out;

Nitpick here, but you could use count directly instead of count-1 when indexing component_arr[]
if you move the count++ to the bottom of the loop and change the above if to:

	if (count != component_count - 1)
		goto err_out;

or use count + 1 instead of component_count - 1.

> +
> +				/* clear buffer after user input for next injection */
> +				memset(user_input, 0, COMP_ARR_SIZE);
> +			} else {
> +				v5param->apicid = param3;
> +				v5param->pcie_sbdf = param4;
> +			}
>  		} else {
>  			switch (type) {
>  			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
> @@ -570,6 +630,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
>  
>  	return rc;
> +err_out:
> +	memset(user_input, 0, COMP_ARR_SIZE);
> +	return -EINVAL;
>  }
>  
>  /* Inject the specified hardware error */
> @@ -581,9 +644,14 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>  
>  	/* If user manually set "flags", make sure it is legal */
>  	if (flags && (flags &
> -		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
> +		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF|SETWA_FLAGS_EINJV2)))
>  		return -EINVAL;
>  
> +	/*check if type is a valid EINJv2 error type*/
> +	if (flags & SETWA_FLAGS_EINJV2) {
> +		if (!(type & available_error_type_v2))
> +			return -EINVAL;
> +	}
>  	/*
>  	 * We need extra sanity checks for memory errors.
>  	 * Other types leap directly to injection.
> @@ -915,7 +983,8 @@ static void __exit einj_remove(struct platform_device *pdev)
>  			sizeof(struct set_error_type_with_address) :
>  			sizeof(struct einj_parameter);
>  
> -		acpi_os_unmap_iomem(einj_param, size);
> +		acpi_os_unmap_iomem(einj_param,
> +				size + (nr_components * sizeof(struct syndrome_array)));
>  		if (vendor_errors.size)
>  			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
>  	}

