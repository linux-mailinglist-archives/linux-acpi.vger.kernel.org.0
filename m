Return-Path: <linux-acpi+bounces-16506-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD19B4993E
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 21:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC28340F3A
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 19:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E83D223DF1;
	Mon,  8 Sep 2025 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="EBX2tSaY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2091.outbound.protection.outlook.com [40.107.102.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99D1E8324;
	Mon,  8 Sep 2025 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358149; cv=fail; b=CNCixOA9cmDI2ctPc8i1dPTXXH0+kH3vHktV8RkzEtavIZ45G356U3mtsaSOGmprSULCKRlA7lMBxD6nHbtKudrPCEAC/p9LcJy6nFxwdBuO/KJ/Yk9VlezhPuFugeUj6XzGLolu8cmC3SbPgwh40XQjNIo5KnOe6frKWBpFmJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358149; c=relaxed/simple;
	bh=il3yRWaaMLkma096ybQ+IdhQDv9SSoQkzI+5zGXN2QM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=sCkdOOXvmojLfKpszSEygW5Zj1FYCJLDVN0Sp+JRTh2kp6m4T3GUvQlDdEO2wbbI2A1d+SMmopCdRYOtpEEReYV4vspSErWP4zimC1Fnw7aYWqq1rSdn8OM9NT1kq5UBMxWomIVbBn1tWPiOP+PSo5uHDnj6hm6tDAvCS3jJJOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=EBX2tSaY; arc=fail smtp.client-ip=40.107.102.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4/ofjrTz5oMlkHwbL324p7F63iWI6yYaRZZyQYye6PpUbkVqoakcPsxpBTeSI4PRGxh94fROqLUspwyGha5CLuum2r07NXl3NJAb9vFgYgX31/lgBPGf1VKZkn8vU3h1E8wdjaF/EC3ncSd2fjdQycU2l9J7R8IhPzu4MlOKFr45ClzxnJ1c6JtFG6r1sX1lhvcspUWHkkeAS/4r4B5P4xIpC6YGX3lRDU9KixHzHhXs7oN0aozuvZUvcnM3NeCnioaTMTQDdJ7fOXjtpoDYDPIfr7/oQV6VpvUObiY45OprUt4Ceas7VePbW1wgL4W+JOlbcAZSuI1BDVhSxUiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga45bVBwLtNGnKnrfOPHz6QXHzqzDQzZ44jW8CUPPHA=;
 b=fxxi1JvBv2VKlbF5ETgtUe4su4Zgj+pj9wFl3hMu9rMVuBZGscIPimx7jXUULVRJsteI6w2nEBtzedylJFhoMMi35nPUUZ+QpgRn6eQ9mrLvvEIz5eRcK/A6zuwDCZcKBimDiLIn1rWvavLTFYZ/QbaR2dsvJ07x2N5Ss1ncpcZVHwcJp5olQMFLw+/Adr64HVdmKsoP7/WU7KqUkNaU+F+b6sRx60f4GLrOFw+IW/R694VOGrdX/Gr+g07w7rNA0QjrTfhGM3sfQvZXitpFiBl9z34n5d3crB8Z4BKrPMbQvs/qyVFx7CgBjUXx8/vpQrE3ikCNK73r4oWUdYg7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga45bVBwLtNGnKnrfOPHz6QXHzqzDQzZ44jW8CUPPHA=;
 b=EBX2tSaYTUBWR4TkEnqKHQcG7Jn85/jDwQpRx5jYq1IO1fDBcISFT0aocYW7ylL1hJ9/BuvWgQytOldkTdsEdvwd7+0jFnZhrliEXqLDRQY5gvN7AKzzIkkcAhsLVWyN5B1uVuXIh5xZanMYdP+yUAwDBCXkI0/lKyfV8bwREo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6231.prod.exchangelabs.com (2603:10b6:510:d::11) by
 DS2PR01MB9207.prod.exchangelabs.com (2603:10b6:8:27c::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.33; Mon, 8 Sep 2025 19:02:22 +0000
Received: from PH0PR01MB6231.prod.exchangelabs.com
 ([fe80::4a0b:cded:6fc6:1e9f]) by PH0PR01MB6231.prod.exchangelabs.com
 ([fe80::4a0b:cded:6fc6:1e9f%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 19:02:19 +0000
Date: Mon, 8 Sep 2025 12:02:14 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org, 
    Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: Re: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
In-Reply-To: <20250905042751.945616-1-fj1078ii@aa.jp.fujitsu.com>
Message-ID: <bd45c06a-77cc-2ab3-122e-41dee1aee0ac@os.amperecomputing.com>
References: <20250905042751.945616-1-fj1078ii@aa.jp.fujitsu.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0243.namprd04.prod.outlook.com
 (2603:10b6:303:88::8) To PH0PR01MB6231.prod.exchangelabs.com
 (2603:10b6:510:d::11)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6231:EE_|DS2PR01MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0a8c2b-e457-498f-21a0-08ddef0a3c26
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vOViIqNuvwtW2XXSjUSQoN7SRmspT3H1KKLtKVQfo8s1T6FxLEE6M5nUIE/M?=
 =?us-ascii?Q?IddbuNV0v3X10EKUK4QiahcEfc7+poDZvAg2HsSsiXh6W8PDZ9c0Uz75XIMy?=
 =?us-ascii?Q?CzrOuj2f7gjJrPWMTaj/xfg5ZWfmsZUIsz3vfi+qEBdMlpiiJO0+vCxKoScJ?=
 =?us-ascii?Q?KrVTdDsfMrlRb1Gh2UA0v4TKp66LhS4zJR0iv42CkLcQezD6ZlYNYWqPWO1Q?=
 =?us-ascii?Q?+ufXdLLQG9+zdaQB/Th0QUhIdBwPARKgFbVC3H+G91MsBYcHATia4VnNIbXM?=
 =?us-ascii?Q?xJ/0f9zWUvoceJoVXV5aXxPvdAMDNyJsgy6bbc4IYaZVV5V7s/zNAaRs35gu?=
 =?us-ascii?Q?+xgFqDzQDwCF3dbhsu4oi0mCV7VHwgSSAatBZLIpuLn/j3oCtH48bpyD8iE6?=
 =?us-ascii?Q?8smqMtROLi7JhJ7yoWkYeUXY3B3oI2KiwYA1393djspt7yfYBEDoi3t0qfuk?=
 =?us-ascii?Q?Un5RtSu6bnhPnNpfHXb8gNui4e7jtfgFA9jb2xxmrpTHtvEjBdOze6Pq1Dit?=
 =?us-ascii?Q?guJS9pYhQ05b5Lzn6hkdlKCxuU40EfpfPk0PwO8+pcELwjK2aixxxn1FSxq3?=
 =?us-ascii?Q?CPJtXvKaW88NI3XuK78HlEGuvh/E0CqUgsZLz/4HeHU1GYyUUHOgjNa+wOUU?=
 =?us-ascii?Q?EVGsi/4C9Y9sV9FBgQsTqVEru9wTx7ysU5KBfmPz8VWRhhzUdZdNSy/HJvCs?=
 =?us-ascii?Q?JU/YpZatdP71YIUKM8bRCIhuSvgkBUG/oPP4lRRN3Hw0gLrggFw8xRwIVFOx?=
 =?us-ascii?Q?qrk0W8w9+GWjs6aSctjsGuRQpwbIV6BOKYORLVdg4yeTu1lEHVTwOQ/+cx7F?=
 =?us-ascii?Q?1y5iqP93hDtDT+n6nc2zNdSvpnQzo7dNSLirtstDTLrhhTtAzBr/4CkgOfm6?=
 =?us-ascii?Q?dBJMa77gbClT0JZ9BbbeXuFpA9LoDE4lg4iohbnqH4HW3M+a/Uas8S5wemLo?=
 =?us-ascii?Q?mTVFczfAY6J4MiiIsKRW1aCN8y9W3anjSba5gOcqOrUKOVTeEcdRkeU0bTsq?=
 =?us-ascii?Q?ZTIre3jXU8siGNSRFEcVu7D5QxXFGl8oL6jOjsdipk0A/mmrJqdXBVaqefHw?=
 =?us-ascii?Q?jE0tZ742oZYzTlSg7af801Yqn2RkH8h1fLf7haHUcgl5QsG/lNMJdc73bkLi?=
 =?us-ascii?Q?kF8gM3XtP6BVDtn6YXOuFIyYfCxHmwV6GRhw9LneWe2VTV3Hf0xwmbwMMV1N?=
 =?us-ascii?Q?LwfDzf3V+DXgh7uPYE6zNSldYED8BAFZfw4O3UQcqUgFADubnqdevcFFMzPA?=
 =?us-ascii?Q?E/ZS8c+O4ow3Z45AgnFE4CMNE5e8404CVVve5gj2jWQ5TGd6B93NLgppiMxp?=
 =?us-ascii?Q?nv5JLLgqQqSR1aHyBD5+aw25866hQCrudKc62l+JspZy+9lTL4hzEcn1EeH3?=
 =?us-ascii?Q?JIPGx8eZGFaHgfT8onASnPnlkLpItsqldUYrIwHiz9hnsirh+Cdh+LKEoQ/F?=
 =?us-ascii?Q?UkSJL0DzyB2B1TpVr6SzlyOq1uhyPEFFE+YKDTXnme+w7PCTzpTmRT/VfnBn?=
 =?us-ascii?Q?yaqPZHJRaD298eQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6231.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dfWT4KFUFQnefXeQ0BULODacQdxlzAJDCRHyjPJ1WMirh0SXDovTs9FqyXtW?=
 =?us-ascii?Q?Ex4anW+/a4b79UIZtFwK/Bjh6dpb/foy13WheOZWhrL1j/NdpdlN+LCuiIi2?=
 =?us-ascii?Q?rbijNWRLxbgOHSDYMgxd1a/vJLVcFSgDz5JDBBQBmWYxMzPnmibK4/SaokOv?=
 =?us-ascii?Q?GY04T5DH+mrBgRRWCH147xnzl1/RuKPY1dHqIo8SPpgWDnT42CTPHqEIHNZk?=
 =?us-ascii?Q?UAAkgNRbCDZnIOiGD0cZ0WlX6wasTe8t2Oe4ICXbi4ANDH1JhBUJOfBEMlwf?=
 =?us-ascii?Q?O1jPzOBTL53/Gob7WiN0FtsTWiMrAjYpngdkURC8IZDOwSV5PYb6g4xBcy7Q?=
 =?us-ascii?Q?6uBK0GMFvrSxWsE8n4nFzr032Sb3+bOBACNN9rxZHi3uf0rlN2AhDMYmPcwi?=
 =?us-ascii?Q?oZITfVSoJlJQjoVAfrD+Eo6HXOJoHiKSIDmDrvXe/cr9LWYcPORYM1ho8ciz?=
 =?us-ascii?Q?PFeK4S7UBaHaK1mWl+0g0HQJkv36XXosSDmqWH86/B8OSBa+r2PVrJbTLybO?=
 =?us-ascii?Q?6aVzsr0x9MHAHyg7k78jk8MZYY2eTiUKzvAGND0t2bVcRa5nZGR2qWXC3HXB?=
 =?us-ascii?Q?VyFcixJ3QXMO6IY/zstpPNRVWJTWYAGBQHdcErrIZM36eYCnr6JS8yVRoZ1G?=
 =?us-ascii?Q?aOsb3SlY4KM6wHs0aaTxaWmF2hKKZ6zR7/gkyFsVGtpV/bJ9r407Obfj+vkq?=
 =?us-ascii?Q?LbI8sQhuZIQThZCXTKp6XCNNr1072Oo4R0ebjQAMmzuxAHASeBW3EqzGL/du?=
 =?us-ascii?Q?xjoi9eLHoKP9bjU1bAJhf4Xxsl0yCXSrbROW/bkZEI4ooxex/YcXb/Yhf4H9?=
 =?us-ascii?Q?0C/Dqc1NeFNCxZXe7+l9AH2GSuD50OU1rziB8YUWmJ9fqpNbOJ0DVxXp42ah?=
 =?us-ascii?Q?QoKdcr9NkAbkuh+x8G6H+bLzCl93v5QZGLaAwxcP6NmzxDbuYe8jFgstqdsU?=
 =?us-ascii?Q?QyWckh3r42g9eBdACEYzzVRMnjkaISBD574ByzhHklA6eQCX4hm1bQPMoS89?=
 =?us-ascii?Q?ee9tUTQK28fk6U387wPvxJ6483yQc+I3+EB5I+QG/XbXzsSDQelhFPIUk/aW?=
 =?us-ascii?Q?/Ce+4W5tSQwf2zbQRHN1cX79KEvozP7KbTaRdZqcwu+Q1cG68+5+x9MycxiF?=
 =?us-ascii?Q?EjXSQ1gytfgBatlsZeeuaQzCU5OrHOsUnGosa8SVAtLaNAYWyDV4g4FwGrWr?=
 =?us-ascii?Q?GcPu86E1MkYhEg3sXErSdxlKsza209jWwwEwxcyQgdHA38/pJVcdxTAn2nIo?=
 =?us-ascii?Q?W7J8qZEcBFFczmkPEJPn5yUm8VkpkVRJL6C3ftMyqjd5eF0XHK20QCWlQ0xm?=
 =?us-ascii?Q?HmqV/NUreCyKUDyMaGyeeTZorcVZ3t1ELUM9+GFvJHW08jzjqtZ3MKOD7nTW?=
 =?us-ascii?Q?YVBoZET/ziiod4WIfEVZKHm0QWSI9VXi6jlGdokxdfRP8qly5qmwMgyZsgSW?=
 =?us-ascii?Q?8xiegzu9Ac3SE1k6wYqwxCszPvW4BCHWfvXsDDxjA8qJ/RAAKJ2kFkVFWr7V?=
 =?us-ascii?Q?TkFkf7xnKYQ7marFdTpuBkAydrHrz2TLhiBf0g4055iZT+dQFEcpU13mu+QW?=
 =?us-ascii?Q?Oza0qT2q//TgHeNNcXTO+ZfoE/FuhHFEkZQx7z5W+r8Kcw632fa7x7kIBMxm?=
 =?us-ascii?Q?rwSe356vFOCsxbbZLd+tUiA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0a8c2b-e457-498f-21a0-08ddef0a3c26
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6231.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 19:02:19.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYMgZxD5DnYV79WPkfj7/RpVfzpUT0It6MLBw8gJpMxVlJtP2S/PnhOYhh+OQf/DtQsq677RtlZOH9NG3Ej23dWX87qPy2w7oZtCmD/zZzIlO4Sh/OGpSB1gScYOIb0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9207


Hi Kazuhiro,

On Fri, 5 Sep 2025, Kazuhiro Abe wrote:
> AGDI has two types of signaling modes: SDEI and interrupt.
> Currently, the AGDI driver only supports SDEI.
> Therefore, add support for interrupt signaling mode
> The interrupt vector is retrieved from the AGDI table, and call panic
> function when an interrupt occurs.
>
> Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>


Looks good to me.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>


Hanjun & Sudeep, what's your thought on enabling the use of regular
interrupts here? I do agree the spec talks about non-maskable ones and
to my understanding that's what the idea was indeed.

Cheers, Ilkka


> ---
> I keep normal IRQ code when NMI cannot be used.
> If there is any concern, please let me know.
>
> v2->v3
> - Fix bug in the return value of agdi_probe function.
> - Remove unnecessary curly braces in the agdi_remove function.
>
> v2: https://lore.kernel.org/all/20250829101154.2377800-1-fj1078ii@aa.jp.fujitsu.com/
> v1->v2
> - Remove acpica update since there is no need to update define value
>   for this patch.
> ---
> drivers/acpi/arm64/agdi.c | 95 ++++++++++++++++++++++++++++++++++++---
> 1 file changed, 88 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> index e0df3daa4abf..2313a46f01cd 100644
> --- a/drivers/acpi/arm64/agdi.c
> +++ b/drivers/acpi/arm64/agdi.c
> @@ -16,7 +16,11 @@
> #include "init.h"
>
> struct agdi_data {
> +	unsigned char flags;
> 	int sdei_event;
> +	unsigned int gsiv;
> +	bool use_nmi;
> +	int irq;
> };
>
> static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs, void *arg)
> @@ -48,6 +52,55 @@ static int agdi_sdei_probe(struct platform_device *pdev,
> 	return 0;
> }
>
> +static irqreturn_t agdi_interrupt_handler_nmi(int irq, void *dev_id)
> +{
> +	nmi_panic(NULL, "Arm Generic Diagnostic Dump and Reset NMI Interrupt event issued\n");
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t agdi_interrupt_handler_irq(int irq, void *dev_id)
> +{
> +	panic("Arm Generic Diagnostic Dump and Reset Interrupt event issued\n");
> +	return IRQ_HANDLED;
> +}
> +
> +static int agdi_interrupt_probe(struct platform_device *pdev,
> +				struct agdi_data *adata)
> +{
> +	unsigned long irq_flags;
> +	int ret;
> +	int irq;
> +
> +	irq = acpi_register_gsi(NULL, adata->gsiv, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_HIGH);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "cannot register GSI#%d (%d)\n", adata->gsiv, irq);
> +		return irq;
> +	}
> +
> +	irq_flags = IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_AUTOEN |
> +		    IRQF_NO_THREAD;
> +	/* try NMI first */
> +	ret = request_nmi(irq, &agdi_interrupt_handler_nmi, irq_flags,
> +			  "agdi_interrupt_nmi", NULL);
> +	if (ret) {
> +		ret = request_irq(irq, &agdi_interrupt_handler_irq,
> +				  irq_flags, "agdi_interrupt_irq", NULL);
> +		if (ret) {
> +			dev_err(&pdev->dev, "cannot register IRQ %d\n", ret);
> +			acpi_unregister_gsi(adata->gsiv);
> +			return ret;
> +		}
> +		enable_irq(irq);
> +		adata->irq = irq;
> +	} else {
> +		enable_nmi(irq);
> +		adata->irq = irq;
> +		adata->use_nmi = true;
> +	}
> +
> +	return 0;
> +}
> +
> static int agdi_probe(struct platform_device *pdev)
> {
> 	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
> @@ -55,12 +108,15 @@ static int agdi_probe(struct platform_device *pdev)
> 	if (!adata)
> 		return -EINVAL;
>
> -	return agdi_sdei_probe(pdev, adata);
> +	if (adata->flags & ACPI_AGDI_SIGNALING_MODE)
> +		return agdi_interrupt_probe(pdev, adata);
> +	else
> +		return agdi_sdei_probe(pdev, adata);
> }
>
> -static void agdi_remove(struct platform_device *pdev)
> +static void agdi_sdei_remove(struct platform_device *pdev,
> +			     struct agdi_data *adata)
> {
> -	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
> 	int err, i;
>
> 	err = sdei_event_disable(adata->sdei_event);
> @@ -83,6 +139,29 @@ static void agdi_remove(struct platform_device *pdev)
> 			adata->sdei_event, ERR_PTR(err));
> }
>
> +static void agdi_interrupt_remove(struct platform_device *pdev,
> +				  struct agdi_data *adata)
> +{
> +	if (adata->irq != -1) {
> +		if (adata->use_nmi)
> +			free_nmi(adata->irq, NULL);
> +		else
> +			free_irq(adata->irq, NULL);
> +
> +		acpi_unregister_gsi(adata->gsiv);
> +	}
> +}
> +
> +static void agdi_remove(struct platform_device *pdev)
> +{
> +	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
> +
> +	if (adata->flags & ACPI_AGDI_SIGNALING_MODE)
> +		agdi_interrupt_remove(pdev, adata);
> +	else
> +		agdi_sdei_remove(pdev, adata);
> +}
> +
> static struct platform_driver agdi_driver = {
> 	.driver = {
> 		.name = "agdi",
> @@ -94,7 +173,7 @@ static struct platform_driver agdi_driver = {
> void __init acpi_agdi_init(void)
> {
> 	struct acpi_table_agdi *agdi_table;
> -	struct agdi_data pdata;
> +	struct agdi_data pdata = {0};
> 	struct platform_device *pdev;
> 	acpi_status status;
>
> @@ -104,11 +183,13 @@ void __init acpi_agdi_init(void)
> 		return;
>
> 	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
> -		pr_warn("Interrupt signaling is not supported");
> -		goto err_put_table;
> +		pdata.gsiv = agdi_table->gsiv;
> +	} else {
> +		pdata.sdei_event = agdi_table->sdei_event;
> 	}
>
> -	pdata.sdei_event = agdi_table->sdei_event;
> +	pdata.irq = -1;
> +	pdata.flags = agdi_table->flags;
>
> 	pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, sizeof(pdata));
> 	if (IS_ERR(pdev))
> -- 
> 2.43.0
>
>

