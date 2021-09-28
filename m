Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82FE41B55B
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Sep 2021 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbhI1Rpq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Sep 2021 13:45:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:4684 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242073AbhI1Rpp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Sep 2021 13:45:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="288426658"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="288426658"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 10:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="456713280"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 28 Sep 2021 10:44:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 10:44:05 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 10:44:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 10:44:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 10:44:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ou94BDC1SYDKxkdW3ez4YHsKGWROYjf1038nCB/TnQ8oHbWsdknxmiJAEp7n8BubZKx+Csb5AGOMa7oN5R78kTdu6aohHS8zso2hiZLW5zj4zW35urpp6U/V/eNy+ISGxFZ4bWSwZzcEa04/zLJvuy/mppclysmmH+XPGgCuTBaOUGJW7CfBMToF06DHJGqMXTyF5kfc7jkdiYjNr+kHcAunUcmAtXGg+Y1k0V8Dku/XAGhV9TSuO2BJ5rgBhYZOPhx51zSMvMsw0Z2cVZ0yISJh26JbEoY+6l/1gN1fh0nkXh6s+hik30BnF24X9VA3cSigu3iFMJ0ELVSx3SzEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dCXYAkk2BBmmPF7M9x9PiX2xjFUlnKkjN69T/KYHkaM=;
 b=eDxZVaUqfiv2f+yzLW/caBDn5eH9w+NzlmDkZV2FhlziePbNV78DchGTpvYywMkNoXY6Cptt5z9kzcm3UFHo4ox0jKoEhiYlqA0osz4i8UK4+2GkDDAoYU+zeThxuHtQTYlsiTxOLaM1qU/pqOcBQB+uOrD7ehIGXGOCR93YJESLoW0axg/m5BbIm5m9nHdQsfMhc/0eDyl/F048K+az2AYaZjglCf48Qd5XTolVuPxydJCToMeosBc9JibOveLTz2GyjR5+x7j2q5PcDJq5gK/5ukIEhSnVpjUmgY927b1s5Gpgzx51mozQdg+rrK0+qqwN+jAuE2fv3sEP9iGxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCXYAkk2BBmmPF7M9x9PiX2xjFUlnKkjN69T/KYHkaM=;
 b=X3FBES+dW5i9DLjHvuMic8+ny5FmhoaUCBL332OaNx9EJn0q6HhgJD8dHOiyjNp87gXSyfF4Aq6lNRVVkxPFbkCb23KpClWuJNTBcIEFmt+wCAnwG0h81wdXjUp4JmMffuIOKpqqnNUl1XOaIZfEd7vH80O+fHKe9DO6CGaswkQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) by
 DM4PR11MB5264.namprd11.prod.outlook.com (2603:10b6:5:38b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Tue, 28 Sep 2021 17:44:02 +0000
Received: from DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da]) by DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da%9]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 17:44:02 +0000
Subject: Re: [PATCH] ACPI: avoid NULL pointer arithmetic
To:     Arnd Bergmann <arnd@kernel.org>,
        Robert Moore <robert.moore@intel.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20210927121338.938994-1-arnd@kernel.org>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <92b02547-3aa5-537f-a782-7a25854d88fe@intel.com>
Date:   Tue, 28 Sep 2021 19:43:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20210927121338.938994-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: DBBPR09CA0004.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::16) To DM4PR11MB5326.namprd11.prod.outlook.com
 (2603:10b6:5:391::8)
MIME-Version: 1.0
Received: from [192.168.100.217] (213.134.187.41) by DBBPR09CA0004.eurprd09.prod.outlook.com (2603:10a6:10:c0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Tue, 28 Sep 2021 17:44:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d020b049-d31c-4fa0-ec2e-08d982a78f3b
X-MS-TrafficTypeDiagnostic: DM4PR11MB5264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR11MB526491D55BBF42EEDFC979C6CBA89@DM4PR11MB5264.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stJLxnLzhaGaWME+BcthfZSU9oU0rA5Sfo+1lEad04rEVk9SdojiE4hv1u7NMB7++ky5K3Waq3Z+bSyd3Wwpnu1YQ8gojvk5R9E4BQNb4scxPjrLA+N3jLJ/ZotciWwDF+o5Y5GkNz7Bz0Bg2j90YQWRJNXm0/dQ5LIB4dhWb9IEFCR0Arav+vFQs40VelZDbUldtDxxsMMV5gPgPwqn6n2rXBx0afoWLLCU/MjFyDK2yj+fN9fnSp0nIY8K+gAczyo4eNXp5qTdEzP6NRu+EwSh+MuIbvGDTB5pSKslmk0qU+DHXQaLlYXlbQpwtXLkgqoPDgPtfEntSroK3CXlQhhYiGfNiwel5I2/YBOulAUZiVPNg1dNndBVrw6Bcv+EBxA+bV73EdMn4NigB1Y6xL2817EQdqUvRjpgOuTWHMVvaUm2aGng6ckYIHparxx/ZO7dBthOrJLlF7bSA00dX2UXI5duZRctVhsqkX3lJp5iBhuVRCvmD+87M/W1mSXbiU8NsyKygJ6wx0/M/RKhbptgfVsGc+nHs+Tw/9WD9+W8Xkeeuy6A4IIwRyqwYyv0tZ6xL8RKpfp7C1I5TNGoJS0id89BLbTI5PDUwUTsEig4WPMnKgSYVsulP4R83FtdGu6cGKzhAqgyAjyhdlwQ5cnyOWmrf1v54DJ/OSdvjEAoFtP3+p9baTX9bWd8QwTMVsOzps8A1jllYA2wVzL2QXyo0kYc3INE6yWYw38V5GObqJyGGGI1C9fzcF8tjm1u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5326.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36916002)(5660300002)(110136005)(31696002)(6666004)(86362001)(186003)(16576012)(31686004)(66946007)(54906003)(8676002)(2616005)(53546011)(316002)(26005)(7416002)(66556008)(66476007)(4326008)(6486002)(508600001)(956004)(6636002)(83380400001)(36756003)(38100700002)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlEvdS83YmVVVHI4Nys2WmFoMXBDV3dPS0dZVzNMUUNlaFJvUjJPcXdSVUVj?=
 =?utf-8?B?WTByVkxXazdDZ3gydE1HK1ZycVgxNHdMc1JFVDFUNG8vMWhqOHRTTmVNQlFk?=
 =?utf-8?B?NkxZTmdqNkhROURsOS9GL2JCNDkvRWpsQlVvbWprRDhGMjY5TDlyaGNOSy85?=
 =?utf-8?B?MHBFWmRXbW1obTlRZmRMQkl0Vi9vUGVBUjNqYlU3L2x4MXR3Q0g4enBESkRT?=
 =?utf-8?B?RXdKMFBMTTV4VWdYNHo3WE1rbjFxckNvaGFwYmN4NVNod3BmclFVOTBjV05M?=
 =?utf-8?B?SFBLcjhIL1o4ZzRhYnVKVVRFWWxrd1Jtc3BnTXd4WXk3MlFLN3h1REZXcThs?=
 =?utf-8?B?VWQ3cm9yNWRhRnpIWFVyWEtFWGFYR2RQNGw5TW9kWWZyL0VnTktOcG1jcnNv?=
 =?utf-8?B?ekxzdWw0dDdZNUE2aGMyZEczTE55Rlg5UFExTGZ2ZTUvMGZqeEpPUXUvck9r?=
 =?utf-8?B?TElsOGkzMHNielpzOTZhWnJBSWtmaFphaWxFMUpzU1VKdE51RmN6dkMrVG82?=
 =?utf-8?B?cmpNMFF4cWhJa0xHdTMxL2ZrYzRuUTgzYW9SYlRqSDhMNHkxZEUyQ2tUYjdm?=
 =?utf-8?B?bnVFUmIxZ0dRSnJPVGswaFV6T3FOa1hqUUZrSDI1Nmx2Z3dHcjlIVklyS1Ew?=
 =?utf-8?B?SFp6RThnRVJ2MTJhS0NWbWZIK1RzUmZ0anVIbCtyQ0tla1dadzB2R3MveHVN?=
 =?utf-8?B?a3hiSEV4ZzYzMllpQThrZmQ2RkZTdlFpaWZBdm80aHBpa1I0S1o4cU8zMnNm?=
 =?utf-8?B?ZVdDdW5QVnFNYWc4Z1pYUDVwTngydytKY2gwbmJpa0xoU2RpSklTVGZOVHpO?=
 =?utf-8?B?V3ZHNEkxK2U5Z05USURTRW5VOHVuRGR4d3dGQk5vcVBVSk1hYkFvMjZVemdO?=
 =?utf-8?B?SUpJQm1SY0c0NFdGZVEwVXFTTlM5NnQrck4zWHZoRkNEaE9Xa3F2a3liMWl4?=
 =?utf-8?B?U2M3ZzFqYXU1Zk93TXlISm1XQ0t4MUg2M0FiZVdjaUpKSEFNbTc1UnBTSUM0?=
 =?utf-8?B?NXRPMURXL1dVc09zZGpHT1N2VXE5WWVTMU9TWURZelZJZDJIMzBOc0tMcnFs?=
 =?utf-8?B?bk11RVVXQ2lWSHFhSzh2T0RrcGRJNm03amcvU3p0T1lPT045TE1MbEZXbHkr?=
 =?utf-8?B?cjFjV3lzQmxGY3llMVhMb2tqa1Zha0M3d3J4WGJXcUVZbER2Rm1TRUJpSmlI?=
 =?utf-8?B?QnllS0hQSnhTV0ozbE82YXBSSnJCN3MvdzVTQXZVeTRsZGoyNmI2SXhleEdD?=
 =?utf-8?B?MlNZb3NjeDVWZlJRRG5ab2JKT2ZjVktXdFNQZFR4K3phU0NrclNUUDBQaHkz?=
 =?utf-8?B?d2s0KzIzdWw3eFQ2ZEF6TklHZHZza0hZZkozYVljaTh5T21DUjFXTWFkdUVh?=
 =?utf-8?B?YjRZK2xmaEx0NDkxVXFheTBHeWFIQ1gzVGU5aC9JSTJvM0ZnYkFXM0dmY1Rv?=
 =?utf-8?B?RDljamVHQXdnR2t0WFlWMlI0MjNKZUNnNytTdmczSTBIVGV6SWlLZ21SZ3VG?=
 =?utf-8?B?RklheFRXVGlEMENaNGdmUndoV24yL21pVmNGRmlVRnE2em1DT012YURyd2U2?=
 =?utf-8?B?RGdVZEJzLzhyS3A3UDREWVFTcDJwQ0NxOFVkQjcvOG1JYlJDNElsYWhwMFBH?=
 =?utf-8?B?WmVoMUxib2tjeTlrS1pGUzVySysya2VaeTFNdzBDQkpDSjR4RlhEU0F0THcv?=
 =?utf-8?B?MCs0czFnM2NOYjJtZzJGRmVSM3huSm9LS2RoRDhzUWU1WnVrN3AyNDhqeVJ1?=
 =?utf-8?Q?PTF9qYFOwYyYhM/WixZcQ+VcaaNRQG4xE1UiB86?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d020b049-d31c-4fa0-ec2e-08d982a78f3b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5326.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 17:44:02.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUe6Goc5GJ2blhcOSZJIpfO4Rb/fBAOV+2mzbUkEKaRpaJfIp6mQrE66+oULNilqq9L8umqmpHW2/QSCbHLD2bxBDGGrNKIkZdPbOxJCB0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5264
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Bob, this is ACPICA material.

Would it be possible to apply this to the upstream from the patch or do 
you need  a PR for this?

On 9/27/2021 2:13 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> There are some very old macros for doing an open-coded offsetof() and
> cast between pointer and integer in ACPI headers. clang-14 now complains
> about these:
>
> drivers/acpi/acpica/tbfadt.c:86:3: error: performing pointer subtraction with a null pointer has undefined behavior [-Werror,-Wnull-pointer-subtraction]
>           ACPI_FADT_OFFSET(pm_timer_block),
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/acpi/actbl.h:376:47: note: expanded from macro 'ACPI_FADT_OFFSET'
>   #define ACPI_FADT_OFFSET(f)             (u16) ACPI_OFFSET (struct acpi_table_fadt, f)
>                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/acpi/actypes.h:511:41: note: expanded from macro 'ACPI_OFFSET'
>   #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
>                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/acpi/actypes.h:505:79: note: expanded from macro 'ACPI_PTR_DIFF'
>   #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b))))
>                                                                                ^ ~~~~~~~~~~~~~~~~~~~~~~~
> Convert them to the modern equivalents.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/acpi/actypes.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 92c71dfce0d5..285bc7b73de3 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -507,8 +507,8 @@ typedef u64 acpi_integer;
>   /* Pointer/Integer type conversions */
>   
>   #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
> -#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
> -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
> +#define ACPI_TO_INTEGER(p)              ((uintptr_t)(p))
> +#define ACPI_OFFSET(d, f)               offsetof(d, f)
>   #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
>   #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
>   


