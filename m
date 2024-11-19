Return-Path: <linux-acpi+bounces-9652-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58B9D1F1D
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 05:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0025FB220C8
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 04:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189401482ED;
	Tue, 19 Nov 2024 04:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RkyyK0Mw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F12AF0A;
	Tue, 19 Nov 2024 04:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731989396; cv=fail; b=Z2B+ZNofCpdZnzEQHmyhCHjcJVMcLSSOMvAY1R7Vdmu4zg/CddzrcwpISf70fZCst60CTTRNNXAAk8cd2YsDho/nLjZc9XtJQUcdu5z4T/Vh2yIHxBRPgE46kbLiVPVeJIxtBqIbdAh55u2eeRMIvl1qTjqAGa4I9Pfa60jL7PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731989396; c=relaxed/simple;
	bh=CgJnqaUd2VUsO/6cFIzZFif4Kgp/iL2kz6TeYIPeObU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nQxXBHq/30KSESxeDV1Q06z53EActf+dwbf9ia5cINvyJead5tHOvBYhit+YpU7jNsxExPab7ggsLgtEbUCW3/2yh/pP4YXlMDkhwIWsC4s8PHHp86EYMXX6dvXzR8x9GxyRqqkIxNzCMOWW8ewfoOf2laieikQ6xQweR2/MROI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RkyyK0Mw; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NV3VrCmZE6RU6SmCfAkr7Rhbxfcp6zscDOsdWHokoGqLlp4tyeayCM2+R6E2EbC0vfp5OOioBvj5EIm+Nrpfrd6h0DCapu4DpX+KKy+Top8P0DDpUweBOPmFTlpCB8tcssXVuTc+BYvvV9s94ONJtTbo2JiWM6vYJVOF5nSoJTKlfNb6vzpXN2FvoH7kPQCpMXbea1ggYHVQPF9y15904EXSVwSYhXbaFQhNn/VvjCIYrl0Vj8hq14nxK2ctUUClGgdQzHov0EoMKOz3UXVeUKM1mfjpIUo0yPa3EtMOvE96suHgchNUdoPZffEIXyegYVabjXp0sp2n6sEi/qQblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTgwtDVMP1sX6lPAgcmNh/zeYCAQPTSLWBY6kxBpCaw=;
 b=ArGY0uLwBAHDcyr+o9M5htlB4mTZ3VPWxBV+uFpwodQBuCaasAOx9EvviLubazwg2Iz+8W67M3heI+u3PMxEfbpYxre0KDBMj/UgxOJtxHXN/BO+wmeR6JQKq8AezCkcsVifHTx9CCvsOWJH6v09mrIF0qo64FIjJkooEd8RPmO+Zkx4FPTGr8pLTLJOWCdCj8gjBSwD35DNHUKKP8PBz/9x3mB9GwjYrIXkOVQMk7WwWqxIjUSV8xaWKRXMIhd87Kcjv1Bo9GHvZ82/e10Pnvh4pIhIALcmk8l3g/8xS7rzEYxsEO/xvvADfJr5mCoaUZ2sHBjpVpjpqhkionQfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTgwtDVMP1sX6lPAgcmNh/zeYCAQPTSLWBY6kxBpCaw=;
 b=RkyyK0MwY5C1zTrzK6pTnA3QIYcGNLI9QBfOdEHkZu93FYm8pSkgCK6JvFrv1kYNMYe/kJI53/3cmGUbH+Hab2ETalckpsg7a0Yd5UxnST/MX3lZpMNLSocySfxDPHtoskRA1XlU1HxKH7EnqHgwvGzwJDBsTYUgVJOeP+cye0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 04:09:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 04:09:51 +0000
Message-ID: <0ba333c7-6e13-41b1-82ea-588da0161e5e@amd.com>
Date: Mon, 18 Nov 2024 22:09:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/22] ACPI: platform_profile: Add name attribute to
 class interface
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <20241109044151.29804-12-mario.limonciello@amd.com>
 <29899120-efec-4264-b6a8-0bca4fc1f332@gmx.de>
 <6b7d2f80-0dde-4f07-b889-fa2cb99f5c88@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6b7d2f80-0dde-4f07-b889-fa2cb99f5c88@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0127.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a5da5c-6d9d-44b2-8471-08dd085003dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3ozQzltL1E3cjZoSkVCdXR4alU0SEZjZWdMaW5KcjRpcWNaYml4aFQ2VmhL?=
 =?utf-8?B?QllWbWxpQ2lDRjh3RTBWN3I4STBwbDNNUzI4WHVkaXh5WG9LOGk0QTA4d3Bx?=
 =?utf-8?B?Yk5EU29WVTdBS3NDS3doVEpCQzVsQUt1WXpvL0U2RE1RTkNqc05kRzFGR1N4?=
 =?utf-8?B?eXNTL2s0YzRGa1JjV2h3YTg3UEdxeERZNWZ3c0JycVRROGZwTWtkQy9yUkZa?=
 =?utf-8?B?dmZKc1ZZMlFjZVpGZHEyendEdkYxandxYWJ0U1diV3plRWtycCtldElqYlRv?=
 =?utf-8?B?dXlucEZUeEwrMGowVGgxTEk5Tkc0SEJma1owcUFLNmV5Rjl6cExoUmdxY29U?=
 =?utf-8?B?dkErN2RzNXkyMUQzZzBIM3B5Vk96aHF2VlBUcm5qak1SVW9tL3d5TVdMa0px?=
 =?utf-8?B?UU5lR0k5bXNVdjF0ejBQb1RmdmQyZVpqb1V4cVJQQUlhRm0yZTdhelBIZEJ5?=
 =?utf-8?B?L1AxSmhmS2o0c1ZDVGQvcm1zUDY4UHp2RW5uNnpiVmFUZ0l4MTlGbUZCTHgx?=
 =?utf-8?B?QVlnMmZvNFdzV2lwUDhZcnZHMVhuMUFMS3k3eDJTVU5NMGR5TXpZMUdjT3pa?=
 =?utf-8?B?N3dSYy9RSjVCMXFJaEk2UHhEaFU1azN3L1dVd1FJckQ4aVd6V1U5Wkk3a3Rp?=
 =?utf-8?B?SFJoeUtyYkNTR1ZLWE9rVTNiYUtoRHZCa3NDUGUwZ0srUGVVZ0hIcngrdUR0?=
 =?utf-8?B?TWVNckVHbjlibTJjYnI2MjUyWGw3U0Q5b3NuZXBCNFVtMjY2cURFb21YSkw3?=
 =?utf-8?B?MEY1eFpEZlMvZktsbDV1L1RmeHgrUjVCbDlzUkdxRHNiSWtJNWs2K21xRU8y?=
 =?utf-8?B?QUtGYXJ5M3BoS0pWZUJBMFJvTkU5M2FZV2hia1FiOWxWeUZGY01TbnZwa09r?=
 =?utf-8?B?MnNUTHNmNm1ORGJpVzF6WVNLU29acVUwQllvL21SeEZSNHpRbSs1YUNZL3d0?=
 =?utf-8?B?Y2FvL2lSZVk5U0lLOTBFVzJDd21LWFlWVW1PQUNBZkQ0WjFFLzk2Y2NqTW8z?=
 =?utf-8?B?ZWRKUzl5UjBWNFlwNkU5Njl3UDlYL3VPS3F1SzA2OTl6ZlNVaHBxdkh2bm8r?=
 =?utf-8?B?T3JzMWpETUExTnB5bm9wQTk3Z2paNWVVVmZkTDVMcVNUS3l6ZEZRWnp0WWNZ?=
 =?utf-8?B?MzVseVZVVkNOVWdEb0RHZWR5ZUl0cUM2RDZ0WDliYnM5WDJySHM0Y3hZU04x?=
 =?utf-8?B?aFhtZ29kSlJZNVdnTHlMT2dHV1ZrdkNPN1FOZmIxa051TWkzd3UvL3Jnd0Ev?=
 =?utf-8?B?MC9XUlhaUStYUVNoTjFtME11YlBYb0ZyTFAzUDgrRjlEN3NqYlk5VFllUTlh?=
 =?utf-8?B?TzU4RVFPNkJsalFZTTQ3ZXdnODhFdXgxemxWMEVTV3pRaGZWWjRva0d2K3c0?=
 =?utf-8?B?N0E2aUViRW1mdlZNS20ycnJpN2tMNHhUY3pBa2JUcVRIOUsxVks0Nkxucm1M?=
 =?utf-8?B?TkkxbEwvSG5LTUdweTQxb3lwSFRUc3JCTHhsRGtMQk9Xa0FneFR6UFVYSlBU?=
 =?utf-8?B?S1dqd3FVM2l2U2xZZy81VU00QzU1a2J0QlpQQ3J0SzdhMXBDaDBIUGZCdFhV?=
 =?utf-8?B?YWErdUJLenF5d1ZKK2d4ZFJpbGI5cTZ0MHlueVNiVkU0MWU1TVp1UHdnODZs?=
 =?utf-8?B?N3J0YnFVdjVRaXZFWXpGZFhBRnNVZ2N4QlBFZnJjMkRxN05lTTNwdW92NlVI?=
 =?utf-8?B?TU9HZlF6QlNKMmdCakRSbVphU3dMZkdMRzNkdktub2U1QjQvcVdzL0Q4bEdT?=
 =?utf-8?Q?eSaviPdAQd3SHqbds7lASC7DvAOdhmsLZpe+Llt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEM4dTRFYk5sM2RnNnFBa1FrRzRqSFJBZm9IMU9pbjZ1a3dMTVZoMEs2NGo5?=
 =?utf-8?B?WnJTdzgyU2RkR1ZQaEUrcmV3ZFVmVUhWeExUSDZ0bmM4UUlFK0J1cm5kdnVY?=
 =?utf-8?B?cU1WSU85UDdabjlhQ0pEdVNqdlMzUVdHbUo2WVV6ZmRDdDFsVHpoL25WcUhK?=
 =?utf-8?B?NXN4aFF2UnJsOVk3UVNsbGZTTVBtVVJPK0F5VkpOaklSMm51aytqSG9DVTNK?=
 =?utf-8?B?cWNrWkVZZEsxWnY2YjFuSEJnRmlMUnpjM0V0WTR6OEpBTmUraGZ3QXFpWkNH?=
 =?utf-8?B?T3paWjUzSFFsaWt6WWs0MXhSZ0taU3dLQ1B1OGdDcWNBQU83ckMxRnRvUkE2?=
 =?utf-8?B?Yys0RGNQd1lEYTdPWENNSFlYR29pczk2UVRWdXVHYXVTMFFGRThqWlZNN09I?=
 =?utf-8?B?bis3MVRZYXNaT3BTTTdWa3RSV3A3NlNQcHEwS04rVUYrMnF1VUM5MzFpcGxi?=
 =?utf-8?B?cVVRYjdwRlJMYlBkVTdoZDRjYXdXdzZGcytZODYzS2Zrc0JzVmU1RzEwcnhh?=
 =?utf-8?B?dUVvUDUvMVFnSUpoV3dsL2Z3dGpULzc0MzJEY3dUd082RFJuYkh4a1ZhY3Nl?=
 =?utf-8?B?R0xNUStkRmZkMWxsenRENnBrR2xnelZtWk92WnZzZ0tuTnNidU9hTTc0SFcr?=
 =?utf-8?B?OUlheWV1c3UzUHNDa1FCem9SbXVRN2FVRVBXNDZyVkJZd1dBcUpBRU9KV3Zn?=
 =?utf-8?B?U0dkcFJybkZsU1h0NDNoNXdLYlljMHZYMDNmQmNMbHBxNWVQdy82MEtDZlJD?=
 =?utf-8?B?R0VraWkxdzJWY0VzYWo0R2QvV3ptVkNQOWZ1MmxoQlZ6QmRHb2haaFVGQno5?=
 =?utf-8?B?Y0I0TWlNOTFOQVN6a0VaU29ZWks5cHZtdDVVRWNrWndwVmxCQ01JU3ZCY1lO?=
 =?utf-8?B?OWVCcklNWU9zSER3bHRuZUFOa0JtdDFvSnE4WHRUd2F2OU9TeGVmb2NRano5?=
 =?utf-8?B?YXRrTGtKMkV1eHlXY1BUL2FRL0VFSVQ3dlZLWjdjRmNwMDZXamNEV1plZytr?=
 =?utf-8?B?alExSTFGL0xNMG9BWDBOenRQeXlHUXgvOHh5V21ZUjBOSHVuNnRGWmJhWU8y?=
 =?utf-8?B?bG5tTlNnMEZCeC9PMzRtdXJ2UlFaYnU3VDBxWjgycHpBOXJGSGpJV2NYTVN0?=
 =?utf-8?B?RG83dFo3UVRaanM2dnNwNzFXMXZ2SGI1WmFldy84WjREK1Qzc2dJTVVXQjRY?=
 =?utf-8?B?blNUNWcyL2dkY2R2N1pzR0JGcTFqV0V2Ujh6bGl6dUZvQ1U3eXhRQW9VbndW?=
 =?utf-8?B?Tm1aODB2Qm9TVHNIRkdPcDRXdUI5MUd3OE4wNm9RVW5qTmJTMUZRc0U1TER2?=
 =?utf-8?B?YlNwSFpVVkhqMEdER3czWWE4Q3NxV2x0TDcwSXB4ZzRrVGNCSlV6eE8vUkZk?=
 =?utf-8?B?MVA3WTcvT0p4cjl2VTk4RVRiQWNJTjRENnZSSncwS2ZRUWJkQUNaNGxYZ2M5?=
 =?utf-8?B?R2M1MXhTZC9aWE51Y3hkcE1SYm40VHgxR2t0NkJLeHFXMGc0V3grYVBUQlhB?=
 =?utf-8?B?Z0tmaVRSZzNqbzh0VENDbHdyQTUwTXhIRUJSRkpWakt0QWlqNjduNnhuQmRO?=
 =?utf-8?B?MGxKaCtmL1EweHJ4ZTZCOWI3ZzN1WUhORFlqTnJIS0ZIdlBrVXlqZlI0bk9u?=
 =?utf-8?B?U25ILzNPNzFvSjBzQlF4RkZubUhrcCtnWk0xYjhZU3FBa0hGWFVmTjdjcGFI?=
 =?utf-8?B?bkZYbFVxdmYvYW1FTjhlR0NJM2Rua25VY0ZrbG5qY295UTByVnk4QmIyeC9a?=
 =?utf-8?B?aUNZd3Y5cGRRa3J2elNGaS9mMFhBcFJOMnNHUDlLZVFRZnk4WWIwcFNLY2gw?=
 =?utf-8?B?Z1JXc0tRbUZiY0t5djdXRTEyRnRqOXplYitrMFlRUnM0SkNiZXU4aDIvcDd5?=
 =?utf-8?B?d2ZRSVRFR2pNWEVxOEtJRC8rVFRFQ0lsSWxidTBONkFuT0EvV1JNdE1HZ1cx?=
 =?utf-8?B?cGlUWnlTUnVTNFhhTHVxbktoU0MxZ0NpSlhLWlExTzRWdHczY3ZlcGZ6Y285?=
 =?utf-8?B?YTdIa21FZGpQTHh2RW9aL0g2R0xLbkRVcXUxOW1uZzFmb1VWcytacWVFK25N?=
 =?utf-8?B?TUV3amREbVFGeEVtb0FPZUp6b21RVWZOYUJVY3RIWk8yMEJmT29Wa2RMN0Jn?=
 =?utf-8?Q?pv764t9AGfUPfBrQ9z+8CufSv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a5da5c-6d9d-44b2-8471-08dd085003dd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 04:09:51.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8feK3lkdyFQHv0zzpfoRVXYXXDrtgOess+1hSHGKKQ6QDfGVP1kawh5Z/52JkFZmPy1m0EG0/J94KC392K56g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862

On 11/18/2024 18:28, Armin Wolf wrote:
> Am 18.11.24 um 20:43 schrieb Armin Wolf:
> 
>> Am 09.11.24 um 05:41 schrieb Mario Limonciello:
>>
>>> The name attribute shows the name of the associated platform profile
>>> handler.
>>>
>>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/acpi/platform_profile.c | 27 +++++++++++++++++++++++++++
>>>   1 file changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c
>>> b/drivers/acpi/platform_profile.c
>>> index ef6af2c655524..4e2eda18f7f5f 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -25,8 +25,35 @@ static_assert(ARRAY_SIZE(profile_names) ==
>>> PLATFORM_PROFILE_LAST);
>>>
>>>   static DEFINE_IDA(platform_profile_ida);
>>>
>>> +/**
>>> + * name_show - Show the name of the profile handler
>>> + * @dev: The device
>>> + * @attr: The attribute
>>> + * @buf: The buffer to write to
>>> + * Return: The number of bytes written
>>> + */
>>> +static ssize_t name_show(struct device *dev,
>>> +             struct device_attribute *attr,
>>> +             char *buf)
>>> +{
>>> +    struct platform_profile_handler *handler = dev_get_drvdata(dev);
>>> +
>>> +    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>> +        return sysfs_emit(buf, "%s\n", handler->name);
>>> +    }
>>> +    return -ERESTARTSYS;
>>
>> I still have a bad feeling about the locking inside the class
>> attributes...
>>
>> Can we assume that no sysfs accesses occur after unregistering the
>> class device?
>>
>> Even if this is not the case then the locking fails to protect the
>> platform_profile_handler here.
>> If the device is unregistered right after dev_get_drvdata() was
>> called, then we would sill operate
>> on possibly stale data once we take the profile_lock.
>>
>> Does someone have any clue how sysfs attributes act during removal?
>>
> I think i found the answer to my questions inside this patch series:
> https://lore.kernel.org/linux-kernel/1390951311-15325-1-git-send-email- 
> tj@kernel.org
> 
> It says that:
> 
>      kernfs / sysfs implement the "sever" semantic for userland accesses.
>      When a node is removed, no further userland operations are allowed and
>      the in-flight ones are drained before removal is finished.  This makes
>      policing post-mortem userland accesses trivial for its users.
> 
> In this case taking the profile_lock when reading/writing class 
> attributes seems to be unnecessary.
> Please remove the unnecessary locking inside the class attributes.
> 

Before I respin a v7, let's make sure we're agreed on which things need 
locking and which don't.

Functions that check if a lock is held:
_store_class_profile()
_notify_class_profile()
get_class_profile()
_aggregate_choices()

Functions that take a lock:
name_show()
choices_show()
profile_show()
profile_store()
platform_profile_choices_show()
platform_profile_show()
platform_profile_store()
platform_profile_cycle()
platform_profile_register()
platform_profile_remove()

Functions that don't take or check for a lock (these are intermediary 
and things they call check for one):
_aggregate_profiles()
_store_and_notify()

Are you suggesting that basically these 4 can drop taking the lock?
name_show()
choices_show()
profile_show()
profile_store()

I think the show() ones I can get behind, but I'm worried about 
profile_store(), particularly as it pertains to the other callers of 
_store_class_profile() because it's incongruent how the other callers 
would use it then.

Can we perhaps just drop it for the 3 class attribute show() ones?

LMK.



