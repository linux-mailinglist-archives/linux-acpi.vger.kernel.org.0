Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF22642FB72
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Oct 2021 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbhJOSxc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 14:53:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:32725 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241552AbhJOSxb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Oct 2021 14:53:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="226742497"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="226742497"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 11:51:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="488530119"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 15 Oct 2021 11:51:24 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 11:51:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 11:51:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 11:50:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDUpkItOIfWPh7H6tSP1hUGokm5dMkcGZo4/RJ/cPHC8Zvd8Ljmqw7zlMCb1cLHmfcgCBS9RTOLWDcpZNkTh7vgR2e1RH6orIgfwMmDh2HvP1z5L+bYiGzpku5OXwa5VdhskU/8VxWKANn0Ss8BsEtk6yXKeCqth+HDa2phPM2+cBwVAVWuW0t3GZC0PuHQPC6GcmMQjyoZ/drY2SsISYzSaUpA/7Pqg0WXeHHsr9XmQoJoWOpwgaPp87/5vfR3WsJMth/gbUYDr+RZs2zBMB6uVbVlK+YnVrg7ryq6YCiCw2SWBAdG2fNmmvanordA2GLJ18GgDiVttkHP/QSX4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNVuH32Lkw0ww3HY3CyTlwnkXdADJ/lcu9Hv92r+i28=;
 b=mHIc3JKlUv87Qj5rBcR+2Bmmba2adcA4TFZPtSQVrvN8QlUdTZjNUGGu8gMBxvsGCNKqTyQUNZJ/zrYGxbVDEyInwJzugKBtV3vkIDVnac+iNVBLEfngFc7IpCUpaNSlNktWXuopaXCVfrrj6HMaKFeImj8b2KNeNabl6D9LKkAXroGnbBrl4ZuViJCLlqbpuJY0XU4RqRPmCRAkxeOjWPP4syAGDeUFOlsmTCgdKo9QBkDCHSk4NePP2wdaO79HeCHFm+tXs0P5cPKWlWI0VxMcvhcvmdh0KZ2qXouKdS1G9aUUtsYMXy1AWTv6AXXR9z4eIx94BKxRuSwBgVYCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNVuH32Lkw0ww3HY3CyTlwnkXdADJ/lcu9Hv92r+i28=;
 b=d82CzAiDtpXdy4udgAjgp0qHnHsILNTIS4JJO2uNxrB9TOC1N3/Lha3bN/aIxgb3btlrhRkejtqZbszTcirTygMmiMgv4afc+hM87MDpDnuSCf69db94gFYQTxBVe2+tcoHeXE6q2Qve5SMCe7QL3+xUrPc6SbEWqpMtA+fjjB4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) by
 DM6PR11MB4092.namprd11.prod.outlook.com (2603:10b6:5:192::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Fri, 15 Oct 2021 18:50:54 +0000
Received: from DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da]) by DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da%9]) with mapi id 15.20.4587.030; Fri, 15 Oct 2021
 18:50:54 +0000
Subject: Re: [acpi] Bug report: nvme :Cannot transition to power state D0 for
 parent in D3hot
To:     Jun Miao <jun.miao@windriver.com>
CC:     <acpi@linux.intel.com>, <linux-acpi@vger.kernel.org>
References: <553a643c-2bda-35a6-571a-628a13c241da@windriver.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <95052a93-93fd-5ace-1568-6cff7b4014e6@intel.com>
Date:   Fri, 15 Oct 2021 20:50:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <553a643c-2bda-35a6-571a-628a13c241da@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR0P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::11) To DM4PR11MB5326.namprd11.prod.outlook.com
 (2603:10b6:5:391::8)
MIME-Version: 1.0
Received: from [192.168.100.217] (213.134.175.255) by FR0P281CA0063.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Fri, 15 Oct 2021 18:50:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80b99d90-132c-4c41-b9a8-08d9900cb797
X-MS-TrafficTypeDiagnostic: DM6PR11MB4092:
X-Microsoft-Antispam-PRVS: <DM6PR11MB40927555338EDA74F833CE57CBB99@DM6PR11MB4092.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZGbqTGH86a+G/lbtCB1cqri0KEr+4YrH0CrZ9I3L0go88OkdLhhx8bZui8M9ok5E1NDqBBE0sk8KWkFHqlUUvIBo0Q7KA6uPXrXU2YC4JV6a2OyaP9VvkEWK8boo7OdaAh33LjpQCHoxnhsi0RhIH4r5+6S5Wog4zQ/hjZf4bNdk1fcilK8YYQ7zJb//oOcAkBvbjVewLPOVMdmsvh36Oqdsij5DriFjy3haUvUMgnPYLQZtS2tMpnN5biEQE6e3BsbcwKA4tpagX/+GbjX1gbYFC/WqhgS+Hr84JJ8XtSVPuvaWWjuxTrfajZc829dcOV5iRA60vHE18mlAeZhvyfNk1XfC/6brrUVEQ3oqeu4iI3+yF3cUW0v/8oHgB3UEg14vpW7sWJb3DjeBhU9pWhd6iUwRu1UgKNnehYXO89RQZwknZ1jc5YLuN5JnMIIZs+Kh0375tdrCBPhvpAXQ6Lo8eKZLa7cOcCIe/khplg0EQKAqX+mVub5Oa+jCdFZLQVUx2OOUhtsTHQ8kyXkqLf7ncELDbwn3S+lDyMo/arVv4dwVFWDaAPNN5JlvPEKLxQhGdSAd/4toAfWpmP34IBF9hBcY3evR/4dfQb8AW8WQIxlPNu7hjZhtwYZeIr/vTQICdDKq7S0VHst5gH9v0vrTXsZisl0QkBUxRZ6mkLLIWhWSAemtCJwF2gm5LuwhcRH+zjvouvKPaEs/yG9uMS88K+u1aStDsB77o9D2OroASetCYC+P+jSNyq7IdV8mB7aZLugt/M5d3B94cb4+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5326.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(26005)(6916009)(2906002)(66476007)(186003)(16576012)(66556008)(2616005)(316002)(508600001)(956004)(5660300002)(86362001)(8936002)(31696002)(82960400001)(36916002)(6486002)(8676002)(4326008)(36756003)(38100700002)(31686004)(53546011)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1o4TUtJNFltNEltKzNjY0pyWEh4dktiY0o4U2pGUWFtSE0vcVBETFZYVUpC?=
 =?utf-8?B?SnM0VFFDOXdacEpTYlVEREczQ2NQcUJCTjBuZ2pBMTBweVRUcVdGSWlHZU5E?=
 =?utf-8?B?aXBCQk5Gb2ZBVkt1cmpFWmJGcUFmaTNUVUpGaFpPaXJlSHZQSThzazdETGhK?=
 =?utf-8?B?ZGJobjUwSGRsS2l0OU5UL0h4d1F4eXBidVo2Y1E1L2xxZFhuZGc3endtdjdo?=
 =?utf-8?B?cW9SZDZBTUNzUFM3Q0lKOU9YYmQ3WGlZSEpGQi9RYjEzQjh2d1Y2ekZ6aGtW?=
 =?utf-8?B?YlI2Vm1JVDJYWlE4NGdENHNpNjEyUmRDQk9JTzI4QmNCeW1hZjRLTkF6UDg2?=
 =?utf-8?B?dXZKNTFjNFVCS2FuSnM2VXJkMzZYc2ZBQ1N5aU1CRDRZMlkwYWMwSGdDcWds?=
 =?utf-8?B?dmFGdkJSLzRWalJYSXg4Tk9OS05nOUI4M1hBbXV6cHF6QlV2MmtWMFJ2S2Na?=
 =?utf-8?B?MHVvcVZJUmRDQk5zUUtZeFFiT1k4UDI3a1U0M0ZuakNRK1h2ekpya2U3cFdV?=
 =?utf-8?B?akdsWUFLM2t6Q25odE12aW1taEdtMk5ScEhaVjVTMlhwVUpxUjJwVW9KMnhp?=
 =?utf-8?B?WnhHM2VyM1NhaFlmOWoxUzljVUJQVVIzczE3N0R2RHhGOE96azhrSERvQi82?=
 =?utf-8?B?Z0ZyVWNNSmF5WURjVzdzQStUZGUvTTJ3bFc1Q2F1WXJyOVJlUU5tU2FhQ2d0?=
 =?utf-8?B?Y2p4elZtQmZMSEx6Vy9yU0pwMVd1NS9YMXhsWktORnZIbHJBZnZXcTNrUnFj?=
 =?utf-8?B?c3F5TDFDNHNEYjVqV1JGbWJrekJndmRsR0FlamtmSk9zZ1J2YUVkR1psb1VI?=
 =?utf-8?B?eW91L2d2SFJuUVVxWlZRaUJhUzlRbEN5MXhNZDlLaHhFUktSb2FZWENUMExH?=
 =?utf-8?B?TkhjTWxPVWRYdVZqV3BZMXczY2tBUFBSdUp2REZ6aWczZGVUZHBtRWlOcHZW?=
 =?utf-8?B?ZmxEdGNEcTJaYktwaEl1djBZVml6RlF0UnNmeU5HQlNMZG1IK1l1bnlaRm5k?=
 =?utf-8?B?NzhOUERuUzJteElxams5NU9zN3JQRjhLZUlZREd0UmV6ZTE2ZzdHL1R6TENT?=
 =?utf-8?B?aEY5V0l4QkZoMngwVEFweDFXOG1BS2dHZWFVT2d6TkVsN0gzY1JTaHM0bHdy?=
 =?utf-8?B?aW0yK1RJWnJDMG1zQTlBVXdoN1B4Uy9qdzZLd3E2S2Y0MWg3VzRnN25ya2Vo?=
 =?utf-8?B?TkNhRnh6OVQ5eG5RdVY0dzZsL1ZSWERkbjJYZDdyTC9ibnlXbllQWkxNOWhn?=
 =?utf-8?B?T0ZkN3ZhS2FRbmlNNFVla0tUQVYrRnNjQm5pbStLTW9IWUdzdFZaeVJuSzFS?=
 =?utf-8?B?bU1HdTFUNjFwS01qNlgxL1V2UDZWN1BsWnE2WXR1dFdVNWNaa01BaWsybEZ6?=
 =?utf-8?B?OUt0U0JwSjk5MmJJd2N2VDZsRlBHQ2VtOTd3UjA1QmcvQUdZQjZOSDFNbWcy?=
 =?utf-8?B?ZXZaMUE4bWNMYnNyclJTUjdLbFpIM2xxMW1vUXE5MWhoSWFEUklNZFNpTTFz?=
 =?utf-8?B?OVhHNG0yc1JheVY5U0xUM0hNRTcyenBxZ2lSdGtHSG5OdEpQaEMwQ0FTdFZI?=
 =?utf-8?B?VnBkU2tSaDJPS2wvQ2p0djB4UjhkZTBpbjN1Ym5NVDE1UzhOcmd1akNuTHBW?=
 =?utf-8?B?Mis2cWJqNHZQSVRWSEVNVzF1aFo2RjBERzJXaVdFLytnQWFZYmhZZW9SUjdm?=
 =?utf-8?B?dW00ZHBMeEpMbTlnTGFwNFJhMXNKdHNDckdJMXRXNllLbjVSQUhJdFJJYytm?=
 =?utf-8?Q?EKrpTdNYhig7ygqp0cEDWvvGMy+oNWiprgYxvlU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b99d90-132c-4c41-b9a8-08d9900cb797
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5326.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:50:54.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1eDGBazHUO7UVZvgoodmUPrx7tXhRt3FSQk7/xunGMiIZfocLHvkAu1gA51352OuIwnG+lQ+aVMXUQJP5ehAFtFilqztpU+e5DZ6PcrLjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4092
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/15/2021 2:43 PM, Jun Miao wrote:
> Hi all
>
>
> bug log:
>
> *  acpi device:1b: Cannot transition to power state D0 for parent in 
> D3hot*

When does this happen?


>
> *
> *
>
>
> kernel version：
>
>         Linux intel-x86-64 5.15.0-rc4
>
> device info:
>
> root@intel-x86-64:~#lspci:
>
>   02:00.0 Non-Volatile memory controller: Intel Corporation SSD Pro 
> 7600p/760p/E 6100p Series (rev 03)
>
> root@intel-x86-64:~# lspci -vnn -s 02:00.0
> 02:00.0 Non-Volatile memory controller [0108]: Intel Corporation SSD 
> Pro 7600p/760p/E 6100p Series [8086:f1a6] (rev 03) (prog-if 02 [NVM 
> Express])
>     Subsystem: Intel Corporation Intel Corporation SSD Pro 
> 7600p/760p/E 6100p Series [NVM Express] [8086:390b]
>     Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0, 
> IOMMU group 11
>     Memory at df000000 (64-bit, non-prefetchable) [size=16K]
>     Capabilities: [40] Power Management version 3
>     Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit+
>     Capabilities: [70] Express Endpoint, MSI 00
>     Capabilities: [b0] MSI-X: Enable+ Count=16 Masked-
>     Capabilities: [100] Advanced Error Reporting
>     Capabilities: [158] Secondary PCI Express
>     Capabilities: [178] Latency Tolerance Reporting
>     Capabilities: [180] L1 PM Substates
>     Kernel driver in use: nvme
>
>
> kernel source :
>
> drivers/acpi/device_pm.c
>
> / 197         if (!device->power.flags.ignore_parent && //
> // 198             device->parent && (state < 
> device->parent->power.state)) { //
> // 199 dev_warn(&device->dev, //
> // 200                          "Cannot transition to power state %s 
> for parent in %s\n",//
> // 201 acpi_power_state_string(state), //
> // 202 acpi_power_state_string(device->parent->power.state)); //
> // 203                 return -ENODEV; //
> // 204         }
> /
>
> /
> /
>
> Whice one  is this device(device:1b) parent device ???//
>
>
You can check which device is pointed to by the physical_node link in 
/sys/bus/acpi/devices/.

Why do you think that NVMe is affected?


