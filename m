Return-Path: <linux-acpi+bounces-9650-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F41349D1B23
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 23:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E077B21CEC
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 22:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C391192598;
	Mon, 18 Nov 2024 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nS+dPnEO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27814E2C0;
	Mon, 18 Nov 2024 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731969093; cv=fail; b=OocSHrDs98M9LrhhRegMM0SWX76iqlaiSyBp1nKPwkAcmSNDQ7vJ2madtnj0+s9ePWacgilVrwNGWAIWoJ3SSDxzP4yr2IosLCbAWfx5PIHaoxHaEGWfPye2KfXJaTuEnZyJz1hHNyBVbQEiN0vJdHpG13pqvOgZ93eLrmK7gNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731969093; c=relaxed/simple;
	bh=IPDM6Xi/rfktkMP9P0viq7kN7n37KMdSEriNBoYvbNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hKcBUQz8lkx+8Hz0Dgeo7G1qaq+630oPDElRkA5+/n7I+1titoSg8GrPA/XRbBOySOBZNm/ZEj6DktlTcXmsOZVGbYLbvf06kvJci0qr6nACFvcdD/KEUSi0Dr8ophZTVTD/qNSztCIxkYd+XhKUWuFCnmYRHAhprFnWX+rhlcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nS+dPnEO; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xe0FcrPwmq/9yzKXdIYI/R0+EALkdnohDprx2CX9fbidv7wUDXrS1Fw1zZlYX+TQGT3ePjXAaCLTGRFxVPuzbs1RZCz/au0IAiyppdC21bAXC/8ry4sRzfdxCiBizmUfoMWa+Twpuuldocr23pm6u+xjtrAcvZEGPGDsYJ+fdpj9rPsLh6iAzM1VvQYXafuOGRDrXnQl9pgxLzgbl5gAMblQJa215U8Ibf47aM9r3djhGw47doEQyKD3HdsYi1gLe7fgZlK00IdhCRSKaknQ24Rx/Vrm1Tnz9MfHNX1obWFJtOr/BrODfcUJ6E8CjsrbVWh1ePOeXiXo20qZVzgmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/63asJoWm8pwN8r28NzIlxrqGoL+04csiyKWrCKnlkY=;
 b=HJCoHzAdq2JNq3Wfo9fbu67WCRpuw9HcuJbDf2TVMq0fytyqOqZE+2vxamkKOmF/kwKrgPUhUegmfJwr0MAYDYD70QuDKSCVPr1WNaFqUwjKt7+j+kuibHbdYpMQrC0OM+KVUaFBmyG5Zjfk5goQlRVkp9uPHY2LclV9YvOh7zy7YVrUc82y/19C1YsDWYCrDHhIbdLWK/yXGwvqNTaNqJVdUHQzCI1e51YGvjKkYMy+nlj+7i+wd7Ej9BF9eWvb4DRY56zSnUd3sQrh6imSiWIs72EVeFpaAmxc2GnszZmtDDyAMtU4CidcdkQJCGRmjsCFKGaUN9uLlVLsthjdEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/63asJoWm8pwN8r28NzIlxrqGoL+04csiyKWrCKnlkY=;
 b=nS+dPnEOZ6co9lAwtT2hZF1v4sHx83GnXSzK1D73WZ7wCHDVhYVA0cU1FtZDCYXYoYmHCD2/Esb5VRK/M9T6FnAdeg5fjPKk7U3uTRkAdoNBR8zFvPpGF5qJdaQstaGOWc0YvvUaML+5q74XdHoHqd35inafLXp8cn5q3LEI9YM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 22:31:29 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%5]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 22:31:29 +0000
Date: Mon, 18 Nov 2024 16:31:13 -0600
From: John Allen <john.allen@amd.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com, Avadhut.Naik@amd.com,
	viro@zeniv.linux.org.uk, arnd@arndb.de, ira.weiny@intel.com,
	dave.jiang@intel.com, sthanneeru.opensrc@micron.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH 4/8] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <ZzvAMWuOvw4j4C5n@AUSJOHALLEN.amd.com>
References: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
 <20241022213429.1561784-5-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213429.1561784-5-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: b9264f65-0bcd-4008-c159-08dd0820beff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cPk1LmQhP7YjlV099YLD7kA2RY1ac/Q5s4CjExoeirPkjstR9iCRniTqqKQG?=
 =?us-ascii?Q?vip+BG4cF5avHu+RzuFo8TgiIq+diMOOnzQDFYLTrOJQDBXHX7wIvN2l7VO8?=
 =?us-ascii?Q?42Bk0LhehxL1Bc3v5OAog/QGBdcVhyzn9ULF02DxSynM5Y0U1MokwZr0FC9a?=
 =?us-ascii?Q?SuwY3xwVXQFnO1ZnHtjkVy3RWdeoJcXGwaYdAqnz94gmuXTkQvNysw5PxbMN?=
 =?us-ascii?Q?5HMvckMKH57+PNzXUHulnBjwjrOBVr/VM7UzGzTYmWKQ/CqTbwb3sg4y4RMW?=
 =?us-ascii?Q?lqRAvdndn/Ju0moHaqDzmLEPn0v9B3BS0eSOhIDvWtR0/lhRFoypwRc30BJT?=
 =?us-ascii?Q?ywauKlReMXc4nd7Fx6f2cgLgRAl1mmRKfl/K/O94Gskk8ogsASAX3e85BDXS?=
 =?us-ascii?Q?nKygMrhTdPGpmSVK0pgPyrh4gtEJK1DWCnRJM5FeXyfgi7tTL8tbVyRxvSnz?=
 =?us-ascii?Q?QU/nZaRFIut70yeDHIijSUClua91mI5peGxd1x9RSO9DmvpjsW4GPXUTWsVz?=
 =?us-ascii?Q?hMQGdkwsGkRqyxeNPtQY5UaH3LvW+sHcoJHmimsVhMPcqyVR+PYWdbcxFt6e?=
 =?us-ascii?Q?TK47YqCI+rNPGzO7mAb/1aB9IGuU0TQalrNz41jVdd09bWMVLwP9xjhmHntZ?=
 =?us-ascii?Q?VNaQRIloKVA8FEiuVD6JQLOR6nbqspjstusHfh1Jcol9Vsi3VOr3XdXxSTZA?=
 =?us-ascii?Q?vuK4LiU00sxBvNoS9jCIZ68kqb0yqxVCbaYoBQjjV5N2UWy4DVaSapecC8ig?=
 =?us-ascii?Q?zjMPQ+tDN2MsOWJG6dh/bXwlAwsh+tXEenq5M/B7Z/wLyKDs8xkBCRNFOtA+?=
 =?us-ascii?Q?VwFNGZfATtnl0HcwZF7LWZIQbKERr0eqKZCl7AlYRqpnAyRNzMN630oPGxYY?=
 =?us-ascii?Q?KyDDOfs/XXJkFJrY08B9RBmykjXfyxBtKt6VCOUmjpuW/jQG9NFtBqaL2Ji6?=
 =?us-ascii?Q?1AhmlyexQhvtZJJ4kzwwROKeS+iWMg18sWTTljjEjFC/fAj2SsDFpu93yijy?=
 =?us-ascii?Q?IllW8uw0fDJOlxTrVNQhBIeVymxXPLzJ1xkzAqcQLj/jXk6lRLpwaD70LzwS?=
 =?us-ascii?Q?Omfrygi0ntnQ76c6GsI3jkxeO8PSIkXxz/S3BboQco+mmHseHFrB0onI4f68?=
 =?us-ascii?Q?lmUpkiKuJbjJOlUil7FUjtpoQvdgT6r2OcDoT9FJNfdy0up5VpCrRixbZoX1?=
 =?us-ascii?Q?riENwht6ni7MYCrDT+6rNK89StuJsVOHh92n+QKI7ZX8iMVp5bdhk9TAhg1L?=
 =?us-ascii?Q?5UwJrx+B3zP2VwAUWvID12HLmTz79ZkmTyhWSKCINT1qXCt17NdsIWGQY6PN?=
 =?us-ascii?Q?f9yHjIaxVI3Obij5P2EYg0i+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DdD5qWFTMgChJcTWtGYB4tdMkQCvZWYaeus/j78jsulE9rXF7Z/16Bdb0VHj?=
 =?us-ascii?Q?2DrsTV+8vrnHNP/fapYIgEiJfc1fyB9svmUCbSdG+JSQXpsaCYC/CYFQ4ocS?=
 =?us-ascii?Q?enzJTAOuaN2ieEdszVUkymmTs+iGGMXS/3w/WNMZgIiMbEHYf8p419Iw+Pgm?=
 =?us-ascii?Q?smlBsXbkzz+hY6mWt4xOHJ9hjrlm3TSraAM6GSSNbVXvTOu0Yh7SCBGCPUWu?=
 =?us-ascii?Q?27rYSPQEOzh3aM/UmfKnastRDdHr18tEvzpFHyQkHis2jNXg6Cwfnw/erBsZ?=
 =?us-ascii?Q?owe6n+i5Q5mW9AFKyXQ5LMzM1Qfxhy8faLHgfWni/JyJh2fmbQiJuJNJ9bAK?=
 =?us-ascii?Q?n1KJ9RyzYXzT+b3rKglJT+C+6/w8MHQBDCz2Ephl6tm+Dps8auTEMu+T1aYJ?=
 =?us-ascii?Q?Q2RM43TcA6kdCNo4AkuRUqSQ1gG4MT8I8dPXjoA3HMttS55go2l8DeDiLqZ7?=
 =?us-ascii?Q?HETUU0/4cdkj1gktcO7M5x8UUmZ/D10y7hliZ7d1uARmn7jqrnlBh53hB12q?=
 =?us-ascii?Q?DmNfrWNF+7AEC37ksutaRHDMbZGuT1MQzHk7B8qzitgzfBhYrxt8TKhlMN8d?=
 =?us-ascii?Q?fSc+u6Jp9GLgehyzjIUFzl9oa8pUAiUdirQavsxzLXMh6Dg1wd9fnhLn4Jy5?=
 =?us-ascii?Q?8djGKcfnuNwJZlGXUKS+uA/jhgtaziYFeGZ6xamMYQ3g4s0Ghq1hIBGJ9cCd?=
 =?us-ascii?Q?wQnDl/nGds83TT8QZgf5NUgcnjP2bO+UrifOPHOkwBq3xRMOwlWoUowr42rb?=
 =?us-ascii?Q?iCvRZqJjcnZZ127l8OxAfjFNyPpfcQ2OTwqolBR3kJhJgcBJpRFY6yXuTVww?=
 =?us-ascii?Q?2LfbPRfufwMX+OEGAO7VTTIIeSUj1sOWMuwkr798brQmmKYZSLGb1RxZzmr8?=
 =?us-ascii?Q?zRSeYRSg3GfPH1nzb1n0WNdot3Xg8ZGPjLN2EXTOPboy5H9FoFA50DQmXo0i?=
 =?us-ascii?Q?PGa88LeWi9tTcKG1AwLS/ZYvL26lEtHdh+HSDKIi6qQ8X/tYgCJcQ2In6t9K?=
 =?us-ascii?Q?7SSB6Map9n5GP9SiLD24F9IHr7yDxwNvmAOT9KjVr6E8HboGfFkD4zBlxRzc?=
 =?us-ascii?Q?q4BzFTRImIZdHTW7jmNDRxheYEswZkckdLLIq0BoGpYHmdDqhKHB9ss9iMGf?=
 =?us-ascii?Q?UI+ZujtlUp2Ju8Kb85iyJt2IiinvdZEzwXSO4QhPzEKGKY9IjBW5xhCcWC7g?=
 =?us-ascii?Q?rBqaXhjGyTZ+OSIi7fGVuPpJGPgYxiBnNvj25mJWbM5VnU6z0Me4tgcOu2q/?=
 =?us-ascii?Q?ZVkbp1DBiPiJsog5ZSes9IpCAh0dkq9dC34PG3EtkYr7yK0z5OhMqNtI2aTq?=
 =?us-ascii?Q?k8VjVTqNMkLatXkmdFRLIeC6XcjVaI6+XHJMnaPqAgpOF9HljorZ1cS0H8uJ?=
 =?us-ascii?Q?iwPWlvWeYO0YD2jWmbSaCd77QNcflxTn0WAuFuCxBTI2o7KWqWgujed6E0bi?=
 =?us-ascii?Q?U8SU957YlpQkU4t7Ld9RxFDnxJijP11C6hNKmYvqaiUEAOXl9gNvjsqI+OmE?=
 =?us-ascii?Q?WI00giezVQjqKJi3Egy/5bYpWdmcjPMP/ByaCtDLqLqafeuaG/qukkUbqi+H?=
 =?us-ascii?Q?osMxE6aFDqqFVMFwv1wUGeHthjialkLalxVaXDIE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9264f65-0bcd-4008-c159-08dd0820beff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 22:31:29.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdfp7yDVgzcepzPjnCRLcsllGjFv4CCo0OFmK35AbKeMLF+OanjF5xpjIczEtogH6YUiS5512UPAAeIqhop3CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475

On Tue, Oct 22, 2024 at 02:34:25PM -0700, Zaid Alali wrote:
> Enable the driver to show all supported error injections for EINJ
> and EINJv2 at the same time. EINJv2 capabilities can be discovered
> by checking the return value of get_error_type, where bit 30 set
> indicates EINJv2 support.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/apei-internal.h |  2 +-
>  drivers/acpi/apei/einj-core.c     | 33 +++++++++++++++++++++++--------
>  drivers/acpi/apei/einj-cxl.c      |  2 +-
>  3 files changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index cd2766c69d78..9a3dbaeed39a 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -131,7 +131,7 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>  
>  int apei_osc_setup(void);
>  
> -int einj_get_available_error_type(u32 *type);
> +int einj_get_available_error_type(u32 *type, int version);
>  int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>  		      u64 param4);
>  int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 78c5a20115eb..3621f071a735 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -33,6 +33,7 @@
>  #define SLEEP_UNIT_MAX		5000			/* 5ms */
>  /* Firmware should respond within 1 seconds */
>  #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
> +#define ACPI65_EINJV2_SUPP	BIT(30)
>  #define ACPI5_VENDOR_BIT	BIT(31)
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
> @@ -84,6 +85,7 @@ static struct debugfs_blob_wrapper vendor_errors;
>  static char vendor_dev[64];
>  
>  static u32 available_error_type;
> +static u32 available_error_type_v2;
>  
>  /*
>   * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
> @@ -159,13 +161,13 @@ static void einj_exec_ctx_init(struct apei_exec_context *ctx)
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
> @@ -174,12 +176,12 @@ static int __einj_get_available_error_type(u32 *type)
>  }
>  
>  /* Get error injection capabilities of the platform */
> -int einj_get_available_error_type(u32 *type)
> +int einj_get_available_error_type(u32 *type, int version)
>  {
>  	int rc;
>  
>  	mutex_lock(&einj_mutex);
> -	rc = __einj_get_available_error_type(type);
> +	rc = __einj_get_available_error_type(type, version);
>  	mutex_unlock(&einj_mutex);
>  
>  	return rc;
> @@ -647,6 +649,11 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>  	{ BIT(11), "Platform Uncorrectable fatal"},
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
> @@ -654,8 +661,13 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
>  		if (available_error_type & einj_error_type_string[pos].mask)
>  			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
> -				   einj_error_type_string[pos].str);
> -
> +					   einj_error_type_string[pos].str);

This looks like it may have been unintentional. Alignment of the above
line should be left alone and the newline kept.

> +	if (available_error_type & ACPI65_EINJV2_SUPP) {
> +		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++)
> +			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
> +				seq_printf(m, "0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
> +						   einjv2_error_type_string[pos].str);

Similarly, the above line should be aligned as the other one was
previously:

				seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
					   einjv2_error_type_string[pos].str);

> +	}
>  	return 0;
>  }
>  
> @@ -692,7 +704,7 @@ int einj_validate_error_type(u64 type)
>  	if (tval & (tval - 1))
>  		return -EINVAL;
>  	if (!vendor)
> -		if (!(type & available_error_type))
> +		if (!(type & (available_error_type)))

Why are these extra parens being added? Is there a reason for this?

>  			return -EINVAL;
>  
>  	return 0;
> @@ -769,9 +781,14 @@ static int __init einj_probe(struct platform_device *pdev)
>  		goto err_put_table;
>  	}
>  
> -	rc = einj_get_available_error_type(&available_error_type);
> +	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
>  	if (rc)
>  		return rc;
> +	if (available_error_type & ACPI65_EINJV2_SUPP) {
> +		rc = einj_get_available_error_type(&available_error_type_v2, ACPI_EINJV2_GET_ERROR_TYPE);

checkpatch.pl complains about the above line being longer the 100 chars.
This should be broken up.

Thanks,
John

> +		if (rc)
> +			return rc;
> +	}
>  
>  	rc = -ENOMEM;
>  	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
> index a4e709937236..5ffc4a162c70 100644
> --- a/drivers/acpi/apei/einj-cxl.c
> +++ b/drivers/acpi/apei/einj-cxl.c
> @@ -30,7 +30,7 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>  	int cxl_err, rc;
>  	u32 available_error_type = 0;
>  
> -	rc = einj_get_available_error_type(&available_error_type);
> +	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
>  	if (rc)
>  		return rc;
>  
> -- 
> 2.34.1
> 

