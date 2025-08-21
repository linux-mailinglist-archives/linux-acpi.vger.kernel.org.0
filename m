Return-Path: <linux-acpi+bounces-15878-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F4B2EC65
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 05:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0931CC4AC1
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 03:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9601A2E1C7C;
	Thu, 21 Aug 2025 03:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VooRY4fq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2133.outbound.protection.outlook.com [40.107.93.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85822E091C;
	Thu, 21 Aug 2025 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748287; cv=fail; b=pk+XvoHb6FtVXUxjqqA4G1IJahtsUI/yDC4L+V8UqIjfLuQSVuHr8ZcGS6WkuwozCWEAmsAGBy88gms0KPb/Az+MDIi6NFvt4KZYHy+N12kYw9eddMBQCw+1XGQ3pUE+9zSOdFjAE9wNgVuipag++fyNfapIT2+vfh8HMrnzvrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748287; c=relaxed/simple;
	bh=7HU7lVXomKnwYJGhYrzfHNswjCPrrl+VbMCQXHuyYSk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=mLoMnvuIPpcP8N7Y+blu24EObESbP9yZYzu0DE2uXdcPlwSDZvvvGY+nr0LUpWe6qATEZKXdsWY5zKbOIjzSj09gOF3zA7GpXnfNtrb/sDzpydpZT6XCiExTzP1A7CK7dLDks4iFtTo/Lxg1BC4wZHkdKK6agfuLmYLl+zKbBhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VooRY4fq; arc=fail smtp.client-ip=40.107.93.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFFUy6oV1w5CGBi267GVJkChvZK4zNZcpVp8eiz/MwTVjuumXF0QrZo4+/uJD73Gg0t3Q7LwrKdvrHDX1U64Nj1GLh5I7/Rn+GQ3AvwAWJzBJUdJ0e1E6zZVYryDgLJNDGo4foVzBEONCzwn3QortMoOxfzHwt/i9pKJ8RYc/HoS4ActNpDfOYPv8dlIKQjM+QauFEmya+iB6fwY4NhUWgxkT6MdugZMWSmfJg/CZd36CC+aZr/cs9ZJDfNI6AWA4lzK6G8gvjCz/u340t1iaLTnRp6OUUFLZ2u8wjitYhzdRdh3sulQA7k6nQqR4sRkWP5/FByoyRtiSas3eG8liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQeRNUwsTzSYgCXoFkVy9afiZXbW9eSb3Xz5g5K0FZQ=;
 b=QE0PlXRF9I2KnwSnWf7pVVbq02K2z7ZTs/+Z6elxzW+Kgq43+l4ei2+OfFo6btEYyLKcHYnUTqgJZXTbU55TKnPI1JDHuGTGnRBHBX0WwrCnpiTi+iBuQRKmnOl42stsnIKHcclxYHWfK2ktpnLDOaFKiNroEe+J1Ih1XldoBnGqUirE28gUoPgd221NyZ2hDMsF+Jd7ayXSM2U4FjRG0WlzVfviGC8ALFLVKZjjOYVMXncOhHZpYAvCLQe41eLaebqx0R/9GZNGs1eM+O0iHbfj6PmuiBEgxISux/YL8KfQUla0aXTlyXts+xwPS5+bNy0oWzxNnQbVQilGJEgr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQeRNUwsTzSYgCXoFkVy9afiZXbW9eSb3Xz5g5K0FZQ=;
 b=VooRY4fq+q1AABHwzhtDLBsueMiYJ9+RzUvXL1cNdfOCiZPKDMdYDDI/JgKNj8CkzeGQjw3xPzLGRLcJr7DUE6wcEma29EEyEqZDS6f9dmOfHtTpKe4Yrfnwac6UMj4Hak3DmExIVjjRWcPlDmM3+NmbVKlpWs4XisBC4C+SmdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CH7PR01MB9026.prod.exchangelabs.com (2603:10b6:610:24b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 03:51:21 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%6]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 03:51:21 +0000
Date: Wed, 20 Aug 2025 20:51:18 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: AGDI: Add interrupt signaling mode support
In-Reply-To: <20250818065437.85905-1-fj1078ii@aa.jp.fujitsu.com>
Message-ID: <a6d5d830-b1f2-c14b-7753-82f35baec8b4@os.amperecomputing.com>
References: <20250818065437.85905-1-fj1078ii@aa.jp.fujitsu.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:303:b5::27) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CH7PR01MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 2183fc2e-551b-4192-6dfe-08dde065fd8c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YKOZDqNEADhWk8WX6LRaa1gQ6/E3pyuXWu+tDW0uVEa3yblC8M5olwvy+wgx?=
 =?us-ascii?Q?8GTvbH5wUAiXwnbR98NDMv+Dbrgt4M6xnTNhBE10Spbgw8FTbTCF0WwESkfE?=
 =?us-ascii?Q?yZHmC/Ts4ucXP7VbRcMO8TqFy4znVuXH/ZOWHnplbaEfGfGLiooWIMbx9K/Y?=
 =?us-ascii?Q?zZn8VUcp7poRI2cNQG8fzw79c3tpRK2dYOmt/CO/EUG20naxS+ImCWT+Ru+7?=
 =?us-ascii?Q?9BmdULC7Mmb5vUCATLtMsgYCmijIsHw/kMX9CvMXurhqV1SBB1QyNsJQdyPd?=
 =?us-ascii?Q?WJKz29zX0Lk2ltuIjDyGZUWAbEEM+vXPM1pCT9hrGsAx5GGZEgEE8mAwfThK?=
 =?us-ascii?Q?mJYr4Ady0/14mVZeSanlpmytIp3rtUZdCfS3GW2qoZdpYKO2W3IeDDjxUMWs?=
 =?us-ascii?Q?TZUMBLHO11uENfZEEunH1j2ytEAvlI41ZbDlnXnUFKEyJGqId2T6y5a1ra4f?=
 =?us-ascii?Q?Cv86qr63gHScS1fEgm2TFYHJ2yJwy7CTpXlvYJtYIscH1TQ5VoXFWh49SPli?=
 =?us-ascii?Q?ye4xIPos5TDSbiT31ONm6XFc30GdqewhySMkYCww8fdL3EvSjuNDXWY7KsEu?=
 =?us-ascii?Q?OzURDwdFeIjvz4GVOBem4YDzuwKkuWu7nXEi3W/hp2J6MP25FEwOXUehwIW8?=
 =?us-ascii?Q?l3uETse0ivLGvD4Bet03TO3iO411T3IDS4hwgXm+BytFeiLD20Iu5POZF+Qk?=
 =?us-ascii?Q?IZE2173kQHB64JzISZHk6eszSZRi9eaiX3luabDBmPR031FBd3iILouSlAIo?=
 =?us-ascii?Q?EJHFDYJfDA7x+Lr5oJMbC7z1YDiFPEgxpe3qLg7qXj5X8PXeMb8RfkbLPc6K?=
 =?us-ascii?Q?vlE7H5r+wizBoPDW/52AYYtVTAFYvBvZJdBsEQCJ/l4t0coKwtihZztS7de7?=
 =?us-ascii?Q?amWbZbzJvtj8izb/kEerGC+wN7CR9rp5iZO+aeq8gxFoteGdFUMfOUDVWV5h?=
 =?us-ascii?Q?bNGRSNOzGJ3l+shEoV/tcPjKOJ8ECMxAunYFHs4TXhmbe9lDzUCjUyK/lRGH?=
 =?us-ascii?Q?Nu48nz+tk7Kcn5YjoWjfAjZZoSDsyxQ8aHyY1oUNTZvcXM39hR6En9vAjQv8?=
 =?us-ascii?Q?j3z61Y59Ql9KnV28w36m8Zr7TNtSV+dq1wdLjDgHdRjpaAebmZ3t0LyBCZoa?=
 =?us-ascii?Q?BJXoDX5dC38nmhXBxL65Xu5MMmNu0VVWPS8gvJwePQ36Jcc3m1QQUamwDbSB?=
 =?us-ascii?Q?te+wCM7KO0OIaUfU2qmRX8w2pNNrcYmjsbvgYaKxD6jXJmTD5vXKKSxMV7SO?=
 =?us-ascii?Q?23cfgqXW0nSiBl970IZqH6ZoGYX6P7pX+j8gRrSbv1F1f19aAlD9vjt7ZI0O?=
 =?us-ascii?Q?VUYdREdRMnTGfUQ3bdluRS6D2entaZAo0ki048icuCgo8PgaK++kJrpDMzQf?=
 =?us-ascii?Q?gC4o61usJvswxGOx06nh7/9214qQ4uOoYmAXogkEvraDfHpUoEYcygBsClrT?=
 =?us-ascii?Q?qQc8yhaPdlWqqbWJ3QP/2VaCZ2OJkrAAc1Lr5ve7bSILYmpwFUZcWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JK1UbsVVyLxaUCw+ATaKH1GUwR15JHTrHb8jwa6EMVR4s493g5EFBqbHiRja?=
 =?us-ascii?Q?6mC5NWqJ4DbOLtJNk9gS76FgoFycBY4X+N3+mwhknzhkZj2Vwphi9rXLh+zb?=
 =?us-ascii?Q?V1c91zwPbQsLfX8NVPY8YBdGeoZqNxFJf6lLnnVFXizQ+DLZl5uc692srAhu?=
 =?us-ascii?Q?qrgIgN+mm1LX9ACmi68CF6joRc8gD7UURDQdKcFa9XaDkQYyUBKn27M9mBl+?=
 =?us-ascii?Q?O9O/IZWh8oMnadFJSS6kMMAp9Rycqhx2m3YfiEWU/u0LQWQ6ti3JVLWAQR6X?=
 =?us-ascii?Q?1km0b5oCFKx6Z3oepKxv333udu0YM78v92puAvYXbCdctGPxw2IqymEewV5G?=
 =?us-ascii?Q?eLTiZAvVa5VpvydRxMCqhML21+9WGdXMIv++Pbr4fE2cVn1GUyF6kzLh1DBt?=
 =?us-ascii?Q?/aZRDGjNfQEg6aze/IKSka5qkdM9HOe29o+9XwzjClSN1Qv4EUKhRwJFfqyx?=
 =?us-ascii?Q?Lk/K9v/nEYF5wxpKgJoV5mFZQWNdeQrCEnLdgqV4SEQ09py3CVDHBrTiqu6L?=
 =?us-ascii?Q?/sYw5s5eEdnQz5zsjCX+/q/8KcnOvyVvM0ns1gW7J9Deb/TOk5fm+6kT4e1l?=
 =?us-ascii?Q?iwsYpHJF340yl6DS5K6dTpZ2XHEjWE5QhHllGL9nf4yiqXNhfhDTB7qN3Vjk?=
 =?us-ascii?Q?O1PhJtbc7gIh4wyu/3GQay/smtVz8+dP4szkRxYDsRqt7UFMKOiMs5QjsfH2?=
 =?us-ascii?Q?p8i571FMKA/6acWiVC7KV3gsHxlqY4g6CrLE/FKLFUxHJrLeu2lJ1Gimz+OH?=
 =?us-ascii?Q?RfAdcOzdek6WbEtZnDm9vG8QxTQ0PKzs2GLK13KIxhtonH1B7hpfTarFVpYG?=
 =?us-ascii?Q?Driskc+E/K3x+y+KjC0OhzDqingu0VhhzcKRLzkeNE2D5BRnMrJa16IpQrRx?=
 =?us-ascii?Q?X0ors+rTysK6pQQrYXFbfqLab5tWZkajKzXURh4ba43LSKJStY43oCVOkBEV?=
 =?us-ascii?Q?IZpMtYuLJQKY898Jn8GtR7GRHiQFdof5OCiQTx67RO0tSDOtjIVDiAWzNVA+?=
 =?us-ascii?Q?vqV6rx6EiMAwOm7Nc0+KKWrN0T9+2E5t/SIzRC3C0L0Id72PXYSbd1kmghEF?=
 =?us-ascii?Q?6S83YU20Ip59KaCsRXiZUoNW9RIgK/IC3r6y6lFYx8vrrhr3XpnApoh4ncmt?=
 =?us-ascii?Q?AZKw3euZklkdX+1hC8ECL41iZfmn6RPG8LIZGKfCD19CpShvmASqSs9QHNy2?=
 =?us-ascii?Q?H/GwuL7t11uLYR/XA+sFQHyEVcfhP6vol/JufUXf7Icy0llX15Gpv4f+qwjF?=
 =?us-ascii?Q?KYbtlMggX5j38Cy0nRMHrau+EUHgRW/Q6D2SOJjTKgrXaGyajZpROcsoS6Cb?=
 =?us-ascii?Q?VaeiHh/JRHzB0yxbCGmpFTJGLheAmFyOfkmECz/pj+rSvABDD/IX38FgpBaI?=
 =?us-ascii?Q?yGFRYZKxNml+rVZcfS5iDzLc/FH3iUm1N0bQYklbOOz73+Db/M8ZeURRnvqg?=
 =?us-ascii?Q?2xcuwdI89GJ/wmBrnn2toVMLRM0EyRuMG7zaANzJgIcipKPlaaIClWwQiGmT?=
 =?us-ascii?Q?Koh8g3OO0MNjOtUjdiwRbrzpoUuXRlV35AzbfAKM4sXjonbrtNLhNs1LlaA5?=
 =?us-ascii?Q?o7bCvC+sJ0RYfqea+9zlGcQebo9ZipUniJyX9waP7t2awsfWY8uI7LBobgnD?=
 =?us-ascii?Q?CplBatn0hovbLbtB8B8iozU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2183fc2e-551b-4192-6dfe-08dde065fd8c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 03:51:20.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjQ1b9/8Q9ZknnHCgNQLokw55b5fIHeWv8AMi8zL3lDfCTDdWaeV5n+byW1To800UNdqRjOk0wCoF50LCVDMHCf5FKXw1M1vGZVq0VwAi6TW0y7ODRbZP5PwDaGHGC9y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB9026


Hi Kazuhiro

On Mon, 18 Aug 2025, Kazuhiro Abe wrote:
> AGDI has two types of signaling modes: SDEI and interrupt.
> Currently, the AGDI driver only supports SDEI.
> Therefore, add support for interrupt singaling mode
> The interrupt vector is retrieved from the AGDI table, and call panic
> function when an interrupt occurs.
> SDEI & Interrupt mode is not supported.
>
> Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> ---
> drivers/acpi/arm64/agdi.c | 114 +++++++++++++++++++++++++++++++++++---
> include/acpi/actbl2.h     |   4 +-
> 2 files changed, 110 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> index e0df3daa4abf0..c514bb874c5d3 100644
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
> @@ -55,12 +108,20 @@ static int agdi_probe(struct platform_device *pdev)
> 	if (!adata)
> 		return -EINVAL;
>
> -	return agdi_sdei_probe(pdev, adata);
> +	switch (adata->flags & ACPI_AGDI_SIGNALING_MODE_MASK) {
> +	case ACPI_AGDI_SIGNALING_MODE_SDEI:
> +		return agdi_sdei_probe(pdev, adata);
> +
> +	case ACPI_AGDI_SIGNALING_MODE_INTERRUPT:
> +		return agdi_interrupt_probe(pdev, adata);
> +	}
> +
> +	return 0;
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
> @@ -83,6 +144,34 @@ static void agdi_remove(struct platform_device *pdev)
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
> +	switch (adata->flags & ACPI_AGDI_SIGNALING_MODE_MASK) {
> +	case ACPI_AGDI_SIGNALING_MODE_SDEI:
> +		agdi_sdei_remove(pdev, adata);
> +		break;
> +
> +	case ACPI_AGDI_SIGNALING_MODE_INTERRUPT:
> +		agdi_interrupt_remove(pdev, adata);
> +		break;
> +	}
> +}
> +
> static struct platform_driver agdi_driver = {
> 	.driver = {
> 		.name = "agdi",
> @@ -94,7 +183,7 @@ static struct platform_driver agdi_driver = {
> void __init acpi_agdi_init(void)
> {
> 	struct acpi_table_agdi *agdi_table;
> -	struct agdi_data pdata;
> +	struct agdi_data pdata = {0};
> 	struct platform_device *pdev;
> 	acpi_status status;
>
> @@ -103,12 +192,23 @@ void __init acpi_agdi_init(void)
> 	if (ACPI_FAILURE(status))
> 		return;
>
> -	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
> -		pr_warn("Interrupt signaling is not supported");
> +	switch (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE_MASK) {
> +	case ACPI_AGDI_SIGNALING_MODE_SDEI:
> +		pdata.sdei_event = agdi_table->sdei_event;
> +		break;
> +
> +	case ACPI_AGDI_SIGNALING_MODE_INTERRUPT:
> +		pdata.gsiv = agdi_table->gsiv;
> +		break;
> +
> +	default:
> +		pr_warn("Signaling mode(%d) is not supported",
> +			agdi_table->flags & ACPI_AGDI_SIGNALING_MODE_MASK);
> 		goto err_put_table;
> 	}
>
> -	pdata.sdei_event = agdi_table->sdei_event;
> +	pdata.irq = -1;
> +	pdata.flags = agdi_table->flags;
>
> 	pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, sizeof(pdata));
> 	if (IS_ERR(pdev))
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 048f5f47f8b88..9ddbdd772f139 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -339,7 +339,9 @@ struct acpi_table_agdi {
>
> /* Mask for Flags field above */
>
> -#define ACPI_AGDI_SIGNALING_MODE (1)
> +#define ACPI_AGDI_SIGNALING_MODE_MASK (3)
> +#define ACPI_AGDI_SIGNALING_MODE_SDEI (0)
> +#define ACPI_AGDI_SIGNALING_MODE_INTERRUPT (1)
>
> /*******************************************************************************
>  *

Like Hanjun mentioned, these should go through ACPICA project. When you do 
that could you also add the SDEI flag to the other places, which are 
needed for iasl to be able to decode AGDI tables. You can find them if you 
take a look at my patch in ACPICA project.

Cheers, Ilkka

> -- 
> 2.43.0
>
>
>

