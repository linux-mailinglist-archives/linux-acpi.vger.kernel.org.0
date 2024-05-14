Return-Path: <linux-acpi+bounces-5802-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89F8C5B4B
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 20:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48ED283896
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 18:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14083180A83;
	Tue, 14 May 2024 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e4p1qzvQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5117F39F;
	Tue, 14 May 2024 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712261; cv=fail; b=o6N2NHAu9Cjvb12BWdJtaEAAVHN6bpuWVMv2FUMVLEyiW6hl8LVnP1+5QdUKOGSHJTKflfh1JT/Zj1ZOuVhtnaObU1cqUGlylvQ+CwKpSU8u8Y5ypisajtMZnFiRIVB2wH0oyz/FJx+o5f2rvRXut21258EFrYRHPwwxGPlNd+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712261; c=relaxed/simple;
	bh=tD6UjklD/U3aO7sl1/RtIbQJrDmBmnIJJU1SZgij6As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FyGNLy7sPeYQMcs+UBXambiC4k33lDTaFTLDUwMdkVn6eTIKpoBMNxgMKGso7Tv7fy/9UH4RijNRiHDccKW40hsP2X8oW5shmYyxWlZLba9d4xFJg5mHHmAFxpSZNjdUvzAvivG7vhabc6fOWARKO5D/LQC8dcBWHCukZLyLK4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e4p1qzvQ; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXu5h5TBTknrK+zJU9p7gmeRC6K47BLti1rIxam2JEL/jLAY3QR1+l/tjsbPGiRcERXfPlXXvLHQ1oGsBSqKLNXoczQf2NIFy7ylfOXzCN81NoJpNwrfzIjcxqagMJzp1Xp2OsOrHrknU3fgxaG6P2RzVE4UVgr6gn7VhoUOyGIymIxPMDlv6UKD8zLb9OMpEk4JBcnWLeqK66nUs1Tw0hi7MN1LM+dcc8srSmRPpgySKMb8kfqWGpCX7Ep9LxbWNceqWy/pERpaEKmVrQbtaibwEUJdfnUOV42Pw0T4pcod0vDr1RZNIYlnyjj4pQD7O54AfiEu8J+ytOwNclS2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ie4p6XaoQl2K6mBDplYLoILpC+yyf7Pzpdtdp37ncs=;
 b=iAU6pNC+VSVCpdQcDHTkLJ8tfAZ8CIf9qh9GEaWfpu6XTKPVoAmy9c7qMy12RwkQA5e/udjYuGwdAIhI9la7u6wLBxmQjvSlZApz5Nyuk+GvGFvlGBm9ulD6XTErw4cquD4IuXeTVKI7EFbiWcUjEMiuRXvPqRykV+GG6Jkq83Zmj8wMpuZgtBHbQH9/zDVV5uPH1/Fdzp2e4CRAcydhrRJFfUrbVh0C7/LH/hp1qCAzss9vMp4CbgOB+HoDnDd94U9UPZXLgIMNx3sfMJH+yTWwpSgE+9eDGQwyV7pFyLoRdICq3CenXhoNSi7oDdikQT9DpE7U+iT2EOF7cd1t5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ie4p6XaoQl2K6mBDplYLoILpC+yyf7Pzpdtdp37ncs=;
 b=e4p1qzvQKoLCt5oN8KsssnCLXBhsurCGA6Vm2HhYghlWAEFVmmyS2qpMjRpvT0rXHnC2HjX9zABU9DCdownTb6cjzclN3AL8Js7dWupJA9jpN7YeX9ql4Or9863LMjEcpEVsPBSTi8ovDWonBi4ixFCxmPO8ynYSGRMie2WSRJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 18:44:16 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 18:44:16 +0000
Date: Tue, 14 May 2024 13:44:06 -0500
From: John Allen <john.allen@amd.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
	robert.moore@intel.com, Avadhut.Naik@amd.com,
	xueshuai@linux.alibaba.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] ACPI: APEI: EINJ: Add debugfs files for EINJv2
 support
Message-ID: <ZkOw9nPxf4xoAXXd@AUS-L1-JOHALLEN.amd.com>
References: <20240312212626.29007-1-zaidal@os.amperecomputing.com>
 <20240312212626.29007-4-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312212626.29007-4-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: SJ0PR05CA0189.namprd05.prod.outlook.com
 (2603:10b6:a03:330::14) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 35752a39-5ff3-404f-4146-08dc7445da7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z6wJ6xnVmGTWzkvsiiNuSI3DMtm1mwIeFU5bcweATIhnl0vhWUCX12oHx/+O?=
 =?us-ascii?Q?1NkQle3y06ZO477SZJYtahHoUDQWHv16oi3d5Vd1aMazmmbIIzlzC0dd/36a?=
 =?us-ascii?Q?IXYOoQZQGHJJmOmKGKl5u6xhWLsa1M0kQCPtx2wgHv7JgB9yEbpz19AuZnHq?=
 =?us-ascii?Q?Vgf/TTcBWdc2akPCrLvUURZIDdPMQceG9u/AgRv7NQLi0mkhr4jR7tc34mAL?=
 =?us-ascii?Q?QEALZ5L8IattFcq/mrBTzFjNElnDVyeWm1Rx9Ib02XDYh6hA1/9x0HoOpmt+?=
 =?us-ascii?Q?8j4Sox5AzbiBcYAzs4LYq6/q6HiJrTBiVH87YpckeIa127SH9n46B1S6y9ID?=
 =?us-ascii?Q?2bTsL/nXsOKPo7SnSUOaV8xFHHVHFWsL3OU+YChjVZvy/d4WPzZ5Y3L5UfAB?=
 =?us-ascii?Q?mFHABwUcbEXiwzUc28GV8Yau4zlf/0dnvGxmEqwIy2WZK4P9wd/W9Ou6dzjG?=
 =?us-ascii?Q?7tN5jCVctLLnCtH0Za+qqq91PC1Rfi5gzOelvfOpJh2DRIjUzHF2kKFBt9ou?=
 =?us-ascii?Q?BojRYZzW6uBoEvtD6yxaRmE4ZiSY1QBjbig15D++zQAJR6qm1VSYXa0cmJ5c?=
 =?us-ascii?Q?nNya0e6LIuGJ8hiSypHZTkBtFAihPzpB6zjWJUYSHKljT+KNquCRTSGI9MWz?=
 =?us-ascii?Q?OYcjc2gKwe+M6WI1SnTi035k2KgtnvIb37JtvUlfi8QskvHF2GSVyLn8Fna0?=
 =?us-ascii?Q?yFrgdiz+FboCo+Z+fEe2PEo/MNLA0uy7vnhriFBVYkCPX2/F9hdHpnpIcok1?=
 =?us-ascii?Q?NwIsaJOAYYwOOe5couNYl4UxAY+sTMMpinJG1/yHbVTYW0cEoycnSNpCFtCO?=
 =?us-ascii?Q?TgBwx0Bj5tEBBcDNkGQbdeIjQW9rsg0ZGRQYl6EYxDxZVlkydWj1jTOalWxB?=
 =?us-ascii?Q?izSvKmEjleQManpubBPA3QFxVHz1MU0klw1eBFKdKrDXiSa4n8YRwSndCr96?=
 =?us-ascii?Q?tyS5ChRdnqi/xyZxp9wTyudUfX20NtFNzJUgIStJtKaQemDEWEl9Jjxi0DDu?=
 =?us-ascii?Q?/4fGZiVIAvWaKv4ZrYVGW6ycYPtoFuJ//NMEyKgTeIoN3HEbCXvLGaxAOAP8?=
 =?us-ascii?Q?b4L/RmnOJbOrbcsKPRlCdaWVRuhzyz8UwWBAvNTgykE8j88DulFpGeQN0Vv2?=
 =?us-ascii?Q?7e2wg6vYRtWUS+br7GL4PP5c0c2Y0q2a9C/lDfYfNZnWrfbzjypeJ5gUrb/W?=
 =?us-ascii?Q?/4cC/yx/ANCd5fyjaFevPiNfEpTCqp6ET3a2x/EFFh6axvFv3oNRloUcXjbi?=
 =?us-ascii?Q?GzB7tSlCcAFKs36Tq+Qdl5s6KFFildni2fXzgi97xg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z74gnJYH4ONbJtOVJ1HqaqCwz9Fufwph0xG6d2ouYh9kRY+BENRXVz5suREm?=
 =?us-ascii?Q?vZ61qTtg5KxXd4bLLp0MyZPmqOXYSD/wFYG96rRbpravAxBcJMAHm9sejp5H?=
 =?us-ascii?Q?DssnP8+i63REZqyAgkcQa1sGgugxR3UVOcZ2kC9iCfPZaouB+3NEwFhxOvVF?=
 =?us-ascii?Q?WVfCN2w1gGSqQL6PbNH0nMVyA+5+McL1LDHIGBl1vaQReZ7N7uY4sSTw5+MN?=
 =?us-ascii?Q?AazbdeYgvz8E7GnpJFXMwbZhGfTRoRl5cMkGrgDpbvI1iC+Bo0ACIZnkqf66?=
 =?us-ascii?Q?6A+KsO/rqiAJUVf7tBD7uwOGx3ds3p2K8VxTASPcXSh7Nwy3bLVMReLSJ4ia?=
 =?us-ascii?Q?3kDAXjv7ZPzGsvA+x5c6RUt0plArmuGa9Ms/HQA9Acm3Pd4dccbXGLdOnjya?=
 =?us-ascii?Q?Nmck3xxFXp91BwFFPqh6uYhvF4jzZ5I0zOXbBEUZvbUm1oaiTgSfVwsqZJjt?=
 =?us-ascii?Q?Nn6gbf85xVxXtIj5ZP7R1HWslP6WktS+IDYc3LQfSn6e6xWAMjcX1t/khqpt?=
 =?us-ascii?Q?BB2uP+pkkemhZJJfy+zygF1n7oq5YQA2CehMI2Whfqnra86Uv1dkhBtB/tm0?=
 =?us-ascii?Q?wIdU4C3rKtxhXoWF29PDTQ6XD3xROvXXfiAUsNfEwGD205rLYzrDKAioLg+b?=
 =?us-ascii?Q?Xg7O/uC5MiPXL+T846SOU5PPzzDizvEtRnksAdhf0zSTi7IwzvfoQnIi0MM4?=
 =?us-ascii?Q?AlGiofwUxckeKd7XdV/5zOxt4NfZaSo81imw7hmynN23WBfdcvurNR08KzDf?=
 =?us-ascii?Q?UDxXNclrnqfRRlYNNHZ5uB09bEJtlGX4V1TOx6xaJfRUVe7VCUpiGgoXNgET?=
 =?us-ascii?Q?21ywqpkkLrc14r0LexJLXGbliR0CVycjUBNqlvi/azqMboVkoYmy3KhYOqEo?=
 =?us-ascii?Q?9meYFt46wqp3k/9hakS76zMvOcNr3YpkX4BJ/k88GBLAbEm49eovnM7QEw23?=
 =?us-ascii?Q?6lNOdvpwfpX2d15bit1vy8Jh5y7CkDBPot97LWZZalGHjGCSsPxR+e331JwU?=
 =?us-ascii?Q?mzZzUAV2VBE9IMZ2Uz1WKwdkIZmhFaENreU1lFsc6w5nT2Qbec4rFSxY9gVj?=
 =?us-ascii?Q?pR8geVHOZMEj3LrY+uCBxd4JBPPNvIBhgOMEmIjIVQbfsGbesY4uhJddwYAV?=
 =?us-ascii?Q?51uzKbAyKFeNtRZOZ5QWsjo/TCcbC7cOemgPO2cyi9y+cB5smJiqqW7iAa/m?=
 =?us-ascii?Q?s8y7G8iaBNPGgGzFDBwOuusWF03E1REKbv57RXheel6qjKy4dhTx4aC5IGzH?=
 =?us-ascii?Q?t9M68Bk4qvbQRcUNgcp9qQsMuZEPHSve96+EnEQ7bBPNLx9S3UPrL2nF38Nn?=
 =?us-ascii?Q?a7U+a7zs5HcUU+f6KErbkpjfITPgz+u5QudRdq3jO4vN2azJ7Mb5eEytk8IA?=
 =?us-ascii?Q?+1apQUB3JC15p1gnG/XMH5PHRyynjJHHQQ6TbS5I+SwqUr27us330ies3s9R?=
 =?us-ascii?Q?fuPnbiviYxsiEiJSqwMXTIJ4r76NuOR8Mvhi7aGUMrXdV8/WfLPK+4nRfoA2?=
 =?us-ascii?Q?3GqZpSLx6Ft7EeeSElwztYoma8tsi591CIOA/9KiBAa6ZGlZJv4h0Ud15Ysw?=
 =?us-ascii?Q?00HWkVwRtoxCPLpPK68YLTrXTWOQ6fFb2HEIiNhX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35752a39-5ff3-404f-4146-08dc7445da7b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 18:44:15.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vyPFzji1G8MesJFB4NA1RHFXlnHHMpXELLq9lcwJVyCt8HPg1rdMRGvuZ1ww7L234vaK6ua1r0sI8cujH512A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259

On Tue, Mar 12, 2024 at 02:26:24PM -0700, Zaid Alali wrote:
> EINJv2 enables users to inject errors to multiple components/
> devices at the same time. This commit creates a debugfs blob

Drop "This commit" and write this using imperative mood (as a command).
For example, "Create a debugfs blob file to be used for reading the user
input for the component array".

> file to be used for reading the user input for component array.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 119f7accd1c9..ceac53aa0d3f 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -101,6 +101,10 @@ static struct debugfs_blob_wrapper vendor_blob;
>  static struct debugfs_blob_wrapper vendor_errors;
>  static char vendor_dev[64];
>  
> +static struct debugfs_blob_wrapper einjv2_component_arr;
> +static u64 component_count;
> +static void *user_input;
> +
>  /*
>   * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
>   * EINJ table through an unpublished extension. Use with caution as
> @@ -810,6 +814,8 @@ static int __init einj_init(void)
>  
>  	einj_param = einj_get_parameter_address();
>  	if ((param_extension || acpi5) && einj_param) {
> +		u32 error_type;
> +
>  		debugfs_create_x32("flags", S_IRUSR | S_IWUSR, einj_debug_dir,
>  				   &error_flags);
>  		debugfs_create_x64("param1", S_IRUSR | S_IWUSR, einj_debug_dir,
> @@ -820,6 +826,25 @@ static int __init einj_init(void)
>  				   &error_param3);
>  		debugfs_create_x64("param4", S_IRUSR | S_IWUSR, einj_debug_dir,
>  				   &error_param4);
> +
> +		rc = einj_get_available_error_type(&error_type, ACPI_EINJ_GET_ERROR_TYPE);
> +		if (rc)
> +			return rc;
> +
> +		if (error_type & ACPI65_EINJV2_SUPP) {
> +			debugfs_create_x64("einjv2_component_count", S_IRUSR | S_IWUSR,
> +					einj_debug_dir,	&component_count);
> +			user_input = kzalloc(PAGE_SIZE, GFP_KERNEL);

What is the reason for a PAGE_SIZE allocation here?

I would guess that a typical user will only supply a couple entries in
the component array. If this is x86 and PAGE_SIZE is 4k, that's probably
fine, but IIUC, ARM can have up to 64k pages which seems like a lot more
than is needed here. I would think that since this is architecture
independent ACPI code, we want to avoid using something architecture
dependent like page size here anyway.

I also think that while 4k may be fine (and usually overkill) in most
cases, it's much smaller than the maximum possible number of entries.
While uncommon, we might want to allow for a larger allocation while
still keeping the default allocation small. Maybe a module parameter
could be used to allocate a bigger file if needed?

Thanks,
John

> +			if (!user_input) {
> +				rc = -ENOMEM;
> +				goto err_release;
> +			}
> +			einjv2_component_arr.data = user_input;
> +			einjv2_component_arr.size = PAGE_SIZE;
> +			debugfs_create_blob("einjv2_component_array", S_IRUSR | S_IWUSR,
> +					einj_debug_dir, &einjv2_component_arr);
> +		}
> +
>  		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
>  				   einj_debug_dir, &notrigger);
>  	}
> @@ -871,6 +896,7 @@ static void __exit einj_exit(void)
>  	apei_resources_fini(&einj_resources);
>  	debugfs_remove_recursive(einj_debug_dir);
>  	acpi_put_table((struct acpi_table_header *)einj_tab);
> +	kfree(user_input);
>  }
>  
>  module_init(einj_init);
> -- 
> 2.34.1
> 

