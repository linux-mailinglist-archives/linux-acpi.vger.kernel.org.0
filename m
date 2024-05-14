Return-Path: <linux-acpi+bounces-5800-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20CF8C572E
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 15:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497611F21B24
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730EC154457;
	Tue, 14 May 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FEtXlVNx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F18144D13;
	Tue, 14 May 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715693284; cv=fail; b=BpEyn3owqaQEL1mgD+UkG2AlqH3RxtsDzvrhsHx/suFy8JFPYEbDYyWWJuGJLijKxeA1+AJpO8U9TtrpeCX59Pr7Q3uZYjY54O3p02QBqtV2DjVtzVaxvAoiQh3agcZtbLAH+TxjMKTU3piCE2zdqClCvoXFWHB1niVTMkGjQ/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715693284; c=relaxed/simple;
	bh=3PMmWjM0S6UgSwvWM/NxMP2og/Pvr09CEARMG9hOQ38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WNcfe7eoiZSaBF9+RedE/rB3XtJeO9nvQsC2rqtiu/+9Us2axcDtYTNegllviQXBN/hJ7yHAX2eFN9C3XxB/aN8quQrBlneB82nVHsKz7gtVfKt4SV6yIRfkPJWAxNXI5CVerlaAPC96SfHwBe6fL+ZMrnvLl9DCAymSRGCf6DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FEtXlVNx; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPsAlP0nNEgb2Odxht6M2TaJHJaLehW19s+Lwd/lYBm18jCsXh1yRPIi9X6x+mni5mw6KHFQ37MgPV+u0cVLibHg7Gg+2B9lyS+0WP9PdK4BVMXso2jP065YZvpaK+8GgXSipLC/VANvUZsNmdiDRivL8kwldWwLx9JEuZduvUWi3EJxosJuTWiHT8cTs8KVjIl8GkWmenIXRGlg/65H640fzgh9cKfWXDmFVSkVhVr7EDf4AmQlWlVnQWXWDcHyBCWMpnLDxTD2Aj0k0fCImjdla3mRLvYtaGhZRX9DleD3giFlU+weTzoQVDZKqueo80p9qsSRJ7MCPQA+zVW+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCtd4seUrq09FFkR0fo+X2oxO3pCOUJiBqsnXhj3DUw=;
 b=oW2ouUzqpTOAXv+CG73sZNZAFpFstXGU0WEwhrO3J6uLVyCpmUG54gSVME4NSgFg+ZnVU/5bYgp6hhxcFZa1dZIewZs4b0RW3F//cnz77aKN+Id9hVlZSoXXlW8MbS6GfHrvOYKsmCfdj1o/lQn6jxrtdlS0pRQPUOafQz8DElEd2O9f4M4FtFK1eTCJ2mOS/MtTdvqOYPjj3CkGSUFuayE76bz2N3C2GSK+str2MTBI2NnydP+ce7GDsfboL9RT/GaezS0gDzFceUrtIaQHghQ/VB2zm+lpqcO/z+WLoc+FcjEPd8hhB7ULANT2U5/OX8/m3kCEhov7wra6Dw7DSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCtd4seUrq09FFkR0fo+X2oxO3pCOUJiBqsnXhj3DUw=;
 b=FEtXlVNx/Oqe0fZlzDFbDc7N59JyzldNcGDG1cafq7aFEhBiIyWqBi1F9olAZcbOS6wFtvIZ39clUnSb5VmnijRBoNItVdapTmi+4G4qFnyaahuo6enG5cPjKDW3/K3WcHpbcVHrogDNiDvDg+qbadQBsFdgmoAkCoCsH1GWn8SO/Iqtzxtk2TS9E7RQ4B4WLRyPrG+dYBx0IwOSz9N9qit9GbIM0Pf0TR+tP8Y87xOJX8LJDrbdR31FMEPJj1b2e10u03JQ4etn4N2QxP2C1bVZm6X1u4NGSSWOMNMYXefeUu9l65b3wCvCCEETo9vpMfOCZ3I8RjhjYG2w67BA1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 13:27:50 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 13:27:50 +0000
Message-ID: <243d441d-dda8-442a-a495-83bf9725a14c@nvidia.com>
Date: Tue, 14 May 2024 14:27:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] iommu/dma: Make limit checks self-contained
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1713523152.git.robin.murphy@arm.com>
 <e28a114243d1e79eb3609aded034f8529521333f.1713523152.git.robin.murphy@arm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <e28a114243d1e79eb3609aded034f8529521333f.1713523152.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0366.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::18) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f75e6c8-828a-4123-e235-08dc7419a6df
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUlHRzExdEVIRGp3OTAzS09vT3R1K2V1Q1ZwL21FSHorajFRTHNidWxCNGcv?=
 =?utf-8?B?bUpDci9DSEZFQlVMUFphbHpQYXFRUWhHNWlKY1NMUlNEcHZGbGZkM2VFdmxz?=
 =?utf-8?B?V21QeTk1YTdNYmorT2x5bG5NeEVDU1lLaW1LTzVPb0VtRXREcXo5NEJrMDR1?=
 =?utf-8?B?YzE2QWhsYUpPVjQxNDVrdFZKN0tuTE5TN2hvVWtvdkJoRDZ4Q1M0RUJ1UVRt?=
 =?utf-8?B?MnZNVlhDQnROZFZKRk1ZWXBVL1BleWZCN0dpY1BKSlNlN080R1NieDZhQ1FQ?=
 =?utf-8?B?STZGN2tUQVg1UzlRNkxxL1EvajhET2daUFZiSTBXTTBpUTJuVFdsRTMySkUv?=
 =?utf-8?B?T2lCamFkRlo4dElKRkdHbU9yNGZYdG1rcDVQL05aWDFLUmFGcTVYVml2andn?=
 =?utf-8?B?a3NNczVyU0F1NXpBNGRrdUY4Q1FOaTd3V0xuV0ZpZFJtSFppdDE1RDdtZXk5?=
 =?utf-8?B?MXE5anZzdWhQZzBwOUtndWNCU1FHM251ditTU2swelRjeWRHcEN0Uk1NNkVH?=
 =?utf-8?B?c0w3eXQ1SXdIQmVyOHhjcWFyOTNFdVpRZDREakpXclRyVVVObzJmdTlPUGtm?=
 =?utf-8?B?NXo2c2xhdXhrWEd0UEdHVjdVQXBiN1I0RnBWNWRwVGNuYnZGRUlEYnBBUDVQ?=
 =?utf-8?B?MkV1Tll5TlRKQ3ZTcnU5S2Nod3pGUjBXSW5mcVdNNHFQMEd4VERSK0lqVUdZ?=
 =?utf-8?B?K2xjbVpQSUNHcDhEZzJ4R3ZLaWRWL3JhNy9YUmNMdGtIdTJJMnZCSDNIZ3Za?=
 =?utf-8?B?Z0Z2QnlCTXlkczV6dTNoZVZrY0VLd2VSK1JxaEFCRzgyTnFZMWtuTG5JY2tK?=
 =?utf-8?B?RDZPdEV3MkkwT1VscVRsWHBaVytCQzZkQ3NFMkY3b3VlVzNJZzViTlFwWXBn?=
 =?utf-8?B?aGN0UTdVWm1jYjNQRlBwSzQxSUl1eDYwMGxBQ0o4VGp5Ly92MGtyc0tjSnlz?=
 =?utf-8?B?K2ZkZzUxSGgrTG0yS1RDL0JVSmVheHExaWttekM1VW5IUDFobnVtYjBvb0tU?=
 =?utf-8?B?ay9HRlNKNWxQSFMvNkZhRTF0U0pHR0VzWFM0bnB3cm5RelkwK0VSa1BnNVN0?=
 =?utf-8?B?WDZtT1JoK0lHWmphRmJSOU1lZHR3NmJNTFdOcmNjTkxtVEl6UjV0VGkwYzg0?=
 =?utf-8?B?YlFiVXVOOU1vOUxodWd2RFlISmNXODBKUHNvelBYMVEwUmg2NUYzVUZ6cys4?=
 =?utf-8?B?cWRQdFBTZlB4QkoyS0R0N2pXT3FtdjFlcWV2RERyTFA0K29BbGd2eU1LNlRP?=
 =?utf-8?B?WjlMektmb2VCNGlZT01rQ2I2eEZjTElTUVFXWVl3eHpXRGQ1dTlhZndJT1FZ?=
 =?utf-8?B?bDZGcVBLVzRsbVEvYzN2QWxsejBTS1AzU2tuNjkzenE3TWFVaUlyUm1RTFJp?=
 =?utf-8?B?WmErQ1V0R3FNT25pL2dQRHIvQzZNVEwzMGR1UnRZSGV1UzRFY00xczZ3bTk0?=
 =?utf-8?B?cUl5L056NjZWa2tzK2FNVW5JYTNwbS9lb3BHMGVDT28weEY1cXVta3ZIOHdI?=
 =?utf-8?B?UFhkNkIrdE40bkE5UEVIMGJyZHMrQ3RtU213STY5WXNXN2xCU0ZYZ0dVN2s1?=
 =?utf-8?B?S2JGd3A5aFYvZURYTkdTRmFLZkozUW1JTDk4eUU0aEptUG5KNzdxUlB6dzhJ?=
 =?utf-8?B?Q0dCNkdKMUhtdnJtaDRiSVpTZWlEZEZCaTBqYkdla0VrbjVENTI0QTJxcWxF?=
 =?utf-8?B?bHJTWk5nT1pJcWJ4Ty9CaktzY3hUeU9TMVUvVHV5WEJwM3FsQ2FLZ2tnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3FjeUhXVWxLaFUxT25sRWx6UlpmUHFkdjByVnY1SGovTFNsU3RrSlVhTys5?=
 =?utf-8?B?cEpWMkhZbzNBRzlEc3JnTFAxcFRNWHEwdGJVUjdWVkRWbTlkRm9Mb05FSzJT?=
 =?utf-8?B?K29Pek9tYXF2aDhyMS84cUlxZThsd2xzcy8yc29QbnR6NXBVL3RRVFpSNmNT?=
 =?utf-8?B?bTJHVXVqV1RtWXMxSEovcndocElIbVJWd0wrbHZoREFvZklnYjJuMDJXaGty?=
 =?utf-8?B?dW5rUmVPRzZleVFPbUppK3luRVZnUk4wOTlhaUtJaUdIb21EdzQ2YjBsYTU3?=
 =?utf-8?B?QjB3ekkwS2Z2SXZteHBManBpVi9zcERiUTA4MWtSeTVQcEtwakt4cmpCWTUx?=
 =?utf-8?B?ak5JVTNsTnY2N2t1bFFwSXdUMDAxeE1GUWdSSmVTcWQ1N2ViSHZVNTF2V05V?=
 =?utf-8?B?OEt5V2dFc1MzUkZuUUxSYkFlZkxYajZyQ2pxY0lLL3NJMDRYTms2b2JGQnBj?=
 =?utf-8?B?clBtdE5wR2NvckZaUDY2Y1lBVG45WGYyd3hLN0JTQnlZdklBZDFKbnZzQ3JI?=
 =?utf-8?B?QUREeFhhTVBGeEg1elRqTlBXUkR5SWpjSll5MnY3RW5NME1Uc1RYN1JQTVFP?=
 =?utf-8?B?Sy9lRVVRRWsveGtDb0dvSS9Eak5zOVMwb0wrTEwrSGwzK0hTa0k0dDZYRGEx?=
 =?utf-8?B?WWdod0tYdGg1RzhmaFVKZDF2NVpMalBZU0VLN2hyejIrMTZ5RndqdXE5dHJD?=
 =?utf-8?B?eXkzaEEranYzbVE1aGFWZktQbnc1Q0cxWXNTdTMwOGo5UkZLSDAxTklPaHRL?=
 =?utf-8?B?QjdUY0JBc3hZRndkZDJKK1h2WFFmMThtcDVuL2poNlVFMHYzVVk5aWdwN3Z2?=
 =?utf-8?B?T2MyS09Zd1BXVlY1UWFaRzdUVTZ3UXNqbTluV0FzYmVHWmgyeXVRUEVxNFdF?=
 =?utf-8?B?U2pBQ2tUQXhxL1lxMlBIdkg3dnA1U1VQbEJYNTA4OTV4YTNIaW1oZ2NTSjNT?=
 =?utf-8?B?cG56U3RXQnk5R2ttQ0VKQXBuekdja04yM0YxSkRpaFZCMkdMZGR0b2paY2RQ?=
 =?utf-8?B?alM1T3RIdVk2VWV3RTZzYTlyWE5tQXUzOEVCSFY0Wm5jWWdBcUZSRVF2QWRo?=
 =?utf-8?B?eFUyaWlsMTlMQ2FEb2dzYXZUOHpqa01aTmo5eklPdks2WUFKSkk0SUpiSUFv?=
 =?utf-8?B?eXMyWTJHZ2c5cVBBR0xsMDIzejltdTVMYWloQXVRYlNsWDhwNGUzeVpVby9M?=
 =?utf-8?B?T1Y1MkJFYnhqbGhRUndqR2dDZHFTRksxMnVreHN1ZWhVMWlNVnhOaFRrWU5O?=
 =?utf-8?B?eGE4UzFxZ08rMExDOEIwWDhxek9ackxTUEhZWVl5VGU2Ukl4eXNScWkyMkpv?=
 =?utf-8?B?UUZhTTFxc2hBaDJnRDhLREVkMExEanJVWDBFM3lBelhwSGxEMGVQd1ZMVEF4?=
 =?utf-8?B?TlF5ekIvRDRpQWd2SlJMclBPQlgrQlcrNHJoTm9qaUQzZ2ordFhwSzBqT1Bi?=
 =?utf-8?B?Zmk0b0RPQjU1RzNFVVl6d1ljNFc4QU5yaXhSQnYwL05lZTRwNzZWUElrTmwv?=
 =?utf-8?B?R1VTbDlaZE5HZ1c1MFZqSFFLbDhsSUJmb2t4Zy9CRFBTMUtvTC9ib3F0SmpT?=
 =?utf-8?B?RklXRkVkQ0ZiL3JWdjl4NkNERzJCQ3FSZTRUQ2daVmFyOXFqU3Y4SFpmYUpK?=
 =?utf-8?B?cHdFSnk3YnhlWGYyTnJTa3J2S2diRjg1RmRQV1YxZk5jVTZsT3AyZDZvR3ls?=
 =?utf-8?B?Q1hldHI3L0M1WUkzU3dvYU9PeXB4d24vbHVCdVRkb21iNlU1Zm1oSEJGU3JD?=
 =?utf-8?B?RElkUXpZTFM1V0Rzb0FEUUsvQjk4U2FXd0J3OXM3R3FRTW1XNHVHcTIvQ1E5?=
 =?utf-8?B?Q2FPRlZhSVRiaDhlMUhvZjBGdlpmMXZsN2R3VEJiZkw2Nnd0V3U5Qi9Ud1Fo?=
 =?utf-8?B?Vzg2cnBZYUtOdTExUjE1eVhBalhUZktYZzJrdkVKUzhSbzlWNmNEVjdSQ3l2?=
 =?utf-8?B?U2JsaGJFRGRBOWtSaEhWTjVRTkZVMWFhdi9Uandnc3NHN21QWCtZb0gramMy?=
 =?utf-8?B?SDVyamErZHVRMHNSMEpWOHZmNnp2amZxTUp2YVljNTdxSUlpSjhaMUF1YVY0?=
 =?utf-8?B?MTQrWmwyNmpTeW50WGdlWUp6b2lzMkcvMUp3QnpoajR2TC9ZTEJIbDZFTmxF?=
 =?utf-8?B?dmoxeVNuOStFKzJORDNnL1FFeTE1WVRTa0NqRTArZE5jU1RPNFBIY01vUzBn?=
 =?utf-8?Q?fNWL8UmtF1qRKCWRm7pc0CCVv/uNiqt1HfWb8O1KDrG3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f75e6c8-828a-4123-e235-08dc7419a6df
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 13:27:50.4553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0e3O+hvCPaXWn7VYGd/QFPOCPxXqsCPEtxj0fEsswS1JcmA2gg/Ca5MLwprsVxJ9hyzrVP/TImGhX5DCPcc6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595

Hi Robin,

On 19/04/2024 17:54, Robin Murphy wrote:
> It's now easy to retrieve the device's DMA limits if we want to check
> them against the domain aperture, so do that ourselves instead of
> relying on them being passed through the callchain.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/dma-iommu.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index a3039005b696..f542eabaefa4 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -660,19 +660,16 @@ static void iommu_dma_init_options(struct iommu_dma_options *options,
>   /**
>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> - * @base: IOVA at which the mappable address space starts
> - * @limit: Last address of the IOVA space
>    * @dev: Device the domain is being initialised for
>    *
> - * @base and @limit + 1 should be exact multiples of IOMMU page granularity to
> - * avoid rounding surprises. If necessary, we reserve the page at address 0
> + * If the geometry and dma_range_map include address 0, we reserve that page
>    * to ensure it is an invalid IOVA. It is safe to reinitialise a domain, but
>    * any change which could make prior IOVAs invalid will fail.
>    */
> -static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> -				 dma_addr_t limit, struct device *dev)
> +static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev)
>   {
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	const struct bus_dma_region *map = dev->dma_range_map;
>   	unsigned long order, base_pfn;
>   	struct iova_domain *iovad;
>   	int ret;
> @@ -684,18 +681,18 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   
>   	/* Use the smallest supported page size for IOVA granularity */
>   	order = __ffs(domain->pgsize_bitmap);
> -	base_pfn = max_t(unsigned long, 1, base >> order);
> +	base_pfn = 1;
>   
>   	/* Check the domain allows at least some access to the device... */
> -	if (domain->geometry.force_aperture) {
> +	if (map) {
> +		dma_addr_t base = dma_range_map_min(map);
>   		if (base > domain->geometry.aperture_end ||
> -		    limit < domain->geometry.aperture_start) {
> +		    dma_range_map_max(map) < domain->geometry.aperture_start) {
>   			pr_warn("specified DMA range outside IOMMU capability\n");
>   			return -EFAULT;
>   		}
>   		/* ...then finally give it a kicking to make sure it fits */
> -		base_pfn = max_t(unsigned long, base_pfn,
> -				domain->geometry.aperture_start >> order);
> +		base_pfn = max(base, domain->geometry.aperture_start) >> order;
>   	}
>   
>   	/* start_pfn is always nonzero for an already-initialised domain */
> @@ -1760,7 +1757,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>   	 * underlying IOMMU driver needs to support via the dma-iommu layer.
>   	 */
>   	if (iommu_is_dma_domain(domain)) {
> -		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
> +		if (iommu_dma_init_domain(domain, dev))
>   			goto out_err;
>   		dev->dma_ops = &iommu_dma_ops;
>   	}


I have noticed some random test failures on Tegra186 and Tegra194 and 
bisect is pointing to this commit. Reverting this along with the various 
dependencies does fix the problem. On Tegra186 CPU hotplug is failing 
and on Tegra194 suspend is failing. Unfortunately, on neither platform 
do I see any particular crash but the boards hang somewhere.

If you have any ideas on things we can try let me know.

Cheers
Jon

-- 
nvpublic

