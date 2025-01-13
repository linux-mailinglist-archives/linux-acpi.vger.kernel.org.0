Return-Path: <linux-acpi+bounces-10557-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B64A0BCBB
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 16:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79153A126A
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5641FBBCF;
	Mon, 13 Jan 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nWaTlSgA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D91420DD;
	Mon, 13 Jan 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783968; cv=fail; b=Jh/d/Fyn+YGvCGizGta/2ren4/zoL4F1xF/NgqEoyohG/BDVW3CYnlIORiz1b+ImIk8JA3R7ty17qQ14PbF4PT2W/shzuYdM81AzC1clS5/31ILi7uGipKrPRrNOCb7wY/WMJ99JSTEAfvx/X7uN1HfqFInWdZuF9yQ8KF5r5nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783968; c=relaxed/simple;
	bh=CSTWBF0uChfkL8RuDOkaqxQ5+hTDzilT5Qa4vQe3FVM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bmdkEU+eHQzJyeGINOOgi1TbhFyRqpFGuDi+oQOjSO+T60/j+2hECnDXQrtwpWLAlrI+AGPHNVrbgcjU1ZfMLf/TtPa17QeA6SS5iZYALSIhJutfo3SAQRGisSci1vMvrsDRWdgTH+n69e6A6ijqjI6PpSVthFqkxIVglEXXU0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nWaTlSgA; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I51kA+qBLArP1p0hO9RLqU9mT4gkMRat87KwdXgfr+I8XVaOReh/GQaenBYV1IsRe3LXmXUtxc4FuW1zdizFokL0i4Ad00U9ciwcLVp1aaF9Ro7QotlrGLN8C/lZi8gQ+JEFiPL3iLbKOcd5JGowxqRHnqyBGCsttNPaferuIHFJtPpW2XIPzyL/Xow2kEG/xe84+1743VGc86Ogj+IoaCR23h1ODDILbELfzD24ZxmVIn0w1LNqKr6KR8DfyHyLgoGcSPtSGbA8KPdcbXOFvrAX6xzIIuB3zOOwxkEVHdlsL3gHiKlgP1dvkdCmFUeOVKAmc3IY7S+vqDg3iozCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ABqzL03q5IJFHO8JGpUvjQacJcDqjFg8RF6X+swTOw=;
 b=HIbVUktUIv0gtf09hhxD7C6nRJJUzlvtcx5xvaQmvuMKrkGxBKHueCmujMchOYCYyT9gU0+niWkp2fpoVRg8KCrJgQpfigEgU5vpopeHMg8TNKoEem/YK0AWwk3e/JP/7Z6HftfTVJQqIUT0J/9V0CaNfJZASqVbmcYLh8X+XNktzxW2wUb5iqOTHZMh9qAsse1SYMajp20DMyC50J90OGrqFkudzS8FLPZYsN+4GdMezD7Kfbo/oB+vGVfRI8rs6Bg3WRb9YPmx3Wf1u7n43pl2d7LN8MBuffkZcUotgnPv8cw/p6p/qq8gw5oeXxCkfG8pRLjZ8AWKgWH1Z2DZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ABqzL03q5IJFHO8JGpUvjQacJcDqjFg8RF6X+swTOw=;
 b=nWaTlSgAhUCzJ6/SHdq9js98WC+3vJ8y65KUeKbi7b5KHinxKK2iFFGS0+dlMm9ho/paw91glByWebSbK8WFgSAJL9hyps4+onW7ji0av7Wr/uYPvGofHkB/zbovGdtSUVUmJU3h0ZauVMDR6qYulRZUQgfXOT1fvxCQgikyOGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 15:59:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 15:59:24 +0000
Message-ID: <ed72f369-bc74-44d8-9cce-34aa125176fa@amd.com>
Date: Mon, 13 Jan 2025 09:59:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: video: Fix random crashes due to bad kfree
From: Mario Limonciello <mario.limonciello@amd.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 regressions@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Borislav Petkov <bp@alien8.de>
References: <Z2yQvTyg_MWwrlj3@debian.local>
 <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
 <Z2yw_eJwR5ih1Npr@debian.local>
 <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
 <Z4K_oQL7eA9Owkbs@debian.local>
 <c6e622b2-64e4-41cf-acfb-31ae493571d2@amd.com>
Content-Language: en-US
In-Reply-To: <c6e622b2-64e4-41cf-acfb-31ae493571d2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:806:d2::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c35e29-4c76-4573-badb-08dd33eb3ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFR6eFpQRFlySjdxcmRmZU9QTnVpNWJiWkh5SWRzKzNKY2FJQnJ6WGlkS1E3?=
 =?utf-8?B?WDIvRkxadjhwSEJsbDF4QlMxR3hERzZrUU9hbXU1UVFRMHBtR3dabUU2Z2ZE?=
 =?utf-8?B?K1R6OE1ONzl2WlNTbmJ6WExqYlkxTmRyWUhEbnBieGM3WUhwQ2ZoYkVaeHh0?=
 =?utf-8?B?YkdiYkUwa3Fyb1hyN3o1aGxCeHFDbVBOcmppd3ozTE0vc1FnTTU3aVdIYTEw?=
 =?utf-8?B?Z3h2cSs0MFhvbkVIYnd6TXF4RklyRFNYWmZobkRRQ1hpU2h5STM4alV6eFNa?=
 =?utf-8?B?Tkc4eEp5SU9WYWQxS0QyU2ozcVZhQ0dLMUV3L1ZYd3dITUNsUGs3NVgySWxN?=
 =?utf-8?B?bzl3OFV4QUN1NVV6d2o4K2t1UDJ1NjBuZkVQVlNoZUxmLzRMSFExUjdXV2V4?=
 =?utf-8?B?Zkg4YzN4ZzkwTFRqYmw2cUVpdnprMkFRTFlaeWl2Sm9FQkZxODhVZnhIZjlr?=
 =?utf-8?B?Yjl4MXR5eWtlcGFGaDhuZUp3bTVIQ21Ba3dxRkoxd3k5MDM5NmR1N0FXRGJP?=
 =?utf-8?B?aHd6dGFVQTF2RXE3QzZiNFJvL0x1V1VIR1ZJbEtLTy9KTkZMRUt3UVhBaytB?=
 =?utf-8?B?TFR0QzE3enRFeWhOdnZpWGpuYk5zRHhrUEtMWnd4RENhdXVVZHFVSWoydVo5?=
 =?utf-8?B?d3N5bnJKL3IzNHMwRnEvTk4xSXplMWw0QlFtYmlHejh5eE5zWlYxeWVibEkw?=
 =?utf-8?B?cldUMUZPTHAzR2theFdCUHRGRE1vVUYwS25wMk1reG13QWRvaVRFYzVMTktC?=
 =?utf-8?B?R1JPMjgvTUlsa2NrblJvN0VHM01LV3k0TXVUM3ZTMlVWTUNNTnZxM2Z2MWlU?=
 =?utf-8?B?RTRZK1YwSFhQWHhMUStXK0l1U2FOOHdRNTk3Uk9aRHM1Ym1UWXhIMzRydXNM?=
 =?utf-8?B?cmFMNWNYTEpQcWlKNTQ3RFErVnFiTHJZWFNEdzR2NW9HclQyZG96VVhCc3NV?=
 =?utf-8?B?UnhSTDRjbUIvb2huVEgrTlVBRXFQQm91enB0R2ZPT1ErY21XaG16TVIycENh?=
 =?utf-8?B?WDhDdGVVeGZjQnZmY1I5dnZPN3ZFZndLTFhvSlE5NVVqRkt2eEoybDZsRVJs?=
 =?utf-8?B?K2VTWm5mMDArdHBjS3plSjh6UitGWkVTdjVTVndBYzZ3RlRZbndYNXpWUEJJ?=
 =?utf-8?B?SUNyME8rbVZZWkpFUGQ3dTNMTDBxUmI5b1lSdFNCSjZMS3hGSThxYVJtbWF1?=
 =?utf-8?B?Z2tKMFZZV1FuL09JSEJrSVVvYWFTODBKM3ZJaUJyeUNmN2I5RjZoRG5CbCtr?=
 =?utf-8?B?VnBkNEdwV2lnRHpJTEVwKzRERkFrOGNpSXZUUUlWVVI5Y3lCbXplbzhCaDQr?=
 =?utf-8?B?MkJnaDNzRTJRQXA0ajlmUVJudmFiLzI3dkowVE80akoxNGYwWmpROGVPWm9T?=
 =?utf-8?B?MVBJcDd2RU9PVUJ0RjQvY00ycXFaSDhYNVVSa2VCUkNjUVpIQ2hjK0ZKbFA0?=
 =?utf-8?B?cTJRTzVUYTVBT1hIN2xSMG16ZFpBRkVNODVyZ3A1YURKZ3BrNGdpNUZUKytJ?=
 =?utf-8?B?bXhUMk1ZRVNOaDdaNysvUXlTdXFQZUtpeFZibkI4Y1dXb0F1SG5kVjZwa2FR?=
 =?utf-8?B?VU1DeDRDM1RuWkpzUVhqa3B2aTRJZVV6L1NScXJYc212ZFk3TDBucG9XdHo2?=
 =?utf-8?B?NWN5MGJ6d2NobE5FbklJQXVpRDE4bzBVbm1qV1dpL0pMVmwvZ1BZb3ZIU0do?=
 =?utf-8?B?aExEQkFvUkZQaTJTT1RrSVBlVFJkUEFvVXBUTGg2d3RodjhiRzhhQTdzM1ha?=
 =?utf-8?B?NkNpYmN1cnNwWDd4Ykg0bVVGeEhvVCtLNjh2MEdJSHdzRWo2Z2w0OHFVRFVy?=
 =?utf-8?B?VGIray90N3ZmOCtvbzJXUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjJ2YVNpN3VOTVZiU3VJTkhMdnBtM0t1Y1JnZmh6WCtVaVMzVmlrYit4RytN?=
 =?utf-8?B?SmZ3LzhiS25uREEwSExhY1VsQ3RLUmNpcnNWUllsWGVRSnFuOGh2YXEzaWZq?=
 =?utf-8?B?dHNhOFVqTmZ5bmtFd2F3cmNKeGJQUzVBbEZLY1pKMFdaVm1xaHN6eHZrMzky?=
 =?utf-8?B?cTdNQlI3Z2JyaDhXNTVFRjdjTHlUdzV3ZXBOV09oUlo0YThZaXhFeUcwNk9K?=
 =?utf-8?B?VytQOGZGNzYxUUtGTkNrdWhKK0Q5U2FUS0h0cDJabWNHbVhhMGtQTS9aU3Vq?=
 =?utf-8?B?Rm1xOHJCcG1lQXJlVUEyUGRBbEZudFY4cC9sN1lWOEZrVCtES21US0FuVVps?=
 =?utf-8?B?VW1sL29VaG1selRvd2RObENpUVhuL3h5MGlsdEp6eEUxS21zMFJDeU1RL0tY?=
 =?utf-8?B?L3c2cFNHaGZpaktvS3dRZ2NqenlhaE41VFdPY3h6UERYTDNMKzJzS2toeEJO?=
 =?utf-8?B?RStFVlJFRWFvc2NYdTFyUDJlelVXVVZWcllZcDBzL1ZSTyt0SkpBM2Z0cXFT?=
 =?utf-8?B?K090K2RQT3VaRFVZMEsvME0wekhwaHZ6V3pVNitCSENmZnIrcDFlcWZQemhK?=
 =?utf-8?B?M1ZHUldKNk8yL1JYWFBBVGlpTnVxOGJnemZSOTB6cDF5L2EzMGlPb1lzTE16?=
 =?utf-8?B?d2VvZE1zTUZjdVZXY0txYWlsL0hRNmt1QW5aTUE0V0lQdEUzbVV3NVk2ZDZx?=
 =?utf-8?B?bGpsV3JneHdXYWp2d1lDZG5wd3ExZGNVK3dxV3MwQXg1czJEcHE0YndWNmZj?=
 =?utf-8?B?Tlh6REM0Z3R2U1RYVVFLSmRBS0twa3ZiSjd3NUkycFRFTGU5RmlpbUViQnM5?=
 =?utf-8?B?bVAzOWxaMVdrWkdQRmNJdklIK3YwdVBwcFdodGF6Ty9Obk5ia2M5NnFmQThJ?=
 =?utf-8?B?eFdrczRsd2tjcEV2ZnpWQ0FTNzRaWmk3VGYyZGNKc2pHRXhqZ3BUTzlDMGtn?=
 =?utf-8?B?anRhZzNvUm9GdCsxajRRaTQ2eEdBU3RZQXA4Sjk4b01iUUxrVkQ2eGxqQ3hz?=
 =?utf-8?B?bUw4SzNKMjFlbmVIR3ZTOWM4MWw2c0M3VlVyNDQ4LzRBandiNGlCdEJyK3k2?=
 =?utf-8?B?bTIzNGdyOEtOdDVYOEFWNFZFUk9sMk9wMmtzTXU1WlhiQ002WkdmVVVVb0N0?=
 =?utf-8?B?UlB6QWc3RmlNcVpxL0p3alBNb3RaUHB1ckRwT3Flb0tTTUlBM2Zvd3VKaERh?=
 =?utf-8?B?SWhmWi82YVJHRE1RRkx1Q2FUbHdLUjVuOCtXM1FZaXJOdW5tZmZadUZqSFBx?=
 =?utf-8?B?QTdsZUJUY1QyOVl6VWJ0UnU5amlPdUVNL2p5V1h4aTFpQ0c0VDdUZmNWY0FE?=
 =?utf-8?B?bUFWa2RLajVxbGkwemlUTTB6bEs4WHIxKzNsUWUxQnh4V3dGamxvUjJMblVV?=
 =?utf-8?B?Qzg0eGhOZ2l4bDRIejFVWHBnc2ZwZ2FUV3JGaGhiREttYlhkSjhha3h3WHph?=
 =?utf-8?B?dUU1Qzdmc3BMUWNoV2xOSUEvMk1kSU5KYWdtbUVKTDBibHd1S2dRM3ArUDh5?=
 =?utf-8?B?RWRZUWkrSmk2WXVmRlZWS0RhQjR2Vm05ckxKeFA4OEdZb0xLVWQ3Q01GeGxZ?=
 =?utf-8?B?ZjFFa2dtOVcvWjBLREZMWmgzUUtjeVVweTB1cFBSSlh4cEJqWXpya1RLSHpx?=
 =?utf-8?B?S0E0czB1cGRvRDg1YllpQTdpRXBRWk13Rkx6WHdvVDBZa3A0WEw5TUY1N21v?=
 =?utf-8?B?UXI4aVVNcU9XSzRnaFdXTG9hRXY2aytKNERuWXovUnVSODN4Qjg4QTZiMk5v?=
 =?utf-8?B?bVI4NmJXdkhOOUxLSDVUV09sem51WU83YzZwY0xmT2hDZTdlSHlYMkphZ05l?=
 =?utf-8?B?N2w5RjdrVWR4R2xhSGU3VjVoblZ6NkRWWWJOdU1nQm9NZ0FveVRxa2RQUUdD?=
 =?utf-8?B?VnhOZU1lSjBTQ094aGxOdnNpaGpOVjc3NEtRU2xVQW5TbEpRT2xMd1hwNG1K?=
 =?utf-8?B?SkJKKzExakRjZVAyZERSVHkxRTFUUzNIVDBERkI0RTdNTEpkaStpVmpWb0tY?=
 =?utf-8?B?RWd2RCtoRTJ5Uk9jTm5NQ2x4WTF6VHZGWHQyOHJleHc0eVQ4amhZM2NvQThq?=
 =?utf-8?B?a0hUOGNOcGxJYmhPS3Z0d0dlVnJJV3pYOHNGeS8vSnB0Z3IrSEVKSWl4ZlVR?=
 =?utf-8?Q?/Tvzx8bphES4feZhbyb3zTGt8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c35e29-4c76-4573-badb-08dd33eb3ffb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:59:24.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxiufaHczsxeiJH9cQnuf0ul1qSs2tiWUhkqzDpdILKGSZ9aJWhALbJxinjQG8LvS2Gt+AForNMb0mmgnEhI1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819

On 1/13/2025 08:19, Mario Limonciello wrote:
> On 1/11/2025 12:59, Chris Bainbridge wrote:
>> Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
>> available for eDP") added function dm_helpers_probe_acpi_edid, which
>> fetches the EDID from the BIOS by calling acpi_video_get_edid.
>> acpi_video_get_edid returns a pointer to the EDID, but this pointer does
>> not originate from kmalloc - it is actually the internal "pointer" field
>> from an acpi_buffer struct (which did come from kmalloc).
>> dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
>> resulting in memory corruption which leads to random, intermittent
>> crashes (e.g. 4% of boots will fail with some Oops).
>>
>> Fix this by allocating a new array (which can be safely freed) for the
>> EDID data, and correctly freeing the acpi_buffer pointer.
>>
>> The only other caller of acpi_video_get_edid is nouveau_acpi_edid:
>> remove the extraneous kmemdup here as the EDID data is now copied in
>> acpi_video_device_EDID.
>>
>> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
>> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if 
>> available for eDP")
> 
> Two minor documentation related comments to consider, otherwise I think 
> the code change looks good.  Feel free to include:
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

A few more tags to collate from another thread:

Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Closes: 
https://lore.kernel.org/amd-gfx/20250110175252.GBZ4FedNKqmBRaY4T3@fat_crate.local/T/#m324a23eb4c4c32fa7e89e31f8ba96c781e496fb1
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

> 
>> ---
>> Changes in v2:
>>     - check kmemdup() return value
>>     - move buffer management into acpi_video_device_EDID()
>>     - return actual length value of buffer
>> ---
>>   drivers/acpi/acpi_video.c              | 50 ++++++++++++++------------
>>   drivers/gpu/drm/nouveau/nouveau_acpi.c |  2 +-
>>   2 files changed, 29 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>> index 8274a17872ed..3c627bdf2d1b 100644
>> --- a/drivers/acpi/acpi_video.c
>> +++ b/drivers/acpi/acpi_video.c
>> @@ -610,16 +610,29 @@ acpi_video_device_lcd_get_level_current(struct 
>> acpi_video_device *device,
>>       return 0;
>>   }
>> +/*
>> + *  Arg:
> 
> As you've pretty much written kernel doc, us it better to just make this 
> proper kerneldoc (IE use /**)?
> 
>> + *    device    : video output device (LCD, CRT, ..)
>> + *    edid    : address for returned EDID pointer
>> + *    length  : _DDC length to request (must be a multiple of 128)
>> + *
>> + *  Return Value:
>> + *    Length of EDID (positive value) or error (negative value)
>> + *
>> + *  Get EDID from ACPI _DDC. On success, a pointer to the EDID data 
>> is written
>> + *  to the edid address, and the length of the EDID is returned. The 
>> caller is
> 
> Since 'EDID' and 'edid' mean different things in the context of this 
> description for the purpose of clarity I think it would be better to say 
> "the edid pointer address".
> 
>> + *  responsible for freeing the edid pointer.
>> + */
>> +
>>   static int
>> -acpi_video_device_EDID(struct acpi_video_device *device,
>> -               union acpi_object **edid, int length)
>> +acpi_video_device_EDID(struct acpi_video_device *device, void **edid, 
>> int length)
>>   {
>> -    int status;
>> +    acpi_status status;
>>       struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>>       union acpi_object *obj;
>>       union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>>       struct acpi_object_list args = { 1, &arg0 };
>> -
>> +    int ret;
>>       *edid = NULL;
>> @@ -636,16 +649,17 @@ acpi_video_device_EDID(struct acpi_video_device 
>> *device,
>>       obj = buffer.pointer;
>> -    if (obj && obj->type == ACPI_TYPE_BUFFER)
>> -        *edid = obj;
>> -    else {
>> +    if (obj && obj->type == ACPI_TYPE_BUFFER) {
>> +        *edid = kmemdup(obj->buffer.pointer, obj->buffer.length, 
>> GFP_KERNEL);
>> +        ret = *edid ? obj->buffer.length : -ENOMEM;
>> +    } else {
>>           acpi_handle_debug(device->dev->handle,
>>                    "Invalid _DDC data for length %d\n", length);
>> -        status = -EFAULT;
>> -        kfree(obj);
>> +        ret = -EFAULT;
>>       }
>> -    return status;
>> +    kfree(obj);
>> +    return ret;
>>   }
>>   /* bus */
>> @@ -1435,9 +1449,7 @@ int acpi_video_get_edid(struct acpi_device 
>> *device, int type, int device_id,
>>   {
>>       struct acpi_video_bus *video;
>>       struct acpi_video_device *video_device;
>> -    union acpi_object *buffer = NULL;
>> -    acpi_status status;
>> -    int i, length;
>> +    int i, length, ret;
>>       if (!device || !acpi_driver_data(device))
>>           return -EINVAL;
>> @@ -1477,16 +1489,10 @@ int acpi_video_get_edid(struct acpi_device 
>> *device, int type, int device_id,
>>           }
>>           for (length = 512; length > 0; length -= 128) {
>> -            status = acpi_video_device_EDID(video_device, &buffer,
>> -                            length);
>> -            if (ACPI_SUCCESS(status))
>> -                break;
>> +            ret = acpi_video_device_EDID(video_device, edid, length);
>> +            if (ret > 0)
>> +                return ret;
>>           }
>> -        if (!length)
>> -            continue;
>> -
>> -        *edid = buffer->buffer.pointer;
>> -        return length;
>>       }
>>       return -ENODEV;
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/ 
>> nouveau/nouveau_acpi.c
>> index 8f0c69aad248..21b56cc7605c 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
>> @@ -384,7 +384,7 @@ nouveau_acpi_edid(struct drm_device *dev, struct 
>> drm_connector *connector)
>>       if (ret < 0)
>>           return NULL;
>> -    return kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
>> +    return edid;
>>   }
>>   bool nouveau_acpi_video_backlight_use_native(void)
> 


