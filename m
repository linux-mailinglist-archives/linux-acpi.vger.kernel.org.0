Return-Path: <linux-acpi+bounces-20815-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBSoJEeAgGnE8wIAu9opvQ
	(envelope-from <linux-acpi+bounces-20815-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 11:45:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E98DCB297
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 11:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C519307B0AD
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Feb 2026 10:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539953570AC;
	Mon,  2 Feb 2026 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P6dYQzSj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2F2C15B5;
	Mon,  2 Feb 2026 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028651; cv=fail; b=Uo+qpq8FImep4kjk/V4d/hRS0XVF7OEKFTwfXwaty3wI75sVIGzDeaP1nCVRi/NLd1CdnY1bwQYR/8Ex7iG00ykOcirLfviE5YpstqY7SemejJjd9y+yiucx1vHS58iALI2hROs/XnHz1uvbv+v3gljXVPjIeArGoFS3yTmSQyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028651; c=relaxed/simple;
	bh=3cRhKtlQyQSLUyZ5PIylGJf1eLrxAJUPwDMd//V4MLM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvLiP6jbVtRF7MxghS7Ea4Yn6F69OKwst0+Cm7V+AubctzkHDtvBiiNTNJUIOPi/pymK9x2D5CHjLwzT4lYrJmsN7S26AQPBl1fHKArDZrRweGwxml+BxtNsB1wPIn2eyxQm5pnvfzzkLlAxs/qvBX9o8RnGMrAd7cHQnglr4rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P6dYQzSj; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGbbugoRZ3Bs8jWo7ugiT+zJjJLFPshUCNvtWOc4VodD3z/UXNOidswg6WhDQOxKuUWI5gSGpD0Tta3pFV/n0L03DrENXgKGbcjXXTWTgefKEMa+J8EeJRSZBmCnKms41imhocOcwExFndRVNxe+gYUR5BnJ1mjViujKFgG5Ms+gFFfHXmz5/UXK/m4gYDDnhx0Bedk3PA8uYFSDvEKM3eWhz1JQIwaKg1wHpFf1FAl9yrVSExvSN02ixIc0ltuTUxy3YkRKj7ohD0dHgaGBFGW31AHEeguZd/eCoChHcY1P12lPuhj1aryLFTF2cjxp5j/L9jtwpOHZpU8MEhL4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3/MbYweNFvYR9KpCdZHux7EJ77fgZU7kU7erAflfNs=;
 b=amFyrFIXKQ0Xo3XcplZxQGefmx5SSQ77Rtx+k446JTtjBv2Sn/iW6ZWDvufQHn30bHlu/XKxLWRVOSvIMiMePVDu/1mKW5ewE6MxLk1hfrPF3qEH4WY/NBZWhMCMRTlLZvqohCdONfUNJ7/3C/O9S45TVYRBt0kOUoOvH5cwiqCxBkY932yKst2JP1wIZKI8y1VU7UPmk48/ctaFFxseLSAhUUJftqK63gT5WJapoN8bD1dOoNz5e6DTfXXLxl5z4dJ5uh270HY6dlcQgBnstjyMAgHwBEjHRHJQcjURuD6DE7naAlwm0V6SUUmfv5et9AkbCSUL83jAD4i0VEnJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3/MbYweNFvYR9KpCdZHux7EJ77fgZU7kU7erAflfNs=;
 b=P6dYQzSjotoeK17bnyuEe9QmHP54DWfVqrbyYxzMUodWg80AG+AmP/GruvkyFWDBCfch3Mc2x7THIvJhX0gkwzr4F4MmYe2OTapgbnDnWbspAXWInAOHEzyh4Hrzaeyzxi+2/sldzd3Qhzl0aXLXVY1yOqF3iGJAqwNJCmmCNPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 10:37:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 10:37:25 +0000
Message-ID: <1331d331-7056-4a32-a69d-e4556bb117b0@amd.com>
Date: Mon, 2 Feb 2026 11:37:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: crash during resume of PCIe bridge from v5.17 to next-20260130
 (v5.16 works)
To: Thomas Gleixner <tglx@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
 linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, Mario Limonciello
 <mario.limonciello@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 regressions@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev,
 Robert Moore <robert.moore@intel.com>, Saket Dumbre
 <saket.dumbre@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Clemens Ladisch <clemens@ladisch.de>, Jinchao Wang
 <wangjinchao600@gmail.com>, Yury Norov <yury.norov@gmail.com>,
 Anna Schumaker <anna.schumaker@oracle.com>, Baoquan He <bhe@redhat.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Young <dyoung@redhat.com>,
 Doug Anderson <dianders@chromium.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Helge Deller <deller@gmx.de>,
 Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joanthan Cameron <Jonathan.Cameron@huawei.com>,
 Joel Granados <joel.granados@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, Kees Cook <kees@kernel.org>,
 Li Huafei <lihuafei1@huawei.com>, "Luck, Tony" <tony.luck@intel.com>,
 Luo Gengkun <luogengkun@huaweicloud.com>,
 Max Kellermann <max.kellermann@ionos.com>, Nam Cao <namcao@linutronix.de>,
 oushixiong <oushixiong@kylinos.cn>, Petr Mladek <pmladek@suse.com>,
 Qianqiang Liu <qianqiang.liu@163.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Tejun Heo <tj@kernel.org>,
 Thomas Zimemrmann <tzimmermann@suse.de>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Ville Syrjala <ville.syrjala@linux.intel.com>,
 Vivek Goyal <vgoyal@redhat.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, W_Armin@gmx.de
References: <20260113094129.3357-1-spasswolf@web.de> <87h5spk01t.ffs@tglx>
 <bc20529d7520e7db7de2022bf9c96a1bc3a2f0df.camel@web.de> <87v7h5ia3d.ffs@tglx>
 <99f1aaba32030d2b9285dbd983fdf8518a181a8d.camel@web.de>
 <82b4d69a5b943aa5e8aa7cc33fcc00bce02e557c.camel@web.de>
 <630a4020c87c122c004321971e43c334fd7aceb4.camel@web.de> <87a4xs2z6i.ffs@tglx>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <87a4xs2z6i.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0377.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: c21a52c9-5b96-4f83-9839-08de62470dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zml1a0oraTRydlR3a1Nzd2pxcE4xUS9NNlJ5UFN5dDcwQWZrV3lvWnhYMHZr?=
 =?utf-8?B?OHJxZzRnL3dwTy9UR0R3eUoyQjBpb3hxKzNHQ2UrMDI1c0FzcTJoK21nT2tZ?=
 =?utf-8?B?V2NiSURHTHY4T3JBMFIxajhKOGppd0VtSDJGclBrOU5OT2xzTVZYallGanE2?=
 =?utf-8?B?NGZJMkJpL1JSVm9TSEtYSW0wOWpWS0l1cEdkMTFjeGxqM2cvaDZiWFovR05K?=
 =?utf-8?B?dTdIL29IRjNMRm1QU2VXMitmMFMvb3A2OEZXTXMzOW11a2pzRGE5VHpSWGxs?=
 =?utf-8?B?ZVBEMXR3Z04zeERSbGNFTEtvUjF0WjBlSGZ5ODc5T1ZIYU80ZUdZZ1ZmTUQ4?=
 =?utf-8?B?YjRaZVJpcElVY0R3a3ZjMFNwbjMvUE5VNjh1czZzWE05S29kSVlJU2pSSzdT?=
 =?utf-8?B?UTYrNWhvT0NuSkhmSHhRZE1DNzMzeHZUVmN3Njc5WGx6K25kZDZQSXg5eXlF?=
 =?utf-8?B?VVlKcFBMdDJFbHlGcG00K1NGUjRZWWtEODVVZm5GOEd5K0d5dGtSYStla1l3?=
 =?utf-8?B?Y2NZL1NYZ2IxWmFSWlRWZEpBZE5VcGw0cDBUOSs0dWhVUEMyZTZlaEVWRkVw?=
 =?utf-8?B?S05qdnl1elY2Z2Y5VDZqOFdVRUxudFA2K1hPQnYrVjBuZWxBUDJzUmxQQnZl?=
 =?utf-8?B?RjVaWnJyVHd4aHlaZnVUVE9hZW9PaXgwV0hkVGg1amR0bFcyL2NBalRPSHRo?=
 =?utf-8?B?MzluLzBZN1hwWngvaXRYL0pJdXdhVk9ENGs1TzkrMS9zVzNrbVl1WEdPeDNh?=
 =?utf-8?B?VVgyaXJrR0xHemRHYUgrbUo5alJRMlBtVkRQd1dTY29ncmpoVmNsaXRGbGlN?=
 =?utf-8?B?a2llUk5BUEp1UTJOb3BOb3B0ODE0OFdjU2lCWFZ3SDU3bzBkekRYK1NwOWpG?=
 =?utf-8?B?MVhtV0FHZzgvSTZxWkI5djVPMlZNZ2FFZVZJQzVJc3UwY3BVbXVIamg0VEFy?=
 =?utf-8?B?SFZSMU9kQlNUMVBDbE8zM1MwNDBHWXdpZ3cvVm4zSGdEWk5BWThpWUFhenUz?=
 =?utf-8?B?MHhYZUJoQlp2bVRkTFRKdk1GTlNlcDVQcUVZL2NQYnlSbWQyT3B6RzM2d3BG?=
 =?utf-8?B?Q1ZMSUlDbnF0QUh1aVJ0UWRrRE5yT0x3WkZzMW5iYkdabEhKa0FWMytHaTIw?=
 =?utf-8?B?amJOZmhPY0FHRFVqOS9sbWJYajAwRU80c0N0bmk4ODZVY1JWNDZwRlBRRE4z?=
 =?utf-8?B?NkwzMHVRS0NvLzcvdHpZamxsc1NjU0E0b1hTeGdES2J1T3ozL2lZQWc5djVI?=
 =?utf-8?B?dkdHR0dCQVNscXJ6ODR0MzR5RkJ2cjlML2xHZExJallXbG5vb245SjNtcHRo?=
 =?utf-8?B?S3FuN0hmNFhmdFVJT3RTcGZyL3NtS1FLZWplZ2prbCtjVWdhaHp1ZVoxcVMz?=
 =?utf-8?B?NWZtbEZUUzZFOEt4NXd6bGt3c05oRUtjcURvR1RXTWJnbGczNWVXdUNGZjYy?=
 =?utf-8?B?Mk9VQ3RHWFQxYmZTNW5kZWI4V2dJOE1yTkFLL0p2T1d6R001NkozK3krb2Jv?=
 =?utf-8?B?RzJqNExrN2N2NWhjdjhkVVZacDBPVGc5UmJrUHh5SjY0WENjMXdBcitLSXpY?=
 =?utf-8?B?NkdKRG56aEdVN3JKNlpOcDVDUXVIY3F2Z3ZEL1hPV1BWMGtFMzg0WTZ4YjZW?=
 =?utf-8?B?a05yK1hXSHRrOHVUZ1NvdlJHV2haZWZLaEtCcnFXWTMvRXQ5b0w2dlRtNS85?=
 =?utf-8?B?blNoUFRvVnNsMzh5RnFOVFRuRFRCakV4dkZ4ZnlQV1RZbVNMZXcyNldaanBk?=
 =?utf-8?B?T0pBZVVyU0I0VzRvQjRydFJ5WkRqWThDUGxZL3ZiLzZIZTFmejIwbzVwMDhi?=
 =?utf-8?B?U21SVzNvVXBld1JFSm9wK3FMV0psRTJkclkvaWlnOGZrekdoZUtwOC9tZFMx?=
 =?utf-8?B?dm0zbUp3YTh6QkNrZ2xrS2NJUURvRHpyMFBCU1Z6WlVoNDZ6Q2hEY2phd3RO?=
 =?utf-8?B?c3JGVlZzZE5KVktXS1Q5TVBPdnozSlFDM0huQVdreCt5MElHcU5Td09hN3BI?=
 =?utf-8?B?cUx2VC9uUXNWRklBVnBSWkFBUUJ4WUtuRFhqbDB0NGlzdU5qenRjSTVDdU5P?=
 =?utf-8?B?SENvRlNmbG5VcjZRdXBsdVMrd3NsRlRVQ0dZQ3IwQ1hSWGM2ZWtFYzZpcnVJ?=
 =?utf-8?Q?f++k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnk4NnJNV3FtT1NnTjdpdXJkUU1lWWFlN1l6N0RyYUNDYjNYYlJOM3B3a0Rs?=
 =?utf-8?B?V29tRXZUVVRoVXVJdkM4aTRLeDM4aTFnSkRCNndoRFF5M2dDQ3E5TmhYV05E?=
 =?utf-8?B?bXVYR1ZQWEZOczNlWnFrZjNYSm04OUVvbVJhSFAzL3RHTlo3RWkzUnJ3TDVp?=
 =?utf-8?B?em5jNENibS9heHBURDRvMTU4Z0NKVnlmZVpPNWcxby92MkFJOVU3RmhsWTAz?=
 =?utf-8?B?ZjZXYVpGZnBHd2xHeVo4Uk85ZVlmd0ErTlZDYXNQSnF6WkRFSzkxOUpFQ01x?=
 =?utf-8?B?U2Q3Qzh6RjQ0STJ1RVU3dVlYdGorZGwwWmp2QjAxY3pWTTRNc0JxVTJJNk8z?=
 =?utf-8?B?OHJNUlEyRHF6SlNkdStaZkZib0owdXJtbElUTXVZemdaOUttY2dXSnAyMGc1?=
 =?utf-8?B?S1ROYjIyd25wR01FMnk0SWRwZ2Zydm1NeERUS3AxRk1zaTJ2UC8zZFZiZ2pQ?=
 =?utf-8?B?Ym9Uc3J6RkcrdFZReGgxQlVTc2RIS0NQdHVSckFYQnBIeENCN1BjdS91SXR5?=
 =?utf-8?B?eVlpdlpqSXpIVDRBMk9taUVLVXJ0aGowU2ZhalBNOWRhY1AyS2RSR1Z3cVlR?=
 =?utf-8?B?OFRwWUZHTjg2Q1hCK05zVnlwZGNBTFFIcnF5dUs1MmRROGt3V090cS9lZUZz?=
 =?utf-8?B?VlJPQ0w3WmRIdWFCV3ZrL0xEcEJwUlVMOTlacmRaZ3dGbHc1bFVuNzZHWGlk?=
 =?utf-8?B?TEpKdEtocXhiOXN6VFQxeHBMTXk5NWlkUS9wVVZsSkQ3N0o0WUR6Z0ZYM210?=
 =?utf-8?B?T3d5SXNjdzVjVkQ2K3VIVzVVWWpWR2s0WFN4cDFnSFkybnovSXZaNUI0NHVB?=
 =?utf-8?B?WEtPYk9lOTMxOTR3dUo0OG95aG94LzgzOFY1MHc4NmpUSndGSzRpTFZxM1B3?=
 =?utf-8?B?VWhhc0E5STFLc3JGWDMxU1dUSjBQUmxQRzlqRCsrVU1zbU5nV0ZwckFkbkhE?=
 =?utf-8?B?SU1oQWZTdTVMQ0FHbmdrQXF1QVhyZzZIZnVDbDZWQ2J0RFhXKzBPWWorbFI4?=
 =?utf-8?B?TkFwRzhuQ3phSE42cnQwdzFFam1OcGxZeGc0SWM3b1F5ZlVHd0Q5Q3Zxa3Yv?=
 =?utf-8?B?akI1NkdUSWRpZFo1UGZIcFE0OTIvSGFWdTJpSDVPdE9zeERDVmdSbnh5UVRw?=
 =?utf-8?B?ankrdit1d2thb1JGcFQ2akRqblY4dWRNVUVFNW1YMm41T1FYMTcwREJpdDli?=
 =?utf-8?B?UHFzZHdjdXhsTTV0Z3FEUGhyNTB3R1ZXd0VndUdOUDFSWnpmTWs3bEgvdlFW?=
 =?utf-8?B?eVdtOWhadHE1TitqVmlYQW5WV3BBT0tLT3BQbTloZXdtSDdjRjhENHNRQ0Z0?=
 =?utf-8?B?YW15ZDN6RFdlTm5YQW5TM2wwRldMWk1jc0RzOTNGUlpQWEZOUWpHbFVCQ29G?=
 =?utf-8?B?OVExRGlGeXNFZnRsVzFTdVJ4eHVEMXYxaFExbklLY04zemxJSkRzczNnSnpj?=
 =?utf-8?B?cHRqeGVSNVd4UGVnSXc2V0p5MzV2VUlIeVpXSGR2Z0xndVBCUlJzUEZrQWli?=
 =?utf-8?B?RWxoUXdZaXVmUWZVeGhyZk1CWlRxZnRrYXdacXhRWjNvYWtGWVFCRWhhMUl1?=
 =?utf-8?B?WVhHSXdqR1c1U2JTUU9WMk9nd3NheldBSHFWZCtENVlFTnQ4cldOTllwWHNJ?=
 =?utf-8?B?bnV0dlNtN0d5UDFUaXN1L1lGTzIyZk9SYkl1VkRrNWJ3WmIxV1N4VDM4MjFJ?=
 =?utf-8?B?YTdnclZNMlQ1U2c1d1RPeEdLRWtvMHgrQzh0VlA2VDJlUXpNemc4WFluWjRE?=
 =?utf-8?B?QmpoRmp1bTFINWwxWjArSDdSenBDM1lQQzlDcU8wbFRwc1lpWVlCVHZWaGph?=
 =?utf-8?B?cEdmK05ocGt4WmZrSkJtd1V4VU1BQ3ErZWl2cmxqcURNVXNsdG1XbGM3dlZk?=
 =?utf-8?B?dm1PNHZGMlZPQ2xjbE5jRjNZd2dSWmxDWXoveVdMcHN6MnQ1MnhtN2ozbTNH?=
 =?utf-8?B?VFpOV2kzcHdNY0ExTEpwWFFoRWJJeTIrTDJHMndwTWR2VHlOcGFWRS9IaGJI?=
 =?utf-8?B?cFJLTE1yejl4UWd2NEVWbDY1OFptUjRiOTdSRXUrRjFwWk82eXAvakppcmlO?=
 =?utf-8?B?KzdDYk8xM0dEbjBlMnJxcEI0Nm9ENENQWDdGRkZpNzhzYThuaGhPTE9WdGlB?=
 =?utf-8?B?WVhMOWVvb1Frb1UrQnRLNXdseGoyam8wanRWM1V1Tyt4UGIxeUxXYVNmcEow?=
 =?utf-8?B?ZnZ6K0FpNURJcFR5WERoaDhaTUxLemJ4dkdLa3BaUnRkRTZtUnM2ZG5HdVJi?=
 =?utf-8?B?UWpTcnI0c05yaVR0VGE3YUVJVzArVmQ2Qm1WZ1NZTTRPNFdyWkdDY1lKaG1W?=
 =?utf-8?Q?6SBtWvOXwgFTcBYGZK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21a52c9-5b96-4f83-9839-08de62470dd1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 10:37:24.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJLUJ5DGoBDfhZzYBfoeJVs8ycBkfmHTKF5eHAIswgTFPCnsZCbjwIcdbNsQOgfM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,linutronix.de,kernel.org,goodmis.org,lists.linux.dev,intel.com,google.com,ladisch.de,gmail.com,oracle.com,redhat.com,chromium.org,igalia.com,gmx.de,ziepe.ca,huawei.com,huaweicloud.com,ionos.com,kylinos.cn,suse.com,163.com,suse.de,linux.dev,linux.intel.com,bytedance.com,linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20815-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,web.de,vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3E98DCB297
X-Rspamd-Action: no action

On 2/1/26 17:42, Thomas Gleixner wrote:
> On Sun, Feb 01 2026 at 01:36, Bert Karwatzki wrote:
>> I found the error, the commit 
>> ("drm/amd: Check if ASPM is enabled from PCIe subsystem")
>> has been applied twice first as cba07cce39ac and a second time
>> as 7294863a6f01 after it had been superseeded by commit
>> 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device") 
>> This effectively disables ASPM globally after the built-in GPU (which does not
>> support ASPM) is probed. This is the reason for the crashes and loss of devices
>> errors which on average occur after ~1000 resumes of the discrete GPU.
> 
> Wow. Nice detective work...

Good catch, indeed.

But it is not clear to me why disabling ASPM causes trouble, usually it is the other way around.

Regards,
Christian.

