Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942432A4537
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 13:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgKCMcG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 07:32:06 -0500
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com ([40.107.243.79]:43232
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbgKCMcF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 07:32:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCQBV115CjxvzlPv3GL38QkuTLhUopkoxppTiOgs+bihlguIsC8kF/+a2Z8ZZ/fxaEE3cgiyEetNqTS/pwGj0kMP7/fP5QuBCMH/vqvR/E2GMsHfJdMQMU07CSu52u+JHfoqZTUIe91u6WI2bbvkr4h84XoYE362dHYgKhaegbjsiz/Ui2fpVc57OeCShWT7WUWS3ghrv7U9hXYJ91JKqy0OxNl0ft52KeEhH7xpxE7AVXX/bCYk/u8Hjq6y92uhyLm3VPvi0udsHOD+rvZvN2Kr8YDwHFVMEd9+UlnVVRC9JFZPtwNeO/oaich9MqPZLW0ffqNPlv34TZuIBedrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G48YiEIyaK8kIwdBNocMIAwq5UNwRbFLYlFATAplJoM=;
 b=Ok1VKSsoOOYut87WRAAaiqRC5o5GnmmEo777N3VmpFUSouFCgX73OYJMqXei5jm3zhQEyYQZU1NvezzDETQYeOWTFgzyDN6iqk5/jOXrSmuN9wYMGuFvZj0T1h5Mb8KP8bcolRHhQInCqXYKDWWCEbMHYIRAOl7YhYeEI5KGi2u9Xlk/xrQjUbM46jw8L0ZsSVp5LQV92iXn/OPYfGpUw73/JUtt7BS0XYC5RJek6IsLKAuEpNiG1Of1rM/OtcLYf08ObwaHcgiU1nxU0t2+X3Yk3S/BwuKp10CMek2JCmoe3Ux8W++Ua4a4+Yn2ny5Pzb0eTKu9W/FpXg/zvQYnAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G48YiEIyaK8kIwdBNocMIAwq5UNwRbFLYlFATAplJoM=;
 b=DzjWLWLANA4tIINETLEBthC/gMKod78I3cyJKw5TbMU/E9gyLi1aJSr7DdR7XCyjpfYfFk2AYEDZIe6DhyS2O+kPPoHQEF0R733fkMRmaVg4il++EcKrtCiy6KQJzyJ8cIBukOBnpMEFUmYaewBddW0T2/0TBd18cssrfQvbpL4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0004.namprd12.prod.outlook.com
 (2603:10b6:404:ac::23) by BN7PR12MB2723.namprd12.prod.outlook.com
 (2603:10b6:408:2d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Tue, 3 Nov
 2020 12:32:03 +0000
Received: from BN6PR1201MB0004.namprd12.prod.outlook.com
 ([fe80::3cd9:1c02:b4b6:104f]) by BN6PR1201MB0004.namprd12.prod.outlook.com
 ([fe80::3cd9:1c02:b4b6:104f%9]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 12:32:03 +0000
Subject: Re: [PATCH] ACPI: PM: s2idle: Add AMD support to handle _DSM during
 S2Idle
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        Alexander.Deucher@amd.com
References: <20201023080315.458570-1-Shyam-sundar.S-k@amd.com>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Message-ID: <0de1bda3-79d0-6f05-43fa-4e46972bb481@amd.com>
Date:   Tue, 3 Nov 2020 18:01:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201023080315.458570-1-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [117.236.185.255]
X-ClientProxiedBy: BM1PR0101CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::24) To BN6PR1201MB0004.namprd12.prod.outlook.com
 (2603:10b6:404:ac::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (117.236.185.255) by BM1PR0101CA0062.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 12:32:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e21a2246-924d-4e01-35db-08d87ff477a0
X-MS-TrafficTypeDiagnostic: BN7PR12MB2723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB272329EA1996AC84EB49502B9A110@BN7PR12MB2723.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylljsiuYh260aMqLqIqRDTwch1OuiuAP0lNFfxqS9WBKJCWMmMI8uiK0u2e7A0ClmHjp0P1UFayH+qTzebq+HktDjR3sQ8wegY5HmbdJv+18qcnTuEoavriMQ8+dxYrUDaWUi3WeodMEH76Fqqm5kunzCxIbFZU3apNriLKiA+ZQ0QlFf+0ciJXzqZzlnsL2DgESBdrl3Tic83o7AMYizYnWZkGAY0WcpHK7YAWX2iBCEWyrAQaFycp+64N8+C+Lva8ZZjNrpc+DPvqqJfEW9ukpK+dzNhkRiQDDKWv1IRfyHy9s+PVUzqbxNIPZ7Yu1fJeScttKxOBZoTa7iVCdwKRJVDGeDNbJy8lfJS/vTBGlRBTsetqAvIpG2P037SjTnCYqL5VGoOKBYwdPrsNvwRaRHGJBek4DyubxiB1vn6uXzkMwUR4Xjm0mkRvl8n0tLZ+jk2U4uvOr4BTBVUi2nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB0004.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(6636002)(26005)(5660300002)(956004)(52116002)(53546011)(86362001)(6666004)(2616005)(16526019)(966005)(186003)(8936002)(4744005)(8676002)(31696002)(478600001)(66556008)(316002)(16576012)(2906002)(66476007)(66946007)(31686004)(6486002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1sdwYlE54is5lZ+jS23N4YLugaxa+4uVKVyahyPtdoVjgOaqXhvyyo39aGgYw1u5UTOuyyr9D4qkzPFk8viiN3Jqi3zdb4iDvolKvLGELyq44ihhMhKHguV3hmLFzG3bl+PHHLC9QAEj/ZgDKQpVRyWmf6rai96M4sIqVrietGaGXzhIPcqCUfe3vMFhvqNmAfE9LZEHXmOD6pkTr5JFDR2y/CeHkJR/T9NSaoJHUifm1oXNt1tRozQXeoaZVo9xN/J/2geg4/ROLf9/FJ5dydrcH6GaIm5Y0zwssle04IQheStvYi21Y5uRa+7ksOAZpMxjGYgaK3vVoZHSTZqZpL8jC+Km7z3zML2Vzdey/QIVO430gxxPhp1ECJqCxBo5QwqdJddXmSkx2RmhZCxVAbdYI1d7TVse5EDM2oYPpUD813OP9rpgEy7OxhkBiTAMyKPF2Smlp/ZJvzCPP50ZLbN7VVHp/QvlwcK7gyje5PcjD/DxwPn/HdVwFjGC5ByUQudsVpMOBs4Df3Q17/o9WY4BGq86XUCxNPD7HzldJcMDCZXFD47C+0HrPaN0esjaGsabi5DPdjpz/1aiFwSZvvivJ1favg2fPS5vRNobng2qbj+pkhHrW18ngFRd+ILS3kl0VXMfiGONHYHz4tQu6A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21a2246-924d-4e01-35db-08d87ff477a0
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 12:32:03.3049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zzzn4bqb85bBbfIF2ijquOtWkKeAHWHGQdzNPg7CtZMQxWmUsZBv/nNtcuMTNUXvSsNYFMyWDlc16wt55FVcFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2723
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Adding Alex

Hi Folks,

On 10/23/2020 1:33 PM, Shyam Sundar S K wrote:
> Initial support for S2Idle based on the Intel implementation[1] does not
> work for AMD as the BIOS implementation for ACPI methods like the _DSM
> are not standardized.
> 
> So, the way in which the UUID's were parsed and the ACPI packages were
> retrieved out of the ACPI objects are not the same between Intel and AMD.
> 
> This patch adds AMD support for S2Idle to parse the UUID, evaluate the
> _DSM methods, preparing the Idle constaint list etc.
> 
> Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf # [1]
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---

Any feedback on this patch, please?

-Shyam
