Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E6A233CAB
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 02:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgGaAo0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jul 2020 20:44:26 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:2574
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730888AbgGaAoZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Jul 2020 20:44:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLOr7ZvMxggSQ4Z4M7L+6QLse3UGkG+/uBhEq6gE5EUeekkO9RBM7Zz5ilkRd54X2tqMidfHShRWOvlnhozEr5VDFTp+OAk4IT5ssRyRDiMkOv5LdIeQbRSbbN+23X4d+DSwP1c0oTJbmoxocJmZ3lTySVQF0hNLuObV6GyO/Oi30n4kqukdPbytmGFNt7jl5oMXKKuccqudDHUZcGMaA+AYVjatinqJaOar4NACBHaeykMrg+SlnbK4R/jGY3WwXGZ6/XdPajvG4SBwWj1oSZHqLO8OXrDph0IkmT6HuCA6dypleyDtV7kp9VwcxeuzinOu+ydAFqvIzuA77OohZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMYI7hZNihsx/TIWc1/uTa8jXnRDgUPNphi/lDnCOa4=;
 b=QVhVCc2+B4VQsMPEVvQ70OanqlSRAhOzULbUQOnrOWLXFyV93qtB/rr0SAH74iWBq3MWhXAoNl+grFOW8EzxIGwmogzUYuUvTuLga1OzumIOsIIy2TLx1aJ0x1ZdZFbSt3o8RtjzajRS3VKrLfCp896iFYDk/0kGRMRSZ/pXGZwiRB4V7hZHBR+MdZjjBZIPNAS9wDtLbTtVDS/6HtnlKrD3OuwIeRiQ+Ua2eWF03JANXFDpd65SObhKJGxagzMmnXRm6vwqShqYoTPKJ/RxA2uAOPPbNbEdNSsDxJegn/U39auPKG8CkY5POCu/C6XkvhJPk8f//F3PnL+49uhQxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMYI7hZNihsx/TIWc1/uTa8jXnRDgUPNphi/lDnCOa4=;
 b=PTrzTK8JdLKk+V+njLwfvvTpQxpUng7tF8dL/X1PUDZa7hwR6SFp3F5WSYBdy3eaTc1Ba7Phjrc+OfG0GCybo4o6QraJHQdf8jeIxXqXEzalOxSsFiO75RlHS0cfqwnbJxqq5gehEJms1dF14o69ZVXOw5NdpF8oOAGH5Pcvdi4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM6PR12MB2748.namprd12.prod.outlook.com (2603:10b6:5:43::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 00:44:23 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e%10]) with mapi id 15.20.3216.034; Fri, 31 Jul
 2020 00:44:23 +0000
Subject: Re: [v2 1/4] ACPI: APD: Change name from ST to FCH
To:     Stephen Boyd <sboyd@kernel.org>, akshu.agrawal@amd.com
Cc:     rafael@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20200728082857.10829-1-akshu.agrawal@amd.com>
 <20200728082857.10829-2-akshu.agrawal@amd.com>
 <159598596077.1360974.483730969007254506@swboyd.mtv.corp.google.com>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <c5041407-1bbb-82b3-e5a5-c6de0ab16861@amd.com>
Date:   Fri, 31 Jul 2020 06:14:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <159598596077.1360974.483730969007254506@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BM1PR0101CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::11) To DM5PR1201MB0188.namprd12.prod.outlook.com
 (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.32.35] (165.204.159.242) by BM1PR0101CA0001.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:18::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 00:44:19 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e1c9b8f-1705-4625-592a-08d834eade22
X-MS-TrafficTypeDiagnostic: DM6PR12MB2748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2748BCB7C0C112B61558EF9CF84E0@DM6PR12MB2748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROt5w1vm98voYaXnilEwHfDCGh+24k5b8/ty1WLvoDq9WNCcYCDDhdcV5OQqBHjURQ4OmW226S5+olBcmXbOeGuNt/5jrSun2gBxC4Kofp1zCUdsbEm3kPm1X67+Y2hnCPd+lpYfRmdjP8DANQqGnIXHau/r1UAnmawTeRLX+VtXCl8trQAKOuHxv7J4HHRnJ3hdgK5PSoD6ziK39/ctUqXauPpQpNDEf3EgU4aVrXTZgdTyfUBX99vQ7XIjedF94R61oblaHpcKGdLShQKuQViitRnL0V7UV2NYQYbBm9EV3JrWA5yAXTO7PDZVviQVTU1Q9wwr/xNIOaBOQnPgWZT8TjR4d+w+lHiskfhuqhNZL1AyJi+4wApolgf9BYdc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(16526019)(16576012)(4326008)(6486002)(8676002)(186003)(2906002)(31696002)(31686004)(36756003)(2616005)(53546011)(5660300002)(6666004)(4744005)(316002)(66946007)(66476007)(66556008)(26005)(956004)(478600001)(54906003)(8936002)(6636002)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fJoWrvAqXRZIAMxLnCzdPRi8kWl31IuV2M6+RbQCOKJcxaHNsxZixum3pm+O5DTD2FX1fuEv4RWkj1HmwC3z4iX7HHw8+fGJ+JKcckxLllMPZkN5ZRLFJMWwyvaFDFccEtMhOW3N+8fWefIlNFum3jbagb0BWbJTwEV+DLEiUYnYxWIF+TPi9MesWray2H07aoBH++WJIYtyGt7q9vefa/argF5BUWf4VEG1mkJ0thRoituSyg2jI7rqydhF7oiceaS7GbYfwmpDqDfRVk/oKujCh3uAA2TKe11nXtP9bHkt2szKAGfHjg9Qb+78kCksBnzmgHqe92AXXZJdWeJ3zw7tg1NADETDD9sjBeBsHotcKkmsgsFVvgdCJE44ym3rnYRCXg5Pn6US+QvWA7hLyqlMWQqYMiz8gXo39o2zXwq3F2UCT34G3nXXMTeE2LrsD2Ib7cyho5pPBJLqwHYHV1CNfs/YSNjeb59uSMf6zuhA35zzwbNjPYIJJfez+Ry69rprtEYpyaFlFnzG7HeNpjnxLV1QXl4ZFPmQqFgRbEQZTwwbHRXo+ZJ73ZhW20XGeeKmiSZwOSGFDNZ63B31mB0gfXMcSfpMJIPAdecePuxxuaD6ghC14plTPbYFcGZHK23TSQqI75INBe+ykip3Jw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1c9b8f-1705-4625-592a-08d834eade22
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 00:44:23.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zP4M8cAdl/GJKwhhUiZw0pMsgDf0CBdp2tC//AY8d5rSvaVjQrIFq8u/95enO2CEBar4BbhllPoaQlBPyDvv+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 7/29/2020 6:56 AM, Stephen Boyd wrote:
> Quoting Akshu Agrawal (2020-07-28 01:28:53)
>> AMD SoC general pupose clk is present in new platforms with
>> same MMIO mappings. We can reuse the same clk handler support
>> for other platforms. Hence, changing name from ST(SoC) to FCH(IP)
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> ---
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Hi Rafael,
I see the status of these patches as Not Applicable in patchwork, is 
there any pending action for me?
Thanks,
Akshu

