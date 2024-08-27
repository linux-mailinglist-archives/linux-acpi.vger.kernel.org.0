Return-Path: <linux-acpi+bounces-7875-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E142F960E9C
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988BF283425
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC881C578D;
	Tue, 27 Aug 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uoaIz2JN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808744C8C;
	Tue, 27 Aug 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770227; cv=fail; b=Y6clGtpf+QaCcRpNZSa/0iukPLeN3ZGHUpSeOp5CBYJ6iNfQgOjxgFOD+Ng/fzXe++MOt6afmuSCxKgUkhplwsUDhhGiFz1Z3BMFqoipoQ0i8XgHHyDO1ymgDZGRCtrk1OszMNKGNCSeir/I0ISQ05yBm7Rss9Iu/2ac3M4R21M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770227; c=relaxed/simple;
	bh=k0El7fquPEdevqQbx8RTDKX5HeIG/IwDLjg53YqqisE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kzzmt6yriF6yvMmOAVDMmhLJ6F7QYABIDdtxTpEq4+Zgg/KycTKjEZ/i+2YwFHoyca2M1ZsKg+3qspX3PSq/o1JyRCLNAZxWcOQ9pToJj/CYfVM2LTwfzptK2korcnKCSY0hKW+FWGfOcCv1bgzG6DhCSbnXQqhC0l1OgYY4ibg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uoaIz2JN; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOBjpwNjXkdJvh4X7xZIHennROAnb5IHImNYf1qL/nSDG/s0NvSsZPbQMlT79MEdTdMvzFFU/iOvbGpbTVZeYNz5NMed4EwL9kYcv9mkve1C60hyKhjHgz5gMbkvtC6J0bZU268fwqIfAIdupGaFi6Gud0/6VCeKf1aFOrAf7yanUYMfFpIJIYcTCzbyy1EyG7u8kItKdwukY2+0ND/1Dp1sRrq3WdosBUVDw+pMCdw1qkzrDBn7eCM2JPZtc0+um2jb2Cu2tNaDAlX2qUKsMpt5Qpp2sLF/p7dun5nqy/C2qhtXP9ho58cGR0dlxQwgj7MS1ElcPAmqNIbksUUOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAcNLjsHIcAUvU3Jbi5+H6mtk6CtHiXYslu0lgQkMYI=;
 b=WnDnRyoaqkbiUzRLDSZXv3Cxj8qJ99IW3UigcQFx7D3J2u6tShrvAKv3vY8xKZ8BFARXb2vIJ4S2JPi2qv+P+TEgSWZnqshwg+JhddCll2J1n8fvWQmLn6wsHaWWEixDnsDR7LfftZKY2eiRWEDJNy40oGtFYxjd3G0+UbRNe2Qiy3KSpZUDL2XtPqPs56m76xtriPu7mdpF1E1BXz42gnnaiIINqhij5cqmkVXMiM7ojyQ4vbulmRyktL73HcOZDv7K4P9gKMjHnRp0zKv4PB4T72fDZinusarRzeTIQe+sDfTTltxYE4ZPaDf/ObmYRU43dHl4/m/lPyopoBVFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAcNLjsHIcAUvU3Jbi5+H6mtk6CtHiXYslu0lgQkMYI=;
 b=uoaIz2JNS4ASxFmELYtKT6N6JU8oN5k7BwzLT52b9wDnEeb33K14VZ6iwPPALADdIY1lAH34tK4X2iCdg/TrZXGO3zi66Td8Vu54Xghw8FlLpf8ytUtbOkm5LMKi03THyEHBNv1nIZC7NTDtFNdn/RSrkbZNUeDMj6Aa9dJe1FI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 14:50:24 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:50:24 +0000
Date: Tue, 27 Aug 2024 20:20:15 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 3/8] ACPI: CPPC: Adjust debug messages in
 amd_set_max_freq_ratio() to warn
Message-ID: <Zs3np8AeARzbMVSB@BLRRASHENOY1.amd.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-4-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826211358.2694603-4-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::12) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: f246928b-d77b-43e2-0724-08dcc6a794ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UPgmXQjQ/6i+QITo/4LxMd6XgbrTcG7Z3nnVwl8RA/uBvj7LO9B0H/iY8qfh?=
 =?us-ascii?Q?Tm57ipj8evvyVYyLv57kt5ndUu7UXA48G/xgRk3k6lUGrBRh4/SEXwM4OvBb?=
 =?us-ascii?Q?PeRbC+hFnUU3OORd+X8pmADf5nCUU/S0nCDqLoGFToq2xy4bhLVvD1MGrkEh?=
 =?us-ascii?Q?wH99tzqDNq4VnOh0U9ezGMFOWPUIE9ZyHkcLhtDlj4aLborg+lcjf+D0Ii/Y?=
 =?us-ascii?Q?+t01ocus5TnuTx55ZmmCIy4UBZ+djH/3nekpUACQOrx4HHDwt3QU0FGT8zvZ?=
 =?us-ascii?Q?zEcOXssUYgWgGd2e+N11NKM5TtLS/Ijz1Zo403KfqWBv57sPt8PKgMYa7UUL?=
 =?us-ascii?Q?jnwwBdfvyGSiKueFBgOslyoRKvOTUtvtF0dSwblhRv9w9XaCCGAqQVinK/u8?=
 =?us-ascii?Q?tA5qVHjeALfaH5W3Oh1RQd9yw1jzV9akhKSM7mOohUFGyoNVewv9tO5Mg6wm?=
 =?us-ascii?Q?S5Hn2fjg+lTks99qD3WDFjwaD1eGYCt58kxo4CT+8SyM2fmntGd3BPr0LNRy?=
 =?us-ascii?Q?YSU0L3moG5RgH9gO/ZQJRDRDTX2fZulXNRRbtuun7YISmANsRmR+KxvG9RQy?=
 =?us-ascii?Q?K3fl4Zyv/t6rn4q2VGBoiDsODV8QLrKAf4zv0AilBExZA86CJB2yGIqLW4X6?=
 =?us-ascii?Q?jIpqX2CJTJ2+vjbpLLCypRGSk0ScK9jmOnNCRXzvOTaOm8Gpw+aCGmrfTdr9?=
 =?us-ascii?Q?mFZkln684LOGW+xTDGVeIspPks695sk2EeYLB0JsIMDiyOOXSibZ054sUduH?=
 =?us-ascii?Q?gTEz3ELxdzBSRZA937jAWYhEBzZRDnv0L7kTTBdKFjSG0h9L8nYQi6OTd3LE?=
 =?us-ascii?Q?vn5E8rFUGDZSFlHDOS4dFNGIJOhfLDVtTN91pmXtPwCWtt7zn16FNbrs8bIb?=
 =?us-ascii?Q?UqC9XtpkHsTdPXKV4n37pCMLw9peEEvphoSMjZwD8y8kxRSyWcMaYLz+d0iZ?=
 =?us-ascii?Q?ccOiCUMaHjG0A8zjymMxpdEOrZDVz2dtLPA/A162R9IrCIYO6tq1lwjGSl06?=
 =?us-ascii?Q?zPXfPJfdQKXlF4hRBaum/cwy5kMJjHOd5dpmDFhpQc5eBMuKvly7N8CtQfXn?=
 =?us-ascii?Q?P4ph7nmf7R5Mic3ynl86/yL0uxyGZyC6p/65rw7ZiG8B3gB1jDdkdUhTjuZP?=
 =?us-ascii?Q?Af9O3wxDQ+oUo8N0rqgWG0b+af2vrD6JlZPo2N7Mz/Fmgq/ELp8c/ONrY0So?=
 =?us-ascii?Q?XGxbCYNKCcEZdjiEBWCfTIiuP6ZvryqaW5kHvrFNlx0o1yc1ZdyjKn0L+B91?=
 =?us-ascii?Q?lnihCVgakou5PONKFHUKLM5qee3D+olLRLTjE7sgPwtn8LMQPK305VghGG2Q?=
 =?us-ascii?Q?AeIhuXaW3EfhcmMf74gUoZcd4oa8fXxB9XgFE+Yma7e7FQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1RcZq3geMDlIeNXTWhEcuIrquTL9eEMi+mmPoscqHdRLvk4sdOxi/C3FZWXv?=
 =?us-ascii?Q?EQkpcmbf/55R6xAl3omK70g3J4PgcWw3H0YhQbNN0C0azJC/iAy2YvMSRipr?=
 =?us-ascii?Q?mIpBJE+rqcCAAZbPIZmQ6QihYtxTzyrBm3L8mrNgm9ZLyLmTmBt7Ij+d5Ny8?=
 =?us-ascii?Q?ilWcQXXWUWeDJJ+DYs/4soWxC9BJm5YVzmSNKj6AP2Yi6GFgcmUdLXwGZOU8?=
 =?us-ascii?Q?177GkIF3pWhPa5/oxY56rGxIas3m7bYPtfCci6OOCorJDFHjlQymqt99SAqQ?=
 =?us-ascii?Q?ThFCgeu3ZBFIWt+0pniKyDKYxldb/f926J/MA68qYXCSVGSwi8uELo2LKjJb?=
 =?us-ascii?Q?Y0dnk6mMpH4KkjItrIdzWaaM4n5FKJ/ZnHxxZ6iJcnvrGzl9I0oN1rO8IuNM?=
 =?us-ascii?Q?P386W+YslXH0GQIc0uPUJnV7wRJOHoIQfSjyOueAPIr/7REoftP9Mc+cFiDY?=
 =?us-ascii?Q?EmVhring9sffPYPmj8JcMzDd9u6yxogn2y5wDXVp3ljq8bH5ruEb/mDP+Szz?=
 =?us-ascii?Q?klQSjpUt5MpyoFFkGyfw4MTQ2AevV6HkXvE8aCCBLFzGUp+tjUO21QuvlB2U?=
 =?us-ascii?Q?rRd68GXI43R33a7TMDZ4xqU/IXvuVH6Re7Y2Gfd7NcJ0RVeu+cppAZkeyn4Q?=
 =?us-ascii?Q?Ili97IbVEGxNKNnwF8KWvvyCJt7xptfRtJwkVwaiJTO1/P6/Uxt0Ia2dIM49?=
 =?us-ascii?Q?/zSYIX1tw+qHDxFENI6ekzQDSCPy8GneHWOjamazvnhvB6Iyxbu/4Psae5HA?=
 =?us-ascii?Q?Vv/ZD4SDs1T35oicpPz7ln6d/vxKdDOhixItK/LwmDkBThM7JwY7edIGpoG1?=
 =?us-ascii?Q?++3PsfNwEq3zrkymNNm97qaV2q/plHy86y6IBrUQ2OmXPHcxx8NGZZ7GCHcs?=
 =?us-ascii?Q?rnacrYLmZVhfDG4/kHlaydd7RP6Yru+m+ckVk7pETg715vacQTuKt5Q7trww?=
 =?us-ascii?Q?p0J4k2l4U/bfZSbGmw6Ip0uVF8XuH5peqBdhWDyiOkHok/9s4yVqX+aoLBRj?=
 =?us-ascii?Q?pllD36NPCIfinqK2JyWnsz6iL4ZTyKe5Wee9moqCjFj6KRPMFh0vgDLACB+y?=
 =?us-ascii?Q?NUC5opcInk5et7JhyaBSc14sdqKookNJjWsNTZblj4opZxI23hVfIJ+4LGHZ?=
 =?us-ascii?Q?9P/dmBUEckK5aVTWpq2vceqKDsyw8ZhVd74I7Cw5T5nRI/Teu0iPYsyyKibg?=
 =?us-ascii?Q?hhhXFCoe2RMhUD3giPkX0/8/uOyoyaNua+KJRMSJlfpMOCxEdZdKSF30Ro98?=
 =?us-ascii?Q?GrtZN8EPxZgkhII8Da5FEDUnNiBkjsomdo5JC5rAI1SiVPY4KYc2HKpQ27kE?=
 =?us-ascii?Q?WCtcdBuvHT4TsCH6dYOIPXqlkkizSaHfHEDfTzz5Ecb8RLupjhiwk76YNZbx?=
 =?us-ascii?Q?VF6ljXteQEY/2n6loxhzIKuvDiDidMf+Ry9aoJlCWHGqzQdJb9deKNVRGYIF?=
 =?us-ascii?Q?OEvShEuBn6o/wntd99xBlusJvrg54lkYJY2yRrcU4tGy/sQDKtJ1c2bJNFk8?=
 =?us-ascii?Q?xQP5pDv7CyxDl0Ehsuf3HObJjc4BcgyIbc/YitfgP1lUkRGc5ZMU0O2X3BFW?=
 =?us-ascii?Q?SON792LtIJ79xo7eRZf47hIncR7V+LBejhAVfo18?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f246928b-d77b-43e2-0724-08dcc6a794ca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 14:50:24.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1z99cX/Ti758sQ8VIFd5tcJjYs45lxA6yr/MSKa5yqu0orrkvAkWdgR5bqFIiZS334MgRZ8JbwPleKVpA8/kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786

On Mon, Aug 26, 2024 at 04:13:53PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> If the boost ratio isn't calculated properly for the system for any
> reason this can cause other problems that are non-obvious.
> 
> Raise all messages to warn instead.
> 
> Suggested-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/acpi/cppc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index 1d631ac5ec328..e94507110ca24 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -75,17 +75,17 @@ static void amd_set_max_freq_ratio(void)
>  
>  	rc = cppc_get_perf_caps(0, &perf_caps);
>  	if (rc) {
> -		pr_debug("Could not retrieve perf counters (%d)\n", rc);
> +		pr_warn("Could not retrieve perf counters (%d)\n", rc);
>  		return;
>  	}
>  
>  	rc = amd_get_boost_ratio_numerator(0, &highest_perf);
>  	if (rc)
> -		pr_debug("Could not retrieve highest performance\n");
> +		pr_warn("Could not retrieve highest performance\n");
>  	nominal_perf = perf_caps.nominal_perf;
>  
>  	if (!nominal_perf) {
> -		pr_debug("Could not retrieve nominal performance\n");
> +		pr_warn("Could not retrieve nominal performance\n");
>  		return;
>  	}
>  
> @@ -93,7 +93,7 @@ static void amd_set_max_freq_ratio(void)
>  	/* midpoint between max_boost and max_P */
>  	perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
>  	if (!perf_ratio) {
> -		pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
> +		pr_warn("Non-zero highest/nominal perf values led to a 0 ratio\n");
>  		return;

Aside:
perf_ratio is a u64, and SCHED_CAPACITY_SCALE is (1L << 10). Thus, is
it even possible to have !perf_ratio?

Otherwise, I am ok with this promotion of pr_debug to pr_warn.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

