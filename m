Return-Path: <linux-acpi+bounces-7898-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C4D961715
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 20:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21071F24BC5
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 18:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D151D2F40;
	Tue, 27 Aug 2024 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3DQWT0ok"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC11D27AC;
	Tue, 27 Aug 2024 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783815; cv=fail; b=I/HsZU9icsBCAIkuy0XNyWU8yf3hQbkVVwSkmX/XkM/n82Wjcs9+FS4fEbTddg9a0EKpCRLYwGK0K0FpDKJGmcJBkYiCwoMLiVpW7wOBVk6p52xaTH/wKPuNQXXBfI51eTQCRWtwKIb+ahrbg2KqDAvoT5BMyVsoHEaGqh9EJQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783815; c=relaxed/simple;
	bh=nmo0+ClngcLiQW3T+0/n+xiigJ7DDJAhIpFDwuwzFpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ly1gr8h7/jYN8/VVwalwaktA/DeM9t6fXxxU835tZkSKQHNwMFeuxxk07yiEuiSFSUygDf45NEh9nRtd2VMTls/ZoCLzz/zPYT14/Nb9OOSsEbsuZ3gPJCs+nWG4auBaAQ4AL8H5tE/S8pmRFqmW0DypaYk4CnM4rFDow5OG008=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3DQWT0ok; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDnI14elK+yrBcQOv6vqDbO6D6JsdH6k0ZLYC4rYQsOI65bybmgnaYX6x8jX1a6kJzPa4vq2lOtGK8xVxyl+/BS4J+Ttu1M3jQE2gzB4eHBXiHE9AP//00cW2UISfnzL3MHQHsw54cgHLC38UmpuzZDxUpcvL50dJ3GhCt788EgUhNbudlbuSDHs7Mi4AHH+rOms9wD3Asr6FFdhzr3qnX9hoRKT+gw0SLaOJ2bSwVdcvkHH5EpSfv7Xw7JohNesqWVrm0aoI5OqDVQYAMG2XGeTU6NxI/WG3u7rMOzz2RsQgS5UGExIQq2qqmnX42NESb3VkzHRCn6+mQiSFQFBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgxPQInzDleRZl1Q+ClhdOrLUOCUdfT7JHPg+OVSKmM=;
 b=LuJs+0V8yIVAvtSg1GEG0OYFFlwqQhBxgWVIgyNC2mD0wLjoDZPscfsiwRMaFcamQA+2RpcutvtfqPdkp9t2mywYfRq9C1W1leFuoeQC+RW2hX3mvkw01iNmiO+b5FUNpQjcs+XyeJzFcBCKi6vFyoXJcfuypbm45Gi3e8eiChHDMPyZkmFsKF54N0YD9cAA91X5bwklH7OjuovHPO0JS7RrzVaL36MeNiu30dWWWfvkVclFczPFz8PqvTIkIlgvA6i0vUCMionqk6ZQezyXj3haXODX+AV9X0fizNQBoDiQXlmhkm6r0B0Fhba84VMvoYbrM05KnpUVKUv8/q14pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgxPQInzDleRZl1Q+ClhdOrLUOCUdfT7JHPg+OVSKmM=;
 b=3DQWT0okVBNskI3ffQqgL2m92cYNmwkzlzYiaApPTyUkfVZQ7K7/7nO9Xz3aqYiEFJi7iql8HiqXEHbd5erxleoFkQbq6zYjKXIx8uQZ0kAOcKncnY4kJgWJwo56CZxZNAlIhR03LffDD8rnuXgKKRm4AXOJG8lk0dC0+gM1C9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 18:36:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 27 Aug 2024
 18:36:49 +0000
Message-ID: <2091c274-00b7-40ed-a27a-83850130df46@amd.com>
Date: Tue, 27 Aug 2024 13:36:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] cpufreq: amd-pstate: Merge
 amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-7-superm1@kernel.org>
 <Zs4EW7s3Z32UAFNI@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Zs4EW7s3Z32UAFNI@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:805:66::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: b307f896-7df5-42e6-a861-08dcc6c736a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDJXamQ2cHB1YzVsR3JzY3JhcUtBTTRxR3E4WHVjd2VBTXBWMlp2R011QUxn?=
 =?utf-8?B?T1N0ZDFsMGxuSHI4Z2h3ajR2bFhiTnBPaEMzVGhLWUw0RHMvTlZ5NTRHbWov?=
 =?utf-8?B?cXZEYXlUM0ZUVndmZWREQ3pBeHdhdDMwdUdNWENwakZOUE9reFlEbGVlaGZq?=
 =?utf-8?B?ZEFtU1NMNE9pRnV6R3JvVFAvOG01SzQ1bm9tZS9YYVg2bUduckZOTzVXZ2R4?=
 =?utf-8?B?TU5xSndUVXd2U1RnRDBLTU4xM2Q2TU00bEtaK1RRWEJWYkZwNDZacTNPb3Nk?=
 =?utf-8?B?cE9KdTdDV1Fka09JMFlKaGRuMVlCYnpBYkR5WTlqY2ZUbVBzTjVwa3VJVTJr?=
 =?utf-8?B?VHJWTG4zQzcvUDYvRHRaanN3TThCT2NyK0RmZC9aQlNCcys2K3dRYnUrN3Bl?=
 =?utf-8?B?U3pYWkZCS1FsOEM4SlA5VElQOXAwOTVSeCtUUXJySitkd1FZUXdVNmJIRG9K?=
 =?utf-8?B?Q3dpVWtDcHM1Q0E1ZWVETjNmWWdJMGNZMTM0QW5KM0xQeHExbXJiRk9uSmhU?=
 =?utf-8?B?S0tLVGxtTTYvdjIvOGh2VVFCTDY1OG96WHhCYVk3WTFyRnppTzZ2R0VYRUQy?=
 =?utf-8?B?bERsOHY5cTFVOW80MnlyZ2NWWm8yUUJoNmJsRHlNejFxdlg1Z1ZUYVpLRW1i?=
 =?utf-8?B?aDkzWUVFYkNRcmM2bVZCUWVtbmR4NGFyRHFGUGxyNDlvSk4rZ0lWYklDTHpp?=
 =?utf-8?B?YnZCaVd3L2Y1Mzczc1c4TVU3M1NoVTlRMWhBb29JM0lLdzBPSmdxNkM1YVIx?=
 =?utf-8?B?YjhLdFo3Rk5hRStmUlU5elpxbTVMVDJFR1pydlA5MElZYUo5SDJubW9nSFYw?=
 =?utf-8?B?QzJyczE3TlJEb0x2VTBrbEg3RWpPMEVqbmVHMGxIZmdzd2JXeWRzeFpPdEs0?=
 =?utf-8?B?R016NDBTY2JVb2ozWEE5d1poZFdhN0h6bnlZbk96UkI0VUZGS1BPN0J5d29k?=
 =?utf-8?B?cXROTDZickZPRU1PblRXVDdvYVdQWmxmUGJrckVQTExpRkt3YjEvaExsWnFz?=
 =?utf-8?B?QjB5UkRLMWFoN25hYVFLT2ladXcyamgvcTFtUmEwdUxNbnk2Vmh1a0NzRW1B?=
 =?utf-8?B?Ukd2OUpUM2RaYVVnQ2MvNE01aVNIVVZyc0FkY0FRQlpXK0FvUFhRenJUcjhV?=
 =?utf-8?B?eEV4STJnQWNaMUlBTTRMUDA1WHpIL0lVQlZha3hZY1V0ak1qaXhsYmJDandO?=
 =?utf-8?B?ZEtOcWpOcnRqSWl4T2d3VmQ3dkcyVUlSUkl6WllEdVJNL2RaTktoQUJpdk5P?=
 =?utf-8?B?MEl0RnpubTEvNzVNNHM4NmV2eXdCWmpwSjVkUEk1aDFHUkpUbklqbXBLd2NE?=
 =?utf-8?B?d2EzdE9hOVFIcUYvOXdJS21kR3dQVEZ6aEcyeGlzWnlRRDI1YXZUayt2Nk81?=
 =?utf-8?B?NDF3MUwxbVFHNWN6ODk1eGhOd0YvSHZsU25jeVZiNkdKQmxMS1NlNm1MS2Np?=
 =?utf-8?B?cFl6Q0dlbkorM1BERkk0RDRMMlB6am9ZQW1ZaVV6RGJuYk0yQlMvK0IxcnlJ?=
 =?utf-8?B?TWswWi85REkvRGhXZlVLckNPd0YzNlRZS1JSVUM2TjZ6cm03eEhrYWJjYVlV?=
 =?utf-8?B?OTNnbENDbkpXaHBFU2hsMEtCZ2x6VWV1b3VGd0NmSUpCT3FLZDhXRmtlNXRJ?=
 =?utf-8?B?NXBkekRPM0QzekpDQndJVTdlaVN2ci85WittTkZRNERpeWp4Zm0yS05nclVy?=
 =?utf-8?B?Um94RDVoWTZCMHRIRkQyWlJRM0ltMWhhVjA1V1dYQ2x6U2ZKZUo2TDNPNVkr?=
 =?utf-8?B?ZHRiUVVQVXdhZnJrSUpSbExUVmZueEVNNlVtUHM5blcrWnJKc1BtYVorRS9u?=
 =?utf-8?Q?0A7b5s4a6UVDDxrPN7qhti1JiJKfuCJsmfT/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmlUWHVLUTlHY3crNkJqS1E2d1duRm5rTHF4YnB1QUZkeWdqSFhpeUc4QkhS?=
 =?utf-8?B?d09LK2hNT1IxSzdWVVczb0hEWVFPTGQwbjVlcy9JNzR4c2wyOVVSUkNDa0sv?=
 =?utf-8?B?OWc5MjJrUzlRa29ieUZmcDV2WlhrNkhiR0dQYVBlNmZOOGkyeG9uZUkwaUpG?=
 =?utf-8?B?cE0wSWpFYUhmUGF0YnRnMEdzVVQxd2FhTFp6ejlxRUlTMUVRL1lzb1phMFMr?=
 =?utf-8?B?dDJ5cHd4cXhRM2w4TDR2MDkycTdSWTd1dnoyMGhDbTNabHQrcjVWQVpSSjBV?=
 =?utf-8?B?aDZwNWNxazQ5NzJCMHNjMFNFYmVIQXlJanMxODJNQ0k5emVqVWRZM1FTVWt1?=
 =?utf-8?B?MjM5U2pvc1E1REs4ZjdBQ2NRQStJMlRTRzhwa0NNWVdKYjgvN25tSFQ5TE9q?=
 =?utf-8?B?US9NL25HQ0lSdzJSUlF3RHEydXJGNEE0dG93K3hwVHdWa2lIOE5wdnkxcS9Y?=
 =?utf-8?B?cGVYbGpVUjRpMndoK0wvSnlGYVZlYVVzeG9ZazBQcHVadjZvYnBFTkFvRFRU?=
 =?utf-8?B?a2Vsb256dVB0bnZwN1diNy9xU0pURk1iRDZFMGQzNk9tOE4zYnlRZUVZblVT?=
 =?utf-8?B?c0NFa2JSY2NpYk4zbnBlTUtpb01aRHNYaVhZRFRyL0RlRjhQNUt4UXF1NWU0?=
 =?utf-8?B?UEIvdEVxbktlZ0tGV1UrNDBCdldFR0JmR2tzQ2liWTM5QVY4UlQ1WEFja1ZZ?=
 =?utf-8?B?N1V4bERNWUFxWWtweWJvSG81NTI1L3l6SDJSWGZwOTZ4RUJCbDF0SUxPRlJJ?=
 =?utf-8?B?ekYxS2JDZjh3dWFER3JpOHlsQm1ISmZneHkya0RMSm1lK21xZllxMjVLTVor?=
 =?utf-8?B?M3RLMHg5eEhPQUV0bTFJaTlSdkpZQldCYWh6YzdvZnFWZFdQb0RKaEttMHpD?=
 =?utf-8?B?eUMzNVlzVHhNa0w4WHZVeWRURFFZR0tIRmhkaXRVN04vSEhMNzR4MTRkTWMr?=
 =?utf-8?B?N3NKc0pYQ0NYbGRIODZHcWZtcjhlQ1ZQNnR5TDM4Nkl6V0JLQ1pmMlJmdEU2?=
 =?utf-8?B?NDBYR3RGSThNQldzZ3ZMRmNIR1ZaWDFNUEhpTXI0K0J6alVMQkwvN3ZqQ3Bz?=
 =?utf-8?B?Z2liOExDR3hJTUxqZmFoek81dllXWCtjc0FLMlhvRnJ3MFZVVFlHbXRPUy80?=
 =?utf-8?B?TUViOXUvUW1rbXJWcUdWaGhkK0xBcXhaUWRxRi9STkJvM1c0Z291SU5RbmVD?=
 =?utf-8?B?aXNTcEJvWVM0V3l5ZTBiRGJZS0RoRU4vb21veXRqVlMvaHNKTW1JSVQ4TmEx?=
 =?utf-8?B?ZkszWmV0ZHhpZjNRVkx4Mlh0NjM3bDNaOG44TXRpd0wvM0drYWpQcVFFbnNN?=
 =?utf-8?B?Q3lYVURINWJQbDkwZkF4OGJKVWo1TXZVVktJZ3FQY0RxVlp4UjhtTXBIWEoy?=
 =?utf-8?B?OFIwM3F4WDNqZ3d3V0FUSmlEMXNiVFJ4M1V0TW9KeW9jdExFSGhPNXV1ckJu?=
 =?utf-8?B?bEJtdXNsVHNLYXVNMVhDUVR6UytrNnJsL2dsVCtPczRCcDAyWmlPMjlxSnFl?=
 =?utf-8?B?RjdKS3cyMG9Lam82ckxCWkp1a2p2ZkVYalJITStaQ0lHY3dkNFoyQVlaMTg3?=
 =?utf-8?B?b3dHTE9BYnhYNFJvQ1ROTFJBd3RId1RrWE8yNEU1alh0ZmMrK1NXY0ZSVFU0?=
 =?utf-8?B?NENOOUcrR00vNStSU2J6T3pWZmt0QXVWN2gvU2szbGM0K0JuT3AvZVFhb3Fi?=
 =?utf-8?B?dXZUV2c4SXA5OXFDZVhRR1lOTGVMRmxrRDlSNDFrTGd2MTZQV0E0L1kyVC83?=
 =?utf-8?B?Yk5wcjQvd2IvNjduZXNuak9TWjBDSkZLclNuNDRNamc5SlUxQ01LNjZmYjhZ?=
 =?utf-8?B?dGthejdLNHdCZFZRNmtQTE1sdmkybzFGYzE4a09oK1pkbGVmbU1CaFJHaTMx?=
 =?utf-8?B?N3V6b3NIQUlVcTlWazl4eEFJTjNOdUxUdkJpbERwVUlObHBvQkZHRXp0Ulg3?=
 =?utf-8?B?RHZZZ1B0K1NhOFVMRTRwYUY1ZkpiSXVaVGdRSzk2elFxRkk3REl6a0pNUU1p?=
 =?utf-8?B?NlFoTWsydkZ0UE16b1dkWWYwTW1XOENnZGdSSTJqdHU2SUtDRXh0eEdCMXhB?=
 =?utf-8?B?TFhKaGo4N0w1K0ZQR3cwSW1EaE5pMkVrTm4veDI1eTBGVk82OFFVUzFCUnZN?=
 =?utf-8?Q?e/Qe1hlE/oRUOcJweq0dGiWUi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b307f896-7df5-42e6-a861-08dcc6c736a6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 18:36:49.8947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxnwu1DJdS+wQQcdso2GLZJM01M9oo/oDvvSW01W+E8L+XRyd4himldpuuQICpySALBIcm6piDZidTxEDrHz1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884

On 8/27/2024 11:52, Gautham R. Shenoy wrote:
> Hello Mario,
> 
> 
> On Mon, Aug 26, 2024 at 04:13:56PM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> The special case in amd_pstate_highest_perf_set() is the value used
>> for calculating the boost numerator.  Merge this into
>> amd_get_boost_ratio_numerator() and then use that to calculate boost
>> ratio.
>>
>> This allows dropping more special casing of the highest perf value.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/kernel/acpi/cppc.c  | 16 ++++++++++++
>>   drivers/cpufreq/amd-pstate.c | 49 +++++++-----------------------------
>>   2 files changed, 25 insertions(+), 40 deletions(-)
>>
>> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
>> index 729b35e84f5eb..44b13a4e28740 100644
>> --- a/arch/x86/kernel/acpi/cppc.c
>> +++ b/arch/x86/kernel/acpi/cppc.c
>> @@ -9,6 +9,7 @@
>>   #include <asm/processor.h>
>>   #include <asm/topology.h>
>>   
>> +#define CPPC_HIGHEST_PERF_PERFORMANCE	196
>>   #define CPPC_HIGHEST_PERF_PREFCORE	166
>>   
>>   enum amd_pref_core {
>> @@ -244,6 +245,21 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>>   		*numerator = boost_numerator;
>>   		return 0;
>>   	}
>> +
>> +	/*
>> +	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
>> +	 * the highest performance level is set to 196.
>> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
>> +	 */
>> +	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
>> +		switch (boot_cpu_data.x86_model) {
>> +		case 0x70 ... 0x7f:
>> +			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
>> +			return 0;
>> +		default:
>> +			break;
>> +		}
>> +	}
>>   	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
>>   
>>   	return 0;
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index ec32c830abc1d..75568d0f84623 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -52,8 +52,6 @@
>>   #define AMD_PSTATE_TRANSITION_LATENCY	20000
>>   #define AMD_PSTATE_TRANSITION_DELAY	1000
>>   #define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY 600
>> -#define CPPC_HIGHEST_PERF_PERFORMANCE	196
>> -#define CPPC_HIGHEST_PERF_DEFAULT	166
>>   
>>   #define AMD_CPPC_EPP_PERFORMANCE		0x00
>>   #define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
>> @@ -372,43 +370,17 @@ static inline int amd_pstate_enable(bool enable)
>>   	return static_call(amd_pstate_enable)(enable);
>>   }
>>   
>> -static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
>> -{
>> -	struct cpuinfo_x86 *c = &cpu_data(0);
>> -
>> -	/*
>> -	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
>> -	 * the highest performance level is set to 196.
>> -	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
>> -	 */
>> -	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
>> -		return CPPC_HIGHEST_PERF_PERFORMANCE;
>> -
>> -	return CPPC_HIGHEST_PERF_DEFAULT;
>> -}
>> -
>>   static int pstate_init_perf(struct amd_cpudata *cpudata)
>>   {
>>   	u64 cap1;
>> -	u32 highest_perf;
>>   
>>   	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>>   				     &cap1);
>>   	if (ret)
>>   		return ret;
>>   
>> -	/* For platforms that do not support the preferred core feature, the
>> -	 * highest_pef may be configured with 166 or 255, to avoid max frequency
>> -	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
>> -	 * the default max perf.
>> -	 */
>> -	if (cpudata->hw_prefcore)
>> -		highest_perf = amd_pstate_highest_perf_set(cpudata);
>> -	else
>> -		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
>> -
>> -	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>> -	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
>> +	WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
>> +	WRITE_ONCE(cpudata->max_limit_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> 
> 
> So henceforth, cpudata->highest_perf is expected to cache the value of
> CPPC.highest_perf and not the boost_ratio_numerator. There are couple
> of user-visible changes due to this.
> 
> 
> 1.  On platforms where preferred-core is supported, previously the
>      sysfs file
>      /sys/devices/system/cpu/cpuX/cpufreq/amd_pstate_highest_perf would
>      report the boost_ratio_numerator. Henceforth it will report
>      CPPC.highest_perf.
> 
>      I hope there are no userspace tools that compute the boost_ratio
>      using the syfs amd_pstate_highest_perf/amd_pstate_nominal_perf.
> 
> 2. The amd_pstate_prefcore_ranking and amd_pstate_highest_perf will
>     show the same values on all platforms, and henceforth are
>     redundant.
> 

Good observations here.  I'm not aware of any tools trying to replicate 
this calculation.
With the redundancy I would actually argue we should just drop the sysfs 
file 'amd_pstate_prefcore_ranking'.

Thoughts?

> 
> Shouldn't this be documented?

I noticed amd_pstate_prefcore_ranking wasn't properly documented in 
amd-pstate.rst in the first place.  If the decision is not to drop the 
sysfs file, then I'll add a section for it.

> 
> The rest of the patch looks good to me.
> 
> 
> 
> --
> Thanks and Regards
> gautham.
> 


