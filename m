Return-Path: <linux-acpi+bounces-8583-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C939922E1
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 05:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF6D28295C
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 03:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1996A125B9;
	Mon,  7 Oct 2024 03:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cHg74pX1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7CFC11
	for <linux-acpi@vger.kernel.org>; Mon,  7 Oct 2024 03:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728270194; cv=fail; b=PTbEv1yU1MA+oRq5A3YaRnSdf0kstNT3YWoySdmdIz3cTyBzqSulUaDxeTdFYod0f0tdubXdxH38i7R+AMLIjoEOjdHlp91K7vhd2JhUftfv9BmWVN7+BdHZb9YcnW1+BVXM3rZfbb3iYAkg/yDuFaB87ITnT2TuMiZ8gkd3ZRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728270194; c=relaxed/simple;
	bh=tsnAwEkicVp5hbWu/8ibvFxY5Q5s/E1VCR8UtaT9++4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hoDE4/THOAXwIBmI0KcuquE7+QxkvCeiPAESp2I/vvK7xK9Zc41z8gw8tCD/iLdz7sX1fA0IqdWDKdDKfl3D6BWF2Wp7Lw0qU6GCDOKJqbZRaZe510wNqy3bBnjfuaw67DuQLawGnx4IxB0ZhoGIT3Z2JtJfJPUwwmbvRZN1xRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cHg74pX1; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpCJvpqQpMWJ7gtydgM17/PPlvBoafVd6eb/dYl6OoYr+o3FzpQXNoByWuGPQB61XncHRZdw4royO9KhpBWgV1bP9KZYSD2f2s0P+CvfKOjQMLkAOemmiROEfo0KjtPmxrKZ4IRfnnPDszFSa3k7xerrQUZ9qLcpO00Cbevgvip6Te+ESSIj+9AJw5PVNVQRgBwJ26LVxQ2Y3gzWB8S238VDwgMFfu346/wPuq4ZNisrDeRWasrYXgVrpPdeAcnXBUMPA3aYVQZidYLuhL079AYPV/rFXUw759ggNqVb69qIO08EB0LogYwkwiX9NvynkHvSMM4sb++eT7197G6LRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk8ILbiZfR8jHxK/ZsJm7IzJKCwOLBLewnF/kLKnOGw=;
 b=e2km2YGctTO0W58E42mBUbzI9h04gQoeOnhroe4ir4tJW8ipVhifzbeVrDudBjhm9PurzmX1nBABjVhpsZy7Nf4ohFPy3RBb+uKr+cRIBlHa2DOLlE332YrnXy/wImALDNp0NbRRsh6V5LLb8g67aUaBFebnS47Tv8Qma7P0k9TDL2pbMSIvgBZf6twadJIeDAxqJm0xLdJwIMIzxIPaTuyKWDxeCMyYrqPjN8cE4PSvRNfCYK7pMu/DoBf+o01BcO3DL5MlWHwqbjn7undO9xWehFf/7wmUpt14Ti1KDSMwTN+uZuQqx9Vqdn1Uuqxn64sSpy3TVfAUWNUNoH+rmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk8ILbiZfR8jHxK/ZsJm7IzJKCwOLBLewnF/kLKnOGw=;
 b=cHg74pX1cPiJDfc5IJVqgdH+X8eDgpiebz+437aiduYTuFzUb6wxpsISsmKx51RbMhuAPELVx6lFZ94/U/pUxOrHhUK+GiEXmaufYslRm5R6XfnAR83EUd7H5ywcKNcgGtcHTotxl9dcJHEku1HjclDRnGW04tT+m1vURdE/EAwj0d4lpfLVMul9coV51BTfCQthltzeisws5HvmewYeRDsXG9s4logfa9SPL1pCKKWAgjYqjL2I07sI39cWKChrXtIbXDoSoSZSnA04snjxVIptIXCwBHy0Q4va5UYNWgFH/kzEPF2QqOT6+tuv/fFI2s4u+kaVSX3sUmKYFvt0uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 03:03:09 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 03:03:08 +0000
Message-ID: <0ca3dbc4-e791-404c-8058-2b2c24051f5e@nvidia.com>
Date: Mon, 7 Oct 2024 11:03:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI/HMAT: Move HMAT messages to pr_debug()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Priya Autee <priya.v.autee@intel.com>, linux-acpi@vger.kernel.org
References: <170668982094.318782.2963631284830500182.stgit@dwillia2-xfh.jf.intel.com>
 <CAJZ5v0gTc_FzwkSxPEa7izbDYz6BWqx72TzEXxHGd3MRR8EUFQ@mail.gmail.com>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <CAJZ5v0gTc_FzwkSxPEa7izbDYz6BWqx72TzEXxHGd3MRR8EUFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::11) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbe4755-c403-4f90-8f3b-08dce67c923e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjJXck40dkMxMTRBaUgzU3p3WkJOcjJNa0VraWFJcUNuRk96aHcweVIvVWJw?=
 =?utf-8?B?MkdNRGV5L3JSWllSVlNXeE85STQ0QWtFVDNUQ3c4SmN4SkRTZU1sZ2o1U29l?=
 =?utf-8?B?TnlXLzJsRGwzNmpCd0xQUEdHK3I2aVovcDFnYjIrODNQVE83S21sdWZJQ0FI?=
 =?utf-8?B?R3hQd280ZjU1clI3a0xXb3hjRHhjUTdvMDlldi9lWDBDbzZQbDA3VnBnOTBS?=
 =?utf-8?B?dXF5NkJlYVg5VkkxRGxZcHhmVVRrTG1IZlA0K2UreVdNUUlseWNoakQzM3dp?=
 =?utf-8?B?MzJoWGs2NkJhR1NPVnI2WWoxMVJzQjRUcE51UmlVTStSOTJ4OG1ScTNjZGxI?=
 =?utf-8?B?aXJhdnBuMGZVS3lmUmlaSFZ2MllDY0dxQUtxaGRNTkswOC8xMktTbkJqeEpC?=
 =?utf-8?B?TXpVRWRUdloyN0M1M2RYR0FId3VXNzQrRDhpdnBuMy9ZQjVKV0MyTFJUT2lY?=
 =?utf-8?B?Q1BlU3ExdUV1RWNVQkVSWS9yZnRvU2s5elp4T2dyTTZEYzhYeGhLSWgrcmpD?=
 =?utf-8?B?NWFxaHpabHlrZUo4dnNkU2VoZjAxNGdMSDZOSW43TW10aWk4dnFreWlkNlkx?=
 =?utf-8?B?dmRucjVQQ0ZrZnZyWlFvQ2pHT0FSRTF1dVZ1TXdaZTUwY1RvTUVhTkZ1VG1U?=
 =?utf-8?B?OENlOUdRQjFyZW1lekZyeXFJYVQ0bnNCWGtuRS9CdTBvenNNZkx1V3dPMGt1?=
 =?utf-8?B?clpFckk2WG9IaTNGamMrbG8wc0VjaC9sUTNRc2lmd1BzTzlabmx1S3g3M2ZJ?=
 =?utf-8?B?RHl4MGcvV0VlTEhxd3M0dU1mbEtDbFhxU0Q0alR6M0d0ZVJCYTBuK2p0SmpZ?=
 =?utf-8?B?SmJHdGlkNzRYUTAwcGhKOEl4ZEJtSGFoQytjdzI3bEhrTW1WblBWbkJNRVpz?=
 =?utf-8?B?WTlCTjhWd2hZazZvZDRIUkI5czdXNjArOTkyalI3RXpvN1E3MUEwRElacFVH?=
 =?utf-8?B?Tkt0dTR5UTlmNHFhS0RJeW1RYStscGRCbk1PeU4vMG9ySUtKNEJGdEFKV1Vj?=
 =?utf-8?B?ZjBEQTRHNjF5QXdzeC91N1RFd2hsNUNhNTNXdmcwb0wzRmd4eHBUYmRWRXNT?=
 =?utf-8?B?VlhFbk1zdVdpMWkxZWI0K3dVeHI2cVFpZ2JZRk5LNncvNjBlakN4aTFCTTFj?=
 =?utf-8?B?NnEyZlVNdVpnelFKVlhXUkpTZmtlSU1VZE1wRmdveXNYWVlFbSs0SklZRVY4?=
 =?utf-8?B?V0NsWmwzN0JHY3g3U2FvNmdtNy82cFBvL3IwNStQYlJGT3BveUtUTTZDVWFt?=
 =?utf-8?B?M0xyQ3ZXemhpQkVWKzJXK01CWW9HdmtrQlVndUUwMkpkUnhUemM4a0M2elVO?=
 =?utf-8?B?YUFuOFo5UEVVeFJHTk5HYVUvOHEwZEpjMVRVdGxoc1lXQVpPY25KcmdCemZG?=
 =?utf-8?B?VkV6S1hwNndKcmtlMXBZY3ZZVlNXZFpuaGh2UWxWY3NJMEFPcUdyTVZ4T0Js?=
 =?utf-8?B?SWRGdGQ4L1UzU1J6VUU2WHVXaDJXNFZUY09xbjVFNmNzZ2pjSmp4Qm52VU03?=
 =?utf-8?B?Qk1MRmkwYUIwNUNqWU5tejRBOHY0d3VUYXJpcEJqOUNsd1NkU3hPVE03UzR6?=
 =?utf-8?B?WlZQNUdhQlh0czFTSU9BZzJLQWRndDdWR0M1aG5lODlTMkJ3TXkvaDVSVzRj?=
 =?utf-8?B?VjFXSU9LODJBSmxscWEyV1Nrb0JDR1JYLzd3Zk1HQ3hzWG1FZkNlbzQwT25C?=
 =?utf-8?B?SWZYTlVHNytYdTVZNmdHMkljWnpGcGUvaEgxcnhUVEVFeXIwYnpKMFJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0ZiaTAreWlmK3VkcGw4MGRZYWRXUkdib3FaclhDbzE3ZytCenN0N0RLa3po?=
 =?utf-8?B?YmhBYUk1WnFwWWZNN2s1anRvT2I3UldNLy9lNjhRWmsvYmJpTXZCbkQyeVJM?=
 =?utf-8?B?T0Q0Z2ZaczNyTElsWFVpaHZta1VTdjRFTHFhNTFNZzhoMWJjSDdDd2lSenhX?=
 =?utf-8?B?Umgyb1F6aWw2V3p6Y0VxMmNxemRTRVk3YVFvRlNxbURiVmlYMG9yZDNwRWpC?=
 =?utf-8?B?UGRiRGlBd1RRWGt6ZFVCcGJrOHhoV1ArUG4wbUw2bjExNW45Sk5RaFcreWpU?=
 =?utf-8?B?YjdSWGJKVmMydnBEWS9NSWlVZUpma2tEdGR4a3hncUZOaHZRdWtpd0VYTHUv?=
 =?utf-8?B?Zzl0RGhhK1dTZHN2ak1BVFgxcHlVVVI2ZlFFdTQrYTlvZlhmUjNSZGZNZjJV?=
 =?utf-8?B?cHZ6OWt0RlBGeG1HYlpWalRocGlwMnQzMkw1MkMrUFhFWm51L0hFcmJ0MTFF?=
 =?utf-8?B?RnZQUWxybDN0SmMzK1VFN2dZaUI2d05VemQ0L0NoeENjdWppeGxMRHFrWnNV?=
 =?utf-8?B?T2RMUWc5MEJLaXVGZHhSc1YrczJvTS9jbHpCL0s2amI5NzkxMUdPeFZUNmJi?=
 =?utf-8?B?MVJMUW5Xcm9WL2FiSmlHaEgveXIxSWMzajQvSFg3WHVuSXI0cFVCaFVaTWNZ?=
 =?utf-8?B?eE9ZclVCU0VySno2cHFvY29jT2hTdmdXSmhoSlF5MEgxQ0lXTEF6NW5PQVAx?=
 =?utf-8?B?aXJaUVJXcW1pb2ZlakJkcExyTmc2VlF1am5oUmZMNzVJSUtsVnUrQUJWWnMz?=
 =?utf-8?B?T3l5dnE1Y1UzTXdFRy8vak56U1RnazA5akR3V0JTZzB3SUV3STVyZVhHWGpY?=
 =?utf-8?B?ems1Y1ZPVCtJSjdwN29LUjdiVnRjZ0xyZzk5VzgyV0h2WWl2Y241VlVhVElo?=
 =?utf-8?B?ZWUxUFNkbnFxSUVwNTBIZzZEZzNYTnBqNFIxbFkxZWNCT21maUYwZVZFZWhq?=
 =?utf-8?B?SjYyNE1YbXc2ZFRZTER1QlBmbmtDMEtsS1pVc0x1ZWxLYnpPWjY3bFFOZGth?=
 =?utf-8?B?U0E2ZDhaSllGaWhVSmxYM2swbm9RYVk5VDduckdMRjlqVittaitSTVJsYXlD?=
 =?utf-8?B?aXFhSlhwdklTc3V4dXYrZUo2VHFVU2tVTFZPS0k5cnh0K2lOY0JraXQzaHFD?=
 =?utf-8?B?OVpnUmZmaUp6dGFSMkkyNmIydG9QaHJRcktjclFFckhLSEY3WUZNWlVqSngr?=
 =?utf-8?B?UFM2ZWNrUjZFNmVVU2diQ2w5TFNwb091UnZER1hGc2NFTGtRUkxrTE9wM29R?=
 =?utf-8?B?dUkxb2lsZWNQczMxNHNQSFBwTHFpOWJndG5XRWpScmJUNjVpbUw0bUU3U0Ft?=
 =?utf-8?B?bnowN1VMOG9HYXgwaGlFMmQrWExjWkxDRmNleCtOTStpVlk4MXFGdC9jWnEr?=
 =?utf-8?B?STFTOE5OckNkR0tYbDZGS0RHRzcwT3FncGs5MC9lTzBLaHkyb3lnSmlYVEdQ?=
 =?utf-8?B?VjR5ai9lVWJvMDgwQ1hnSEZtaTU1TW5zS3VmeC9vVHdrcFdObklOaXcranhZ?=
 =?utf-8?B?K1ppWngwM3Fkdjdpem1VYXg2dU5RcnBzZjIxOFJCWnpIajlaaVdnWHJ4NFgy?=
 =?utf-8?B?eE9BUkptZDRzcGV5WG8vL3dsdktVSWZoMmhiRDFsTFBKNVFpYkJsaHNUaVdv?=
 =?utf-8?B?Ulp3MkVva21TYmdLbkcxSnJzdm8zVjl6M0NQbS9BenNLeERoNmlJSHRFeDkr?=
 =?utf-8?B?dDRpWU9KSUFzeGhCU0lYTzlFVGdCcW9sckNGQVZRU0VlUnFBYmNWdG5ONjBn?=
 =?utf-8?B?VGtBYi9TZUV4dkhIYk9rOEtZYlVJc0F2b0FTRGJCdzV0SmVXSkZVVklxSUxw?=
 =?utf-8?B?NStKeTlYRVhHVFV0NkNYRmd2UUhoR3NGSHdNOVVQR3U1Y3BCN0k4VGdtT2hu?=
 =?utf-8?B?Vk5lTjVqaUNpMVRMRnN4ZUxkZjA5LzBKUlU4T1JQVjJmSFJCMXFKdlNKNzg5?=
 =?utf-8?B?Zzdubzk2RjFwTjlkY3p2Y3JWNWI0UUZDUCtUWkc5NGRPT0tJNjNmVGp0dTQ5?=
 =?utf-8?B?MFpaMDZiL0kwdksrL1diOHhrcCtKd1BGc0cvRXhXSGRxcTV2RU9FcHNjK29m?=
 =?utf-8?B?c05jdzg5M3ovWDhEbzUvRnhwYlJkOG9MVUQyYzZDZ2dvM0RSa0pIbGdzclZ5?=
 =?utf-8?Q?zS+RZzhT/FxK7ga7MjfQKfdVh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbe4755-c403-4f90-8f3b-08dce67c923e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 03:03:08.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7d9yfAtmqUD9pWoWU4yiZzCTvr3k5WOLuEvfm1RW44GD9O2bnYoy1mShXxFZIbXty7iuPLxWnrsgVh5zakKAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618

Hi Rafael,

On 2024/1/31 7:54 PM, Rafael J. Wysocki wrote:
> On Wed, Jan 31, 2024 at 9:30 AM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> The HMAT messages printed at boot, beyond being noisy, can also print
>> details for nodes that are not yet enabled. The primary method to
>> consume HMAT details is via sysfs, and the sysfs interface gates what is
>> emitted by whether the node is online or not. Hide the messages by
>> default by moving them from "info" to "debug" log level.
>>
>> Otherwise, these prints are just a pretty-print way to dump the ACPI
>> HMAT table. It has always been the case that post-analysis was required
>> for these messages to map proximity-domains to Linux NUMA nodes, and as
>> Priya points out that analysis also needs to consider whether the
>> proximity domain is marked "enabled" in the SRAT.
>>
>> Reported-by: Priya Autee <priya.v.autee@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This patch doesn't seem to be included in the tree.

Is it possible to pick this up in the your tree? Thanks!

Kai-Heng

> 
>> ---
>>   drivers/acpi/numa/hmat.c |   24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index d6b85f0f6082..5331abc7c956 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -409,9 +409,9 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>>                  return -EINVAL;
>>          }
>>
>> -       pr_info("Locality: Flags:%02x Type:%s Initiator Domains:%u Target Domains:%u Base:%lld\n",
>> -               hmat_loc->flags, hmat_data_type(type), ipds, tpds,
>> -               hmat_loc->entry_base_unit);
>> +       pr_debug("Locality: Flags:%02x Type:%s Initiator Domains:%u Target Domains:%u Base:%lld\n",
>> +                hmat_loc->flags, hmat_data_type(type), ipds, tpds,
>> +                hmat_loc->entry_base_unit);
>>
>>          inits = (u32 *)(hmat_loc + 1);
>>          targs = inits + ipds;
>> @@ -422,9 +422,9 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>>                          value = hmat_normalize(entries[init * tpds + targ],
>>                                                 hmat_loc->entry_base_unit,
>>                                                 type);
>> -                       pr_info("  Initiator-Target[%u-%u]:%u%s\n",
>> -                               inits[init], targs[targ], value,
>> -                               hmat_data_type_suffix(type));
>> +                       pr_debug("  Initiator-Target[%u-%u]:%u%s\n",
>> +                                inits[init], targs[targ], value,
>> +                                hmat_data_type_suffix(type));
>>
>>                          hmat_update_target(targs[targ], inits[init],
>>                                             mem_hier, type, value);
>> @@ -452,9 +452,9 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>>          }
>>
>>          attrs = cache->cache_attributes;
>> -       pr_info("Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
>> -               cache->memory_PD, cache->cache_size, attrs,
>> -               cache->number_of_SMBIOShandles);
>> +       pr_debug("Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
>> +                cache->memory_PD, cache->cache_size, attrs,
>> +                cache->number_of_SMBIOShandles);
>>
>>          target = find_mem_target(cache->memory_PD);
>>          if (!target)
>> @@ -513,9 +513,9 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>>          }
>>
>>          if (hmat_revision == 1)
>> -               pr_info("Memory (%#llx length %#llx) Flags:%04x Processor Domain:%u Memory Domain:%u\n",
>> -                       p->reserved3, p->reserved4, p->flags, p->processor_PD,
>> -                       p->memory_PD);
>> +               pr_debug("Memory (%#llx length %#llx) Flags:%04x Processor Domain:%u Memory Domain:%u\n",
>> +                        p->reserved3, p->reserved4, p->flags, p->processor_PD,
>> +                        p->memory_PD);
>>          else
>>                  pr_info("Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
>>                          p->flags, p->processor_PD, p->memory_PD);
>>


