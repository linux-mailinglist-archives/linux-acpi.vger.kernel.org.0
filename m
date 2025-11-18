Return-Path: <linux-acpi+bounces-19032-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D32C6AB5E
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 17:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CA2852CCA9
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBD731B81D;
	Tue, 18 Nov 2025 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dCU0iQcb";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="VE4uaJHo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91A305079;
	Tue, 18 Nov 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484406; cv=fail; b=WvLsnGx5gWl+SHZL1fH6xnONYybG77EXofISJxfWZfem9KpW7VgBc25OHPkK6Jc5S3eFRVlAtrpjAFHrbmYvA3JaZpFRGyVEX+fN5hm1Q+JeyTCWi00zVs+UG7QxTWHRAYdGYKVB/dDHrtSZAfskTh3aW1Dh59J7VuY+jG5axmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484406; c=relaxed/simple;
	bh=vribAjhf3amsskORwZHyDK29M/xn6ZVaZ0dOPJLhAyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bouDD39XBiyHdzc2WePoCxEF4ry52B0YgolJzfw1D2eMZ2EfrAlLPLoObLErnvev5REa3BDyRYjGKUlw050RVuxfFr31ZzER7yMRtbz0j4D3Mzx4JT9/Mf/L68vtc5ZX6Zh3T63Cm8fpG5myuKtazg7fJ+zP3JRl1U4hGW4ew8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dCU0iQcb; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=VE4uaJHo; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI5xPPW059271;
	Tue, 18 Nov 2025 10:34:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=f/j4jFo014kPNxHKVL
	d5/stBP75NPJjIr5TiK1u/0MM=; b=dCU0iQcbKLThHljINb3n0W9UEUxmjthude
	UPNStCQirYaOwtl2Z/ny+MiiED0ZI12NmsmoiqJFKcxd6rBrBlKXopB8UNAnkKb7
	J4I5sg2yilw6hNutvV6M8uGRtJdylSyOhpt9FRi1wvNZlXQ4rgIxDWAwj6bhxDXR
	x++zn5cwNSqGCLz1FTmn1T7d99vKRC8onQSiyvHlijoKqQbgicP9Onl58TpjmHmX
	iwNmzMkmRwec916mvOclqvQHvvAB9ropBwnHbX++mM4V/XqONKi8JOuRy5QCLnSF
	oM0hAF2uOgnBh3iUqWBnBNVL/4jeY2h7CCuVzf2ZlbU1KbllW3Rw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022141.outbound.protection.outlook.com [40.93.195.141])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4aeqt1bq92-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 10:34:00 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uK6kY645C4vrmAU6aXvF1vx47J98XLAoDD3FHR9uVOGwdBe1wpl+cLRcpmzYqrhtyHCcXiqw3h7cQCXjYcoeWfDrJ8N6AC0bj3FhPZYdGxN/lojgBmNg+hlPj/M35ozQGj1SZzWvU0TojICTEIfCjHrpBRwdwRWgiVrJBVVt+5GUGO6gZbNmo7R0xfP5YcxybkVWVGz77hsbrOYLgHjmioKrmNwOiz2f0kYbITpPoiga/tUoTI/AIWbhl91i0xczppukwlIwWQtWylzHlLNNn0UVD9IKn2Rr7wudpbybEFjIBThvXzsU6TNpOlfTftLSWG/gY0F06PcX8s04AAxqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/j4jFo014kPNxHKVLd5/stBP75NPJjIr5TiK1u/0MM=;
 b=MsJ5cED/xkVGYmsn8wjKxIRMUOuOmoTXzemov8UhSrSYYcssiyNearoyryLElO8i+/QsU5NSpV4rOlp0WNds8i3Ood28c0d6gZS06UaRKjRDVQJyorXA/ZocOtydO11oznbXWXBLySyOFJla4P40RStc2QHltzqhc1mBJIW2OfTxc1Pk0LmfHdNLjSPDajW0y1NAmY3EMpdbQC77mquSBm+Kvgk5eLBE0Dr0kXzePMA4L3qNxP73kHupbTG31driUB0NHgUzfOmvN0vIxdHbGzNVvlSSDnNjTQ5NWxBbc/bxDolSEh4pqODzq7oZgQxU7lhQY2dfJoZo+3Mw/ly+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/j4jFo014kPNxHKVLd5/stBP75NPJjIr5TiK1u/0MM=;
 b=VE4uaJHoL7e6RKmuAob9YQeUxWCzKQ8O47ftJvtz8josmiEWOsPAH+HeA86ZPUMn7JtuFj+BKnusloK+K/UITNOGsEWm9U0/h0ixUycNkAbKlFipzM1FnbR7Rcc6TNcV2Yc1+0YIA7UeaQc1A85BvkIL+ICSmAKYDi/VGacxPtc=
Received: from BYAPR11CA0059.namprd11.prod.outlook.com (2603:10b6:a03:80::36)
 by MN0PR19MB5682.namprd19.prod.outlook.com (2603:10b6:208:371::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 16:33:53 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:80:cafe::75) by BYAPR11CA0059.outlook.office365.com
 (2603:10b6:a03:80::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Tue,
 18 Nov 2025 16:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Tue, 18 Nov 2025 16:33:52 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 908DA406547;
	Tue, 18 Nov 2025 16:33:51 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 77F8A820257;
	Tue, 18 Nov 2025 16:33:51 +0000 (UTC)
Date: Tue, 18 Nov 2025 16:33:50 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v4 04/10] gpio: swnode: don't use the swnode's name as
 the key for GPIO lookup
Message-ID: <aRyf7qDdHKABppP8@opensource.cirrus.com>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|MN0PR19MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: ca034428-16b3-4842-43c0-08de26c04301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f3CR+g139e8M90kejGTsMgCZmmwZi4wfSsbJo2dP+YUcfn2NSjdQRD2wPGzE?=
 =?us-ascii?Q?N4qeXJE6NM3LS04NDUVpwHJn+sB8EVPC6YiFMlHdLGOwp8loNeYtZTZSWyfd?=
 =?us-ascii?Q?kuAPXEPHxNty9ta4xTvZMyQB6nylB6l9C8uL8Se5lJBOVYJv9P+1G0QubMUA?=
 =?us-ascii?Q?J6l/9h0MoPb6YVlf9jOzFD4cRdHkwaH39gMOdOxfR5uwycVg8Rz9bRlEvwYY?=
 =?us-ascii?Q?b0G7DCniqV4pLhsyyPGHbVIo10j2HYSUe/2xyl5AH5zh/PX7tVNYz4/6DM1E?=
 =?us-ascii?Q?f0Xqm1ndvDVHNPR+cG+ES8bCABPFQPZ1/yVcP9cz9LAK+7pxjTrm9YnfZkFS?=
 =?us-ascii?Q?OwcRehxb8i5pCRy1xyo33bzhlp9Ho3Z1V74MAgMUfVSbpeWDmXiHJUdvb/tt?=
 =?us-ascii?Q?XXQ/3TpTJelmxt2dZ93wa3rdXuO1MkD2ULprb76xXtDpIfDBTlX1pUEaONCO?=
 =?us-ascii?Q?06lDKasuu4C+R/QnnJT3CN4KTEgr+DHh9IuY8F9o7HyAwQuabwqjwwFFs+Oz?=
 =?us-ascii?Q?yJBdrfFvcasIc8U82Ru4YI7vYfoLzfwidE8DKCCsNKtrOwpyI5ss4/4or89o?=
 =?us-ascii?Q?YM5YrbvlvYE3/FmbbUVC0PHrZJOjEH7E4AsLWjlflhVLJtXUJVM00mCqru0n?=
 =?us-ascii?Q?SWvUBp7zdmk1QeB9N9bD05/zMUJ0FimNUKi1TPsqvP6A76Av2vX5X0trpmDC?=
 =?us-ascii?Q?E/BrgUaJ3wK0iSqXh56PKFvSmS/wOLGeaaY9X0mgKt59IGR4zrOBBAMJrNNM?=
 =?us-ascii?Q?oiqkckfgnzUHfdsQ/QBKncaMEXCmh+ostuZC2G1mDIw1VAJTxrm6h4wd22bD?=
 =?us-ascii?Q?cKAwzK5VMdcaNqmbJ2DfAuNaPDjtDxSqh2W64SmzDzDxr1IjWEz+HMtArdu/?=
 =?us-ascii?Q?OZEbUWHv1En3UYkZ6K/UuQVgTmn7nHWTU0QYoyj0fY+jzOWjmMn/Ww/8lLqQ?=
 =?us-ascii?Q?Bz8NUUfAN2+7vrJbvasMylgcjL5z6peYLUHgMg4Iwk1B1sWgTOuvIp8XpQ0q?=
 =?us-ascii?Q?8dEqmvvGgRyW9+PIoSxg+M5mbIWwum0kz4XvA+tYSQ4lnDCnbNxgt4yW5qO1?=
 =?us-ascii?Q?jo0rjF8Qlr7Zqw4uX6R/+MzukN7g4Dc1VwuFWkFr93HoYtZTE1DBxLLTgxeP?=
 =?us-ascii?Q?+zdp6X9j3VxTA/avuG9FQqH8ROlUXZ5gpwTEwUfwmgaQ7eUWDgkHyjP48ZvQ?=
 =?us-ascii?Q?/vF6R8XNgtl360MBmLOoqaf3HOzglPZ596DnUGK6zr8ODZLtqIHe/L1N5Ajw?=
 =?us-ascii?Q?KPhI6OglIPes65FtzAuQTp9OcJY8x66YHdFA6IzXnQ95Zlea963JsgO/336R?=
 =?us-ascii?Q?Aol2NtNILVpDUhd+9q5VL3l70RwDQuhH6+2kC5vqhaHpbJB07AbsOZrX/ELJ?=
 =?us-ascii?Q?+OS7NS9qUhHC36Eq1/z6cuF++NL7GEo7Ywz746Ea50Gjonz5wQFP6vzkofNh?=
 =?us-ascii?Q?mUyPQ0qeNzR5Rt/NpqJI6GYjnSBkFktx4/gOCSxcH3enANcuyiTh0iGUpAEb?=
 =?us-ascii?Q?eh2o++R/iqx3e8Q+9kqhDTiiQCSjcDGDLw1tH3fDeyMrPIgdyOCv+zj8tdqp?=
 =?us-ascii?Q?nkAjGD/OR4e0lt/odbI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:33:52.9521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca034428-16b3-4842-43c0-08de26c04301
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5682
X-Authority-Analysis: v=2.4 cv=OOEqHCaB c=1 sm=1 tr=0 ts=691c9ff8 cx=c_pps
 a=grR+JLqVfS8Y5b128bbGRQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=O_mYIUxG9PxvoMOS:21 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=iN5EgualfO_EKXrbzocA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: SLIyGwYIOt9ePoGZJa9iaRnl5DA9XqL1
X-Proofpoint-ORIG-GUID: SLIyGwYIOt9ePoGZJa9iaRnl5DA9XqL1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDEzMyBTYWx0ZWRfX/nZQ1QF8uV2l
 OFzw12DPvoxwLFUyw6CpW+lOOf1gYfwiXR4gtwnWzCgzHeB7lIQ//1c76HsDcbIQl/Fb7pLsJSg
 oIjGuKA4b0Z+eM76ZlX+xCAl0Uw61DZ4onyi0vMUIIJMMfTLwbXdqmsiG68l/bP96vnY6EsqCtB
 IyuRn4oFQJZoFZbtUFxhuwdZM8lKIc+cVNHXT0UGTM6ogir2wKCUm0eIxJ8VZ4O2f2VwZe8vwxN
 IPUNk2+2P2+uAd6hVlyKb7whUDNPMUjIltbJw5hoVCY/F51XNb6tGeK51EpPTZJ3oiyWj/P0wFV
 6zVIFpF69r46Qeb+VolL0ODahP4ydQcGpRpK6mDEw6hv/MDDSf/QkKUjQwdwgO6TJMQSI0vHjes
 tXirZZeAyaB1nOTsHz8UAieFw9l6Hw==
X-Proofpoint-Spam-Reason: safe

On Mon, Nov 03, 2025 at 10:35:24AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Looking up a GPIO controller by label that is the name of the software
> node is wonky at best - the GPIO controller driver is free to set
> a different label than the name of its firmware node. We're already being
> passed a firmware node handle attached to the GPIO device to
> swnode_get_gpio_device() so use it instead for a more precise lookup.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib-swnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
> index f21dbc28cf2c8c2d06d034b7c89d302cc52bb9b5..e3806db1c0e077d76fcc71a50ca40bbf6872ca40 100644
> --- a/drivers/gpio/gpiolib-swnode.c
> +++ b/drivers/gpio/gpiolib-swnode.c
> @@ -41,7 +41,7 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
>  	    !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
>  		return ERR_PTR(-ENOENT);
>  
> -	gdev = gpio_device_find_by_label(gdev_node->name);
> +	gdev = gpio_device_find_by_fwnode(fwnode);
>  	return gdev ?: ERR_PTR(-EPROBE_DEFER);
>  }

One small problem is this does break drivers/spi/spi-cs42l43.c.
That driver has to register some swnodes to specify some GPIO
chip selects due to some squiffy ACPI from Windows land. Currently
it relies on the sw node being called cs42l43-pinctrl to match
the driver.

I guess that is not quite the right way to handle that but its
not clear to me how to link the software node properties to the
pinctrl otherwise, anyone have any pointers there?

Note: There are a reasonable amount of shipping laptops this will
break.

Thanks,
Charles

