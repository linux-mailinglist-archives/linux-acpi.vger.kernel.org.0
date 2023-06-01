Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D4771A0C1
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjFAOqI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 10:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjFAOqE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 10:46:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7578CE7;
        Thu,  1 Jun 2023 07:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLlnWM4R7T8GcUZ2sR4AZ+Gvbmcm8tEhxN69kAi7dnNPV/iE75HuXXI3k45sLo5gPWOf71U4xA76euqFoLH1jgpy03gfAd/b23OAzo5TczLVDT40f3s/IHaIK82B20fVsGkd9P44dB9pCe8w1gW3HjCNSCXaYMV3zuaW7Wca9f1lnHvQbIe/umXZUcVibzlT+aVM9UmwsetGe6mDeozwUAks99N+gdEGfC9VwH0aBn52iV9T4wXuyfKK/Zd3pr0p1V2HAaHq/8puh+FG9EEiEqQ0yeHUuJYDqJ+deX2BESCBsyUx11S8GMLFJsxUotyNWFRr1RaFY5WR7QwaOTzr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHgX0QxD53vuED11pnWmBT5jH+6FsCwy87sBvgUk/FM=;
 b=O+BKXAPaAAlH2riS0FtWR4DXU+eEXdoaQLaiRj86kiYWFpGAimc3v1VIFi+Da6niq1wNrCB0fZCLBud2ZxCrgCQxr/8Q2splQ6W3F+ARReQ1wnzu+O2Hm9tnugMDnDNRxcXOgu/9ONsuEvSIToVeqXPdIBvMrgE2nz40k72WA0ZYU6wiFuFOwmTBy6BI39lfr/rQjmQ2iKwnHoR2WJ0zohLCuWq0Zyv6le3gZDEzk7iKyCuhi9Vd9oV5BQGZtiDfMlJwTqLGVjoERM4xFA/GLoK1sAEFtztrQjeOt3hFA0vbnQX+zQRCOWleUpetyND1rbnj9PSE/OHA3Q7DTeNfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHgX0QxD53vuED11pnWmBT5jH+6FsCwy87sBvgUk/FM=;
 b=eJKBFBdlbM82ThUr06bmm06KboA8W6M8PnZMmQczDVZHr4s+uWZA/3sJTPZY7UFJBjMkNbDw03rtD9sIM9cRujYK/MhMS+yjhebkSuucxBW6v6rQKraTPCc8M+0fS1IrqBYhDBtH7YierrSlHthEEoOzEwhIbWbhB7yHZtS4Zik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 14:45:44 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::bff2:b08a:4624:ec2]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::bff2:b08a:4624:ec2%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 14:45:44 +0000
Message-ID: <bcb655db-4a7c-9323-34b5-8a4df753a0d8@amd.com>
Date:   Thu, 1 Jun 2023 09:45:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ACPI, APEI, EINJ: Remove memory range validation for
 CXL error types
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Cc:     yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20230403151849.43408-1-Benjamin.Cheatham@amd.com>
 <6477bcbf96b48_168e2943b@dwillia2-xfh.jf.intel.com.notmuch>
 <647817212bcf1_e067a2945@dwillia2-xfh.jf.intel.com.notmuch>
From:   Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <647817212bcf1_e067a2945@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0086.namprd11.prod.outlook.com
 (2603:10b6:806:d2::31) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d10c63b-d844-4535-6446-08db62aee115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2elQLBW1Vk/wMNaPxQxamHZvXnKai5zBTqLVsLKLJVwi8AB0P2K2yX7m21GTQMaExcD9Q9qI136BdMvK+F2Nw/Hxd7miiYssMiw/0dNIsUvvz650128QXNPAGyX0ycQAA8I9rgNynsqdok61SfvFTdfk98N9yTgWyC/DXwoFlMpfcCC+mRXemS/w7yKXhs1U2Cku7in1roN1l/C5l3lm2nTFSr4krWC9XptMKMWW3IDfZJfmX5oAssnRk9gnvT3BexyUNUa24nLHFvROeuhd8D9vHjYB+ITpDpHqMHq+CShV2A2H7GH+na07+n3d/7aaT1GOwIvdghAsmZy4dQR4SYho45hvuNlyM3qVz15dVpxvEs6NNzGMIB4cUJqWX3SOa9MAy0QcioegIiRguevvnqo8Ch9tOKdeS6JUEq+FJt6F2w6TDgvlsycCjNl4YvrY5J2UDROaLsIBVS2XrUSrdYmMP82lM6hli6pmJJZ9QCxgnKNab56i3q71xeEzbZnFi3iPcHNG+0PXaCLwBMvMHbh0Lt/r3enOJQmtt0sGqpyOXwpgvRaUedT1eg84V7vewF+VjUmCpQH8RFOaSv8A4lT1Ra2YWV30Pn3ywKfXzbmgp80hqkPQL5XHGdzIKTymuUD9uf2qXvWYqL90WCgOhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(6666004)(6486002)(478600001)(186003)(36756003)(26005)(6506007)(6512007)(53546011)(83380400001)(2616005)(38100700002)(86362001)(31696002)(316002)(4326008)(41300700001)(66946007)(66556008)(66476007)(2906002)(31686004)(8936002)(8676002)(5660300002)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHBqZUZvSUR5enlzcVE5NkMvQWhRZU41dnIvaVVoRE1BbFZWdGl1RkxNQ20y?=
 =?utf-8?B?RlQrUks3WUJZdk82aEt4d0N1U1psZUc2Zm1IVG1BdWhud2dFV2lrbzltMVMx?=
 =?utf-8?B?Vkh6ZEJQRmVWSVo2VGRETlRSYWwvOHI2RFBoRmtRbk5acEgvWThBd2RJVUov?=
 =?utf-8?B?cUpuZ3R3aTdwYU9tMzczTndXMnJadFVtNXR4MzJ0RXEwSHhtTmxQT2U1WThU?=
 =?utf-8?B?YkN4akxJeGEwSmIyT3VlODhlS0QySmJVeWltWEw4VjM2aHVTKzNvVENLTE41?=
 =?utf-8?B?NHowU29mWWZ5OWZHSWI5YkEwTzM4QTlOU0V6b2VTc3dBWEZwVWxHb3lQZTg0?=
 =?utf-8?B?SktuVHM5anhxdnZqcm5LNlZ0aVJuM1VDQ1IrTzAzK1J4cnBjdUkzaFNJRVc3?=
 =?utf-8?B?MXZLNVU1TG8yVkpiZWhqVFZPLytIclNZV0tyZUhEVnYwbG1KVTVUT0Q5cjlF?=
 =?utf-8?B?TUY0c1E3amxTcWwwck04eExwWXlEckJjR245anR2UzZkL1EybmswakdBeWs3?=
 =?utf-8?B?L0M3MndWbUhQaitlL1djUjQ5enM3L21zdjQ3NjlJZHp5MmhsaE9TNUZWOVRq?=
 =?utf-8?B?SlJJVkN3SFJidDcyTlJqUjUwL2g2aG94MGI3aTVEU1dYZU5uNHZvalhtK0w1?=
 =?utf-8?B?bzRFeHVPK0lyaHpCc044Nld1eGI3emxZSjlFZVZMTHh3ZHoyeFovbUFNbFlV?=
 =?utf-8?B?WTlWWkdOdEVhUmtaSktPZGw4Z09jaVBHUkw1OE9OUlBvakNZWXdCZnByNGxJ?=
 =?utf-8?B?Q3hRWTRSMmlWZnhwT1RqN2g2TmZuUk5PUEY0QUJwRTcvOWlQMk9pM0J5ZW02?=
 =?utf-8?B?VERpNk1Gc0x4S2ZZRW5uV3FCTnJmUzQ4Ulg3RDBnUURIeWY5MmhRZ2RHR3FV?=
 =?utf-8?B?ZC9KNGprelhtdHNsOGFkc3BjWFAyQTN5OWdHdy9icXM2ZGpEaUtNTmxTMnFZ?=
 =?utf-8?B?K2RwOVZEOHV5b1VYODUveGV5aUtvUGxtbVAwVFFZRFlMZmRIRFpEQXlMbUZX?=
 =?utf-8?B?QWRHWkhKQkcra2JiSXVxb2RUaGVOLzNyZVlSdHd4NFB6dEljYXdiZ3F5ajFS?=
 =?utf-8?B?K24rNFlRdjBrZzNlVnU4R1VFQ0c3OWFQMG44ZEtQa3loakloWGJkK1p5MFBK?=
 =?utf-8?B?QTNmZmNzdk1QSW5POUFKYUVBeDd4bk5FUjBqYXdHSmJreVMzVWE3T21naGxH?=
 =?utf-8?B?NkxYYlRaK3h2aExXK0xieW0zZ3V3WDNUR1JPL0ZLU2cydVQzUVUrTVZvUXlh?=
 =?utf-8?B?cG4yM2hGS2JBUUR5S2VSVzZaK3VCQWJsTUlhTld0d1hFbTBZWEt6QWFGM2Fs?=
 =?utf-8?B?UDI5SW9WVGRQL1pOSGdSbEQ3K1hRY1BQcGVhdHEwQ1c5UVRiRmdWTVRtNmFK?=
 =?utf-8?B?MnJGa3U1Z1lrbWswUCtFbm9JWEVEekZMOVFmLytKYWpBMDMwV0JLK0pLQkxp?=
 =?utf-8?B?THhYSUQvOUw5WlpZSXlvVGZlRHhtWHg0YjNiejFTbXNNNGM1YWd5SFMyeFJm?=
 =?utf-8?B?YktQVjBqWHdDaldTd1F1SUVRSVhCVGdOclNXZkFzSXRBcVJTcnZIcXRwZjQv?=
 =?utf-8?B?RTNSZ09XRnY1ZGZiSHRCbjNmR1R1dGFRcWZZWVpNVW5SbHhTZDdVWm5YZWlr?=
 =?utf-8?B?QVJsdjY0eVJKVit6NVZSTzhLVjhIT2NGZDBpRkxLaHZsV0hSZDBET2ttTUNP?=
 =?utf-8?B?UjlQT0M0OC9CaHpJSjk2OTNaWGp6RjFHczNyUk95M2VZUFh5UXBBZTduQ29k?=
 =?utf-8?B?b0lra3k4V1NTTzVoZnUxaDV0SHN2WWREaitvZGlwQldqUjJKTGdNTmlzaFQ0?=
 =?utf-8?B?RmZRRDFRTnlaTStuemY0UzZ0OWdaZkc2VlpHZFBkbEJ1MVl1L0ZvVndpWm5q?=
 =?utf-8?B?M3Jwck9nWjVPbjcrdE1OL3ZaazNVR2RFM3JkV1dxdFcxQjBraXB2aFc0TGU3?=
 =?utf-8?B?VlVGdWhJN09UVVA4T2dCbkxnc3hNZGxQcXVRQ3pUUExzS0dCVVZ6Ui9VVDVE?=
 =?utf-8?B?Q2pZTU9Gd2VMWHJaME9MM0ZSc2NadFdMV1JjYi9LOTFvV1N4anViV29LZnVi?=
 =?utf-8?B?cFNUalVjcXp2VzFMeGxzSVlMcGxaTjBDQ1VTZ3Zta3h1QmpybjRydk5WODJO?=
 =?utf-8?Q?X6Bop4SWWPdCSz0vF4hol4iZf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d10c63b-d844-4535-6446-08db62aee115
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:45:44.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33kCLlQoZzqbgwbuWoZpyvIeXnVBkHG9mx+SeDaocbakv5htXK8FkbknDnUO7zQBV8nWMGyVlvptnWRyKhPIzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/31/23 10:57 PM, Dan Williams wrote:
> Dan Williams wrote:
>> Hi Ben,
>>
>> Ben Cheatham wrote:
>>> From: Yazen Ghannam <yazen.ghannam@amd.com>
>>>
>>> V2 Changes:
>>>  - Added Link tags for links
>>>  - removed stray unused variable
>>>
>>> This patch is a follow up to the discussion at [1], and builds on Tony's
>>> CXL error patch at [2].
>>>
>>> The new CXL error types will use the Memory Address field in the
>>> SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
>>> compliant memory-mapped Downstream port. The value of the Memory Address
>>> will be in the port's MMIO range, and it will not represent physical
>>> (normal or persistent) memory.
>>>
>>> Allow error injection for CXL 1.1 systems by skipping memory range
>>> validation for CXL error injection types.
>>
>> This just feels a bit too loose especially when the kernel has
>> the cxl_acpi driver to perform the enumeration of CXL root ports.
>>
>> I know that Terry and Robert are teaching the PCI AER core how to
>> coordinate with RCRB information [1] (I still need to go dig in deeper
>> on that set). I would expect ACPI EINJ could benefit from similar
>> coordination and validate these addresses.
>>
I haven't kept up with that patch set either, I'll take a look.

>> Now, is it any address in the downstream-port RCRB range that is valid,
>> or only the base?
I took another look at the ACPI 6.5 spec since it's been a while and it doesn't specify,
but when I tested this patch I think I only used the base address. I'll try out other
addresses in the range and see if they work as well.

> 
> Now that I say the above, I wonder if the legacy EINJ interface is even
> the right interface for CXL protocol error injection. It feels like
> something that should be relative to the given 'struct cxl_port'
> instance where the error is to be injected. Userspace should not need to
> deal in MMIO addresses, especially in the RCH case where the RCRB is
> difficult for userspace to enumerate.
I think that's a good idea. My first idea is to have sysfs files under the port that 
are basically a shortcut for an EINJ injection through the legacy interface. I think
it might be possible to have just the sysfs files and no legacy interface support,
but since I'll most likely be reusing the EINJ code I imagine the legacy interface 
will have to be updated anyway.
