Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BAF2DE02E
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 10:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgLRJCN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 04:02:13 -0500
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com ([40.107.237.40]:20577
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbgLRJCN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Dec 2020 04:02:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNusqtjJaVl5ooc8Qc8l3i30+fQ6Un/Fm/isP73S7FvRNSGXShqsR/IU2w/94sFqs/YcjpAnZBDyMa/2jP0oKNBYIewunbWjIfolTis1Vkpwq5UCPuqIu+r+ycj4w0AqtL0iD9xqdPzjO9XIaEc2R9+DJ0qUJf7WZGWrSkGtIsgfCWTMTiZftNYrtTsJ6B/BHp+PcMm4QfAsfbbLr8J029A5h6d8ck6gfutu1/JUKZqhM0ODNt+0tcfaSaKXoHDQUhAl5G5bPsoa0nXzop7X4QiPCjhYbSCwTbMUcmGsYRwkVfbdB9NZdtgjgrcHKxb7fNffYOyi4Ky7KT/5HfQIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vaVCso8bAlOEUUAU3XrKiAqwFl+FXRDpkelm8DhkBg=;
 b=cxJjgVFwbDfDmDl/F++k/igk9b/VjzTGdEY8YmpAaGTTkawBwzLe4bN/cGoKE5BZSPxwK9CttfNDsNm0zarJVmNNUzNxyyCsEgHadi9Ce+0dh44WHqL2I/otn4izxd+xJPU0xbcooNjRjWyYrKYA4jW9VNQ5TAmk0jr+crS4peJPQy/ui01t4366Y8yLyiPeXvrEJ+4cJELgdpPp8nMugwNdKC7uYr3CSvYO1+poBhgfNjI5ZrIzEAE03EcKJazQfQ2sF76qrTCLw+4olF7wY/1oPIu3Qcs+8jPKpVQ6dnkCBYHsHcy0Rfq7T48wksfEsrNdaOu5q0UA/63+s97JTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vaVCso8bAlOEUUAU3XrKiAqwFl+FXRDpkelm8DhkBg=;
 b=rBCl8RWaoyB/UPpA/+Vjj08semqPSgBngQFmPwzlkgYy3/zz3+I0GyCAbwkbyIAKjK+K5SkNhveEhIZNEZjyw9DRjyHva7R1fPDzk4rSvVlnax8XuoTxErppQSxnqPSVNBr55XL0REvCBCKb7vsj45uCIpteqWSUDNYPUW1/2lY=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2495.namprd12.prod.outlook.com (2603:10b6:802:32::17)
 by SN6PR12MB2752.namprd12.prod.outlook.com (2603:10b6:805:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.20; Fri, 18 Dec
 2020 09:01:18 +0000
Received: from SN1PR12MB2495.namprd12.prod.outlook.com
 ([fe80::c9d:1af9:30b:c4ef]) by SN1PR12MB2495.namprd12.prod.outlook.com
 ([fe80::c9d:1af9:30b:c4ef%4]) with mapi id 15.20.3654.026; Fri, 18 Dec 2020
 09:01:18 +0000
Subject: Re: [PATCH] ACPI: PM: s2idle: More x86-specific code to the x86
 directory
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <1702151.Z2izUkvjaf@kreacher>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Message-ID: <3f18b469-69ec-0f3a-1714-a6b5f3f314b3@amd.com>
Date:   Fri, 18 Dec 2020 14:31:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <1702151.Z2izUkvjaf@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: PN2PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::28) To SN1PR12MB2495.namprd12.prod.outlook.com
 (2603:10b6:802:32::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.208] (165.204.158.249) by PN2PR01CA0173.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Fri, 18 Dec 2020 09:01:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0248b6c9-5637-4757-7707-08d8a3337ba4
X-MS-TrafficTypeDiagnostic: SN6PR12MB2752:
X-Microsoft-Antispam-PRVS: <SN6PR12MB27520610E72EEB0628EE53A79AC30@SN6PR12MB2752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfrnuZlOsQxWWxQoqufkow1X9B0UngrFSB2UN86MEZLFuOn1fKFgQnijITR7Nitx3sxdM21ZPausooUY+3G/jCvXXq1T65x+xkh43SqqFHpplJ+pinNr9C2CrhLI77ijkhXVWoWeOYJSDPhfb5HkeC89Zdqtff+ZwM37lI1QIrHVPMQmCphUDqumKcVweQ+U5V0qlfNQvU1EaXkogQf7pWawubspzSxPT1S7uhnIvKFTvBnhDP0UieUuxWU+sNK/B+CCaRsqLz0j7DiznEPjeA8osFZfJw9WEUcRCdfrbKPGZ5MMgJsNQdbjB7BNUWsgWz0c/2hs8EzEXTKTYBAosR+g7DOtj0diVnvvtTUHYVden3EatqBdmNGedzYhvTRjeWoNNX70OhwgoW37/j2fwaQFnOOzL3XnKnMfwQFTaL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(8676002)(186003)(478600001)(2906002)(110136005)(6486002)(16576012)(66556008)(6666004)(16526019)(66476007)(316002)(31686004)(4326008)(31696002)(4744005)(83380400001)(956004)(5660300002)(53546011)(36756003)(26005)(8936002)(66946007)(2616005)(86362001)(52116002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZTRaK25XZjVKQnNLdUFnbHV5NmQ2R2paalBZbENQTGluT0tXcktNdEh2VVQ2?=
 =?utf-8?B?UXBNZ0g3ck5zSnVaZ3c4dnpiOG9qVUR5aWs5WWVYbS9DZzJqQlV4TCtJbmFp?=
 =?utf-8?B?RUJ2V0JWNDhZVjc5WXc2aER0L0cyRExELzFKZEE1THc3YUtiN1F1RlZ5Umoz?=
 =?utf-8?B?dGhVQUlQT0RsSDJBU0VjOTRuQ2RqQ0tnQXp0SWhkNWgvNWpmRytxNEJOS3F5?=
 =?utf-8?B?ZjlKYndQQnA1UTBhb1ZUakoyWEZiZURXUURmZEQyOXQyMHJsN0F3N21hdjVw?=
 =?utf-8?B?bEt2VkR2ZytLZklVWjV6cGdUTm9rclpxdk84ZkZjN1ptVEcweFp3N3ZqbDFr?=
 =?utf-8?B?dlVhcnMvdTZDdEkzdGY3Qk5Bcmtzai9jRHNuRjJTcUlEdDZ0TnBZUzgzb2hG?=
 =?utf-8?B?VlhLSXFFRzhJN0cwRVVEclpZTURHajh3MHBCemJxbXI3Y0ZpUmVOUmFsNEtv?=
 =?utf-8?B?eVUzMnFhcmwzOVVIaGFIdG0zZTNQTW0xbnQvL2hCL2swUWY0R0RYZzdDVEl0?=
 =?utf-8?B?WExZZ29kT3Q5cE9tR21hTUdKYWZNbkVzQ3FVNXVEMkpEQXdGbjdxWGlZemlG?=
 =?utf-8?B?cytMMEswSVB0YlVNK0tDSmJzQ0JabWpuUXBwa3JZZ1c4OURQSUVzakhPYTFS?=
 =?utf-8?B?dytXRDlNVGpyZ1hSc0JTSU8rb1RVc2xvSnJaWnN4OEpGUzZhMm1OQ1EwOWRx?=
 =?utf-8?B?ek9tQmRVY0hjY215VFROQzhCSlYzODNyQ1ZvKzIzaWRnSFE1R29hVDJZVDBt?=
 =?utf-8?B?UWJpUlBld1ZpVDYza0ZnRVNjbnVEVFdBak95TU9vUG51WlBzTWxnT3I3bkFh?=
 =?utf-8?B?alNPUWtXYTloNVMxVXQrSFpWSHpKUkgrLzRQZUh3aXdlS21kTS9uTm4xWGVj?=
 =?utf-8?B?cjUrSUVPRU40STlZZHA4WTFKVU5GdGxJQUxjd0wwRnVheE1CRmE1RklvWWtP?=
 =?utf-8?B?MzRhc2x4UjFnaHdIMkJFRnl4U0xnUlNicjBwQ1J1NkY2cytJTlBoRmRQNDBK?=
 =?utf-8?B?VVRPQ0h0TXpiZ295NFVaYVhqNnZEOStmNWFDOFE1Ry8wVHJHUTVHeVdGQWJO?=
 =?utf-8?B?VlIzVTlJV2JVUWFzTmNETWFndUR1UTBQSGl1d1RtbGpKZGF6enRleVR0VlVq?=
 =?utf-8?B?WnIxK2ZmQTc1RktNcWtrY0lsdU1sMkllUjNrNUk4UGEzUEUvRVBWTHdpWlVX?=
 =?utf-8?B?VDZLNldnSEE1cU92cDZZdm5DL2tmZWRJV09nOFZzeXI1RmN2b3NneWF4RHR3?=
 =?utf-8?B?R3JqTUlZTkt4KzZ0MXp4WmFQU2gzSGtwYi9JKzgyR1hrTnhuRkM2bnZuVlE1?=
 =?utf-8?Q?aOaXCCHm3lBjq6+Y9xbbNTmP8CQk2kKk/0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 09:01:18.4451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0248b6c9-5637-4757-7707-08d8a3337ba4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wv0QvYXGn1OFEh9KpnxT8zSd6hYGonpqTQo32JFNYFVL9Ydc190LeZBwJcwa2oTOp6b052yQrlIhaUPu3snQwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2752
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 12/18/2020 12:53 AM, Rafael J. Wysocki wrote:
> [CAUTION: External Email]
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some code in drivers/acpi/sleep.c (which is regarded as a generic
> file) related to suspend-to-idle support has grown direct dependencies
> on x86, but in fact it has been specific to x86 (which is the only
> user of it) anyway for a long time.
> 
> For this reason, move that code to a separate file under acpi/x86/
> and make it build and run as before under the right conditions.
> 
> While at it, rename a vendor checking function in that code and
> consistently use acpi_handle_debug() for printing debug-related
> information in it.
> 
> No expected functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you Rafael.. This really helps!
