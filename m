Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C1C7065E1
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 12:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjEQK7L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 06:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjEQK7B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 06:59:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A35B97
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 03:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684321116; x=1715857116;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Do3SigHW2jPS4Q6THCNThOAZGfye7D5aLigbu/p47fg=;
  b=Pf8719SbNElP8ckNow/unvW1+sYpOWQYLxL0mHU/P4i6Z8l048lVWewr
   mNWYtUsa13aJ7vHMqrhMwDRqcSNWzunYgzBNhcC6OhkVVRXFQ2lnjuZ8a
   Cqd6va7XQkxBSoJUaewsvG8CKiUkr3tNfZ4VZs95Dz+MKxz83zHvrEyOa
   Pf9oW6d8fh6cp0KikBpexJe6K+EQFA9+TB1MdZhfgXNa1Ai1Lzn36i5BG
   hd7Go3aJt5pLWexrOqI/vNEmnQzHApAH5aKaaP/2t7XkNoXOYsOXInv0f
   pc350YxHm0d2RixYZyrRFGCzHYMIOgCqhqrV/ydkvrdmm0VpE7LHmku9Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415139512"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415139512"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 03:58:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="813816383"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="813816383"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 17 May 2023 03:58:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 03:58:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 03:58:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 17 May 2023 03:58:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 17 May 2023 03:58:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfqOvnlpKsBy+uo9So0ZSeMk/dObZY/olD8JIoqwJ+zW5H84uUZ7HKq3Xu4oED7FOm+0QFAHnnDbkA7/MTEV0y3k85x7jVZ70fACs8oiKBNuPc/ThElpGqzuaVIkWaco2sJd5BoeKm1MZ9mpylFcmOGrdmQOfRQXsEVWxMTgtxas60MEY4RRLhhfiaQ/Dy2K/UO5LT0jzYK2QTXBy9crXTOu5lhyUvfpUZKJqXouc2l2B/mh71n7x7UncMalvWvqi2edvnWoSsyt3GalnxUTIOlJf9bvjxVPgWoOfxhgxXAgzHXLkn++lnU/vyjEHG4GBXbe/9Qsq4dhqzfZ+M2QCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFsSNH2oMSFPYR+ZmV+HU4yymKVyxia2EE6S3SqBYm8=;
 b=e9HxB1GUFSGmrYqmy/ZFuK0SOSggcQg+RSQOQmLlG93JbwupKcx56DA1oQNTeOe4l40J/VonoqgtkLZhCxKNulpnpdzf6xOV0uRhp0fArNkGOv+VJJ5W9VZY0rxPRgS6vgbwF+K6W/Wl/L1UHieyorG/5813Oici2wMKeaIw15sRZEsz5J9nuBq8BqtFt2GuCdzb5j11EFxE0XKhlxULy6BdxmqKWED8sqEoHWR+cfxWDElP/RB9b9VUurF/lxF6saeuagu1s3ihO34rVgMw9+Pdi2HyU4q2p5vlpHhpMG2KfP5aBJwbs2nVzvh9XDGrWAU52yHMaA8b9ztaBNW+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by CH3PR11MB7370.namprd11.prod.outlook.com (2603:10b6:610:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 10:58:08 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::b42f:7e57:d100:6c60]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::b42f:7e57:d100:6c60%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 10:58:08 +0000
Message-ID: <6b9031c5-2e60-5fd3-f1ed-9e46925bdb9b@intel.com>
Date:   Wed, 17 May 2023 12:58:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 00/34] Remove .notify callback in acpi_device_ops
To:     Hans de Goede <hdegoede@redhat.com>, <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <srinivas.pandruvada@linux.intel.com>
References: <20230517075724.153992-1-michal.wilczynski@intel.com>
 <1454e65b-1d99-4542-fdcb-e72b1e447b1c@redhat.com>
Content-Language: en-US
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <1454e65b-1d99-4542-fdcb-e72b1e447b1c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::11) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|CH3PR11MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: c0425d3a-73ca-4922-fa7a-08db56c59900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lwj9o9VvDJ4L5CDuAPWIaQQhiuxbXFubw67EjwkJaGqCmVPdaMkWgQMU31u7+sorcBPEY2v12C1TNsjGHccg+3kXrksO8kmAYle0+1R/1LmZ/Xbe/a6SE1f9dMk8tveQK3dxPYuVp5+fLTt9/VRGAyBRpXwdH3DTxlNBlzbcgyyxyuAMV6Ecdt1ca1XUXy9969ARTYk6Yj4UEX0DSS00DqN6h6I2RsX8aJE6Ap3wpLZWu5In1aZDg3A9JpmFKdwY1O3pfjCA3aYqVIBgVi/xhnHgiMwj9JCfN9Nq/SQBmUnmwn0araU956VTRp7yG9e6QRcPSg4bG4IBvW16e21FYg7AG2QW3HCHFdUdTDnlUjR36jLxg433sE3wnbvVYvZN8XvkexZGGEcBgs59JFnNl0NiCnbwMM4pg0c6PLbDDKUOGj1k3kq0peJMnvpxy4jLcKagatLFZzFXzuhaIQMXA4zcwDMbWhrQ3u+UBaQpHRYT647iCwaHlhbbnS14wHa8W6PSuHc93HWVCa3RtbXWTBL5N80HN48YGVJVvp1L/GZdIurE9jXhWZBSJKz4shL5qAJKPBvf8zEOFKMMBqwqtLLZr+KjvQF9JgQTUrQH9jPiYSnRp1sTEpZxShlZL1+7j8pj7q5VCWCLy5UMZUMl2/W+AhcacG7p7MgvsrkhjZdtY4fItiORw484Rt/l3q12
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(2906002)(478600001)(316002)(41300700001)(6486002)(66476007)(31686004)(4326008)(66946007)(8936002)(8676002)(66556008)(5660300002)(6666004)(6506007)(6512007)(53546011)(26005)(186003)(82960400001)(2616005)(36756003)(83380400001)(86362001)(31696002)(38100700002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDBDTTdiYmM2NGw0cXR2NjUrWjY4VXI0UTY5TDBkN1QwR3A1THBoeURsdlow?=
 =?utf-8?B?WEUrai9xRk1zeFlyTEdmMSsxUWdpeTF2UHpySmhwdnVEMlhmWGxINnhCYk5r?=
 =?utf-8?B?cUtLZE1aVHVxbWxCUVJBTWQ1VlNMa05Rc2hjVWtWU1dkNlg4QVg2QVE5eXhH?=
 =?utf-8?B?UkNKTGJzUnB3eVo4SVdXMGdyMFlYckFuM095NUpaMXA5R2Rad1FnaWFEN0VZ?=
 =?utf-8?B?eWIweXFRUDFhdjVIQnM0OTRxZW4xalkvOVc3ZWN0dWQ5ZDFDM0c4NXFNZ0F6?=
 =?utf-8?B?Q0ViK2ZVaWN3UVR6eHdsT0pGdHNCTXljejFBM3VHTExSQmxUU2VDRnRqL05V?=
 =?utf-8?B?c1Y4cWUrUGFrZGV6R2R0WE5YKzJvR3hlaDQ5WjFsUXU3S0RJMEYrb0tkU09B?=
 =?utf-8?B?Z3FSL2ZVeWE5ZTFvem1IcXJGUjlFWGVwNE5DMzFqNlV3SmR6cUF1MjJydGpy?=
 =?utf-8?B?eGtTdG1QbUgvMnBnR0JpNnFBb21XdVgwbU9kRlJPaUc3SmhrWlBPdUwyQ1l0?=
 =?utf-8?B?alFTaTRFaW9qdlRnRWhJdEJ3aWZPay9NMkhKWmNBWUFlaFFwRlVNZk5EREl3?=
 =?utf-8?B?N3lEMDJ5WjlCS1Z5ZVVFWnUxakdDUURUdEszVG5NR1JoeXN6WlhrV2RxQ05h?=
 =?utf-8?B?Nm9kOW5hWU5rMFZWS0VKTURodnBVdkRmcGhadjBVM2Z5M29XS3RSek1wYXhL?=
 =?utf-8?B?SVhHZ1d6NHhmVmw1UU1yQXJ1cUtrM0VpeEg0SWlxR3A4RGZuU2RVdWRhODc2?=
 =?utf-8?B?VGUyVmJ2eXM1djA5RkdxMGZFaTE0SVlaeDBwQzlVQUlsUUg2TzVPYjRLbVc2?=
 =?utf-8?B?UCtKZG5ad1pBUng3VTVIUE5VdTJXTmQxTmM1OUdlbjh2RktSY2pGWE1QMWxK?=
 =?utf-8?B?UTQ1YWgzK08xakhUNzcxeThXa2xESmVtNUkvc1JrRVVLdEZIZXI5RmM3MER4?=
 =?utf-8?B?VHo4VHhVdE9Iem9sT1F2dzdEa25qd0cweE5aSHdmZmNKN05CTVVZUEV6T3R5?=
 =?utf-8?B?K2NOcStpMGFVeUFKWG1ycUppekR6b1M5NmdhbGpkVU8zdzVOLzdkZ2ozbU5p?=
 =?utf-8?B?cjF2L3YvREZseE5zeWZXZ2ZiMmdZRDk0UWlHaFlycHBaczcxb2xhU0ljaFNh?=
 =?utf-8?B?K0hhakN5TzZER3RIQ24xZjRPVWpqZ1hrdHhBNysvNTdOTU9SRmJmU21RU0Iy?=
 =?utf-8?B?Um1sUFpDTEp3YXg4V3hpcXQ4emhJY2lEZ3cxZEI5SHZmZXRQT25uM2l0Mmd2?=
 =?utf-8?B?OXdaelZDMkVxSTFkRUFqd2w0Z1VhczB4TVhzSHBmRkRmVHBFVUtHWjRCSVZk?=
 =?utf-8?B?QzIxUTJYZTJVZjJnUWpOTGgya0FrdlI1REZSSjc4cnBBUHdJS0ZqNU9IQytu?=
 =?utf-8?B?SkhDR1h0NVZ5RElOcnhmeHZ4ZU5mSkZVUXNqSzJQOVI2REszZGIxeTNFbm1P?=
 =?utf-8?B?TkRYU2U2YWVDYTNiQWVPSnV3eHYybWhFcWxXd01pUmUrT3hJclNpbkt3b2FN?=
 =?utf-8?B?cTA5SDNGYkhGWHFybnlNTldlNVRpdVhKanlNcS9LN0ltZUxWM0sxNFhFTkVk?=
 =?utf-8?B?OE45bUl6Slk1dTlzREVrMG91STRLbFphTnRZUithbGZOeUdFK2c0SFZYYVZx?=
 =?utf-8?B?MnlkOHBEWkl4dlVkRGVPbWFhTXpSYkhpeVpXakNlb0dqRVB4VFpxTTNJSjhO?=
 =?utf-8?B?UWh5ZkYzbzEzeVlMdGh4dHVwWThpQTQzOHg2SFdNa1czd2szWTE5RzNyWGxR?=
 =?utf-8?B?VmY0RlFXV0cxYkw0VDYwcVRlTm00Q3EzOUVNWEJNTHA2Q0F0SWhxdXlONFBz?=
 =?utf-8?B?SDJoalhiVlRoSFZESkNndk1mTnRmcWc5dG9KSUZhR1I3Zzh0cXJxdld6ZUxu?=
 =?utf-8?B?b0JadFFMeG5rTG1NbXBvbmZiZDhsSWNvUGlFcnFOeUFuQkNqeFlqZ01jalRt?=
 =?utf-8?B?VVZva2h5MTZ3Y21sOW9oazRIbEVLbGRxLzhVSXlzSXIwN2R3bzZvTEZxeGk5?=
 =?utf-8?B?TGFDU0lXV1NxS2haOFRhQjhRM3g0T29pSnJZaldYZk1IaDNGd3NiU29kTDhO?=
 =?utf-8?B?S0pTV1hhMjRjUTZkcHJIZHBlcWs3ekl3VzNXQXhpclBEQnN5UzQyemw2eUx1?=
 =?utf-8?B?RXMvMk1CWEx5MEs4ZU9zd3NGdGhXZ1FWblFZNDFwUHdwa3Z3T3RlOC95Q2xT?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0425d3a-73ca-4922-fa7a-08db56c59900
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 10:58:08.2822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypFAfV0WbzIIEmUuI3RhFIhZbsTMm5iZVzUIRmE5i47/BpkzWhTFEEFNrwnPFi6xJfgg+h/4wPwadRQtuWEExexnzKNrvdqvGKcndf4G/vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7370
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 5/17/2023 11:35 AM, Hans de Goede wrote:
> Hi all,

Hi,

>
> On 5/17/23 09:56, Michal Wilczynski wrote:
>> Currently drivers support ACPI event handlers by defining .notify
>> callback in acpi_device_ops. This solution is suboptimal as event
>> handler installer installs intermediary function acpi_notify_device as a
>> handler in every driver. Also this approach requires extra variable
>> 'flags' for specifying event types that the driver want to subscribe to.
>> Additionally this is a pre-work required to align acpi_driver with
>> platform_driver and eventually replace acpi_driver with platform_driver.
>>
>> Remove .notify callback from the acpi_device_ops. Replace it with each
>> driver installing and removing it's event handlers.
>>
>> v3:
>>  - lkp still reported some failures for eeepc, fujitsu and
>>    toshiba_bluetooth, fix those
>> v2:
>>  - fix compilation errors for drivers
>>
>> Michal Wilczynski (34):
>>   acpi: Adjust functions installing bus event handlers
>>   acpi/ac: Move handler installing logic to driver
>>   acpi/video: Move handler installing logic to driver
>>   acpi/battery: Move handler installing logic to driver
>>   acpi/button: Move handler installing logic to driver
>>   acpi/hed: Move handler installing logic to driver
>>   acpi/nfit: Move handler installing logic to driver
>>   acpi/thermal: Move handler installing logic to driver
>>   acpi/tiny-power-button: Move handler installing logic to driver
>>   hwmon: Move handler installing logic to driver
>>   iio/acpi-als: Move handler installing logic to driver
>>   platform/chromeos_tbmc: Move handler installing logic to driver
>>   platform/wilco_ec: Move handler installing logic to driver
>>   platform/surface/button: Move handler installing logic to driver
>>   platform/x86/acer-wireless: Move handler installing logic to driver
>>   platform/x86/asus-laptop: Move handler installing logic to driver
>>   platform/x86/asus-wireless: Move handler installing logic to driver
>>   platform/x86/classmate-laptop: Move handler installing logic to driver
>>   platform/x86/dell/dell-rbtn: Move handler installing logic to driver
>>   platform/x86/eeepc-laptop: Move handler installing logic to driver
>>   platform/x86/fujitsu-laptop: Move handler installing logic to driver
>>   platform/x86/lg-laptop: Move handler installing logic to driver
>>   platform/x86/panasonic-laptop: Move handler installing logic to driver
>>   platform/x86/system76_acpi: Move handler installing logic to driver
>>   platform/x86/topstar-laptop: Move handler installing logic to driver
>>   platform/x86/toshiba_acpi: Move handler installing logic to driver
>>   platform/x86/toshiba_bluetooth: Move handler installing logic to
>>     driver
>>   platform/x86/toshiba_haps: Move handler installing logic to driver
>>   platform/x86/wireless-hotkey: Move handler installing logic to driver
>>   platform/x86/xo15-ebook: Move handler installing logic to driver
> Michal, I just stumbled over this patch-set while looking at
> the lore.kernel.org linux-acpi archives...
>
> 17 of the patches here are for platform/surface or platform/x86
> so I must say that I'm quite surprised that
> platform-driver-x86@vger.kernel.org is not in the Cc for this patch-set?

Sorry, that's my oversight, will fix as suggested

>
> And several of the pdx86 drivers at least also have individual driver
> maintainers which should be Cc-ed. So that those maintainers can
> hopefully help with reviewing reducing the workload for the subsystem
> maintainers.
>
> Please make sure to run scripts/get_maintainer for all touched files
> and put all the relevant people on the Cc. Either do so for a future
> v4, or if there is no reason atm to do a v4, please resend v3
> with the Cc list extended.
>
> Regards,
>
> Hans

Thank you !
Regards,
Michał

>
>
>
>
>
>>   virt/vmgenid: Move handler installing logic to driver
>>   acpi/bus: Remove installing/removing notify handlers from probe/remove
>>   acpi/bus: Remove redundant functions
>>   acpi/bus: Remove notify callback and flags
>>
>>  drivers/acpi/ac.c                             |  14 +-
>>  drivers/acpi/acpi_video.c                     |  18 ++-
>>  drivers/acpi/battery.c                        |  14 +-
>>  drivers/acpi/bus.c                            |  53 ++-----
>>  drivers/acpi/button.c                         |  18 ++-
>>  drivers/acpi/hed.c                            |   6 +-
>>  drivers/acpi/nfit/core.c                      |  25 ++--
>>  drivers/acpi/thermal.c                        |  20 ++-
>>  drivers/acpi/tiny-power-button.c              |  18 +--
>>  drivers/hwmon/acpi_power_meter.c              |  15 +-
>>  drivers/iio/light/acpi-als.c                  |  23 ++-
>>  drivers/platform/chrome/chromeos_tbmc.c       |  14 +-
>>  drivers/platform/chrome/wilco_ec/event.c      |  19 ++-
>>  drivers/platform/surface/surfacepro3_button.c |  19 ++-
>>  drivers/platform/x86/acer-wireless.c          |  22 ++-
>>  drivers/platform/x86/asus-laptop.c            |  16 ++-
>>  drivers/platform/x86/asus-wireless.c          |  24 ++--
>>  drivers/platform/x86/classmate-laptop.c       |  12 +-
>>  drivers/platform/x86/dell/dell-rbtn.c         |  15 +-
>>  drivers/platform/x86/eeepc-laptop.c           |  18 ++-
>>  drivers/platform/x86/fujitsu-laptop.c         |  19 ++-
>>  drivers/platform/x86/lg-laptop.c              |  12 +-
>>  drivers/platform/x86/panasonic-laptop.c       |  17 ++-
>>  drivers/platform/x86/system76_acpi.c          |  28 ++--
>>  drivers/platform/x86/topstar-laptop.c         |  16 ++-
>>  drivers/platform/x86/toshiba_acpi.c           | 131 +++++++++---------
>>  drivers/platform/x86/toshiba_bluetooth.c      |  30 ++--
>>  drivers/platform/x86/toshiba_haps.c           |   9 +-
>>  drivers/platform/x86/wireless-hotkey.c        |  23 ++-
>>  drivers/platform/x86/xo15-ebook.c             |  11 +-
>>  drivers/virt/vmgenid.c                        |  30 ++--
>>  include/acpi/acpi_bus.h                       |  10 +-
>>  32 files changed, 457 insertions(+), 262 deletions(-)
>>

