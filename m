Return-Path: <linux-acpi+bounces-5803-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BD38C5B86
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 21:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813791F232F1
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B8181325;
	Tue, 14 May 2024 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zveEA+I+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E1181318;
	Tue, 14 May 2024 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713860; cv=fail; b=T4vY/h4dJyMrFOOFBXWs0DSqyqNlmjYUicONxijMeOem3HNxBbYXCYLUzBdiJ5cMRrjuZSQQfCombyzYBbjJ5Glkrg129GdxogNjG9bVGAAuPGjqwaz1750wDp9KtrzSQnMlUqKfn7TYnpfowUCdpaHIGeumQT/0FkzZhSKjLK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713860; c=relaxed/simple;
	bh=gVHFj5OMIC4KbgHzwmVDDYlEI3WEYq4lQri9r1QPhhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JpSX+eqmrKmXwkAuyOmHqXKkdu8muBEKcJGm9GvpwlWZsCZ0baUxB1CaXI8xtHbfjMTYQRWP2n3An0BeDC6fk030x0DJsGpKUxD+sqFq0cD+qFylfaVtReLbPBg+qgITnZYe6Lum25mzjMQuJmvsWpuZXfntaJpOdFeI5+3tedA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zveEA+I+; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNN/rsT1lXMNtn6pHMAv4UDD3rArqETtFVpijOs9qpxJqxUA0Pc+BJoKixnkoGK43LWoJ2NA+JMr+boKTCoCdsEULs37+MUU6x6cshtbcwftjjWh67GNt/Pxc4GkM/Xd4+FixIWVCGU67PwdW8XFxJTSDSnBx8Lw6c8RPIPk9bnMvlZ8vqxknU0TlO7d7hiduWaTRVMAyLAYP/zZXf1wcFijEoXIAnOBHr47ShCBSr2pjhxFOFKyQmf2p3AAToz0wYA/ExjRkVhepUF72Cn2TgHz8Vwoy3GkZ9rPFP8qCE1O+Rw/44kVoUnzfAMhwxQTKFRO4IWqMbXh4FI+Ba2gKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDQcMbG23il32S0DZV39vysXn3xEB9XoWmRaQnIo4Mc=;
 b=OhnR75/f/Iz4mMktX79/jlwXHXhzv5TGxTU58AaShFkLBuM/dqIrRFfgcCraNR5ya+iEw3SwlmHbu5zzUOoa9FXGOaMpBK5iT3sciQzATv9gY/AMryQBXUiooATAAmX+gltAz2xyxNG3gxAeLj5h3p286Ig2FzyIhXSRibpKOAwuhvRF2Lg8z4gg4sEGwl/vdsAjkaO1LubSYTQIwsssZGJtxJNRwRIG/fqamEnALvM2gY5RZakbcW0OjA4T+hStygne8g9dTaSHlGZReeproV/Vr6GrD5z+ewExzdP61RkP1+2krxW15HwATCefK+xUJMBVSqGIz2CXzs1BywUAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDQcMbG23il32S0DZV39vysXn3xEB9XoWmRaQnIo4Mc=;
 b=zveEA+I+HGfr0V6tMAVzIuRxElJ6MZ1x7ZONwC3A3REQvDtCcLJRqFMUT33KYgG4BDyU0N5JsX10NZiYfOBtCKuQzLitI03l5HeAhSVlphhfon4fnbGkNH0E2E3Ad99N1/1f9WNoxdi+0QAiCj0gxyj4ZO8HjI4C2RJj10a8lQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 19:10:55 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 19:10:55 +0000
Date: Tue, 14 May 2024 14:10:45 -0500
From: John Allen <john.allen@amd.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
	robert.moore@intel.com, Avadhut.Naik@amd.com,
	xueshuai@linux.alibaba.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <ZkO3NRUV7Kjrf/VS@AUS-L1-JOHALLEN.amd.com>
References: <20240312212626.29007-1-zaidal@os.amperecomputing.com>
 <20240312212626.29007-2-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312212626.29007-2-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: BY3PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::34) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ab5589-2234-4098-b881-08dc74499441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YArxOsgTrEPeTNT6NnG3OxXnvsem8pJQJRfqG4xGTRzdis5gLI1cgNsTb0Pn?=
 =?us-ascii?Q?icdr81LO8UrHmQDf0ighgJSAkRySc60WCGTMAeRZ1KO298jq346ZmVLeo9CW?=
 =?us-ascii?Q?xBB0UnhaGH0w37aDen2hvDt4AnCc3BuT1MntEb5sb1SgjR/rRTndpDKwLXdK?=
 =?us-ascii?Q?BwhaYoO0ewtH1WE46k5up0A6ih8waiBKaOLJRPSaKOu6KEUcV3V340zgnLOc?=
 =?us-ascii?Q?Z/68GCY3Vzc1o/FM+qDjHp9keKw0xBmXfDS2p17FiMqYjHYgQXkPCNp/UqH2?=
 =?us-ascii?Q?vcwAYICN2W6+iScCWg8TPq+VKK34oB+5rfXzbBAYoHBSUInelPJaHIX5KmV1?=
 =?us-ascii?Q?pgmtr9S/yp4BVgTRDqrPg8wJI6RUlmUsG65Aphv6cjQa+QQzWUcySaQ5fu0o?=
 =?us-ascii?Q?J5Q1jmsLZsw0YCZoGvPbn5dh2KzGUTltCRO60iwqIA5lF2amw4++ehG+6OPp?=
 =?us-ascii?Q?rX/aIZ3AS4Wt6Ex+aunaq9tAjEoYmxa7uX0nmL9aWfNJhWLXw1qxO+kmfkFp?=
 =?us-ascii?Q?fHF9V+EXZDWmBXa0qb+pkNspQiuqfe/vpBoSXjPOE2AZi4U14AClbP9X0QCy?=
 =?us-ascii?Q?93EWfsXzTYOc42sSoNKBOj0LogtdQVplKpxm9yYR5xKm6FOYN8Uj2lcTngEo?=
 =?us-ascii?Q?SHLE+SFUF4SG4j5XW5npoI4e/uvVDmARm91K245OGsYE7C3VQJgai0MSywFd?=
 =?us-ascii?Q?/jIwvmSrRD4/FW8KkJgEQIJ6mSJr/64vqdK7b/GvpofatUkFFRfSnZenMiuv?=
 =?us-ascii?Q?9x3T2FTPMxkZ6tLvOPzXcCRyxDbZ5thRjsnEOGewsSYpLH2xVRzB4q4u3FzP?=
 =?us-ascii?Q?UsSjnHdbmFWj8tEAM6EVct6yqQQO05JN6zh5c7IVPiXTykHYEDXU4bSOSueS?=
 =?us-ascii?Q?cxEZSllgnrqsQ6HTxin/Fy+wYMAtUuI0Nf95VDNCxIsOCPaWB81ETT1M+qQr?=
 =?us-ascii?Q?F3EiX+o8azfdCEY078FQ+WzxUrhmyzBUUdTy0ehLtQKh4y+X7oQt7HrdgL3m?=
 =?us-ascii?Q?ZvleaqPDnfVTA1JL0Nb+hlwB2yw75VAa+zbhlRFQw2gvPLng/7rlsCDLn6SF?=
 =?us-ascii?Q?x6Jl5wQr1mNez0iOa/qE2Kmwb1I+c0mnuVlaOj4uO5fRjSLEvMHI2D3Ifelm?=
 =?us-ascii?Q?YcqzEiqfADCBDXDX/ckDVwYZYCQGmsA2UpusLidBA3hoJ9dv65Ys1OJ5KLFT?=
 =?us-ascii?Q?Nr+R8sb90NHfmLL1auviKYttvD/aafV1YIBJvejUKXGMPMzfgP3SwrPfGVzy?=
 =?us-ascii?Q?7xEDW+WsgewdB1c3IqU6xisa+Eec8bzX9Mcw7Ll14Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oWtdVcncTRFkbHgiQEcM4qraj66N0PqJHEgtC7lSiWPSPwVa0HpXEtSq0x/U?=
 =?us-ascii?Q?+FvhsfcoM8+6BNlmJlQCOV6wD1kyQoSUAsTpcO2fcgJGT8X8JYaBzJWTV8H7?=
 =?us-ascii?Q?2XQMsxyAcKmKBp3AcmI18J0YWjAVgRRNiKHem3zRg2Bq85aZDKZW0Ca9rypE?=
 =?us-ascii?Q?l/6OIuWLiUu+cH8+gUoL0RCT8CaJiHAH5xVqBT9v8fBBqF0zyvhRrzzgRhxi?=
 =?us-ascii?Q?6PeewR7yR0Rt8185iUYLB/EtfBkgW27lEg3ZKpTSuyhygqOLNA/NqhDZYINs?=
 =?us-ascii?Q?9qPswOeM0pci1Ne4pKONtLZg5yfpLL7qVOB7Koxa5y1Tfc16Y5belufgsLJQ?=
 =?us-ascii?Q?4BdW4QOZDcay4zMsYl2jCUZVRsHQGtxMZBiqrhe3gABpwU0W7XydG7qIXUyw?=
 =?us-ascii?Q?i2kb9T4gnIx3M80RKLJYtRUR4CYcjQUF47sJ5/BXQAUMWTY7beHCR/iXvZcQ?=
 =?us-ascii?Q?JfhGGUluykAExHaznVeO1doUfSQPTneCpovXVzvWr1bKVh0Q8qk83L9a+y5D?=
 =?us-ascii?Q?uGXzTYDfT31geOpGodWJ4urVOclYFVVeWClsaogV2AIJL1A7t7u3DY1NgSWH?=
 =?us-ascii?Q?7DXMKSAIfxVAIgOYg8M7a5ezFd9tXJUFoUf7dvZFTBhClzsfZ0G90jYE057T?=
 =?us-ascii?Q?mITRCXLUzdUI3XoLd+BMsnI11BiwuQzLOw9aO0xQtC6P5wLiAxjnJqxFKFa2?=
 =?us-ascii?Q?hofdM8fL7G0Ua3NW70oUR8YfiLHmdWUL7x3DQ2bHBrhWZNN1lO8teMI9ZHGQ?=
 =?us-ascii?Q?iTPDdh/GOCZOTT6IqCzE/sGeeCQnxPDyCPMvZawgpX8MHaxRKAOYFZy+UiIy?=
 =?us-ascii?Q?9gtsOrL9NOSMSm67ci0N5oHINr9tQ7m3XH2Neju9vkN0Bc5nBBoEzNn/fiC+?=
 =?us-ascii?Q?LftqcqfT4eISHsogxm54fUBOaxoEE4x4d57Qk5hhDKb57RqawJ4eLq7mpkmf?=
 =?us-ascii?Q?rFc0BQjDPI0DFXbBDm8f2aYa+DNwNdseWDowtHSuTtm5P1orqfE5LYuJ6YhE?=
 =?us-ascii?Q?iT+4ZJC6GZyuDkS3IGtxjftaKoXaoWxAeNxy/4rlE8N14ff7FO1aiP6v22EE?=
 =?us-ascii?Q?4Af3bWPudb0pDhXmfec8mRh5nWltXdTJfwrvutOGa85bMsIHsSOiikQa6Brh?=
 =?us-ascii?Q?Muk5STTL7SeCzX+8skLiL1G7bEH+hXWF5viJ6NUb5JmRMjNxgkQjwojDu6/t?=
 =?us-ascii?Q?PKer5NEQ6TTsZDUu3klGg0xJP4X5bZScNkn6hKfzurPhuTuteG5ofZ2/CraZ?=
 =?us-ascii?Q?0I9lNEj2gIXWQ+OJLM+pTS6qFDnhs/SyVp8skQApWmPr/d5NuefeHi1NQkOj?=
 =?us-ascii?Q?giy8QibcC0RnFUpRLB8nDUUqA8Tx2sza9cNnhoE9E4+EJqf0v30LJh+WaDMb?=
 =?us-ascii?Q?+crvcOkA//KjCBQLw3W5ytzNpzFZFDeytZVwnSKnXKHsHga5VbhFKGVfJTD7?=
 =?us-ascii?Q?L902SBCuDpx/+PAjUIdV2t1ZVbhS28DqGMZ6xPZgermgT3JOHrDXIEyKnJ/6?=
 =?us-ascii?Q?b+EmI8IztHHZCjS+UlkbxYVHKkGvQCjq5OdpI+GCHK13q+DsblOkzfspfIie?=
 =?us-ascii?Q?1jo61Hdo02Rkd69TiLUBkiKL06GFhZQn01AtdoPE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ab5589-2234-4098-b881-08dc74499441
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 19:10:55.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrZ8KAOQ02l9j6b4nLFbFX8DH8qliGrd45r+Iznh9Zt9F4/yEDkSYRTwZJ+Eyp8rzJmjykPqlUutC+PGYScyAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738

On Tue, Mar 12, 2024 at 02:26:22PM -0700, Zaid Alali wrote:
> EINJv2 capabilities can be discovered by checking the return value
> of get_error_type, where bit 30 set indicates EINJv2 support. This
> commit enables the driver to show all supported error injections

Drop "This commit" and write this using imperative mood (as a command).
For this one, "Enable the driver to show all supported error injections
for EINJ and EINJv2 at the same time".

> for EINJ and EINJv2 at the same time.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj.c | 37 ++++++++++++++++++++++++++++++-------
>  include/acpi/actbl1.h    |  1 +
>  2 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 89fb9331c611..90efbcbf6b54 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -32,6 +32,7 @@
>  #define SLEEP_UNIT_MAX		5000			/* 5ms */
>  /* Firmware should respond within 1 seconds */
>  #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
> +#define ACPI65_EINJV2_SUPP	BIT(30)
>  #define ACPI5_VENDOR_BIT	BIT(31)
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
> @@ -145,13 +146,13 @@ static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>  			   EINJ_TAB_ENTRY(einj_tab), einj_tab->entries);
>  }
>  
> -static int __einj_get_available_error_type(u32 *type)
> +static int __einj_get_available_error_type(u32 *type, int version)
>  {
>  	struct apei_exec_context ctx;
>  	int rc;
>  
>  	einj_exec_ctx_init(&ctx);
> -	rc = apei_exec_run(&ctx, ACPI_EINJ_GET_ERROR_TYPE);
> +	rc = apei_exec_run(&ctx, version);
>  	if (rc)
>  		return rc;
>  	*type = apei_exec_ctx_get_output(&ctx);
> @@ -160,12 +161,12 @@ static int __einj_get_available_error_type(u32 *type)
>  }
>  
>  /* Get error injection capabilities of the platform */
> -static int einj_get_available_error_type(u32 *type)
> +static int einj_get_available_error_type(u32 *type, int version)
>  {
>  	int rc;
>  
>  	mutex_lock(&einj_mutex);
> -	rc = __einj_get_available_error_type(type);
> +	rc = __einj_get_available_error_type(type, version);
>  	mutex_unlock(&einj_mutex);
>  
>  	return rc;
> @@ -221,9 +222,14 @@ static void check_vendor_extension(u64 paddr,
>  
>  static void *einj_get_parameter_address(void)
>  {
> -	int i;
> +	int i, rc;
>  	u64 pa_v4 = 0, pa_v5 = 0;
>  	struct acpi_whea_header *entry;
> +	u32 error_type = 0;
> +
> +	rc = einj_get_available_error_type(&error_type, ACPI_EINJ_GET_ERROR_TYPE);
> +	if (rc)
> +		return NULL;
>  
>  	entry = EINJ_TAB_ENTRY(einj_tab);
>  	for (i = 0; i < einj_tab->entries; i++) {
> @@ -615,19 +621,35 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>  	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
>  	{ BIT(31), "Vendor Defined Error Types" },
>  };
> +static struct { u32 mask; const char *str; } const einjv2_error_type_string[] = {
> +	{ BIT(0), "EINJV2 Processor Error" },
> +	{ BIT(1), "EINJV2 Memory Error" },
> +	{ BIT(2), "EINJV2 PCI Express Error" },
> +};
>  
>  static int available_error_type_show(struct seq_file *m, void *v)
>  {
>  	int rc;
>  	u32 error_type = 0;
>  
> -	rc = einj_get_available_error_type(&error_type);
> +	rc = einj_get_available_error_type(&error_type, ACPI_EINJ_GET_ERROR_TYPE);
>  	if (rc)
>  		return rc;
>  	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
>  		if (error_type & einj_error_type_string[pos].mask)
>  			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
>  				   einj_error_type_string[pos].str);
> +	if (error_type & ACPI65_EINJV2_SUPP) {
> +		rc = einj_get_available_error_type(&error_type, ACPI_EINJV2_GET_ERROR_TYPE);
> +		if (rc)
> +			return rc;
> +		seq_printf(m, "====================\n");

Seems like if we're going to visually split the EINJ and EINJv2 cases,
rather than just splitting them with the above line, it might be better
to be more descriptive. For example:

# cat available_error_type
EINJ error types:
0x00000002    Processor Uncorrectable non-fatal
0x00000008    Memory Correctable
0x00000010    Memory Uncorrectable non-fatal
EINJv2 error types:
0x00000001    EINJV2 Processor Error
0x00000002    EINJV2 Memory Error

> +		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++)
> +			if (error_type & einjv2_error_type_string[pos].mask)
> +				seq_printf(m, "0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
> +					einjv2_error_type_string[pos].str);

When you break a long function call like this, the second line should
align below the first character after the parenthesis. For example:

	seq_printf(m, "0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
		   einjv2_error_type_string[pos].str);

There are a few other places in the series where alignment should be
fixed in this way as well.

Thanks,
John

> +
> +	}
>  
>  	return 0;
>  }
> @@ -662,7 +684,8 @@ static int error_type_set(void *data, u64 val)
>  	if (tval & (tval - 1))
>  		return -EINVAL;
>  	if (!vendor) {
> -		rc = einj_get_available_error_type(&available_error_type);
> +		rc = einj_get_available_error_type(&available_error_type,
> +				ACPI_EINJ_GET_ERROR_TYPE);
>  		if (rc)
>  			return rc;
>  		if (!(val & available_error_type))
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index a33375e055ad..a07d564b0590 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1030,6 +1030,7 @@ enum acpi_einj_actions {
>  	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 8,
>  	ACPI_EINJ_GET_EXECUTE_TIMINGS = 9,
>  	ACPI_EINJ_ACTION_RESERVED = 10,	/* 10 and greater are reserved */
> +	ACPI_EINJV2_GET_ERROR_TYPE = 0x11,
>  	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
>  };
>  
> -- 
> 2.34.1
> 

