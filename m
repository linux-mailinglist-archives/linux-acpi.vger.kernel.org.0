Return-Path: <linux-acpi+bounces-21513-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACoEE246q2lYbQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21513-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 21:34:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB51227885
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 21:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9684A303527C
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15E63A7842;
	Fri,  6 Mar 2026 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nuHoKtiP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42F401491;
	Fri,  6 Mar 2026 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772829289; cv=fail; b=EtIPmIiwbBrilwtrvNnyagDHsddRsycPD8r3S3I4n/4qQDfSqnR2S3/Ar3y5jW5eb7Lnz0mxQS56EjBQPE3XVXDFkurqdhGP/Kpur18YJSikU0mnhCGHqF+O3bOfmQum1VDvKrMFHWxb3281df/9rw2T65xesFcuCGtQAjDRl68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772829289; c=relaxed/simple;
	bh=hU+3AOn7qoXsraKVRfRYalx7vzl7n3W0OpQYIIGs3fQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVDmRYknIbXrBPJTLMot3mIE9L4j0zEx11GdFye8u+qnI0HxDAg8mXgV3X3JfKngQ02nNdxzzbqtJNP4ui2ZAXmFGHEDXARveoEQgQyARX90lz8pqYFhBm77oAMPx6zyY9gGyaglkcQ1VCXrQJ5qDgw9mutctgMQQN8/oV3Ypps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nuHoKtiP; arc=fail smtp.client-ip=52.101.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5cR+1CPbhBerugUnk+h94l92a2aYcNxaNVXP5Oa7y4rRYIZxi6CIuoNKiUqIa9vjrBZv89o8mgNJYH177gG0d3znDgHodENNfuq5D2+z4yQwLdWY1AJ06DaHOKzPQCYTkf93SVx7YqaVOWwil3asmbKB9LpeejedqsSmOd5Z5LQKfw29l5A+z98dMXJygXg5ObjrsreD/9AbuK3RK9KLGiScAlaI2o4GfNibV3c3eom3zy0Yi6M7EA1S2TP+MLqtAERuJIAIG8f2r6KWvhg632fESf1N5d9OSGkXchhtwWK1gowd67uTgHHxKyuh/v1OfgMpuQjgj2s5VebtdhyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8ufeJsa3MK8ser2lwzc90T9eH+rxIPlpcgTt8VhutU=;
 b=DXH2l7kuuEdloImaeD1T0F0JPOWNP34C7Sjz8I/j2ECBSwk2ASn+qogAL8QPk1dacjDamAAioSeRfd09X2o8e0+r0NpEwdw47bDZl7XufdFg5SBkdFvpqgtNeqv9DaYCjgqQAHDH9fYhbKHKtYFfZPOKAT8Cnk0+fvYeMwKqOmn72ge6dg9NFbdX41y+I2+nbysHAW/rKaw6UOmp66oQW5BY71vXInUrEE+5U6USOMuHagkj+4lBbR3TmuUoTyvbU1H6q1MPYwWCUWzH59HsKTP8F0R3MRkT2gychAXGnDhJ6KCCso8cXr7dDZOPtqYdybIlAaRu4pf9Y67XbMJmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8ufeJsa3MK8ser2lwzc90T9eH+rxIPlpcgTt8VhutU=;
 b=nuHoKtiPcV2A/3wVNMRgdjUkiMYL3jqYlBQa/v18h7GqSsCTKJRwhx6/CU9nCrhFCoheXWeMGFEr2E9XiK0aty6JtLD4f6WM4XYqTV/R7wzPVeQoydv0bFn9yZU4MNKUfgmYBu93j2BF8StxmhuJPeiNe65R2NHYgpAzg/vQGUjUq+wOQ87+CnBmetbf5oQBVBTg65RkDIhiZZd3IwhYCYYKCb3HpnbULYvIqYiTqwPfM/QGesa3/3yQTduWFGJxZoWPIIRPEWVI/oiOaiAvTSp+p/oOZLafG8Ov33SaMlOI5Iof0kD6tkkT96GxoqMtxhCaoq2LM/zsonyAKyaPjQ==
Received: from PH8P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::13)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 20:34:44 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::db) by PH8P223CA0025.outlook.office365.com
 (2603:10b6:510:2db::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 20:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 20:34:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 12:34:27 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 12:34:27 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Mar 2026 12:34:25 -0800
Date: Fri, 6 Mar 2026 12:34:24 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<praan@google.com>, <kees@kernel.org>, <baolu.lu@linux.intel.com>,
	<smostafa@google.com>, <Alexander.Grest@microsoft.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <aas6UO1BNfhfY2hl@Asurada-Nvidia>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <60d77adc-d5a6-40e2-a497-a57004f23e7e@arm.com>
 <20260306140115.GH1651202@nvidia.com>
 <aas2kHcjJPYFbKSD@Asurada-Nvidia>
 <20260306202216.GO1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260306202216.GO1651202@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|LV3PR12MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: 834f47ab-7d7c-4441-0024-08de7bbfccca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	HMRlHGT6z5pto6/zzRTFcbHQ3SouFD47MwcI3KO/2rQmmAn8sfL/93jkzpExyoz4KaaD8J+sJEMG2p+ayk2wLRbnPzNmdYbP+BYO31tm0MqG9XPde48prY+NlaK/srLfqd+80qkGscJtVpb4b54Q/zBw9OhT7lHw/lb4/PDf7JXxp2W4kJoCLldjvn7JRH1/M/kQIHxPrhIhOBJc4hDm87GwPwK31Zb0tdELb6rZCs4OC7zB3tdIHOLsM9p9isAltf0zI0bChrJcuoxAg5Bp9s8zOoOMvzP8i96qvx+jmEoCbfVH1YdUHGy+bl0k6/4loMS0UBDlQqNKkjOlpywCDSum7Jm5KD1oFqo3gmi+etxyUEaVcVbbyT9LEUzNjMMIfGy7BC9fBWTtEcBbFNyl7Pf5sPRXVmgVfXaSYK0qMMTO5jzYjgLckRDoUTdowqRiz8E/nsD6CUmuVCzNnZ22RED/RaqRGwwgbyJTFwoWd10OMHl6n+8FJYuetk8hekfdeKU2eWkx9VKJQSr02ZDDgyLSGuBCs7+lU30ibDX6Ei++GX8Q7DVZxvMWsVZ0jw6ui6t5ZcQMuE5GDG3ot6s0jEGy8Z4n9SNPxZKRtUO10dcJjRJT+q4wtq90Ffq6K5qSa3LQkhD3IZqEiz3nDF1cYvE+OAOuOI+rPgmBsZcQ83IboSS1ZZW4OTDfd52yWQPaj18I671DzSFzUowcM2ChkiYeq2MVnAiqoI7KGTqc/P+4DqqJEcfzWZUE23N7kTnbJh5dWNXx3rwi4UJ5wdfDog==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AklOSyOY3YvtRp5LTuAQyLnEgUe/ffNjiTuQI7RShON2l6lizvgdhnx1CgGdvcSId4jfJ9Ziz2urplggiEacpReLiJ56zsi2Kd5/6T2mPlYGqZqZsJw7v7wVeNIWsdtpvstQmAmNVyUbhMkM8SIVB90jIQnicrTjC02PnJ6tzcVG/rUg6LG4YEpHnJXH5/w1Mw59y4ab3vPUIfBMwN7q6ihCvraJVp0vwLM5BPbhRIijeRYRavrMs+bv6YCSGHROIrPjh+pb0xnKznL5MP27190Gxe+fQo64j1XACpEMVFptc8MVnkkFY7xv64+h3n+oD4+PitZIVnhSgRkFKFnEMrQMwBF2JwJ79PoS6lICLk3/guX0bKKp2cSO/pDoe0x4q7aBfAp05DNFyIgWOVfh0scK5AF44zlij1NJqtKOhkvNzq06M7TFTnxMYyL2H4VI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 20:34:43.6739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 834f47ab-7d7c-4441-0024-08de7bbfccca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094
X-Rspamd-Queue-Id: 9FB51227885
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21513-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.962];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 04:22:16PM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 06, 2026 at 12:18:24PM -0800, Nicolin Chen wrote:
> 
> > IIUIC, we would have two timeouts to identify the device(s), so we
> > wouldn't need to give away the optimization of batching ATCI cmds?
> 
> Yes we should not harm success path performance to compensate for a
> RAS error case.
> 
> > Will letting a faulty device time out once again give it a window
> > to corrupt the memory?
> 
> No, you are doing this within the flush callback so everything relying
> on that flush should remain held.

Oh, right! I didn't see that coming..

I will rebase the next version on the invalidation series as we
have multiple things relying on that now.

Thanks
Nicolin

