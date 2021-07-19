Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560C03CD441
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jul 2021 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhGSLTo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Jul 2021 07:19:44 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:35694
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230493AbhGSLTo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Jul 2021 07:19:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCDav62R6zSs3N2AqDUqOjhMGr03ZtxJd703IEyvAEN4ju3ALGbVE7uyC1otUFJZ/vbtM/h/JySaZoUqNOV1g7RJrc4e9nXlh1p2HAj1JjuUs/6ol2c6aga8ldo/0yCBD88JpPpxpI0a/nVupvQXkk60tZMdt8lqOjaHiGVYn+yGdw0x/z2iG1iZHEDV+y3MGxMbv+LKJlAOGesZPSLntzbWCb22f+RNdd1/eShiyqehLxXZWeigmPpe8zei6AEpBZXtFOx2B4+nFBjtbeuQm0G/45RlEllX4psZ7sQ73U6PAn4g6Onc44V5+jYxgW7itUhDaLsb0/Rpq4Rk5oo4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUZ+fdEIBj+SWEtw7LmD22G5xqVnGlPgJMazhkSyWZM=;
 b=ZRTuYP+vz988FqziJ17rTSAoYW9vsiiDO0O/la0/u07mOqALFevw8OisX/PX+UcpFQXcN68hBUS91X8u/S6qPWa8HZqJ2njUverRjjVy7D+7BPo94daIeTrKrImMg6buxvF68GEBehv8sCVduhCmMUvZ+dNu95vwRDB9VVo1zUFrfeGfg5KGgz1DROcsO2u5vHwJKUgQCbcuwsZn42k6ywoNNWywElHlSx+0tyfqliYyDLpLHkBDAQo2W9TE6JJ/Wqon9xbjDcBrHNX1IwWRiOF2EP2fu/35XPl12WMDgUCF10XkWOwMVqx60+V7MvWPlCXQiK3+GtzYcyLN1nKOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUZ+fdEIBj+SWEtw7LmD22G5xqVnGlPgJMazhkSyWZM=;
 b=Y5KM02PBc4dDb1YcxG3wQQj+r5hYuLkUI98eiMbiaurgLVT5SFlTTEiUQgrvSi/w/rTjBtasipsMoIdZJ3VTe493ouEH9CnhNH5L3FPWTMNhaFkL1rMLhvkmDpf5fIU8bUbNidjZVI/S2YjxtD8E3RnZkkR1nWB6nacx9ysibG4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0402MB3423.eurprd04.prod.outlook.com (2603:10a6:803:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 12:00:21 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 12:00:21 +0000
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
To:     Jon Nettleton <jon@solid-run.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210716101602.1891-1-laurentiu.tudor@nxp.com>
 <YPF40t5bhgTFM2wK@smile.fi.intel.com>
 <CABdtJHuKyybhJazpAc8KT54ELtZ319rdb6CbSH6zB5x3NhgtAw@mail.gmail.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <bb009f85-687e-d560-9cc5-1ac4f586a6bd@nxp.com>
Date:   Mon, 19 Jul 2021 15:00:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CABdtJHuKyybhJazpAc8KT54ELtZ319rdb6CbSH6zB5x3NhgtAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0902CA0017.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::27) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.103] (86.120.185.232) by AM4PR0902CA0017.eurprd09.prod.outlook.com (2603:10a6:200:9b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 12:00:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00429aaa-6ba2-44e4-d26a-08d94aacc8b0
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3423:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3423992B6313A8C2479D624AECE19@VI1PR0402MB3423.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhXW7+VGfcXtK4fkCRNFxhzns5FHToZPg5LLBvilMjsFbtYqkHzOtCm0R52fUDW12tPyg33VtGA2589pHIhIXYCuaTtmz6xdQSSLWNx1qb7zoEizDnFcfqlUj08wgmtdTXFd+GheBEjZlumQ9Gpi1pHaGYK5enJKLALfqoIMIwrASXhvHeeQpV+ys+021hBCv0AnzixcRuszSjnz2nEBDJESP9u9IZm10e4fsMfMTzHChr7sM2W3W7YVZrxFQkBFeobHktLhViXX40GDzGv+XVCf14pwFElodyGEmT1rvCUvcZ7ddcwqlyxw4CzTUnfxBWfZnw1u+zPfvJTxyJ1D/h6Hy2EQBQ/wWpGm2kp+RiNY2MJmt5yOHyATf99C7xgcXg20u82Gv1qNCW2ChcZONdrB7gRFWkrYnxFkHNJq0GPcDQssycs2kFiqgLO2KsLBBp4IDycymNpfQ1q7vmVJ4gnmszuJrhUjZxMId+bRXqqjzKyezhN41/0GTMRVpy/Bq0EYwf2Gjdx2NAbnA58Wk1onK36CMn/OOZs/kJNCo6bp/QSYlD5Kd8Bnk8dao3jlBiXapPUzIlOE9ykMT9FihAbwKw8sCpuJ3t6sBtQfiRhqglnPdrJM+T3BfqpMJoauxeRI66s128Vi4gpxIg5F+Qd/pFrAKjhUeByDJcT5KMyzFt7+AUQAhiZMY2iQRociFULZF2wa5u9OVpWc5o1gI3PWvMPRnrPRW4mR1DoWI052AMgfUNaCeOq8ci5N6/cFlen+91wbzOpkEO/nil2eVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(31686004)(6486002)(44832011)(26005)(52116002)(2906002)(16576012)(8936002)(66476007)(53546011)(54906003)(6666004)(956004)(316002)(83380400001)(4326008)(31696002)(110136005)(2616005)(5660300002)(66556008)(66946007)(86362001)(38100700002)(508600001)(186003)(8676002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWc5cHNWUmZQaW9FVFlxcFdXak1WY052dmMwanhnMXgzazNxV3k0U21Gb3Z2?=
 =?utf-8?B?dVB5UVB1L2pEdUZUeXFmWWthNW1vL1Byckw1SmtXdEpoRXBjYTZOL3B6NDdL?=
 =?utf-8?B?TjBpbVJZVS9TbGFWWFBSQTVGTythOGFUeHhCVTJGZXVZeFBvR2haMFZIcEdH?=
 =?utf-8?B?Q051dndGRTdBRG9SZlh1MHBjSXlWdFJnSnBWT0svbWZ3eE9hanpFMWJxUVZD?=
 =?utf-8?B?VnBUaEtucDhQSFMrL0xTSkQrQnA3MWkyMmdmOU5KbE5DWFpmOG1XV2cwRkRM?=
 =?utf-8?B?S1Z6QVFtYXFGUTFta040NkFoYXUzVFVLNzFBR1BaQUZobGYrQ1ZIVWpISThv?=
 =?utf-8?B?eTEvczRFZEhoZTlsdXY4R1BXTlF3Y2cvNnVyV1VtV3V6c3JkWEgyempvdzVk?=
 =?utf-8?B?b0x6WWtSUkt5aThVQUxRdnJ2OElMZUNxY20wQWxpcDJTZWdERi8wV01SQjhR?=
 =?utf-8?B?c3h2T1AwUlR6YXFTYjI5UUlvdzZ2cUNTMzRCdUJrQTMzekxZN04zSWFsdXNa?=
 =?utf-8?B?dXQ3NU1hSDRZdFl5YmRienBPWHNVK3l4VERxWXNzbTBTZ3UyVHhTbkMycUNt?=
 =?utf-8?B?bVYxcTJOTnNXN2VFZlYrUEVVZjl1cE90ME9FbjhnY05FTGlLdENnOGJyRXh2?=
 =?utf-8?B?aHhmNHVPazVOZEE0TEhwazdzZVdsVFZJUTRFRkJoVzBnQm93UjBNMTNaYy9O?=
 =?utf-8?B?WGxicGhKRDhJTzJwd051K0V5Unh3YUp3MzhzOTNUT2dnSXI2TnpWRFBDYnFU?=
 =?utf-8?B?NDZjVlRNcXdmUzgxN2IzYkl2QWM1VjcvTHM3VStFTmFaSFYyU0xBeVJXeWdj?=
 =?utf-8?B?cDd0T0pHeVFabDRYYytPOTl3bTF4T2FVRTRKSTRqdjE2bDdRNjE5Nm93cUJQ?=
 =?utf-8?B?ZEoxRHFFcU1OdTNuNHRSZDRBVWNiNjFFd3BIdThsZUNBQzdyTi8vcTltWG44?=
 =?utf-8?B?b0JxMEU1QUZTOGo1SUhxREZlL0JmQ3JGZmpMb1JRKzBOM0JwbVlUWUdrZmJm?=
 =?utf-8?B?K0J3NXNjLzN0aTVXREh3S2JPaEpPVFM5WWt3SjNOTE5tMURzWFc5WDBqckRK?=
 =?utf-8?B?Ty9jMk5MU2FUNWFROGd2WmdFSXUwdjlWcDBXSGl3M0VFUFE1em5vSFpBMDRZ?=
 =?utf-8?B?dk96a0xBd0tINElXNkxsZDZtMitlb1dYSmp1ZzFKdk1KZWlxTDJ3U3NHVkNF?=
 =?utf-8?B?NGJaVWg0amRrVHJ3WmpSV1JhdE9HdHphMnR2bTFhT0ExYzFwQUZzSTdnVmF6?=
 =?utf-8?B?TGFuTnhLRjFLMi9GTmlnbmM5bm5NRUxzSUttbFpkY3E4QTdTYTJjaUFGUzQ5?=
 =?utf-8?B?R0ZQYmsyYkpzalVjVDJ0YTBuOU0vcjVrYWtVeGo2bmFEMllkZ0xLSW01RlhG?=
 =?utf-8?B?VmFKcVhmMjQ3c0hqYzd0Z0Zhc0N6QU5MdlcycWU3TFRrY3RYKzl5bFpJQzRy?=
 =?utf-8?B?Rzh2TkQxTi92ZVFBQkw2Y0U2RjBoZjFpQ3IzNENBbWlXWnNHckMzNzVacDg2?=
 =?utf-8?B?aVk0TFkvTldWRExLdXdKQUFneXdKVGt5Vm93bnE1azVuY1gxcWhsN2tBSGpq?=
 =?utf-8?B?S0pJWk1TUXI3bWtpcTc5Smk3aVFHN2tGWnlsblEvaGxXOG1pMTJnbmcrRWFP?=
 =?utf-8?B?NmFRVzZMMkRZNjZGQWcrSTNjWUhxMzg1ZkVUQTZIMTlBQ0xFcDFGcHpMYk0w?=
 =?utf-8?B?TEt2K2dTa3dWN01DUTVNNzVSUE1BeVRvRnhBS2FvbStKdUpjbzhQaHhTL0FD?=
 =?utf-8?Q?EpzExV6GXRhh25XFDriWZHKjmiXSiv7NdzQPv74?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00429aaa-6ba2-44e4-d26a-08d94aacc8b0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 12:00:21.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPQF36TXxVcJYKmpukwf/EJbTuctUHzcvn+LECCJ3O810fGthk1UNRgYSPZBx5H65EbI7gYd+8oR6SM42Fnfag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3423
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 7/16/2021 8:21 PM, Jon Nettleton wrote:
> On Fri, Jul 16, 2021 at 2:17 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>
>>> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
>>> software nodes, thus leading to underflow errors. Balance the refcount by
>>> bumping it in the device_create_managed_software_node() function.
>>>
>>> The error [1] was encountered after adding a .shutdown() op to our
>>> fsl-mc-bus driver.
>>
>> Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
>> later on), I can tell that probably something is wrong in the ->shutdown()
>> method itself.
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>>
> 
> Isn't the other alternative to just remove the second kobject_put from
> KOBJ_REMOVE ?
> 

Or maybe on top of Heikki's suggestion, replace the calls to
sysfs_create_link() from KOBJ_ADD with sysfs_create_link_nowarn()?

---
Best Regards, Laurentiu
