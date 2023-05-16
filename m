Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6F2704D08
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjEPLvz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjEPLvh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:51:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C446A4B
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237871; x=1715773871;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=brChLY9ZURkQO9mjB10QrrEKZo6/qJoNiMzrq7ffChc=;
  b=OwQy75bp+GoQzotsmmVZ0d6hUq6B435yHHRJkeM7occM6rk0rqlgNQt1
   ZCElVVJviHqxhh0boU0jkBtJMgsRgHyuY/DsBk/wji1SuQhDWAb9WG3nK
   hdNmoB2oP3JxDk9NwC388ixfGHx0MgpY9ogYJJWLqRzdgFe3yOXwfaEnB
   1wf2cVrM6T8XvHY3yFfMzBRHuU9CiJafi/B8OWWVoZH7XL4dj46aLXWIb
   UrDUo0O1orGzGjuczhc2Te1AObST1EyCgoYoeO/Wwm0Cw9RP22VoTf5UT
   xoZSjPrOlVX0Fh+iq8rvmcjt+pY/4q1ECsRZW9Betx48M9z0sPK5zhfs5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="379629361"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="379629361"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="813387526"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="813387526"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 16 May 2023 04:50:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 04:50:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 04:50:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 04:50:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7iaJAT2OTgvkv9bUPi9HM/zSL5UW/QMeEVKZPL8wQIJB3G1gBrlQM2/r+WWX3BJ6fSZWJIPsTt/EeHHVMX346N9yCu0WcJANLx73bfceNEyDFcYjwnX/yLxdULioU53g4aN/CemEHGnXvfsu/jcfigYCi8f0OiISaH4ESB+tNw1Qa8Yp3XCF8AXfwsgq/e9nYK3fSo6QoIGfqtxKt3mO20t9G1KHiGL8f7vgn51BfC6HuirWb2Rt0R9Zlco8B4QkfI7ySDqrWl1Z3a3k2v6AZDlL6HICBAdDTPk07eV38TjMUbM6nYY1KbVJCEekVSIcF8KLCmLtBEtsBKToW/NFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxX6ABDSKa3SVOIb7NvmN7Ai+LuWPiPXq2qIjgTdRU0=;
 b=WUSEaqK4E7SRYceZmh1Y+nejd3Uf8Hvpa+B6xSbdE5HATQbn/dhp1NjUOfiWMCw43YX7DFWWIdaDdiZ87e1fNEbx1gL6Uvu/WYk+dIc4okydx9QAl6xogq303IClDZ6gmUAoSdalj+LOrJO+hXrD4dIdJOgx6GPkwudpgc0sUcy+Yjl+HbcLPQzU5wZA0r/PAxacKAhGDaUJc7tblZvd7xB0KUXMcH5IIqLkYj+POtDKwyJbzRX8tcSawKGHyccMVpH8BCokp+KB9OrZoFg86vEcY0fkuIv4m5nEixvaR2UKtG8dX1Y8xYvZeF7ysodidxzj0TkgEz+n+BnPLY2oTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by MW4PR11MB5821.namprd11.prod.outlook.com (2603:10b6:303:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Tue, 16 May
 2023 11:50:49 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::b42f:7e57:d100:6c60]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::b42f:7e57:d100:6c60%6]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 11:50:49 +0000
Message-ID: <a73d08b1-2786-2641-53da-2dc9e23aed85@intel.com>
Date:   Tue, 16 May 2023 13:50:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 00/34] Remove .notify callback in acpi_device_ops
Content-Language: en-US
To:     <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>
References: <20230516114617.148963-1-michal.wilczynski@intel.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <20230516114617.148963-1-michal.wilczynski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0132.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::17) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|MW4PR11MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: c439252e-476d-4e97-918f-08db5603cb0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YROWwlw+1rAjqBghasseyaY849SXkkzqnrbjwXix4/qPYWCqncm/NrOvu9ESJ4hK4e4ma6ZNXSf/J2AyTbqNGAgTwOzMPXQFNgTFjTNol7YYsdP65iAoDPAZJBfRtuZaB6riX0cFQsqDvzqSJkHhVMaLLNy/7fSslZHfQD17L9nJQ6Suu957ApYp4gkyWbcdK2xQIvH3aohF4Uu+P65xpX0j2FUjvOeM97fFaC+MAvmznIwfMFgbLr8IHBolSo0tqvPPZgwnB4/u/mJEvr5dmgHsm2b5dlwxHLwepvYfjFD+pzm0acboZ9aA4c11zJexuikVEa3QglXNwH0AtZDFi9+gOvejjLsUX6cjnQ5Uh3DKlEQEBuaY9oLKcdo9U2mvYSciEwhc46q2e3ivKGw5YexmP0PswV/wOltwQIsz0CjINkpXrYvg3JdkEfJ67UbbPAjS4HwWq5tlqv9MS+E9hBwRYNevVE0NgpVwXBBGqWRQ0hdMCwZyPxCcELXI5i9UN0FOvFn1i7YvoqcM5B4oIXAJBaW+s1YAoky95Fm/X3KE0KqFV6qg+dzk41zfxLaylR8BiIz5VTO1zGpOeXUV/destMDAGsN9UEkdPLBQeNWbUqhEZM28sRaq6bDUiNdvRtdT+KE8+SUYNSFI1IQtTRyWrn/wl76u5b7EaXKfCxg/kBTwRKsP2l+XjzRIH7Uq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(36756003)(83380400001)(6666004)(6486002)(2616005)(186003)(478600001)(6506007)(6512007)(53546011)(26005)(2906002)(38100700002)(6916009)(4326008)(82960400001)(5660300002)(66556008)(66946007)(41300700001)(8936002)(31696002)(86362001)(316002)(8676002)(66476007)(31686004)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2k3STVuTmh6SXZMR3FiQlBGd3hrZjRyYWFoaHV1VUJ6RlBlMDVnU2FoUU13?=
 =?utf-8?B?Nm4zT0RaMTdqc0haVjN2VXk4VGdqSFZQNzlma283ZnlLYTdkU2tuZWQ2QWo4?=
 =?utf-8?B?RnRERjdWU3VsQXFraGlwNmZRZHZzN0xITVRiU0VRYlJTNUZaWkw4R0EyZVcz?=
 =?utf-8?B?V1hOOUlmZnF4Yk1xSjhkV2h0cVVQV1R2bXZmZUYzRTNFWnZqTGpQbWN4c3BO?=
 =?utf-8?B?bmlhcWdTZjFTVmV0WXJRaC82ekwwazJSdWJuMk5rMHJYUy8yNUpIWWFiY1RH?=
 =?utf-8?B?SEd0M3lENkRPTUdZUjZzV2VzMVZadGp6cWt5NDdLciszcG5oR0tIaitKRUJs?=
 =?utf-8?B?UkFMZTFnSXkvaUhpYTFsYkh2UjNXNUxnRXB0Rm5EKzdTU0pPUk1YQktnWWRL?=
 =?utf-8?B?MndiaGdXS0xQbUJIT0M3MGxnb3dlcWg1UVhBYmhhYSsxWUlIb1p1YjNHenBu?=
 =?utf-8?B?aENpUzNMOW9zQXhSRFVzcVJsd2JLL2lPbWlicWZZelFsN1BqKzhsRHVEWlFW?=
 =?utf-8?B?TUk4QmNlL2dHVW1ub1hoRWQwMXNTcG9DLytWbkx2QXA1ZVRGcXhUbXZMOEJi?=
 =?utf-8?B?dXZqc1l5L1FwUzJXVENIaWRUYjRQTUgxYXVzWjlrekxWcHJCcDVGKzh6MHBr?=
 =?utf-8?B?VDFCeTB3VGlXZWFOLzZJbmp6eVZPenBNd0lwcGtjN0x3eU41TmpGY09kRFR3?=
 =?utf-8?B?RkI5QzFGdUNaQWRERUdJSGIyMU9jVERSVlhZK3JUajRJUzRhT21WaEpweTJG?=
 =?utf-8?B?SDVaeEphNzZ2cDBMNFBqZytaa0s5VlZHeHh2Q3d4czgvMUhoQit1dE42T20y?=
 =?utf-8?B?TUF2VVQ1eHkvK3AxeUdDWmhhNEJzSHgzYVRoVU8wSGF0Rnh3Q2h3Zkl2dFNq?=
 =?utf-8?B?SGpubzNIdjAyd2crZUVPYnExd0RFOXVjaEswSWV5MjFwQWRkbXBpVktpZFFQ?=
 =?utf-8?B?ZUNDOStqaWtmT1RXakR2OXk5dVpBNzhNb2hVNS9XTVZTNDgxa0xmVzFKVkRa?=
 =?utf-8?B?VzlPK0x4Y0ZkUm5QTjZTNVlTSm9rcUM3TUVqVW9ESG5FWlJ3cWQ3TkttZmRC?=
 =?utf-8?B?aTRzVkltanNYLzVkT2dra2ZOZG9kcnQwWVBGZEJNQTVJVDlUYXZRbDdma1hK?=
 =?utf-8?B?dWZiT3RKT1VyMHBld29QQUU2bGw4RG5uM0FwczE1NzFDdlY5ZE1vY2hsQ0E1?=
 =?utf-8?B?VkV3K1BTUkQxZ3h6b2JqamhnYXgwci9tZGNxbStMQVkydW1rVW9aQkkwS0Zo?=
 =?utf-8?B?UHpmbmZWMkJYeERaLy82bEsvRmZpbW1lZ0hMY0JUR2NVUk1lUGpHb0FLOHFG?=
 =?utf-8?B?bTRKdnR6aXNHdHlmVlZhVjZXelVCMDBNa0NIV3A3bml0eit2a3U4di9WU0xS?=
 =?utf-8?B?U3Q4aFN3RkhKYVVLcm1ndm9kYjNXOU5wa0NXMGFuMFB5dDZmejdZRUJiaUIx?=
 =?utf-8?B?SXhYYjdxck5rTFZ2THdtYWNPclIrZzdGNzZURHF3ZGk2WDZMelF0RWlDeDJU?=
 =?utf-8?B?blBxYStOTHN0VDc2NkNyamJKNmRQZG1OYTRsQ1hFNzU2Qm4ySjRsbkJ1cHlM?=
 =?utf-8?B?RmpNVURzNTVONG9sMkgxa0ppbmhXQk43NkVLa2ErOE8raTJzbXhzYU5Xdzli?=
 =?utf-8?B?Q1ArOTlDUk8yYnBlYmR0aFRrbHVXNWRVVG5FdjY3WWQrNnRPdWJIaVRZUXh6?=
 =?utf-8?B?RVRQV3lRQ2xraUVPMkJPbzlzM1lucFE2VFN5WWtCQjZBajlTeGJkckRObEJI?=
 =?utf-8?B?NEY3OExsNVBKZ29HWldrSmpVUHJxS21lcG5nQjFNUGZuaFZwOHZ1Nm8ydEV3?=
 =?utf-8?B?WkZBbzBycTcrQVUyaXFYeDU4WlhBQXB5Yll2NW01Z1ZFbVp4czVOa2NjLzhE?=
 =?utf-8?B?ZzdIV3o4NjhoaDU0RDk4SktLSlVYZGY4VHdvbE1xaUJzbENwNkt6cnM5UGs3?=
 =?utf-8?B?VTJURGpnSnJYNUdXcFdwajJ4ZVpQZ2xnNmJ5ak85K2g3UHVHVStTemZxS1Vp?=
 =?utf-8?B?SVRhaHEybGZpeGE3VDhsNU1xYVpBS3crSzNTelVMUitRTGI2M0ZFMkRnTVZM?=
 =?utf-8?B?R3ZXb3lMdGRYS2s5RHBrbkllS25jQ1VMNnEyQ2gvZHRBMXZNMFc3VUdMYVdn?=
 =?utf-8?B?c1hUbjlhUWdtaU9kSDBjMUE5bkVJc0dOVzdTdHRMTmFIU3VTbDA5R29hSTBC?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c439252e-476d-4e97-918f-08db5603cb0d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 11:50:49.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88GNAKzNBUrkl/UQQNjrTjxkGVKjhLJtQXckjrXiwgcyFv2yevgn+FXXWiBru3kMfK1FJlVmR9VtRJclv0QCSmxdd9wj9hoshSu0SIH4pSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5821
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 5/16/2023 1:45 PM, Michal Wilczynski wrote:
> Currently drivers support ACPI event handlers by defining .notify
> callback in acpi_device_ops. This solution is suboptimal as event
> handler installer installs intermediary function acpi_notify_device as a
> handler in every driver. Also this approach requires extra variable
> 'flags' for specifying event types that the driver want to subscribe to.
> Additionally this is a pre-work required to align acpi_driver with
> platform_driver and eventually replace acpi_driver with platform_driver.
>
> Remove .notify callback from the acpi_device_ops. Replace it with each
> driver installing and removing it's event handlers.

Forgotten to clarify what changed in v2.

v2:
   Fixed compilation errors for various drivers,

>
> Michal Wilczynski (34):
>   acpi: Adjust functions installing bus event handlers
>   acpi/ac: Move handler installing logic to driver
>   acpi/video: Move handler installing logic to driver
>   acpi/battery: Move handler installing logic to driver
>   acpi/button: Move handler installing logic to driver
>   acpi/hed: Move handler installing logic to driver
>   acpi/nfit: Move handler installing logic to driver
>   acpi/thermal: Move handler installing logic to driver
>   acpi/tiny-power-button: Move handler installing logic to driver
>   hwmon: Move handler installing logic to driver
>   iio/acpi-als: Move handler installing logic to driver
>   platform/chromeos_tbmc: Move handler installing logic to driver
>   platform/wilco_ec: Move handler installing logic to driver
>   platform/surface/button: Move handler installing logic to driver
>   platform/x86/acer-wireless: Move handler installing logic to driver
>   platform/x86/asus-laptop: Move handler installing logic to driver
>   platform/x86/asus-wireless: Move handler installing logic to driver
>   platform/x86/classmate-laptop: Move handler installing logic to driver
>   platform/x86/dell/dell-rbtn: Move handler installing logic to driver
>   platform/x86/eeepc-laptop: Move handler installing logic to driver
>   platform/x86/fujitsu-laptop: Move handler installing logic to driver
>   platform/x86/lg-laptop: Move handler installing logic to driver
>   platform/x86/panasonic-laptop: Move handler installing logic to driver
>   platform/x86/system76_acpi: Move handler installing logic to driver
>   platform/x86/topstar-laptop: Move handler installing logic to driver
>   platform/x86/toshiba_acpi: Move handler installing logic to driver
>   platform/x86/toshiba_bluetooth: Move handler installing logic to
>     driver
>   platform/x86/toshiba_haps: Move handler installing logic to driver
>   platform/x86/wireless-hotkey: Move handler installing logic to driver
>   platform/x86/xo15-ebook: Move handler installing logic to driver
>   virt/vmgenid: Move handler installing logic to driver
>   acpi/bus: Remove installing/removing notify handlers from probe/remove
>   acpi/bus: Remove redundant functions
>   acpi/bus: Remove notify callback and flags
>
>  drivers/acpi/ac.c                             |  14 +-
>  drivers/acpi/acpi_video.c                     |  18 ++-
>  drivers/acpi/battery.c                        |  14 +-
>  drivers/acpi/bus.c                            |  53 ++-----
>  drivers/acpi/button.c                         |  18 ++-
>  drivers/acpi/hed.c                            |   6 +-
>  drivers/acpi/nfit/core.c                      |  25 ++--
>  drivers/acpi/thermal.c                        |  20 ++-
>  drivers/acpi/tiny-power-button.c              |  18 +--
>  drivers/hwmon/acpi_power_meter.c              |  15 +-
>  drivers/iio/light/acpi-als.c                  |  23 ++-
>  drivers/platform/chrome/chromeos_tbmc.c       |  14 +-
>  drivers/platform/chrome/wilco_ec/event.c      |  19 ++-
>  drivers/platform/surface/surfacepro3_button.c |  19 ++-
>  drivers/platform/x86/acer-wireless.c          |  22 ++-
>  drivers/platform/x86/asus-laptop.c            |  16 ++-
>  drivers/platform/x86/asus-wireless.c          |  24 ++--
>  drivers/platform/x86/classmate-laptop.c       |  12 +-
>  drivers/platform/x86/dell/dell-rbtn.c         |  15 +-
>  drivers/platform/x86/eeepc-laptop.c           |  18 ++-
>  drivers/platform/x86/fujitsu-laptop.c         | 103 +++++++-------
>  drivers/platform/x86/lg-laptop.c              |  12 +-
>  drivers/platform/x86/panasonic-laptop.c       |  17 ++-
>  drivers/platform/x86/system76_acpi.c          |  28 ++--
>  drivers/platform/x86/topstar-laptop.c         |  16 ++-
>  drivers/platform/x86/toshiba_acpi.c           | 131 +++++++++---------
>  drivers/platform/x86/toshiba_bluetooth.c      |  28 +++-
>  drivers/platform/x86/toshiba_haps.c           |   9 +-
>  drivers/platform/x86/wireless-hotkey.c        |  23 ++-
>  drivers/platform/x86/xo15-ebook.c             |  11 +-
>  drivers/virt/vmgenid.c                        |  30 ++--
>  include/acpi/acpi_bus.h                       |  10 +-
>  32 files changed, 497 insertions(+), 304 deletions(-)
>

