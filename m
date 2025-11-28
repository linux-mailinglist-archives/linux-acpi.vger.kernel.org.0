Return-Path: <linux-acpi+bounces-19351-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FCBC9237D
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 15:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53D6C3528D9
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E86930F80B;
	Fri, 28 Nov 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bsx8XyH0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37D3043A9;
	Fri, 28 Nov 2025 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338492; cv=fail; b=fLYtPJMYayK3x3PdeR+gw+kvXWYWfvu2mO3p71D3amQyu5hSh4g6LKdCdjrakjHsownA6wg39G83wP0E/xS1sB5kBy15EnsfAmZe3EbNYeHhwksaRhWvQJ1OxdRkKRxrrQusKcVSElitkpBAyd0G5wEs5sAowRHgiBEwOicGfNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338492; c=relaxed/simple;
	bh=RJWvTME2Nat6NhS2+O1MUO8WYuBJaVyfeMPYt+kwLy0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lkUNHozjR7or/IhSVOQ43Ul/ZPFqACuQDLBM7VHbqtinNK3Pw2mj1hGDLEnudn7NfYuPYcvHGDfPCxOss2yG5+ffKRG1IUCaEw7Esds0gol1iZs1KDov3DInYOKi1LI7WekiK1JYzhgAjwjcMOcUGt25kPSvwGJ8NaKQVBWC03g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bsx8XyH0; arc=fail smtp.client-ip=52.101.56.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcKQdHxK8hnydv0+KmAE76XJfd0qhX1tm0umzkYiQHw4cesEvrhtFr0q/f7qPcIHyt9gqP//POys4AIRdlh0s3crE22eK7Bo7DxmnrdkS/Ce4VEB3FZx4g5Tyc88Gqvfm5noM5mXLJqzttKAwZGBXoQY4mbnE4m1q8QdO2L7yFhXqwjWmmUToFUKyKbmpR2H4pDsB2zKkciUWrXdplCCRg2067rkyaYunnaOB+AVPBr3vkfQBpDUyHEp92MatRESG67jcNIlgloPzyTyqpGtviVQJYH8iP40MXibFxOhqqSuCP8LFzTpk4AbGCxsc2BJaeyZnMhWr/Uzh7RtoRY9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YS++4aZ/UF+IKkG66EM2TYKAjPX7MbU3QUpNqSKibZg=;
 b=eH7hPBHk55pWnt2oZ5ZSZ1hpcwYa34cCc6oHojDh0Zj3d2pGidYbqRacaf65+n65iJgy92M1iXLtpkeIiHUwI3ArlNg+APRe4Wb3OGkkIZL1EykT02D9qGpoLWmipMo1e83MGczjFqZU7phsOKSq/uMPjrgpNt9VuDwYk98GxQ9lBg9MHrnDzpv7kYs5/3+DGjZzGBdbziUGcvhwjDRr7c98XhTfv1Z7abK22nHyLfWNC+mQfuVuxpEAwFSms/NpxqfWDfd5nE9zgZYmPDPp150GvXTSyp3K75JtgJCsz7DukF5zWep+y7iA9gv17lW9E/yJKML/Q8RNhni7fKtoRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS++4aZ/UF+IKkG66EM2TYKAjPX7MbU3QUpNqSKibZg=;
 b=Bsx8XyH0Z3i+L/H4ci7KwRIshPXxuhVrzeM+uL87az9nnpP4oMO78zOVbTbv++Ottk8y9PEhzxHSL3HuxGLyYsi3cIkTiNGLH36OiqRPDZudCqcndiE2XduKFH113QLfQlfvMzU1F/90Oehse2u72yXEhniTYubOVqOx8EZh+HJuNrnjTJpNIwiF4MUfqbiw3/Iyyd1syjbBz/5hT4oFkaiMLTlmQDVlAPY8YWqt6nI/3ZE0fdyqldFt+MI4bNYqTe2arV0qJnLeTt5gmBHDCgR3zRGFmTWUxGFyxIW4ovdI4qoHTiX8GuCmeU0W4ef0sraZ7C1diufly7KXd6jAyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 28 Nov
 2025 14:01:26 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 14:01:26 +0000
Message-ID: <ccd45c1b-2f69-4725-918f-18063f00a864@nvidia.com>
Date: Fri, 28 Nov 2025 19:31:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] ACPI: CPPC: Add cppc_get_perf() API to read
 performance controls
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 mario.limonciello@amd.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 rdunlap@infradead.org, zhenglifeng1@huawei.com, lenb@kernel.org,
 robert.moore@intel.com, rafael@kernel.org, viresh.kumar@linaro.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 bbasu@nvidia.com, corbet@lwn.net, sumitg@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-3-sumitg@nvidia.com>
 <011bebf3-ebd4-4245-88ce-5e826faae66f@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <011bebf3-ebd4-4245-88ce-5e826faae66f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::24) To DM4PR12MB5184.namprd12.prod.outlook.com
 (2603:10b6:5:397::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: c347d378-8054-40d4-d427-08de2e869e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3JGQ2psSHNmSUczckNYdGc4MEY0OUhVaWUyalJrcVVONTBvNHZSanord3hj?=
 =?utf-8?B?VmRVZEt5THVZWXJiV00xREk1NkpRVkROd25JWk4yWkk1L1Yyeko0dnZaSWho?=
 =?utf-8?B?L3c0QmRZUEVtVEQ4a2lhYUluWHQ3dm82VFpiaU5OYXFKUy8vbXNud3dsUWp6?=
 =?utf-8?B?QUhQc2JiOEg0WVhlQ0dwTjliakt4UDdnbzFDT3ErUlFJUklia0Z3T0NJVnlm?=
 =?utf-8?B?U09pZ3V1ME9XU25vRndSQ0s0L1cxSlh2dDltTGRiT2tHdjhBbXVYQXp3UW5v?=
 =?utf-8?B?WlljNUFLUHRON0NkT1dtajNGTzVuZmthTVIyWlZWS3FmRXpYY2tEQm56ZFdv?=
 =?utf-8?B?c3ZCZC9HS3JoN1hadlhTRjZSbzV2bkhldWpqQWdBeFFmRmdCQllhOU9BWDhi?=
 =?utf-8?B?NUZra29CdXVZS0o5aDdjaGloWDgyV2FxTWg5ZFNHNWxlb2lETjNDSkhPOU9m?=
 =?utf-8?B?cTVSUnh5T01XK2hqWktnVXV1Q0NrNFV4WlVLSVhxdWY1RmhaVVdRcXdpNFJt?=
 =?utf-8?B?cGRsMXZDTUhibC8wVld0NHkwRVplWHRKSkQrYisrYytpdmdtUmlKYlI3TVlj?=
 =?utf-8?B?N2pRc05uelZZVDZFY2JXdGUyMS9HWU5XOW4rdW9VNWRZK1lnMWZPOVpDNmdk?=
 =?utf-8?B?RXZQNTM2ZE9Bb3RtTXZqYjc2YUJxZFVxUDV4TGRQd3NWenFHVFdydGJ0dnpB?=
 =?utf-8?B?eklGU25GcldUdEswUnpGK29vbjl4bUdYMWdKRjdhOElFbUIwRGdIajJKa1Nk?=
 =?utf-8?B?bHhXZVQyQUhFWXJqMXhCU3hiZWtSUzZpVDhMY0dzT1pGUllmVGpqTTV4eE9l?=
 =?utf-8?B?cG9ZNjFUNU1EMzlNSGpWZndNWFVxMXVyU2RCMVJNaEprVk4wQjhoN2lBODNH?=
 =?utf-8?B?UVVJbmhZRUxLbDJaYURaZGRpeGs1Rk1UN2tPRE5Xa1ZjWTNCZkpoNW12eUxt?=
 =?utf-8?B?VU1mTG55OXZSNEZIN2J0a1BtYTU5U01mTDNzSFc2dkFHVXk4U2lSbENvbGk4?=
 =?utf-8?B?WUNucXgrakJ6anc5ZWhBNjVGREgwUEhsZ244YmZCWndXNURCVkRkc3B0ejhH?=
 =?utf-8?B?WUhPa2tVT3RBNnI0YnIwQ3FGTHFPREg1bnc4QUtIaVRkaHk3UGQzd2VmT2N2?=
 =?utf-8?B?NUZ5Mm56U2NqZW5YRnlJblRPVVpaN0RWUmJ6ZmE1aVJUYU02SDNZZXZENWdy?=
 =?utf-8?B?ZFZOTWtpYi81dWZXZCtXTTUzbkxybjh2dlBmODFvUFFEMExoZjU5bGFiLzht?=
 =?utf-8?B?NytGS3dTaUtXL0R5alVSdi8zaUpSS2FWZE45WFdTdzFUVDNOd2ZpV1VZZk16?=
 =?utf-8?B?dDZ5c3lCYVMzM2pJTHJIcFBqWGxwYlVneWwzYVpucVlXMTJGUlFaZTVmM21K?=
 =?utf-8?B?bXE2Z0FBaWN4MDcvQndFZnpiRGF3emM3ZzNMMWQ1NWRBR3BrZzczWVBmdFoz?=
 =?utf-8?B?SDU4VTF0RE51Q3ZxSU5aZWxEcENuQTg1QjN2dndJb1VKM0pHNVhLalVrWWs4?=
 =?utf-8?B?MXdNSkZmSnpOZ0JpbEp3MEwxMDIvSVBqZUtiWmkrQTVicjdoMjhEalVkblpa?=
 =?utf-8?B?ZGVQU3Y0TFV2NFF3M21EeGtwVUJSWnBXSUluRHB4M1Y5YUJ2KzZSaFBPbVMw?=
 =?utf-8?B?UlVBU1ErN1ZSZXVHaDVsdTdXNi83K205WTJGS1M3QmMwSVF4MFRhYUtSSEVP?=
 =?utf-8?B?ZVk3aVA1TGtNRldlZEdOUUtvaEJFRUFDOWdMd0R2RS9sSDZ1UitwWms1T0xX?=
 =?utf-8?B?bW5pSDFNdGV5aHFGRUQ2RWsxOG1SR1p4VTFKSk9iNzZYVUZQNWJ4VmFxZGVi?=
 =?utf-8?B?WTNuSit2eEtjKzlMcXpPTVdQTUtpczVsa216dkNiRTNlL2h1SmJFWHJBNUtC?=
 =?utf-8?B?cmNJbHBId2RxMjJoTHlhcG1qOU83MGZVQVpVOFRYWkU4OTNuNEJrdmtmOWw2?=
 =?utf-8?Q?HwjKTAjND3pguvmpzIv0qnjtZBXTdfmD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGJjL2dKWTJoVUhmN3gzazFwdFhmcnlvcXhvaU9UTHJuSW1EaGh0OXl6eUNI?=
 =?utf-8?B?MTlMVnJJRDMvYTUvS3lzV21nSjVUZExGVlRLSFJWNi9OQ2VURFdMQjY3RVMw?=
 =?utf-8?B?M2gyK3FwSU50TTlTUmlOM29hQy9HdWtsOFhhNWJERUpxbDJ2ekJ4ZGg4dnh2?=
 =?utf-8?B?dzdVWHBHeENJYUtmWHZjU1JSSkwvSDFRYW1oVWFoOVpUZVpSWGlBNWdvNkxv?=
 =?utf-8?B?MDBmZnFjRTNQRG5tUGh1cjZmVGpKL2ZFU1JqTUlLdmZ5VW9vWjMzNjBLeEFE?=
 =?utf-8?B?aDJSZ3ordTIySXczdzA3N3o4aDRTZ2t1bzZoTnc3eUNqL3RJWC9ld1JRRTFT?=
 =?utf-8?B?My96Y0w2TVJaSzlYNGt4QzVuaTVJV3RRTTlXMU81ZmkwckVTTVkrb1U3TUw4?=
 =?utf-8?B?dnJ2ak5GVDE0V05WODBxTFMzOFlLRGJOaXBLelRRQ1JEeUN5MERLZ2Rzak12?=
 =?utf-8?B?RmlYSk9wRHlGSWs0VGxmODZWd2hoaGpvelJoTlNQY2RyL3ZMQitwVCtWWVFH?=
 =?utf-8?B?Wjk5OXpCQllaOVhZMmhZL3dYUzc3eHVzb3RWN0FkRFhVblc0ZnMxMzRHTWhE?=
 =?utf-8?B?Ukc2WkVEUS9iSlNkWEhsZ3JXT3djdGhYb3RuenBkd1ZZTFdwNnlXTmVNQkdj?=
 =?utf-8?B?MDl6bTVZSENzaENwUFlEVUM2QXVGUjV0UnE3NFJ6OTNqYW9Sdjc0aWYzbUo3?=
 =?utf-8?B?bThWMXZ6eStUcVdHbm5XZGdPNDMyRXZsSFEvYWJFU0ZzK3dkL1NGWVNKL3Vr?=
 =?utf-8?B?clcySEhyN0w5ZWdCQXVVS1hjZ2VIRUZYeDduZDJoVElpQk9EbCtqZ2I1UnQ2?=
 =?utf-8?B?ZTAzRUJHVTBOQ0hqNktLSlJ2NnFkTEtNTCtjTjF3RXpCU3pEcEZkU3E3MmxQ?=
 =?utf-8?B?WVpHSnJpdEg5KzA4YVhMZkxycFVQWkx6cDNLS1huclBmUG5YZGtKdDAyNFcw?=
 =?utf-8?B?NEo1dHZFWE5DUk1UVytXcE1yUWNLVldPUjBpdEt2U2NlQ1pHVW5hclcvT0gv?=
 =?utf-8?B?akY5YWczZ3N0alg5Z3lrSGU1Y3ZmQlVrYW0wMDcrTE81ejdJcTAzd2VVc1BL?=
 =?utf-8?B?eFJMR1dLREUxdmxIeWtuN2Z0ZjU5cHIwNHpLdy81UUpmeTFpV24zMHYwOFEr?=
 =?utf-8?B?bmdUQkIvNjdEcSthRkxqeWtvdlJJcS9TcndLVC9PSTZBa2FMSW1kYWU4V1h0?=
 =?utf-8?B?NVBXQ1g2NysvNnVZSUNBaWsxd1FTV1lkc3B4MVBrRXBINGgrUW1CWlZUUi9a?=
 =?utf-8?B?ZWI1R3NQT2ZEN015TVVKcCtJQ1VkN2VZZDhEZkNUMFdwR0t0RE83eEhkVis5?=
 =?utf-8?B?L2NrUWVTbTZPVTBDQVc2SkVDWHNlOEZOOG9qaGlkemZ3Wm5sZzdoMTNVdjVV?=
 =?utf-8?B?b0Rwamlpa3lOeHRGcGtCS0crRzhZR21MSThXVEpvbSt5aWdUUm5uWUoxaExR?=
 =?utf-8?B?UkhQamR2QnpETWxRRnFmbkhESWt3cU8ySE95RGNvbUx6NDV3UXdrbUtuNkRE?=
 =?utf-8?B?TXZQMGNUdlNTSUhLNG1ucHFFSGR6RVRGZ2hNWFlVVktZZmQyMGJ4TjBscit1?=
 =?utf-8?B?ajJQM25xb2hlY2tXeE83bXlBNzNBNVNydUdZRjJSOVJmMTNEU3Y1V1VOTnJM?=
 =?utf-8?B?UTR5VWJFRkt1K2lqdFM4SnU1TjV0aEtXNUtyS2hIcEUvWHdCWTFTcm5HbjY1?=
 =?utf-8?B?NUhTdVFVOHA4VktpQ2ZHTlJ0ZFdpQ2V5NXRNQUxtNXJVempKZEtrb1ZTWTZJ?=
 =?utf-8?B?UFdWa1I0cHF5SzZ5S00zSGZ3Y2dkUks5Ni9QNnkrbzJERHlyN3FrUUtqWUFH?=
 =?utf-8?B?NWhjNzF4MWZFeGNZdDB4eUJmK0ZHcjZabGV4QitwK3hOeTBoVVlETitZN3lx?=
 =?utf-8?B?WExRMUhDcnVMZTF6eFJ0Nzl4YTc5WE5kRVIxci9mSGp6UzFieTYrUUhlcnQ0?=
 =?utf-8?B?WXkvSFJjYmpiampDMzR5VFcxYlNXcHJlNDFaRHJLUkNjbEI1aVM2NWdUNFpU?=
 =?utf-8?B?OEVQUHNBaVRPSWtpK1ZMd3JHRVNFUVFiSTV2ejIzYkRoQ01EUHl3NUxEYnJN?=
 =?utf-8?B?SHZLVGZMRG9vMHVWN3BCWHYwbzd3OUdOY3JlSXFqTFZNS2JLZEFGOG8wMmlB?=
 =?utf-8?Q?i6Bub+utiJA7Rx/CUfxy9BJI3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c347d378-8054-40d4-d427-08de2e869e68
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5184.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 14:01:26.4510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxdQm+YlcDn1trVziF9jBt4JQV48RdCc9/ZSp+tdTfY/npZQSo9q0Vlkgww4rD0Vr4nbOoa6zpqWJKkRridEBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710

Hi Pierre,


On 27/11/25 20:23, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Sumit,
>
> Sorry for the late review.
> I think it would be nice to split the patchset in 2 as handling the
> auto_sel and
> min/max_perf values in the cppc_cpufreq driver might lead to more
> discussion.
> I.e. the ACPI: CPPC: XXX patches should be straightforward to upstream.
> This is just a personal opinion, feel free to ignore it.
>

I think its better to keep the changes in one patchset for better context.
I agree that the 'ACPI: CPPC: XX' patches can be applied first if ACK'ed.
Will update the cover letter in v5 to request for taking those patches
first if no new issues and send v6 with changes on the rest of patches
if any new comments on them.


>
> On 11/5/25 12:38, Sumit Gupta wrote:
>> Add cppc_get_perf() function to read values of performance control
>> registers including desired_perf, min_perf, max_perf, and energy_perf.
>>
>> This provides a read interface to complement the existing 
>> cppc_set_perf()
>> write interface for performance control registers.
>>
>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 73 ++++++++++++++++++++++++++++++++++++++++
>>   include/acpi/cppc_acpi.h |  5 +++
>>   2 files changed, 78 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index ab4651205e8a..05672c30187c 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1731,6 +1731,79 @@ int cppc_set_enable(int cpu, bool enable)
>>       return cppc_set_reg_val(cpu, ENABLE, enable);
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_enable);
>> +/**
>> + * cppc_get_perf - Get a CPU's performance controls.
>> + * @cpu: CPU for which to get performance controls.
>> + * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
>> + *
>> + * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
>> + */
>> +int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>> +{
>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +     struct cpc_register_resource *desired_perf_reg, *min_perf_reg, 
>> *max_perf_reg,
>> +                                  *energy_perf_reg;
>> +     u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0;
>> +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>> +     struct cppc_pcc_data *pcc_ss_data = NULL;
>> +     int ret = 0, regs_in_pcc = 0;
>> +
>> +     if (!cpc_desc) {
>> +             pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> +             return -ENODEV;
>> +     }
>> +
>> +     if (!perf_ctrls) {
>> +             pr_debug("Invalid perf_ctrls pointer\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>> +     min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
>> +     max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
>> +     energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>> +
>> +     /* Are any of the regs PCC ?*/
>> +     if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
>> +         CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg)) {
>> +             if (pcc_ss_id < 0) {
>> +                     pr_debug("Invalid pcc_ss_id forCPU:%d\n", cpu);
>> +                     return -ENODEV;
>> +             }
>> +             pcc_ss_data = pcc_data[pcc_ss_id];
>> +             regs_in_pcc = 1;
>> +             down_write(&pcc_ss_data->pcc_lock);
>> +             /* Ring doorbell once to update PCC subspace */
>> +             if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
>> +                     pr_debug("Failed to send PCC command for 
>> CPU:%d, ret:%d\n", cpu, ret);
>> +                     ret = -EIO;
>> +                     goto out_err;
>> +             }
>> +     }
>> +
>> +     /* Read optional elements if present */
>> +     if (CPC_SUPPORTED(max_perf_reg))
>> +             cpc_read(cpu, max_perf_reg, &max);
>> +     perf_ctrls->max_perf = max;
>> +
>> +     if (CPC_SUPPORTED(min_perf_reg))
>> +             cpc_read(cpu, min_perf_reg, &min);
>> +     perf_ctrls->min_perf = min;
>> +
>
> NIT: I think the 'desired_perf_reg' register is mandatory, so the check
> could be removed.
>
>

The register is optional when Autonomous mode is enabled.
As per CPPC spec:
"This register is optional when OSPM indicates support for CPPC2 in the
platform-wide _OSC capabilities and the Autonomous Selection Enable
register is Integer 1"

Thank you,
Sumit Gupta


>> +     if (CPC_SUPPORTED(desired_perf_reg))
>> +             cpc_read(cpu, desired_perf_reg, &desired_perf);
>> +     perf_ctrls->desired_perf = desired_perf;
>> +
>> +     if (CPC_SUPPORTED(energy_perf_reg))
>> +             cpc_read(cpu, energy_perf_reg, &energy_perf);
>> +     perf_ctrls->energy_perf = energy_perf;
>> +
>> +out_err:
>> +     if (regs_in_pcc)
>> +             up_write(&pcc_ss_data->pcc_lock);
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_perf);

....


