Return-Path: <linux-acpi+bounces-13917-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B68AC6A5A
	for <lists+linux-acpi@lfdr.de>; Wed, 28 May 2025 15:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2963B308F
	for <lists+linux-acpi@lfdr.de>; Wed, 28 May 2025 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7496286D7F;
	Wed, 28 May 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IGUkPiDx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IGUkPiDx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1A286D72;
	Wed, 28 May 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438820; cv=fail; b=ZPw3ugJYWwIbKytnFjmRWXB/Zz6FAAD2rL7euaeT2ISB9dnlMNmv2ePq3JtEVP8Aq14hS4jAfWd2Yj8P/xHL40hGWYQY/Pbk3Jy52x4kH1jtzyqDRJUkeH2nE0jVdyPT8w85def36rKJAdWprbgIx3jGzNq45cLDvxwekCsjI3g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438820; c=relaxed/simple;
	bh=fjik1RjtYZ0zNBRT/4AtCpwPxJ+k1ESpEjIkno0hEUs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YFqut+gDHt2fp+HFoQ0AVQiGD6QaWHlDZ7SADlEtCzy+OK2+suQkC32Nm07WSNHOqVIOWejJW7cVTRacM6T8sBkSCpgUkncpyVWJ5ADVyLKXKd1giV5i8xfgKkfabMIXt3TYzKA9mdXndtikAvG2bGIR6ZZdncWUj06dab+qxRc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IGUkPiDx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IGUkPiDx; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SEVK4vAB0EXpn45K0qwhzqb4tbSGiZxtS8zX9oBKW3AyiYk69CYZOrVMT/9Of/M85+WVY1hTQEAV5PWtGFAoccqxeGIrjIX/5IUGpL6BXVGEn0lEMfDx581zJumgxO9RbSNbGJciP63QbndoXEQ4XShJPuBBxljRqIzkMo8cvj5En8moyx3Ym1LYhAgR13yihLDjrDif8qYYfyfvXdGT3ZHlG9tIfT8r3eHMybNECP2KUMOfnx3HQOFVazqtpBz+RP1MYV/mApu0h9DXly/vR/8jy2FP3NQHKjnu8cxhd0RpCpJVueHQPqlej1v8gH083kD9LqRNYW+vp+c8fSbYYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aOrNN1YkvSffTqNanEUWTGR/b1BxrX+YemS9hhSrKY=;
 b=SuYOmAt57LMb/xoA6Fi1vZmGnESILqo38lVMMsOKuwSS2qpTu+bs/J1DFZyGOsnQc8Q6wlkyIxcAjMH6FeZsPkPFXt41A4Wf4IIf0k6zCRjv4sFlQL0/ev9Ud+DCb7eDX4ySrxPD4P8dDfX7CB/eJP2bsiIwErNJukccsfLwsPdecm4hSZlr6OBbFsMWlbfzlhsAlqWinScz+Ha9Q/j2G6Rlac47tp8uoveYEe+CCg2+V7AKcoTzLW4GeHCt3LIis5pIfJrYByedfAjAorcM7m76Ruj8wzbNQdaNXvM12MRdWDLfUxO4CjpQqbBh6JLPzUbSaC3gX9eiQUrNDnedPA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aOrNN1YkvSffTqNanEUWTGR/b1BxrX+YemS9hhSrKY=;
 b=IGUkPiDxRyg/s/Cr/Wi848is3JxvvCkunxXJ8mOo0l+OPFj4yeIB0Cm7R62O3+pVNRqT2bvhy1uLyUt3xyN2IAe9efdXCyeLDCW2I8DG209GSjuic5iRW1OUIrgcqRCsN7WxtDYdVdOlNeywOGaPDCAsfGP7QUmieZnTyprnYFM=
Received: from DUZPR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::20) by GV2PR08MB9160.eurprd08.prod.outlook.com
 (2603:10a6:150:e0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 13:26:50 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::71) by DUZPR01CA0026.outlook.office365.com
 (2603:10a6:10:46b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.25 via Frontend Transport; Wed,
 28 May 2025 13:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Wed, 28 May 2025 13:26:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRsfj5rDFKasY6uNJRoZidt0oNRJokv/duzpKeZHP0e4XefQX3jbkQCfs3rIm8edxctEVHutQ9iJEF5jPE28A9W0JnTZLzbZCtZjE6SJHVFzvE7o+p8lH1BqsHNKFSv1toGaHFBV9/HR8k/RZYOR1a0o+A/nxECnM97dM235xovthwcMqNXnvqmXT24zyBuUmV75375EA99zgFEcvGMRGaQMplF+lfqxtYY3WyAERRPKpfZcMDOKz/VJiheeyosrUa9hu12Z9bP6XDq2llti/DpzlJqopJUbCAnfJn8ah3zmF6gHLwZJRQlEf62+nWuKiD68Bd1Emt3/R1kZJhwa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aOrNN1YkvSffTqNanEUWTGR/b1BxrX+YemS9hhSrKY=;
 b=oMXe/yKjC6YWHbzXNxQlR3M52p3KY7fw23lGB+T0Rrnuj8L4B07CYWdAjp4PTcEuxIRuvz8ICjlDCauSEMTdI2fvgzU4NF7BLo0ykqHpZhkG9fY9ZjRxB0i02e96sDV6/i4UMy98rsiyupSTNot0Mms788MDGMXGgBSLNo01goc4rz7VQvQ//EIWPuZKz5mM9xPPhQ9SBQypWQfmYdUp2dFIwiC7egHxDKhwf5JQzm7L0JGerEZB1NK6UZBIhJVCTNokhLSq6wVbc2s1fPens+aXfovPL8in7TzWo1ZQVPUy8Dx1IEFlBfsK/TcTqUO7TYZERrD37w0diwvKrjtocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aOrNN1YkvSffTqNanEUWTGR/b1BxrX+YemS9hhSrKY=;
 b=IGUkPiDxRyg/s/Cr/Wi848is3JxvvCkunxXJ8mOo0l+OPFj4yeIB0Cm7R62O3+pVNRqT2bvhy1uLyUt3xyN2IAe9efdXCyeLDCW2I8DG209GSjuic5iRW1OUIrgcqRCsN7WxtDYdVdOlNeywOGaPDCAsfGP7QUmieZnTyprnYFM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DB5PR08MB9970.eurprd08.prod.outlook.com (2603:10a6:10:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 13:26:17 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70%3]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 13:26:17 +0000
Message-ID: <237e957e-82fa-41ea-9f6e-bd37f51003aa@arm.com>
Date: Wed, 28 May 2025 15:26:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cpufreq: CPPC: Some optimizations for cppc_cpufreq.c.
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, robert.moore@intel.com, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linuxarm@huawei.com, jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
 lihuisong@huawei.com, cenxinghai@h-partners.com, yubowen8@huawei.com
References: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::8) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DB5PR08MB9970:EE_|DB1PEPF000509F4:EE_|GV2PR08MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a03c977-6f92-4d73-1a92-08dd9deb4daf
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MDBuamk5QnpFMEFZSDU0YllBR2RmQWdKdllzQ0xmLzQ1b1JuUnZhNC9NVGJy?=
 =?utf-8?B?empaY3F6RUZ4NmloMDN2K05reU5JbmV0R1g1eVpKU2t5aW9MYkRiU3VRMDdj?=
 =?utf-8?B?TGw4by9oVCtyU09teGxQUkhFTWpNM2FiYzN2c1JXZDJydDBjVGhjM002Zitn?=
 =?utf-8?B?V2JpeFIzeWlsUzlwN29zMldKS0JpTEZhTWpRU3gzOWJ2RE1jRmpZcUoxY2Ru?=
 =?utf-8?B?RjIxTEhGVUw5QmN0Wks1RFd1SFJiV0E2UUtmck9JT3pua2JwaW1NZU80TFlh?=
 =?utf-8?B?TXFyRjgyMnM4YzJOSDJrZWNMMUdPd0pvRnhpejR6bUlWNWozREQvRlpuVzRT?=
 =?utf-8?B?djMwVVF6UkxQWUhWNVQrcC9ncHR2SS9tdXpnWndPL0x3Y3JyeUFOUFNlcmdW?=
 =?utf-8?B?bjJqVXdPZ2EvVWo2cXVnOFhtSG4zdWZzTTZwdWVJdWl3dTU5OEJqZGRKTDdW?=
 =?utf-8?B?YnlYSEhScnNjazBhV2tWaFJLcXorTWV1SFVrUSs4M1kvY1Q1SktpVWZKdGZE?=
 =?utf-8?B?aTZYZHh2eWk4RWJ5eXkwek5jdS90M1U3c3B3U3kwMHdaOU9PYnlDSzMyayt3?=
 =?utf-8?B?VkEvZUZsTkRkVEYxTnF6S0diS3NrZnFWUkZ5eVR5Vk1aOE5vdDc2OGEzVkk4?=
 =?utf-8?B?QlBxTG5SN0tERlovYjUwTWdST25KU1ZPVjE2ZXdCd3NlaHhNdlpkaTEyZkhl?=
 =?utf-8?B?emw4M0lqb09KRVhUWWlRbHZpditaN2w5OGRTVFhyYWc1Zm5PS2RaSnpFdEZQ?=
 =?utf-8?B?b01LenpVbG5oNnRsc1R1WUxIcVNmWG1YMHJZcW9IK0hxM1FqbHVZZ2I2SWtG?=
 =?utf-8?B?V0Joa2psMEt3TzJNKzJTYllVYmFBQXBIVjFWVGY4YVZlRklLNGMzdGprN0tn?=
 =?utf-8?B?Y3oxVTVWVnZmVTNSWERQd0NtYVhpek5DbldKRkFjb1ZhK2k4dndBcUdOeTIz?=
 =?utf-8?B?c2VLWWtmUmgyV0k5Q0ZIVVh2VXBDdXo0NHVsakdjOVZLV1VqQWZIM3k5L2pj?=
 =?utf-8?B?QmJJbHZxVy90OTd2cFo5dFRZMmswUG9ISlNEdDltSXhDdldLOExPNmplUzc0?=
 =?utf-8?B?T245dDQ2MkdzUDFVem9XQjh5MUVsMTQxdit6YkM5eStwQzRxbEVWZ1VNM3ox?=
 =?utf-8?B?TFFCUEYwY2cvTFBpeXdJY2o4QnlOUGMyUWZ1S2xhZkdlR0lweG1EaGdBWm1X?=
 =?utf-8?B?bjlrcjRrSGF3R0xmY1VzRVMrRWVOTzRUVjJTVEY4Q044a3lTTjM5c3orUDhG?=
 =?utf-8?B?SGtRVkxEYm00bUVSeUNIZEQ1Y0VSS2EweTlEYVBuYW1id1RZL0VuSTlUQ3dm?=
 =?utf-8?B?SjhTL3MvQ0YxTUZTTFdMeTJiTENSOVZQRG93Rnk1bjhKTzBvZUcydkl0QVE3?=
 =?utf-8?B?K3ZmY0h1TDMzd2dWRVJVTzNHTm1nYStxeGgyYUxEeTB5UWJUdWxUUzgvWFJO?=
 =?utf-8?B?cHR3WFJLRFM0L1A5d1pPcFRNVHE4S3puK1Y3Rm9uRGxaUWFqODk4VWVMWmxQ?=
 =?utf-8?B?S2pJNUNhSmxBZmpKNnVpRnJBOFl0UHpIQiswTjl6Qyt5RENLMldEUDNnSm1a?=
 =?utf-8?B?WHVKV1ArZVl6eDQ5WGcrbWVFeCtEREtjbkh3RGord2FiTzFjT2NoQTE0TFBn?=
 =?utf-8?B?bGlPcWQ5d1U3WkYwUE4zM3lXWm9LM1NNKzU4VVhXamVkWXZJTllnZUlEeFlI?=
 =?utf-8?B?L3UwT2ZmSlMzMDhQTVRCTVptRFRJd0pQY2o5TWFqeTFzZFkwM202cGJLUHhF?=
 =?utf-8?B?MUZoU1NsT1JQRllrWmJheSsrcU5SUVVpdGZadThOdUNMUkZhUGtQNnNmVEY4?=
 =?utf-8?B?b1JUT0wzdFhUWXQ4RitiMmF0ait3UysrSzhLUDhoSm1GdDViVVQveklRNFBw?=
 =?utf-8?B?NWhPbVM1T3JXNlI5WkNKL25aYitFV1Bld3BVNnlxUytCRnlzQlBjRDdrYW9h?=
 =?utf-8?Q?b5GdKT0Bun4=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB9970
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c9cce1bb-fdb6-49d7-7ffc-08dd9deb399f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|35042699022|376014|7416014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFlXMXJqUnViN0g0ZnFFZjF5VjUwUm9Kd0tobS81b0JuaHo0cS9mWHhSTU4v?=
 =?utf-8?B?dWhGUEhCNkV4Ky8vcUFVRmV1bk1WYXViTXo1QlBuQXdOQ1pVb29DTkRJRFk3?=
 =?utf-8?B?N0puVGU2RGRmb0V1SlF1RDFmdDl6U3lEbWhRMWtVb1lhclhPTmhOaWc1OXBH?=
 =?utf-8?B?am4vVGdJT2t0YmdIQkQ5WEdtZGUwMGNPK3dtN0lQdkRCUGdaTGFmWnhUaU9N?=
 =?utf-8?B?dUxGODBlZU0zM2s3Ri9RbFU1QUFOeDNnN1kwRFdabmNCWkdXeDNhdkZjMEdN?=
 =?utf-8?B?L1NuZ3Y4L21zZzdCQjZHaTZMbExsbGtFNGJpWVZXTkZ3M082UEpBRWowcWtH?=
 =?utf-8?B?bGhpNUZKV212MFN5VGtSblRxbzVQeUpFT3drQUNBSEtrSWFTV2J0eUdzaWxW?=
 =?utf-8?B?Wm1ZRGdzMzBMTkMyTDREbG1ZR2NrZ3ZqTUtycFI4OVJzcFRMUW9oZjRVSmlU?=
 =?utf-8?B?TkZkUU1jVTNDTmdnNUZNd0RyZ0pGMU96bEhab2M1UzZqMzIyY3BjRWdpMC9G?=
 =?utf-8?B?NGk1dlp5T1lGODZxVE5hUmV5UU9OSWQvbVZoaUFlYVhNaHNyRjFVRWN5WTIw?=
 =?utf-8?B?bENvZmRua2FCTXEvT0I2STEwTGxpdkZNNHU4eC9JUDJPSmRXbVZEbnBHdnN6?=
 =?utf-8?B?YTZQeUNqZEJQc0diRm1JTzRteW1SYlJUQnlaYTExUkV5U201OXk0dW5ueG5O?=
 =?utf-8?B?ZnJPOGVWQ201cS8vQUd2UkVFYjA2ZTQ5K2JKUnJTRnlSbTVwcmtXaDRkTytm?=
 =?utf-8?B?WDk0TUcxV05oUm9kWWQzdFRNWDhYV3lHNGVQR0IrOHROU25WUjdXY1E0Z1Yr?=
 =?utf-8?B?TXF1OElmQkJBZ2hyczdZQlMrZmdXNnRna3N3MDB5Z3BUZGJiMVBaaU9OYlZy?=
 =?utf-8?B?eXlDV0huWHpGc1p6cmpzb2w3YjIxOUxJeFdDMFFmd2R2cVEwMWcwVkhaeHlQ?=
 =?utf-8?B?RjE2aWJWWFNtTkNzV0JqRW1RTCs2SzZqWjZMV1FHc0NLSzZRNmtldVRIK2M5?=
 =?utf-8?B?bEFOeVF5bm5QTVBaZ3pBYjBBUTNHUC80NVdtR2E0a09NRUhsOHNMc0hmQWRz?=
 =?utf-8?B?STlPSEJnWTBYSTMwNmNvcUI5MVR1U2dLWWVqQWVjdktEeVNtU0Y2RG0reXVj?=
 =?utf-8?B?clBYNVhFckphZENGUCs1ZXVwN1NNSFNDeDh5WlZTd0JyYlMydldCZjl2bURw?=
 =?utf-8?B?YXZZQnh0dUlINE1QUkpwcXRFM0ppdi9DQzZJTTJ2LzZGTzJIa25YeVBUL1R3?=
 =?utf-8?B?aU5wMDVPVzdCbitLeHpvRjJwNjM0d1R2czNEL1NxNVpGWEgzNWVvV25UK2Mr?=
 =?utf-8?B?K3NxWEpkc0tRS1NBaFVJZm9TMU5VNERnZmlVZjYvVXoySU95bEFqYmNieW5t?=
 =?utf-8?B?a05FMmM4aUluQUJkNzkzSi9MZlpvaklwSjdyYUwxbjlYTUhac1E4NDlNckIx?=
 =?utf-8?B?R29kbHFPMUVwcTlTcmtYbjRqOHRlTkFHbFNDTDRCaEtmd2JzbmE1aERHL1FE?=
 =?utf-8?B?cEg1YnZ5aEJLL05qTzJMa0JoOS9GM0xVaTREblZncG1keCs5ZEtyRUZFZHp3?=
 =?utf-8?B?VWJTUXZoQ2RiTlFTRVlKMzlmUHEzWG9jUHFqSjZoczlXSnkwM1JDb1M0eGsy?=
 =?utf-8?B?clJRVTdBUW8vSTZJM2JsNDBNd2hjaDNxcGxZSW4wY2FFZUc4em5rSHQwaDhH?=
 =?utf-8?B?UUI4QXdKTkhwOHJCNUJHby9GUXAyaURXYkZiRUxybXhGTUgyVEhOZWc1UWVu?=
 =?utf-8?B?VWRQa1FXYkx1ZkJHODNiMXlXYjBYT1drWlMxVjhpcnZEQ01aM1BvbHBxc0Nn?=
 =?utf-8?B?QnRnV3RCNUQvRXk3SFJkZ1lsS0NEaE5TeGU4eTh0bkdGYmI0aStSdzhYSVNk?=
 =?utf-8?B?L3pVeG9nVEFhQW9SYU8vMm1yUk4vdEhKdGtWb3NFMUFxdURKOUJHeG1xVXVu?=
 =?utf-8?B?K1ZwZFBsWUF0YUVYWElTdGgrREp3cThzMkR2SjRYUnBNVWRTU1AwVS9wbFdp?=
 =?utf-8?B?clBodDM4bXB1WFdrVFRvSk9QY2paS2lrQlphN25PTFRBQWRoUFpDUkpmc2pN?=
 =?utf-8?Q?cAHnrp?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(35042699022)(376014)(7416014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 13:26:50.1634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a03c977-6f92-4d73-1a92-08dd9deb4daf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9160

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

On 5/26/25 13:30, Lifeng Zheng wrote:
> This patch series makes some minor optimizations for cppc_cpufreq.c to
> makes codes cleaner.
>
> Lifeng Zheng (3):
>    cpufreq: CPPC: Remove cpu_data_list
>    cpufreq: CPPC: Return void in populate_efficiency_class()
>    cpufreq: CPPC: Remove forward declaration of
>      cppc_cpufreq_register_em()
>
>   drivers/cpufreq/cppc_cpufreq.c | 59 +++++++++-------------------------
>   include/acpi/cppc_acpi.h       |  1 -
>   2 files changed, 15 insertions(+), 45 deletions(-)
>

