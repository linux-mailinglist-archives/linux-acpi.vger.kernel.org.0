Return-Path: <linux-acpi+bounces-10177-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 612119F57E5
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2024 21:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850DA7A1990
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2024 20:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B21F9EA3;
	Tue, 17 Dec 2024 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qNWBHeoa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65991F8EFF;
	Tue, 17 Dec 2024 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467910; cv=fail; b=XB8zK+MX9gatNeRc7i4ZdGPUtqDBeV5wnxR/e8rjCLsvriUFxgHAt8IGj34LXV9fy6dEKL4iBd+Adakvvz5R1Ft53Ql8mt2qCY6E7GX+mpGCQURxG7c6lZqxbgeYgPanPUyDGUkskSoN9GJToapHQztBO3vD8J0l4QhmQME8G1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467910; c=relaxed/simple;
	bh=0jOkvKJBd09/QQ1RYvXAGX8JAf3Hfmq1a2+1RNdnX9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=edTAaeaqea/OWjVvkmJIuOPr73PdteJl/mcQDftjFPqfutnY0Y7JlWv2bXtiWXNcK8sLrEq/Um0i7aB7Yi3g71tKRyuunoAmopATHuevukSLmxREWY2beAbCLvMtPOakPj+O+1VewfFMgauvLX9NQ5aFciwTaa9NXOhO6H1QAEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qNWBHeoa; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVP3RudJmBlvWMEWD3P9sm8dMITuJCbAdwXZVyq5aa1Uh4JdAbaa8pLpweJs5WUaXbDbi0U6aBzPOgwT5WBBnyasYoOPnW+5BT9860E//Pkcxyp4ZC7hmhhzLY8HjJslk0GpAgkh1PB3MiNBvuvJSuem4/Fu2Jp89By7MKRnD4ok8RU8OmeWjrYnl3yNYtP5SjBucsQBFMb7iZtHnbX0eKsXihicM9CuFv+aCYQtMSftfvW4W/mpd2V2fzHWCHIdcqh6HSuTJ+2Z0Rw/Ghh8WtW0TQN4BcDakWVo3JvcSxrJZ3adZAz9siHu4Jt+lRsPLknE45lr/X+9cOPep5lu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+yG6roT8ru1b8fr09IP7WGrjaAuNhlY7WfCPfhHAw0=;
 b=HFqOaxlzIJwObxJOfz2nPUSV8XkCmgaNV+pxCKU9a48awJrbEWQF6sVJzZqHHO86LoGeju0hjb/TnB5Tl1PFAgaQ0RGN51veCy+LNuMZqTBrcx6gaSpOolt7NZPk3eBJ8//+XOFPB0ZPMVyv7L7ki4/SNdPbGrfidu8mQPBtsgpKL2s+BD2/LHIpDl8xOKX/RT8ep91PySaopklEWtF9XRFy4Qzg1xjfgPSkq0GOQxlppTTsbprsjlBRph36D+MXriY76yxAuTUUMECNfqEJYXVhGpYQPsNfYGqbUCP72V7Nmdunj4EnlYlvhiMG/bKHnVuo8MeSijrMiRTZltcAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+yG6roT8ru1b8fr09IP7WGrjaAuNhlY7WfCPfhHAw0=;
 b=qNWBHeoaIALyHVqCQen48TRsPiIN7COu2P+5n08tznexzoLurBoT+HVJr0T5wBiwt/kDPbFoZxUpjc0z51EPcODGES6gJcBC1JkgF2cz8/KpZ6cAmPyryX66Xw58G0ughUya/x9GlosmyCO4AO14oyvPtY+1vtPxXJFL2IVU2Fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 20:38:24 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 20:38:23 +0000
Message-ID: <e6650141-85cb-450d-ab62-0c2bea8ff1da@amd.com>
Date: Tue, 17 Dec 2024 14:38:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] ACPI: CPPC: Add autonomous selection ABIs
To: Pierre Gondois <pierre.gondois@arm.com>,
 Lifeng Zheng <zhenglifeng1@huawei.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: acpica-devel@lists.linux.dev, lenb@kernel.org, viresh.kumar@linaro.org,
 robert.moore@intel.com, rafael@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 ionela.voinescu@arm.com, jonathan.cameron@huawei.com,
 zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com,
 fanghao11@huawei.com
References: <20241216091603.1247644-1-zhenglifeng1@huawei.com>
 <20241216091603.1247644-4-zhenglifeng1@huawei.com>
 <e581fa05-9b4e-46e6-9172-83704bfa8ab2@arm.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e581fa05-9b4e-46e6-9172-83704bfa8ab2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::22) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 3173423b-4567-4863-177e-08dd1edac076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHFoSjBEazR3WXRkTHN3d1FPK3UydjZTOGUwdFh0dGpQeExNTldzQUZFRThW?=
 =?utf-8?B?c3R0THBnQXdXMDZIQjdNc2lSUTkvVWFDZDMzUlVtZlhXQktkWURxUjMxUnFp?=
 =?utf-8?B?K3VkbVYvbGIwTUluTExXMkFMZ0tRVnFsSmlzTlY4M0RaQTVRRmw4SjBYUGNO?=
 =?utf-8?B?SjQ2cXlyVURsWWdqamdOeHpxMnRXRjl2b1JQWHJzMDJvdzdVMnVDZUNWT0Ux?=
 =?utf-8?B?UnRKeWo1T0FuSjhzK1EwM1NUcG84V0EyclV4WkM4YVE3R0lXVFhGc1Z1cEda?=
 =?utf-8?B?eUordEMxZE9lWUEza3R3V09ibldXMjJwMHVvU21HdG9saGhlUUVVVDZ2b0Rx?=
 =?utf-8?B?VmMzRjlBRzA0Z0JwY0R4KzR6MnV1bUN3a3VwMmY5SVlQaGhqT1h0NUtzY01P?=
 =?utf-8?B?bFBMaE51UDVZUEQvM1UyV0xuQm55ZjRPeEU1SVFtZ1Z5QUxFVjl3anJ5WEQ4?=
 =?utf-8?B?SE8reFVTdTlzZ1UySFVUWnRSek9YVkw0d3ZFajc5bzdNSGRLUVFYNCt2M2lj?=
 =?utf-8?B?TVA5UnJrNnB3bUZNVGJ1cjJkS3FvYVpLRU9HeVU4RnlWOGZCQXh5U3VDcDlU?=
 =?utf-8?B?NTlvRmRwQUxERHgyNjE2UXlOS3hRQmZUVkIvL09iK2VPNUUyZ01YaFdVTDRm?=
 =?utf-8?B?c01jUTFYWDZKd1p5VCthQU0xVFhHZ3VHQTNFcG5BMlRHeDNxYXVzTzNoZUQx?=
 =?utf-8?B?U3BOdnpqSXpvVGdlMmVXMTQzRDNicjFaUEtaZndHVDE2eC9HWml3eEFDdjQr?=
 =?utf-8?B?U0FoOEdpLzZyRURxeFlQbUs0eVlqemxzZlhaajJES3VOaFBNL2s0RGxzeXhB?=
 =?utf-8?B?Zk9Da0ZrZ3NnVHNrU3JQRDFkQU9HLzFrbWVyb2gxYkR1cDYreGs3b0hHZ0U3?=
 =?utf-8?B?NE9qZ2g2NVdwTE9hRTlMSTA4Q0d6akNZQnRKSzdISjZsRkkvOVcrRFpyWGUy?=
 =?utf-8?B?UFZSTytWK0tUSitlTlIrVEpVMU9pbTZQUnhIT05MVHBGU2FTNGNGUCsxRmcw?=
 =?utf-8?B?SFZvMDkzLytBZGg5NHNPbVVKQzliQjJGSkNhQUc3RmpNQ3B0cXcxYVdvcmJv?=
 =?utf-8?B?dXE5bjgxNnI4VlRDS1IyQ3hYbVU5K2FhUW5iVHJtampJQS9HNXVZQm1VN0NH?=
 =?utf-8?B?YzRaajk3ejFzaHdqUDlIUjhFeDhNK0dQeEJvTm5zN1pDL3dYZUREWUJTb0NL?=
 =?utf-8?B?eGdxdmJSM1hETUdsWVcxOTd5K2tvbnNQdkVKTDc5ODBxbk05NE9ab0QvdURz?=
 =?utf-8?B?b1RVZEpHdkNBMDlDcmZUdnU5YTBNSkxnU1BJQytUbGw5VjF0cVdCbCtFOGo2?=
 =?utf-8?B?djEzSWNLRTRjcmlBY1lGRmNxcDdaSXdDZXpzeU41Mk1hV1RGV2ZieWZzMHdk?=
 =?utf-8?B?MUV3cjRxLy9pdnVPNFZGQXpkcUw4MDI3ZGxBZ2ViakNDbUx2cTkrelF2bWtN?=
 =?utf-8?B?eCtWemxnaVVmQ1ZnKzkrbVFicU9ZZkVNNXNpaGh1QmhVS3o2MXl6dnBpd3NX?=
 =?utf-8?B?NlllUFQ2OTlTTmNvU3pPU3dYdTN6SFdnN3pmdXB0enVtdTViVVh5TldvMWRH?=
 =?utf-8?B?bFF5RDlHTjh6amhIR3VGcHRSMjE3aWJLMnJ3eW5EbGNqUVAwNit2eUlqRk9j?=
 =?utf-8?B?bXpHWlI0QzVzeTkwcTFydnZZSlVKWE90YURSOEk4eDNKek1zYkM4eGpBK0M5?=
 =?utf-8?B?VGkxMXdTWjJPaUJoaHY5Wjgza3pqUlVXMC95d2RPREF5VVBGUHJ3WjhNMnhJ?=
 =?utf-8?B?bUtFRlB2dk1HODBOMGg5dUFNREhycFJPM0lFdEtaellyV2ZIVzFycnVhNU50?=
 =?utf-8?B?Mk10QWM5ZC9iRmNPSDFacUhyTmFOMGM3MTFlSTI5NHlEUm00cTU4RDZONXQ3?=
 =?utf-8?Q?gJYe9biVl4Qs6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzdoS3c0WnBkL3Y1aGlNeFlsaGdtOTV0V1NZVnpQZ205WkEwOVQvNXhEZkFq?=
 =?utf-8?B?bDc3MjRmRFNZc2xiYkI0a29wY2ExUERCUmxyRG5KYU5WR2Uyalg4NXUrc0da?=
 =?utf-8?B?dmE5UXBueGFpUnJyYUdGcnlIdDN0L0ZlR2hkLytaNmRaYnAwbk1QVmZWKzRR?=
 =?utf-8?B?K2I2aFFWangxcGc0TFRvWVYvSnVPZGc4a2RaeGQxNHl1UHhscW5IWHE1N3hC?=
 =?utf-8?B?TDEvZWF3MW96c1NZSkFDMjJKQnlCbHltb25XN25HS1k3Wit5aU1XdGpEeUJP?=
 =?utf-8?B?eEVMT3FYa0FodlluZnpmN0g4UjM1OVNTSlZybjE5b3RGMkxMWTVVNDBXVXBt?=
 =?utf-8?B?L2l3WFhmeTNSdittSnJEN0NMbWQ5NjlhcVUxV3dIaXM4Z3ppeEZ1MEN6YmlW?=
 =?utf-8?B?VGZHeERoWjQ1SFhQampFV1llVURIelR6NWcvUXIvdXA4M0o3MjUvVUJTT2NM?=
 =?utf-8?B?SmFwc1djcC9NczloWXR5M3NNaHcwN2xOOHRPOHdMQW1BK0dmNzNEQ3UxajlN?=
 =?utf-8?B?UU9QaFNxQ3pyVmE3WVJ1T2o3Mm43ZHBibDEwTGNVUFE3WUZwWFZvdGt2Qnpt?=
 =?utf-8?B?NnJJSzN3b01xdHduSWZsTUl0TjVKMkdwLzdQdlk2NFB3RzEvUG9JT1BaVHpO?=
 =?utf-8?B?RnI0Z2R2NkptdkJzRHN6azZMRmlkTk1hSkFmcUZlS2ZLUHBkSGdqcjhDYzVs?=
 =?utf-8?B?ZlV4S2kyNHJoenM1U2s5SFNUSE12KzdDV1VSVm55dUhROGdtSndNNkVUenN1?=
 =?utf-8?B?OWZDNlpPVnhXOWw4Y3NLbXdzUis4M2NKNnlXN2FVWld1Z29YMU5wVHFGVmNy?=
 =?utf-8?B?N1dHd3JpekFJQ3BvdXROR3FlcEdTSjdGTWxESEM2SWxzTEd5dDdMRkdxa0J4?=
 =?utf-8?B?Y1BhdFlCNWpPVElWVjc5TS9kRE82ajNsREFWeFlLVlIvZXo5N0Z6U3crdWxl?=
 =?utf-8?B?R2JrVCtpQzNwM3FqbmptRkEvbWVwNndXS0Zub21zazllZ012NXR0Rjl5eHFu?=
 =?utf-8?B?aTlBeWpyRHRCZlpwc1dpU1E3a1ZOQi9EYlZhWnUxKzhZWjJPOUpEVzJJanh3?=
 =?utf-8?B?WmwwWkpZOC9HMXdYR2hHZ29kdW9EYjg2MjJQWkQvYVcxQlZvU25PTFBqSHZn?=
 =?utf-8?B?dlBIRFY3NENXc0tJSy9oQkQ1ZnpUV3QzVDh6VE9SSmk5T1ZDV2hYTlJobU5N?=
 =?utf-8?B?cHRwWXlLMmtNaDAyQzZ3VjFjVnlZdUlKSnJCUUdjWnpDY0JtRmdqM285RlFB?=
 =?utf-8?B?MHRONzM3K3U0dUhxaXVIUXE3MXphVnd2WTVyQitpNVB4TUluTWphMENsUzZS?=
 =?utf-8?B?OFkrc2F2Z2JYY0tkTzBQMjdUN0VOVUdvbTZ6blZLaEgreG5YUDJWNG9BaG5W?=
 =?utf-8?B?OGMxQ3VIMWpXNHp3eG1XMG9neFVHU3VXTnhoSlg1dGU4QzM5cFZ6YVZDKytM?=
 =?utf-8?B?Ymg1RlNUQkk1L3lleUpaNEFEZTgwUXloNE5sSjRiOHRnaWdzVGF4Rk9hY2d3?=
 =?utf-8?B?LzFSYzRnZU50SFlTV3RUdE9TVnRCNmVrWjN3S0JCU1ROcyt3THI2OXRRN0lR?=
 =?utf-8?B?N0F5R3B4ekIydXFqKysvc1VIRi9ERlNKcXJpNlMzVXBxQ2tlSlhJMVdDQStU?=
 =?utf-8?B?R1R2d2ZsUkhKdVRkSnRKdVdYYjNiMkhra2kwc24rckdIZ2xYckhJK2JsUUkz?=
 =?utf-8?B?eG9zSzRsRjBRZlNaMFB1Wmc1ckxOMENRaWZhVEY4bzB0OEJTOXQvbFJxVnFu?=
 =?utf-8?B?N252VG5HVFlpT0NuaDZDNm11b3o2NGVxcjFxME9hSlNMYW5EbEgxQXlSWWZH?=
 =?utf-8?B?aWVEMEliVUtRUkx1WmpVV2ltNHlnT2xtaWgwK2xDK3dDZHVPSkJqOWRwcllK?=
 =?utf-8?B?Wi9aclRheEsxU0VVckc3ZmI1bzkxM3BMVnJIcis5MmNra05LN0JjTGJFUzVl?=
 =?utf-8?B?WjdSc0hhc29IQjB5QUQ4eDIwTlRiQkFPcTFpaml6UXlDNVVORm1nZ3Y2OGox?=
 =?utf-8?B?WWtWREExdlp3Wkg2SlpUczRYN0VpSVQvNnV6SDVLbTlwTWVIQldaZ3pVRjla?=
 =?utf-8?B?UnFQS2hNVlFscU9IdUJmb25EZG9WNzZZTDdWVmJkMnZQMDQ5MHovQ00raGox?=
 =?utf-8?Q?ZjBKyWGcHQTLCTCZjxPo2e3Sa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3173423b-4567-4863-177e-08dd1edac076
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 20:38:23.8852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DacG8Sn4GFvAXcW5z20/3sO6TtXRJ5lz4LjLaKyHRXwpdtJ1ZvYEhuiqLMWrpIysYcpJtkp0iV5L94FqpZSEwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151

On 12/17/2024 07:48, Pierre Gondois wrote:
> Hello Lifeng, Huang, Gautham, Mario,
> 
> On 12/16/24 10:16, Lifeng Zheng wrote:
>> cppc_set_epp - write energy performance preference register
>>
>> cppc_get_auto_act_window - read autonomous activity window register
>>
>> cppc_set_auto_act_window - write autonomous activity window register
>>
>> cppc_get_auto_sel - read autonomous selection enable register
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++++++
>>   include/acpi/cppc_acpi.h | 20 ++++++++++++++++++
>>   2 files changed, 64 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 83c7fcad74ad..645f2366c888 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1595,6 +1595,50 @@ int cppc_set_epp_perf(int cpu, struct 
>> cppc_perf_ctrls *perf_ctrls, bool enable)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>> +/**
>> + * cppc_set_epp() - Write the EPP register.
>> + * @cpu: CPU on which to write register.
>> + * @epp_val: Value to write to the EPP register.
>> + */
>> +int cppc_set_epp(int cpu, u64 epp_val)
>> +{
>> +    return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_epp);
>> +
>> +/**
>> + * cppc_get_auto_act_window() - Read autonomous activity window 
>> register.
>> + * @cpu: CPU from which to read register.
>> + * @auto_act_window: Return address.
>> + */
>> +int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
> 
> As there is only one way to interpret the value of the
> 'Autonomous Activity Window Register', maybe the logic to convert
> from/to the register value to a value in us should be placed here
> rather than in the cppc_cpufreq driver.
> Meaning, maybe the prototype should be:
> 
> int cppc_get_auto_act_window(int cpu, unsigned int *auto_act_window);
> 
> Similar remark for cppc_set_epp() and other functions.
> 
>> +{
>> +    return cppc_get_reg_val(cpu, AUTO_ACT_WINDOW, auto_act_window);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_auto_act_window);
>> +
>> +/**
>> + * cppc_set_auto_act_window() - Write autonomous activity window 
>> register.
>> + * @cpu: CPU on which to write register.
>> + * @auto_act_window: Value to write to the autonomous activity window 
>> register.
>> + */
>> +int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
>> +{
>> +    return cppc_set_reg_val(cpu, AUTO_ACT_WINDOW, auto_act_window);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
>> +
>> +/**
>> + * cppc_get_auto_sel() - Read autonomous selection register.
>> + * @cpu: CPU from which to read register.
>> + * @auto_sel: Return address.
>> + */
>> +int cppc_get_auto_sel(int cpu, u64 *auto_sel)
> 
> Similarly, maybe it would be better to use:
> int cppc_get_auto_sel(int cpu, bool *auto_sel);
> 
>> +{
>> +    return cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, auto_sel);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
>> +
>>   /**
>>    * cppc_get_auto_sel_caps - Read autonomous selection register.
>>    * @cpunum : CPU from which to read register.
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 62d368bcd9ec..134931b081a0 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -159,6 +159,10 @@ extern int cpc_read_ffh(int cpunum, struct 
>> cpc_reg *reg, u64 *val);
>>   extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls 
>> *perf_ctrls, bool enable);
>> +extern int cppc_set_epp(int cpu, u64 epp_val);
>> +extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>> +extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>> +extern int cppc_get_auto_sel(int cpu, u64 *auto_sel);
>>   extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps 
>> *perf_caps);
> 
> This is a bit annoying, but maybe only one function between:
> - cppc_get_auto_sel_caps()
> - cppc_get_auto_sel()
> is necessary.
> 
> I added the owners of the amd-pstate driver to ask if this would
> be ok to replace cppc_get_auto_sel_caps() by cppc_get_auto_sel().

Yeah I have no concerns with this if that's the direction this patch 
series goes.  Feel free to change amd-pstate in the patch that 
introduces cppc_get_auto_sel().

I'll be out around the US holiday, so I might not be able to review it 
for a while, but CC Gautham on the series and he may be able to.

> 
>>   extern int cppc_set_auto_sel(int cpu, bool enable);
>>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>> @@ -225,6 +229,22 @@ static inline int cppc_set_epp_perf(int cpu, 
>> struct cppc_perf_ctrls *perf_ctrls,
>>   {
>>       return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_set_epp(int cpu, u64 epp_val)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_get_auto_act_window(int cpu, u64 
>> *auto_act_window)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_get_auto_sel(int cpu, u64 *auto_sel)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>>   static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>>   {
>>       return -EOPNOTSUPP;


