Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFBC79D16D
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 14:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjILMyI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 08:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjILMyH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 08:54:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B05198
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 05:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBbMBWZBm7R+QoDMLGmfmdazyE7H20dmUxbK0xFeOUb0+G56VVN5K4q9NyZshsyVpuQOa/oFqWzTpSoERck5rpIduFA9ZUvLthkq/jwDJiOSEjdztDC6JqdhLg6lpPMyFs74eXpuWYyUwAF3fo79b1FMD62lP5AQ3nufZGsFzoxv8xKUguRdLZLLQOS7wC00UdAK/I9O+G9f/hOSN2hTBzrwY6LY5vU6cR4tdhm9UrbqFFr1o59RSIJRnyjamTZErl+KLx28pwIYWxfOByz/iDhpllq6+EaD2FIhmgNA+EQSBvCfmp2WYTYRsLTs0BDgBHL6LcuxwePCnsze+pQQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75eANkTZ+dlTJBc9l5NrBWnA9YzYujRpt2sj9hRfvEY=;
 b=iSWs5+p14k3PB8bll36k2zZrs8W5VRcZoN/5D9TsRGotghRt9WJsyzcOwrLZa32Dk+1vg3m0oXB+3bDAAmu7YeSUW7/CAbNVYnJMkkfSr8tg7mlouMjIVjV3JA9mkyFbSO60UZdH9xN0VN47ZePuGqNGAYcYazy5eVxCTuuOKpD6NSggGIcA6jBPypJ2GSXY2GDY8byahPeFZ584PKsMCF4dwySWYAlX3F90wQIzVzPyk5NlKraTJQ5992dNf28ZUOykcMAURpQWgHW1OKOd6l/JGaMVz60tCLFDfPD+NqLbXMSqGypbbKtB+YiVFv0H18XooNkF0ldN3bFgvizyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75eANkTZ+dlTJBc9l5NrBWnA9YzYujRpt2sj9hRfvEY=;
 b=BNzODv9bBtzGTDUTgJtv9aXGcMpiM3aB6ZLcug8s4LJf9yzakpI02gGY7ZxXw4u1eDqk7cNp+XZpnC0HLO76wwnCXapldvDyxB+ufHElpjMZDCbDdQ2AYqSOE+I9fPfgqWFvvChSnnQe6w1jtO2I2TK4/Hg31xwqTVnKnwrjuQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 12:53:59 +0000
Received: from PH7PR12MB6978.namprd12.prod.outlook.com
 ([fe80::c422:217b:5b:979d]) by PH7PR12MB6978.namprd12.prod.outlook.com
 ([fe80::c422:217b:5b:979d%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 12:53:59 +0000
Message-ID: <ef556f45-a90c-a4c3-4cc0-f57323c438c9@amd.com>
Date:   Tue, 12 Sep 2023 20:53:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] acpi: trigger wakeup key event from power button
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        rafael@kernel.org, kernel test robot <lkp@intel.com>,
        cwhuang@linux.org.tw
References: <20230908095747.446389-1-Ken.Xue@amd.com>
 <ZP7hH9i6ZQgINbcB@smile.fi.intel.com>
 <2bfaa431-ca9f-c879-9967-f13d18dd4cd3@amd.com>
 <ZQAvpIKqmLeWbh0v@smile.fi.intel.com>
From:   Ken Xue <Ken.Xue@amd.com>
In-Reply-To: <ZQAvpIKqmLeWbh0v@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To PH7PR12MB6978.namprd12.prod.outlook.com
 (2603:10b6:510:1b8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6978:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 05339139-37b5-4a99-cd8e-08dbb38f54e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLcbZ6p9j8saJ2EWDzfC/eZ0iFfiaZhrIwZPwnSFcpivA8Rmo24BOsnIxeFPXk9dUJEm4MfHKTe2SRQJ2Q5bsVZWwDRp0aRbD6KbnzaU1t39jDpSVY+hpZwdyY4gnjIj2lta8Ju032tcm3bQw3KIQ5BMrQi8YpX4V28Z6YpC1K3H5tMbNmzBkHFkecv2WbBqnGuymRh6MApMGerrxAotNyvbf1eqUQE8vSgKf5xUNqwr9/v5ORXKEFxZqBhFiMyr7ZMXzdNF+ddHtN7SbwrGqcz949axnRk1VcMrEfAmjz3u31dzV8OVps1Fs2cz6hUB4LKxZN38gyZm6Hmc2rmoDoSq72j4ySpycXuzMQbYB+9MRGNi85L2kCvHj8iJmLmdqjyF08rdiZemR/jFOr7gx+/z+jgjC00cFviDFfndp1Nt+A2Cx6tp+fPQ8XnJmwn8cCcVWiaoFydLvt+OUZeuSUovamKlrDHqplMVEdzF343ZI64xD782B+v6BARQM9Ca0r44TLn+W1mQmMn6rlmW7aphEOECp8peu2oI0mnvX2rBb42b2W3Qcrot7LJqL1dd9fcx30nt1WMJDztb9hrXBUfFzKrzXL4couSRsuv61wZ9LtEXRdHom5oT1QItRTlgE32sa36ntabdLm9Ux6KjkxhWkD3pGiFvbwGmmOtqaNUmO0cial6PmeABbpmQ0Ykp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6978.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(1800799009)(186009)(451199024)(83380400001)(66946007)(66476007)(36756003)(38100700002)(31696002)(86362001)(316002)(66556008)(6916009)(8936002)(8676002)(4326008)(41300700001)(5660300002)(6486002)(6506007)(53546011)(6666004)(6512007)(31686004)(966005)(2906002)(478600001)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVBBMWh4K3NROVJPeVdpYnBaUldnWmtpUVlxeTBJZjR1c2UzZ3IrUlJ6YTMx?=
 =?utf-8?B?dnNkcjZYN1ZabERwc3hWdWVNN05PbThwa0tFWlBVV3ZmNVB1R3RoTU96ZzJU?=
 =?utf-8?B?Y0xiZVppd0VsVDlKS0pNbkNkKy9IcGJrdXVndFJxcndCSlZWR0tYYlh0MVVN?=
 =?utf-8?B?cUZ0UzdNa3FxQXltUTFyVE8zV3ViSlBjYThzdGhVVVFndDhYNnU4Tmc0MFhM?=
 =?utf-8?B?UXNUVllvdUxDR1dQcThqNFFMc2gvWk9qcjhRVlZpNWV5WWtMbFhKTE1RRU4r?=
 =?utf-8?B?YjhSM1Y2Um1RS1ZBeGVxYlBrYzRkYlRHMW53c1ZMUnFZeFFPQ3pVeEllUXE0?=
 =?utf-8?B?YUhUQnB2V0ZWdXFyb294c21COXhGUmY0NVlrT0VsaGtqdFlodldPaGNaQWxt?=
 =?utf-8?B?ZXY3NU5qbHVmN3Jiak96ZmxNdXNxaEJlZldaVUVaZ0VxNnFSRmFXczdlYXJw?=
 =?utf-8?B?bFNQNWRDQnZsbFc3Y29rY0RJTGFlSEhONHZuRjZKL3pxdmVNa2FXZWpiT0hU?=
 =?utf-8?B?MHNXUUJyc0RGYzFVZ281bXB4Y3gvZzZKTUhQRkdVUTRaWWpwNUR3RXpVWWtw?=
 =?utf-8?B?cE5NRkZXMXdlSk5TWXFxcThnNnBMSUF4QmxrZVExQnA1elR3dDE1czJ0OGdv?=
 =?utf-8?B?K1BnOS9hZmljMm1wUThkU21sZVFZYUJRaEh3YUxkdHRtSFlTSHRsSXdrbkRG?=
 =?utf-8?B?MFFCUjRHY0haV1ZEMVNwdmxwWEtkWGxrNnkvWlZNMzE3Tnd4dHVDdG9XaFNq?=
 =?utf-8?B?WE5ZQ0ZWL3lLekcyRkN5d2hVSlN0TldoSDJLYXRzRzdVQXZwUE5hOHByeGJx?=
 =?utf-8?B?TzVFWW5YTTZobmkyZy9SdHpqNUd6VXJpWGJsY05XYXRyL0VCNXpEQ1JjajN5?=
 =?utf-8?B?N25Pb2o4UTNNalFTYU9ZbE9ZSUpVak00ZE9Xdjh2MDlaRS9CYTcrOVFpYS8r?=
 =?utf-8?B?YU9vcmllbFR4SEdhYVl3WWlNTFNxM25oQVc0eG1YZERWeWlQaUEvWVVmQjI2?=
 =?utf-8?B?MFBScGNmT0RkZzhsR3JwbzN2ZXZjUHlPN3BFY2hMTUVvQUp5ZVlkYmU4ekFx?=
 =?utf-8?B?cDd4WnlueHdvRDZuN3E1a3gyS0NCRHg0V1hKK2NJbVZsU3dodnhYOHErdHFu?=
 =?utf-8?B?aTlUR3pvWGwxNHFrMDRyNWtHdjBJdVpCTVFRVmtIa2ZJbFVBRzVBQzloQnFT?=
 =?utf-8?B?WTFCUFBOS3pwOE5PSjkrRTd2VE96Y2ZmbWdTekJVN3FsbHM2Nit1K1ZMNWx6?=
 =?utf-8?B?aHN3U3M2ZmZmNEwxeXhCTDJqL2dUTjM3by96RW5ZamtIWGdnYlNWMFZuaFpH?=
 =?utf-8?B?eFQ0aG51QW1KbjFqRHRUTmNuZC90R3UrODN6ZHhNWW9lTVF3N2N2RHNsZWln?=
 =?utf-8?B?Um9SMU8rNGJ6RHpRaTZ5cEQvMXhIaFYwUjRxWjVJZ3kvWlpuYWNjVThJbFZR?=
 =?utf-8?B?QXlGSXFiLzk1Y3BpenUxM3UxZS8wQ2pERXNEelNvU0pwV3hFRDdwWThSYWd2?=
 =?utf-8?B?aTFOcVV4Z3c3RFhmalV4TnRFNDNXR2pJYUlNK1QxYWlnYk11Ty9ZMzZRZDUx?=
 =?utf-8?B?Qi9WM2dvcUwyNmxNMnhCR1ZoVHZmeHdPYVdVcW5xeU43NW4vWEdRNkRDUzYw?=
 =?utf-8?B?enZqZmlaV2ZNQ2FSRnhkMHRPdWYwV3dkU1NLRlM4b0FoVmRRemlsMEZ5Qmdh?=
 =?utf-8?B?WU85anoyUVozcmU0SGY4SXFzdkpIQ1RwQy94VkladjVhb3RJR1VnbHRpZlli?=
 =?utf-8?B?OStXdVc1SEVxbU5jYWVaZ2llNUszZm5lejBtYjdJNE5wQXZDcVpWcXRTNTNx?=
 =?utf-8?B?TjVsMUVoZExuVFZ1RExNUVpJZHF4OHJaNWdpQVVsb2dFU09TWWw0SUpBbGVU?=
 =?utf-8?B?NWY0WGtySmd3KzFIMzRlMmJvTWpabVhMSXZZVFR0U2poLzJTM2VReTRYTjNq?=
 =?utf-8?B?Q05ZeG9NQlJWQWhySHhjOHlJODVZRlh5T1FERjA3bnNZNEhtY01BYklxWGNm?=
 =?utf-8?B?VTZGUEUrSjBZd1owVkVPbDlNWjNRVHFXZHhPeFhCK2pIZ3hESFovRFk0KzBC?=
 =?utf-8?B?VFh1cXBQN215WTVBTnJLRm5qZXZlSzZ5emF6S0Y4Qm5SajF3SG9IaEU3emU1?=
 =?utf-8?Q?PVoUdTiaKEc/jv3hFgAEdu3iL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05339139-37b5-4a99-cd8e-08dbb38f54e3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6978.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 12:53:59.1137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFc0bWq7gUYvovcmlW9U2gF3tPffuSlTEUnRBEFLbi0jM44ZwNtUDQlkTXgXIrOo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 2023/9/12 17:30, Andy Shevchenko wrote:
> On Tue, Sep 12, 2023 at 01:32:02PM +0800, Ken Xue wrote:
>> On 2023/9/11 17:42, Andy Shevchenko wrote:
>>> On Fri, Sep 08, 2023 at 05:57:49PM +0800, Ken Xue wrote:
...
>> 2) test robot reported some compile warnings and errors detected by test
>> robot which is fixed in V2.
> Yes and that's what I'm asking about. You are not supposed to add it as the
> initial problem, the patch is trying to solve, has _not_ been reported by LKP,
> hasn't it?
>
> ...
>
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202309080315.txQUEyHQ-lkp@intel.com/
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202309080239.IiC7uLpW-lkp@intel.com/
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202309080351.xHt2qhP2-lkp@intel.com/
>>> Are you sure?
>> Just some errors/warnings from the v1 patch.
> Same as above.

Get it.  Those info will not be included in commit message.


>
> ...
>
>>>> +#include <linux/acpi.h>
>>> There are no users of this header.
>>>
>>> Check how forward declaration can be used (as it's done in many other headers).
>>>
>> Yes, "struct acpi_device" is defined in "include/acpi/acpi_bus.h", but
>> include acpi_bus.h alone will lead to more compile issues.
>>
>> Regarding "forward declaration", how about
>>
>> typedef struct acpi_device *acpi_device;
> Is it a forward declaration?
Ok, I will use "struct acpi_device;"
