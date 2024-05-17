Return-Path: <linux-acpi+bounces-5882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD418C87FF
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2024 16:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE8728788F
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2024 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809A35D49A;
	Fri, 17 May 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sBj7ZTZP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F095A4FF;
	Fri, 17 May 2024 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955735; cv=fail; b=H2jRhq43XINhD+MPWPZl63IwmYV90b+w87rSnGN3kxEIK32uObAF3QwoxFY+t3rm3T1hi3P2E+vmysZ/HvCaKSwnrHyOxGn5QvxwX+9CjxWlBzVmtr02yAiL9vFSC1WjrwahatElNAg07sKJV0HbchAtgkbg7taxcZapJxMnEto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955735; c=relaxed/simple;
	bh=fngU33ByadEJddW0Rr+lLUnV4GRikISaTjxK0S/7SUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eRJ5FGd57rGa8j+j7UMUkVglSv+FrrjHK2H9pTlHQB/fip3WkZ2lNuk2aXYLhvkizQZ3N2Xb3JX4SsXeDN3SwCDa0PgJfKOSdeT4tkLAwzAN76douMv+oSOgGJG/Fnf4TqCfO1eRmT9x+FkyecYc3AMHhFM7AlfuDpsRx5WKa2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sBj7ZTZP; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpbvozE0ELskSbesDC0MOlJExfFWQV2JpDF05shnGo/UJ9rs5iXMooazGTbcu8Mc0+JNl+OJgEG00F66TgP5E1JASgCGmOr3J9dgWRuPikwHP/6PtWHJkwWfpqc+urXNJCsMb4fcQJfGe3YN7Q7qUUYX3VHoFmAypjVQ8cV2iRttlCy2VPHT8dDg262TkjA3t+xkeC1dr9RkIIxJ9v06G0qRte6yJfqSgbUMmrdid83LJGYlC7zzS9dD5+XzAUg9924Wn/aF/kSjs1f0I6upGJeSVdF48q8R+VyHSsR3sFh9ZyX8fmj6Iyp5cw4H2fvH5l5BK+ma/nDKW/EowlRROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSwiecNenrwCJM+14oaiUEsegyXYBBWrRQs6Vc1QA58=;
 b=OcfeVPv6kpr1fz3zshVTaYTmWAuqSxvGMtlYx2NBm5KBEvz0ZtJwoyHRDUVChSnP9f8OapaY97HbOS5AyDisRQKEauda3lkksJ7rwkDvuhVFxS8g+9wkq/qUHeHVApYkn/KHAj4ZDw61BaMMC1dmRA5jnq6EizKSbuVgb3U7iFxVWzwZBMWkfdWOhqhahGED35YEHIOaJNECLVw70xfijag9zBA7k8t4W4x0xPj7Dus9FxybW2MAzJhnqAaaWFmu9k8xd38TqY8miLW5RUbL6jXim+fRytXsS7KXCmmZDER8/yg5CnonViheRB9JRV2aSBNly5x3TJKMxBy8iQOlxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSwiecNenrwCJM+14oaiUEsegyXYBBWrRQs6Vc1QA58=;
 b=sBj7ZTZPwh2Uq/YdH8MpEjBx60snF7o4XsSgpjgacp037Sau3tQB/5adH2HF5YQIfL+OrZUKoNj9N52hmoTPS2fL7bQfl0IFn82MM2BbQyNaPkQtvOm825oru54prXNCvFGf+r4Ximn6/O173yfucvwVyPm0weCCsZU6WK9gDJF4tSWUjslWya3VjBMfBwy4aNFYMYuEcmSVd/gLR72LxiDK3HZbP9Q+9pfvKOmP9tBEq4N3ebgzxRAIOHUt1RD5ww34w4Aw5xaYJ6iHte+01q1EVUa1SX9FgAYolPEUgRImSuoegZf+UcbnNUbBgxw/uZKdnK/kp2uixiWgy1FA4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.28; Fri, 17 May 2024 14:22:04 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7587.025; Fri, 17 May 2024
 14:22:03 +0000
Message-ID: <46fc1b7f-7d10-4233-b089-aa173ad3bbeb@nvidia.com>
Date: Fri, 17 May 2024 15:21:53 +0100
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
 <243d441d-dda8-442a-a495-83bf9725a14c@nvidia.com>
 <48c39306-c226-4e7f-a013-d679ca80157e@arm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <48c39306-c226-4e7f-a013-d679ca80157e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0239.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::35) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2fe087-47ad-4123-2145-08dc767cb8ea
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NThEUTNCU25mcDNkS0hNaDBBbS8zYzh3ZXlMRVB0STUzb2VOR0tTOHo0VEp4?=
 =?utf-8?B?L29ocFQ0R0d3cHlhRzMzVVEwYlVwdFBQS0lYNEUvWEU0R25tT0xvNzVCcysv?=
 =?utf-8?B?WkNmeEtvQVNUdFZLRkJnbnJBZ1VIYUVCRGRHT1VTcmRUY3orZGdtMjdNOGN3?=
 =?utf-8?B?UE5lZUgrblY1N3RmeHk2aGlaR1VuakZ6TFZtWUJLQU1PVFJSbWtSQk0ySmFH?=
 =?utf-8?B?WnNIbWh4LzdWaTVHWVVTYkVud09OWHYzRkJwdW1rWndJdUlWeGFicHA0OVo2?=
 =?utf-8?B?YzhXdnQ0K2RQbjBKaDcxYUtOS01wQWV3alpOV0xRNkkxREs5M3E0dk9kYjJR?=
 =?utf-8?B?YXNrVUU2ZVVpS0JJVmV4bkNPRk5KZXhabXRyUXpnSEY4b0hneHJLN29RczA1?=
 =?utf-8?B?aDBEaVZUWFQ3NWd0OVg4THIyVFFWT2hXak45WEhzRngyeWc0STQrRGNLbU9w?=
 =?utf-8?B?ejNjNUFhWG9FWjhXR1NyaFd3L3c0UklyZW9MekpIL3FGWmRBNEdkeVBYN2Fv?=
 =?utf-8?B?QWVVOWFtYmpUUjJ1Q1dRaEFIcDF1aWRKZUVsWmxoVzN4bFpVa1B3YmlUWi92?=
 =?utf-8?B?SkhmWnEzbjFZRmZuUnFDTHRDb01KSUkzYkNLUzEvbFYwNWpObnRwV1pMTUY5?=
 =?utf-8?B?dE9xSHc5TUtIOEo0TmpFUEdmWlc3RGtMWXFpOEppeThrMURMNVgwYjZpZTVm?=
 =?utf-8?B?WElOdUVYZXF6a3ErRllZR1hQUUR2V3VPbjY5aTJrNFQySGs3c3JsVHU2ZWov?=
 =?utf-8?B?OUdhaTluOXJEUWdEV3VpclVsYi9hNUVtODRPZmU2TDZyTEVXOW14QTVmc2hZ?=
 =?utf-8?B?VHZTTVZLMnVhd3dxdE1qVjBmbWpyWEprblJrV0pHbGpheUxUYWY2RUdrazFV?=
 =?utf-8?B?ZzN1ZklzWlpBYXpCcHhEOG1vTGNGa2Zab2RsUElrSUowc1haS2NoUjBrUFNE?=
 =?utf-8?B?SlhlSnVmQkJGZWVmTVZJZHdpeWNRV2lrSnljUDRJVjAzRUQ5eGxGTjRxR1VT?=
 =?utf-8?B?b3dpSFljbk1hemxlZmV1K2tITzFIVDhWNzFTUlp3MTliN0Q1NUs3Ym5rNHp6?=
 =?utf-8?B?WlRzNlJ1OGw4N0NZTTJERlRLSjRCc012TFdiRGRLb2JSRmRjRU1xSzV4Nkxu?=
 =?utf-8?B?SkFRWGxqdHBkeC92dEhjbjkrQi9DTVBmSmxKYVpWS0lHUWtOUTlIdS9sWmo0?=
 =?utf-8?B?MUxzakFkbTBJTE9BMDNOUEd3T2cxVnM3citQVnZxZTVNTlZ1VW1FUEFyRXVq?=
 =?utf-8?B?cFNVaWQ2RytoL3FiTHJZd3FsYThoeFMya280WkxTbWJCcHY4ek9ZSG10TXJr?=
 =?utf-8?B?U2lnOXZFTTZ2SFpxc1lFM1AzSDYvQTVsbXFTZEhKK0NGQTJPdXhuSWJuYUdC?=
 =?utf-8?B?ZTFNREdxZkh6emovOXhkNnNMNE5YWG5QRkV3L28xOUxqYVo3NWNhRGJCaXFt?=
 =?utf-8?B?VEthY3lYejJBeHh2TmdIN3ZQSE9SUDJxalEwK2VnM2ErOC9hdDNxOW83dVFy?=
 =?utf-8?B?VE1MNmJaTmtrTmJpdDBtakJDR0FrNUg2NHN0dVNtY3ozd1l2VmxkZWZNK2tz?=
 =?utf-8?B?dklQZHYxQStXN2hYcWcwSGV5Rmw0L0ZSbXh5RFdRSWlNdmsyUjFQTHhYVVo0?=
 =?utf-8?B?bWFzUnJHQXVSb29LalNqOWNzdzFTemJOQ2FLVDFJNmxmZkdoV2hPd0hKaHJX?=
 =?utf-8?B?QW4xK1Y4dWJsd2JpanpmRGJqempNMDUvMVpSUHc4MnNaQ2ZCVUV4UUNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0twRGo2NStGRWxROStYVi9TYlZLeU5DZmJBYVR2T0pyS3BBWTlCR2hmRjZx?=
 =?utf-8?B?SkgyaVNpSXBWNjRVdldBZDBYQyttRjlNVmVOYnZCZ1JkdzBvZ3h6Z1FBdzdI?=
 =?utf-8?B?ZjFFODlsT055WTZKR1JmY1BnRGs1Q245NnlBVTB6d3B1elZaVVJFNU53RXN1?=
 =?utf-8?B?ZlVYV3JlaEtGYXhHOTUyQW9BQVFNK2dYbG1jSjJFaFMyZVRMTEtDNmwveC9D?=
 =?utf-8?B?dm9tZHZYRnVZQkNWcDhPQ1FYeDF6akxvblVVZTF4YTBsRDQ4Sy9lSDVkQzMy?=
 =?utf-8?B?ZUxKSmlFaEwvQm96MldiblBGbFdlUWNid1ZxYTJaNmgyTGNGZy9zVG1wYW5j?=
 =?utf-8?B?bGJ5RTd1NmRuUGJVYUxYaU8yREdLd2hVMXlQaDhmWDcwQ3RTRi9reHEwYXJl?=
 =?utf-8?B?aWIxcVh0aXBCQXhlKy9nK1BieVF2NTduV2dlTngrdGtrWWFQSVVSWC93bk9R?=
 =?utf-8?B?M2pKZGRCblllZEhSQ3d4U2llK2tUSSs1MjV4bVY3RGRQeVIxUUhmOERlR0dF?=
 =?utf-8?B?eldnbXR5LzBmM21hVjBTc1ZvR3F2elpKQjRYRUNTMnRpbDFDalJhcHlwZGc1?=
 =?utf-8?B?dEo5SytxNFhPYmZLaGRZdndtTEVSV2p5Y0p3cU1ZZkhXVERuNmFkbDB4Q2FV?=
 =?utf-8?B?d0ZtbmNpSmtWY09Ib1RRWTVmS1U2S3NzMmZEWGNlZUZ5UmNxenZPVWNPYlpJ?=
 =?utf-8?B?c0hzeTdjUFRESnJQYkdBQi9xK3l2YzdEb240Zk9XUU5LblRXQVZETGVQVFVI?=
 =?utf-8?B?ZDdoU2lwUUxnYWRyZXFSODAyVUM1dWkxSUh0YmdOcnFNMElXT2dXbE1TbStQ?=
 =?utf-8?B?VWJvd0RNN2JzVy9EREtjTXFHRUNLWUxDeVRtTXFaaFh5VUhZNGxHOXcyN2xP?=
 =?utf-8?B?b0YxaFVYMy9ERzNXaHcrckt5NmRaT1ZyRDNnSjVJMjRaeVNYZFhKbWtFMlFT?=
 =?utf-8?B?SE5wUURKWDVlMmxLazQwSGI2RGVBWUJHcnFTekEza3lCbjRPMEdSSWQ5dzYx?=
 =?utf-8?B?dklDTmI4b0JrZXBodFF4Tmp3cXJKTHlXSE1wTm5xcVRqTTllaTZidHpRNGtQ?=
 =?utf-8?B?dU9ZUXdvaHdoejgxWWtOQThiMEJZMWowYWN0M1JFSWxVTEFqR3QvOFBhV0p3?=
 =?utf-8?B?cjAxTjlQQ3ZJYXltMWFlY1BkTWllVkVMR1pQaEJDcUxycmpwVlVacmI2bU9x?=
 =?utf-8?B?VmU3WHkxdWtTSEl5NXpxdjYrc3E2QkhDZkdPZUJMbWgvKzR6ZVB0R1NoQ2JK?=
 =?utf-8?B?SGJselRUYkhJU1pCSjNqK3I3R0hUWEVTQXdTZnlRcnk5VGE3WE1WZGFFOHpU?=
 =?utf-8?B?RkFpNnlMNmRsVlpnQlRVNW1kcEY5NVFQL2FJWEhuWDVTSWtMUkU1N1Zjd1VL?=
 =?utf-8?B?Ty9HZnJwR2F3R3lwWUJ6dHdBN2RyMm5xK3NkcTkzVFVjRWU4R2tMK2hONXBp?=
 =?utf-8?B?NE8rSjZsTWNIVGp4OWNzUFJrd3krczNwazdTaTRLM2lTdHg0ZURaYk9PRzR2?=
 =?utf-8?B?MDZiSC9kejlFOHFJbWFnV1dJTC9OY1hwUGlJWGNTMjBUa0VyeENkYURLRkI3?=
 =?utf-8?B?SFF3emVuZnpHZzNnZlgyYUQzWFIxazJnbjBsK3pkZTBJZjRnTm02dXJGc0Mw?=
 =?utf-8?B?SzM5Qng3eVl0b2ZaU3dNUWRqWWQ0SUw5NENXK1RWWkJkbUdrNk9HRTRISG5D?=
 =?utf-8?B?aDRraHVtd0lkeXF4MElZcDVXMHdUdWpMT1ozUkhCZnRaMmlHYjB4NG5HdkZx?=
 =?utf-8?B?M3N5YU5EYk4xNkdqY3BQa2J5bklOREpOQWJQb0pYZzdGLzROT3E1MlFhWlJs?=
 =?utf-8?B?ZE0wNDg1NEJra1A1b1FOOGcwME9UdDIvTW9GYUN3bmUyVitDWXkrViszMlh5?=
 =?utf-8?B?R2RvWUlkZENHaExKa3F6MndvQ0U2RllqRk1OekQ0V3o5SlEraDIxeDB0dkVG?=
 =?utf-8?B?bUNoYTg5MEIrMmJTRmlOYlRaMXYzcUl3eVp4RWZqSHdFWGkvcGdJdmxnd004?=
 =?utf-8?B?VTZEeHB5ZzBQSWIrR1EzTFdqRkRVMWZBdktzblVSL0llUi9CemN3N3ZUQ0pv?=
 =?utf-8?B?WlJqbVBVQmNHSFhmYjNnYmVnR1owNlRHRlRWR2JGbFZjSXpvZURaeXRqaXRQ?=
 =?utf-8?B?VjJLKzNkS201V0RGdDRmVUdJbmpzb1lJR21adkJDZk1TbXp0Yk9DQndXSG51?=
 =?utf-8?Q?nFuy7lHs3rtqV/ZU0u/N3K/yqWe/3T3TxtZK2OuLlX0c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2fe087-47ad-4123-2145-08dc767cb8ea
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 14:22:03.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qHOxsocpjzqQdfyKEHK1r/qnI0+EjvXnOXsSoWb0FKto1uCk1C9ERBcYjic4e8fBdHZ4r9wGIW6zPOaLZI3pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189


On 15/05/2024 15:59, Robin Murphy wrote:
> Hi Jon,
> 
> On 2024-05-14 2:27 pm, Jon Hunter wrote:
>> Hi Robin,
>>
>> On 19/04/2024 17:54, Robin Murphy wrote:
>>> It's now easy to retrieve the device's DMA limits if we want to check
>>> them against the domain aperture, so do that ourselves instead of
>>> relying on them being passed through the callchain.
>>>
>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Tested-by: Hanjun Guo <guohanjun@huawei.com>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   drivers/iommu/dma-iommu.c | 21 +++++++++------------
>>>   1 file changed, 9 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index a3039005b696..f542eabaefa4 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -660,19 +660,16 @@ static void iommu_dma_init_options(struct 
>>> iommu_dma_options *options,
>>>   /**
>>>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>>>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
>>> - * @base: IOVA at which the mappable address space starts
>>> - * @limit: Last address of the IOVA space
>>>    * @dev: Device the domain is being initialised for
>>>    *
>>> - * @base and @limit + 1 should be exact multiples of IOMMU page 
>>> granularity to
>>> - * avoid rounding surprises. If necessary, we reserve the page at 
>>> address 0
>>> + * If the geometry and dma_range_map include address 0, we reserve 
>>> that page
>>>    * to ensure it is an invalid IOVA. It is safe to reinitialise a 
>>> domain, but
>>>    * any change which could make prior IOVAs invalid will fail.
>>>    */
>>> -static int iommu_dma_init_domain(struct iommu_domain *domain, 
>>> dma_addr_t base,
>>> -                 dma_addr_t limit, struct device *dev)
>>> +static int iommu_dma_init_domain(struct iommu_domain *domain, struct 
>>> device *dev)
>>>   {
>>>       struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>> +    const struct bus_dma_region *map = dev->dma_range_map;
>>>       unsigned long order, base_pfn;
>>>       struct iova_domain *iovad;
>>>       int ret;
>>> @@ -684,18 +681,18 @@ static int iommu_dma_init_domain(struct 
>>> iommu_domain *domain, dma_addr_t base,
>>>       /* Use the smallest supported page size for IOVA granularity */
>>>       order = __ffs(domain->pgsize_bitmap);
>>> -    base_pfn = max_t(unsigned long, 1, base >> order);
>>> +    base_pfn = 1;
>>>       /* Check the domain allows at least some access to the 
>>> device... */
>>> -    if (domain->geometry.force_aperture) {
>>> +    if (map) {
>>> +        dma_addr_t base = dma_range_map_min(map);
>>>           if (base > domain->geometry.aperture_end ||
>>> -            limit < domain->geometry.aperture_start) {
>>> +            dma_range_map_max(map) < domain->geometry.aperture_start) {
>>>               pr_warn("specified DMA range outside IOMMU capability\n");
>>>               return -EFAULT;
>>>           }
>>>           /* ...then finally give it a kicking to make sure it fits */
>>> -        base_pfn = max_t(unsigned long, base_pfn,
>>> -                domain->geometry.aperture_start >> order);
>>> +        base_pfn = max(base, domain->geometry.aperture_start) >> order;
>>>       }
>>>       /* start_pfn is always nonzero for an already-initialised 
>>> domain */
>>> @@ -1760,7 +1757,7 @@ void iommu_setup_dma_ops(struct device *dev, 
>>> u64 dma_base, u64 dma_limit)
>>>        * underlying IOMMU driver needs to support via the dma-iommu 
>>> layer.
>>>        */
>>>       if (iommu_is_dma_domain(domain)) {
>>> -        if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>>> +        if (iommu_dma_init_domain(domain, dev))
>>>               goto out_err;
>>>           dev->dma_ops = &iommu_dma_ops;
>>>       }
>>
>>
>> I have noticed some random test failures on Tegra186 and Tegra194 and 
>> bisect is pointing to this commit. Reverting this along with the 
>> various dependencies does fix the problem. On Tegra186 CPU hotplug is 
>> failing and on Tegra194 suspend is failing. Unfortunately, on neither 
>> platform do I see any particular crash but the boards hang somewhere.
> 
> That is... thoroughly bemusing :/ Not only is there supposed to be no 
> real functional change here - we should merely be recalculating the same 
> information from dev->dma_range_map that the callers were already doing 
> to generate the base/limit arguments - but the act of initially setting 
> up a default domain for a device behind an IOMMU should have no 
> connection whatsoever to suspend and especially not to CPU hotplug.


Yes it does look odd, but this is what bisect reported ...

git bisect start
# good: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
git bisect good a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
# bad: [6ba6c795dc73c22ce2c86006f17c4aa802db2a60] Add linux-next specific files for 20240513
git bisect bad 6ba6c795dc73c22ce2c86006f17c4aa802db2a60
# good: [29e7f949865a023a21ecdfbd82d68ac697569f34] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 29e7f949865a023a21ecdfbd82d68ac697569f34
# skip: [150e6cc14e51f2a07034106a4529cdaafd812c46] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
git bisect skip 150e6cc14e51f2a07034106a4529cdaafd812c46
# good: [f5d75327d30af49acf2e4b55f35ce2e6c45d1287] drm/amd/display: Fix invalid Copyright notice
git bisect good f5d75327d30af49acf2e4b55f35ce2e6c45d1287
# skip: [f1ec9a9ffc526df7c9523006c2abbb8ea554cdd8] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git
git bisect skip f1ec9a9ffc526df7c9523006c2abbb8ea554cdd8
# bad: [f091e93306e0429ebb7589b9874590b6a9705e64] dma-mapping: Simplify arch_setup_dma_ops()
git bisect bad f091e93306e0429ebb7589b9874590b6a9705e64
# good: [91cfd679f9e8b9a7bf2f26adf66eff99dbe2026b] ACPI/IORT: Handle memory address size limits as limits
git bisect good 91cfd679f9e8b9a7bf2f26adf66eff99dbe2026b
# bad: [ad4750b07d3462ce29a0c9b1e88b2a1f9795290e] iommu/dma: Make limit checks self-contained
git bisect bad ad4750b07d3462ce29a0c9b1e88b2a1f9795290e
# good: [fece6530bf4b59b01a476a12851e07751e73d69f] dma-mapping: Add helpers for dma_range_map bounds
git bisect good fece6530bf4b59b01a476a12851e07751e73d69f
# first bad commit: [ad4750b07d3462ce29a0c9b1e88b2a1f9795290e] iommu/dma: Make limit checks self-contained

There is a couple skips in there and so I will try this again.

>> If you have any ideas on things we can try let me know.
> 
> Since the symptom seems inexplicable, I'd throw the usual memory 
> debugging stuff like KASAN at it first. I'd also try 
> "no_console_suspend" to check whether any late output is being missed in 
> the suspend case (and if it's already broken, then any additional issues 
> that may be caused by the console itself hopefully shouldn't matter).
> 
> For more base-covering, do you have the "arm64: Properly clean up 
> iommu-dma remnants" fix in there already as well? That bug has bisected 
> to patch #6 each time though, so I do still suspect that what you're 
> seeing is likely something else. It does seem potentially significant 
> that those Tegra platforms are making fairly wide use of dma-ranges, but 
> there's no clear idea forming out of that observation just yet...

I was hoping it was the same issue other people had reported,
but the fix provided did not help. I have also tried today's
-next and I am still seeing the issue.

I should have more time next week to look at this further. Let
me confirm which change is causing this and add more debug.

Jon

-- 
nvpublic

