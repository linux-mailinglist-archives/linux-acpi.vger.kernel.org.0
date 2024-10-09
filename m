Return-Path: <linux-acpi+bounces-8659-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F7A997172
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB0E1F23BAA
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC1F1E22E3;
	Wed,  9 Oct 2024 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZEs+Ejn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551991E1C36
	for <linux-acpi@vger.kernel.org>; Wed,  9 Oct 2024 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491013; cv=fail; b=PRI5An/k9nFtEp/WNRE9oXFBwME1Lt6y6IblT5CRakRYZJgu92WyhOwaal3x5/gsA3o+RFgQR0KKMatdWwnVczbyRntqRuPaTdUmDu68oCBwwh8pxGuzfZYk7fPqcb55elPv6H0VABksVqk5od6rwC9Vy1NFB0cP/lrJp5CW8NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491013; c=relaxed/simple;
	bh=mKT1IJJeKHX4ypen5n7Whj6rhvt4w+VnV0D5xGA4VGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oofrV1e4Y6I68p5q8arbPMmNPf2V88gNMbSVVh4TddjTIeei4TTBIioqt7L3AG2Rodgy/7F8Vdw4LAwtOynDDqpy+rtpZAgQM63LvDLDxI+SzhK/L8pusZup2hT4+cv8Pi2AVAabnN7lKUpVC1He2sN8BeAD6yIVKjlNiLnhIUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CZEs+Ejn; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Loj2TqiceABW4PO3prqsIgmEXZkYUekzH3VuVJ+4TASz/xXNp84ixFRUUQG+YLL8EXppLdLx7c5p0jStBmAlNAzlBbuWmE/6rpnpFC1xQUB2nb6/gFa1Me7OgR4VcomcNNiudcZgksjbCCqvsIm9dpOcyR1D/5yR+dwhIO3rSk7Dhumh/JPocfvSOip0HFCNwrBWvJKpVcPfDI+WxZA+LBm5VlY742qyIGa2JE2WgcHtk90UzQsApNyjoTAr3Qbi73siMX5pwq1jgOA9fAaaRrs5lYNRqSp/NREixazR22sqxl69FDUprvJCPYupjkHH0WJs5xBi4YFqqjWFGL9esQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM/OqRVKfdnk+8DUpdClNjxJr4a69tRo13nfkCjpyJA=;
 b=eVSAmg5MOcC29o2kC5Q2kaGcxAF3YFv0k+Fn4l5njeIfJ+h5nOnZn5xwmkMse6/AzGEerzuL6q0/PSZXll2XZq9zWJx6s0TNtPO5VAMhZJadwFKkUJXT+BBIz0RAlafHUT7pXjr5qn7n8DpKvoxItggoiDI2pLxobWk9CcjWOpbZQfoQKVnTWdWbGaJ/P04Cy8zgUzO8W77dB/g8fB9rvrAQco/i2AZ2ANKpjv7bpLr2wc7/8G7UnUgJVXxQjRrSWR7EUA7APziwBPsXAOl9R6WLK1SUBhU1rQCJeUlfXKoBy00Kw83q5vpw6AZsJjN+yJzXF0Bw1aAtAHBm1V9sQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM/OqRVKfdnk+8DUpdClNjxJr4a69tRo13nfkCjpyJA=;
 b=CZEs+EjnQu+7dwxWbDCjVec05nOucftxscXNoyXH/Z7yzX0rIVP3+F0ZSd/DN3AEgCKfZqhZDNjQO1jnRiT5qDWp5UhAbM59/yerxYp+H0/bg+7PggdMPrexT2XEdywqM08uqAFbQZWG+VGet7wNF2oD74XiNIJt4YlyCFaC8xuzsZ1Oppq37zAmesD1E3URUo0hnONVp0vkvepHxV37KqaQm3kpkrOuMu+cfrO7fAIcjbCypq7HNx1qgJNf2Qe5FLMbRoqUfqsvMUJHhdiCr43I4f+F7bSzUSmuxjnZbCVlKi2+A78fdzdhGwsrrlaxj00rjPhtquIz2dJ49GBtiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:23:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 16:23:18 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: acpica-devel@lists.linux.dev,
	Hanjun Guo <guohanjun@huawei.com>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: [PATCH v3 3/9] ACPI/IORT: Support CANWBS memory access flag
Date: Wed,  9 Oct 2024 13:23:09 -0300
Message-ID: <3-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
In-Reply-To: <0-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0150.namprd04.prod.outlook.com
 (2603:10b6:408:ed::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d76295-0202-478b-92f6-08dce87eae69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qnjhu8Bde1Oevx+ZcdHbbvYD8XC2lv5KVgjNlEl5UTmdQpOd6wkJ+fqMPIOw?=
 =?us-ascii?Q?H2bP158razPk6Yl37NgeFaRAGu2n1KTM/TbN4r/YMse5MeAgL0qVz0yDj4Jh?=
 =?us-ascii?Q?r+sijxQbL8+xovFPZ3dDWToFqqFE4R8cvt4Fx/PkpQl6dmXCZcstV/hLMCbW?=
 =?us-ascii?Q?BGSu9N1fuadwcnYW77VzxQi7MQuY9xwVUNzvTqPeh79ISZONgG0rZAa7ya5p?=
 =?us-ascii?Q?TSQxKTC15XmpyszAq3Lo6fCooWbmJMpDmBgUFXMEkSk4HJ0ng9ptx5669eY1?=
 =?us-ascii?Q?+gOeJOk5T2efb1A9s8rc1FPOOniRNnY4GvnwpIfxwyVjoqObG5AhqeD4GARw?=
 =?us-ascii?Q?7Sn9En8McfzlAG1Fbf34KQwZEId8S4cB2E2c2c97SAllHCF3ke4nhcvmhwme?=
 =?us-ascii?Q?BU9Oi98gTEpmrrbsHhzkHUyQdCEQxMJwJlMCsxOqbJndhSCVIK947S7tkC0e?=
 =?us-ascii?Q?KLHXxLu0vyzogoAxwD9IT4aJaJISwbSbvZowqpiNtgzQG3kBwGWWqWZl5TTi?=
 =?us-ascii?Q?QaLVfK4fn/T+m2s9WFhqtpTLaA724JR7IOuLvOHg/3bqS4Wf4nE8LbKkF51c?=
 =?us-ascii?Q?iMoKs3xmvUlcmlHr+rs67WL60OuTdnaZ9JZ/GaccXnxmSysDw6FO7ZmRDA96?=
 =?us-ascii?Q?uin/Z56XG07yGrmnVptpZOsCtGMP1sFUjLo4LQSedLGbodf/blD7ReFNprUb?=
 =?us-ascii?Q?R9wg/WlvHkyo2oKVwLdFc1RPpDEvgDF/KePKujKoDvV6poUzGkXwsscN1LzC?=
 =?us-ascii?Q?+PqoiSt1YXrRqjwL8ylGX17ZQ0vVAMviXKYjBdjuTPHZUS/ER615BWWXTOOs?=
 =?us-ascii?Q?ufCn9Cx7A+5V+yo2rM5rNSl2GhU8m7w8SQcvIxSYgJ06WRIRh14oXSQp8cfO?=
 =?us-ascii?Q?Z7XdQZJrvhlA+FxbIs9WaG45n6V0t9o/9ZXJGVXbzd7zWhfNrkvroonTjGit?=
 =?us-ascii?Q?KyZ1hWsLim7IilvLC3GS1ZWZAPHBHMS+XSO3bXaQkeSpHq6+vb8J3cXNvrzO?=
 =?us-ascii?Q?65Vlro2u+6k3rybCQuG+091Y5FvStuFSOpTysIT4WkdI8wX4+bTeMlsPeeWA?=
 =?us-ascii?Q?UmUDKaEFhljJUHUEl9fgT+AcdifYXpkPiglvMuKlT9wtcSlDO9AnzVHKZ93c?=
 =?us-ascii?Q?+bfJm7/SIVQA6MA/nrM8vtHJOTkDEgs7JWJvt9nqiFXzfjFw10i145lr6ka5?=
 =?us-ascii?Q?RXhG8UkM3RH3GxwdhPdz+Lu+gXDh6LZWvzFjj6y6uPw9T/nCiCUzZ0aUMRy/?=
 =?us-ascii?Q?E4lcDYWUPN5mXxqbimcpjsS4WEJC4XGkZr0Oq1JA5Rxh3zOmMdiNBW1mppHG?=
 =?us-ascii?Q?dK5SkceNhqRf8XojuHbz91cp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qxlGwldOWm2u2AuF3q5eCits0aUWddCIsL2PvyruTQN55dyrKUrHQ7riK5j2?=
 =?us-ascii?Q?ZDF6XHFcJ7hkRCbzkQriL85G8tra8v50kYQsMVcjO4MK2plvfiiHGzuc3EYq?=
 =?us-ascii?Q?2LsvSReBnP1mXNt3QMcj87rG54pppplGV1Em/BcitawRz8YPnGauneX6qE8G?=
 =?us-ascii?Q?yrlIonbY1+qtLnrt/elc5Juk4giOc1swC3uCLZV9yd6gPsQAXl2NeFTioJYO?=
 =?us-ascii?Q?fQ4vuzS/2PToBlE+R6q44iQJ7c2PTSU43vIj7oAPhhOJi1FYpZojgv6XcfWV?=
 =?us-ascii?Q?ZI+GDBhp9ERV56VK0fMC6ecIGUP/8VXN1/hle5LEvQSLvoN0pUV98h4dKvgY?=
 =?us-ascii?Q?3Ei5vEvXKdixcGFCWIoduuNZALUQfrhMHTnSuYGGMEKoFfSOqcpw0emtUHM8?=
 =?us-ascii?Q?IYXyoxIeHBSYPxfUw1VaTcQPMDMBs5+6PdHIalVU8yNGankzQcs4aEFlgiJe?=
 =?us-ascii?Q?8g3T42I3+BI/ce7Cgwn1+/hh5kjRlXEQyXBtD2/Na4eVlIptorilqGN5OFty?=
 =?us-ascii?Q?tGWc7j3UoYcEec6Z7CfVWzS330AYudpUjncHF3PgglACJdfdgt/3PzkFvtlh?=
 =?us-ascii?Q?95ev2r6nD+gziGdSs2Dsd+VCMMNFO1EO+1XfzQ59t0F4JlfRMPIoBUhzV1/I?=
 =?us-ascii?Q?/ojYKV2AshupFvuTUGZm/Ghw5T3kNo17/FK5qfFQbgFPeaIocBsdnaQuduH2?=
 =?us-ascii?Q?ZSppvfDpitMGofBvgVc1Ya7qyKJDxtKcrzep2iitnmRUgjXsI9kwzl3Sd/Gj?=
 =?us-ascii?Q?EnBhaEGRIZLg/YUwU1dPKbFeRCYda1M+7jARW7p8fDXD/E5OihPKXBLT5xfy?=
 =?us-ascii?Q?uwHpnamhiKFYPlhVqhZGY1oMDpZYwN3vVvnUESxQyUmbCfTT3XesDZCA3Kq+?=
 =?us-ascii?Q?4eHoJpbtXLnj/ju5uwMAi2rYCnBbTGMp36yx0/JOdndVKPUmToo0OOGNObPQ?=
 =?us-ascii?Q?pvFwqr2o98mE/csDuCPpFkFN87j/48RUDWsV4ZrqQUgZT804eV7MCy0QWN3R?=
 =?us-ascii?Q?hDeA4aYJjjLAsuGUVzKroGtrQJRYRBzWy8Yx1T5E5R0k3+V+m/U1X2jMGcBg?=
 =?us-ascii?Q?jPBD5ylMpXThPita4NzdEoSDJO8qY5v1STzLefg6l1QfTlkPd8yjx3kB0Ad9?=
 =?us-ascii?Q?Ylb1YCcJ4qnzLMLTjsOZWumPm8sxzeid+COAk9AXNt4R4wWvRbRSxMf8lnDD?=
 =?us-ascii?Q?A/AD+Bhm2P0w7m7LrWDdrmhfS6+aNUY/P9ofgw2gRiA5ePHQiS2vWddYtNO2?=
 =?us-ascii?Q?/g9eGf6AJYFMhr0/NSPCK7nP/hKGcFtxF4YzHfki7l2PPMHFZVrUNgn90rre?=
 =?us-ascii?Q?HL1llzu+FmaJwFM2GO8RJp3eGSEcvU2EwEU//jJ3GCt9AmuI99SfVy+18E1e?=
 =?us-ascii?Q?5snp4i9FRnPElug4XELZimjvNZeY3RN4ti3VYBwbWfBLEmyTKm0P4dG8RPib?=
 =?us-ascii?Q?zkoTVFslnGLf+UDxHvOtNpXYlkc2ees4P0shWAXa0+jRS30YMmvsYRTmqpie?=
 =?us-ascii?Q?hmq2v8LLsH6vTbu6GPd1NQGl8GyeMr2Pl5S+F95Qp+EGk58W3Eqi3SAXSGkj?=
 =?us-ascii?Q?JpvBMaZ0c91rdDeN2ng=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d76295-0202-478b-92f6-08dce87eae69
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:23:17.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzV3DIQp0gkbWnuegAh+abXT7GjefFb21K/DvB7YXRKGbwcc7TYdp+rAtV4+a2bI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073

From: Nicolin Chen <nicolinc@nvidia.com>

The IORT spec, Issue E.f (April 2024), adds a new CANWBS bit to the Memory
Access Flag field in the Memory Access Properties table, mainly for a PCI
Root Complex.

This CANWBS defines the coherency of memory accesses to be not marked IOWB
cacheable/shareable. Its value further implies the coherency impact from a
pair of mismatched memory attributes (e.g. in a nested translation case):
  0x0: Use of mismatched memory attributes for accesses made by this
       device may lead to a loss of coherency.
  0x1: Coherency of accesses made by this device to locations in
       Conventional memory are ensured as follows, even if the memory
       attributes for the accesses presented by the device or provided by
       the SMMU are different from Inner and Outer Write-back cacheable,
       Shareable.

Note that the loss of coherency on a CANWBS-unsupported HW typically could
occur to an SMMU that doesn't implement the S2FWB feature where additional
cache flush operations would be required to prevent that from happening.

Add a new ACPI_IORT_MF_CANWBS flag and set IOMMU_FWSPEC_PCI_RC_CANWBS upon
the presence of this new flag.

CANWBS and S2FWB are similar features, in that they both guarantee the VM
can not violate coherency, however S2FWB can be bypassed by PCI No Snoop
TLPs, while CANWBS cannot. Thus CANWBS meets the requirements to set
IOMMU_CAP_ENFORCE_CACHE_COHERENCY.

Architecturally ARM has expected that VFIO would disable No Snoop through
PCI Config space, if this is done then the two would have the same
protections.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c | 13 +++++++++++++
 include/linux/iommu.h     |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 4c745a26226b27..1f7e4c691d9ee3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1218,6 +1218,17 @@ static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
 	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
 }
 
+static bool iort_pci_rc_supports_canwbs(struct acpi_iort_node *node)
+{
+	struct acpi_iort_memory_access *memory_access;
+	struct acpi_iort_root_complex *pci_rc;
+
+	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
+	memory_access =
+		(struct acpi_iort_memory_access *)&pci_rc->memory_properties;
+	return memory_access->memory_flags & ACPI_IORT_MF_CANWBS;
+}
+
 static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 			    u32 streamid)
 {
@@ -1335,6 +1346,8 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 		fwspec = dev_iommu_fwspec_get(dev);
 		if (fwspec && iort_pci_rc_supports_ats(node))
 			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
+		if (fwspec && iort_pci_rc_supports_canwbs(node))
+			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_CANWBS;
 	} else {
 		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
 				      iort_match_node_callback, dev);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c88d18d2c9280d..4ad9b9ec6c9b27 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -991,6 +991,8 @@ struct iommu_fwspec {
 
 /* ATS is supported */
 #define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
+/* CANWBS is supported */
+#define IOMMU_FWSPEC_PCI_RC_CANWBS		(1 << 1)
 
 /*
  * An iommu attach handle represents a relationship between an iommu domain
-- 
2.46.2


