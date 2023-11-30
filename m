Return-Path: <linux-acpi+bounces-1961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D5F7FE6D0
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC541C208FE
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981C2154B6
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MZaNIhcl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5E10DF;
	Wed, 29 Nov 2023 17:10:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiZX9ZOj1ub5T9vWvCHa2tL4ofwN9OtXUUoJDccNC6Y48wwXxcfirU/IvuLRnbVJUDsKvD/g1NmFwob1PuN8+LxT7qAFwnn/U9MX1ZFHiaZOu/k/u/dj1EgvSZ2G8B02Tm6UZpmomSCfGdzxCnsbreg1fZZ06fU1UW3bxxNlciuEP2Ezl0dmvZojr7/sQnT0qMYSwQKE9c/vMqidLyfeIr5Is4oc8osCau2Rpeye5VV4xKn8rY0v5vwp4EncvD71zT6eb+DSasF1rhLbaRXN+yBb3q3OVLbc6yKP3mqw3NY137AWTQXJlnBX9Q+L9aJMgO2/+A3fRorgP5SEy//zHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR4pbU5x/auVrVVOg/TAb4tNE+GP54D6lTgTD1gMXyk=;
 b=EZpxLEJGABfvkFODDCF5OnvVFTmTSJerUlLhwSe0cX0KaxiLv8W0rcfIFB9zLhVt/v4JH3Kze6jclBhffVnSNV3t6I6EdQE0y9+ZiYXwrdMux1DwPnTofCSgHo3lqVao1gKeqKjgMDAXhHrl+Wh27X/zBp+q1onkv7sjiZkIQo4XULdIdNSPCjqN8oCryAkBU52lwjx5X1fmGh7S5gLCyuxth5isZNh2KzY4qmivwrKhoBhQ8YIGlc+r0k+A3oOBoNA88t9z+At1XB/KGjtz5+qK715BjxjIeVILX2GA6VLuMpdcJ7hBm8jTfg/ORpz82tRxhzwNt8u8h3//BP52bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR4pbU5x/auVrVVOg/TAb4tNE+GP54D6lTgTD1gMXyk=;
 b=MZaNIhcl17yWA62qyFp4s06oBKWWsHLDpCRq1CPDGZgNkRLJP21TSBVaBHJHPrb+ur86IW1IJY9SfRtwRgYqg5T4iKr8Y3mQNFNYKNzCrJjxIPrUU5rSTEXvtVjxPJEFjsmGLqNWc7dZlfP9mf1yMp8XYV89JEnqHL8/uhAGPKNEtta/Z/4w16w7HzPyz+qZV+qQiBYV5WJzBD5rtCC4PqTorBX80mksNnXkg67auecoZoruQFeJ3o7+JMrs5lCRArKMa3GVZqb/0adhihufOQeKT9uTs9Zbtd8vnOddVndN0nXzGmiReGUCPR2HeylGp/MtVXtol6uaMH2om1RauA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:10:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:10:48 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: acpica-devel@lists.linux.dev,
	Andy Gross <agross@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Bjorn Andersson <andersson@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	asahi@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Kees Cook <keescook@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hector Martin <marcan@marcan.st>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	virtualization@lists.linux.dev,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	patches@lists.linux.dev
Subject: [PATCH 00/30] Make a new API for drivers to use to get their FW
Date: Wed, 29 Nov 2023 21:10:07 -0400
Message-ID: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:806:125::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 771d985f-0b93-4eb5-a0e0-08dbf1412b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OiXroFQzwMNNfbmgk2qTxidfbHLliwxcxq9eNvc/3D6MDRdSr0QKCW4Txpb5GRzLPXFOHDZ1rPCJNE+K/d48Ubx5f8x3+z6S6KUsEwKj9Xp2G5J9MX7dkPutFAAXInwx8AFkfTNeEptsW/dPWPMi8JGzAxQb6I7tR03Brkvj10vQHOfFoN1GJRVzT97TNyd3s2AgLgla0wDgyrplc4b1BmA4rYbIdZ/dUaTHlndJ9MfKIK0BH67fDPsmgXJP+FG6zC0gzjj6UVFKkXY0G4DD80ub0Wd2HoYkm/Bnk2laBKlBIbFlg5BsvYj02LoYC8dZ+fnjqDkuAsQP6TMCsTDdd4Uoh16b3z4Kv80TETy9tDKeWF8Pi2XM+YKOqxQ9NSdLz7SAkkwmYI/Peraz1lZapwwg1U3GzQGfDRFN08/ZtAeqN6qJ1ew/05P5F00xjpCyrRNea8u07tlDp96Njw+duSOI+Y2vlD9UntSQnYGijjxJ4S3JMxM4UbwUbwey14DFzwuZOzfokMCewaTyNalthNiqLlBdjKs6gtTX/kvkHfaqntT37QLjJa24ylHkoJsvCbMxEXZbo6DUyGfC1KKEaO1HwVaODIaHqh5miOVqAo8iwllNGXFH2XbYP37W0wxzcD+gu6D7Ui/C1dbMO3uG9PogPe6QTEy2Fq2AQvKR6PvcZbZKh9zAxz4yzvTOpdocu+E4oWm0LBabBKscms4wuA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1191002)(8936002)(110136005)(8676002)(316002)(66556008)(4326008)(86362001)(66476007)(6486002)(966005)(478600001)(66946007)(41300700001)(36756003)(921008)(30864003)(7416002)(7366002)(2906002)(7406005)(5660300002)(38100700002)(2616005)(6512007)(6506007)(6666004)(83380400001)(26005)(202311291699003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjlPR1lnOHpIUWU2RVo1c1M4L2hLK21Rei9LL3RCNDJYdDBEc2Zkck1xTzYz?=
 =?utf-8?B?dkJrQ3FUenVOcmpwdm02VnozOHVPU0wrZ050eUJpYmdLelphalVmYjBYNWw2?=
 =?utf-8?B?eW5OaXhidjlsUXJ1TjJUcEhvSVRtMk1YTDhWbjRPRkhnaFU4ZjBoT1Q2bC83?=
 =?utf-8?B?RkY4RkRRSFlzRHhoSHdpQXJuTzhETktpb09reXZrTnpIeitIamJ2ZDBkckVx?=
 =?utf-8?B?a0tUTmZ2RlFvWTI0ajlCanlwaHptLzRsdE5Kckt5S0hIUDZFREpnaW5YZit5?=
 =?utf-8?B?OVRaWWZHM3pQUWtqSVI1Ni91VGNnQWtvaTlJekdjNXF0eThUZUZDRFI1cXkz?=
 =?utf-8?B?VFdEQkJueTJrMzNLK0JHUFpSSlJOaXdBa0NxMnVmOHRCbUtDVmNjVHM4UEc4?=
 =?utf-8?B?ajF5NkVadWRYVUFBOGV2S1JwMFpwVzU2SFRsWXBVV2xMRityaS9NTmdqZ0Z6?=
 =?utf-8?B?SlNTdUQxMjVEVk16UGZrUlBwVURkZEwrbTVzNDFOc3E2Vm80SW1kR3cvd1VP?=
 =?utf-8?B?clZTSS8vMml2SzNocHZ3ZjEvRktmbGhLT3E2R256YzJXUVB1VmcxNHNzUGhU?=
 =?utf-8?B?VjFhWFhnQWRTQ2tSeHRxWFoxN2dwNEcxb3d0V05TWmxWdHRSUk5keGwzT3Rq?=
 =?utf-8?B?VnJMNVZFNWNVdWJ1enFtdnljNmNzRWo5bTB5TlU5dnIzbDBsUzlYZDlybHJn?=
 =?utf-8?B?dzlJb3hkVW55T3VQV01QVlozTWlyUjRiUjRCRElvaWt0VVhwZytFdisxK3lQ?=
 =?utf-8?B?R1NPeXQxeng2TjM5T1RPbUlCVGVWbC9TTWxrRzExaUQvQnAveXB0enE2dGRG?=
 =?utf-8?B?UGFZYXIzVnVvVjIwQmsyZXk1ODZYSTdwQTZha3pydWc2bFVZM3Rhb3luSjhp?=
 =?utf-8?B?NFZpbEpMYWJ4WG1NY1Zid3NHdHVValE5bjJnMm1XV09nQmR5YlZnTzliMmlF?=
 =?utf-8?B?OGNGK09UWWt2b21RWXRuREp0YklodkpqWHd1REY0ZEVRdnRQWTB3R3ErYWNp?=
 =?utf-8?B?OVNkVFVURkhRbzl1RFF4QVdBTTV4TEUxeUQ4ekwrL3NsdFFxQVcvdS9Ebmsz?=
 =?utf-8?B?UHdhNXNtdnNBYUJEd1JWa3hRSzhENENaem5OaEI3SitubXBERis1UlR1S0pp?=
 =?utf-8?B?SUpEaFlJU1NnZUdWZXZjWGRPaDdTN3lOV2tOVTlHL01ZTEU3ZmFqTHpBNGVh?=
 =?utf-8?B?cXRMcHY3N296U05rbUdxZGdYVXNqekFHbERiU2RWV0Vieml6L3lzenJYeXU1?=
 =?utf-8?B?R2dyMWNNbk1YNEVsb2l3UGdWVko3UlV5dm9PWlAwQklMY3Zab3ZQbmZMZXF3?=
 =?utf-8?B?a2NoZDgxV2RndFhMMDlPZTdIRm9BczlKQytFOXhIbVZhanpWQWFHNTVvSTR2?=
 =?utf-8?B?R0NYVWp5dTNrWjdRSEJSOGJybGp4N3FTUzFPU1FvQWlNODk5WTFjOVFFNU9O?=
 =?utf-8?B?N1dXVEhZVDhKTlZJNTFubnJWMW5wYUp3Z1NiaWFEUHM1cDd3b0MrcCt6Wmx2?=
 =?utf-8?B?R3FtY2FEdVExMWQ2Y2hKUW5xUlVEZTA1dUZlQTJwT0p1ZUtLVmJCU0Nqa202?=
 =?utf-8?B?R3hEWWxEZDlNcmI1YTBSbUU5aWpxRnEwRWljcW03eGRhQzBLcXZKL21jZ0FI?=
 =?utf-8?B?a1pwQkZ2b1FwU3laR1dZYzVZc045UlBIWGhMczFoQWJCdXZHNVFRVmsrYzZB?=
 =?utf-8?B?K3pkNXdrYmVhdm1ieTFxR1dSZnQrYVluQUZ5OW1EMC95bTl0VStKb3JEZDh4?=
 =?utf-8?B?dlRxY0JPZWplK2tqVEIrMkFodWw5MCs4TWk4RCtDUmlNaURGVFFUdE9XZ1FR?=
 =?utf-8?B?STRYOGFJZkY1cTBoclB2WjVucDZJckM1b0hPM2VPVmQzblNUa1hmQ1l3V3VB?=
 =?utf-8?B?OVZnWjF5TzA0elZTVlluN3lyc1M1NGhIZ2Y5RWJJa0I3UG5LY2x4b2p3dTVI?=
 =?utf-8?B?Y2lvSWxPVHIwSldqcjFud25lemRhTUluY3h0cERlSmcvSjB3YldXQWtvSmVP?=
 =?utf-8?B?NHg0UTNqRi9IYjFxZmlhWHVsTC9PMXN4S3luRldVeXpTQTNieVJsaXRQcXBZ?=
 =?utf-8?B?dVdjRnNDc2xTMkdRY29SRVVqNGRxaS93V0M1cjhoaFp2ZGVydUc1OVVjTUtr?=
 =?utf-8?Q?TapHe5HBPxFQbhz6bN48dHqv5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771d985f-0b93-4eb5-a0e0-08dbf1412b56
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:10:40.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFPy5PUxghfXtbKQurqYbSRoGqBpiEiAtA8geV7Qw5E4kUqFRSTNB52cpLxCirzW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484

This series improves the way drivers get their FW data. It introduces a
series of driver facing APIs and converts every driver to use them and
replaces fwspec with this mechanism.

The new API allows drivers to do less stuff in alot of cases, and permits
all drivers to sequence their operations in a logical way with correct
error handling. It doesn't force the idea of pre or post parse on the
driver, though I choose to implement post-parse here.

Aside from the API change this takes on a few other goals:

 1) New API for drivers to simplify drivers and make them more robust
 2) Remove all FW parsing from _dma_configure()
 3) Make the global lock back into a static
 4) Organize things to reduce the probe time memory allocations from
     fw_spec, N*realloc, dev_iommu, device-private
    To just allocating device-private. The last step to merge dev_iommu
    and device-private would be a follow on couple of patches.
 5) Get everything setup to allow all devices to probe during bus scan,
    not during _dma_configure.
 6) Better layering between the ACPI and IOMMU code, less
    iommu related things in the ACPI directory.

The drivers break down into two broad approaches for accessing FW in a
driver's probe_device() function. AMD, Intel, mtk_v1, omap, S390,
smmu-legacy and tegra can "self probe" using code in their probe_device()
functions to parse their associated FW descriptions.

The rest (DART, smmu-modern, qcom, smmu-v3, exynos, ipmmu, msm, mtk,
rockchip, sprd, sun50i, virtio) use the iommu_fwspec system and rely on
the core code to do the FW parsing for them before invoking
probe_device().

To understand the philosophy of this design it is worth to take a moment
and review the 2009 LWN article on Kernel Design
patterns (https://lwn.net/Articles/336262/) exploring the "midlayer
mistake". While I do not entirely agree that midlayers are unconditionally
bad, the discussion does nicely frame the architectural choice I've made
in this series.

Organize the FW parsing so the drivers have an toolbox style API to
extract the information they require from the FW. Create a set of APIs for
the drivers to call that do exactly what the current set of drivers need
in an efficient and understandable way. The API is designed to
significantly clean and simplify the drivers.

The API transforms the iommu_fwspec from a long-term allocated struct into
a short-term on-stack struct iommu_probe_info. Using a short-term
structure means we no longer have to be memory efficient and can store
temporary details about the ongoing parsing in the structure which is the
key to allowing the new API.

Further, philosophically, the API changes to make the iommu driver
responsible to provide per-device storage for any parsed FW data. It is
stored in whatever format the driver finds appropriate. The API provides
concise helpers to make this easy for the standard 'u32 id[]' cases. The
unusual cases were already using unique per-driver storage and continue to
do so in a cleaner, less convoluted way.

The design allows the API to be implemented either as a 'parse on demand'
or 'parse and cache in advance' (more like fwspec) approach. I've
implemented the 'parse on demand' version here, but I'm not fixed on
it. Let's discuss.

The choice is deliberately not baked into the driver facing API,
iommu_probe_info combined with the generic *_iommu_for_each_id() lower
layer provides a lot of flexibility to do whatever organization we want.

The specific commit messages provide details, but the drivers break down
into three basic idiomatic sequences for their probe_device with the new
API.

Single iommu with no ID list:
  iommu_driver = iommu_of_get_single_iommu(pinf, ops, num_cells,
                                iommu_driver_struct, iommu_member);
  per_driver = kzalloc(..)
  per_driver->iommu = iommu_driver;
  dev_iommu_priv_set(dev, per_driver);
  return &iommu_driver->iommu_member;

Single iommu with a simple u32 ID list:
  iommu_driver = iommu_of_get_single_iommu(pinf, ops, num_cells,
                                iommu_driver_struct, iommu_member);
  per_driver = iommu_fw_alloc_per_device_ids(pinf, per_driver);
  per_driver->iommu = iommu_driver;
  dev_iommu_priv_set(dev, per_driver);
  return &iommu_driver->iommu_member;

The iommu_fw_alloc_per_device_ids() helper allocates a correctly sized
per-driver struct and places a u32 ID list into the flex array
per_driver->ids[]. This removes the need for a fw_spec allocation.

Complex multi-iommu or complex ID list:
  static int driver_of_xlate(struct iommu_device *iommu,
			 struct of_phandle_args *args, void *priv);

  per_driver = kzalloc(...);
  iommu_of_xlate(pinf, &ops, num_cells, &driver_of_xlate, per_driver);

  dev_iommu_priv_set(dev, per_driver);
  return &per_driver->iommu; // The first iommu_device parsed

The driver will process the given (iommu, args) tuples and store them into
the per_driver struct in its own way (eg DART encodes things into a 2D
array). Allocating the per_driver struct before running the parse cleans
all the tortured logic.

The VIOT and IORT ACPI parsers provide the same API. Drivers supporting
ACPI will call the ACPI helper (ie iommu_iort_get_single_iommu()) which
understands how to parse OF if no ACPI is present. Since the SMMU drivers
directly invoke the IORT parser they also get back the extra IORT ACPI
data in a "struct iort_params", which eliminates the need to create SW
properties or store SMMU only stuff in the fwspec.

The bulk of the series is converting each driver to this toolbox API. The
design of the toolbox functions are lightweight from a driver perspective
and generally replace existing steps that the drivers already had to do. A
significant amount of inefficient boiler plate is removed from all drivers
related to how the driver obtains the iommu_device pointers.

The implementation of the three flavours of FW parsers (OF/IORT/VIOT) are
all structured the same. The lower FW level provides
a *_iommu_for_each_id() function which parses and iterates over the actual
FW table and calls a function pointer for each (instance, id). The iommu
layer then uses this for_each primitive to do the IOMMU specific stuff and
create the above APIs.

To allow the iommu_of_get_single_iommu()/iommu_fw_alloc_per_device_ids()
split API the get_single will count all of the IDs and then alloc will
size the flex array. The iommu_probe_info has scratch space for some ids
which can then be memcpy'd without a reparse. Reparse is kept as a backup
so we can handle arbitary complexity without burdening the typical fast
path.

The removal of all FW parsing from _dma_configure leaves only the
initialization of the iommu_probe_info behind. My plan is to add a new bus
op 'init iommu probe info' that will do this step and then we can fully
execute probe outside the *_dma_configure() context.

The big win here is the extensive cleaning of the driver's probe
paths. There is alot of "creative" stuff there, this cleans almost all of
it away.

This is on github: https://github.com/jgunthorpe/linux/commits/iommu_fwspec

Cc: Hector Martin <marcan@marcan.st>
Cc: André Draszik <andre.draszik@linaro.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason Gunthorpe (30):
  iommu/of: Make a of_iommu_for_each_id()
  ACPI: VIOT: Make a viot_iommu_for_each_id()
  ACPI: IORT: Make a iort_iommu_for_each_id()
  ACPI: IORT: Remove fwspec from the reserved region code
  iommu: Add iommu_probe_info
  iommu: Make iommu_ops_from_fwnode() return the iommu_device
  iommu/of: Call of_iommu_get_resv_regions() directly
  iommu/of: Add iommu_of_get_single_iommu()
  iommu/rockchip: Move to iommu_of_get_single_iommu()
  iommu/sprd: Move to iommu_of_get_single_iommu()
  iommu/sun50i: Move to iommu_of_get_single_iommu()
  iommu/of: Add iommu_of_xlate()
  iommu/dart: Move to iommu_of_xlate()
  iommu/exynos: Move to iommu_of_xlate()
  iommu/msm: Move to iommu_of_xlate()
  iommu/tegra: Route tegra_dev_iommu_get_stream_id() through an op
  iommu: Add iommu_fw_alloc_per_device_ids()
  iommu/tegra: Move to iommu_fw_alloc_per_device_ids()
  iommu/mtk: Move to iommu_fw_alloc_per_device_ids()
  iommu/ipmmu-vmsa: Move to iommu_fw_alloc_per_device_ids()
  iommu/mtk_v1: Move to iommu_fw_alloc_per_device_ids()
  iommu/qcom: Move to iommu_fw_alloc_per_device_ids()
  iommu/viot: Add iommu_viot_get_single_iommu()
  iommu/virtio: Move to iommu_fw_alloc_per_device_ids()
  iommu/iort: Add iommu_iort_get_single_iommu()
  iommu/arm-smmu-v3: Move to iommu_fw_alloc_per_device_ids()
  iommu/arm-smmu: Move to iommu_of_xlate()
  iommu: Call all drivers if there is no fwspec
  iommu: Check for EPROBE_DEFER using the new FW parsers
  iommu: Remove fwspec and related

 drivers/acpi/arm64/iort.c                   | 233 +++++++---------
 drivers/acpi/scan.c                         |  58 +---
 drivers/acpi/viot.c                         |  67 ++---
 drivers/iommu/Makefile                      |   2 +
 drivers/iommu/apple-dart.c                  |  62 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  73 ++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   4 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c  |   6 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 209 +++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu.h       |  13 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 160 +++++------
 drivers/iommu/dma-iommu.c                   |  22 --
 drivers/iommu/dma-iommu.h                   |   6 -
 drivers/iommu/exynos-iommu.c                |  78 +++---
 drivers/iommu/iommu.c                       | 271 ++++++++++++------
 drivers/iommu/iort_iommu.c                  |  99 +++++++
 drivers/iommu/ipmmu-vmsa.c                  |  95 +++----
 drivers/iommu/msm_iommu.c                   |  92 +++----
 drivers/iommu/mtk_iommu.c                   | 115 ++++----
 drivers/iommu/mtk_iommu_v1.c                | 162 +++++------
 drivers/iommu/of_iommu.c                    | 288 ++++++++++++++------
 drivers/iommu/rockchip-iommu.c              |  73 ++---
 drivers/iommu/sprd-iommu.c                  |  31 +--
 drivers/iommu/sun50i-iommu.c                |  59 ++--
 drivers/iommu/tegra-smmu.c                  | 158 ++++-------
 drivers/iommu/viot_iommu.c                  |  71 +++++
 drivers/iommu/virtio-iommu.c                |  71 ++---
 include/acpi/acpi_bus.h                     |   3 -
 include/linux/acpi_iort.h                   |  24 +-
 include/linux/acpi_viot.h                   |  16 +-
 include/linux/iommu-driver.h                | 250 +++++++++++++++++
 include/linux/iommu.h                       | 101 +------
 include/linux/of_iommu.h                    |   8 -
 33 files changed, 1649 insertions(+), 1331 deletions(-)
 create mode 100644 drivers/iommu/iort_iommu.c
 create mode 100644 drivers/iommu/viot_iommu.c
 create mode 100644 include/linux/iommu-driver.h


base-commit: 68ec454bc1514f557686b5895dd9719e18d31705
-- 
2.42.0


