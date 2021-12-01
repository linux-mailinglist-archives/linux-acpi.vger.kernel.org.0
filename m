Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35DE464F5A
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Dec 2021 15:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349656AbhLAOJb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Dec 2021 09:09:31 -0500
Received: from mail1.bemta31.messagelabs.com ([67.219.246.112]:41607 "EHLO
        mail1.bemta31.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244833AbhLAOJ2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Dec 2021 09:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1638367567; i=@lenovo.com;
        bh=Gcv65RrBiMWzA+ygpqyHXiBgB4ZPaC+52h10OQv5Uz0=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=z3KsKccZDXvI0inO2vVkgfWEzgbVX5l2W63S94anW/EMKHQSQNB7Y1IQLEP3XrfwV
         5D1p9XeBHeYX59kM142UKJeZg33vq9UicZWIfS8oH02KDmNCBNmtA/8gDzGN9+11L3
         89tdnv22x/MtF0bzWhxrE3Q+7/8XreE7BFT3NHhgXYe4/msWiF1mDxJ4FD02AcGTAk
         eIJ6gmIv1bKXrqz4YzUaAzPJK8ddaZwZOkQAF2YWTPF28qTtnVbCszpjAYpU/ACmAw
         hzR6vF5cnv8bXrY/tOJhVIT2axhDLGAhgJ/pFDChsAt48D9mf8daYOifwZfwtvOyBR
         DHqjMxZuG4CmQ==
Received: from [100.114.1.181] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.us-east-1.aws.ess.symcld.net id 4B/A1-01499-F4187A16; Wed, 01 Dec 2021 14:06:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRWlGSWpSXmKPExsWSoS+lrevfuDz
  R4Hcrp8Wb49OZLHY+fMtmsXxfP6PFmdOXWB1YPDat6mTzeL/vKpvHlqvtLB6fN8kFsESxZuYl
  5VcksGb8v9vGUvCdo+LFwRmMDYwH2bsYuTgYBZYySxxbvhTKWcQq8fHxMkYIp5NJYvK8e2AZI
  YE5TBLzP/SzQTiHmCRWHNnCAuJICBxnlOg+tI4JItPJKPHj1SkWCKcfqGdzEzOE85hRYuexOV
  CZh4wS126eBspwcPAK2EqsfVPexcjJwSKgIvHz7XdGEJtXQFDi5MwnLCC2qEC4xNlVt5lBbGG
  BFIm3c98ygdjMAuISt57MB7NFBIIknv5+wwwRt5X4u/YsG4gtJGAhce/PVzCbTUBbYsuWX2A2
  p4ClxK5vb1gg6jUlWrf/Zoew5SW2v53DDNGrLPGr/zyYLSGgIPFoagMjhJ0g0fPvERuELQn0y
  gV2CFtW4ujZOSwQtq/EpgfroGwtiTc7LkPV50gcOLQQylaT+HhuOusERr1ZSF6eheS1WUjOm4
  XkvAWMLKsYrZKKMtMzSnITM3N0DQ0MdA0NTXSNgaS5XmKVbqJeabFuamJxia6hXmJ5sV5qcbF
  ecWVuck6KXl5qySZGYJJKKWIu3cG4v+en3iFGSQ4mJVHew+XLE4X4kvJTKjMSizPii0pzUosP
  McpwcChJ8N6pBsoJFqWmp1akZeYAEyZMWoKDR0mE17sOKM1bXJCYW5yZDpE6xWjJMeHl3EXMH
  F09C4HkpCO7tzMLseTl56VKifMmNQA1CIA0ZJTmwY2DJfVLjLJSwryMDAwMQjwFqUW5mSWo8q
  8YxTkYlYR59UCm8GTmlcBtfQV0EBPQQW+XLgY5qCQRISXVwGT1tvPo1hnr15lel17P4KLx2ij
  +5XTZJtuCF5ws8YnH6zpvxp68/F7ZjvViu3Or9/QpvtFv4qdpfGaeatnx0V0voCRS5f4WM6Ou
  CYnb/6VK5F/x/n/jqJfaB9EOBoOU38HaO27k/G7xeTblbvWtN1yWsT+7POLN5zBk6iaHBPk7W
  2/RvGowrZ83NM8h+aXUMcHWqQ3rm3riL953bHlSrF5+jCvwruksKeHDnbxCmstNxXef2NTi1l
  P2zrpN67e61fJ25scXEg7OWThTRzu9ujuPg+XqwofWOT3uJb836q6Z47hFYfMF1sgviZw1L+S
  7WWO8Wjz7KspnPt4VflRtAffc0LoLMrzXxS0lw5SUWIozEg21mIuKEwFGC36RZQQAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-5.tower-706.messagelabs.com!1638367565!29799!1
X-Originating-IP: [104.47.26.43]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18149 invoked from network); 1 Dec 2021 14:06:06 -0000
Received: from mail-psaapc01lp2043.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) (104.47.26.43)
  by server-5.tower-706.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2021 14:06:06 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0qWV66qu/EWeDNZDKpGJI7jEJxlVNj20vErKC6wGifBO8tKPrGjfrtxWfBJjGfE9gp+VoOOBwK3pP+OcHg8TvGY5wdBgLKB32zZ6aC3sY70jVSCiYcOZnogNRxAu3H+512NYVYkcIrX8yLgV3nik4wQ7oeJBRaaQ4h7OXeCHOim/EAFYfpxxqb2qc5KfngMT6EAvzp6hc8pFmRPI+dh/VIky7O2Wqv1Ch/Qbsa7k2+lOVOLthWamC84qNfiQv2W4BH6OZOgRT5OJ0W3rFAbymJD5IpA5f42OAjDbsG95ls8dd9LM4zzN7JEWFLNg5sWfydQ+L1SN4BnG6dT1p037g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gcv65RrBiMWzA+ygpqyHXiBgB4ZPaC+52h10OQv5Uz0=;
 b=VD5CNnlnkWWWlYA/PWSwWJiAT6FhBKXQ4HidA23M7fb74zIXX0gR6sbpQm0gzWy3rcjPdTLBtvex5ltOVhNY0Wh/jMeh/a6mY6ud7UP/GMw6KPcoac2ZCtlPyY3ZZoJdgyuBm4798BHpWrR+2OfdFPKg4JE7s8utQdZzVBddfCuDrGWmYfwXOgUxauCH8QtMST/XI7Go7nW8vnpz5yJzJTq0zmqTlWwmoGqL3IFABX/anxTWPzf3F9fW4qUpeajILAITIcNbOwnWuytlWDt3nxkRjqhkcUsvuQoLrvyOy6CWjMe+xY12CJ+8ZltCJeHVYwPMVJznND5hzMJwLpstaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=redhat.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from PS2P216CA0026.KORP216.PROD.OUTLOOK.COM (2603:1096:300:1a::12)
 by TY2PR03MB3440.apcprd03.prod.outlook.com (2603:1096:404:37::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9; Wed, 1 Dec
 2021 14:06:04 +0000
Received: from PSAAPC01FT046.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:1a:cafe::23) by PS2P216CA0026.outlook.office365.com
 (2603:1096:300:1a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Wed, 1 Dec 2021 14:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 PSAAPC01FT046.mail.protection.outlook.com (10.13.38.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 14:06:03 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.20; Wed, 1 Dec
 2021 09:06:01 -0500
Received: from [10.38.96.153] (10.38.96.153) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.20; Wed, 1 Dec
 2021 09:06:01 -0500
Message-ID: <6990b275-9a09-a135-8e9b-d5c963040770@lenovo.com>
Date:   Wed, 1 Dec 2021 09:06:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [External] [PATCH] ACPI / EC: Mark the ec_sys write_support param
 as module_param_hw()
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
References: <20211125103616.47742-1-hdegoede@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <20211125103616.47742-1-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.96.153]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9afbbdb-39cd-4ea5-ee1b-08d9b4d3b645
X-MS-TrafficTypeDiagnostic: TY2PR03MB3440:
X-Microsoft-Antispam-PRVS: <TY2PR03MB3440584A06D596014DC4065CC5689@TY2PR03MB3440.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 347PkbHAKHdTjDXgwE+Ws/v9c2KTBbk9MDiLd2QoJyM7nMQYOrgrLJKeXY/QWsMC8d8zGrVeZ2FY562u5aJS9bBSn4OruzsJWsGmrcO4FlP6hFT9Bn9hEYSeBPh9uIFK9U00PfBnwWDcvH7DUDIxHByxrBkDRea71faUPdHVJSiwGNJvxL3ZS+3Qj92xsNEKDx2oLaK5hxIeCgAMFsIbIHl5/JWZdehVdF1E+3WAa3jPX8mjh3zLyrfna0eKUdQXQj6aXvJXpLVQhaCT8nERE4/zSfXiFMAUkVZRtAXEBDPE04hDeGVKrr1GfMDIocpXzwtVushT0wifBMoNIav1ZQ4df9OZCwm2LMjUtpWv8fpbKpDT6tZVlDcbSiKJvZfSU8XFDCXiJ+/AwL/gbRBOshPRX8XMPO9pSugqI1pF9Por+3jM894DyYPqj6ubwkSN5E4QtHRXE2e8wIHXIrCBq8AzgZKq1R+Xwmy4sBIC8eHG6v1hKZCydRvOjKaoZM2xlgNv3btYn3qCo6CND3Tkxg0D4nnQV3M3cHsladRZ2uYbzU+eSnskIX81J1BcsgiNV2ePUwOrsY4rJ+14odDOJXCq+UNDV8jnxbYwAUaierFU/mcFiA1INLM49z9aketJc21LJXGnf4gxA9yDkV0gaIq4fye8FfuVb97UJ7ozjOHi2ubCbyD0G5/cpFu2vS1OxMshn7SGPc25e1NR+YOiLhkWyA/h7IJWH/frbyy8eRwum+nikG8OY9uT2Jcdr7GtIo6q5Ie1C3vlkCEdsiatS079pjvCfCkJ2QrByYMzyklQ2Tg+8wfwSFgtFuRSx/4dWJhCv4wUPpWPMvvZdKNNRQDe5JFO0DdXS27evldfvl32/sEKdXS/RQNBGUYqntknRMTIUcW+oDRbftgYRlz6bZgXHGdIiCTA0HtVmDorHa8=
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(4326008)(8936002)(82960400001)(356005)(86362001)(40460700001)(70586007)(2616005)(36906005)(31686004)(16576012)(36756003)(47076005)(70206006)(31696002)(83380400001)(2906002)(8676002)(316002)(508600001)(53546011)(82310400004)(16526019)(186003)(110136005)(54906003)(5660300002)(81166007)(4001150100001)(26005)(426003)(36860700001)(336012)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 14:06:03.4396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9afbbdb-39cd-4ea5-ee1b-08d9b4d3b645
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT046.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3440
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 2021-11-25 05:36, Hans de Goede wrote:
> Using write_support=1 with the ec_sys module changes the mode of the
> "io" debugfs file to 0600. This will cause any attempts to access it under
> a kernel in lockdown mode to return -EPERM, which makes the entire ec_sys
> module unusable.
> 
> Use the special module_param_hw() macro for module parameters which
> may not be used while in lockdown mode, to avoid this.
> 
> Cc: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/ec_sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
> index fd39c14493ab..c074a0fae059 100644
> --- a/drivers/acpi/ec_sys.c
> +++ b/drivers/acpi/ec_sys.c
> @@ -19,7 +19,7 @@ MODULE_DESCRIPTION("ACPI EC sysfs access driver");
>  MODULE_LICENSE("GPL");
>  
>  static bool write_support;
> -module_param(write_support, bool, 0644);
> +module_param_hw(write_support, bool, other, 0644);
>  MODULE_PARM_DESC(write_support, "Dangerous, reboot and removal of battery may "
>  		 "be needed.");
>  
> 
Looks good to me. Thanks Hans
Mark
