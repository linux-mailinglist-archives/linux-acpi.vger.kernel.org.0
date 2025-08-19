Return-Path: <linux-acpi+bounces-15836-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0946BB2C67C
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB14A7B21A8
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8094F204F8C;
	Tue, 19 Aug 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zyPWSPld"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E771FC7C5;
	Tue, 19 Aug 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612267; cv=fail; b=NPKV5QilZNj7Bx+YGG9svPG0Hp/8ZqrfjknNoOhOjFWMh057vzo4WgeMufSZUeOB+6r4XCjMpc5uh39BFi4cPJgQ2rG+py+QX4Lq4ItXHMkPqN4u6Qb/r81x4WQeiTBGWmi+vjvSgJlZa88sorWEx7AdUFcRL4pmEp5Hkjh2OqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612267; c=relaxed/simple;
	bh=KTyLdPImNFFUOrlJ+tM/K2rCnijZdln8pWrjVZKnl1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=frcZUPOrH8FGm5KZwnb3WMK1GyOAf3rYuNXZpQxF8g8frsSrlVSw/NHl1ZzzjdciqCBeAQQgMUYZokeec8LAiJjK/UAjLZlUVBSuplFBUv/VgWJfNe1fa9GhReW60BYbz3cqESGW+XGKlZHWSOpRva8aeiESjN5hVnTvxiWX5SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zyPWSPld; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N624HyVTt3JGIy+JBAZr1CP+t+8Pubm1T/Ym61QrjjQ2wZff++BRnJFstfhT+0gTFpJQTgTgzCDyGtCQEmrHmMI5cKQVJMt5Y7ZpXng7DwAlpphj/8/tUUmT7UFSSaNKKH2qTZWECddDbquceYnXBIr5zLMT9g/Iwmajq5acmutlOX4BOmLI9JOLX+5FcD7leetF7NTC7eFBIzP5i9K4nxaX6e8Q9g97ZkCq3+3oKgwv/nzJUV501XpOPqL8+KaWeV4rAGfB3cdVCSE7175LqnTZST2+udOKhXIwGwM6L71i88DSFT5AhwSukB0lzsXsVzlFNZu/dE1H+CkmJU3FtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1Pkz3mOqZ4L1ZGIAPx6Vs5T6/vEQ/E6CoUc0plVBMc=;
 b=fUfuTwXollB/ThYD7vT3PmuJzidJntM0UmkIBWfGnQ4/NDsaZXD4W8zx3kiGMgoCkfZcSwrvf0xRwgum2tSGVk80Er6TCiGiUq+pdSEigW5cLI6ngg5oeyfeIdqHSDR2GLvHlBQo10iwAi6Q05NLy7DgrdBIX7RK0TF+mpFLD1LI4FSI1eoSgy27IcHYOjaQUQK2vSlq4kdSSU6ojDJoRjh4CKm5tNXUdKOqTgjBN5ik5ok+FxiJKcI06+q7w6ICJ9tTdbhVxF+OLx64ZCL3m7HZg1re+BcD0iBq4umO8+HmadQTxYfClsR7mHfnpWCETGRjnRa3kNmAtytfGnM9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1Pkz3mOqZ4L1ZGIAPx6Vs5T6/vEQ/E6CoUc0plVBMc=;
 b=zyPWSPldkGlVajdmu5ZlFA/eDL7fvGnd0dHYqB/Of+B5Riaq52RM3KsXXcuLqTTlFNhJG9chX/GIABIqONRybs5kKgNMD2b4abgoHJzC1yGOC8n3JEFrlVoPcC4AMQPoIsNWe69r64IUpMYKgadDMAPl3ENgmD/NtoR7bgHDjq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 19 Aug
 2025 14:04:21 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 14:04:21 +0000
Date: Tue, 19 Aug 2025 10:04:11 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Charles Han <hanchunchao@inspur.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
	guohanjun@huawei.com, mchehab@kernel.org,
	xueshuai@linux.alibaba.com, lenb@kernel.org, ira.weiny@intel.com,
	zaidal@os.amperecomputing.com, Jonathan.Cameron@huawei.com,
	colin.i.king@gmail.com, dan.carpenter@linaro.org,
	dan.j.williams@intel.com, sudeep.holla@arm.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: APEI: EINJ: fix potential NULL dereference in
 __einj_error_inject
Message-ID: <20250819140411.GA389101@yaz-khff2.amd.com>
References: <20250815024207.3038-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815024207.3038-1-hanchunchao@inspur.com>
X-ClientProxiedBy: BN9PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:408:fb::14) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 6957e5eb-f1ad-4705-519f-08dddf294b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zMRI2e7MlXaV+xweoiUjsVZd1M7Eb37DqI5gPvLKZo4LETlpOA0M2Zvja1XQ?=
 =?us-ascii?Q?z//lcHNUoCwjfGEsI7Srj7E4nIjHS6eQzUgSR03+wcFZAmz1XCW4Hp6rUwuN?=
 =?us-ascii?Q?6MrVBL5Vk1OdkDYbTi+ExXNj23W8BMUJqiwf9PwN4jnbweJPjFKj2X87ULR3?=
 =?us-ascii?Q?zwoSQf6oIbqoBjYklp6+nrUsGUyD/W9GwG7Oj1KG9A6MWCPQqMRSENHdaQDD?=
 =?us-ascii?Q?fBEw2DMDPUAttbLyULLSMtAKh2ACHSUTre2Iy9RNwAldCJ3LDA2bsiFfEDw8?=
 =?us-ascii?Q?UDGaUBfRTsmIdDaOpNT7ywT1wwoyPEL1PPmzDSUud0ptcO7zik3ZNBh0bS5D?=
 =?us-ascii?Q?bGIo/l9s2n9CNXkWog9hWQH1j9d3mzxTLNDfDc4kiAzkjaK1BBCMM9ByI2Q7?=
 =?us-ascii?Q?6Y09DcTEpmvejjzeIx7T/dmQZrNViaoQBoDRIKLNc3TxB+0d5JtcFobpdM/t?=
 =?us-ascii?Q?SP34XvIPPkPpnuX5HeqDwE/ko76IO425FuEkGd2FVZNtIq7Re5f4bsgGiy4W?=
 =?us-ascii?Q?MMa+exAuGM3EVCU8Cnh/yb6W7AkRHykQnWqssjTqQBXc992y9RAc8ZyHRwDT?=
 =?us-ascii?Q?Ioi7T261/ZS28i+7dxFyyQ4zosSwXXbOycDemgBYZ046pKBnNKnnLgSWlAwG?=
 =?us-ascii?Q?dcZ3/dBn5ACkm63logO1XLobGzsItvSk4uPgKSx1tjYTLSOExefOOza0ZJyx?=
 =?us-ascii?Q?BhvxwDO0/JB425oFcR7e0L7F+1r+oMrEdQuHxIERv7BfxaWG0StyAT1QAjKT?=
 =?us-ascii?Q?XLdygPBDBkkXwjrKPkyVPUm7IdQldMh202v8ofZLBXbVTC+rRxkIAbVJwll1?=
 =?us-ascii?Q?BKC9/B7zSolTA5MxS4hBOrTQMYDJlHnvGpqtPPdsOPMkN5VfamE12GNrEzm3?=
 =?us-ascii?Q?gqNW23KJrmL2CG9ntvI4RNvv462+s/xvu4cf4QmQfiSC3ra4VL2rKfFHjGXM?=
 =?us-ascii?Q?+NEmMkBRH1JWukZ2hbeymDigN2J7kk+uaqmrq0MAzUgUFYpDSQ1GQ12udBZi?=
 =?us-ascii?Q?kq0Ix1lZXwgKYBDIJr8CaBb5W73YhvnUh/KuUXJ2YJ/KNqPrTRyYAhulVes/?=
 =?us-ascii?Q?rE/PUP60fu8VxCluW3PV8ObO4ftSfeuZH33M5x96zy2BbwD46dHD5f15BafW?=
 =?us-ascii?Q?2IhnhDrdBp2m8dTPGnwnA04JA2ansLOCOZK95VzpE7p934MfpNdsfxMlHz3y?=
 =?us-ascii?Q?Tf5oQ17f9H5X19hlytetlya6rPrYv2MflwCVLmm0183AZP2PpZqU8IXjuB8d?=
 =?us-ascii?Q?4AJVn+0Rl0CBhGRvxezcOF/VQSluGczGWve3+O05NIqPKJAAM/aJhnNn3JN1?=
 =?us-ascii?Q?xtUR/Qwze3YE1LrPGIxj95hGw/chiwRt3KMlcDdtJNvgWvpIzF4vHctIMWyG?=
 =?us-ascii?Q?lFbrDut30lVSXsc+SlrGlkeykdDuKqUfeOneStRj7lbE7WCz1rw/Dj2v+w+u?=
 =?us-ascii?Q?aAIbu2kATVg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2qQC0IsK66tM+ZZ+8bfhK/Ht1eMHf6vH8Q6AwJwa6+dmURLbnZdEiyU1R1t?=
 =?us-ascii?Q?lio3b6mezImtsVstnv2lQHCyBXDENet6aKW4e+FgEvYrHOn0bMzJW+X2u36z?=
 =?us-ascii?Q?69NuopndjDwqEEtg/bFhXR0eQubYn0fZLAlSe83dHIdvEAGxRu7C0Lcu+0TG?=
 =?us-ascii?Q?SSzHUXuBcVjWrd7ajgdMv7MMeQ+6TqLOeauaYdhRHam4th/6YGroIUZi4NOz?=
 =?us-ascii?Q?fLrRE43C/PUYhqEqRBfID2FjiDZnAAaoGMfu9M17HGSkMyeldb7qHH+LeFCL?=
 =?us-ascii?Q?8i+zwh127KZBe1zyGIhkUwCABbQ+R0jqXUeZmjQwW3po4JxVJkQqEXtgVWKM?=
 =?us-ascii?Q?PN/izuEvoPq144XCHCrOWn4xhh5oZTS1NwzYaim9iIA7QBKRJ54onDS4rqhw?=
 =?us-ascii?Q?5ue3ichAajanhohBBAgkvw3m+agPQggF1DHw9w87fvZ8Bi1DB7Wb0Mz6/ExS?=
 =?us-ascii?Q?IvdmRYTVFx33Dmw80hnCAVf2yiKtXNcyzB4/dAtwFdmbZUJZi67eBidCcBB4?=
 =?us-ascii?Q?Zvwm/yk+ui8wwWheIV2EAE+11DTKYJhf5+bLjMt/o57sre0agbS67MTUmkgO?=
 =?us-ascii?Q?bALC9FSF+jIV3bDciB+SKRjnRu9BWeCZ43Wfpy0trAMb0od3wUuheTn0Bm89?=
 =?us-ascii?Q?KsMPVd//gDR6jzPpdi7hqnk4N1g9/PkR5y6bOfDOtZYzDpOTQlffsYRlkkFp?=
 =?us-ascii?Q?0or/vzheTrbXbGmCtbgWOsFDc83tpI/b9KQwpG+9ZmISUEmHnRgwcVHY7KBS?=
 =?us-ascii?Q?6Cf7Q0/38GPGWhXcr2MaysU+CibsSovoCGeZmqw8RwZ1hwQDiXE9dXRC/spt?=
 =?us-ascii?Q?E9ITrMpGniNU+xRAnlTPIVcH1w4Cem9Zl6zyA6O9thWdmEZS/ky4Yu7njMyS?=
 =?us-ascii?Q?6VNt6dzWeT11dXFpGo7Aon4GiYsU5kE4uDBCk9FE26H2Tqh/8bRQEaGldkCs?=
 =?us-ascii?Q?waCbN1/v/i8scEaSCsePiTxVhE2R8SPktNYVIMD9hRKCvB/TwAdWlkWdTsEL?=
 =?us-ascii?Q?OvgH4YzfwE/li+OcdXAPNTDENWZsMY0LgX6DH0RpcWogGzqGPodm3k7zMXNq?=
 =?us-ascii?Q?5iuwV0QkCPFJGf3ZvSAhmCuJCB7BEXQLLtx896cJhykj6rRN8aA4XQ8X+4Tt?=
 =?us-ascii?Q?YlK+pcA+cQQkjZRks6hka5M2Y2p2/3WbyKZisBGTG/CPVpWO1mcd2QX8ijwo?=
 =?us-ascii?Q?B2Zl5A30Gb/4DgmgiweYbaPo2rFR8X8TutjOMtklsWu7E3sXbjeciyZeCdgs?=
 =?us-ascii?Q?J1/XHcN2o/sRUsaTnDdiCogb3lySYOUJfTT/vbZkN5H5Y7O/n9XZ7H3RjrAA?=
 =?us-ascii?Q?QaWEhLUeyxYwUbuLW1wBur6aM96i/x3jtyE3jCCbMRzLO8zZSIcDyh8HTrI/?=
 =?us-ascii?Q?BTwbUbZTxgErQjMUdmKKvhiKpvLSoDkkjbk5TGpTUSpiQcDiD/X0NqiL0Rqa?=
 =?us-ascii?Q?VBLZJEvVlQDoEMOdnELYASeo7LbZAGgtmy9zikH2cg1EmWxRepVvHrNxewxC?=
 =?us-ascii?Q?DONo0R6fMv4VC6UnoSIVrkL7Y8t/VMc9zLwiUy1IbN9y892d2zRr650NE16t?=
 =?us-ascii?Q?RnSIHnSMPclD1A18dISolZP7reTlK5cU3p2W1rbu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6957e5eb-f1ad-4705-519f-08dddf294b72
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:04:21.3050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxDamKiY9di9wkayOlMPW8kv9WKz/3WS/8dZyToWvZhCSbUux4hdGyGMxNh/XGLSju4/Hd6mzlh0KVmHms/9eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586

On Fri, Aug 15, 2025 at 10:42:06AM +0800, Charles Han wrote:
> The __einj_error_inject() function allocates memory via kmalloc()
> without checking for allocation failure, which could lead to a
> NULL pointer dereference.
> 
> Return -ENOMEM in case allocation fails.
> 
> Fixes: b47610296d17 ("ACPI: APEI: EINJ: Enable EINJv2 error injections")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

