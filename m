Return-Path: <linux-acpi+bounces-8657-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E7099716F
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 18:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A30D1C22C12
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6CF1E1C27;
	Wed,  9 Oct 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d50cU2wX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F231E1C09
	for <linux-acpi@vger.kernel.org>; Wed,  9 Oct 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491008; cv=fail; b=A5rT0oHr2oBT52Zs2bvy6J4PzDR0wMClSYnMRh8Lovv1A9VKj7btiIsidBUQlKSeKlZFfQBfvCfIHfZ7cT3EOSapX3Qsm9vMYWJqlajh7evevwPjs0+9DRysSfZrOj+rrMErL9o8RFldzg1hJU1uy5OkNYXP9KMI3DAnqn33+5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491008; c=relaxed/simple;
	bh=HLgJSx9zNbLKmh+2CXeB+LrMw50jskRmGn9phyJNGss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3/Z905OxhDCq/at7rrw3VTZWD7VWIcxtdoe8OCwmFf1cxF2g55C89PXXjMGyh6cFhY0BeTRp2waUMoiGE0f/Z7/kJm4OEbvGjfR1AUfEyTxAlo5TxeUL32ODWbaoodSZvp+UWvSU/a7bgp7l1NnXrbbP2Kx7jAt1I3WWONWHac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d50cU2wX; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgANiwPFZXeKoUJymz/WPW8JF9ralZ/w7KSUo/dlotwQvZhrjqgc0uGtHsmx64NEcQ9v+aerPSSriQzD1KDjgAw+jOvojd/K4fuuSvkTYe8I87o/Y3GmypWfEKmcLSK0zAL5Tw9QpjW88e7gJvPfaqa6iVgOcudrfjXgkkXFA9MymrkBygDDLKm9t5Ad0A04SS6vtGEfv4w5AoCwn0nFVilnU62djbxGv1/vIQJcKBG7qXgjcQ6IeVQHpEz3CfBV2zM3OVxjYTbHq9PxNTF6OLEO+2rY8QkB84zk1VmGhV/7xfDHXdMdTO4GTc8xHiw0igEpqHY4C+GxAnrklwxKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpiN5oo4z3lvMmB3amQBIgcZf9ooTUIzQ5WEgszjOO4=;
 b=JBne/XsaUl58Ov+HzrthiGsND6PCL0HOYIEpCntkTxXgqaMgXj4Ifvnw8LVlRe8OoLLc1ihSYm6THhVRqPeDPY6cC0mGMlPzp5G1C6XYuyXEgLEVOhBPVkxtV1K67OMFZmcTQgega2K0zCldAAlunvnRVTCC477eBA8fMOsf3YYpfA1KeKPz+EHFHEwlw9uXIKbu7x1q+kr/Q+4Cn1AfFQTwdaaZj0d9Y36R85+B/i86b1AGnGTD1Og785Oq3pJxAqlEUoBJd9Hp+09+fRlWr98GgPI9qTmZUZEVaO4Q5h9sj5mOucaI+eQSw1z+EO1dED3pvF8jXt7U3kTtFI7huA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpiN5oo4z3lvMmB3amQBIgcZf9ooTUIzQ5WEgszjOO4=;
 b=d50cU2wXXX4tpCgnPtBgw3FI+ThGtUmAiTH1UQ5VGYyTasQgEhYu2wCWokHn23qcV8EXFUzvuzAfSo5MQGPxiiy0BEH+XFXKNJFxIgG6eeOkYmFMcmZr6KOMxSSZlYjy43ohiSfWCzS6rojnuVWBQZJ5GCzF8Fl03LavhdeTe4q/+0BjDqafU2Ymhe8t+8oMPwzvRfwlhCGJ2ACwVavlxKndRy7zhe2LxPIVSlJFcgSiB1AsPJ+dodEOaBcVr25bIBiAqP9yyM9zWojGKkCYieC/vMxvtVYOyDh1yaPS6+ErHfGBZJhJB6QOmCTCrH3k5YSiZqVSooL2f7NJQ3CkyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 16:23:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 16:23:17 +0000
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
Subject: [PATCH v3 4/9] iommu/arm-smmu-v3: Report IOMMU_CAP_ENFORCE_CACHE_COHERENCY for CANWBS
Date: Wed,  9 Oct 2024 13:23:10 -0300
Message-ID: <4-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
In-Reply-To: <0-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5bcaba-4be7-4cac-a8ad-08dce87eae39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SqFRJX3mx2+QQomHypksFTpSykVYlvBUUQPHfoxgDh9g3zW2kDl7aWsxz4rj?=
 =?us-ascii?Q?3OEntwiGVTNFGd+ttcmrIzwAvnLGCRE6QcWrFb3+SdcIdG0xZlOwoifYkT/Q?=
 =?us-ascii?Q?uPHIgxyt2MKdt4QaV/mvvrJNWUKfEoMvZxd5Atn0IhTR3iSweLtM9mJu1bYi?=
 =?us-ascii?Q?m9v0GaVMtTv023jJKTspzbSmUfwK6f+ajxP7bQ84/lMJqqEKxQ3JEpo1RL7s?=
 =?us-ascii?Q?2XMqqE7ARDr4YZ17z4zq4PL3uGcmHOiYIe/H9UaC2QuX+JmprU2fOAPArZ2f?=
 =?us-ascii?Q?KgljOlJnCX5sycy6+g9XFjNZpVdy5WViOhGElcgQHbMLGKEAVSH+jKha4ZvC?=
 =?us-ascii?Q?j7G2D+xMFrj8GHYGLAyk8T5WAxg/GBnNDuPNsnpbF8zqp8BnXD/4frmZHWgA?=
 =?us-ascii?Q?hOuLoBpikq5zuEFvxUqmfFp1BagzzUUYx9CkTJRq1wJz3TJormskKjHAsUkk?=
 =?us-ascii?Q?MOS3Y53/3qcvAXYdG/rEOLogeKflfTnLKg1NPnJc5tjZ01F2gbjrVkEMM9eG?=
 =?us-ascii?Q?2O8mok4o3uMf+jr73p2mSDcDt02QVv75IWzq2Z23Y7uudp0hRp1ihfGfg4Di?=
 =?us-ascii?Q?YJ31fcdBbOif3muDmsAFtYu0mkuuc8MzQ7nB4XAPNtBdt1ZfC0VXIe5g+W4f?=
 =?us-ascii?Q?JNpkRfsBH5ph0i9VCiHFPXYM5SbyI0e3BmXKeaBjLxpRVlu8tphO4wl9i0tJ?=
 =?us-ascii?Q?0V9S/+G8MHzU0zGTFBZ5ysCjh005YmSfoTkev7tvLTubpoiS+AAwLPWVUfvf?=
 =?us-ascii?Q?rq48jVqAPTPdMeamb6IU4YS6sSl/TJhkE2zCFxdceiyEs09QZymDo6bJlhIa?=
 =?us-ascii?Q?0qTHu60MP1PWaUfZCz7ZeZORjiBihfRUcTUXluFFbT0bpOkZX+QcmNE57SYW?=
 =?us-ascii?Q?UK/7gWWs0EEiMJbtMb5Xh3u3/MHekhoE/Ayy4yK1OfzHdP1NhmJ5QTyxTMW1?=
 =?us-ascii?Q?bvtN49CKoBekKoBbH/AC7ybNDsEXIdDKZUjToWgjkFgpbNMM0xlHPt5JY2y6?=
 =?us-ascii?Q?+Hput1qPe4A4yWQ4QRpXdmlhNvFr9nThc+v/X/nZQAFITWdKRIbl/dyuWQ+h?=
 =?us-ascii?Q?vsTlCCL2vs6wqmSvA5LR+L9p91F8REF9fDt6oW1IlAei1sbgF8O6r853MYRh?=
 =?us-ascii?Q?TOjj8DzpJO0GZPVqjXZZsc0JEy9KQXpvXblT5qD9Oki1aZa9KWF0h4JLj4ei?=
 =?us-ascii?Q?/RW+3DWCAOt9GecxJHGkttNJtaRlIG3pAHkWQ+GJLpOGD92M4Kzf74qT8EyO?=
 =?us-ascii?Q?8zTHBHYqxoa0kdWABWpo50z9a4HhfWLCG+ld0DNf/G+Vq+Wg1SvmFMOUR3p1?=
 =?us-ascii?Q?8szIwCpGMutzM8sh1QlWsazy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?irmSj1wv0w71F+l/lFBXKHLFY/69FiKqeTKm1i+hz4A/mtEd7QCc5DN+cJNm?=
 =?us-ascii?Q?45sutIlvF4bywdCrHTVkggSZAdbYI7Q7YXh7QVjnuDtEsSh6McL2vx57uBO3?=
 =?us-ascii?Q?/7C5fn3lG749IAlnCfLpm/gJTFKOlZ2B2y3DmPjBJrfdbNQ1Rd+PklFLCMMu?=
 =?us-ascii?Q?GIn71tQzd4LIeMzgf18WNe0J7PfVdGvBk4fVDBvGtE6gZuW42eJKZHl7zGbw?=
 =?us-ascii?Q?2HrcLS8mdS0teP3MTTwyz+xAPMpoW35ejE+7XdgDAlr+VwQcG1q0IMIuDoxv?=
 =?us-ascii?Q?rdpQmuf1c3A0stsfqCQ9rk9rWrOL+1XnWtf1cZnQQvRIlN0stMwP5akiDLvo?=
 =?us-ascii?Q?f61vC0pPLAwBnOv0qIHK4DhHxWvt++7AKdlQtF8/Nc5ndQDHys9yVxIoyE3k?=
 =?us-ascii?Q?96rbDuFwxGBRJ+gGtv65BO4y+SMozK/PehiHOhUgfDsmz/uwYHTwIhhGT88o?=
 =?us-ascii?Q?+MeChd9Ukx8G9EorpZFGAgq1Z+knq9BAlvzG98BlmwBiuHPQ8TUHgOxgNpFA?=
 =?us-ascii?Q?TojnR+ZFlM3jHSAuIZyXDq9b5z8V4D6Xxv4WXHtErHf3U0N2HX1djTx6/1Xm?=
 =?us-ascii?Q?b6RbkD1SBfQLm80fDE+GcvDyu74gPawXJgUpHcN/BTTGClK++OTI8jDU148W?=
 =?us-ascii?Q?dMVBUqhzurvA3TZyxjHutPc4nEpJVpQR7Jd33B1gJQA7pQ+jUPUVX8o4rgI4?=
 =?us-ascii?Q?iv9z8CtiVpsIqm4c72MYQlnsfS3QkodBHvpBwe8v9fTB0RejdeWS8e6QqUcs?=
 =?us-ascii?Q?dHW1iOslZMbOrP4B3tX1vaqqpUw+vr8ZtSsECti37GaTmm4lPZVlIGAVHmBk?=
 =?us-ascii?Q?FD3xo6YxRUgsykOSOin1Klu848XHLKrH/ZFn3yxBSTpcwQUjesNxTf5z5TTD?=
 =?us-ascii?Q?9kFsREV7MjE89tBL12Gy73sonu8qeorn8xZZ5rwBfyZePjkJ41t2Br3T5vQ9?=
 =?us-ascii?Q?ZzEfaIz3aMSLI/uyjUOXrezo4tmVx8edLQupNzbOQPYS+IkmfRxd+CVsADdO?=
 =?us-ascii?Q?QD4F1jhmlZeMDQXXZCzWC8gEDjVR7CWBfBJSjucKmm7Y9260s3nm8lfhXI0E?=
 =?us-ascii?Q?UIoXq4aBo1up4fiv5yo8uSCrLsWP3bsWLU8n9bJKfRcC5/6ps4+sPUJhh5v3?=
 =?us-ascii?Q?si8v8qCSUgecfu64VfxJJeicjOl1cyYvTj4+y1+o2+UjTz53JQKVIwWYIVH9?=
 =?us-ascii?Q?3wzAvWOM3yddHyDVtdD0k/RvKxoz0eXJHBR3TglLsCX61tI66wYznbZptQtG?=
 =?us-ascii?Q?SWrOuFLOIOSOBFW5udlNketN8rJXCfxVDXJJpK//qp8t6pY27f6YatqYG0Sn?=
 =?us-ascii?Q?mt7wuwX9U7FcRSGdhcWFSraT2eWY6nrJJmOq7IQSr8t3ouTN7JeilzaoV7uQ?=
 =?us-ascii?Q?4iNrSUukgIfc1CTsYqQ4SB421mZyffmqujvkN+ZyScWlOuz6sdGRkmy7kc98?=
 =?us-ascii?Q?eYOGIZ4OgC9UeFBvnhDG/2uAalo6xgpkVTYcCsZzO/YW2ol2rhmKlLzlPz08?=
 =?us-ascii?Q?YRfflf0U7BhIG1Wz99CitPamx4wiBXxC2wxOjvYQIVYL1PChEKBqKwkJV2rm?=
 =?us-ascii?Q?qFy22JqPDR31kmXPepc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5bcaba-4be7-4cac-a8ad-08dce87eae39
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:23:16.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZi9RBK54LUj5/rXkaHwmnHi29o5N0cqg80YXVErXrHS0v9bovmVShySAx5LmxPC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073

HW with CANWBS is always cache coherent and ignores PCI No Snoop requests
as well. This meets the requirement for IOMMU_CAP_ENFORCE_CACHE_COHERENCY,
so let's return it.

Implement the enforce_cache_coherency() op to reject attaching devices
that don't have CANWBS.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  7 +++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index acf250aeb18b27..38725810c14eeb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2293,6 +2293,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	case IOMMU_CAP_CACHE_COHERENCY:
 		/* Assume that a coherent TCU implies coherent TBUs */
 		return master->smmu->features & ARM_SMMU_FEAT_COHERENCY;
+	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
+		return arm_smmu_master_canwbs(master);
 	case IOMMU_CAP_NOEXEC:
 	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
@@ -2303,6 +2305,26 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
+static bool arm_smmu_enforce_cache_coherency(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_master_domain *master_domain;
+	unsigned long flags;
+	bool ret = true;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master_domain, &smmu_domain->devices,
+			    devices_elm) {
+		if (!arm_smmu_master_canwbs(master_domain->master)) {
+			ret = false;
+			break;
+		}
+	}
+	smmu_domain->enforce_cache_coherency = ret;
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	return ret;
+}
+
 struct arm_smmu_domain *arm_smmu_domain_alloc(void)
 {
 	struct arm_smmu_domain *smmu_domain;
@@ -2731,6 +2753,14 @@ static int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		 * one of them.
 		 */
 		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+		if (smmu_domain->enforce_cache_coherency &&
+		    !arm_smmu_master_canwbs(master)) {
+			spin_unlock_irqrestore(&smmu_domain->devices_lock,
+					       flags);
+			kfree(master_domain);
+			return -EINVAL;
+		}
+
 		if (state->ats_enabled)
 			atomic_inc(&smmu_domain->nr_ats_masters);
 		list_add(&master_domain->devices_elm, &smmu_domain->devices);
@@ -3493,6 +3523,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= arm_smmu_attach_dev,
+		.enforce_cache_coherency = arm_smmu_enforce_cache_coherency,
 		.set_dev_pasid		= arm_smmu_s1_set_dev_pasid,
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1e9952ca989f87..06e3d88932df12 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -811,6 +811,7 @@ struct arm_smmu_domain {
 	/* List of struct arm_smmu_master_domain */
 	struct list_head		devices;
 	spinlock_t			devices_lock;
+	bool				enforce_cache_coherency : 1;
 
 	struct mmu_notifier		mmu_notifier;
 };
@@ -893,6 +894,12 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
+static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
+{
+	return dev_iommu_fwspec_get(master->dev)->flags &
+	       IOMMU_FWSPEC_PCI_RC_CANWBS;
+}
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
-- 
2.46.2


