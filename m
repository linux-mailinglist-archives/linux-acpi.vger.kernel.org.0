Return-Path: <linux-acpi+bounces-7756-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66319594C0
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 08:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B695283A3E
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 06:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EAA16DC20;
	Wed, 21 Aug 2024 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FHEqqs9r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6608479CD;
	Wed, 21 Aug 2024 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222202; cv=fail; b=BLQ2XNFRguaFxIxSeTtmB2FKOkV30DE/2nPncKvjM9q72MsFgAHyXiu5sXLLCjANrtSuDRFnuzLxYnlEINHFsUiIYFj/sgJ1l/kCcUz1kuZQEKtyjzHqLGrD0+N+dCkfnEAkx0VEWGEYda6/vdISK9CndrB10Twkk0LQU9Xzb1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222202; c=relaxed/simple;
	bh=3p8Sl3SmJrbfX8Nl9xekhm8FRPIgv/7Q8mg1povfyGY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MuoHQ46DOAO3CaSnLfLbQwMcfDKAekja0Q6m7Zhh/dDTQ6yN2vw2B/+UgPXXTCvsTwHBtWWo+R+QyBcQvbhzpYlsF4U/QNq5+hAui3SLBvcuahpCg9IdHnPG8UjWGiW+/t3bEvWdRmLfCBJDE0Er81ls4jBoIrzdeFlnEEjEpCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FHEqqs9r; arc=fail smtp.client-ip=40.107.100.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nnx0wnFBhtikcDiAANwNtVi4OxLuZWyqv+6tHRrUqWPtEs2pAoYbe7aXA5b8UxyJMs8/7uOch1pv4I8jPa/+OE/Wafz0sOIkn4Th0R4EY+5YdZ5orcVoHxEiOTgolhyNhNDhWsxS34FSEGtw53AlQ1U8LIPbjnd1MzhcUSWUj8e5KRJrHblCe3r/s8/mKAoCjnzChzBURUlEz15E9hvFIe5Eb1vaNNH8Gxwf7X+pF/kwo+ji8zTB2sEEPDvr4Be9Io3iV/NeusmL/ND4YKqHFIc9F5dZbKKNYlF/aDNGmQz/4P1epU0CjFWuqZ4Uw6kido0Ry2InH0Hb5ivCkRHvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p8Sl3SmJrbfX8Nl9xekhm8FRPIgv/7Q8mg1povfyGY=;
 b=IClqBZaY29YtVohuCCvIbhQ193YcDWnQPZwqNd5AtaKd30IOnCH0tHy37n1wzOekBQQ5a8zsgG4BEA30QlcGVwjYBmQAwXMwI1iKf63qJGHuQGpvZgi3QBTxPVbo2i9MTEXasmP4cShT1n5rEBigCb3yHGnAiT/FDc6oqZF42/4EyGKyMf6SIxxCec62nz9z4UGW0ZEoYu17OY2rmxMQXnF13oP/KMOgfolnZjcT2+5+ybYald40F+48G/bBa3UhK/3axxblxQtRishZvrRJGo03Q6xuTeSZt+1NREm4NBiMCJwhrDWaDCy8gGyJVumaD5G1vQv6Y3WL3UO57Agtuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p8Sl3SmJrbfX8Nl9xekhm8FRPIgv/7Q8mg1povfyGY=;
 b=FHEqqs9r97zBjHlmMQFj931lCPUzB4z4FoaXO99c5CMmBt7VydpIErq5e2qsJEUnd9oFsxVrvmsjLSGO621w2S/g4XlZ8YI4Gn5qtWTDgKhw3rWPIkNChJ+dNw0NTC0IkHux0VySzGj/eDcks3MrJS7WKnEAB2+VHf4U+B9TaeSWH5FHjBBa/7210MyzpBar9oDgBcG6mhpHNzormn9V1KiRCNZPCq478p9AdgKSuNUAUE4IDFhTeQCrAZ//9pv597C3N1rauXIw9+wsYqMu72sHm668OvisF8JwDUBs/ajVdvQ2IT89wLcFmFLznUuHjzx4j2xlYWZhePQve38tMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 06:36:36 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 06:36:35 +0000
Message-ID: <519e8e00-cd82-485f-8871-81fb703c7592@nvidia.com>
Date: Wed, 21 Aug 2024 14:36:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi/prmt: find block with specific type
To: "Zhang, Rui" <rui.zhang@intel.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "james.morse@arm.com" <james.morse@arm.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20240801014853.1594699-1-kobak@nvidia.com>
 <6cce5245bb569f30d73ac8ec1d217d70a11925e3.camel@intel.com>
 <678e2e3b-4c45-4c10-8af0-32e17c7b3bd4@nvidia.com>
 <a8aceb6abe91bd339ef4d90a84131701f8e8abbf.camel@intel.com>
 <f6e581e1-2d24-4587-a193-bfeaf1a3cb1a@nvidia.com>
 <4ea0db68415445e5aab405438bbd8ce4240d7ee4.camel@intel.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <4ea0db68415445e5aab405438bbd8ce4240d7ee4.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 26af1fa7-1d3c-4098-5ae8-08dcc1ab9a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjZBMmVLa05tTUFrUFFMeTdoYkQyMjd3NDUxNENoblpZYWV1Yld1bGpzQWF0?=
 =?utf-8?B?cUx6K1BHT0dZL0RWbmNNamNRMnJqR2NSUFVaYktrK1BsMGRmVXFHMWpNNWFG?=
 =?utf-8?B?M0NGV0V0UFZWeVFhWjA4QmlteGFkMTJPZVFRbmx6alVZK2RTeHJaVnRWOUhp?=
 =?utf-8?B?L0dJUkdwdVdVUlZ4M0U3N0R5R3hjeC9kdER5TzN1RXZ6T1FYVUE0RERnRDF5?=
 =?utf-8?B?UXBObjZBVllmaHA5amN3MjNnU0FrVlloKzk1c0RScGNNa3UySmpJSThTblV5?=
 =?utf-8?B?dE5RV0Z4YTBGTy9VL0dOb2J3YTZCeVNxamUwQmY2VyttTUgrc0hRV0FZWmty?=
 =?utf-8?B?L0Yyam82djFwUjMzREFGSXpHQlJhb05DMDJhUUx3a2JGdWlFOFJrQm11NUJO?=
 =?utf-8?B?NEtLd1p0QmQ2aVZtU0FXTlpISnNCME11RlYxdVM0Q0NPU1U0Mk5BSTNjL29s?=
 =?utf-8?B?M3NEdnFUSE51YXQxRkZXUmVZV1lYU2M2bWxWSk41dE1XcnRzd3paS2pYTEJs?=
 =?utf-8?B?aU0vWlZQdlp0OUsvV0ZaM0ozV0lndjJJdTJkV0pjMW5lMjdaZXZ5S0lGbzJy?=
 =?utf-8?B?aHhzVmNoNDgvWEpLM0Z1QnpkcHBNY0xBOS9US0FmUUNiTGlQV1RkVHkvbEdn?=
 =?utf-8?B?WUFLQXBIZDJWU1g5V0FKSGZKVzhlQWJTSVFEYmZscXFOenVlY0YwMjRpZy9X?=
 =?utf-8?B?MW41VS96dlp4K2djYURZK3NqZTR1Tlc4NDRrQ0pYTFBhT3ZLdmRrbWUxVVpZ?=
 =?utf-8?B?NUhETHIva080TWxPTm1xT3ZsU3RWVTh3UlBCTVJSTzM1SnJKaWNuSGk5M0lY?=
 =?utf-8?B?VDZBMkpsaU9KMzY0RGJWK01Yc3NiRXBmSzZpYnJCMjJSc2FBR3JJUGo2TVF3?=
 =?utf-8?B?dmxwQ1NmNGhGSEhTTlcwSGJwT3AzK09kL2F1SUR4UWlVSWZSNzZCNm1hR2V4?=
 =?utf-8?B?VFN3SVVXb0NlYmtjZzUzM2FNb3ZRVUxKVkJQWnZtRERGV0MwVG1TWFJqdDZD?=
 =?utf-8?B?OVNOcGJ0bXd6RHlaWnpZdjRpNUtYeUIwbjFsNDdGSkFTN0NMdXdRZDhxNStP?=
 =?utf-8?B?NDBkTVAvcWsrWENGY2swK2I4SU1IN2p0UGs5bU5tOGFjWDdWakJnYzhyVjRa?=
 =?utf-8?B?eEYwUng3bnM1V1B6aE9qOEI5OVZvUWhpOEhZTmhqWm1Sc0FrcTZCdEJGZGRV?=
 =?utf-8?B?TWkzU2JXcWpscmRQeW9WMEZ5RXFweHlhdmpkVi80L3RISkF1RmQ2MThDQWRi?=
 =?utf-8?B?RHVFVlczc1FWS3ZvMTdBcWg5eWhoYUk1WmJ3d25WV09SY2YyMGpvZmw1RWpt?=
 =?utf-8?B?aWNKM2t0VkFraVZMYUF3RVRSNkVsdisxOS91aTNpWTh3TUlVbzJsajFMUlQy?=
 =?utf-8?B?Ync5MUdRck01UU1RUUcySjQyMSt6ZzZVeDlaekNvVFYxS2g5K2Rvcmxhd1BV?=
 =?utf-8?B?Uk9sNm5ydzJwUVVCN29ZMVkrL1JaL1ZYcW52RGMxQmh4VmdCUTcvYUZ1U3c1?=
 =?utf-8?B?elFWc2VWbVhVcTFQMDUrQ1NXWWZsUm5qTWM3S2tpekprWG9QY2ttVTNqM3BU?=
 =?utf-8?B?dkEyZzVMOCt5WWIzeTlSQitDTE1raWs4S1dyK3I0d3kwRVlBM1ZEZEt3L0F0?=
 =?utf-8?B?RUpZcTlJOWoxNm5TU29URjF0VmN4NDRjSy9oUXVrcHh3WGozWjQrNnNjN3pv?=
 =?utf-8?B?UmlVVE5qOHI5ZWJmNXZwYnNFR0hNMWJkc0QrSVVvbmR5b0JvYi9CSDkza0FK?=
 =?utf-8?B?cTZLNGhDZHc5QnZMNkI5d2ExajM5RFBzZDd4VnUyY2RVUitTZ2Z0OENzcm9E?=
 =?utf-8?B?cldJYWVpeWRqazd1V01DUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkRsOGpCcmVTNFVQRVl1UFhvMXdVU09mZE5NZzJTSm1KUjVxT2ZkVlA3TVZW?=
 =?utf-8?B?dEJ5VkdxM0RtbmJsTGp5MkQ4VG9qUWdYSHduNEViOXJMZGNmRm9TalVCMzFp?=
 =?utf-8?B?Nk4vK1l3NVZGUXE4SWxleTg5VUswaG8rU1A1Uk9tOXNQUjVKQjJ2ckxYamdJ?=
 =?utf-8?B?UXY4dzVLdE5KeklubVJ2OHk3WGRIeDVWSW1jRmxKSGovUWxYZVJaMVhhS0pG?=
 =?utf-8?B?N2VRaVlaZmRTbURJK0owRzduKzFqdzQ5OFQ3cmV6Q2xoem9henBTOTBuanRQ?=
 =?utf-8?B?d09tdHhNMXVYS2drbU83SUJtYTdhMGVKQTcyaW1pTjdHQ2JrVVBMbEl1cDF4?=
 =?utf-8?B?R3RSZ05heTJ3eXpZL2Q0R3ZUMkkvTzhYUXBxNUk0aXNpaUhiSEVjbkJJZjJz?=
 =?utf-8?B?ck5tUHdIVmlLaXRrWGtRU2NHRTZodFo3YkpldXM3TWR3Y3ZmVkRPc0VKZHVY?=
 =?utf-8?B?WW9KNGV4VENuWHdxU015cDlTanR5aDg4MkpZOXNQSEtLV1E0MG9KOUxBUUc4?=
 =?utf-8?B?RnFqSmtUN2JVem9oN2tlNFRmdXRKLzZob0dKY2p3c0dVNnBTU2I1OG0rVURp?=
 =?utf-8?B?NkxhZlJTUzlBN28wd0Z5QTR5TTN1U25tUTY0d2VmUFlqMkwvaWtUSVgrSHNG?=
 =?utf-8?B?OVRKZzE2anFoVk5LUzlveXVDRUJobjJIb0xtUjQvc1I4ek5ZeHVTTGREdU5h?=
 =?utf-8?B?Ty9ycG5oZUpWZUhoejVhYXFoTTY5SFJaY05lVFBZalJmZUl2Q0xoT0J5dWph?=
 =?utf-8?B?UUFpZHdHc00zQzE2ZzlzTDdNMFBBbkQ2YWF4bkZkeHBQK0RJMHhQSTIzR0ZN?=
 =?utf-8?B?YW1oc05VTnJxWmZJSW5kazM5dU5hVmQwVUNJU0FWNi9oemdoWFg5Vi9zRXJV?=
 =?utf-8?B?YWZjOFBjM0tacmt1MWdxMUpObnducXRXTXcydzI3R1k3d2d5SGZMK3ozUUFy?=
 =?utf-8?B?aExtVkU1QzdxcnRBQ1cxRHpCK3VuWldkRzlBaUxaRTdtb0RObXl4SC9naXBs?=
 =?utf-8?B?b0R2eWJ6MGhLMHZsVnVVWGdjR0I0VkFEL1pqV3N3UDlVZG9VeUtTRFJuaXVJ?=
 =?utf-8?B?OVlzMkwzU29oMExWaGVWL2E2RFdObWF5S2tLeElneFF5QmNiZ25KVHA2Szcz?=
 =?utf-8?B?d0FWcDdrbU9IdUI2OUN1QndsbmxRMnBPbkFwM1FMaXRDU1AxZlZOMGR3eXVo?=
 =?utf-8?B?dWUxd1paNk1ZelZybHoyb2NnTnlnMWZ4TElHOG1CZEUvQURhSUJjb3VsR1Zp?=
 =?utf-8?B?V0MzYWt4YVpzMU1XLzRNZk5pUHcrQWJUNENnUGxrQk5pc0lQRlFCSGJscENt?=
 =?utf-8?B?RUNKUkpXRTFMRk4rUHRIcjNBMnk1RTMvT3NsU1g3eVFaQndQdFNRUkJIOUNE?=
 =?utf-8?B?VzJ1eEszU3lQZTExODJjU1ZETEtSKytsejB1N3ZpQjROVURDZGNITVovSDh6?=
 =?utf-8?B?WFA1bTRnd0pXMGNNMDlncG5PMGdwa2w5a2VTREdYTmhxbE4yL3pLNnZWNHBY?=
 =?utf-8?B?UlFUcGR1ZHlFci9QWEhJMG1lRnZQcmZnMUdxcWdQQXIreU9acXR4OHFvWGxY?=
 =?utf-8?B?S0ZzNmFtL1BOc256am1zMm8ycDVTa1doRUlzQ0hXTTlDcUlJVXdnaWNQSFY0?=
 =?utf-8?B?bHV0LzRUd2syQ1ZOTkJaRzlWZ0RPOTdIZHlUdG1EaVVKMjd2dlpiMjNzNDFh?=
 =?utf-8?B?eU1EVmlrOHBPVkV3Y3dMS05vZnI5UjladDdCcXFIN2t5aW0xZFh6R1pLVEt2?=
 =?utf-8?B?QjEvVjIrMG1kNnpEUzI0ZXRoVi9CaXVqa0VxMVZYeS94YVlJMSsxcHcyR2lC?=
 =?utf-8?B?Q2pWbDlJTDl2M3h6MmZlZ2wzcElBU2hoNzdvYmcvbzdjS3JUc1cvT0l6Zjdy?=
 =?utf-8?B?UWRlUzVyNzBOb29sN0N6MklNaGZpZllGZHhvOG1tL3RPYUlqUXVSV0J4Tnc5?=
 =?utf-8?B?bldkNVZxdDJPVUZWb3JlNXdIVWNQaUNLTWpoeTdJVllUV2s0eW00U21XR3Ft?=
 =?utf-8?B?YkxaMGRUZlVFUzF2NFVRQTlQSnRDMmJWSE9pT1cwNlVtTVRlRU85c3JFNGEz?=
 =?utf-8?B?Z2ZHbno3VFhjRVBYdlkzZXcxejhJbFZIQ05rYTBzTUt3bkJTbVlBQ3o2a0Rw?=
 =?utf-8?Q?sb5pROfd2CvtPfpJWxxjZnE+2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26af1fa7-1d3c-4098-5ae8-08dcc1ab9a5f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 06:36:35.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGWvADUGC4Oj85ykx9qI96U53C2/KYCJ3JIMxWndPKV2x40EfZj/E1/9DGrKXts3TsVdRugHU/W1FDKLtYLfRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372


On 8/21/24 14:33, Zhang, Rui wrote:
> Yeah, but I mean pr_err() may be overkill if the driver is still
> functional.

how about replace with pr_warn?


