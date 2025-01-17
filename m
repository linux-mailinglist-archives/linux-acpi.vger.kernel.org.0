Return-Path: <linux-acpi+bounces-10738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43912A151D3
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 15:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8247A188CC7B
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F415350B;
	Fri, 17 Jan 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pcpFOjX2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65DA5464E;
	Fri, 17 Jan 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124250; cv=fail; b=N0mqLz70FSFXh3aW51QlKrLkrqCry6eV3bs12s1jyvwYdlqAoU7KXJhfPxSRZu/J24yg9kJz4L8yGrM33IBG9SzeW8qhnqCkrCUE1G4DctnMT4800sV4n1Cim+/+4Gn6MzayzLuG3ZlDTPQ/IbESUBEB17PHCqOqGseJ9QFd7Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124250; c=relaxed/simple;
	bh=5j8j+Q6LYPmHJAnuZqQjvzawmjaZYfxN53iTuSyuL8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PwsZiZvuiePMuOTNsh/MkPRu97BmWyY3RdgSY1H38UGqt4VgqbTeCP4nr1j98m6rLfVbxc1fg+GkG4YfL1OuSuotL3vtCO8irJch1WLs6iRVbHxFZVqrH5leAIyXgOWuyzhx91l/zaaJcwGbg4umoqLzzJ7yoKEmtQ8xh63l3F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pcpFOjX2; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyfnaFdsMMOsAtjHn87Xr4Y++K5EMl5lueNv8PkbTzOJX+7Iyz9oJpTO6AqpxWLmBMHfOIL7EpKlx1jP3naiQraL30KQpW4pKJh/BtnMnx6u7L9iU0rPbDQCDoWdAYxyxb/s2P1Cw+YjgdZaOyPWKacxENVGAbGDCEEQ/eL3kC8/Rwrs9czRg6TGjNwbOXVPdKqCQ1jRJQI3PzyOtfIXBQnkOVOlBzNpzGdW9V6IG9//lOClmZlMtCPBS/yWY9OFXhaTU7HFtUdELVGr2TtZ8zMZEstmxeocCLsYqs5eSZygXk2oXvqkb0WR9qpsO+sy5xrIFFtYM88ZmBCSkGctwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1joYb9mq9L2tCoIRCiqt2jH/RvYu5riUg85FSOj7xQ=;
 b=JVjwyesC0uJeZAyDteHJerHE5k14Y1sXqx9fhj8u9Wtq7UIq3NYMITP92nteo2a2cHGSAJf896KcnP4IfuvSJiGyi2PD8EDAS/RD6IZUXYTD/P/cFWZ2t7+R6YmK9LTu2zsO6Xu51K0VJuE6x/VptYJHffx6oeAvECh3RF5vleDM+T8wYvQfGCBD2uCtjj1hOFVdmIY9nqxI+pWswCM8/j3r65aU3Kvdrdb5PO5+2QV/EVshcsQLn0j73Y3iaAWOaLbGA3CTaf5gXebnvRsBBjgSIZYznp+ZqJ/+t/P74YZAYCUUlQ5HaKDllC3uxD4TfBc0x2fdsy2PbrFFxko6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1joYb9mq9L2tCoIRCiqt2jH/RvYu5riUg85FSOj7xQ=;
 b=pcpFOjX2l94uuAfWz5g7jf9BF3SQnrKHGiIdH4YRdKsDcG3hgjfe/g4tYz/N39ac1YyoevETVc3eizDl1zyIpZM/Y0u/h2IChB+j0Bw+sSjX4dJ3m1skyZ58u66fbDoajrv6jUgiyffOvX/bxG8C3PhHClHyMxPpjwgFASp/Up8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB9460.namprd12.prod.outlook.com (2603:10b6:610:27f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 14:30:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 14:30:46 +0000
Message-ID: <270a1cce-8afe-497a-b30b-56157d75a863@amd.com>
Date: Fri, 17 Jan 2025 08:30:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 Russell Haley <yumpusamongus@gmail.com>, rafael@kernel.org, lenb@kernel.org,
 robert.moore@intel.com, viresh.kumar@linaro.org, gautham.shenoy@amd.com,
 ray.huang@amd.com, pierre.gondois@arm.com
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com,
 hepeng68@huawei.com, fanghao11@huawei.com
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
 <21654032-a394-4da9-8ee9-d7cb9df8c855@gmail.com>
 <6909eef3-20aa-4341-9177-a42323a0d5c6@huawei.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6909eef3-20aa-4341-9177-a42323a0d5c6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:806:24::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed2b261-c72b-4442-6196-08dd3703883c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y01UUk92bkF6MGxzU0RPREhQUGxscUV1TGF4YndOTURML1dsMHZUVkcybUZ1?=
 =?utf-8?B?NXZTanJBdmZtTlI3dVJGVkJSdC9xUThRTVhoSkxnajVKS1Qyc3hlUEhERFZE?=
 =?utf-8?B?OVZ6VE80QmE2YlV5ODJHSmozUkJ2TThWM1RXdysyS3o2OTMvR1JtTEloeU1B?=
 =?utf-8?B?S2N5dU1qWVFyMjY5dTlNMkIwSVpRUG95WlYxZzlOeXNIOWFock8yUDdwUTQ5?=
 =?utf-8?B?YXJmWTRwdkRLN1lZbDVSbmd4bFFwcUVMVlhsZ2w5SUVpRGN5czQ0RUJRRkly?=
 =?utf-8?B?azlZQW9aMzFhRjREMlB1czZpVytZUjBaUEpZSGpXekhTdGpkanZCMEFHMlJX?=
 =?utf-8?B?TFNGVEgzNWFiaEhLL3MwM0x4NzF6aS9VcGFCamlDRVZHRjlqeXV0MEV5TTAy?=
 =?utf-8?B?ZFdpem9aQkVURnlqUXVSOW5xNm5pZEFyT0lLL0syeUd6NDVQK0g4R055VUxZ?=
 =?utf-8?B?VjdVT1hnSjNtUUxHK2hiY2huamtQQkdxVnZ2VkdKM0Y1V3p3OVNxVlBoZkNW?=
 =?utf-8?B?UUdyUHcxSXZoQ3d5d3lvTGtENmdDTVE4QTR0M0N2aTVEWWlFc0dNeVgyN0Nq?=
 =?utf-8?B?eGR0WWlaalViSmhQN3ArVis0czdacEUyUUZLM1RvNjRwT2NlbExLRXRWQVk0?=
 =?utf-8?B?WWhKU2xQZ2VxaytiVU9VVHVqYzFaVnkwTzdsVi9XZFpZT29aUHFUcUNiOUI5?=
 =?utf-8?B?Um5qbTdmamNkVHJPSEprRThGdGhqaHc2Skw5NU1teXZsS1FjamdaR1dvekx2?=
 =?utf-8?B?WnBGbFRtWnZTcEFpVlZKTUZoSERTTzZQMnhuVHgvUDFIbGNaNlRpZUxDYXlZ?=
 =?utf-8?B?QWNSeldqYnlSL3ZISk9wK3Ayc1QrSkEybFgyYXdTSnVwcDNPVTJzeFFGVms0?=
 =?utf-8?B?eDBpeUR1djNkVjgrS2ZMMWJhWDNGQUdtTFlQdEhyeFZHSWtFeGd1dTRKUFBR?=
 =?utf-8?B?czZRUjJoUGdHckxTWjJzT0pySUxubW81YVYzdVNoTFg5K01kN1I2QllGMjVW?=
 =?utf-8?B?cGNnWERLWUpaYTJKREVoOE1rQlBPdHRZUjZ2dEJ6dDN6MEtkanNEclh3anhl?=
 =?utf-8?B?SHhGenFkNHhFdGdIaDI3NDBwMFM5UW1acnJ3L2lJYUxBOHdIOFZqMzhzZFZW?=
 =?utf-8?B?aEdCNnVBZEgyV1J6VEJsck1IY3J4bTlqd2h4OWxGclFaV3ZyOE9LNzhXei80?=
 =?utf-8?B?bDVjZEgrcndUMDNGejBEVVhmTU5IOVQvSU9BdTRGUW1ENFdUakFUMVFYdjVu?=
 =?utf-8?B?WFpmdGh6YWRzYzQ2cS9CM2o0Q0g4SUZBOW52R2VkREJ0dndYb3RQcHhyOW1C?=
 =?utf-8?B?UUVrbUw5MDVoY2RiZDFlWjN3Z3RSbVhPTWxUdCtUbGxMVW85bEtBcGxydjVM?=
 =?utf-8?B?bnBiUnloWm1IcTVaYmZkVU5Vb054MmtPd09pUGZ5VlJUcG54NGtNSmx5Rld5?=
 =?utf-8?B?SXl6bTlsRWV1K1ZjYjB6NnVpQStjMXY5QmxTWjM1Qk03RzBnaXA0STVlL2FV?=
 =?utf-8?B?bVBDUDQvdk9qOEhPekIzT0JBQW9UTlZRd1B6TFhhK202cG1TSVBUWlVNNGdL?=
 =?utf-8?B?VGV2OEgyVEFocFJZVEI4dHlQNnR2aVpoek1xNVNTM2pxOStkdS9IaVRqdytr?=
 =?utf-8?B?RlA0dDVMV3FOMEx3ekJNai9JcThNNmhkeDQ1N1VJZVdZTmRjaVZzdzcvVFQ2?=
 =?utf-8?B?UEI1WXJodGh2cUZGYzFGVHQ0SUgzL3dpRllUenB5NEZTWDVDUjJQUEZxR1Ri?=
 =?utf-8?B?ekZTZldRMHQ2K2dGYjc4SWZIU3hjWDJLQzVFWGkyblVBZzVBMmlGLzlMMzhU?=
 =?utf-8?B?VmREeEtFV3ZLV21ZakwxS1cySlY4Mkt0bDdMTzBHVVNYNzJpVnZBdjFiSGJn?=
 =?utf-8?Q?hVTz+f5+uNpps?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czFIdFZFN0IrZVJWUnFPZWdZU1NXOHNTdjhtM2F6N0dkeE1oVTBLUm5iWFVs?=
 =?utf-8?B?V3NjRDVEVHBNT3F5Q0dXL1ZPcnllZk5tMFNjbitjNW9kNS9xS0F3TWpiVjRq?=
 =?utf-8?B?UFNuZ1RCd01ROXpuZFhaWUhUamJBdlE4S2ZxdERFOENCWmJ1SlpFOG5acVFP?=
 =?utf-8?B?SllpMVBhY2FuOHlkQ1Awd1M1SmpYT0ZWbTJIRE9wZUNmU29IajJhU3JkVWIr?=
 =?utf-8?B?ZDhDVDY0cjhvMDJMWUFEYmtaWVpBTmRpTG9tZmZCT2FRQmw1ZHdheG1iYmd3?=
 =?utf-8?B?cDJKRSsxbE1SNDdyVlRjOEMrbnFmMk5LNXREQU41cDgrQU0rZlp3dzJ2d1ln?=
 =?utf-8?B?TGFveE83MWF6SnQ1NUxTeVdDMnpNWm92UTZ4c2hPSituVDVkeHMvaWt1eUN6?=
 =?utf-8?B?WWRic3VHMFJ0TjFmRUFCT3hZUUlsTDhqR29BSDBNbTNXeXMwUDJvbG9CVERO?=
 =?utf-8?B?UDQwTVpCb2N5Q054SnNwODRkWkliS1pJbHZjdW84TGllSWMyTXJ0dHZpV0pV?=
 =?utf-8?B?YlRPSzVxK0hkZ2puYllnSHg0S1VaQ3R2RnR4My9GRGFYaENPWnFoM2hNNGI5?=
 =?utf-8?B?Z0xaVE1oNHJBZGZtSi80d1Y3YkVXWnh2S3c3K1dpSUFtTURpWitlc1pIaEdB?=
 =?utf-8?B?WkVpOSt5Y0hMSDBEYzcrQzZTTzdyRjFDUkYvZnVoTjlhZ1E5T2ZITjVsWDJz?=
 =?utf-8?B?ejB5SGxxSi9yeU4xaWZVcDBBNERScTljRWowZHZ0WEJIT3ZYZW43VncxN3pu?=
 =?utf-8?B?emx0bkRjZnRWY0grMWx0OFk5eDBBNlZYUzdFWSt1cmlLMlhrWEcrRkdYZ2lT?=
 =?utf-8?B?Zk10Y0RaQUR1L1V3Nmo4TVN6VUtEUXpSNUthQ2tDazBOZXVYcHhNUHVyWFNC?=
 =?utf-8?B?clVBdHdPZTRpSzdvQy81R25NRTZadkNCdnlCU0VoRzVoMFFnc2g0WXVUSDM3?=
 =?utf-8?B?cUZEdmU1TjFtd010dUZueGs4enRhUmc5c3FrT3JQLzBFQkxPYzdLNzErUStl?=
 =?utf-8?B?MnlGZ3ltUS9WYmplZ0taRkRnaG9WUUs4dEpidkdFZG5wZ2M1NW1Jdnd5ZUNS?=
 =?utf-8?B?QTl4ZVNEdGN6NW05T1FPMXhvR1lNZzF2RGM3L2tnRmFxelZ6c2t2TlpTRzBZ?=
 =?utf-8?B?YUZEVi81SVdOSi9TZTRMY2VSMUZzRFowOGI0aUNiL09tbVR3TWhqanlScGF1?=
 =?utf-8?B?T2RHRDJzRSt6T3ZaVDJwNW9mdzgvU1J4eVhvS1lxTklRa3F0K08yUEt5c1dI?=
 =?utf-8?B?ZXpkRUJKWGw0emlCY0daZlRqaWxqdmRHWHRYdDlNVys3NzB4a21mN3l5MUM0?=
 =?utf-8?B?Z2czdE1FdWtkUklwWkpHTVVmUHFDOWpDcjV0WkVKQ0VTUEw5ZzlKNU1pdFJq?=
 =?utf-8?B?UlNPWlYwSXNjM0JTL1owUDRDekw3bWJXbkpTTHd5VlF3Z2FMOWppczRIZS9q?=
 =?utf-8?B?ak9aWlY2QnJMNjBIemZubXRJNlZKUUk5NFpiNHRCbEFlSHEzNHJrc1F2OG5L?=
 =?utf-8?B?cXNaL2ZjNm85RTYvQUJHTHExenpHK0xFZm5VMGdqUXY5VkRhL2RPZEhYNkwz?=
 =?utf-8?B?RVlVRlptSG5PSGE3K21uNHlmdURpYUVWOERFYTFVeHVoWkw2aGJFb0VRMlUx?=
 =?utf-8?B?aTdwQmR5ZU5MVlFjNlVPVUN1QzJHWUNFejY5RzJTV2FpSjJXN0Q0SkZFWi91?=
 =?utf-8?B?ZmlXQmlvaE1jeHk0VmZpc1l6YlNUS0JEeUxVUC82akhxcmV4cEVxV1A3R2p2?=
 =?utf-8?B?SThDZkRTcnBCTVJkWEJKU0JNY2MxY0dXdFVpbUMzcXE4bkhHYUw2TzNEd05T?=
 =?utf-8?B?eEU3U1RDenZvb2hWTnBFbTRwUjZveVN6V3UrZGRNektZMEplYVc5MXR0a3Za?=
 =?utf-8?B?R0VmMnZKVzk5MzV6UXRWYWJnSjc1L1Bia2RkRnBiNENqQzB4L2crZEhlT1JD?=
 =?utf-8?B?MFF2ZkNkdWhxMGpLYUNOdkY0Z1RBQlVtRjZac0VsaENEdTVKWk1VT1dHVVpY?=
 =?utf-8?B?Z1ZXWlp5c3UzNzI5TzByc2oxbnp2WmR1bEdUdXdZUzdSNWUvWkFoM1BRbHBr?=
 =?utf-8?B?QkhwVTRXV3BUcGRkN2lRcUNZVVBiWHAyM09kZGRRblNLV0pTeUtvdWhVa1Vj?=
 =?utf-8?Q?JtYKXNvhv7FC+AJiFX/+4AvxK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed2b261-c72b-4442-6196-08dd3703883c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 14:30:46.8149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/pZlU3ljIluYzUfxeQIfsvvnzIXt+gqWlFPS7rQaqvsT06gx2xAeb3hvYhxloDMLynBc1kubyqV6okyBAnCSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9460

On 1/16/2025 21:11, zhenglifeng (A) wrote:
> On 2025/1/16 19:39, Russell Haley wrote:
> 
>> Hello,
>>
>> I noticed something here just as a user casually browsing the mailing list.
>>
>> On 1/13/25 6:21 AM, Lifeng Zheng wrote:
>>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>>> driver.
>>>
>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>> ---
>>>   .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>>>   drivers/cpufreq/cppc_cpufreq.c                | 109 ++++++++++++++++++
>>>   2 files changed, 163 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>> index 206079d3bd5b..3d87c3bb3fe2 100644
>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>> @@ -268,6 +268,60 @@ Description:	Discover CPUs in the same CPU frequency coordination domain
>>>   		This file is only present if the acpi-cpufreq or the cppc-cpufreq
>>>   		drivers are in use.
>>>   
>>
>> [...snip...]
>>
>>> +What:		/sys/devices/system/cpu/cpuX/cpufreq/energy_perf
>>> +Date:		October 2024
>>> +Contact:	linux-pm@vger.kernel.org
>>> +Description:	Energy performance preference
>>> +
>>> +		Read/write an 8-bit integer from/to this file. This file
>>> +		represents a range of values from 0 (performance preference) to
>>> +		0xFF (energy efficiency preference) that influences the rate of
>>> +		performance increase/decrease and the result of the hardware's
>>> +		energy efficiency and performance optimization policies.
>>> +
>>> +		Writing to this file only has meaning when Autonomous Selection is
>>> +		enabled.
>>> +
>>> +		This file only presents if the cppc-cpufreq driver is in use.
>>
>> In intel_pstate driver, there is file with near-identical semantics:
>>
>> /sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference
>>
>> It also accepts a few string arguments and converts them to integers.
>>
>> Perhaps the same name should be used, and the semantics made exactly
>> identical, and then it could be documented as present for either
>> cppc_cpufreq OR intel_pstate?
>>
>> I think would be more elegant if userspace tooling could Just Work with
>> either driver.
>>
>> One might object that the frequency selection behavior that results from
>> any particular value of the register itself might be different, but they
>> are *already* different between Intel's P and E-cores in the same CPU
>> package. (Ugh.)
> 
> Yes, I should use the same name. Thanks.
> 
> As for accepting string arguments and converting them to integers, I don't
> think it is necessary. It'll be a litte confused if someone writes a raw
> value and reads a string I think. I prefer to let users freely set this
> value.
> 
> In addition, there are many differences between the implementations of
> energy_performance_preference in intel_pstate and cppc_cpufreq (and
> amd-pstate...). It is really difficult to explain all this differences in
> this document. So I'll leave it to be documented as present for
> cppc_cpufreq only.

At least the interface to userspace I think we should do the best we can 
to be the same between all the drivers if possible.

For example; I've got a patch that I may bring up in a future kernel 
cycle that adds raw integer writes to amd-pstates 
energy_performance_profile to behave the same way intel-pstate does.

> 
>>
>> --
>> Thanks,
>> Russell
>>
>>
>>
> 


