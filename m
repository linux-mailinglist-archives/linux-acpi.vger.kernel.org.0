Return-Path: <linux-acpi+bounces-9649-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E709D1B0B
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 23:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF481F214D1
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 22:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005991E6DD4;
	Mon, 18 Nov 2024 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G0fblqgN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CCA13DBBE;
	Mon, 18 Nov 2024 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731968472; cv=fail; b=AdBI7QTF4xXTDo8FocTFOC6zogEF1ZeBDKjZIVNQeb/Z5FJ1KWM3+dFmWVhFzqsRe4qwGqUN9HAlwRdq8NxYoLX7HJIolq1RwVch1LhmLC20A7Ae0M/Y3uIWR8WWCRkA5YpSiUo//0CXsS+YIseN+VLnFMSvLQM4eB45qDR7BYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731968472; c=relaxed/simple;
	bh=p2Bc5ctZulIbTobSEJ8cW9NbDTYkrhHhr3TlZiM8p80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KevXbFconoqMk62ieiALeFxaryOXi/PVP6NQ6kws1e4HS0NWbPIvTQCmPnLu8sUT/X09miH1gz6Y/0p8BdlU290xkQvv9TEATIIzE1gDIIeZaU+zABdO307GYG+PmCnt2Ai32uk9++t8Hn9aY1c6dzkOUO2BqxXKRcZPjWmbCts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G0fblqgN; arc=fail smtp.client-ip=40.107.95.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lkjcq5Z1vLlHzgurIPrzRdxMbj1lOZYn62Z/jxTPQ2AQhLMSpKv1LFOrqAu7ixYl5ahV6r2aR4TMNYyBtgmiAgO5eOPte/LvkPTP7pP8WeYYAByRLCZ9ULKZSKgVGxplxTJMAI0HOj3j9AHY9IezIsbfSW5tWOKZyko/I2jGqpEgJXdzQnNm3r5Sm7lvEjYSo207LjgsqaFHz5idJEsHekud5mNDC0uD/XbZfPN/1JBajLZehutpxboNEBHVoB1umstMBBMzaWi7I52FdTplLa51ltcX6FSqFHNM1NbqXT0KCWnfdiQXoR5Mih4VZBWCagq6FZJE0HIadNZkxiT4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2p+UrqzbT50wXEqlKz2O2TjEkRA2Cqc2lBDAaYFlTg=;
 b=A188psJfHsPbdELg5gZeTWrzojluseOphVwryYJLnedSDJAJmNIGB2rTp9N0lar/pgxt/hTqfhYaRADpvFmGVvv8GJ2u3d4GAdIVFAq9EwwYRxXE5zlMrn0fV9kulwfsBHp3Fi6OPFx9wgpkY2nRTRyr6a0aoj8ILG0dKUjubIhP79u3WburLYJ56/ltEz9JBYVoiQ8JmGxKcyStDk9JaCQSg5si3AtoGCekQ/l9HJZdwLZkGmDrepmNJrj6FwciDS1V6U3aZtypbgD6GJf79cC/pUCUopxwebLfDUxrWX2a4C//MRxXvcJqYm/AJQZfDIABsuHNaPQgQOEzgn/eXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2p+UrqzbT50wXEqlKz2O2TjEkRA2Cqc2lBDAaYFlTg=;
 b=G0fblqgNULeZw2W5BGcXyXUg9QtkKd8XEQLpQH1XUgljJnO3P1HOmEgi/QtmaKbgP0ForifAZnSHBNEA0e8hp3/lZ58Ozgr24xlpNu6LLOPoB91fxJ8j/3igSWTyDizlqOHSpDCnL9ZCwCAqSSM4qEt18St1FIUhuvRKS4gnY48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 22:21:08 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%5]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 22:21:08 +0000
Date: Mon, 18 Nov 2024 16:20:53 -0600
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
Subject: Re: [PATCH 7/8] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <Zzu9xWllk6GsT3a+@AUSJOHALLEN.amd.com>
References: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
 <20241022213429.1561784-8-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213429.1561784-8-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: f65eacdb-4809-4a37-0795-08dd081f4c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jRdja2Zi9yN+L+LxL90gxhIGrq0BFQsk8Y8shncN25200MJgDatSFot9WMO7?=
 =?us-ascii?Q?9MkpSeQauH8YKFR2bGU2GD4D5o1jey/Wu8L6T90diKpe4hO5o2BNSyu6QEZ0?=
 =?us-ascii?Q?qdMD46rtaZY/GV6oFXdCbG9gJuQTsr7oeC3pKQozeAq0Qry89B5LLRHUwqbG?=
 =?us-ascii?Q?puf97MGPgfpfGWz9lZf2HfSnPcDMkEzu7gAevH04PeC9lP+fJ9FrAdhNmSUB?=
 =?us-ascii?Q?ahcm2qlP92MwcnvJ0yavlFhTykIZuIMYom8fRRRxwGRZd17q3rx86fRBgQMl?=
 =?us-ascii?Q?1mzI9vYjI+KIHzzYWaUxQm9fJAq02QdyZQqt6VVKDNz8dfxCD8YPbNn6TN3q?=
 =?us-ascii?Q?Ipf37utGputSxyviPcSfwak3OShf12ujJc9LDSl+KyZKzwH3O4VmPKr/FUwN?=
 =?us-ascii?Q?U5xQ0sck+FINr7M3G3t6XSGQ80u+GpxYAhoIud25Zlyi9/ILXPoN+i9PPxvi?=
 =?us-ascii?Q?0pXBsjIlDVlHB+ROBYy+3HTh0VZA7mqBsdTRSnGVtwA6VLcQvGHOovBbMaUQ?=
 =?us-ascii?Q?LiRGal/lZFCnmlgttbvhG8svf1qXal651lIuWU9gau2OVc8SPOh4tpHzs41E?=
 =?us-ascii?Q?yohJ8OP/ooZ9gCGxuXl7Nks+stK9kKc38j4SdLyIqJDUNr4IwrQ53yrVoxYG?=
 =?us-ascii?Q?sX6wTljEV8dY2LGlS9iFltYy5mZqSt6ViRBPq3lAkF/ftMj9wAqcxVd+OcAX?=
 =?us-ascii?Q?2WtTFfr8+ZyjIlI3tWeHx6zuN7wJEYHlRyx5O2fMsXmL1Y6VhzsDWuIFj6Yv?=
 =?us-ascii?Q?74RoegGjA96SUvuBL1Ypqu9CGQEeXllzAH7BvrHfR7+54Mzel7cb3TQLVIJC?=
 =?us-ascii?Q?yk/GIgjPyvU+jIOS8wi+RA/+mB6/K4ty05OBehHP+UDF4yqLOQxPv9edY9Dm?=
 =?us-ascii?Q?1evUTH5TThVEfWSsMvrDKIbD0ewDrExQlcZwAtFV67LndZ4uuK5ZgkH8rJXu?=
 =?us-ascii?Q?SLMEL5kPfOaqw6RA8YMAP1Yt5Qa3bafW/iG9ytpgCtOqg03BUsrJIiugKBNm?=
 =?us-ascii?Q?pW+u00rOv992UuTQYdX4VPw7LfUU6GkRGuAzMg6qnakkYDN/Vv2U8zAv0irh?=
 =?us-ascii?Q?/bw6fAmRaoguGIlTOk3oTef4NM0sJGAwVLOqNZYhfjCTmaBBgfJ1mQZTZATI?=
 =?us-ascii?Q?K9zc4bb6CIilx4oHLOCEPTmvb0eyKi67fiInxAd4sWBscyEv5SR37fIl9DXB?=
 =?us-ascii?Q?DR1rvCAXRM4MtgwTUl2doLA/rK7KmhMlQ8KQk0c/zQqqr6v/D5D/r+kPOAUR?=
 =?us-ascii?Q?GMf3FNNVZFUMvi2om2zgHIeMApWYE1DWzPBSBDwPspMXQ5OUaVDYdFVQZyVS?=
 =?us-ascii?Q?+jf2GkFBdVsY5u7OVq8CYJ6J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?okjyBTvjkPN4+zZM73RsxmWLyrPy6f2f7pw4ccsGHE45UF49cLMLv8+BD3eI?=
 =?us-ascii?Q?twADLU8B3bifz19r+SgqHQ/oKGXfEzzSljMU8mlp1KK+pngWvK2uWS0uWwdF?=
 =?us-ascii?Q?Qja1SHkNcmdd9H4uOqnMJmVlraROSJMiFQ0V4ais5G7Lw380NXkhZ0TDr6te?=
 =?us-ascii?Q?b7ntmmt3Wis2cKdyGWQcrl5t9rvOe3OS1TlPW3oYlhTCR5Um8L/LvZbIEcK9?=
 =?us-ascii?Q?zbLsKDPmYVwJLKL6GQ+Azls1TP+oSZtkTVZnthCu+gR/2d5h6Z4KqKGOXMib?=
 =?us-ascii?Q?fPji6wd9qhWv6g/ErQ8QK4dYirwQBj3rsxHJQ0xtYLV+w5IActLP1FXs74wv?=
 =?us-ascii?Q?srO68ObuZxjAW7s2OxbAEzOD2gpjkkgfTsUMXk28omF925zRJS9mzNXQbL+d?=
 =?us-ascii?Q?h/G/gt8IP+uTtLqkRD+K0ao0YnwoxGdbCIpiZ4WzxIuTs2lZFboP0d07Zj7x?=
 =?us-ascii?Q?23TMpzVYCbjB1hp937jsVLdXNxs7h30P04aNWfD/lqgnQrwbOWznGna73ACp?=
 =?us-ascii?Q?HMOH6PuAf34jbMdVVK3RvHH7039qGc1xTDeSRDBUj1xOx1o4cfb06IWlHZg3?=
 =?us-ascii?Q?bKKm9TgGbi3Mr2b5QX0tJVdBasNUCWjhUS1LVKb47FlI/cXyjh76mzovXhmM?=
 =?us-ascii?Q?+eJmoy1lAbDEGIYWGqrUmbvzkt27VHrSvGQjKGYEsa453fEtAutYWmFcUauU?=
 =?us-ascii?Q?RjBPovMD55ePZgTuOuj73vh8GJ39JGJrc2ilUaxqvmueIKFfR3UimF/3yA+g?=
 =?us-ascii?Q?T4q6Hp7dxnGKlUxeZs2jgGrsENKTBCp+01uTG+/KNGE1y8gfRqy/yC1/IX3h?=
 =?us-ascii?Q?GJtFzQGZzH8Jcpa80loQ0k/djbF7Xkw6mV2ocRhRVsgYtVoAEt3M+naptLyq?=
 =?us-ascii?Q?VshN2BxEXhGJuLqlRa0gMu2EuIDD1u+dmXdVe5hePM/dlSjwyixbbJcersw1?=
 =?us-ascii?Q?AlIDk62lVaaPWWuVWnWtKfzNphHJ6X6ZTATJfhFsh2U+WJFbJEECyEoR8o/+?=
 =?us-ascii?Q?1TPnSdzLxGgUDHHEU3+rpzx/1VC7zMG+GPKzbPLL+wWG1U++CfzCarF5ssbG?=
 =?us-ascii?Q?/ddf34cixhU7iqDaF3mec/1y8/feLoKrvo/M5l8oLAxKWRbrKFcGFs17O65S?=
 =?us-ascii?Q?ws2imQazIVP+SqPvNjOPRBQe2soB6V4LOK1d+JZh5fpIqXonCIp65cTno6wD?=
 =?us-ascii?Q?Avt2P0Hrf6PiGTtls65o+a5SYr21oUsKE9juMbEe8Ypoi6tgzzohYgLd64RH?=
 =?us-ascii?Q?0/nnE609hWuTKL9OY+DX6CTRsXEgTtfoa0mXsPqVUXReOl+LZwj2ETVzjMR1?=
 =?us-ascii?Q?wnp+CQFkTVZqNidCGFjnzZxeZDiag+MlZ/JLjV57uQRewFbCn2yQToMiyHkL?=
 =?us-ascii?Q?NOVZrCvab+1eysKes3EZ3Nn/KtBlJ5+Pd8y3C2XSWYymOvNsYuHTnUYI0n3n?=
 =?us-ascii?Q?tCIQUS8P4fucRc/vIhloylRj/JvAfgJdcHN2W3CLKfzpec4HN0B5LAdN9tX4?=
 =?us-ascii?Q?Asya9VFZ+LAPL5QkgWnDqAZX5WpMiFwRdiXJFgvlqQ8qqLsAi/rQ5ubiEUKM?=
 =?us-ascii?Q?i4D/HOVS4sqTd7MJscam5qEu4SnrX1GU7maQYAcA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65eacdb-4809-4a37-0795-08dd081f4c80
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 22:21:07.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LFywxfqTsv7alYseIYz/EXaR7vhdT98Y3H+L8d9+o5hPiPCOQ/FVT1C/Zs6Wt0w0T8VkNU1+N8VO/Ez9DYUdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734

On Tue, Oct 22, 2024 at 02:34:28PM -0700, Zaid Alali wrote:
> Enable the driver to inject EINJv2 type errors. The component
> array values are parsed from user_input and expected to contain
> hex values for component id and syndrome separated by space,
> and multiple components are separated by new line as follows:
> 
> component_id1 component_syndrome1
> component_id2 component_syndrome2
>  :
> component_id(n) component_syndrome(n)
> 
> for example:
> 
> $comp_arr="0x1 0x2
> >0x1 0x4
> >0x2 0x4"
> $cd /sys/kernel/debug/apei/einj/
> $echo "$comp_arr" > einjv2_component_array
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 76 +++++++++++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index bd46a611eef7..bc833f42dfc7 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -87,6 +87,13 @@ enum {
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
> @@ -111,6 +118,7 @@ static char vendor_dev[64];
>  static struct debugfs_blob_wrapper einjv2_component_arr;
>  static u64 component_count;
>  static void *user_input;
> +static int nr_components;
>  static u32 available_error_type;
>  static u32 available_error_type_v2;
>  
> @@ -287,8 +295,18 @@ static void *einj_get_parameter_address(void)
>  
>  		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
>  		if (v5param) {
> +			int offset, len;
> +
>  			acpi5 = 1;
>  			check_vendor_extension(pa_v5, v5param);
> +			if (available_error_type & ACPI65_EINJV2_SUPP) {
> +				len = v5param->einjv2_struct.length;
> +				offset = offsetof(struct einjv2_extension_struct, component_arr);
> +				nr_components = (len - offset) / 32;
> +				acpi_os_unmap_iomem(v5param, sizeof(*v5param));
> +				v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param) + (
> +					(nr_components) * sizeof(struct syndrome_array)));

The way this line is broken up doesn't look quite right. That paren on
the top line should get pulled on to the next line and aligned with the
beginning of acpi_os_unmap_iomem. See below example.

Also, it's a little awkward here to map the v5param above just to unmap it
here in the case of EINJv2. Is there a reason it needs to be done like
this or can we do something like this instead?

		if (available_error_type & ACPI65_EINJV2_SUPP) {
			len = v5param->einjv2_struct.length;
			offset = offsetof(struct einjv2_extension_struct, component_arr);
			nr_components = (len - offset) / 32;
			v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param) +
				  ((nr_components) * sizeof(struct syndrome_array)));
		else {
			v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
		}

		if (v5param) {
			acpi5 = 1;
			check_vendor_extension(pa_v5, v5param);
			return v5param;
		}

> +			}
>  			return v5param;
>  		}
>  	}
> @@ -496,8 +514,49 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  			v5param->flags = flags;
>  			v5param->memory_address = param1;
>  			v5param->memory_address_range = param2;
> -			v5param->apicid = param3;
> -			v5param->pcie_sbdf = param4;
> +
> +			if (flags & SETWA_FLAGS_EINJV2) {

IMO, moving this chunk inside the conditional here to a helper function
would improve readability. As written, there are a couple too many
levels of indentation.

> +				int count = 0, bytes_read, pos = 0;
> +				unsigned int comp, synd;
> +				struct syndrome_array *component_arr;
> +
> +				if (component_count > nr_components)
> +					goto err_out;
> +
> +				v5param->einjv2_struct.component_arr_count = component_count;
> +				component_arr = v5param->einjv2_struct.component_arr;
> +
> +				while (sscanf(user_input+pos, "%x %x\n%n", &comp, &synd,

Arithmetic operators should have a single space on each side:
user_input + pos

> +							&bytes_read) == 2) {

Another alignment issue here. This would be nice to have aligned after
the sscanf paren. Like:
				while (sscanf(user_input+pos, "%x %x\n%n", &comp, &synd,
					      &bytes_read) == 2) {

Thanks,
John

> +					pos += bytes_read;
> +					if (count > component_count)
> +						goto err_out;
> +
> +					switch (type) {
> +					case EINJV2_PROCESSOR_ERROR:
> +						component_arr[count].comp_id.acpi_id = comp;
> +						component_arr[count].comp_synd.proc_synd = synd;
> +						break;
> +					case EINJV2_MEMORY_ERROR:
> +						component_arr[count].comp_id.device_id = comp;
> +						component_arr[count].comp_synd.mem_synd = synd;
> +						break;
> +					case EINJV2_PCIE_ERROR:
> +						component_arr[count].comp_id.pcie_sbdf = comp;
> +						component_arr[count].comp_synd.pcie_synd = synd;
> +						break;
> +					}
> +					count++;
> +				}
> +				if (count != component_count - 1)
> +					goto err_out;
> +
> +				/* clear buffer after user input for next injection */
> +				memset(user_input, 0, COMP_ARR_SIZE);
> +			} else {
> +				v5param->apicid = param3;
> +				v5param->pcie_sbdf = param4;
> +			}
>  		} else {
>  			switch (type) {
>  			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
> @@ -570,6 +629,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
>  
>  	return rc;
> +err_out:
> +	memset(user_input, 0, COMP_ARR_SIZE);
> +	return -EINVAL;
>  }
>  
>  /* Inject the specified hardware error */
> @@ -581,9 +643,14 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>  
>  	/* If user manually set "flags", make sure it is legal */
>  	if (flags && (flags &
> -		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
> +		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF|SETWA_FLAGS_EINJV2)))
>  		return -EINVAL;
>  
> +	/*check if type is a valid EINJv2 error type*/
> +	if (flags & SETWA_FLAGS_EINJV2) {
> +		if (!(type & available_error_type_v2))
> +			return -EINVAL;
> +	}
>  	/*
>  	 * We need extra sanity checks for memory errors.
>  	 * Other types leap directly to injection.
> @@ -913,7 +980,8 @@ static void __exit einj_remove(struct platform_device *pdev)
>  			sizeof(struct set_error_type_with_address) :
>  			sizeof(struct einj_parameter);
>  
> -		acpi_os_unmap_iomem(einj_param, size);
> +		acpi_os_unmap_iomem(einj_param,
> +				size + (nr_components * sizeof(struct syndrome_array)));
>  		if (vendor_errors.size)
>  			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
>  	}
> -- 
> 2.34.1
> 

