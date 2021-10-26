Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465EB43B9F6
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 20:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhJZSw7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 14:52:59 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.4]:36911 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236813AbhJZSwz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 14:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1635274231; i=@lenovo.com;
        bh=ZUni6vJ/l4U7o+adXIdcTlITNtt3sBms4aBLbRzYhig=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=g6JBPiI5Kjd3Uk0SHMM9ceS1kqkZtfde8q3Nf/T/kJ6CtPTNK/0skWdtk4fpvrJ3t
         4EVaOPJp/Q+e0jCWj2QjhfgnpKAF7o6YN7kRf853nI53QXPXRPkWpyyc0jafQ67yKj
         WMkpkBHsR0h3cwC1mtgtBINFFNWbPF5AsQT8mPuBWPZtoHMrmodJf+5jfOK0q6A1q5
         iJQg8SAg9PicK5JqM/phkfqfsz+cSymWlOQ6DuRb0mQ6LFp+HbUqChccPUHjeKXE3l
         6xmwoKtF/mEnAeyS8y3584Vjf6lJHGwmf/YprRg7yt/IQdJVuQU4+rfruwzZ3h1EXk
         kk/2YBQmetmsg==
Received: from [100.112.129.81] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.us-west-2.aws.symcld.net id 54/F5-22018-7FD48716; Tue, 26 Oct 2021 18:50:31 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRWlGSWpSXmKPExsWSoV9rqfvdtyL
  R4Gg/j8Wb49OZLJbv62e0WLx+GaPF547JLBar97xgtjhz+hKrA5tH66W/bB7zTgZ6vN93lc1j
  y9V2Fo/Pm+QCWKNYM/OS8isSWDP2nH7KVnCCo+J6y1nGBsap7F2MnByMAkuZJba9M+hi5AKyF
  7FK7J68jhXCaWOS2DbvDguIIyQwh0li6v8l7BDOQSaJcw9ugWUkBG4ySszvXMQGkelklNi99Q
  eUM4lJYv72Z1ADnjBKrO2bxAzhPGKU+LT9NyvIAbwCthIvd3czgtgsAqoSW+/MZ4GIC0qcnPk
  EzBYVCJfoeLoOrF5YIFli0v5msHpmAXGJW0/mM4HYIgKrGCWm/ogBWcAs0MYo0XPyCSPEtq+M
  Eh/OdDGDVLEJaEts2fKLDcTmFIiV2Nb8EmqShcTiNwfZIWx5ie1v54DVCwkoS/zqPw9mSwgoS
  JzetosVwk6Q6Pn3iA3ClpS4dvMCO4QtK3H07BwWCNtX4sajS1BxLYnWK2+h4jkSrZsfQc1Uk3
  h7soF9AqPeLCRPz0Ly3Cwk581Cct4CRpZVjOZJRZnpGSW5iZk5uoYGBrqGhka6hsaGumYmeol
  Vuol6pcW65anFJbpGeonlxXrFlbnJOSl6eaklmxiB6SuloNlhB+PuNx/0DjFKcjApifJKO1Uk
  CvEl5adUZiQWZ8QXleakFh9ilOHgUJLgXe8FlBMsSk1PrUjLzAGmUpi0BAePkghviA9Qmre4I
  DG3ODMdInWK0ZJjwsu5i5g5mj4sAZK7npxazCzEkpeflyolzvvRHqhBAKQhozQPbhws3V9ilJ
  US5mVkYGAQ4ilILcrNLEGVf8UozsGoJMzbBLKWJzOvBG7rK6CDmIAOYlYCO6gkESEl1cDEvaR
  jg5rFnwuxwmdWfEnq0j5nMiNnHZcu4yuW/29yKpPq/Y6GzjIt/ull7y5w8yg7m4HIxK7yXtO+
  dWLSm06HzbH4LzMreru01BHhlxefGH9wbduhtP2tz8PIa/ey7rv+P6A4I9pvztHIHg/jJ/Gym
  0y77j0OeMTJdOpuK3eZgvQZ93e1//6H6YX/9yvWb2D+/95CemHJhqLWUJV7O/RFek2fq1n8Nu
  PgkT6qwtzU+NIq6peNzsrEd9Mbrmnlse0I5S/XErz0Yiu7MNs7DwHuu6Vs9Y/T7cO62C48Wm8
  w6UtZ9VUZv2//BFOqvV59e7oifZsti+uGK753H3otUXF1zZXr3zlLyuls5ssV2UosxRmJhlrM
  RcWJANIqVvtyBAAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-9.tower-336.messagelabs.com!1635274229!54543!1
X-Originating-IP: [104.47.125.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32423 invoked from network); 26 Oct 2021 18:50:30 -0000
Received: from mail-sg2apc01lp2057.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.125.57)
  by server-9.tower-336.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Oct 2021 18:50:30 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8TeYR7uP7c09u+OUBtsc//1QDYe0ZTjnwJukZ8Uev4ipzHY3QfXT6uF2nznHKRu+dSlQqW8fRJMpsTbFe3blrW60j/6VQ9xLP1P7cmeNIsi16tFUmCSoblXRDCaDlihAnl1OqSrTW2gZjor6YkO5+HQ2JG7ffe7reWDiEUh4OlMl+X13tW9Ok3dSDTzYfTWCipZ8GQ4Me1+KDkREdg00kIEGvZ0PTeyfzgPeYQCV2n5qI2Ft3f2CWZNASTX2hN33i5SsKEpvBBfE5mFvkT3NhXtwcNYfR76XnX55Zt94yD7G129yMvXbLdVCWlUzkX2eqm3ZndEaCygSHQTlo7Zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUni6vJ/l4U7o+adXIdcTlITNtt3sBms4aBLbRzYhig=;
 b=MOAtVD4rGX48+2aeUtY8eCx24w0ikLRxy3Qv+e1AnMDfPj7OLzlWZQbtPaC9F77RG6jkO7iB7WT/uwxLI3LKjWixQvPF1xpuh+Ompa3oBC7pIzAMYBWqdgjUWShyerAvYhNhrHQ3PsAXklVTczRaZ8UBUGS3Syhz0buq1C6ZUs0UnbaDux4pRuU5bTuoSZUS7Fudi26xD8Fm5gm13/5m4eObUIutYzJFu1zNCHL0qMGVXhqtSq63IMSgFZ6lw5DoZEkjCxyU3lJMFsCyvaM0Mj5ADUJy08iIfpFiWKbd6B8Ms+A44oX2deuh51n54s+B+TSCVYtqWzHMMa2c3vHx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.6) smtp.rcpttodomain=amd.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SL2P216CA0136.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::15) by
 SL2PR03MB4170.apcprd03.prod.outlook.com (2603:1096:100:46::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.10; Tue, 26 Oct 2021 18:50:28 +0000
Received: from PU1APC01FT054.eop-APC01.prod.protection.outlook.com
 (2603:1096:101:1:cafe::8e) by SL2P216CA0136.outlook.office365.com
 (2603:1096:101:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Tue, 26 Oct 2021 18:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; amd.com; dkim=none (message not
 signed) header.d=none;amd.com; dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.6 as permitted sender)
Received: from mail.lenovo.com (104.232.225.6) by
 PU1APC01FT054.mail.protection.outlook.com (10.152.253.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 18:50:27 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.12; Tue, 26 Oct
 2021 14:50:25 -0400
Received: from [10.38.56.137] (10.38.56.137) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.12; Tue, 26 Oct
 2021 14:50:25 -0400
Message-ID: <ac75f7c5-6579-9d6e-6bcb-ed067f3889f7@lenovo.com>
Date:   Tue, 26 Oct 2021 14:50:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [External] [PATCH v3 3/3] ACPI: platform_profile: Add support for
 notification chains
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20211026180535.9096-1-mario.limonciello@amd.com>
 <20211026180535.9096-4-mario.limonciello@amd.com>
 <9a4ef81f-a064-31c0-d52a-42f79b12191f@lenovo.com>
 <SA0PR12MB4510745D300C9E3239EACA00E2849@SA0PR12MB4510.namprd12.prod.outlook.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <SA0PR12MB4510745D300C9E3239EACA00E2849@SA0PR12MB4510.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.56.137]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b82c9092-7cc8-4d1a-ad3b-08d998b17a6c
X-MS-TrafficTypeDiagnostic: SL2PR03MB4170:
X-Microsoft-Antispam-PRVS: <SL2PR03MB41705C382D9F558148DDBEA4C5849@SL2PR03MB4170.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OHM6EBIW9MlOAzz4pvvHBEN8kpvLEkagCXlc/AeTFYhSITCfhfuTYA7ypMx7+ua9h0NKGl8ftSjg5YVUJWVeAoyhdhna5yN6jxd6KiXyu3+EjYXS9DheZnNlJN2A0MysKM0JJ9n+Do/xpHTwcmgV0jng41Sox7NaZXtkCUJiUeFcCCsjj7XsU0sQXETixVhQM5Dc6FrLcj2HaUacNFbZ9AsrmvpIPAYTMLRU0O+s+0ItGd/0uC3mN0ZvZ8uFAHnZfsiGcS/TFExgYIzkqWUy4oKDHVIwfZmEAUu+wjmRWjfEjheK4833ky/meVLrNKVL7N2Rg9jW9YK2W2UTzHViGQhstTp60Uvs+oiGamGSYBwqqrufSoWORiVSdVtISxImFW4H7+ImanYRC7C6aOVfTEaJOq9ZwXptgiPFj52RZGQOdYMS/pEIXVGDseK50xhnL87wK7SsnW69nsm+YztzdtKMl97z3YRuubed4Vzb+xdEusk+VP1h85UppQy0TBAdUyxzXAhAchqS9P1tuCbGkTs2rEOjb0zVkFPvMv74zrRUc7G+JgxW8Lleb5hW9c39qBSk3dQP0Eyx6j6gD0EUc2Q9IMPOjg+MLmlQshO0mHCe9y50GbnFopyh2ztQ3194OhDAZVmO7zENiQfxd0jOuNqPiBdx7EgB/p10Pcr8sn1HzPefs51dwcI1PzksFvoGuAX+PUAV2seNh6/BFNEzTCyuowRLxy5LGkOx75tJ2LoZsiNA8NYqjbN/yXJgYxwXtmN4n5JlO6sHEDtPUIdY+aUEk5YY5AJWeTsy1fgiwk=
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(508600001)(36906005)(86362001)(316002)(110136005)(8936002)(36756003)(4001150100001)(54906003)(31696002)(356005)(26005)(16526019)(8676002)(186003)(16576012)(31686004)(426003)(2616005)(336012)(47076005)(53546011)(36860700001)(82310400003)(83380400001)(82960400001)(70586007)(2906002)(70206006)(5660300002)(4326008)(81166007)(15650500001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 18:50:27.5664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b82c9092-7cc8-4d1a-ad3b-08d998b17a6c
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: PU1APC01FT054.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR03MB4170
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hi Mario

On 2021-10-26 14:38, Limonciello, Mario wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Mark Pearson <markpearson@lenovo.com>
>> Sent: Tuesday, October 26, 2021 13:36
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Hans de Goede
>> <hdegoede@redhat.com>; Mark Gross <mgross@linux.intel.com>; Rafael J .
>> Wysocki <rjw@rjwysocki.net>
>> Cc: open list:X86 PLATFORM DRIVERS <platform-driver-x86@vger.kernel.org>;
>> linux-acpi@vger.kernel.org
>> Subject: Re: [External] [PATCH v3 3/3] ACPI: platform_profile: Add support for
>> notification chains
>>
>> Thanks Mario,
>>
>> Patch series looks good. One minor suggestion below.
> 
> Thanks Mark.  What do you think of the other idea I had in my cover letter?
> I think that's another way to do this, that might mean less surgery to this
> source file and other function call.
> 
> I'll re-spin it either to accept your suggestion below or the other idea I put
> in the cover letter.

I don't have a strong opinion either I'm afraid :) Getting the
profile when you register seems neat to me - I have no objections.

Mark
