Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F882346FA
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbgGaNdo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 09:33:44 -0400
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:37089
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728607AbgGaNdo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 09:33:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzX254ET4hAAxZ0RSo8DsQAB1y1EGcFPM4TYZr/n0VBuHGEvzQZcMncei/YDoDPNUDMf3tw6KCllZjfDlnrxV/IaZVi2pwdcNRW7pq3Fz1reayUzbD6eKbm4jygaUq9FkvIkMdVRMiMG2onGHiiOcweeWrWNnAGWROl0zxuSvtSnEPbjD7i5jYnuiWmGkt3DPFCheJWzSTpVk5EwhDjzGy+owfNSVdc69GBNIR6bjh3y2hQMWHsOt9fXnqrWu00ALnqZ0f4yrZv0LN9D23TUNzzi3aMkJAts9pI3rY5mWfaUJraEYpYgnWqezESbcWmkGhW6rmyE/D1zinGWJis3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF0QhOB+ffp4nsvVOQTKzKVYuk4vkMVUgn55nCJOK9g=;
 b=KCiPZyrm4X6P/MS7JYxu8bsS/mIzZwePae9Bd+TDSPka+cG/a91JrZ2mg1e0HuevcIUHzjSqBjcCd0riqgAZ89hue0dEhxOdTlEGt08GG/5PLUY7EdA6S2RPk2OQVoeSLGVxGNJSVn+OgXa+GqHTaP19PtA0GSrHjZEbInANH962AOC7PH7c72qENYrEW7bEVbniXvvrRJlnqAS+TrXzBTsGVj4Hix4Pm/mO5G67s/Ch2zjBFTuhQie62qM/yeqnLOrUsQjEgwKolFOudvqUP1F3JYOjkfO5yUOxsT1Ri6A92LkiItQYN+a0WMv/wsIv2Gv9RUjtUIUGh7MLK0xhVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF0QhOB+ffp4nsvVOQTKzKVYuk4vkMVUgn55nCJOK9g=;
 b=Cr1EGk1Px54tV67i9VanHgus3rM8mIA8iFdYXqkIuIwoHIG9UXSe7ZR42iMhWNcqR5AulWkSYvxGC16jC8EFpvt6OGOlqJs6Ca6wBAPSKi0OFETiqkBX/hM82xXTxbxT3KEGsHpo3X2E9tX/8XCwiPIdbaIY6j1egHNrXg4qyNk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 13:33:41 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c%7]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 13:33:41 +0000
Subject: Re: [v2 1/4] ACPI: APD: Change name from ST to FCH
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Agrawal, Akshu" <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20200728082857.10829-1-akshu.agrawal@amd.com>
 <20200728082857.10829-2-akshu.agrawal@amd.com>
 <159598596077.1360974.483730969007254506@swboyd.mtv.corp.google.com>
 <c5041407-1bbb-82b3-e5a5-c6de0ab16861@amd.com>
 <CAJZ5v0hk+kNrHo1VmBRC=VF-dhdRP2143BxeHOGyY==1Cj+Qrg@mail.gmail.com>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <94ecbc3d-23d6-cbf7-57c2-5450a2c8952a@amd.com>
Date:   Fri, 31 Jul 2020 19:03:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <CAJZ5v0hk+kNrHo1VmBRC=VF-dhdRP2143BxeHOGyY==1Cj+Qrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::26) To DM5PR1201MB0188.namprd12.prod.outlook.com
 (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.101] (122.179.42.211) by MAXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 13:33:38 +0000
X-Originating-IP: [122.179.42.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d7cb819-11dd-46ed-52d2-08d8355656d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3257F100453C08C69BDA82C7F84E0@DM6PR12MB3257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFUI2fW94Uz1SBciPpMyLrYiQFX+241V6A13kGV/wKadQJ04DXdgvf/Ha1FER5hexVVwZgZ65pQVmVvMl1INtzcv80Y2rOenNkk5gFmJ2yE4iB8VrRNh7IO6Wh+F/gbjojwZ96Pjtms/QfxtenOKRbUsma+ADY3OIREpdBFFuWkH2D6tXX0BzJumSADXPC2HpcZt45gDttR3Ue4OhECKii00NjTc/QaXIPeUgg4UBL/82n7lIg3NmOYnsrlby5+lGcRtc4Zakxfwm7no7LSko6C9CVQqy8vHUWaB4yGC1U3SBx5152lNPYeUzZMu/hkkqbDpnRLYDD/LGQYQ9Bt9KQ8+bLqIT26l4eO9GJb7r9WLuBadBIWfFhDrWxIGlMP1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(2906002)(8676002)(5660300002)(31686004)(6486002)(6666004)(478600001)(8936002)(31696002)(6916009)(52116002)(36756003)(53546011)(66476007)(66556008)(66946007)(4326008)(316002)(54906003)(16576012)(956004)(186003)(26005)(16526019)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5GaDaFh5dGS/8kYzQmgYaikX8PAeuVYpai6MamkIc5kXkrO5PMYNVU9JJKf4i7+yJQ8Ag42kYNB/KtI0qWIctSQKQn9CnfSkolcRi8/y1DnEM07PWJzs68Bk3hANH8nvvUq8JbEpJMWt4w8gh4aN6pmA2q/avIay47g76J51Dq5kApiKErqtkfp5FWEoStq+IqdfRchTX2MrO4MC1Sen9PoUnTnqHMldUQRbqac3Y18WDU4xA20k6+khkLORUOgNQmWttg39rlQte+ujdBUROW77ikrxUAndDDpy0SIw0vBDhtzw5PX8A3z5g0+Zk2a2y0PCExWUJK+575zXwfumg1Je7q+pMetpEz4TN/yu3CtmO5G6mx6c/Iq3fQgTfT7E6m17Vnsm6nX2t1uNkYacutU5pol5+T7g091eQ692u+eZeU6X7leEcl1YCU421GuGNbQvsOZab8dZxbMhRjU8W4YMd34Echv3vwjwezz369EqGeawMo+UMWfYALUaP8JFb0brnmhv8P7GVb5jIyPI0ekEVDUGzxaRzsv5V+sZ0dXzACxVaexxMUEbK4HVcfLukvuwr7SRBk//r2614x3ZV/ZGuVd+Mx3wNbJe2PwzEIGBIBLCMsYCyqLL2AGZO3AXIwt9HBGWeZF3JErXCs8Dog==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7cb819-11dd-46ed-52d2-08d8355656d6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 13:33:41.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vq1GFcJIS1LZuVh9gYPY415n+vMROmXECJJnCGDVUb3FjzHVz3eO1bVl74P0zYgQ0yPNYAqWxTxJhpMNbN9kJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 7/31/2020 4:44 PM, Rafael J. Wysocki wrote:
> On Fri, Jul 31, 2020 at 2:44 AM Agrawal, Akshu <aagrawal2@amd.com> wrote:
>>
>> On 7/29/2020 6:56 AM, Stephen Boyd wrote:
>>> Quoting Akshu Agrawal (2020-07-28 01:28:53)
>>>> AMD SoC general pupose clk is present in new platforms with
>>>> same MMIO mappings. We can reuse the same clk handler support
>>>> for other platforms. Hence, changing name from ST(SoC) to FCH(IP)
>>>>
>>>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>>>> ---
>>> Acked-by: Stephen Boyd <sboyd@kernel.org>
>> Hi Rafael,
>> I see the status of these patches as Not Applicable in patchwork, is
>> there any pending action for me?
> Yes, there is.
>
> You need to let me know if you want me to apply them (and I mean the
> whole series). :-)
Yes, please apply the whole series.
>
> Besides, I only can see 3 out of 4 patches, so if you want me to apply
> them, can you please resend the whole series with CCs to linux-acpi?

Sending them again with cc to linux-acpi.

Thanks,

Akshu

