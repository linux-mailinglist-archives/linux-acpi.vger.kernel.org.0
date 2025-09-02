Return-Path: <linux-acpi+bounces-16299-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB0AB40DFE
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 21:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627C03A39F2
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 19:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAFA2E6127;
	Tue,  2 Sep 2025 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="c+bFtKTC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020090.outbound.protection.outlook.com [52.101.193.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4182261B75;
	Tue,  2 Sep 2025 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841997; cv=fail; b=nkwtKaiZVOk1+KxQ38GCXwnnbhV3fl5Vw7la85TgRrLUZCPyqZEnMZO5vqw0tJoH28nnHM/C2l/wCY/XxYY9USwkV5J1TSxPUFvmZHVHZQpQWMVSuVyU+OT6WxuZvneLl1Iw529gtRK0DCwr9bo0qSz0HAekUPc504CIlXoOKnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841997; c=relaxed/simple;
	bh=YNlUySKMEof21DUfMHGiomdA2s6NLvgPFG2w/w2hJCg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=TQaKxlBqdxaqQxvZmWUSyHloi2p8y4VFDQA7WTAbfdHBnGOou9k4yX1+NbDm98ImYVI4jemuRV7MKCL6sChQ2/tMAa9vI8RWe3ezpEuaK2RyqvJPzkAZVql8Zh1EBNW81TEHsjmUa6LeEgO1X7j3q86zA8LsqXkBCtFF3mBhaFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=c+bFtKTC; arc=fail smtp.client-ip=52.101.193.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/TRFxIQSXbdrXENFAuaIZ9dkz/PHYDRKsBj307raRRzO4jez91Hx7PgB1ZPbaDmmTHkfi0Z3x/DwSTZxqeU8UT2z7uU0BRnz2L7dhVi79kwQn1xdWBREurPgrkl6w8CYOmm63xkxnn6miywZvF7LBz8dYEChR5JNVcx3T0yqiJFWOuHD7NY8/PgD4g8PCvSdRQpjFj3hIRPxeaenYVzBbBvwpbVAgoPWtsspo2i/fpSqB8LVywGwT0w6kQgBiAowwTvvJGxxFEclTFAxHqVFKU0/sok+jhIEJ/MnXzHeHc1xAjR6WYEQMiEbxGKsXWLMTpEeR7uxX2uEh0ErU4v1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOsxfYa3Ml3Ngt5QujncTBk7bpNi6IOPOUNXoYgkg3I=;
 b=B8R8f+pS6n5/z1S9ZmAUScqqK57cs8go8B5W2RarNwwsDknl2F/3RX5Nu/XbDQgtULaXvOc4mKsuPMsqzfO3fiYpCop7Bk1G4P/uxrHthtZKhHnvTmF8JOwbOA1//UggzCg6hZJd57Xfi6n9KgiR37P87txEQj5cfrT4nNLBS39dvHuyeObQlc8ALcHNw+E5mfRqaYXll5/okOraGLP/lY5FBd4nE9/USB8j58Wa1LVNX9jXYyg3GFQnBZS+26Tu0W43EAvOO7H0bzgfua2qXFpHkyCIfFnQs9S/uANGxzCLFimQQr0bdQs/y+1/fzx5LPgTPvylv0ocpM/kmHlDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOsxfYa3Ml3Ngt5QujncTBk7bpNi6IOPOUNXoYgkg3I=;
 b=c+bFtKTC02NO1jH5EeBb1+QHqWljYvhWNwYcWSb6SZBT052hCF/nIJ4mxhN8vsGYq/ac+dH/VX0230G8hvyIi81SL933n40GIgXFLnfCbZ/UanYuCt2gwrYr2+mejJBOuDivVXnCQHQD/mD5ZhVYkfKAIGF4/Fj2E5pzDR0nCMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 BL3PR01MB6803.prod.exchangelabs.com (2603:10b6:208:33e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 19:39:50 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4%6]) with mapi id 15.20.9094.016; Tue, 2 Sep 2025
 19:39:50 +0000
Date: Tue, 2 Sep 2025 12:39:43 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org, 
    Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: Re: [PATCH v2] ACPI: AGDI: Add interrupt signaling mode support
In-Reply-To: <20250829101154.2377800-1-fj1078ii@aa.jp.fujitsu.com>
Message-ID: <f61868d2-3344-b6a9-d587-98cc654885f4@os.amperecomputing.com>
References: <20250829101154.2377800-1-fj1078ii@aa.jp.fujitsu.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CY8PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:930:4f::24) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|BL3PR01MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e89ba63-fc5c-4863-28c9-08ddea587b10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aER1rwlQpGKKgiDhFkZZ5G86yNEzHB32qXAi4/4f3rKbwqqb5jitcvX6B6ZM?=
 =?us-ascii?Q?KWyL/q9kQ+9jrZJh/g030puTjse5cJwMZ4yHh48LukBNCwkmwkkfxExsTjoe?=
 =?us-ascii?Q?UqN+I3VhYCBIvefylVrcp+bi3T1Q7dZQGYep4UOMoFaIOuQqvtyU8iq2KDlo?=
 =?us-ascii?Q?e5zHb5nAklLgEOhAB+x2Kq99DyOVZmCHXOFxBvAbcwnTRLjOmClHz5oN5K1V?=
 =?us-ascii?Q?VYRalhw2AWWt6ZYdUx9ZqRhZKkaSc4+GZNKjra8t/dcnYxXDlffkH+ZM9Qf+?=
 =?us-ascii?Q?VAjiwHALEseEAwMxYTW0JmH0+gP5aNdvx5/0o8HL1+7VQwzOS45WIe4PYQfu?=
 =?us-ascii?Q?lXFKMRwi7lRrUD2mv/xXBKNudMV8mHFcvHkkJM/IS2kPcS3x8wxMjb9Wvtw3?=
 =?us-ascii?Q?0Y2SoQ8t0fWd0lYCyHKOE0ZARjUf53vOU0hCnVNbVP25RCCQBghOyPF6Q/ol?=
 =?us-ascii?Q?fy/Rw6hufFiJ2v9FtcDhfOMUZASCTENnXR85SGKzD1qzIP4EDUrfUiB+25GL?=
 =?us-ascii?Q?mThKsCEj39+l/sUIipOfvrhFWIgwpTLTSTGfg3XOGvgC+h3/dNC9EXcPOEeo?=
 =?us-ascii?Q?ecIh5WElELLSmFPK9qloHLn6Sbp8HIcahY4oz84KEP8hA9bx7U8HEC3s16xa?=
 =?us-ascii?Q?d3iBoNL6T+iPvHg82OybEzdpu0tjXSzuC5IQJzBBS6Pm3U+hTUMy1Ul3R8f4?=
 =?us-ascii?Q?BGQJlZNUWIzGAE1p67o3UrCIiEUi7V8IWJ3kTBJsV51dAKQA0wb7ETUz6fFK?=
 =?us-ascii?Q?NIi2zklsLPLC/u5PJJJ/OqNHPW8Shmwq5KmqUKcSX1Kcg7FNze0pdqGoZNvH?=
 =?us-ascii?Q?AxA/bLw7GdudJNpD23EsVhjmebyyjqqfRpwIq9MXGC8WgHgJ9JkdJyswYujP?=
 =?us-ascii?Q?cDth0pM1DD73tRR1R/Obhge3t/MdzeREYg91T7+x3y3scXKCLSQmxrOivhLx?=
 =?us-ascii?Q?wNvc70UwTkvU1fnFMJOhI9SfLtb7ql+POPbhg5L8+Vc4vI3ndZa1XidMeBFw?=
 =?us-ascii?Q?nlfoIkyT3WWTBzmRTwkzXNwKp8xezRKGHpBMQgnsyIL7sHKVdNIfid8o17/n?=
 =?us-ascii?Q?dmX3w8PxOriEJ8GmAwTPXTlpqH7rkNYd2l5MC5YqfEbWs+yjXPRJUkJBANuF?=
 =?us-ascii?Q?Ygeix8y6ZWtH6n2RBZZF4gCxEaMW0ILX/+q2YYGKtJHcZP4JJROd28AS6LdB?=
 =?us-ascii?Q?IfBYDndw3llN3JhfYa0rpR98XIrUGuZelXyfqCZ9JKKBX0UcoqeotV2NeUTr?=
 =?us-ascii?Q?hLjnp6Zb9vHf8MJi6KuHRW85sGCJ2qhUPN880BmnOdkvsBRC/8bZiHFFCnuj?=
 =?us-ascii?Q?96WIHAmss+ZtBawFDU+QYdPcnrrE4UBzrYFLst+pyJsXR5wYYndNOWkBoAcV?=
 =?us-ascii?Q?WaNAai+XNxzM156t8jBHy9bjRgOqV73WvVED03Wuxhn8s7J5XBCdzWXVrM5Y?=
 =?us-ascii?Q?LWb66k+NDHq+DiwV6hZql6KUmVHGwuRNq9tjqT6jIIUAu1zWTyS70Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kCtoqOuBQdn9ktMS/PH6HgVtCIevuA8RcDYnrFHcXaWjQ9y6T5OiQ1vN6Ya/?=
 =?us-ascii?Q?aN+Qrwoo1tMut+6BA2F8k2XioiSrvWknoOOTj0fG+PaXVto5O0IR+S7CYPiq?=
 =?us-ascii?Q?DsrJ7w0hBFGlenRQIm8aLZPNYdwcmu8nupu9zCkfOJfeWHCcJfAW8rna6Vla?=
 =?us-ascii?Q?YCOFwev9AEfwLRd3ahlTAP2J3sQ9E2bCqOd5tJXu6WjhjC64t9sfoDHDxafJ?=
 =?us-ascii?Q?1EeCFbmLPbfL5z8oKcfOnNRzt0Ob0Kadef4OLae9wGEbxOJlEKyeQ9p/qggq?=
 =?us-ascii?Q?CoVnrnLcRW/yLmK2F4HL9WUbjTgD0MwgTtlzlHKVMiHqOELN7q99sz6xUHLq?=
 =?us-ascii?Q?w6Qo3qYrDR0Pubt2PH/t2r6cvDwLuM+WL0/jKWHNgL371DKkEA2OStrsESGl?=
 =?us-ascii?Q?NToi0rcU0PMHDWnUZErghwroQu2MMuwV75sDWIo+FFltyIaAd7guHhUtdHGh?=
 =?us-ascii?Q?/3JtVFpu7RZfoSxSEYtB1GvbIy+UFcYoyYWHL62XdTLyWCbY/2v92GaO6Jiq?=
 =?us-ascii?Q?SrGwK+NQqlDHuqgWza1o4muOBjhxsVXzS+Uz9fAV3uYEVEUteMU5l+CgiPv+?=
 =?us-ascii?Q?X3I/Nu+FRPMf+I/VFpjFd54QrpXi5x0nBMOHIGIifUd2YuOjjUZZkXTjfpW/?=
 =?us-ascii?Q?FkEUEY/SjDDO0rwALiTT4hrLrhCyKemnrDch0VqAV1e94qQX8a60eEiSDdSZ?=
 =?us-ascii?Q?ODs0Ks67kOtBby/njtU8LhgzxEOzpZfAj54nYUOScfE8tfy3u+SnZQTb40og?=
 =?us-ascii?Q?TPIwXrYCXj7DJzTfMCufAS1hUYylb77O7u6oyFkbJHqswnpvsvUDn8ZCiYr+?=
 =?us-ascii?Q?ZT9Sd82CnjRe0qfFKZ3MMEvskTPW/qxkZJclENjxXlzWY7gHk1hJ4RPykM2c?=
 =?us-ascii?Q?EqrhgZOZOEql16aUb2J8vFinga8IQc1/UmBtj5RgAqX5TGaHTkd3vljCpQad?=
 =?us-ascii?Q?KDhRy6fqAFa7Llch8vEpFUa2feZkv0UyASFg36PukMVRJmt2cF7E8Wap83+S?=
 =?us-ascii?Q?z5E5LYuKcarcy2Abp76wb7BlmTJ91slw8n/Mubn1G5coA5XC2ngn+tYWtnIq?=
 =?us-ascii?Q?b5/1G8v+6FvJqSwihqjC14GY78D6e3Lz1/XGKobklNAAppZYxZbHwc30c+Hk?=
 =?us-ascii?Q?o0cmy5w5tjEJ7QgChOCx2gLDsV6tFC8JBNwfIQdp+Houi1jv6k4K0ReoVPS9?=
 =?us-ascii?Q?T4anbtbvZjDOCL0PjKBIdDcqHoZDsoajHgJQ1ysfL+Mpbe+OVsFe9olPUUGZ?=
 =?us-ascii?Q?mYDaDbWZu0bDj9ntqObLzlMKE6wjOUGFT8/uiRyIWt7sqFbE0Qa2BoL1Qrja?=
 =?us-ascii?Q?LpuhGI/ua032XC0pUFOwhXIGWB3Guhv14IXo8QWWE68ud/sGKs4c4blsqkkf?=
 =?us-ascii?Q?gycnWMFzga99nXKuC21anCE+1uG04BiOeNLRhyPn2xiupH3HtAXc/l499kvs?=
 =?us-ascii?Q?DJvssF9X+vD/eLgf55+5l9M0GGxQ49Ne3j9pgvrsKEEDRWwCL5vbNnx5Vyrf?=
 =?us-ascii?Q?dYcot1Y05FbK9zUxN2+zVfR0zR340NkVLBOZ4nBqx/d7eSnV4nSK4DNIYdDY?=
 =?us-ascii?Q?dBZuQfxclOunubXy1EsH3dccJpLZ4q3sRRW/8MjVqCdoCF9c84GshGuXt5d0?=
 =?us-ascii?Q?e/XzWWovA1MCrS4r3UWUQ9g=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e89ba63-fc5c-4863-28c9-08ddea587b10
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 19:39:50.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M201TDMwARiy3+mLM1Nuco0I/P5Skf/CwUJNAtAhkk2At+HW0rhFe93mGTgOusUKKzggkIt+plx8Mkn1IUcv6BrdSwfTCepZLbwpvkTXCMQG9wSMHof0Cikw8LZJ9kVZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6803


Hi Kazuhiro,

I have a couple of minor comments below

On Fri, 29 Aug 2025, Kazuhiro Abe wrote:
> AGDI has two types of signaling modes: SDEI and interrupt.
> Currently, the AGDI driver only supports SDEI.
> Therefore, add support for interrupt singaling mode
> The interrupt vector is retrieved from the AGDI table, and call panic
> function when an interrupt occurs.
>
> ---
> I keep normal IRQ code when NMI cannot be used.
> If there is any concern, please let me know.
>
> v1->v2
> - Remove acpica update since there is no need to update define value
>   for this patch.
>
> Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> ---
> drivers/acpi/arm64/agdi.c | 98 ++++++++++++++++++++++++++++++++++++---
> 1 file changed, 91 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> index e0df3daa4abf..e887aab6b448 100644
> --- a/drivers/acpi/arm64/agdi.c
> +++ b/drivers/acpi/arm64/agdi.c

...

> static int agdi_probe(struct platform_device *pdev)
> {
> 	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
> @@ -55,12 +108,17 @@ static int agdi_probe(struct platform_device *pdev)
> 	if (!adata)
> 		return -EINVAL;
>
> -	return agdi_sdei_probe(pdev, adata);
> +	if (adata->flags & ACPI_AGDI_SIGNALING_MODE)
> +		agdi_interrupt_probe(pdev, adata);
> +	else
> +		agdi_sdei_probe(pdev, adata);
> +
> +	return 0;

Is there a reason why you always return zero instead of a possible
error code from either of the probe functions?

> }
>

...

> +static void agdi_remove(struct platform_device *pdev)
> +{
> +	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
> +
> +	if (adata->flags & ACPI_AGDI_SIGNALING_MODE) {
> +		agdi_interrupt_remove(pdev, adata);
> +	} else {
> +		agdi_sdei_remove(pdev, adata);
> +	}

You don't need curly braces in this if/else block.

Cheers, Ilkka

