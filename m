Return-Path: <linux-acpi+bounces-5901-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2848CA1CF
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2024 20:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DFFFB20BCF
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2024 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603C137C21;
	Mon, 20 May 2024 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZdktqHdI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628334CDE;
	Mon, 20 May 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228682; cv=fail; b=bZJHRDixdWxCfC2Tu2tv7Su556T29+dFhNr1oxOcKoYRLUZTPL1jrQmS3Rs8Nk+v256g+XeVTgk+oH6dQi2/gj3xN70CUOB45RIWPNi2LG+Xknls5SX2aBYeaxE09zZIh+k/1UMN4mpOVLy+sSePTR8aP29XPRZ+Mq/TTX67XXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228682; c=relaxed/simple;
	bh=GMkq5So2GlHLNCxrRUvKxklM8AF2T5T+uhyIFILH0nE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ojdj/y8/3qVBIvAn0enl+8yM7OMcQIN7qin37j8ZILecEwjgKeC8XpdJCatL2IWqbdbI3k83Gp4bK54A7Q9RORi5ZPCe/fVOp/6w+tj362sSSpewYMpm1ESZdSmSG4J3juTjpuBOM2CcJVIgw2TyB/woLoGqmzI//s7PH9QxLGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZdktqHdI; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmR7jX/RsNgZTY64bBPeeomN0tBo9i0g3ketY2HhPOi+JjOottCjymSeuKU9iQWT0cTqAzcohoXjMp/AQNzaH8KfoLspqBgJlPqUaHUJR9pq2sSLCGKfj3yH2FCEmM36zNzWu+GaolQo5qHrrUt8lLMTpoKhHKgA6ZWavQwnSwQH/8eacSm8lV3labJZxtJyhAzPojCnqCd8wVg2ZBN61U00Qz0UEdkt8HTwpvhBdci0xNO03GVIiBXnPjZ2aNc+D7hEvwF1l6GSaOPOrDGfcD/mRu+Ogonz+1QsD+CLJTDCkg3IB1y021LC8j0xeXEJhbpa75tmICFNK77QZ0mm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htMCbPYZKglghQSmoYlJVc3dIu3d1MPXZllfX7+KkQk=;
 b=QCbwT80SkygOSF26p0v58+bgH/Oq6O6YwrjWG73XiaLsedoDfbFwGyXCKO/0yiz00fAOsUXpmIIQn3jsHmD0BkPTYZ9hAfNgATe2feD3gbQ5ooqNzWy0EGWnsJRvRrrH//8RWA+k5rMg9KimmSsuZ528c6Fq0Ai1wIxOTumnjzwy0hQuE2DLNQGjo/q6fhMVOLc0hH5rSjR3Anr2WRKCwMopIwjKwXds067Dy8Q4WYigveabmfa26LD0Sln0X3TnphAAiBt/35+BVGnojIApRGlwknDtwU0AWr8CdJJwlM/D+gfTnGOeBUtUXgsBfREZUB5Qkvd+nE+2SXOUXnx7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htMCbPYZKglghQSmoYlJVc3dIu3d1MPXZllfX7+KkQk=;
 b=ZdktqHdIa5P1R3YNivBqJAA1e+88pSKxV6bxfcS8m0Y797mcWeGRWcQR911FH1tQjA5uz/+fTF+kqfimE6ECZiXiT712Q0FkNGWjOgZoRGzgsKruC2TkJ7uP7z/acz1p1STigrjGT+Tk7Azf0AdJqoi/aES7Rg1zENjcMcX7LPfzoWIoMlNHyX5wfz7hPYXDuK/SIuMFGUC6jehoeNa3DJ/CxzW4H7qpjy3hRMYKwxDsk8Eodt6mPBqfSGMR8+KAp1p0VJYzwh8utzZcG5jXc+5YKuarG2FPcPwuwwy1IdPKdJPd9iyqeAu6fblfRhzwJE2T5cN7QtOb8uveiTc38w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Mon, 20 May
 2024 18:11:16 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 18:11:16 +0000
Message-ID: <11aa16de-0ff5-4f22-a4ec-5513900f0e98@nvidia.com>
Date: Mon, 20 May 2024 19:11:06 +0100
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
 <46fc1b7f-7d10-4233-b089-aa173ad3bbeb@nvidia.com>
 <981c85f3-6d43-4c2b-a440-88bf81a18e55@arm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <981c85f3-6d43-4c2b-a440-88bf81a18e55@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0511.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c64f7c4-7054-40c6-effa-08dc78f83d8d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am4xV0NPZjlRaHl3WHhTWXY4NC9paVhiV25lV2RPWFRqVjBzeHR0dEx2S09C?=
 =?utf-8?B?c1dUR1BHa2IzcExDRDhReEswenpJdlVpOEk1M2FzNGw0cTErRm5oRnA0ZlpG?=
 =?utf-8?B?SXlJb0Jhb2JxVXRpaTFaL0VlaWZZdEpsZEc0a1BlTUZkaXBSUmQ0L1FQbmh1?=
 =?utf-8?B?M3FkSDcxdU5FeFZZU0VOYkI5ZENyYVVXWndZY0cvRTkrc3FZZUE4cFFzV2hW?=
 =?utf-8?B?cFpQNlVvejQ3Ti9obkdkSUpKWE95eXJmc2JBdW1wR3JoVnpvRml4aVFxbWJz?=
 =?utf-8?B?UGdDcExFRWVjWTlhMzNVQUhpOTduZElKMGd5ejhQOGZTclR4UDY4RHVISzVp?=
 =?utf-8?B?SEhhaDZhVjRuYk5SZXI3Vy9pa3RTRnVucHZEOXBmR2pTdHo2czY4TUZGOU9o?=
 =?utf-8?B?UmloR01rek1iQWhxOHVEenRKemtibW54bEk2S1A2bmpkZjJpd3RKUzlzTFQv?=
 =?utf-8?B?U2dWa1loNGcyNHBoeDZMNlVHd25VckpIc2tXMWtNWjMyMWEvalg5UGsyd2F6?=
 =?utf-8?B?YTUrUVlyRmdoMVVZTG9UMlpJN0ZEblFDNFFSNlpaYmZZNnByRFJmbCt4dmVV?=
 =?utf-8?B?ZkxmeWJaQ3prYTFjVWpQOEVtbnJvcFMrWTcxNGcyODVpTkhRU3ErRXdDaWwz?=
 =?utf-8?B?bnNkM05BU1g4NnNZa0ttZFFoTzNTdUVQQXJqL3VMZkNxRWkybGV3ei9kK1RW?=
 =?utf-8?B?T09BOGRzZEdhMWFIR1pwb2ttNGxpYXNtS08xemQwblJCMXp3UTcwZEI0aVpU?=
 =?utf-8?B?anlkdGhRRnRRMzFwc29oakV3eTQ2bmZGSTIvSVNBNGlPUGFOdmR0TUxsSFNQ?=
 =?utf-8?B?MmZpRmZUWUtsM2FoQzBVRlRPcFkwc0ZmdlJ4VG9ia3oxbHRzY0RoRW8xY1VR?=
 =?utf-8?B?cTNUMFlIY0xGZ0NyNm9Wa1Q4SmNybVMvNVFWKzFZM2lQR1c1UEtyL3ZWei9s?=
 =?utf-8?B?VC9PZ01PU3lzQ1FrL2N3Z2h5OTlieUVoSGY4Y21KVmxhbHhLRy94U3o4RmZM?=
 =?utf-8?B?WHFORXhZYUpDTHhZZS8wOXRJbW95L3ppOXkxOGtVUG9tUVdiYkFXckE4MDEv?=
 =?utf-8?B?cm9CSFFvTDR0ZmQ1Q2J2UjV3S0lsL2owZytLVGcwbFNUSG9iSDF1YVgzWVhx?=
 =?utf-8?B?M2tReW9zRnNybDR6MEhWVzRVSDNLSlpuZ0Y4VnBRZlIzdURCUkpmVlJUN0pv?=
 =?utf-8?B?RjFMSUJELzhuQ25iSXpZWU1nUENQZnRyd1htcHZxVDZEY1VYUTFQdGJqbVlU?=
 =?utf-8?B?bWRQOENscUZtS01TUGIzeklYdDFvbEwzU1dRWWFlVmYyZWlNNHlWbDNkQkdo?=
 =?utf-8?B?Y3FQQ3Z4REhGb3N4Qkk3YXc3a3dXd1RnVG80Q1k4QlZkYnJLdDBQbGZ0d2Ny?=
 =?utf-8?B?QVdiRFJ5OThJc0hwQi9Uc1NSZVNObE9GOFdETjlYU25qdGpLUG5WZ2NiMy9B?=
 =?utf-8?B?amFLWWJrVERYU2tyNCtMRkI1U3RhaldLb2hmT0FDS1p3VGxnVFdCWEtKWnNs?=
 =?utf-8?B?ZzhlZ3NjUXZFVGZqM3gxajJvR093NHp2R01EcWxtaW5YZE5vQ2hlb3BtOGpU?=
 =?utf-8?B?a3piek5wblorMmc2WTJYR3p3aTdRbTcrdk1ML3NIM2xkRHBZQ0xVYVpyRGtV?=
 =?utf-8?B?U24vRDRaNXpteU1jZGo1ZzU4RFNDNXdubVQwVy9CbWU1aWI1a1JDY1I0bGs4?=
 =?utf-8?B?djhiS1VRR01jV0lRWVdTOVVDYVVGRExkc3dyYlZmeHYrK0JzQVhLckpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Si9VTmc4KzJJRVphOXdydWVNUXZaRDhZck5vUmMwcXNEMjllOERxaTFsOFpr?=
 =?utf-8?B?UXU4K25NSC80Y2VFSXBtbXF0Snp2S0tlSjJFallTZUtLaHRRRlI5U0lUZXgy?=
 =?utf-8?B?R2sveEhYOEtYVlNXdmhoZHNEajRobFA1bmJiRXBlNUk4L09sTmZYYVlIbk51?=
 =?utf-8?B?ZkkybkM3N3U0TGd1VnZyY2tSc1ZwWW9SZHJMQ2lFeG9YcWRHWUdVMUFCT3Zj?=
 =?utf-8?B?Qk0xL0gzdGRDWldyTlk5WnpHdFVWbzZON0V0TmpaWVhwWWdXR09xMWczSTlZ?=
 =?utf-8?B?ZjgyWmV3Q1A3VGFnQ2grVWpGVjVCMVhUQkVuVDFXbjFsTUo2aVRVZllLZS8r?=
 =?utf-8?B?RHlKMmI1cW8wZ2JtM1hGOXY5Z1FNMXhEb2pyakRyUkd6K3NmbjJLUEcyRVdj?=
 =?utf-8?B?eHJvRUJWMkJ3YW9qOVM0N0xHRXlrUXRYZlIveURkSW84OWRhVkdFWDRhd2M2?=
 =?utf-8?B?dFZIWXJaNGV2blhSUFl4Qm83OXdZUTk2bk04UHk0ekNzT0IwQVUyMXlRYXV5?=
 =?utf-8?B?TC82cDZvMkdPTCszTWk5bEF1YzRDdGRsWHdTdzRRZVlvM1RGZUZSc0luZXUx?=
 =?utf-8?B?VTg3aDBSaUtIc1hRQm0zMmk0LzdNb1FqK0Fzdis0bkRMN2Z6Uk9LY3RwSHJl?=
 =?utf-8?B?UzIycUdoRkNuL09IS2ZnU1MvQ3c3aWVvbVk5QnN5V2ZTVWNsa0xlYjhma1dU?=
 =?utf-8?B?eVFrc2JwRkY4U3dFcEhlQ1JpNlhtcEVEYU9McmlTckVqVmdqdjRWYThNQUFN?=
 =?utf-8?B?OGo0SmpsVXNDRm1oTmxiSEhBMUFCSThqdDM3YWsrOWpyTWFzWVhOWFBib2F1?=
 =?utf-8?B?Q2tlK3AxMGlwZk81Rlo1cTVMd29hYTgrSnhuUWx5ZG9SbVkrSUtmRnlRSGta?=
 =?utf-8?B?OWVNNThnbm5zMUo3UiswcS84SnB1cnVZeDk1ZkFoTFc0WVhYMUNteUFMUStr?=
 =?utf-8?B?b01DYUNVYmQ1R1VSb2U2bzJaQXd5NGErZUZkckF0cFNoSitSTVp6YUJmTnpI?=
 =?utf-8?B?U1BVT2tjNUswVHlpdnV6Skk0aWZ2Rit6Y1VzTG9UTWtZbFpmblE0TVpVZk0y?=
 =?utf-8?B?Y0p4aUtZQWZGcU1WUm5zWmYrUVdlbG1HMWtPeXlNMnFrL2dNSm1XdlFaRWxD?=
 =?utf-8?B?VUF5elBrVmlycXZpbkFsN01YNWVkNUlQNmVTM1pGM3J1ZHIzWXNoN2xjcDN5?=
 =?utf-8?B?c01uTzZpYlNOT015b3JWRmtYUFlONzVLNnJ4RFE2dUF3L1lTRnhYd1IxQk84?=
 =?utf-8?B?OFZEN2dtWWNVR3JpZmkyMHpodnFEaUZIZDJpblpWZjVzZzR0MmgxTFNFSE9G?=
 =?utf-8?B?cUlsbERzdk5pY1RnRVo5Q0J6QlZmSU5XdERiZVhUMm4vbmc4cXQ5b1dYU1lG?=
 =?utf-8?B?UGtOQzRyd2JJdWNBMUJ3dzFzcnpSRXZwMHYzUXR5QlUrWi8zY3dqamhVY0pj?=
 =?utf-8?B?UDRjZzBmNCs2WHlLYVZYbGVzNzZaYWJqRGcraHJaVlVKS1loMm5pcHdZWWRF?=
 =?utf-8?B?a00xdFBYV09qMGwzYUNFYlkzQ3dBUmw2VDkzR21CYmNCMGJ6ZkVwaUJFWk9L?=
 =?utf-8?B?UWRjQkhxYlNUV2MrZ3VmMysxa0dWd1VOSGN5Sm14QU1VVkRldk50MTVSUFhn?=
 =?utf-8?B?SUJuWGlQT0R4a2N1VFNXMnlkcUpMbi9uM1A5Nk4rUVVKaXdtUDMvUCtjZ21U?=
 =?utf-8?B?QU1zYlhMek5ZZGQrZ1lCMFdmRG9lTzVGaTZ4bnh4amFUemYrNEtwL0FDZDYv?=
 =?utf-8?B?cWFBc3FPZllNY2tELzdIdDZHQ3ZFS1NYQTZLOXN4M1FuQzdHZzIzNURGK0pC?=
 =?utf-8?B?RDVnbUhDVU1TZWhjU3E2MkttSWg0QklFWXVkKzBBbTBBTXFtdjF1d0VJTC9l?=
 =?utf-8?B?T1M0VGhsbGd3cmdGK2c4TnFqOU5TQWFPRXh0ZUp6QzVvR1ZTcGVWYklFTjZE?=
 =?utf-8?B?MDdBaGZPV3V0TU12TnNnODdTV2JuaDNPQUY1YzE1VFBwUWVYSEpSNEZLbVBQ?=
 =?utf-8?B?TWhibFZFN1R4VERQcTJJRWpmQTJvSjZWY3ZsRHlBWnlsbFNxbjRsVkdJZ1Fu?=
 =?utf-8?B?NFlhdVFaN2dQM0VsODVnbitSUUkycWxtUlVvODN6SEFWc3JHMkg5cE1yVkIy?=
 =?utf-8?B?dHVvSE4wV1ZZRTVLeEpsWVBUSXNva1JxcFZLbFJzS25BZ2szeVJTaTZLYjAv?=
 =?utf-8?Q?gvKzJdlI8mJZYO0IXYVk09fTLcvS67g10JGoNC0Led/3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c64f7c4-7054-40c6-effa-08dc78f83d8d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 18:11:16.5038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUjpe8xdefHMF6mH1KeEkVPApkZtbvMQ54ymQ5PV85S0UYsLBNgs1wCDv+cf97Lt/JeK8Lxc5vPCW1eLvA4iGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

Hi Robin,

On 17/05/2024 16:03, Robin Murphy wrote:

...

> Thanks. From staring at the code I think I've spotted one subtlety which
> may not be quite as intended - can you see if the diff below helps? It
> occurs to me that suspend and CPU hotplug may not *cause* the symptom,
> but they could certainly stall if one or more relevant CPUs is *already*
> stuck in a loop somewhere...
> 
> Thanks,
> Robin.
> 
> ----->8-----
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 89a53c2f2cf9..85eb1846c637 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -686,6 +686,7 @@ static int iommu_dma_init_domain(struct iommu_domain 
> *domain, struct device *dev
>       /* Check the domain allows at least some access to the device... */
>       if (map) {
>           dma_addr_t base = dma_range_map_min(map);
> +        base = max(base, (dma_addr_t)1 << order);
>           if (base > domain->geometry.aperture_end ||
>               dma_range_map_max(map) < domain->geometry.aperture_start) {
>               pr_warn("specified DMA range outside IOMMU capability\n");


That fixes it for me!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

