Return-Path: <linux-acpi+bounces-18848-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0873FC5571D
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 03:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A28F343995
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DCA20FA81;
	Thu, 13 Nov 2025 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WGt3Hg/a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760B1EF0B9;
	Thu, 13 Nov 2025 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001246; cv=fail; b=YxoFWCtM3BogBldcWSkDr+VuGC9cdkSiAIQxeCuqXfk70IKK4FREzFRpeaeGAtx8lUfVN8r4rqZCJ0r2XCCNusbxvqf+NJI9RSp6iZRRElVOa/c5gLwuMbKvu/Lp4nI4GlwVE64mj6PgX7S41tunRblDRNAu1V9nO/TrSGwEAO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001246; c=relaxed/simple;
	bh=f/QoKZ/Do3EigDYePZVyOwWZ9FPn7gIJfvESqJKcUA0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y87GvPVZvTiobZZ7gj6ki+HP5oxPOpE2t5e8mEOEt//1qumapzjABy5epkIbh+wJbwKBKmlANJxH9ieH2aoy/ZQuW4QdPfBqedyb1sRG+q+l3R9FbeIcqnNZDn58TXIVIPLSc2ecN3vWBIdAwoBNvDHkzSAMXA2aoUR/irbfov0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WGt3Hg/a; arc=fail smtp.client-ip=52.101.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIQNP4wzu9pmnfY4FylHIudWH8ss5YK0FHxfsjHoveu+kzuBkz5Qd2S4qCDudJ9T3jKk9MjpTgRPBe/Z+PUs4O8vAMv0I8ZMjo1d3WEBPUNFsZEU6wDLKLIj/+zmy4xjSrHvwRNN5noK9TsUh3QqMpDYWbnqglee9m5z6Ld3RH1YqYEPa5+ycx+6vvWfsqI6byHuUt4eG2yDXSiIYFyc/x9NgT1F575JmReTyG0Tfmv5DfF05FLOKVNuuxs8fDNLEGn2UzPRndntSFl1jte9NQr9s03nfyKaEDtkgRRCChKjzVjWJYtzt9zfNZOMR50bTlbW8s6OvKsxJEMYv6t+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W//7caATWt8JlWokW537C8n+uCEwo0LBjNalFf5cy24=;
 b=aHKC8+xt9F/pOvBZ195e/v17oHrtmgkZUN7cEi6+hrdjmkkZaKLPB0CI4RHoaeITBNvYRiL/OpxV8Epm5rRU3dB8QUw7lx+vc4vUChR9ARTUR6/fDAhn0SXFYLA3s/BtlF20O0uhxvH4jLLoQsulu8TgjMFJq5cNHjxhVff/og77i/pe2wtAN+dHaX1w4mT84GSHBpYRRYwS12NuKEsP0nWA0VzW5tLVVqQUSq42keznyo3Nb9DvL9CxX8UPuviKACiUhL0HTDBYFDiEP37qMzW8E/ZzpzntEB0CN7mMf9ejvwMy7u4bS9/anet2ZEkP71xIqzOhCzp0bExdF7dF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W//7caATWt8JlWokW537C8n+uCEwo0LBjNalFf5cy24=;
 b=WGt3Hg/atZL5WSgK0ieYbqYNB5HaiRBapR/l7htSaRC1cQs8gi/sLXPTB+lpRhuy26UsnvOpxiFWKMkYex4/05uIw9KR1vjXFkBWdozXLEP8CT5hvdE0ZUtaj6jxGDH7IODuz8KPQCZZE9DFgazAXPSk4F0Wawxs1GMYhKQht1ffTJsp1RvrlVqwjfL3BdQiLuCVst2V1/zk92rgdGJkX0msrA0BOeUyPoxiKv4VVTGkreSOBZjaocP2WmqZdVaJMAby33MnEeFdR+Od2hgneEIzLFaZ7bR78JyguiQ/bZA6iWo0QwQNj+n5KxZYm5tzXLqD9vZt9FaTIQXRl+GLqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 02:33:51 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 02:33:51 +0000
Message-ID: <498b5814-28fb-4b5d-91a8-1aab02f3f5d6@nvidia.com>
Date: Wed, 12 Nov 2025 18:33:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/33] ACPI / MPAM: Parse the MPAM table
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-10-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251107123450.664001-10-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f68f794-4fa3-488d-d908-08de225d14e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlBlMUIzbW5MaXJtVHBtWXlQVUJHdlFZZVFscXdYYlZZUWVYd2xTbURDRGQr?=
 =?utf-8?B?RUpSRmVqYi9WN205eWdHODlJOFdlbWRlS0duRG1vd1laMVU0QXhQM2VQSFhB?=
 =?utf-8?B?R2lRSWJtQmxWMEVqLzd5akFuSTBibUNQR05xSmNMZnRkNFB3YUpNUkNHemtJ?=
 =?utf-8?B?N3JibFlQSTFUV0dhU3BKVndQalVPZ1UzT2pWNGpXRG0yUzVEQVB6NXE3ODdi?=
 =?utf-8?B?alhockVTRmNlRnR1SHB6OHBuanVHaHV6N0JpYTdpY2FZOVVLaCthcjZBeEtM?=
 =?utf-8?B?VDdLODNrNmwvb0EvL2R2OGNVYmtvWWJVS2tjVjEwN0x0ZmZRTEFodSs2ZDVH?=
 =?utf-8?B?bnZGTEEydDM0UExYbHhXWndYbjRCMng0M0FURFdhcEpmWUVFcnB1K3ZzbWZ3?=
 =?utf-8?B?VWYxVHNuTjdXSk04RHFhQVZ2WUhmTnZVQ2E5eFZwVzhaRHN4SjlQSUV4SXZY?=
 =?utf-8?B?WG1abktsRlFUQ283TC9Ra2Y0WSt0cXNxaFJIbjA0a291VkJXUGpaeXdLeHhP?=
 =?utf-8?B?V3lVVm81aDZWdVNGaXNMbkNLUWtOdit3ZjVVZEg2bEtWUnRsN05mRTdDbDBy?=
 =?utf-8?B?Rkx0T0ZUM3FucjhHMS8xOTNBRm1Ic2dtSHpLVFFXNCtBYVNMMWtiNlVTU0o3?=
 =?utf-8?B?ZUIrT0hrSG4wRUMzdkRNbjFsbTlOaVFFTWUxZVJMUjVTYW5MVjRHekljaFAz?=
 =?utf-8?B?OFVCOHh4QmczdXIxN2tGWUVkNWE4a1J0bDloeGliemhUMFJmQTN5d2NraVE0?=
 =?utf-8?B?Z2FsZkd4ODN0NnFpV3dNOURMZTlXVjJxY1o4UGFqakc3Nm1CS2FSeDJOM3Fn?=
 =?utf-8?B?ZXhQcjBvbENLVjJYYm4xY2kveTJpK0twS05pRWJoZ05qZDlxOUt1dE43M3Y4?=
 =?utf-8?B?OGVFSHZ2THU2WExieXFuclNPZUJFUW00RlVLQ0tXVlpidWhxeHprbDF1WktJ?=
 =?utf-8?B?QmIzaFlrSVlIbEVOdjZPOE5mUnNiOVpOek16d2xiL2F3MDkxTXo0Wk1xbnpw?=
 =?utf-8?B?ajRTeGhCemJDVld6eVh1MkJvL0QwQzZtSXNlQ3lTMHpYZ3Jza0NPUEl3eWpB?=
 =?utf-8?B?bERVWEJ2MjVJTVdmT3drelZSU3lKTUVKVFNpZlZyOG9HcW5tOG5vQ3p0UFB4?=
 =?utf-8?B?UkplVEVYMGkyaFI3Sy8xcGJ6YjNZb3ZjZXVoR3dJMzJwdFh4dGh1blRGcHV5?=
 =?utf-8?B?L2NycG0vdEpvWWJ4MGlpUmYyVWdSTGpGbjRLamFTdjdXVUtlZ0pncG42YVZm?=
 =?utf-8?B?ZmlYSlBxTFRDS1YwbEdWNFNYeEo5b1BBZTl3blpaUWQ3dk1GTFUzcndycE11?=
 =?utf-8?B?dG16eVJUemV6ZDJMQ3hyY0ZQcE16cnVidy93bDd2WTZyYVFlRncvWWpGeHVv?=
 =?utf-8?B?VWR4OS9TQTFyN0xJMmFvaFk4c0Z2UWlWYWRDTTdYc2k4eWVKZFdwa1M3eWRi?=
 =?utf-8?B?UTBwZC8vOWNJdHFzZ29IeWRYcnA2RUpuVDZhU25wUWIzOTBNNlB1OURzVnZx?=
 =?utf-8?B?VG03VUE4ajU3UE5NM1ZZTEFLOENNMGx3RjNydTkrQmQzbjVqZDBVMWZoR2pt?=
 =?utf-8?B?V1gzNnRTZ3Vzd09XL2FVSU5aM3dnb2FkSnFyRDI5MmRXazhFNlphMzNvWnZG?=
 =?utf-8?B?YkNVL3l4QURZWXFtY2ZwbWZRMEZLUDNFSjZ0eUc1MFV1OG5DMlRoZ3hKRzFR?=
 =?utf-8?B?SXdyL0lOREVLbk40YTRpSUFFNWVpOFRzL0tHYy9leEU2SHEvUCs1K21YcWpB?=
 =?utf-8?B?bytxNWQ1czlLYWFiaFQ3aHUzb3g5SXlLVCszY2t1OXI5dktoeTBiSTNPTmhY?=
 =?utf-8?B?WXlpdGdaZHRjbEFNZ2lSdzJYWEJnak9rZmtOcFdHSmo0SVNibTkzTUlFbktH?=
 =?utf-8?B?TnZQYkVBVTJyQ28yUnNadENwS2MyVTlKVjhMcmEwMGNKeHlTTGZqVHJhM1RJ?=
 =?utf-8?Q?U26PYKb50Fn2WVVfDfvmoZZQF0kKjiD0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0tzK25vd0FLWU5EaUVpemd3NzdpUjkybERmK3UrKzNWWUtDWjZyaXRmUFIy?=
 =?utf-8?B?MVZYMTJsTHpER2xFdUF4N1dVUlRiNlgzRG5ya1RMU0k5VVByQjAzWmQwUDg4?=
 =?utf-8?B?Y3FWRUFxL3BjeDgyV1N3K1M5eFpXZTQ0TjVaUzR5VllBd0gyWm5XZ2dKTlV1?=
 =?utf-8?B?eVc3VVlybFBnS2U3T2d1a0RBbnB3Q0xsMjlJd2h5V3NLNitsL2dZYjM0NkIv?=
 =?utf-8?B?NFdkWWErK21XT0M0bjNrZUtkNGdPUlZXdUFmSEp5amRhRnlwbmNIdG5nK1dB?=
 =?utf-8?B?UTlMWEw2dkpGWHVIUWhSUnRucUl4UnVaVjJZc0tlNXF5YWI1aTZUVFlDbnFj?=
 =?utf-8?B?SjVnMVBGMEVSM3NZOHBEQXNBWmZrMFY2SnFYOU5wVytFSjFnMkIzeGQxYmhU?=
 =?utf-8?B?NDVzeENBajlibUNzOXplbExsMW41L0ZaRmZqUVRyL0gzbEdwSnVWbEFYYUdR?=
 =?utf-8?B?cVdEUEpkVks0dWJrdVZ1bjJ2WjE5dlRPU0VONkJmS2dNaGE0dWEzd2JMb1Jw?=
 =?utf-8?B?VUl5a1VXQUY1QS9kdGlJYnZhUTE3clgxeGJSTkNVSU1PczA2TExqZ3hQc3Bn?=
 =?utf-8?B?WEhXd2VRZzVDNlFueThLQWs2VXY1TTVBWjdXNmc2cXEvQUk1WWpqNUluL3VF?=
 =?utf-8?B?QVRqeUxPdVZIdSt5UXN6RmJ1WW1RWDJhdncwNkFtUWZuMW4xWWhVaUdiR2ZW?=
 =?utf-8?B?NjJZVGJ2V3VtaGZMeWdZcXZzdGJXTytJem1sQ2t6dUdsQStiQXJoOHZvRjF6?=
 =?utf-8?B?aFBJelFSNWRjUEhJait3OTFGaXk2UzVReXZtbkZFSklaS2tZZWltODltR1ds?=
 =?utf-8?B?KzVEY0dFNUlNQnRwTSthMWo4UkZ4NTV0T01kSE90dE9Rc0JhOTBUa3RwaVox?=
 =?utf-8?B?ckIzTWJ3V1d3Vm5TNm85TE9QZ3hmeFFOL0N2RG5WNU1qc3orY0NXSWl0QmFN?=
 =?utf-8?B?WXpFWTQ5dDRqbTdLSFZXc3JxTmhBZUJiOWtXMStDQVpNOW4vYmpIaWxlbncr?=
 =?utf-8?B?MzN4b2xJWTlXTlVuV295citXVDNSSkMvWTlheTMyRDdkdSt5MHRSQllrZzBL?=
 =?utf-8?B?L1NXV2JTS1QyY2xjNzBZdGxFbFFQV1AzVkFjZHJ0U3MwcVBnK0dyRTlvUFBy?=
 =?utf-8?B?TU4wOUxzZmlpR2haZFdaTWxaZ3VXMHUxcHBXTklSdlVIOXJUSElNOFpyWDdB?=
 =?utf-8?B?ZzdWbURTaUFzWUhFdVNVU2NoMlNGaUtGWXZvai9sMXVIUWZCZ2xlWlFGNWts?=
 =?utf-8?B?SXRSN01GUm92ZDNzRG1xUjd5WUZEK1JMNmtwTXBSbFJ1WklGWUxmM3o1NkZQ?=
 =?utf-8?B?emhITFlLZ3VZVUtxVWJBdVJPelZPMUdXQm9jUVFKV29mRFNMSGd2YUUzaDFT?=
 =?utf-8?B?WUFMSFNDSXRueHpPME5LaFRwNTBya3UxeVJDUzl2Q0Vzbk5DWW16SmtOOUly?=
 =?utf-8?B?djFPR2ZuVmIvYlptSHZQRmxBWFpkTEVtNVArbjRTNGsrR2h4dHRyNUlVYXNX?=
 =?utf-8?B?Yzk0QlRrcUtGdGdKTTFUVWtqSWhIN0dXcjFnSlUvbTJMZ1QxV24xM29FMERX?=
 =?utf-8?B?bTdXL3l3M0tjTHE4anNNY29vQjA0dXEyV010OUpkYStNSDhyTFBEaU5saUdx?=
 =?utf-8?B?QVlFdmQwTjFaY1dyWHNKendISFVJanQyeHZMWUFTTEo3cjkxQTgrWTJhRVcx?=
 =?utf-8?B?ZWQzS0J0ZnJGdEUrU2pmUE84SFJCZWZwTjNNaFRKQ0QwQndrMU51ZG1tVzdr?=
 =?utf-8?B?R1ZPWVBIa3ZKWFExdi8xcS9FR1NVWDBuL1JndllmZEhXb1Y4VVVPK1ZyMXYr?=
 =?utf-8?B?dWt3VVpySURsNHVyellma1VuUW94TFZUZnJZUy9qbCtRTUVIUUF4dWlrSU43?=
 =?utf-8?B?WmY4b2FEWjk0Qk1LNlhTcXFpcDlTdTBTOEM1SFFJUktSQ0x4cXZqZFYrRm9p?=
 =?utf-8?B?QjZzcmVrTXhsek9IamYrSXl5TEhsTitGTHNyN0FjMU4xU1NoalRLTVl5ZlM1?=
 =?utf-8?B?Z0dCT00vQVNKZ3gxRTUvZCttcFM5bnBTRzRGbHduanpYeU1FL0ZqdkdPc1lG?=
 =?utf-8?B?NkNkRndVL2pYU1lISE8xMmhxVnM0N0t4NDZSOHg3Nng3M2NGYU01NE1nbmlI?=
 =?utf-8?Q?e2NridTLyrO85L2wifmVFl1ek?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f68f794-4fa3-488d-d908-08de225d14e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 02:33:51.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Er7SHwWNmt0dRFsThNfufwX38CT0YSijmb4iUqlvUoBMDL8Ne9QJhdt/OCk58rHIwmJPGtY1RQ49+hidLgyWwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

Hi, Ben and James,

On 11/7/25 04:34, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>

[SNIP]

> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
> +				    struct acpi_mpam_resource_node *res)
> +{
> +	int level, nid;
> +	u32 cache_id;
> +
> +	switch (res->locator_type) {
> +	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
> +		cache_id = res->locator.cache_locator.cache_reference;
> +		level = find_acpi_cache_level_from_id(cache_id);
> +		if (level <= 0) {
> +			pr_err_once("Bad level (%d) for cache with id %u\n", level, cache_id);
> +			return -EINVAL;
> +		}
> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
> +				       level, cache_id);
> +	case ACPI_MPAM_LOCATION_TYPE_MEMORY:
> +		nid = pxm_to_node(res->locator.memory_locator.proximity_domain);
> +		if (nid == NUMA_NO_NODE) {
> +			pr_debug("Bad proxmity domain %lld, using node 0 instead\n",
> +				 res->locator.memory_locator.proximity_domain);
> +			nid = 0;
> +		}
> +		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
> +				       255, nid);

nit.

Seems "255" is an ad-hoc value which won't be used for memory type?
The "class_id" in mpam_ris_create() is confused: it may be level for 
cache or it may be 255 for memory.

To be clearer, maybe it's better to define and enum for class_id? 
Something like:
enum mpam_class_id {
	CLASS_ID_LEVEL_1 = 1,
	CLASS_ID_LEVEL_2,
	CLASS_ID_LEVEL_3,
	CLASS_ID_NOT_USED = 255  <--- for memory type
};

Thanks.

-Fenghua

