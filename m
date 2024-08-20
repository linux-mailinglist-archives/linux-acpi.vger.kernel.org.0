Return-Path: <linux-acpi+bounces-7721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B500958B7B
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 17:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEFC1F23B57
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612F629424;
	Tue, 20 Aug 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tu1bGIu0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A518E34B;
	Tue, 20 Aug 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168454; cv=fail; b=fTEmPQJyZW/4/4pQFfLrZGJkHIfKeqQbWIvK/AK5qpVTNgjU4RNG+LYbIp4lRmeri7zjRX8SRG0RX4AF533m6xVA017dF1jSxRH0oDFESoG5/iGWeOJH+OZhXPgD02dGH2Y6IWSVEHSyTfur4HNa6wwp0G2/YFEX2sL+8+hfWRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168454; c=relaxed/simple;
	bh=qBvdkgkeVgUW71hX85hn39afoPpQQQD08AurjvWmG08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r4Qe7At+JI9cYk5801EDKOMRVie5OBGWqqLHigcFfUbiSOTriwPYELXLyjoGNcr+BtTdiXqbaYUdHDpJUeOU2yXXKXK5vkDN89HLOKRin+tLJIJ32NspqWd8jTiOnYfFW2xDjrO3je2/UrmsRLEnBq0NYQkwfB6GNOzAgkJLkTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tu1bGIu0; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoighwkEXQeK6yBNBts6KPUFkG+OhDhZg4L0CQ74BMQRsgOWI7BbgwhDIlx19pMI9yxlNgBC7tIaGHyRWMWprcsQliwHKB/74GIl2wc6zrHmb48HSG2SwgvV0ItqTjw4mwhRK8bz1v4/INhNa83348RSxiIQAgSXsDFs/CgQu9hHiJguuiWKg4ArVKpeo/2owYMxAbbKwZxeET3IVut0Quj3voPa9200HTKxnXCosBLbI80IXCtwIN/4h7qKUd79RE2+VYfqvLTWB5JZwz9PgqRkJeX3o//4pFVhPIbZbOZsVtV4E2QHjMqXFpYbsXdBImNBhxjxYgcbGj/8iCnPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skJB22R2eek5klGaBdxjx4IA9EJLMnbhcQpB++VA914=;
 b=Oe1rbSTzLKNZ6EVAll1KBs0nwjRDDf8jDmmPIzox96iCCXZpqAQZt1bXO5pFCEKKBY6Z4k1xrheNYSmtJnS2k5ZNDEmDBeEnyMH+sQXxwtHMsRTgwYfJb8Fo3L/cFnSUoUmA9dXTCgZQ4auxb5+lADLxy2c9PJuvfSyPRhHD57vrvlF1+2WEpv0xszHE87W9yihPZUK/zxR6trKeAXOMJM74QhZ0nZX+C3fjifS0FzoHrpEbqtRZQc38dNeP26M7a81dVqTZ3XV1FCkay/oker3e4UC5w5D97uDLdA/HyBdGpDXf6/1247cdhB3sCMzRi+CnVzFJ+AMzhrChriQ1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skJB22R2eek5klGaBdxjx4IA9EJLMnbhcQpB++VA914=;
 b=Tu1bGIu0Wsz0POtyBogaZrBzh372oYALFmK1M31EOnj5/g5YTi0o+2Ecma/bYt8xoEB6ktQYDxuNwkXvEROfNNOMbyRihGKABq0sU+34rxUoF3EPI9YOohCMbbygNWaEpCEKznXf3H2OKmm1vw5xlDizfde3YG1RvA44i8717Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 15:40:49 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 15:40:49 +0000
Message-ID: <0fa061f4-c82b-451b-a12d-e873d853e436@amd.com>
Date: Tue, 20 Aug 2024 21:10:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: APD: Add AMDI0015 as platform device
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sanket Goswami <Sanket.Goswami@amd.com>
References: <20240812144018.360847-1-Shyam-sundar.S-k@amd.com>
 <ZrpFU6wFyQDykSlO@smile.fi.intel.com>
 <CAJZ5v0guWb4fK0DB1t2MMGvYXBrVoq52Fo_ZgzEqyF_OndqsLQ@mail.gmail.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <CAJZ5v0guWb4fK0DB1t2MMGvYXBrVoq52Fo_ZgzEqyF_OndqsLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::22) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 97546188-cb7f-41dc-3f04-08dcc12e770c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU5YajNySm53dWtXMi8zY0VIRzdOZXNQVHVOYkViSlNRci9FS3JxV0RCdkFr?=
 =?utf-8?B?NzVrLzY1TjBBL0JuUVEwaUkwNUxBWEphMWRNOVhyRktmQkZjOHpjcDNwU3hY?=
 =?utf-8?B?OVFiREtnOXVNdWN4RjdZSXlneWNTVmRLVnF3N2IzS3VuU0dxaWU0TEgwUWR6?=
 =?utf-8?B?TWRFWGZvWWplZ1JJcE1CUmZ5UUZ1R0ZXaE5zWEFjWE5ZY0JLaHZvSDM3V3RE?=
 =?utf-8?B?K2Y2anFUdlhnbmFCVjFkNmpRSGIvK1FJU2RXS2NsZmdWQ2l5NVhtb2F3OXh4?=
 =?utf-8?B?N0ZVU3FDNGlKU3lFK3FZNGR4ODB2T3I0d3lGWUxZL0tZYU9wL1B2NGFCODJU?=
 =?utf-8?B?bDRReW56dkZ3QW5LVGMxTERQaDdDNHhwMkNKZjgvcEpMc24xS1hwMjA5d0hu?=
 =?utf-8?B?bmI2MExLNWg2TStQT0ZMN29wQmtqQXcvcE45Q0oyNmZYa1YyUnhPUUJCWkFW?=
 =?utf-8?B?elJDMklMUFZoVkFRblZTUmg4QytTMjBhQ2NOTmthdHBoY1VIV2YzSTQzZVpq?=
 =?utf-8?B?VUVNZlRTbnF2dW9pWlpzdzFwbVcxUWt0eE1VUnAwNERRcEcrd0xpL3NqcHBG?=
 =?utf-8?B?OTNHR3BjM1NzWjY5K1VSYkZPTGRLYWh6M1lhR2llWWxVT01WVXNCclcxVFph?=
 =?utf-8?B?bzJ6bUJEN1FOSHNZSkxUL1FqOFFaR0ViYTNpOVJKUkx4NExiRDVqd21uY0hl?=
 =?utf-8?B?L05YMGVuM3RNbSszMjBCRXhFT29STkZLUytPMmNsTE5abGVEbFdObCtMQ001?=
 =?utf-8?B?SUZaU2VFNDRlQ2lrTlRxTUI0SlBpY2lTb2pUeStNOWpqMExMazRnNFBJRi8z?=
 =?utf-8?B?ZGpsL29nZ1ZGY1U2TVRxaVRDMjE0aDhFSlRUMEN6cllzcUpCZ0wrRkFSS0E5?=
 =?utf-8?B?VlNGRFErcGFlRWo4QWVTQWhHUnBORHozL2FDR1hoWVZVZUltSDlTcmZBWjdp?=
 =?utf-8?B?c0lkTFViY0RLa2N3V1ljZm8yMi9wd0tSMzFDNTNPZEFwU2lCaHpMRm1GUDJE?=
 =?utf-8?B?dG9rMVBhdnN1bTNhVUtEWndibVJRSzBMVDZTRGFPdTJqaVpia3dqNFJNZ1kw?=
 =?utf-8?B?KzBSZHBtMnNPQS92VFdydTE1QVpURDdjZUtHR1B4bjJFYWcxOFMvNUV0WFlr?=
 =?utf-8?B?NFFtZnZuVzFmMVJweVErdVh0LzIrbitPYTdCTEExaTRVblVCbXNpOHlGYlJV?=
 =?utf-8?B?ZWtnRHhPdXlBdkhLUGo4RktFN2JYa0xzdUNYM2ExdEpCYTlYTzloWnNtdTk4?=
 =?utf-8?B?RHlVOGM2MmYydjd3S0hvU2pXamVzWENGTGFGZWFBcnpZblVFVnh3RENkS29N?=
 =?utf-8?B?TjBpOEcwS0tEVHRpRXkybDlIejdERGFjSkdURGpGVEhlbjdHZERaQklGR3pl?=
 =?utf-8?B?aUlVNzhQRG9rTkpsakJ5b1lpZE5TcmlwWnZNdmI5YjVxNjNLUzdNTFE5WlNi?=
 =?utf-8?B?WURDcGR4dU1EM1NBNUdzTkY2cnc0QnBmRllwZ1dDYTJrdW1od3kycm91UnpK?=
 =?utf-8?B?OHpnNVR6RWZuWVcxUWRQSURjVUpUYk1VZFRkSURPZWZLM2VvdE96Q3RKemU3?=
 =?utf-8?B?U2xIMVdRWXVyczRqQ2xPTWRoRnozL3kzZlV6R056b2FpTHhGZEVHdGNQSU1m?=
 =?utf-8?B?MUpHQlZXcVJDTkZWakFSbTJ1THdhd05OQzlCUk1mR2pKcmtHZHVyZlRteHVU?=
 =?utf-8?B?d2dVU1hHQllMSzUyTWRrMmYvN0ZvNklJRFFOWlNrNE1WbWpuQ2toYXgwR0dL?=
 =?utf-8?B?OTNCazJzQVR5OVdnMHFYOUVGZU9UVktqQ3FDcTVZZGU3UlJ0ZjBmZjAvSmsr?=
 =?utf-8?B?QmkrVTZpU2xoS1RDY2ZRdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmFwVGxUTEtvQVZzVTlUMkJ1RzcxMmpKSEg3Z3Z3RGhNUFpKZmpFSU93M21j?=
 =?utf-8?B?WmZFdUlYNExPSE81SmZRSXNoc09rZlkwVFF5R0c0WnJYeWVkVXhZTDl2cTha?=
 =?utf-8?B?anRyRWZwdGxhZk96elBNT1ZmSEd5V2p4WExBZXpPZGsvSUdldFZFNzFiOEcz?=
 =?utf-8?B?OFZ4b1BaQWlEZUh2enNNVmJwMzFtZDVQRW5EODFvYWZKVXJlN1hJdEtrcnlq?=
 =?utf-8?B?MVRRUVhBODlERFVJMWhMbnN3NzFrNFZFeG13VkdKcnNCSWd1S0pzajB3N3pl?=
 =?utf-8?B?R3Q3SFk3VnFkYnREMEpmUjRIckpmQ0QrQkdiNXZjWEtMYVZXenFHVnpyNjdB?=
 =?utf-8?B?S0ExdExvU3FmK1JYRndXbUJ6RFdCeWlubkI1LzRtbi9CTVoxd1NsTFBidlNh?=
 =?utf-8?B?THd5d2JqK21rcnpVc05zL0dOYkY0eHN0SG1xNzU2Yy9LSElFRW5iZHZCTGxw?=
 =?utf-8?B?OWFZVHROSXhNeWtIYnd2N1dacTJWWGsxeXAweEdZbWZiQ1AxYzBlL3JjbUdk?=
 =?utf-8?B?TEdtS09GQ1NqSWI5RnRucSszbEhSem1lZmNFSFdqdVdpSTdQdWkxY0xLazJY?=
 =?utf-8?B?b01sUHlPNnVPN1ViKzQwMmJKK0lKbU1ieG1xTndYbkFGd1h6UDZCMzNsc2xn?=
 =?utf-8?B?Z09uL3psL1JMWkdNc0UxenAveFJtV254emlCWHYvRUswVEhVVWc5aHVwODMx?=
 =?utf-8?B?Q053WkJKL0NzcWhYamlKMWpYK052WlZFUmZoL24zQ3djSkNHRHI0ckpidWpj?=
 =?utf-8?B?MzhrRVVlalRZYmExZXI2WDJwbmRPZHJVWUpUK2ZmZkJ1WEdScjg4NXYwMHZs?=
 =?utf-8?B?UWNZRHd6WDR4MC83dkZJbC80WlRqZWd3RG1QWFliWStNbzFiLzhmV0lkVElE?=
 =?utf-8?B?QktjZnVPTlRralRhR0ttSEh6MHQ3TEQ3TUd6Q282VWkwTUFWRHRGVEhqUjlH?=
 =?utf-8?B?N0lqV3pQNm1NSDJ6dlhkTEFXdXdKa2UyZEpORVdLRXdSaUdVUWFiSzVlUWdG?=
 =?utf-8?B?TDhDM3lpZU1mQndMcTJ4TVFjSHZ4dzdkMkF0QVJIZkEySGtZVlVvQlNKZTNT?=
 =?utf-8?B?U3N0L2dXeDdkNE4xMDMzRENDVmZiZzBYRDV3M3hLUE5WNWtkVGIraUp3Vld1?=
 =?utf-8?B?aW1DYjhpRmRCZ1FQbXRFMmFDTFAwK0h5aU9lbHF4SHpXTy9LMnhkd3RRYkIx?=
 =?utf-8?B?NHNON1F4dElwa01pMXlhTTR1R3pBSDI1K25Mbk8vMzBaSks4VFovV0hVZWl3?=
 =?utf-8?B?WkhXOFhCZnNPN2hVSWNTam9JOFlGSDM5MWtuaDZ5c3B1Vy9PSTNoU1lsV3Y3?=
 =?utf-8?B?MHZVVUVudE9QYnZ5WU1Ja2xTdnJlQXlZbmVlNmczVXlQUnhpVEdrVzk5Tjdv?=
 =?utf-8?B?eGs3eGJuZXBQVU1GdVMzQkErRm1jMGNTcUQ3TlF1OWhtYk9IRE5TOGNGckNz?=
 =?utf-8?B?K2lLVEhaeVpUUmZ5VUNneDJFb2RUOTJwOWZLZ2ZreHk1bDNneGgzWlAxS3hu?=
 =?utf-8?B?NkxWZnBBLzFxbmZiNit3Z25IcGNuSnBSSlp5MjROWFBhUVBEMFl6N2pQckhW?=
 =?utf-8?B?VlJkMy9oNU81OGV0WDUxYzl5L0pDZyt6NElVMk5sUzRSVytGcG5nWkhrLy9q?=
 =?utf-8?B?Zkwva3lTTUZFbVQzakI1UUdyMGk2ZE1taktjY1pZdEw2N1Z3azRqQ29wTW8w?=
 =?utf-8?B?QjE3dVNST2oza3RPQVkzTFhkSDZreFVEbWZHRnRCMmtDbVhqcnM2Zms1YUk4?=
 =?utf-8?B?azNTaWFJdU5zWFk3MlIzMzNiRzJoYkdIak5idmNkRlZROHBYcWVidFRYKzQ0?=
 =?utf-8?B?TEhFNDlqcVV3ZEUwNkplcndDSU0zeUtpYytZcTJZWDRyMGhyZmlYQzZlNHVt?=
 =?utf-8?B?QmxISHNITjJ5UGRMYXFieGtSalFoZnJ0VE9QUzhCd2VvYktHc2IzclBjVE5S?=
 =?utf-8?B?QWlQSXNsYnFtOHBBdllSeXh3ZkwwUmtWWXdQRW92NUE1WGpUcW93eVVRRWZt?=
 =?utf-8?B?RWtSRzUrZnVQWlhpVXJ3RkJvZDlmcEFQN2c4RWpaUTI0ejZ6ams4VzRSb3dJ?=
 =?utf-8?B?NlFNSXF4aE5pWTFid1BYZ1RZbW12OVB6USs3dTZCWm5SamFGWGNtdXpvQzRa?=
 =?utf-8?Q?jdfUJ7MsE/13m4paKIUj43kUC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97546188-cb7f-41dc-3f04-08dcc12e770c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:40:49.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SX7SnpYOW7J5vbTuchjHv46988jwn4L8BLYYdeJPmuJ5ipelb+mXb9Lu1oEwDUopdyy5yPEsO4Tii67A34IeJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280



On 8/20/2024 20:19, Rafael J. Wysocki wrote:
> On Mon, Aug 12, 2024 at 7:24 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Mon, Aug 12, 2024 at 08:10:18PM +0530, Shyam Sundar S K wrote:
>>> Add AMDI0015 to the ACPI APD support list to ensure correct clock settings
>>> for the I3C device on the latest AMD platforms.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> from the ACPI ID perspective.
> 
> I've replaced the v1 that has been applied for some time already with
> this one, but please note that it still is not entirely clean.
> 
> Namely, if there are two S-o-b targs on a patch, 2 cases are possible:
> 
> (1) The person sending it is not its author and merely sends someone
> else's work adding an S-o-b to document a "supply chain link".  In
> this case, the From: header should point to the original author (it
> can be added right before the changelog) and its value should match
> the other S-o-b tag exactly.
> 
> (2) The person sending it is one of its authors.  In this case, a
> Co-developed-by tag should be added to point to the other author and
> its value should match the other S-o-b tag exactly.
> 
> I've assumed (2) and added "Co-developed-by: Sanket Goswami
> <Sanket.Goswami@amd.com>" to the commit, but that's not something I
> should be doing.

Thanks! That was a miss.

Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com> is the right tag.

Thanks,
Shyam

> 
> Thanks!

