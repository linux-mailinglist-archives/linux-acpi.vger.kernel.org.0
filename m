Return-Path: <linux-acpi+bounces-18987-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D89C6727C
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 04:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CB7C524167
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 03:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD342F6921;
	Tue, 18 Nov 2025 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t8qys5Hf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A625B31B;
	Tue, 18 Nov 2025 03:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763436705; cv=fail; b=o6w6w1iMsVEwBBBPXJIAUXLmrEOOPyYGzHhzl1CPCP+8gf8ntalHd7lLjf1sekq8gX4yrVceNC52QeEoERYuboNvIDdMmkJRXMSsqarx3XHViesQJdSW5T/NLM90ETQMDUetAJecX0WaPRRWDfWUEQ2wwmVRNLo/yFsTLGB55ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763436705; c=relaxed/simple;
	bh=wuCAPXT4N0Y5TKqGV7ZcPr610Oo9MSM1kzRT1oS3ZiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pk1567aTiavvPYfoQyju+EkBlI4CEwnAiVkvhNoKjfw0EhAxb7nL/NPV71m9IsEWYXNwihnX1TdNE7MvSLUnKwQPHBUHgmtfo4/mLZrLb5NzR4rsWik/vK8a8QJ85qZZ0ol9TWBjzi4LeQ0eCar+dKP2MIR6qk14mIuph8VuOts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t8qys5Hf; arc=fail smtp.client-ip=52.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sucOLfuGKlFKMtLycfjbfsMKucUuuY8/shoU9V2F6QF8MuGFWcBJbfoJ2+dNDsygNqroctA7U/imWQV10kR74Ym3XH0TVaKu/N+wZVMfcdRhuJulzd2J49hb5YLYvluRXz6J9GWydhXHLrMUUGXLstXDYxPNgWQuXg+O/U428kfixgf+nZowyo+z/T4Lfm9AJP35UFk898jXN15iA9ygfTxM6YfcY67EzD9EFSQPp2nwf5P5bCGq+8wwh0z0uUR0biRaLaXpz9osHluuPhsKVW2cRozDvKVuEyGQOdhD7rrQHMXmRTwmsLiMB2C1SvhBMPAgbiTHz7mInLLe/pWs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0hWsrn1qkrj49I21AE/BFCcyrp75IZrHswzziY2mDU=;
 b=s8A1kE3l9J3LhIVdZ2cayfpViUHcaz42Tkx5WJUnwr+wCPnLRwkI8KuN7CdNrXTIM/H7YW2bLonpzc8nC3MJuwzlH9IDirnyhP1bsgFpTvx8GEkyvnIi3BijySTQb4ndXvx/8wKMomBqWpMB0664D4vpipp5sB8vexQPzxy1FiKHGP+xLs9FxVPcuk0YX+IAGM2BFqmxKG1RxrcOP7z6LIbh5hgjlYTT+membzErWMFsMYuE/aX9bl1lI4wHhg3Bt7d6DZ31PmBy+7Ml00P9x3CKYStPDxjoXeAAVvBpMJIx4TkZYMvH8UUX+UM4m5HCaxsPGa7ahQMvRZxpGJbNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0hWsrn1qkrj49I21AE/BFCcyrp75IZrHswzziY2mDU=;
 b=t8qys5HfGIQqNN9GQaYyIHj3bR7U4RsWG+UnKKsL0T+UhsAFCmOTUImwBTCysMSg9Y8D140bon9MfpfCncAwtPJDPL8yTajfOYfkXwoHDWMk4QQ7r+PwuwtIYMyL6gCPapshRfZSVKCHxngj4QdpKnmzkQrhO+TZZ1i+Wckru5RVSTR2DutaI+8PBv6HmFWe7kQNTWYaBQPy5CWLZV7+oheK1UqATug2iZw0PeQuiE6vEchqzclFepne8i58hBkfcuTa3OmozPsDsIg0YhbkiFA0KOIpblzka6m91awTYr6S6e87i/Z7FkN2xCGd2HUfbvssHPYBBIm4HfBFLcU7QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CH1PR12MB9694.namprd12.prod.outlook.com (2603:10b6:610:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 03:31:41 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Tue, 18 Nov 2025
 03:31:41 +0000
Message-ID: <ce66bd87-b7a5-425e-9afc-e92459382397@nvidia.com>
Date: Mon, 17 Nov 2025 19:31:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/34] ACPI / MPAM: Parse the MPAM table
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
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Zeng Heng <zengheng4@huawei.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-10-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251117170014.4113754-10-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CH1PR12MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3c916e-0ebc-4b82-4131-08de2652fd13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDU5NGlTbzNvNm5WZFNTTmYzUFZXNDkwc3ozRkI4RjgvK0xUeWs3RHBWNkMy?=
 =?utf-8?B?R3dEcklldCsyRitEblpmU2hCdHptdUlUWnJmVGNpWnBUdHJwTUlOKzgwaFJJ?=
 =?utf-8?B?KzVkMUhZaGsvR2FQalovZmtrNGVISk9PQmdPNzIxSlY1ZW1tQTJCc1VoZmM5?=
 =?utf-8?B?eEZpaTZDR1hjUldFTGR3bWRHZ2M1MXcwSUZ0TnVvYzh4VVMyYzl2WlBvNEJo?=
 =?utf-8?B?anA2ZEdvOUVWdTZ4MGFPTnJlSnE0UkFLSnZoMklEN1FrUS9vK2xTT1RZMTB0?=
 =?utf-8?B?VDdiK3NYNzVHdytmWmtsSC9ybW1jTHJnUEhoSVljcTVSckRFRmxKMkJidkU0?=
 =?utf-8?B?b0NEelF3SHlmdFl4cG55TEFsell2ZFh5ZThlSlRPSklMK1h4MnVNN3Qrb2Zv?=
 =?utf-8?B?VElRWk5hei9tTk9BRFdIci9JSzd2N1B5VytlYnUxeXFkVkFHZng1UHVieUdj?=
 =?utf-8?B?U05GcXJ4YUtXQ0xqd1VEVHY1NGdEM3hnQ2JXTEJXVWR0VXJLZ3FBajIzeG4v?=
 =?utf-8?B?Rk43NEhKZTA2V3hRMm1zekpBZEo4T08rSzQyTDRyRnBIMm1GVk5BVkJNLzg5?=
 =?utf-8?B?QWJhOUp3UzMrQTJsSWNsMGpLOXVldGI2RTU2aFpDYlkxL3c2ZFZ4K2RObHcz?=
 =?utf-8?B?dGFxaklVZSttd2dJbDd5bTlmTVJCQ2liSGlPM2xabWF3QUhLMS9GTCsveW12?=
 =?utf-8?B?b2JCUTMrVXBHdlNsRnhiaHBNc1hqZHUvVlNZdnUzbTRpNjZkemNNc1UxR3Jp?=
 =?utf-8?B?bXhuS0tleVFMT1I3MExIbEx2aDZGcjhPS3JJZ3l0c3h2QzRQUjZzeEhBK0R5?=
 =?utf-8?B?REhjWmFhTUxyUytKUU1sd0Z3QjVNWXdLMVpzK0JjWVNpSXkrcElzSXpncEtz?=
 =?utf-8?B?ZzJGY2FKOGJhUFJTeGlieko0WlBIUFV0Z2szVVl1eTFxSGJqMGhSMk1oSGlr?=
 =?utf-8?B?VzlDL0hBc0R6Q2FLQU9tWkU5djRrSjBEbzVwMFVyaWxnaURHYmxzTmsxWE0y?=
 =?utf-8?B?ZmVkS0JHQUh5bjBTM2x4cEZyM0FYZ3VaSU9JblpxRzgyMHdTeUNCNHNsU2Fk?=
 =?utf-8?B?YnI2dm0vUm9HSmJKckwyU2NpWS9zWFVKT21FZENBV2JaRGRkYk9MbVBVZHk0?=
 =?utf-8?B?R0x6cFZqUU93SG14QitQTXVTYXlFeHR6NXJaTmJZTkZUN0ZaZ1lqaUxTc2JH?=
 =?utf-8?B?TUN0NHZ6VkRlNkIvREVnUjNOdnF2SFFQQVZVWjJCWUNUY1VaMjVKUm1XNmdN?=
 =?utf-8?B?czViNjdiMmlzSWI0L1JvY3pVVXBZZUUxWEhqd2EwSzNvTnB5M3hBVGRpVTQ2?=
 =?utf-8?B?REE3OEhERlFNWGJUZzE0byt2MHY1NnhFSmFRcW5NZFJOS1VwQ0ZEenpMWjRV?=
 =?utf-8?B?OThyUC9zKzZoV05hUUxVQlM3eVlQanRHQkdqRHc3UHY3dFdCNERyV3lLV0xD?=
 =?utf-8?B?L3NuQU9rbW82MnR4MGtNZG5WeXFzekpSQkd4d2ROd2VTaFI3czlxeGRuc2Rx?=
 =?utf-8?B?TVRtT0hmNmhJbGViZGtJUVVaZmYybkNJTW1JcGh6V2hXZ2ZoNHVRU0I1Z2JE?=
 =?utf-8?B?c2JMYWZEa29Wei82Qmd6WDNCZWdyUE9Rc0Q0YWcwTE5ad0gxUE1RcG9tU3Fk?=
 =?utf-8?B?QnI5MjJzMEJlWmQxdGpmbzBPMTNnc1JOZzlrcHQzc0U4NS9pN0IxTWlCZ3I5?=
 =?utf-8?B?cHcwWURDN3JEemlXTFk5WDhJQ2lHMDU4N3ZyYmJYZStLNC91cE80RUl1aG52?=
 =?utf-8?B?ZVdqSWE2b3ZyODRIVFdYTUtYWFZFU2lEMEtKUnVBV2lzbEFBZkw3dkdGa0lj?=
 =?utf-8?B?TU5nL1FXL2ozU3pFYklBOUhlUGphSUxIdjQyUVZlbHR2dWtqZFAxOWo1OVV5?=
 =?utf-8?B?UFI1NDVwRmIxZnVJUG1HM2MySGV5MHd2VnpZVmdBVFFwc2Vsd3MyZmV0NmFv?=
 =?utf-8?B?ZUJmNzE1MWIwb2lxVnU3cUFEempncFZKZ3kwc0NQSXFIaTJ5QWh4ZGxnWUts?=
 =?utf-8?B?R2JRLzYreEtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2lCenBXMUdnSTIrWWRab3hpSTArY3ZrVDdLZHZuRW42QktkZGsxUkFYKzJ3?=
 =?utf-8?B?aTdzOHBsZ3lvUkJZUHRmai91VEk4cGg2MDdwVG1FT0VwQXlWK1Q1TGVGQnJW?=
 =?utf-8?B?OVJYTTE3em9WT0xCMnVmSHkvSkpyNVN4UWRkRnp4b2RrRUZXTU9PM0ljb3A5?=
 =?utf-8?B?cDJIVmp2a1BqVVNWMXdLZHVyd2QyYXoxbXhQSE91ekhxMzRROURmU2o3OElK?=
 =?utf-8?B?Y295UHdTTVpmc2ZpaGNCcmRZWi9ha1FqeHI3cEdQTlFqdEQxQ0ZBTVQrK1Uz?=
 =?utf-8?B?bThmS05OZ2NyME04bldONVhJK3AxV2gxWGpGbmNnd0NGSWpnRWRCYy9DY01x?=
 =?utf-8?B?ekNXVlg3cXp1M0hSakhaeVMvYnc5S0RIK0ZiY2ROR0I3eDkwcWRQTVRYK25W?=
 =?utf-8?B?MnEvMmEvZ3ZyTldEaW84cmkwMmYvY3dQNmJ2L3ZlVy9manV6WStNd1RUdk1T?=
 =?utf-8?B?K3h0ZzZ6ZlFVT1N4Nk1sVzRDaXBkd3JmTU8vOGlURENVRHo0bnNkZTRXZ1NK?=
 =?utf-8?B?N1R5M3FXcXpFSVJ3d2FXakp3NTBKL1M3Ri9sM0lkcEt1Rk5IejZ1WGczWXov?=
 =?utf-8?B?YWNObUJkVzN2M1BSdWFsaXN4SnhXK2FMSWc5bndwS1gvRVlpdW5vVkxCOXdw?=
 =?utf-8?B?eVptbVZNb1VJK2lqV1E5aW4vQ1FZMk9wOWNVVGtsRk8xNHdOc201N0ZlSlQ4?=
 =?utf-8?B?M1A0Ynp6UVFHYnZDaWx6endkWVkxbWJ4RUJpdEdsbEo5ZlpDL21zU3ZzYkNW?=
 =?utf-8?B?YUxhTG9JOVFWdHJrRSsrazhyUU1sTDFBY2J1VkV3UnhROU5lSjN3QXVDZVZn?=
 =?utf-8?B?elBIOVJzekZBVHl3NkNmbmtnOFpEOENMVzV5UXBUOFlnbWdYVE5VcUhhWXhB?=
 =?utf-8?B?WjFKaHQ0bU5pNm82WG9EeHp2enc3bUFrNkpVcVFYWktKNDJGaTZNcFMvM1Rp?=
 =?utf-8?B?T0JROUpoV3FzQ3ZENG5pQThKdkd2SExFS3ZIMWFpUUNjVDNSS215TVdkczVS?=
 =?utf-8?B?Nm1OUzlnUjlOTjBvN0p3ck8zaEgzbkh0MldmMmVNWkNhbHFxU3VnZDNuV0ts?=
 =?utf-8?B?RWV4RVhOVnZKZC8yM0R2QWNEenp6WVAvVjVGTnY1c21XQTZFU21OdnlhdWJl?=
 =?utf-8?B?ZHo1M2ZXd2pYK2xCM1lYeFExYTB0VGFWU09JeWg2bWJITVlTeG9zU2hKRTJL?=
 =?utf-8?B?bm1oN2xrYWJhZ1AvMlBBdTB2SmxBK0lqK0VwNXZjbk9mUGlwc2trR3g2OUNK?=
 =?utf-8?B?Sko5dVJudjZSb0NWaS80c0FwOEFNWXRCU2UxQWd4Q3RlRlg0UzZtRWxyVTdN?=
 =?utf-8?B?SnhYY2I3YlJzdG1MTUVJeStuMlcweUNQci9FOXhDZTIzVElFdXMrWXFSdldB?=
 =?utf-8?B?MHZPYmhiTnAycHBYTFZvTTNrdmlBcTk1ZmNrRGttcUpJWUxXZ1dBQjNvOE1O?=
 =?utf-8?B?TjcwV1gzckNMYlFlazNmeENJZlI0VFpyRXd3eC9qdGk4RUVSdTFMdmh3Vy9k?=
 =?utf-8?B?VnhLQWp4cUxVU1ZFODU4R3Z3N3NUbVhUcFJHUkRLbDNYaHFEajVjRndZalo5?=
 =?utf-8?B?eU1VNVpmRDlnQzlEZ3NUYmRuSGl4ajRiWDQ0MDVMSmc4dU40dVRDZzdyRVdL?=
 =?utf-8?B?TDU1T2ZhRCt6SlQzejV1cEYwK1FsdjR2bGF6bWFIT1I5ekdBeDBtZjVqb0h2?=
 =?utf-8?B?MEhnRUlZNmMwSnBqUHRPa21Od0dNU3J2emxMNk9HV0JFUERjOG1QUmxLV3pt?=
 =?utf-8?B?STltNDBoeDZrcldacDE5TW5Xc0NMVFdKWm1ULzhsZ1ZvVnd3SDBwUFJSaUp4?=
 =?utf-8?B?UE1PQjJjN0prbjdHd3NsZTkxMkxhN3IxZlNneXN6Sk0yQXlvQldiM3FYK0R4?=
 =?utf-8?B?c2MzUDhCU09wQUlvT0RCcDFVMmpNSHh1Rm5IeEIvRWY4OENtY0tSalBpcllM?=
 =?utf-8?B?NEtpWFJicTJXWWhEZURwNFFQLy9aVlZCTXVsanhCM3hPWDJNVE9KNnBEVWdG?=
 =?utf-8?B?aXlyQ040SU9wQVlBekZmOXl1US9GaUl0Nkpxc1plSysrcHZ4eVBYb0xkN2FV?=
 =?utf-8?B?MkhjU1BPUnQ1N2F1NW1KQWROVmNReWVYa2YrU2JZblAzWjFSVkdtTDhxbzgx?=
 =?utf-8?Q?EJnSiTuJlXxQo6Gc+A1dEZP0t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3c916e-0ebc-4b82-4131-08de2652fd13
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 03:31:40.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNnWVNdq4hyGoEP5qqubWIftl17akfSPkn4KI3SIcDdlU2RkdJ7pbkfVYyMbDjj2nmLu12sitGem6jTwkyQwLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9694



On 11/17/25 08:59, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add code to parse the arm64 specific MPAM table, looking up the cache
> level from the PPTT and feeding the end result into the MPAM driver.
> 
> This happens in two stages. Platform devices are created first for the
> MSC devices. Once the driver probes it calls acpi_mpam_parse_resources()
> to discover the RIS entries the MSC contains.
> 
> For now the MPAM hook mpam_ris_create() is stubbed out, but will update
> the MPAM driver with optional discovered data about the RIS entries.
> 
> CC: Carl Worth <carl@os.amperecomputing.com>
> Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=en
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

