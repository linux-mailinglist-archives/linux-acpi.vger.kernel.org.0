Return-Path: <linux-acpi+bounces-9354-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F58B9BEFE3
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 15:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9A41F22388
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10831201038;
	Wed,  6 Nov 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rrsppyox"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB6200CB7;
	Wed,  6 Nov 2024 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902486; cv=fail; b=BRoL7u7Xt7oBPWnQ308YNt/AwM9HRupjsJtHG/h57SouqxiviJOBao9ABpnfllVaA34OCP6C3Kjw8FtcKeq6aZwKckbMYv83Y0EEjcYgAJIPTU64QxRTnqiQ7hzKM0La9/zNCJ6KYn0JFgy/Q/d9mTDGJgN0iPMz3Q/aeAI0hTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902486; c=relaxed/simple;
	bh=aDuwlVoq+2/LUpDVuCoU47nPb/ax63wvmQV25BzSE/k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WexNvEWw4stD805ID/pK6Bly+JQ3PlyDDn2My2VoIPVovIlcbxdNE+74QlZSrD6J5IZ5nhnKDc/LM1LyjB57Aj9NHJPswIDY4Xses4RNEZTYOQaLKGJUvhu/P4A26NdUVi7PNl8L67/qbYsF9vfVsSyHLqUh/KIG7KQ1kfZaf4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rrsppyox; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtCOXtqBQk2Gpv5Jc5F2yq/SOu7AA5rK9mRSIGfyKiCUXA4fAwoMb8qfA82bhVBYndjx2h3K8hEnutasHqx3z4PM6+PjBDd/nv1U0nkfFq0Lsop8zO0JDMArMMGy5FzIREILln8JatjQ7I1F9yDXvMloHVtD2nOLvd6LOiiJGaDs3TSaOrPF7dSj+BGx6NUfhGOY+BlAZxQNvBV/Gj3ynpAEZTsEYzMuA9HzL1rh4MK9XXmdRLnTXwc4jlbWKnxYsI6hHVy6Sr2jGmJokU7/xS06cj6kdDhsz78QcN7IaARdS3kwbSHYQvon3ZLmA9DWkghKCdJZCstZyKyZFo54qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z9kEf7lgK8zDU65IsJqgk28AXngeuwU5hybDkBt3s0=;
 b=AwmUUBquBi9+fnfpcgjBMwK8EvUTb2FAUIc/OsGETw4UJ4GaiYQgpXb9uF1MOvS0i+Npy9jCn0t9U+lm48ahOuX7MFkS+m9cHgaM4hkbmv0NtnVvGm0FIeRnyTEjqgt7lOFStUBxr+IG+PA4CBbztxljVzLIUvu6qDtkwkFTSGfVLF8CLSTd+Rm3lYr528BEVDXpnaX3q1J4YE5P6Cj1kRbt10IsMacOrYghqg3ywLQZlembJZFPd4jpPTwWZfangcJMiD5FrT6FBJibBjFMU0dThLYNdA9IFY/YemkgR2qMlWFCxrK78Ugr+lzFSrye/QHAfd+7lw5XDBXKdLQzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z9kEf7lgK8zDU65IsJqgk28AXngeuwU5hybDkBt3s0=;
 b=rrsppyoxJ8h+N9sLpF7GOnu4ZqQWmAaj0GdZohkimio1s3e0E/EDPKxT/avaXjMI7SlnPKe4fdnEBWuu9STnzjWrlLQLatAs9xzGATBli3vAq9Vska/xs2MfCGS30ZEoZfOQErziVPz8sWGNdDyRWsCdf4RD6AO793d7WvKnRzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 14:14:41 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 14:14:41 +0000
Message-ID: <701f20c1-b429-40b8-8ad0-15d796238d70@amd.com>
Date: Wed, 6 Nov 2024 19:44:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] i3c: master: Add ACPI support to i3c subsystem
Content-Language: en-US
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
 <20241023055118.1400286-4-Shyam-sundar.S-k@amd.com>
 <7cfc1f2a-cb4a-4ddc-af0a-df7793ad4487@linux.intel.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <7cfc1f2a-cb4a-4ddc-af0a-df7793ad4487@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::25) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ebce4e-3482-4516-11b4-08dcfe6d5aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N20wejI4ZkZYS0l2a1pHTStzQWtGWmZUWTdxbUpDT1M1VW9rSC9GRWZINE1x?=
 =?utf-8?B?VUJWV2xRZ080Si9EV3pWb1ExVmZhc0V6T2IyNE1PSDFxOENhdXNScndQK2xK?=
 =?utf-8?B?NzBUZ1lmc2c5MTFEN3dxYmx4eWN5MG9aMzBQNFB5US8zNUo1S0pSMEc4ZGhs?=
 =?utf-8?B?YUIxeGRvZWhtdzN1VFk2bitQd01LRURFNTROeGF4YnJFeGY1OHpWWjB4TkZI?=
 =?utf-8?B?eVNWeFdKSXhJNXNLcVRkL2tuaDlRM3pKbTdXR1hnWFY4T2tod0hPWDF5ZUJL?=
 =?utf-8?B?N0FULzlrWnNzK0gySVM2OW0vc0d2dWYwZHpJQWZsTytzaFdLQnhtenNaWkNm?=
 =?utf-8?B?bitaUTBKNDV4NDZ4d3l5ZXY4dS9Sak9ydGJRZ1cyK2gwNG04eGVVQVBiYVNR?=
 =?utf-8?B?NkQxbGZObzBCTjJYZGx2ODVUS2dEYzgxUjZ5VXlEbFFqOFQ1cG1INnBxN01n?=
 =?utf-8?B?b1o0WDRGRW5wbjZodHhnQkFQTVIzbmdwdFY4NlZTMWFyRlFjUGZMdk8ybTVw?=
 =?utf-8?B?K0lYZzJIYU5mS2szUnQyVmNtMEZKYXlNaHFRUWZhbEQ5QkdDZzJoM2FidlM5?=
 =?utf-8?B?RlZqVWpGWUVxeXpnSWtOZ0VEWXg5YVArcExkWlM0dWhqVi94aHNkVWZ2MVBK?=
 =?utf-8?B?WmlyQ1h3Yk5sL2wzeURBeDh0YmxGMVlrNERoUFZvSTZrM2ptRTJVZ0RMZTJs?=
 =?utf-8?B?eElDdm1KcjhBQVhEVlJjcTExTlpVZ0duMlJxRE5hOWdENG9DbVNSMUpIaTVh?=
 =?utf-8?B?ZFFhN251RHdCem5ha0FKNmxCNjJwTm85dld1WWkrMlRGMFNLa0t5UjVBNysw?=
 =?utf-8?B?SDI2b3RWais4aTNHcTRNVzcvVExoWEI0TjV4THlVZkNMcTgzQzNWYXJJYmhY?=
 =?utf-8?B?UHdVeHpZajRrVURGTmphNFovQjRyM1R5VHU5Qk9rWVpOdC93ekNxNWM3RkV0?=
 =?utf-8?B?SUFpVE8xcmJ5amhwdmhTNXZJWktOS1l0eko0R2tZUERDZUdiM3c4VlRoUUQ0?=
 =?utf-8?B?OEN6WlNGOWluZjY2MU92N3RnVnIweldoL1hCQVo2TStIbTBtZVllSjE4Wlg3?=
 =?utf-8?B?aGR0Q1dydTFhNG96MVl4c003Qzhjc20yaitMNFNJbERLcGF1VlBidkl3bjFI?=
 =?utf-8?B?L3dPT1dBcXRyTWJEVXZRbmpWR1dPeFZUbFQ5VHpaUTR2eldKSm1OK1FMcEJ6?=
 =?utf-8?B?UXBjY1VoNW1vR3EzOWFETG1DYjE1ZjA5Q3lURzEzUStQZGZodDNNcTBFUTdL?=
 =?utf-8?B?SUg1MDVMVHEwbmRhd211KzhzdDk4RUNuZDF0VUlQNHdxRTN6ZXJHSngvY1Mx?=
 =?utf-8?B?eDZJMW1YQktSNWJjem5hUUJEZ1NmQ0wvMitlYk1USkNNME0wQSs5WGRxWUE3?=
 =?utf-8?B?Zitvb1hteGtNZ2VlTVUvbFMxWlhFUmx5N2p5NE9QdmVJYUJUVWNxdkFNeG5V?=
 =?utf-8?B?R0xTdjBvRE5ZRVBxcUlGSmFuMGN5OC9mUFhJb0s2RTVnQmJDY2NCMmFsVTYz?=
 =?utf-8?B?cSs0NHdsN0JqdXo5RjlmbGQ5NDhYdFpUeDNYTUZITm14THN1YnJJNDc2aDlB?=
 =?utf-8?B?UERHU1ZKUXZMcTN3aW9CdzlHYzZ1cTg2VW5wOUxsSGJKWUxSTFFKWTdmOXUz?=
 =?utf-8?B?d0t3cmJmTUgrOGdiNXBqMDFGd0lBUXBMU3JGMGhsb3RhMHhHL2ExK0QrU2Js?=
 =?utf-8?B?N3RaWTR0dkxmYnFQMnRydVUvZ1dWY3VBRFZBZHVBaUx4cWQ2VnFHYmd0R3Np?=
 =?utf-8?Q?onEuCG2TLakboZbI5I0n1orPiH2jjOszXEQkVXa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHNPSFY4a3RpRTVyT0ZrMWhHS2o5dmtZelYvbDRJdEduWFpxdzFnQUgvSGxI?=
 =?utf-8?B?YnhKNmM3STVNWTd2cTFlb2cvUXB2WHFaRENEdVd3eEF3YzM3Wko1bWpvMytT?=
 =?utf-8?B?UVh3VnBUOEZ4Y2pNZmNEWWxFNmpNTGdxVDFmWGNKZFkxakVrVFZTMjZYRnpn?=
 =?utf-8?B?MEpLOVo2eldTL2JvQmpSZ2tUMFd3WEtMcWEzZ0gwZ3JtdVhlT2IrK3k1Qm9G?=
 =?utf-8?B?Q3gzRHpoNlJaY0xTL1ZJWkF5VXNRclBoNFd4TlFGWE1ZZDdDM1RCUnB1OWxl?=
 =?utf-8?B?clVTRmdGclhaRG1KZzhwYnVLNHpmWndpcDIvRjU5R3IzN2JvcCtiL0hzejFq?=
 =?utf-8?B?SGtnRTlIOUJRNWxZanNpWG1Yb2VRV1M1ZUR5ZWVMSHE5alQvTUk0TGV1UWpK?=
 =?utf-8?B?WDRodldlKzN0MzhVdHNFNm5SdEQ2by9OUElEd1VnNlpiVTNyeDdrRFp2Vjdv?=
 =?utf-8?B?cGN0T1JtUUh0Z2VhNlhLQVlyanpnd3NrM1N6Qko3TXVSM1NEaUx2ZDZRUnRQ?=
 =?utf-8?B?REZZWVZhM1dFUXoyYkJkeUtydVM0RFNtbndWYUswZ1VSY3paQm1vQnJFS2Zj?=
 =?utf-8?B?Y2xDdFJHQkwrUFgrWnowNWtYZk9oOTd5MnVtdFAyOGpNL290TTlDUmpWT0Jr?=
 =?utf-8?B?UnJKRGh1OERXZmxTMnNFMS9qeEtoUTZlemk0YzdZbzlVOWpjdlZIOXcya3Z2?=
 =?utf-8?B?alZOODdhNndTbkg3eU5OYkY4Tk0yNklkZGNXckFFbDUvMUYya1NnWVlSN25i?=
 =?utf-8?B?RFVIV29XeDkwYXRUbFNMenNZc3BKaUl2MWJlRWxicUI3NW1LbGFNN2lrMGVi?=
 =?utf-8?B?L3FFbjBFMXdlNTgvMWtsc0JiTUo1OGp4bDgrMmRKZXE0NU9hMTVNcFRuaXVP?=
 =?utf-8?B?cmkvUDI3S25qU04zcXpDNENqdmVlZG0yVFdsUjBONVFEOElxcUF3Z3oyc1FO?=
 =?utf-8?B?NFlOS0MyQjFCVm9ncG9hVUJPRXFyZEpPTE1GcEM5VllVaHk2OVROaXpWcmw5?=
 =?utf-8?B?WWFFTDhwR2dMVTRUSld5blFpcVpmQmYvK0UxVHdFMERrYk10bnJQakRUOWpw?=
 =?utf-8?B?eVI2ckk3bVl6eWRyWCttV2UxTHRXNjdYWTRvOUs1dG1MS29xU2VRTWFobVlx?=
 =?utf-8?B?VEVlNmV5aGlFbE11Z3ltT1hyS3RiYmhKcXYvemYzY0tKR1ZOaCtXVEMvUUVX?=
 =?utf-8?B?MzRkVXJ6M1Y1MGYzL0VPTjhCTFVRR0QxeXA4WGRFK1VqemI4R2VBK1FGd0xz?=
 =?utf-8?B?eitlRHZnb09QZDhPWDk3cGZHS1drMmg2QW1yWk5QYmR3eDd1aUpwaVoyOG94?=
 =?utf-8?B?MFViWTZuVDIyRUhMbTVlTWpMazk3ODBOcVpaTjdRSElNVHQ4VFJ0ZElJcDRs?=
 =?utf-8?B?aGplQllGaW5tSW9maGtOSERhMndIdnVoQnR1blRVY2JOUVBmQkpheVRHd3NB?=
 =?utf-8?B?bSs3clZibzdpYi9jelNwcUxaN2NlcDVBcnBBckQ0NzZ5QmRvNVBMbExrUVlY?=
 =?utf-8?B?eFVZbloyRWM2NStqRFFtZmxFeDBEUGhXUWV6bTliZDRmYk0rU0p1Z3ZTM3BY?=
 =?utf-8?B?QS9JWldxVWhMd3hieVp4cGNxaEl2eEpubFpRWVRTTEFoVjl1YWw0T0FpVjZO?=
 =?utf-8?B?UmtiZkRVMnBjaHpsTkpJMENCeWZkbWpvMUR1ODFlTFhsdEdjMk4rNFFvVFFY?=
 =?utf-8?B?M3UxVlptWXlzYzBSN0R6N0Q4KzR6bE9KeTdzWENhbTBsam5IZ1Q3MVdvK01J?=
 =?utf-8?B?Q2Q1TDE3SmtqSFR5Z3RBeVRVVVpQWHZ5TzlXdnJZeFNnaGRZdWFoSnNLU3VV?=
 =?utf-8?B?cHdEWHhXSzlPRFA4Z0o3Y3ZQcnNCdC9LUG1RMjdmY3RnQStYWWJxNENscTR6?=
 =?utf-8?B?K2s5ck05WFJpbmg4VlprYTlsVXJ5MFUxeG12bXpyaFBjc2FQUk9RRjVrcGxM?=
 =?utf-8?B?Uk5TT0tUZkowTE9GM0J6aVA2ZFBUeGFtVU1uTnVUcGZ4R0FqTGVuSVZiS0Zu?=
 =?utf-8?B?djFnMVhjVFg5SDYwbUJDTE85M21EQmN2NGM0bC9xRnZUdDdVU21oTldtYW5k?=
 =?utf-8?B?NHpabSszOGQxQ2FoQWx6QXduQVAyQlMxWm14RVBkM3IrUzJlWFd5OWtmTG9l?=
 =?utf-8?Q?5se9sdwsJHWrJSpifTw09T4rX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ebce4e-3482-4516-11b4-08dcfe6d5aea
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 14:14:41.3549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGtVyjntFZDYyd6XiJ7VEcmUCcmuGAMvDJPgtWqbViRNNidcXfRxyyoFjcl70VvWRc1+oMi29jq9eXbTydL5MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259



On 11/4/2024 19:36, Jarkko Nikula wrote:
> Hi
> 
> + linux-acpi
> 
> On 10/23/24 8:51 AM, Shyam Sundar S K wrote:
>> As of now, the I3C subsystem only has ARM-specific initialization, and
>> there is no corresponding ACPI plumbing present. To address this, ACPI
>> support needs to be added to both the I3C core and DW driver.
>>
>> Add support to get the ACPI handle from the _HID probed and parse
>> the apci
>> object to retrieve the slave information from BIOS.
>>
>> Based on the acpi object information propogated via BIOS, build the i3c
>> board information so that the same information can be used across the
>> driver to handle the slave requests.
>>
> I think it would be good to have a DSDT example here?

Device (I3CA)
{
	Name (_UID, Zero)  // _UID: Unique ID
	Name (_HID, "AMDI0015")  // _HID: Hardware ID
	Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
	{
		Name (BUF0, ResourceTemplate ()
		{
			Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, _Y2C)
			{
				0x0000000A,
			}
			Memory32Fixed (ReadWrite,
				0xFEDD2000,         // Address Base
				0x00001000,         // Address Length
				)
		})
		...
	}

	...
}


> 
>> Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> ---
>>   drivers/i3c/internals.h            |  2 +
>>   drivers/i3c/master.c               | 84
>> ++++++++++++++++++++++++++++++
>>   drivers/i3c/master/dw-i3c-master.c |  7 +++
>>   include/linux/i3c/master.h         |  1 +
>>   4 files changed, 94 insertions(+)
>>
>> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
>> index 433f6088b7ce..d2d6c69b19dd 100644
>> --- a/drivers/i3c/internals.h
>> +++ b/drivers/i3c/internals.h
>> @@ -10,6 +10,8 @@
>>     #include <linux/i3c/master.h>
>>   +#define AMD_I3C_GET_SLAVE_ADDR        0x30
>> +
>>   void i3c_bus_normaluse_lock(struct i3c_bus *bus);
>>   void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
>>   diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index 6f3eb710a75d..7d23c32e1c0f 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -2251,6 +2251,84 @@ static int of_i3c_master_add_dev(struct
>> i3c_master_controller *master,
>>       return ret;
>>   }
>>   +#if IS_ENABLED(CONFIG_ACPI)
>> +static int i3c_acpi_configure_master(struct i3c_master_controller
>> *master)
>> +{
>> +    struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
>> +    enum i3c_addr_slot_status addrstatus;
>> +    struct i3c_dev_boardinfo *boardinfo;
>> +    struct device *dev = &master->dev;
>> +    struct fwnode_handle *fwnode;
>> +    struct acpi_device *adev;
>> +    u32 slv_addr, num_dev;
>> +    acpi_status status;
>> +    u64 val;
>> +
>> +    status = acpi_evaluate_object_typed(master->ahandle, "_DSD",
>> NULL, &buf, ACPI_TYPE_PACKAGE);
>> +    if (ACPI_FAILURE(status)) {
>> +        dev_err(&master->dev, "Error reading _DSD:%s\n",
>> acpi_format_exception(status));
>> +        return -ENODEV;
>> +    }
>> +
>> +    num_dev = device_get_child_node_count(dev);
>> +    if (!num_dev) {
>> +        dev_err(&master->dev, "Error: no child node present\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    device_for_each_child_node(dev, fwnode) {
>> +        adev = to_acpi_device_node(fwnode);
>> +        if (!adev)
>> +            return -ENODEV;
>> +
>> +        status = acpi_evaluate_integer(adev->handle, "_ADR", NULL,
>> &val);
>> +        if (ACPI_FAILURE(status)) {
>> +            dev_err(&master->dev, "Error: eval _ADR failed\n");
>> +            return -EINVAL;
>> +        }
>> +        slv_addr = val >> AMD_I3C_GET_SLAVE_ADDR;
> 
> This doesn't seem to match with ACPI 6.5 spec [1] chapter 6.1.1 _ADR
> (Address)? Address encoding for I3C says:
> 
> Bits [63:52] - Reserved
> Bits [51:48] - Master Instance
> Bits [47:0] - I3C Device Provisional ID, following encoding defined in
> the MIPI
> Specification for I3C.
> If an I3C device supports a static address instead of a Provisional
> ID, then bits
> [47:7] are Reserved (zero), and bits [6:0] are the 7-bit static address.
> 
> 1. https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf
> 

        Device (SPD0)
        {
            Name (_ADR, 0x005003C000000000)  // _ADR: Address
            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("e7a40010-1da5-46de-abd0-317a8babc96e") /*
Unknown UUID */,
                Package (0x04)
                {
                    "mipi-i3c-sw-interface-revision",
                    0x00010000,
                    "mipi-i3c-static-address",
                    0x50
                }
            })
        }

if you look at this _ADR, 0x50 is the static address given via the ASL
to the driver and the rest of it is the PID.

You intend to say, the static address bits are incorrectly given by BIOS?

Thanks,
Shyam

>> +
>> +        boardinfo = devm_kzalloc(dev, sizeof(*boardinfo), GFP_KERNEL);
>> +        if (!boardinfo)
>> +            return -ENOMEM;
>> +
>> +        if (slv_addr) {
>> +            if (slv_addr > I3C_MAX_ADDR)
>> +                return -EINVAL;
>> +
>> +            addrstatus = i3c_bus_get_addr_slot_status(&master->bus,
>> slv_addr);
>> +            if (addrstatus != I3C_ADDR_SLOT_FREE)
>> +                return -EINVAL;
>> +        }
>> +
>> +        boardinfo->static_addr = slv_addr;
>> +        if (boardinfo->static_addr > I3C_MAX_ADDR)
>> +            return -EINVAL;
>> +
>> +        addrstatus = i3c_bus_get_addr_slot_status(&master->bus,   
>> boardinfo->static_addr);
>> +        if (addrstatus != I3C_ADDR_SLOT_FREE)
>> +            return -EINVAL;
>> +
>> +        boardinfo->pid = (val & GENMASK(47, 0));
>> +        if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
>> +            I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
>> +            return -EINVAL;
>> +
>> +        /*
>> +         * According to the specification, SETDASA is not supported
>> for DIMM slaves
>> +         * during device discovery. Therefore, AMD BIOS will
>> populate same initial
>> +         * dynamic address as the static address.
>> +         */
>> +        boardinfo->init_dyn_addr = boardinfo->static_addr;
>> +        list_add_tail(&boardinfo->node, &master->boardinfo.i3c);
>> +    }
>> +
>> +    return 0;
>> +}
>> +#else
>> +static int i3c_acpi_configure_master(struct i3c_master_controller
>> *master) { return 0; }
>> +#endif
>> +
>>   static int of_populate_i3c_bus(struct i3c_master_controller *master)
>>   {
>>       struct device *dev = &master->dev;
>> @@ -2771,6 +2849,12 @@ int i3c_master_register(struct
>> i3c_master_controller *master,
>>       master->dev.coherent_dma_mask = parent->coherent_dma_mask;
>>       master->dev.dma_parms = parent->dma_parms;
>>   +    if (has_acpi_companion(master->dev.parent)) {
>> +        ret = i3c_acpi_configure_master(master);
>> +        if (ret < 0)
>> +            return ret;
>> +    }
>> +
>>       ret = of_populate_i3c_bus(master);
>>       if (ret)
>>           goto err_put_dev;
>> diff --git a/drivers/i3c/master/dw-i3c-master.c
>> b/drivers/i3c/master/dw-i3c-master.c
>> index fd58a95ae1c3..f683e2a398ad 100644
>> --- a/drivers/i3c/master/dw-i3c-master.c
>> +++ b/drivers/i3c/master/dw-i3c-master.c
>> @@ -1602,6 +1602,13 @@ int dw_i3c_common_probe(struct dw_i3c_master
>> *master,
>>       master->maxdevs = ret >> 16;
>>       master->free_pos = GENMASK(master->maxdevs - 1, 0);
>>   +#if IS_ENABLED(CONFIG_ACPI)
>> +    ACPI_COMPANION_SET(&master->base.dev, ACPI_COMPANION(&pdev->dev));
>> +    master->base.ahandle =
>> acpi_device_handle(ACPI_COMPANION(&pdev->dev));
>> +    if (!master->base.ahandle)
>> +        dev_err(&pdev->dev, "Failed to get acpi device handle\n");
>> +#endif
>> +
>>       INIT_WORK(&master->hj_work, dw_i3c_hj_work);
>>       ret = i3c_master_register(&master->base, &pdev->dev,
>>                     &dw_mipi_i3c_ops, false);
>> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
>> index 2a1ed05d5782..367faf7c4bf3 100644
>> --- a/include/linux/i3c/master.h
>> +++ b/include/linux/i3c/master.h
>> @@ -523,6 +523,7 @@ struct i3c_master_controller {
>>       } boardinfo;
>>       struct i3c_bus bus;
>>       struct workqueue_struct *wq;
>> +    acpi_handle ahandle;
>>   };
>>     /**
> 

