Return-Path: <linux-acpi+bounces-10719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91557A132FB
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 07:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE9A3A5666
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 06:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F2518DF6B;
	Thu, 16 Jan 2025 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vkEJ4+vT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2047082F;
	Thu, 16 Jan 2025 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737008035; cv=fail; b=bE5QSMM+IedEvXxFs3CMypnTu+2kR08oFib0N6CiskdnA58JDg3uVryZ8I3AR6fhuhyhBkH07ShL/O9Yj3Pz4wvJdPm+W1lndGZgoZntkJsQILsKKWsDAXZZjrmBe5pKiWJiicaslcfmdneVzGdXZiDB/oT1ntjrnTqh4pIU22M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737008035; c=relaxed/simple;
	bh=Nmmsg2X/yGB2nFe+yn+XawTTqsN03by305OAyzavNTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RRD1PMC1UXCcRSbpBKNMlfvI1FrU/RsMLRRWLDmIrrw5a6C06lnNqMIamk/Fd/wiDEX+nSWMcjMvtQ8uPvz1RcMaFXFBRyY9P9mzw9hSMwbMFv3fBJgLLElS+vIMuueq57LjHh9vC0hX5yVFIwDV41HG9yz2D66HdEblg21LwpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vkEJ4+vT; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ni3YZ2y7iUGcHFzfJUhlZ+IonXTn3MMwQ5tkpwjY2n3Es3SnnLJCxs4fa6LkKPaPzLXFSTIF210bxv/2EKdexlEz4vUrVdwGoZm+kku/8wjqf656fuMRa7MTN1+0z5HdTfMV6MnhZ4FStUJpuHXul7j4E5TQRtU9ZfZluKAh95rRyRim68bmZ1iM2GVsH200DjJQYAKKNeL8Rq9ZfwvF5CsVaVHzvNUuwwMdZf7hSizOw1nrXg/7VdmniNykAurxSzVAzlM0DpGu/l0Dtz7+q8Z5dspfEkDsYpDTZVkCTr7cNJx4wjLaUh+xH5oQ6urursb6AElky+1beCQru4m2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA3fiNpieu6fodhbBj3VOSULiZGV6EtmU3oMJ+mmPdU=;
 b=K2XRSkDXW1ZItWak9PpuFLcgr7bLgjBPQaU9/0+g2nu+vDF1fgSSsiYfwQJDT6FbPl/g9pUWtrfobjDnw9jp9s8CFNtOkELlnPNVVvkgMDd9kR1g5tkno+6ZvcufsOA6izEgCkqDpRUwtauWs1uiDNSt6JCkeFuZQGe3usHmfbdvIP60xEPcI+5/yxeNlkcheLlFRefToX1IfMbYVoOtVB+AxKDQJB8FVRYguPlmQBhFxFCSPHolr4uN03s63HS/g3kDVSPQxh3nJcrDEQJCofXnSRM4IToPPgyDB9aBLhgPPPa5qEY9F60f3mXzdqWQG4BKOtThKiZChi8ICx1ZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA3fiNpieu6fodhbBj3VOSULiZGV6EtmU3oMJ+mmPdU=;
 b=vkEJ4+vTnppRFc5WKAZIM68cidprKQmt1rRkY7pr4T8AASfN3Nx5k9nUsjDT8amOh+h8nCQLThcP5zUt/g9g81ApaFCSBP4HZTBryZZidH8OhV0uv4vyJClURx9MGdPdiZZaYq2e1j8ZLQYduzJtQyIj3t1Cq2QIjq9Vf9eC5BY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.14; Thu, 16 Jan 2025 06:13:50 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 06:13:49 +0000
Date: Thu, 16 Jan 2025 11:43:36 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	viresh.kumar@linaro.org, mario.limonciello@amd.com,
	ray.huang@amd.com, pierre.gondois@arm.com,
	acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection
 in cppc_cpufreq
Message-ID: <Z4ijkAFOMtVAOY6u@BLRRASHENOY1.amd.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
 <Z4fLXPgMvwGur+pz@BLRRASHENOY1.amd.com>
 <f89fc07a-1c65-4d1e-9ad8-76c6c9a15b25@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89fc07a-1c65-4d1e-9ad8-76c6c9a15b25@huawei.com>
X-ClientProxiedBy: PN3PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::11) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: eb486675-c142-4d76-0504-08dd35f4f166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?em2MMIMwjpVcW/9+mpaxHquseQ7jIeHn1B4voGoSLhrddBIw2xNIisWaDhm4?=
 =?us-ascii?Q?T5ESxWOrSEoAXdwexnruQ8lm0STKaV7XS2akzmBuWz2mNp1W+fCx1/n8la1z?=
 =?us-ascii?Q?IbKXT8DhEwApQc6AseqxfSHxHgzn1hUubvUgUkUwlDDcYzKvO2t0zs7v8He3?=
 =?us-ascii?Q?kyL5Xog6GurUUwKXdvzKgN1NwaTPnfKCgtugZtM0uiIxRxQ5bSUYjuFx1Wt3?=
 =?us-ascii?Q?OrOyt8kVJYRmNERSC2XZswYWYiLDsoaZgNNnhZ6fe/76osvxd+3uqtqJmC6K?=
 =?us-ascii?Q?UftBTDtJmHt2Hzt4d2arUbJQP+3Q8J1zTIBQEhhh1mxTE9HX3RprizRs2QC4?=
 =?us-ascii?Q?KnNhkbVvPOwmDnBwQU1obw9xWuogHsTvdm5zRQ0mk/Yi93hhr4j5cvaKbIab?=
 =?us-ascii?Q?D32l1P8+ZsH5vfvS5teqyFUHOHqnh1hNbdlY5oCmmWK8u4+EuXyLMITRb3/n?=
 =?us-ascii?Q?rKgeCtQi5Eu46ybam830iomIvRO2OEM2LMSBrZ2UXx/sudZgTf8SbmU4Esf/?=
 =?us-ascii?Q?bMG/iXVnDG9v7esA0XW/n49CuBxrQT1Lsql+tAGKYdpaeXTW34pN0kD+wdZT?=
 =?us-ascii?Q?2LSgHBZR8gckW1HPUS/Z0SRkPi52MUtTK+yPZ2oWa+5Rm1LMC7nnAEUoJh+b?=
 =?us-ascii?Q?ss/xdNo6Cc3jl0foO/y0+7ZUWI0jwbDrBF7ijZl7cP9kI14vfXGFw9NHBUog?=
 =?us-ascii?Q?GmfggHbGJ+lT98oJMjndCRBZCU0WnZV3Efhd5ulq4yIXmyBkUnTtomRRTE/Y?=
 =?us-ascii?Q?OBjBi4u9YzUmdbbX9YX7ntkC8GWM2U3maaRpAwlGV+5G5mMhjnT+09fCnaec?=
 =?us-ascii?Q?+ojpCMkKKfKLSs2dcXpjedTAoEqafbUobLW2mQoH8LmFw432nyw4HmC7wC6t?=
 =?us-ascii?Q?SvPUibbeRxN8U/h0BmDDpzBpRJCNuwkEn+55WjE7orfdchj4i5VnVz+CgpRg?=
 =?us-ascii?Q?6Yw2LfwaoX4BGEU3F/Nr8sQHPp7CcwmXec2ys7QJKLp/Vkq66Nvh5LxaNI7D?=
 =?us-ascii?Q?U51Hp9O2+y92j1KjnOiMTU4UgIv/a1ifCMHH75fiTIpI2/v30g4J0X8Taw70?=
 =?us-ascii?Q?9vLo9pID5a1+t0FuuhCAUhprhSn2yxydlKeUUE9Ty8yeB6Stsuy3BxudxXXN?=
 =?us-ascii?Q?8Au2qSX9KzMN+XR5gx+jUXdaiowOjzNm4v2MOdh+2Mgr555R95Ey1gisSmOb?=
 =?us-ascii?Q?GCFdXwBGFsoe5jwJ+UCd1fDOIo4RMwYGshwLh5ls8dfn6Scoz0zrkAylU8ur?=
 =?us-ascii?Q?Oqm6Iifhq+82nrZICbrJI/bkZGBfY6vElTo9R80J9BVPI21JClQLTm9aIhqg?=
 =?us-ascii?Q?oYsnCo+sjmjAirrjfGzs6oU1e+4VC0qRZGrTm6iRSbfb2wwN+E2h90ItWB5z?=
 =?us-ascii?Q?6KHD+RcZmSpJwdaVu9WZWwQ5G9dU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ik7hggPb5IznQf779Yk2lLSjkGZWXXQofMTjB14cRvCahobAYymsfznkV/KX?=
 =?us-ascii?Q?6opfu395wK5vikcvEunTN3qmjYD0djw6c6dTVGDOg/gcdM1DaoZhajhZBxSo?=
 =?us-ascii?Q?GDf/ewDUXDstdX/RNFNURSfIJehhTnSn+7SK0qgsZnM0nn3jLHUd30Qy3huR?=
 =?us-ascii?Q?Itira3RD9uKNSSnFQnqsBvxU5Zb3BAB6OlaykMKgKnIBMkym8wmCpxGSKMaN?=
 =?us-ascii?Q?Wb9TvmxKAZM9ru4wlhgFteK+JWZAmDVJIRHYUb80dBofTdVInjVKanWyhJ4x?=
 =?us-ascii?Q?wuPt7LtV4e2MeQvwCf4IHtJ5xUCXAnKBx0f4NtMoFiccp6/cEyDAkTBbwjO4?=
 =?us-ascii?Q?RdjxlcQL0yHowenEvhddBGSlEHf5M0kyXsFWpJK79Gkkgc66C1OEo6CEwsT2?=
 =?us-ascii?Q?FnblsW1QvX3XmHBbcWSiXk5KcoF27FP4l4+hIlTA9Ei0p3fYjYAfk+lH+s4S?=
 =?us-ascii?Q?P4dpuXiz379a506z79EFWq27+acNqJxK7mfgWfY9sXgXrF8/Tr4uNuSPwarW?=
 =?us-ascii?Q?DOTOUaVRaGiUspwSA20b19Xm6gwIW0nxXb5X6x/OHiis0F4zCqXR1NlOaMIr?=
 =?us-ascii?Q?Ss3fKmnbs/KeloiqTYUjc61vWOWMU9qvRLYRUm1Chov60jgihFsOENmrJxg+?=
 =?us-ascii?Q?eBRYIofnj8u5N98SHeKsgHZw6YKLJ3B7VaYBGg7AvfXd1YqO9hC3PlxpceXi?=
 =?us-ascii?Q?v86CQj7PQdE5kG19pZ7RPgXheIGsdkBib+8SyUdeJK+bF+TRoTFVIFnynAYK?=
 =?us-ascii?Q?Mc/JE5p+YBDpytV1KBH3DGqdjICvwMcryKMUJq1T63pughSl8In4Rzy4rBZU?=
 =?us-ascii?Q?2rrLNro7AcPxwBYoOqRT2WxM/88Tf1mSiWWrSEkBXY01dd/lC3+tHOd7ZLnq?=
 =?us-ascii?Q?ysXQzFi5sxj+qoQgL7gPLQiY9IoX9V4LLSR7wudZRzKyiba6VLsOrjmXWCm/?=
 =?us-ascii?Q?1g7xOg/AyCX9lSAUTJ5B5jByHNNUVC4fgmLba3oI4NXo4/tjpsHzWSbWgv08?=
 =?us-ascii?Q?Opn4T3tCbGShAIO52jcEdRFerumGld6edDlU7VCJGxUbC9wDJlaKm30IvMk1?=
 =?us-ascii?Q?lXuYH+gbi2lZhIgnZC9UwMWUFH7a3eqP4RynwI1uzXHIsIVnTMwOOnepWlcs?=
 =?us-ascii?Q?Mt5cVC/WbIOOCrVTsu0bzjkKir4ryWsFHqnEgX7gzR9fpxAhgj1f+GeHTlSf?=
 =?us-ascii?Q?I2o1BM4vuEb+3lkqaUcliJOrbMi9QKVVMaN8iBR9Pel+aVvn2ODf42QoXxmO?=
 =?us-ascii?Q?7SlEQP9U1FqcK5JR1ePx2h/1wlGYZauI9kmjlHZPMe00BDxuyEtG0pJCwYC4?=
 =?us-ascii?Q?zLuVxkl8oZb5i7164OrNNuUOvYcyw1XkG5DNcQUodwTg4YBlmKQBZOJfEotB?=
 =?us-ascii?Q?Uxn/mevXR0B448Ta4sd5RpwKjK74n+ANxUhj7HK+sMGOWTCa360QOHigso+I?=
 =?us-ascii?Q?qoRRMe8RHC5EuaxYunN48XN5kzune/TdRW5pt4m1rPvUyPWpdip3NO2JBYSf?=
 =?us-ascii?Q?i4C9rLisn9XSurhi0HfRbDT1UlBByleDqIblUwHBsI73A0ToQOR3ANKjCwhV?=
 =?us-ascii?Q?FMVBPJB2zO4AG4IdD5m0jFVeiD9dncUqg0ml/urf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb486675-c142-4d76-0504-08dd35f4f166
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 06:13:49.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60Lfec5TOkwKs0ZKcE9dW8eb0nYQVuGMjbV0nDTP+W8qeS6mQ/BHyVTbtzkiXQTIUoqayfLHtud2Jflx396+VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672

On Thu, Jan 16, 2025 at 09:26:37AM +0800, zhenglifeng (A) wrote:
> On 2025/1/15 22:51, Gautham R. Shenoy wrote:
> 
> > Hello Lifeng,
> > 
> > 
> > On Mon, Jan 13, 2025 at 08:21:04PM +0800, Lifeng Zheng wrote:
> >> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
> >> driver.
> >>
> > 
> > [..snip..]
> > 
> >> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> >> index bd8f75accfa0..ea6c6a5bbd8c 100644
> >> --- a/drivers/cpufreq/cppc_cpufreq.c
> >> +++ b/drivers/cpufreq/cppc_cpufreq.c
> >> @@ -814,10 +814,119 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
> >>  
> >>  	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
> >>  }
> >> +
> >> +static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
> >> +{
> >> +	bool val;
> >> +	int ret;
> >> +
> >> +	ret = cppc_get_auto_sel(policy->cpu, &val);
> >> +
> >> +	/* show "<unsupported>" when this register is not supported by cpc */
> >> +	if (ret == -EOPNOTSUPP)
> >> +		return sysfs_emit(buf, "%s\n", "<unsupported>");
> >> +
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return sysfs_emit(buf, "%d\n", val);
> >> +}
> >> +
> >> +static ssize_t store_auto_select(struct cpufreq_policy *policy,
> >> +				 const char *buf, size_t count)
> >> +{
> >> +	bool val;
> >> +	int ret;
> >> +
> >> +	ret = kstrtobool(buf, &val);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = cppc_set_auto_sel(policy->cpu, val);
> > 
> > When the auto_select register is not supported, since
> > cppc_set_reg_val() doesn't have the !CPC_SUPPORTED(reg) check, that
> > function won't return an error, and thus this store function won't
> > return an error either. Should there be a !CPC_SUPPORTED(reg) check in
> > cppc_set_reg_val() as well? Or should the store function call
> > cppc_get_auto_sel() to figure out if the register is supported or not?
> 
> In patch 2, I have this check in cppc_set_reg_val():
> 
> +	/* if a register is writeable, it must be a buffer */
> +	if ((reg->type != ACPI_TYPE_BUFFER) ||
> +	    (IS_OPTIONAL_CPC_REG(reg_idx) && IS_NULL_REG(&reg->cpc_entry.reg))) {
> +		pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
> +		return -EOPNOTSUPP;
> +	}
> 
> If a register is not a cpc supported one, it must be either an integer type
> or a null one. So it won't pass this check I think.

Ah, I see. In that case, you can remove the cppc_get_auto_sel() in
shmem_init_perf() function in amd_pstate.c (in Patch 5/6) from the
following snippet. The auto_sel value is nowhere used in the rest of
the code.

@@ -399,6 +399,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
 	u64 numerator;
+	bool auto_sel; <--- Not needed.
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
@@ -420,7 +421,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
 
-	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);   <--- Not needed.
+	ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);         <--- Not needed.
 	if (ret) {                                                <--- Not needed.
 		pr_warn("failed to get auto_sel, ret: %d\n", ret); <--- Not needed.


--
Thanks and Regards
gautham.

