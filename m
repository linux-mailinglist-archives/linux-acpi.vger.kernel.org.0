Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E902241B520
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Sep 2021 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbhI1R2v (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Sep 2021 13:28:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:1618 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238961AbhI1R2v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Sep 2021 13:28:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="211846538"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="211846538"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 10:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="706767648"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2021 10:27:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 10:27:10 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 10:27:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 10:27:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 10:27:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGoNs59Xtu8VW/B7nPbNcAhpP+VPUbyGs6Chd3Y6qBKSsaj+hUlBRoxDr9XZ0URVZctBae04++YVHX5YVZButszGuYJERV3lPbV7YVP5uPRgUdBw9vMJJFGjs/Og6l4RHM1MIH3c0kK8yqfLJmNYjxARJ17gEf3LVvr0PKSll7KBXaqtpXDZmBrBxim/IUfDnqY7683l43hjb5SKlvyLej03IvWF3Rdr6R+OHOGsiXoLcd6A0VFjO6p4Sv29haub8w4Eb19RqP+u3v8PoculqRAAR4BKLbhPQ1AondHsW2ayrKcA2bNfiZqFO0mBeU6rWg2YSmw1d06nW0p5pJN6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Vxb5OI6MVra5QCbk2oBogSiqvxfgwZxHu4UucYaXTDo=;
 b=Yakeq5cayXnz7t/LMpQShjUhOvUmiYpWgsuFfOBZK6g28R0mwVtsYraVtxH71+8l4VDQtH4mhMX2CPx2s0snOAP94sJeRd0v2dMlWrDw5gQu66VlpJeS3/h/6u2gfrwx5ywJW5zaohbtqZb4AG0n7j0OcEDqCeresPl21v5OkFdXYl4ceBSpoQbfuoLMfVZ9MrNcdy8umttcdCefjwJZj3vwxR5PigD7stXxN8Ar11vh64eOugum1SXLMxU68kgZrxr3iHdUYqeDnBbLYJC5snM2Bn77QL8zhUhXkV4b6UirwRCYNgw1iNCzA4GToaPYE209fkiqfOkfdcUSbIi5nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vxb5OI6MVra5QCbk2oBogSiqvxfgwZxHu4UucYaXTDo=;
 b=J2AYyjqUU7ETZHjhFd+Tn2hqo7g7ToESdVqmAsnFf/cu7QwPB7k8oNnFrYwEGfsa9jN26VdCqKLuvt8gLRGp9tlaiM0l2h1M35DA/qRpALyhnkxHzW5jWiu8Wcl+peMJwxo9DHMfJxuFzSo0cvf6auS+7Idzi1VNK4CdmEiZ67k=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) by
 DM6PR11MB2841.namprd11.prod.outlook.com (2603:10b6:5:c8::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Tue, 28 Sep 2021 17:27:03 +0000
Received: from DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da]) by DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da%9]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 17:27:03 +0000
Subject: Re: [PATCH v2] Revert "ACPI: Add memory semantics to
 acpi_os_map_memory()"
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        Jia He <justin.he@arm.com>,
        "Harb Abdulhamid" <harb@amperecomputing.com>,
        Will Deacon <will@kernel.org>, "Len Brown" <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20210910122820.26886-1-justin.he@arm.com>
 <20210910143223.6705-1-justin.he@arm.com> <20210922163336.GA24633@lpieralisi>
 <56147a0b8b9fba46@bloch.sibelius.xs4all.nl>
 <20210923094031.GA6454@lpieralisi>
 <CAJZ5v0g+OVbhuUUDrLUCfX_mVqY_e8ubgLTU98=jfjTeb4t+Pw@mail.gmail.com>
 <56147c6e73afe9f6@bloch.sibelius.xs4all.nl>
 <CAJZ5v0j7=EGbtGw+FOMwyNWoyRoaeT1cvu6si7nPVVFh307J0g@mail.gmail.com>
 <20210924090409.GA26089@lpieralisi>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <44f20f07-257b-a1a5-23d9-ffd66bf45887@intel.com>
Date:   Tue, 28 Sep 2021 19:26:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20210924090409.GA26089@lpieralisi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: DB6P193CA0023.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::33)
 To DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8)
MIME-Version: 1.0
Received: from [192.168.100.217] (213.134.187.41) by DB6P193CA0023.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 17:26:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7df46069-88cf-4f8d-563a-08d982a52fa6
X-MS-TrafficTypeDiagnostic: DM6PR11MB2841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB28411141E0FC747F7915A007CBA89@DM6PR11MB2841.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ElHoqZoeZEB76GmIq/V2XLCo5xAGdz4FhxYvXPVzHeDN42UbxEg14/xrjZTuPHqX5a3oqJ1Xa+9YrP6J5XQPH78I1Giqanqo+FGPoRvnyRfnkIKg2Og901berWCZcSuvuBv1/v4h0FdLSd1xUdPhQWoTVVxsnc9BWy1gSoLNqVnFr+FM0YO2rxBxiEdn/cy1hDfJD94xYl5/8iUfuZqJ5vT914w4HUrzksPWe39umo1EJuk9qnbHYPUrigVZDM2h/1Hg2i8nvH0Hq4T1YfFBlEOj74jskX2XvO63NLAMDVC0KZpGckY8Ihw348UtFk0awfbNgrCUmvVYq3fFGznbmP9mG6Y1NeQiVgWmFM2UYcJG3Pmeb3Q4Qz6YU2YWb4wwJhpLwhUrq3djvSriY11rZLwws2vyBbuTUy5jKZs4Dh8LeTwEG08fdQ0Eg6CsX10/mcLP7+mzCTVc1s49xg93bJ60UCQh86knQtdnwGzI0gjjbxKdC9JTEdCf/O6V1OzwkFxx6MxfaRgwWT0WsvEO7dSpUS2scN2tMvPhfPeNnrhfjAXjsutZBuK6boqID2790/mgW5tsbpMe6OhBBqVNxidjmqcTxDGoJD6hA7hpgbyaUvtegpxA4PwATvpg/eRTB7jXY3B8S5oFXAc7LZlieIE0mgRyRBj73kLBXuI86iFmAoQS+dnSuJhw0BJBMD8GHBcVN0F3oquBOzlTBz44/BHGCBRvrTPBiRdnnzPyCksy3ISoQ6vpU3Xy7mhLMWA+SjqP2xtoNuFuPQN7pCosw4LQlrkeoSCNoRxKyr97hjrxWajlBQ4HZF/qTBoPXM8m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5326.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(966005)(45080400002)(31696002)(2906002)(36916002)(31686004)(36756003)(16576012)(66556008)(956004)(86362001)(2616005)(7416002)(66946007)(66476007)(54906003)(508600001)(53546011)(4326008)(110136005)(83380400001)(5660300002)(8676002)(316002)(8936002)(38100700002)(6666004)(6486002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkNtbE9GNDlLck1ONnJZRTU0SVdjeU1YVHU1cnkyeTNQSW5LM2pORFB5eFlC?=
 =?utf-8?B?L1NweW04Yy9KdU5PbWhXeVlYc3FLa3p6ZUdPKzM2bUZrdExzWHh2TXF4UVJw?=
 =?utf-8?B?eWNqRUI4Rk4xUTNQRDFSUS9maUVxTEZGSFZhaUFqQ3ZNVG5UdStIMnFhOWU3?=
 =?utf-8?B?ZTVZRjdCbHp0VGJxNzAyaHJ4MlI2aWdET3J0ZGJBZXBTZmVEZmZENDNTMjVL?=
 =?utf-8?B?WEltSFJpUXQxTVBoRGw3SUhBTVhGOGc5YVNOSkppWURnL0pjMUxEOGlLYjIy?=
 =?utf-8?B?cTRxYmxURlM5NnFVdnlSTWlqd1pNdy9aMzNWdzZhT0pjQ3hBTU5VN095U0x1?=
 =?utf-8?B?VFZPSWFEK1dWaHM2cTJKeVhVUW1VeVdMQ0YvOFFCVjZsSHQwaGdPd0RDS0h1?=
 =?utf-8?B?Y0RTbHhUYkJQVEN0VDNUaUQzOTlyS3ptWjNGeUYvN0JCa3o2aC9wTi8yWkFQ?=
 =?utf-8?B?eVpWd1pXcExIWHNTNzVUVk4vNjA2VDVJZ3ZEWElFdllHVzVrNlVtZ2hJb2Js?=
 =?utf-8?B?c3VDbkRJT2FUc0lkKzZWSC96V2l0R0grZTcwTDR4N09DMW9rcDhiSURIQmpO?=
 =?utf-8?B?V0hIYkhsdUt5bEovSXdRdU5JdmJEWVRNT29VVUswcklkeVVRQW1ESFgyVkYz?=
 =?utf-8?B?bEdTY0YrUHFScnNrSnIyNUZBSzgwdmdHUEF1QkcveXEvYWkyZENmRXRUQzV1?=
 =?utf-8?B?OW14QkVUYnN0WWsxN1pnWG9pS2g4VFJsME96MldDUU5tMERaemRBT1FHblRI?=
 =?utf-8?B?eVdZcS94NXNTYSsrWmdBR1JiWWpmY2h2Y1lnY2IyQXI4V1h1UEpUVi9ZV1V1?=
 =?utf-8?B?UHRBeTlVeWFpN3hweFZ5UHJwaTREVG9EWVZ3WDdPVTljMTlwZGozQ3o5Qnhp?=
 =?utf-8?B?M1FOckdjY1o5dU9JSXZmeWFYV0hRVFRZK0JITlFFUUJUSUtFbXNFRjJob01X?=
 =?utf-8?B?V2I4VTRQemJGMW1NTHNGbDVUV2xIdVRDVUVWZjRhdDFjLzFSemtOUGhhbXNu?=
 =?utf-8?B?eDY1RjhnRDJJM1RUNjl6V1A5SFhkd2tYVjdhSGsvZm1JTnhtUXFKSWdNY0JK?=
 =?utf-8?B?QVEwa1NMZkdteFZuYUlzN2tpWjhKelc3NC9lV3l1U2ZDOVM3QWYrWjFqWCtu?=
 =?utf-8?B?L1dyaFNLWDhUS2VBUFBsaVBUZ1dWS3cxWXFmdXJLakMzZHhBMDBUWVY5Q2c4?=
 =?utf-8?B?Q3ZLTFA0bm9NZlplbkRuVC9BQnJVOUZpTitXNGdjZDJWTmZHWFo3YzZWWGUz?=
 =?utf-8?B?bmJUUm9RK3BudnFkcGVtY0lPQ28za21XbThCVzdydElYaXNzTCt3NVU1MkNU?=
 =?utf-8?B?dlZoYUYwVlhHNVRHTWZFb3Y1eG9VUloxY0xPNzdYdmcrUmVCNE1iams4R1F0?=
 =?utf-8?B?WWJFZ3QyZ0ZZbm54Ym82RTFISGxtT0VaSUpmQmphRjlVTGFGb1BFVlQ5U1dQ?=
 =?utf-8?B?M1J0TldveFJaNUk1UDJBVDZXTHRTQ00vbVF4cTd0dy9EL3dxZEVwM0p1b2dx?=
 =?utf-8?B?bnIvMzFFelpFZTlrOUppc2JPNXluUFZGRjFKRWJZMHZZdU1EUlltZ0h0cmdz?=
 =?utf-8?B?dEJWMFF2WnJ4N2lXdjJRVENYZlJSN1k3aXF5WHlRdy9LSEx1ZmxodjVEM2o5?=
 =?utf-8?B?S2Ria1BKVzY1M3BRNmpYdXhYQXBVVnRCMHVXejFHaGhOSUVid2daR0tGNGZU?=
 =?utf-8?B?d2NpZ1BiS2hJbVhVOUVGZFZiYzN1ZUNLV2d0c3FLUnhXZ3V4Ukx4OEJuVDMy?=
 =?utf-8?Q?VRGJir/9sukzNCtjLa7aNsyyGJAHomb+6QzFInG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df46069-88cf-4f8d-563a-08d982a52fa6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5326.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 17:27:03.3735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMPAlszjx+Xj2hytZoTWOiJ8v7wdQMRhjEeiZQ5/tvUZ7oqJc1dVBKBSaxs7zDdLH+bkryrWWRdvzV+mXPF0tZiO5Ozb9m2LG9Jgn3rytSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2841
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/24/2021 11:04 AM, Lorenzo Pieralisi wrote:
> On Thu, Sep 23, 2021 at 02:54:52PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Sep 23, 2021 at 2:26 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>>>> From: "Rafael J. Wysocki" <rafael@kernel.org>
>>>> Date: Thu, 23 Sep 2021 13:05:05 +0200
>>>>
>>>> On Thu, Sep 23, 2021 at 11:40 AM Lorenzo Pieralisi
>>>> <lorenzo.pieralisi@arm.com> wrote:
>>>>> On Thu, Sep 23, 2021 at 01:09:58AM +0200, Mark Kettenis wrote:
>>>>>>> Date: Wed, 22 Sep 2021 17:33:36 +0100
>>>>>>> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>>>>
>>>>>>> On Fri, Sep 10, 2021 at 10:32:23PM +0800, Jia He wrote:
>>>>>>>> This reverts commit 437b38c51162f8b87beb28a833c4d5dc85fa864e.
>>>>>>>>
>>>>>>>> After this commit, a boot panic is alway hit on an Ampere EMAG server
>>>>>>>> with call trace as follows:
>>>>>>>>   Internal error: synchronous external abort: 96000410 [#1] SMP
>>>>>>>>   Modules linked in:
>>>>>>>>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0+ #462
>>>>>>>>   Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 0.14 02/22/2019
>>>>>>>>   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>>>>> [...snip...]
>>>>>>>>   Call trace:
>>>>>>>>    acpi_ex_system_memory_space_handler+0x26c/0x2c8
>>>>>>>>    acpi_ev_address_space_dispatch+0x228/0x2c4
>>>>>>>>    acpi_ex_access_region+0x114/0x268
>>>>>>>>    acpi_ex_field_datum_io+0x128/0x1b8
>>>>>>>>    acpi_ex_extract_from_field+0x14c/0x2ac
>>>>>>>>    acpi_ex_read_data_from_field+0x190/0x1b8
>>>>>>>>    acpi_ex_resolve_node_to_value+0x1ec/0x288
>>>>>>>>    acpi_ex_resolve_to_value+0x250/0x274
>>>>>>>>    acpi_ds_evaluate_name_path+0xac/0x124
>>>>>>>>    acpi_ds_exec_end_op+0x90/0x410
>>>>>>>>    acpi_ps_parse_loop+0x4ac/0x5d8
>>>>>>>>    acpi_ps_parse_aml+0xe0/0x2c8
>>>>>>>>    acpi_ps_execute_method+0x19c/0x1ac
>>>>>>>>    acpi_ns_evaluate+0x1f8/0x26c
>>>>>>>>    acpi_ns_init_one_device+0x104/0x140
>>>>>>>>    acpi_ns_walk_namespace+0x158/0x1d0
>>>>>>>>    acpi_ns_initialize_devices+0x194/0x218
>>>>>>>>    acpi_initialize_objects+0x48/0x50
>>>>>>>>    acpi_init+0xe0/0x498
>>>>>>>>
>>>>>>>> As mentioned by Lorenzo:
>>>>>>>>    "We are forcing memory semantics mappings to PROT_NORMAL_NC, which
>>>>>>>>    eMAG does not like at all and I'd need to understand why. It looks
>>>>>>>>    like the issue happen in SystemMemory Opregion handler."
>>>>>>>>
>>>>>>>> Hence just revert it before everything is clear.
>>>>>>>>
>>>>>>>> Fixes: 437b38c51162 ("ACPI: Add memory semantics to acpi_os_map_memory()")
>>>>>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>> Cc: Hanjun Guo <guohanjun@huawei.com>
>>>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>> Cc: Harb Abdulhamid <harb@amperecomputing.com>
>>>>>>>>
>>>>>>>> Signed-off-by: Jia He <justin.he@arm.com>
>>>>>>> Rewrote the commit log, please take the patch below and repost
>>>>>>> it as a v3.
>>>>>>>
>>>>>>> It would still be great if Ampere can help us understand why
>>>>>>> the NormalNC attributes trigger a sync abort on the opregion
>>>>>>> before merging it.
>>>>>> To be honest, I don't think you really need an explanation from Ampere
>>>>>> here.  Mapping a part of the address space that doesn't provide memory
>>>>>> semantics with NormalNC attributes is wrong and triggering a sync
>>>>>> abort in that case is way better than silently ignoring the access.
>>>>> That's understood and that's what I explained in the revert commit
>>>>> log, no question about it.
>>>>>
>>>>> I was just asking to confirm if that's what's actually happening.
>>>>>
>>>>>> Putting my OpenBSD hat on (where we have our own ACPI OSPM
>>>>>> implementation) I must say that we always interpreted SystemMemory as
>>>>>> memory mapped IO and I think that is a logical choice as SystemIO is
>>>>>> used for (non-memory mapped) IO.  And I'd say that the ACPI OSPM code
>>>>>> should make sure that it uses properly aligned access to any Field
>>>>>> object that doesn't use AnyAcc as its access type.  Even on x86!  And
>>>>>> I'd say that AML that uses AnyAcc fields for SystemMemory OpRegions on
>>>>>> arm64 is buggy.
>>>>>>
>>>>>> But maybe relaxing this when the EFI memory map indicates that the
>>>>>> address space in question does provide memory semantics does make
>>>>>> sense.  That should defenitely be documented in the ACPI standard
>>>>>> though.
>>>>> Mapping SystemMemory Opregions as "memory" does not make sense
>>>>> at all to me. Still, that's what Linux ACPICA code does (*if*
>>>>> that's what acpi_os_map_memory() is supposed to mean).
>>>>>
>>>>> https://lore.kernel.org/linux-acpi/20210916160827.GA4525@lpieralisi
>>>> It doesn't need to do that, though, if there are good enough arguments
>>>> to change the current behavior (and the argument here is that it may
>>>> be an MMIO region, so mapping it as memory doesn't really work, but it
>>>> also may be a region in memory - there is no rule in the spec by which
>>>> SystemMemory Opregions cannot be "memory" AFAICS) and if that change
>>>> doesn't introduce regressions in the installed base.
>>>>
>>>>> Where do we go from here, to be defined, we still have a bug
>>>>> to fix after the revert is applied.
>>>>>
>>>>> drivers/acpi/sysfs.c
>>>>>
>>>>> maps BERT error regions with acpi_os_map_memory().
>>>> That mechanism is basically used for exporting ACPI tables to user
>>>> space and they are known to reside in memory.  Whether or not BERT
>>>> regions should be mapped in the same way is a good question.
>>> It is not inconceivable that BERT regions actually live in memory of
>>> the BMC that is exposed over a bus that doesn't implement memory
>>> semantics is it?
>> No, it isn't, which is why I think that mapping them as RAM may not be
>> a good idea in general.
> Should I patch acpi_data_show() to map BERT error regions (well, that's
> what acpi_data_show() is used on at the moment) as MMIO and use the
> related memcpy routine to read them then :) ?

It actually would be good to clean it up so it is clear that this is 
only used for BERT.

And then there is this question: if this is not RAM (so effectively it 
is device memory), should it be exposed directly to user space?


