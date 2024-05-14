Return-Path: <linux-acpi+bounces-5804-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D95A8C5BB5
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 21:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8B5282849
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BCF181313;
	Tue, 14 May 2024 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fwe8Jhot"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06A144D0B;
	Tue, 14 May 2024 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715715298; cv=fail; b=r7AXEytFmpnCPiXt6L9ZF8w5lKU2QSGLN7WH3KrCLOyWgTJf8aLbL3IzbMOcEYQlH34bf3hEmib6RYfkgVYL041tRxhOrbxAnKauaQt5tZWulwdBz9HSAVMIPL827Pu9JMJZi6LTzoiadX2gUi357pPm3IvlFMGa7inPyDwe/e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715715298; c=relaxed/simple;
	bh=jOlYDrA1+Ydc12wrxtVQw6/Eu+y4DBZjFgk3OrYSnTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lDvuPZdof8uoJjEtE8dQ9b7Zyf0OjpbXc373LX7nMdrYw6q8iDZTze9sfVmiZUDUqz5xM8JVtDQtEuOwpScD5a324+/fbzNTiVu3gaJvQmLcZCGaldJgSf9yFuzKsoSpDQgfeV+D5Dc+Ta2Sq0xxxK9nWK6d8a7qh8txMDfBq5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fwe8Jhot; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhN+CVk77IHghJbAwcm+zxTPI+r7cSZe2Gn4YyeCi+bdu9EIys98lgnCEgqWdKa9aJI38iQHhhxQhI3BvSXEoMaQr6raImmB7O78svZ92Se3ZRNnwC5ZbCRwQPke3/prum0PoWNmoYt49N2hKK40tmr8VtdRWxR+cT6iLMGr4klLYUv+K9Zg+gt+UAmcOymgW72/5Spm2Q+5wleoLqCbksAjjZJz41NVtyzFdGsN119gNf3wB2V+XJgRr9vScqYUpeQ/6Lybro14mArn0sRMaXalRehtVbzViBdTegPNWPEV9CbW+lNPDBN7nBYthHhqtpLP6vO85Ybo0JGF3neHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjI5jS+2WpkN7aezxdItb2nYjcrQlF1hAg8sPhTzBPY=;
 b=llKpy1xz3EXoHkvwAhmkst8TxIXpcHjvVJYL1WCMx632fNJV3skkcLv3FDNsHpfhJhLqdF4bNPvk2MJXIRxgJurFMJ0iG1a1/Eq1FRer5TQgdpFdQlHeqvrPYGKyWO+uXGI/9KotctSrokpFoU/1mUuj3vj2+Axfo4Odhj+rk7VKCU9aZrbzJPPjSOMlx06hi4zrq/TfuLCUt57kQcp8bzmMp704tydRcl7BQfMOzHXpEPAddfK4CTtrfzZCIBOOtLxOwxjgh2nG/mJUkS9FGlRjRJ1t7L4NxbJzT0xVPZE9MWPDakFwWLB9pkjGbvYwjHrLe6p+rO5DlL0o7SultQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjI5jS+2WpkN7aezxdItb2nYjcrQlF1hAg8sPhTzBPY=;
 b=Fwe8JhotbXe3Rv6ANlip7+JfuO7uq4IUUxqJkGeodezYYgaPHqDgHxFJHXiJAPlwSgNbtyeC98GFU3VbIj/bgiAp9BEHgHoJIuHAgWMehQelaz2zdVuXqNFaY6weBJHMxAg/jom/9F50nUUpr0AK+jLRUDgQQ8fB/gKH83wQdb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 19:34:53 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 19:34:53 +0000
Date: Tue, 14 May 2024 14:34:44 -0500
From: John Allen <john.allen@amd.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
	robert.moore@intel.com, Avadhut.Naik@amd.com,
	xueshuai@linux.alibaba.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [RFC PATCH 4/5] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <ZkO81HeI5qyDxOMf@AUS-L1-JOHALLEN.amd.com>
References: <20240312212626.29007-1-zaidal@os.amperecomputing.com>
 <20240312212626.29007-5-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312212626.29007-5-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1023e7-c228-431e-96c6-08dc744ced55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mIPtxO9uUEbfx76wteDs7H+B5tysDUl64v9BH9Fc/BOq5j+0nSh0/ojjvmng?=
 =?us-ascii?Q?/iO/+hs9KM6sR5k/uh7dcXMUGn870GNTu2sTxZ8KGSKr72SGLsp1TEMGCwz5?=
 =?us-ascii?Q?Bys06cPlcdXcAXgHkHS1FtbkTBwrQDSjNICT2nylsHzfRTd+a2C8V8ekPUJe?=
 =?us-ascii?Q?WoJbcJU9DeOv8ogkobQd9E+9H1sPuMuBQPsovG5seJiqhd1PEusZRnp5hKBZ?=
 =?us-ascii?Q?qCcdgrmd8Ae4Ocbls7aPtT7juAX46cfbZkiHynldJVdpcph2JFpkFr0zk+TM?=
 =?us-ascii?Q?yhAS2PkBJiC2C9lmEnfzENerfw9qZnwjnKiaS3B4JJUJ3/gYPEgQD4btx7+S?=
 =?us-ascii?Q?NoDQDId1MrYtd4vr41GfN1rvelspQQU5z3RROc41nc22GCI3BBAmnmuk4xS8?=
 =?us-ascii?Q?q4k/5oZuk6P7NmlCeX0S0llwIsLdMbp9wcy6CSd+JrvKIrsLbekPdlNVzZAL?=
 =?us-ascii?Q?7tJub56JngG4kEWlSmzjf79ZtplblO0gNCVbp+CtYeTXBl2cEYLtyYJ4n7G+?=
 =?us-ascii?Q?IGbz0cc9BBLD6tp50FpGCfzQa+rWRWNy4qqfZSbmoDxbpEJt/lEMr/bQyz9E?=
 =?us-ascii?Q?Ioy4U+svjqTCXgwbG2KmH1kzSwl+zXK9Fsmbmm1/jugEvCSXxNmstr8dlzGS?=
 =?us-ascii?Q?faf5tg3mgl+V90Hdr0gdIFMy/pfHhVqlDrP1UzUV2BllZIUwn84hZlG8E/Gr?=
 =?us-ascii?Q?IS1QU+6dfUjcnJvufsEiWAivleNCDSjpJk7cjYFYA3J4e78qTNG+wrpGWgdg?=
 =?us-ascii?Q?qwHPtoLsWUCQF3b00eUSyRS6o+crvtovDkTdvjvXg8+epGl4Aft5s7w73/pU?=
 =?us-ascii?Q?RxRBWz+kzpbutqHnD0vzdeEiEpdj6Pco7uA6jS9xkAVXTKf9W8gT62H60sUi?=
 =?us-ascii?Q?dxOt9iH1tFk4n4Hfp1jElJnHzFuoUcLHaadYRyiSZBU98C9i9uISC5mk9IrX?=
 =?us-ascii?Q?QzFtuMoa26ZikXEbc5ZwNXA716hVe0uO6hZBP9lRtwkpGiYQrISV2sCY8HK8?=
 =?us-ascii?Q?wEHiBgCuXfLMatJxJCn41niIOx1nMLxyi1t6xNBWBdp5kfrH1subEmJ8j7ce?=
 =?us-ascii?Q?CfvW2Pu/5Rs/EdvRNwFU60j97pappyk68yUXTUDznJiHI+jCLt9wUtrJ6bkK?=
 =?us-ascii?Q?qq8oMEnjI7FODJLCaVdGsHSxgyh4wkFDXaEEEeA+pk0j19plWMxVZs5Hb+6l?=
 =?us-ascii?Q?SurLiAeKVidV0HgB5xLJSywgKLhbGz+NLoiLCjbc48H3CMWokl5INer0NHlW?=
 =?us-ascii?Q?u2k1kt4E88HmThE8mc/DvftkN7BeUbBQjvQkRv+D5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1tStGMdmGKyL1Gmj6wlJDJKLXCfYm9y4Dp2sghlccQo3w71LVnZHDAZmqRDp?=
 =?us-ascii?Q?r+7qQAxhP3DfYrlY3PgajfnlH7M/8N/SPEPrgnV7FyliY3OpEhEMHt44jtip?=
 =?us-ascii?Q?hsMRLntG3R6/cJoQbdOKlpmmIBlP+2UEu6CFcF14+H/af7LLWGDrRdGsDAtr?=
 =?us-ascii?Q?IzChy3mseUrsJZpbNBH4HG8BT9OcVOPqKk6l4gyKqNzW25sASsNIsnw8vmPE?=
 =?us-ascii?Q?B9wlvnoos1BhB96ghVpRMNOvvUXYIyKNMoSnUBUKXOSYbYyCAp6UIZxjJ/cG?=
 =?us-ascii?Q?al4XF1E977Xya5QCqFTTWrqcgqu/m8OmrsfRZw3iGMAQyuGsYojQNISW5pXS?=
 =?us-ascii?Q?7pMuBgRQunPsiZuU8je8WSTEjsBm0DeMmDmKddFqtyOFUPEWJxEpjsV9v66R?=
 =?us-ascii?Q?/I1Lxh/yk1bMzxjuXOsSxeY7rHoqtjfiq/tvZqg5xwcCUNDgUCCgiAUq4Ote?=
 =?us-ascii?Q?dIb5/ixyyqOnQf0Wy7RFdEgu1b/78VVLoBVdhh8b3KZDPx4hqcC1nd+RSjW7?=
 =?us-ascii?Q?0saVwsh60RSO61iNvvsYFbLWkmwsNEcWsFKlAiezLUUKaiRBSZ50y1Q4yuG2?=
 =?us-ascii?Q?fMyvYeOllD2m6K/uMqrQiLNlU/qtBqZ3oq1Ema+uGJtuubN7xv5X/JXhAOM6?=
 =?us-ascii?Q?5UbZEIGdV/FSnrYTsTtsJxTB670JXwqev7S+2gmZnknkdMi834vzJWguIXsw?=
 =?us-ascii?Q?FkbFlHf3WhgZ6yunHXBr6InyaAkH6+ddlDYJ8eHV+/zh1d4Tkf8BpP/BcKh9?=
 =?us-ascii?Q?laFLt/1wB3DtW7WsrinHHvn671xVLkHfPpB2Wqx9dXZm4JpdC8D5+JYEUgXq?=
 =?us-ascii?Q?q71ov2ezcQ2Gt4uL6xfR1OSjWBa7FSJqVqYJsIGuibWXg8ORgqfKSSu+cQaV?=
 =?us-ascii?Q?Vr8eQU51wnQoDLWyApgiQ68fXstiNB+A2fBGgF4AkpYwzf/GhRcSSCdQIWIb?=
 =?us-ascii?Q?ySexvpDlQ8MFFSHRJlkSrHAAiJUD20cMGq8lOLByZ/LU6+aar78sfTTRUwo7?=
 =?us-ascii?Q?rAYwBud4bddiiDv1Jc8J4EgL/epQcrU3Qev8hPvx9+NPFfWO+57kmuHYvLVI?=
 =?us-ascii?Q?tDwkE3rR8QHI0/Ym0lPQ4GodqvxNtUd7medbodD1L8TfSbQ1kOLV/G7479Ov?=
 =?us-ascii?Q?X8fpxAQ6v/z5WXyfEFPfoigc8EmcKRE8Q3EkULx7VHSkM+wi10taph0iEn1d?=
 =?us-ascii?Q?uAJVbRqIIe9STGNwj1kqsX7F12wkwnfmRlMarNY3TOCepmAdd3k/eXgLBP6H?=
 =?us-ascii?Q?X5z9o37OBuBrRYss+8urQgk49N31p66j/8JcW6DhbKbhFn/fRA1zL0YhOedJ?=
 =?us-ascii?Q?eOsWm5nhtfJbql1OB/clcJYSeTxp6uyom4LA3lEjwUa1vxzgJE6FlRA4hbcI?=
 =?us-ascii?Q?OBQga++5Hy2uuhCfHbP81sP27PdPjHFAbBVoGWQPpWWpv/HVv916nmzjFTBO?=
 =?us-ascii?Q?hxMgew2AlkW72v0VSYBWA4s7bG1eQtL+XIhF8rXjYoo6GUFl/Jb7RTQY9Xjt?=
 =?us-ascii?Q?kQs342LbMFk8SMkS1jWMQm3Y/41FFBRE3tioL0n5vvm1lgG7aGHB34O+cUPv?=
 =?us-ascii?Q?DsQoUynzc7qspbm23Dnu0d7dRvIik5SOEpOgLfdd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1023e7-c228-431e-96c6-08dc744ced55
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 19:34:53.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSyI+ly8Z5xzLD/oGJj3i1Jg6LV8CUyFahwoqEvCeMwzoGDq/IMbC6J13czTfbLvPkTCXyEF4z82cs0bxt19FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883

On Tue, Mar 12, 2024 at 02:26:25PM -0700, Zaid Alali wrote:
> This commit enable the driver to inject EINJv2 type errors.

Same with other commits, commit descriptions should be in imperative
mood. For this one I might say something like, "Support injecting EINJv2
type errors." or something along those lines.

> The component array values are parsed from user_input and expected
> to contain hex values for component id and syndrom seperated by

s/syndrom/syndrome

> space, and multiple components are separated by new line.
> 
> for example:
> component_id1 component_syndrom1

s/syndrom/syndrome

Same for the below lines.

> component_id2 component_syndrom2
>  :
> component_id(n) component_syndrom(n)

This interface seems a bit clunky, but I can't think of a way a better
way to do it right now. Can you provide an example of how a user would
write to the component array file? This would be a good addition to the
example in the documentation provided in patch 5/5.

> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj.c | 89 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 80 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index ceac53aa0d3f..9e31bf707ced 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -80,6 +80,13 @@ enum {
>  	SETWA_FLAGS_APICID = 1,
>  	SETWA_FLAGS_MEM = 2,
>  	SETWA_FLAGS_PCIE_SBDF = 4,
> +	SETWA_FLAGS_EINJV2 = 8,
> +};
> +
> +enum {
> +	EINJV2_PROCESSOR_ERROR = 0x1,
> +	EINJV2_MEMORY_ERROR = 0x2,
> +	EINJV2_PCIE_ERROR = 0x4,
>  };
>  
>  /*
> @@ -104,6 +111,7 @@ static char vendor_dev[64];
>  static struct debugfs_blob_wrapper einjv2_component_arr;
>  static u64 component_count;
>  static void *user_input;
> +static int nr_components;
>  
>  /*
>   * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
> @@ -275,11 +283,20 @@ static void *einj_get_parameter_address(void)
>  	}
>  	if (pa_v5) {
>  		struct set_error_type_with_address *v5param;
> -
>  		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
>  		if (v5param) {
> +			int offset, len;
> +
>  			acpi5 = 1;
>  			check_vendor_extension(pa_v5, v5param);
> +			if (error_type & ACPI65_EINJV2_SUPP) {
> +				len = v5param->einjv2_struct.length;
> +				offset = offsetof(struct einjv2_extension_struct, component_arr);
> +				nr_components = (len-offset)/32;

Binary operators like '-' and '/' should have a single space on either
side:
	nr_components = (len - offset) / 32;

Some places have this right, but there are a number of other places in
the series that should fix this as well.

> +				acpi_os_unmap_iomem(v5param, sizeof(*v5param));
> +				v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param) + (
> +					(nr_components) * sizeof(struct syndrome_array)));
> +			}
>  			return v5param;
>  		}
>  	}
> @@ -485,10 +502,47 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  			v5param->flags = vendor_flags;
>  		} else if (flags) {
>  			v5param->flags = flags;
> -			v5param->memory_address = param1;
> -			v5param->memory_address_range = param2;
> -			v5param->apicid = param3;
> -			v5param->pcie_sbdf = param4;
> +			if (flags & SETWA_FLAGS_MEM) {
> +				v5param->memory_address = param1;
> +				v5param->memory_address_range = param2;
> +			}
> +			if (flags & SETWA_FLAGS_EINJV2) {
> +				if (component_count > nr_components)
> +					return -EINVAL;
> +
> +				v5param->einjv2_struct.component_arr_count = component_count;
> +				int count = 0, bytes_read, pos = 0;
> +				unsigned int comp, synd;
> +				struct syndrome_array *component_arr;
> +
> +				component_arr = v5param->einjv2_struct.component_arr;
> +				while (sscanf(user_input+pos, "%x %x\n%n", &comp, &synd,
> +							&bytes_read) == 2) {
> +					count++;
> +					pos += bytes_read;
> +					if (count > component_count)
> +						return -EINVAL;
> +
> +					switch (type) {
> +					case EINJV2_PROCESSOR_ERROR:
> +						component_arr[count-1].comp_id.acpi_id = comp;
> +						component_arr[count-1].comp_synd.proc_synd = synd;
> +						break;
> +					case EINJV2_MEMORY_ERROR:
> +						component_arr[count-1].comp_id.device_id = comp;
> +						component_arr[count-1].comp_synd.mem_synd = synd;
> +						break;
> +					case EINJV2_PCIE_ERROR:
> +						component_arr[count-1].comp_id.pcie_sbdf = comp;
> +						component_arr[count-1].comp_synd.pcie_synd = synd;
> +						break;

Nesting is getting pretty deep here. A separate function for parsing the
component array could improve readability.

> +					}
> +				}
> +

Remove unneeded new line above.

Thanks,
John

> +			} else {
> +				v5param->apicid = param3;
> +				v5param->pcie_sbdf = param4;
> +			}
>  		} else {
>  			switch (type) {
>  			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
> @@ -572,9 +626,19 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  
>  	/* If user manually set "flags", make sure it is legal */
>  	if (flags && (flags &
> -		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
> +		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF|SETWA_FLAGS_EINJV2)))
>  		return -EINVAL;
>  
> +	/*check if type is a valid EINJv2 error type*/
> +	if (flags & SETWA_FLAGS_EINJV2) {
> +		u32 error_type;
> +
> +		rc = einj_get_available_error_type(&error_type, ACPI_EINJV2_GET_ERROR_TYPE);
> +		if (rc)
> +			return rc;
> +		if (!(type & error_type))
> +			return -EINVAL;
> +	}
>  	/*
>  	 * We need extra sanity checks for memory errors.
>  	 * Other types leap directly to injection.
> @@ -694,7 +758,7 @@ static int error_type_get(void *data, u64 *val)
>  static int error_type_set(void *data, u64 val)
>  {
>  	int rc;
> -	u32 available_error_type = 0;
> +	u32 available_error_type = 0, available_error_type_v2 = 0;
>  	u32 tval, vendor;
>  
>  	/* Only low 32 bits for error type are valid */
> @@ -716,7 +780,13 @@ static int error_type_set(void *data, u64 val)
>  				ACPI_EINJ_GET_ERROR_TYPE);
>  		if (rc)
>  			return rc;
> -		if (!(val & available_error_type))
> +		if (available_error_type & ACPI65_EINJV2_SUPP) {
> +			rc = einj_get_available_error_type(&available_error_type_v2,
> +					ACPI_EINJV2_GET_ERROR_TYPE);
> +			if (rc)
> +				return rc;
> +		}
> +		if (!(val & (available_error_type | available_error_type_v2)))
>  			return -EINVAL;
>  	}
>  	error_type = val;
> @@ -886,7 +956,8 @@ static void __exit einj_exit(void)
>  			sizeof(struct set_error_type_with_address) :
>  			sizeof(struct einj_parameter);
>  
> -		acpi_os_unmap_iomem(einj_param, size);
> +		acpi_os_unmap_iomem(einj_param,
> +				size+((nr_components) * sizeof(struct syndrome_array)));
>  		if (vendor_errors.size)
>  			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
>  	}
> -- 
> 2.34.1
> 

