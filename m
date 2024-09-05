Return-Path: <linux-acpi+bounces-8173-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1EC96DF3A
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 18:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD931F239BB
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFF219EED4;
	Thu,  5 Sep 2024 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XYSOgaUN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456B168B7;
	Thu,  5 Sep 2024 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552602; cv=fail; b=ACF4G79lFRDGegjWZ08wT1FYyqbPf+1HZBx1tXgILfDJ4goSl5pLJRnShNRr1DvMp8nXjZUs1+fE7QxfG5d2UmHbllxwQBdBQ+nQ1gSF+mCEQMP1id52vkthWvEO3KgJGVlMIXglqA5IqjUbAqhl6ILnXxhAw6wt+r9QmJ4ua3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552602; c=relaxed/simple;
	bh=znrf5DJG/DzElY21ckv7/CkG8F7d+P3L8/vHjn6mHxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aQmOR5uQnqRgQ+24I8MsQGB+gkxcR8W2L59upy42YZw+a84aUB03Avcfal72NLX5OVB8Ndkzmh/yssby0/bnZa56W1ZLhSPqivxA9K1Kt8sInY0pLj5yZFIY7yb+76nelePU/eYgD3gHgxZCRTYybeUlIYNMRGzGzK6JP9yHmD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XYSOgaUN; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFEIr1cV01mCfP3cbXjh0mXazEI+9ffNpF6lj8JPT9JwqasMzOSsYs9/AXVLtjal1gpt2xfwxloibJOD3w8qU+OlUYk+92xy3RklRS8mCPZT3gbjSI7XtVDqVH8Z4iLk1Ss8XnHiOuGEpiKP+M47S2AZnlE8bRUrqUAZ6zkz2IZ+Yo704cz+fyYF7QcpWn0X33kjtptuD6mMX1iIIIwwCPR67DFjL5Gm/wtkceB0u8amZ/atk8DUVtxzgOk4kNVb6z09GQA99wW5y5lAa8eitlWxFvOMJPvGbvEfvmy1OvD1HRQKmXWuPEpHhsaQ7lrWC4OgH7YEdBwRAWy+UghePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BPFgLSNVmuHF/N7lyXZR6DMKv7mW6XJLEVialS49fw=;
 b=C+p6UOBOS3e1yjYei+AYQi7SWEhVCL6k/v0XWUoxvYcnV/KpNiYlSFi3Mym4ZHJRxPPUoCvelUn4QY4SFxlNzxeiVsMT4iedZOGYjH+txrILvnL1lwKftnj63VqnWu5oRY4uUWE/HgvPHuQB+l8RQjGxzMIA1Fkl6TxKhJevLLdQPHeL1twewqb4/c3dBR5wyaaDJl9KaIjaZG/RjiJX5mcw/fsVOeXkLpzpBt+pI1w84URBdLOtUQkzlbrOzwV8DRFBhhb9tsTRQ5PLb1QJEUrTr0+LtBLh5otRXFbLAFtVlrJcBbx4/dCxvULzO+c385TmeSu5GutvnwVwxzaD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BPFgLSNVmuHF/N7lyXZR6DMKv7mW6XJLEVialS49fw=;
 b=XYSOgaUNKdcJdRFDMIR4OPuAHBQnEzZ44ovZrN69Vntb6b6Jh/LrDo56lVXxjeHjPdCX3ObVnqx6JoxcEEK7alSf9+u2pne7OY5BaRyWfeWm7uw6kgsjyGideCaAjdUeydLcCb5kFXDHk2J63D/feaTvzv9dox4dKwib4TxYQVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 16:09:55 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 16:09:55 +0000
Date: Thu, 5 Sep 2024 21:39:42 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 10/11] cpufreq: amd-pstate: Add documentation for
 `amd_pstate_hw_prefcore`
Message-ID: <ZtnXxmFdNS2oVviC@BLRRASHENOY1.amd.com>
References: <20240903203701.2695040-1-superm1@kernel.org>
 <20240903203701.2695040-11-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903203701.2695040-11-superm1@kernel.org>
X-ClientProxiedBy: MA0PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: b07944b2-e439-4594-9302-08dccdc52e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j/KPejUL3Oxl5re/9Q+3PXu87i2AB1XAh6gSjRAhOvmZhhb4CP+UqellJXnU?=
 =?us-ascii?Q?a5FbYMCcVEG4f8UENbF9MVl5d1mPcuIekYX2zpehPeVGzHkbTuy1S8FRxtRd?=
 =?us-ascii?Q?pC3xYCxRytMdG1wClJsT13fxcA31YplkZaxQ05kZ/3ttdPwlhF+4/VyQM285?=
 =?us-ascii?Q?Azwx7JHbxWQ8FkLhBfjEez+UYQQxkjFqyN3aM661xVgHevOvSXE+UvXuqNtr?=
 =?us-ascii?Q?ZuBH4opSjRCOOr1eSorWqdZZSMfloycHJayOckq2koKynYFFS76hpo7ZR47m?=
 =?us-ascii?Q?8E5phUnQxHqH2w4h3WcL+itDdbdfnpJd1aojCjaGl8BMERtYs+afXyU0bi1T?=
 =?us-ascii?Q?LyipMZ2ce1mrZhdK7uL7swpM6QsG4A97oa0XEAF+VSU8rwlqyINo0CEIs4Pc?=
 =?us-ascii?Q?PQtxFFt8p+1B7uru8RjGfnU8uAAY3NlxP0JytE3vuGD5vt+PT/LYM4sLqnmZ?=
 =?us-ascii?Q?F4a4eD1RSs6byNchZAp5fHhRsiWU4FAkte7x44DHCyPzYw9jisbwmjIwI1JR?=
 =?us-ascii?Q?VlK1KTaIyXRRqTApKziC/T8hQx4Z6CD0If20Y0lEiJE7cnoay05DWpBLT/KP?=
 =?us-ascii?Q?w+bNoQUYKmalJY4Wnzj0ieiaic/TdPpYeIydWWuuOBY5ETo1GBYprOlFNxa5?=
 =?us-ascii?Q?+KMHa09FZwygaiYCtwUJgphoswE070Xi2EJgEx44GqMrDzabtW7adzmV1YDI?=
 =?us-ascii?Q?a4ITDP+LUVCsxmLvKIQe0opnsMD/ssrUfv3XbRP545GjotKIdyExGo0gd0Pj?=
 =?us-ascii?Q?8lMTJcHY38dnQ26j1HPGhiF2iOOMI2+4l6JHOt4vMipwbLv4MyWBHOTxecHb?=
 =?us-ascii?Q?281wnuSBtOBFaMbd5sGpzfIbA3WTMlKUgHm/k7YJoCF6cQeIggct8jOKVGl+?=
 =?us-ascii?Q?f93BpFqIGy5NSHuYi/kSY0+0cYCLE3r/ayjzUiVg+z9AXzLOZ/9wyDljPkl+?=
 =?us-ascii?Q?B52Vr/6dDOV4A+MjjFJoywbhbC13KsI55q11WBhzO4oPy1QES/1BjxWvgaDw?=
 =?us-ascii?Q?bqTL4sLeebJRm/8tj+XBpKzsyywgX9lbckMzg0bPCpH/9QHcbHO/pL+io21t?=
 =?us-ascii?Q?xbwjDL9zULIJ1nwDUqv/qWBvpS/PqV1Ss+9c0PtOtDtD354uYg99moUXFkMr?=
 =?us-ascii?Q?vdSk97HO47P/magszZTm+WGYaxBhZ7wrpoYTpS7M54Yp1QCHX/Zt7LGblsGF?=
 =?us-ascii?Q?neBPOJXvTu6YDw4yCmg6GNGWZRmwfkEqwlXWRGRoBolYCLlu5OgCkiv0ZwdO?=
 =?us-ascii?Q?YZMT1zfrQY4cIvi2xieAgZjDBeJzd51odUVbZrbailfBDfzNoGw7S3HuXjEn?=
 =?us-ascii?Q?m2WyaqwqrF4XqzVipYDCHM9NWNmKCRE2ITiPp+tJ5j648w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OE81IyLao845AiHH+ifvmajAwSeeGbe18Oa6rvn0HE6VjTgcr+L2OD3zv5ts?=
 =?us-ascii?Q?RmAL7cBoyWCrQxoiPCRiQczO8I0zTfaOI3CTxcnmGJ0LalBMOPL9a0THd6Wj?=
 =?us-ascii?Q?5IDtKnPGv4a0IGNemvjWokt5iuHcya0o7Y79fZ/XOU/Ujkra7vpMN8OlIsHn?=
 =?us-ascii?Q?wHmYPjSgeXQ58cTIp6ncRojI3YvJ5MLB5NnOyAe32PHMXI5MJwdMuAybS9J8?=
 =?us-ascii?Q?1HTMXw0tEtKSor+JC/HrDtxJwKEZZn1xHHcxUG4e6BsDucgI0ftUBFt9d4SB?=
 =?us-ascii?Q?WchwAxmJHBDyy1GHoS+QPjASX0cz8RGk3xgREACzoWv6i8r1ELJ7mw3t4s5u?=
 =?us-ascii?Q?S1bhlka33xgdj6oZIg2rFdU9PyHlYgtFg7N/VE3Aputy8BjVeYNvazxH0IYJ?=
 =?us-ascii?Q?f0zaLFw3luzT4nCt/mfOvT9s/0zIQ/TUk7igxpsY5bJ+h/r//fEHZ6gHNyjW?=
 =?us-ascii?Q?8Ymox5QI/+YqL1oxwvo6XYelULsGHV5JNGxL2AJ84dY/zCM2GU/oXby+TTaa?=
 =?us-ascii?Q?bB9yMUlWw+v8CjKt3lEx8rGZoeL08l81/6zDILAGW9vag62OP0YYq1PTv0JE?=
 =?us-ascii?Q?ZSIsjVxLXVYsHcty96to7oOc3sPUZQLRRJYSuqhJw6gBVrwcYXqqjUb+YdF/?=
 =?us-ascii?Q?f40/2irz9Qk6DWzen11AQhHQUt3cBRoJCXI5kLUlxjLnMabgMwybHBn1J3IS?=
 =?us-ascii?Q?6tsMVEmVpdgSRxHNHnTAsSLj30yMyNwkozXk5U/DyeGKDw0Rb0VHxYzv0/q2?=
 =?us-ascii?Q?zmvutG75bm5Bx8oCB8ulztUpSk6ow/hvBLolRzfpDmWl6tb8mHIBMtkDWd/j?=
 =?us-ascii?Q?HOXMVGrvVXYlaNbZOObNTCiQ1m9R/A/z6TOGXlhYDFGi0kLHvu9B5j4+yXCv?=
 =?us-ascii?Q?Xos5Ivn21i1VEG2C/e+eqJCOTmKjfpo3XVZ5M9sqHKFh0vL3boFR7fBstmpC?=
 =?us-ascii?Q?bZtw9gtCzEL6uKvwU0wze5oybiOoHeOVaL3tcyHr7KrzfinEcPXhvDkNbiMH?=
 =?us-ascii?Q?V1gxQQ6gvrgNOdu2YSxdkyH4g0Ddtxp+GYOlZMw2ksRZE3WvBvx7uSm4w47b?=
 =?us-ascii?Q?FvpyyVEZVbxRAarP8uBXB2/LOBefNB306eipP63WqPnD3SzPFuPfq2Uh3ndw?=
 =?us-ascii?Q?jfAlg7Dp0iv13uS/yj3oT1QJs73qTPfE9H/W7r2joHXvqTImgY5hDMzNlK5F?=
 =?us-ascii?Q?uvJojA2i8QXH5yB5cn8WUf/YW5jIsq++5BZ9Jr4VKC8WViLsmgfm+0O8SFxT?=
 =?us-ascii?Q?vUHJP/SpVs0LxF6WxYZpRkaPabmWHLiIKnejARUBB2Z+A+8TV+RxzZE04Yyc?=
 =?us-ascii?Q?/RWLkL3CnYutl4HyUDR+/lpb5IxE2OIqPOzjcJWn3SaQUYt/wj4WdrtZ/a0q?=
 =?us-ascii?Q?1XZNGRqDw21Xc6v79h5AI+QTHHuaNS6D54NS9ERfjcg5fzA8Bta2wHmjPSBf?=
 =?us-ascii?Q?7GbILcGl/aiD2iubHSJ+cDCuPAvAn6RAn5en2orKyayEhz+pqlt5iIZa+Kgn?=
 =?us-ascii?Q?TyQV5Rp8ItEGK1oOqO2OpISyQy1pkZZirC28mfubyYBWAyJJw97zFPdNlE7C?=
 =?us-ascii?Q?O4NEXHQwm6cZoaP7h0mrv0fzR6Cowc4M6ekYZrtJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07944b2-e439-4594-9302-08dccdc52e36
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:09:55.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KjzdT83z98eYzmV0U7o9608rqr5nRO750Fd7hYXJnvTcr3Rn4Hd6twTEMi1AR6tnKvOEVGhv348ty150WyDrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215

On Tue, Sep 03, 2024 at 03:37:00PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Explain that the sysfs file represents both preferred core being
> enabled by the user and supported by the hardware.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index e13915c540648..d5c050ea390dc 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -263,6 +263,11 @@ lowest non-linear performance in `AMD CPPC Performance Capability
>  <perf_cap_>`_.)
>  This attribute is read-only.
>  
> +``amd_pstate_hw_prefcore``
> +
> +Whether the platform supports the preferred core feature and it has been
> +enabled. This attribute is read-only.
> +
>  ``energy_performance_available_preferences``
>  
>  A list of all the supported EPP preferences that could be used for
> -- 
> 2.43.0
> 

