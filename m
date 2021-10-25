Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9416D43A396
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 21:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbhJYUAm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 16:00:42 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.1]:42652 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239679AbhJYT53 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 15:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1635191705; i=@lenovo.com;
        bh=afW8huENU5yTLOE3zkgKhYpxHW6w6o9E/m/gSooV43I=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=XK1PYtFLRmP8ZRZK7J1wjI4lRMLirdxM7Jvho86h9y/doJphUQ1+2sYafZQYsGEbk
         qS4gwyulrHLym9yhjFnUCPE2E9LW+Z2/mcBrlTaT0lyZWdEOTovlULJUoCP6fFcbji
         nf9Q9fOiW2qO8TUNVowxPzJjKxRxIs2Ct8mjqwq+KBFc+V2bObXpjgY6jyWFf3ozqk
         /Byko+2SEjS9EvkMcSsDj8cVMXNx7TyvZwaA5ydR6H1Bzz3d1xV65C0f3kd1XRtSjv
         4e1NrKCK8DOgsFHyrS+3g87iwgHzMpKqziZT4l/xGxTVmmHFrjiwSjHNDGsPLYiJOo
         pVvyP00/ady5A==
Received: from [100.112.1.55] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-east-1.aws.symcld.net id 3E/03-09470-99B07716; Mon, 25 Oct 2021 19:55:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRWlGSWpSXmKPExsWSoV9jqjuTuzz
  R4PtNdovl+/oZLRavX8Zoceb0JVYHZo/WS3/ZPLZcbWfx+LxJLoA5ijUzLym/IoE14+/DXYwF
  P9Ur3t9+xdzA+Fuxi5GTg1FgKbPErf0mXYxcQPYiVolTfYeYIJw2Jok/TedZQBwhgTlMEtcv3
  2IFaRESOMgkcfJHNEhCQuAmo8TCL4dZIao6GSV+vDoF1TKRSaLrbxtU5gmjxKTW7YwQzgNGiW
  nr1wOt4eDgFbCVmPYxHmQui4CqRNOnx2wgNq+AoMTJmU9YQGxRgXCJjqfrwHYLC8RIvJpynh3
  EZhYQl7j1ZD4TiC0iUCVxfMYaNoj7bCW+LV3MCGKzCWhLbNnyCyzOKWAn8ffcZ6heC4nFbw5C
  2fIS29/OYYboVZb41X8ezJYAis/68J0dwk6Q6Pn3iA3ClpS4dvMCVFxW4ujZOSwQtq/E2e/3G
  CFsLYlNVy5DxXMk7i09wARhq0msOb8ear6cxKnec0wTGHVnIXl5FpLXZiE5dRaSUxcwsqxiNE
  0qykzPKMlNzMzRNTQw0DU0NNI11DUx0Eus0k3SKy3WTU0sLtE11EssL9YrrsxNzknRy0st2cQ
  ITEEpBYwaOxg733zQO8QoycGkJMq7/GxZohBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3mSu8kQh
  waLU9NSKtMwcYDqESUtw8CiJ8HaDpHmLCxJzizPTIVKnGC05Jrycu4iZo+nDEiC568mpxcxCL
  Hn5ealS4ry2IA0CIA0ZpXlw42Ap+xKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYd4qkCk8mX
  klcFtfAR3EBHSQn24JyEEliQgpqQamtea1L5rur9u00tpjTwTnp18v2D5KL7vI5dPv6dt4WXT
  TEq0Fx2bOcEiuYTb8qsrY/vdh9s2Tc0/ey2fLVptoyrZq9uy/rjnT1ZZGrJ4rW7M/8ot9dtpv
  dtbCH0vcaoI61oU3zHWavHWbu4PIoo7oQAVOJpFUzemzFLKivhtLsm/Me3D25dR3hX4W1xQ/y
  LctsZy7LzQ59etxy++uci3C9ucFCs5K3aoLaIs99POHS0dXh47kKu3AoEoVm5XsbA1KFsFM7+
  7Em00sc7ogcuB7LltC2nr3T1tqVsnufhuwblKV+aKeqJPX0ye/P+bdf9ew9bNRo6T8xsQ5Ud/
  spNUlppTyLrnwg7M7emthV4YSS3FGoqEWc1FxIgAVKBkeVAQAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-7.tower-386.messagelabs.com!1635191703!35072!1
X-Originating-IP: [104.47.124.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26611 invoked from network); 25 Oct 2021 19:55:04 -0000
Received: from mail-hk2apc01lp2053.outbound.protection.outlook.com (HELO APC01-HK2-obe.outbound.protection.outlook.com) (104.47.124.53)
  by server-7.tower-386.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Oct 2021 19:55:04 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADKjMMXfUvqRjPXXrlFE+lB53MhRxew+galqV7fIMlCY9gpJVAd4lt9tAHZzpowqzLEGT6qiwXV+6b7WHqGsIqDqCm+wrThPGhlYMtbb2/SYyjSqLb77jmamh+2eMmKSMn6BGuOn2HNHa23JeI1DAN2sBMiig8x9RpSAX7/xGFoIdNttp5FPl+tUZRsHN2PVLsvxKn2Cetj8SS+b0l/4jzhg6EUjyNfqU3eGNgtnyCsKEdY6N3PPPlagQB/N0k5m+0//+0vhIf1qERLO0EanS3Ubeg3riTM6z++jXjRnIMPO3ibL3gvpsLgk5YmoCPwe4qomzkKZ1v9gC0CfaaXSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afW8huENU5yTLOE3zkgKhYpxHW6w6o9E/m/gSooV43I=;
 b=GxVoVdidz885kr6IW2yxUjudLb95TXq2KVFGyDMWZ1h6bn4k2FyK+HtmdXG+HSBA5OZWwWF541Y+b6EndbYRkJMZL69YQY9B0m47h6rQXYoqtmHr88ZCpH4Y+d1v6YwGOxm1Gr1IFfMs/E+4H281y3pw6RqePfvBiO5AeWSpEyAiQcf3ilHWbqrgcE5ap0TaRpU7znfuccldPGRY0JZEjotxa4UrnBu1G0jfAZbaSJbZa27N8O0sDk3yboG9wTBC/afT3ikOFWWXB71hkhty/hc9vOQPfW5mO4EnEYuLwJRCWw6PNrDXE7JbHPEJZojIqwZhK7Sb5BZWMAg/YHWvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=amd.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SL2P216CA0105.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::20) by
 PS2PR03MB3735.apcprd03.prod.outlook.com (2603:1096:300:2e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.12; Mon, 25 Oct 2021 19:55:02 +0000
Received: from PU1APC01FT060.eop-APC01.prod.protection.outlook.com
 (2603:1096:101:3:cafe::32) by SL2P216CA0105.outlook.office365.com
 (2603:1096:101:3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend
 Transport; Mon, 25 Oct 2021 19:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; amd.com; dkim=none (message not
 signed) header.d=none;amd.com; dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 PU1APC01FT060.mail.protection.outlook.com (10.152.253.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 19:55:01 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.12; Mon, 25 Oct
 2021 15:55:00 -0400
Received: from [10.38.56.18] (10.38.56.18) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.12; Mon, 25 Oct
 2021 15:54:59 -0400
Message-ID: <5353d34c-c8db-d3c9-2f0c-a8be633721d4@lenovo.com>
Date:   Mon, 25 Oct 2021 15:54:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [External] [PATCH] ACPI: platform_profile: Add support for
 notification chains
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
References: <20211022181608.3121-1-mario.limonciello@amd.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <20211022181608.3121-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.56.18]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54433984-f86e-43a4-ac94-08d997f1554c
X-MS-TrafficTypeDiagnostic: PS2PR03MB3735:
X-Microsoft-Antispam-PRVS: <PS2PR03MB37351781956C7AA71B8263AAC5839@PS2PR03MB3735.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nV95Ocg/4Z6fdLK3WNP4uTc/5I8Cc89v5F5Rt7tCAFHKVYmM3tZT/BaJ0n92GIepR5oS6rMKGpATmZWmXupRoQ5cRl2mfAIP78WvM0lU5wPgthmztpIq2b1GDgidjkRxAgXef+h+KA9eq1XqanHuSLpaX8Vx2lLiAJXnWsq1rsvVuEe1TxPYrGuPHNis2Qp7XFpNY4Y6K9ELk7zYgKdSeoE/hVrUFpJq9UQ278V5IG3fLeZnU5clOxY/7dwE9XKt6JLeHDY0LbOBOklsID3p+sSZo28wW4LRjmABywfbeaj/laxh/5a9MntBGLKblVUt5ijkTCMRJQ7Ot82ePAOxfwwGGWU9/031Qw9iRz9ChC0sTTnKGSmCPUHwmbYvNFzT0I1MpfS5UNXaRDpfzAeHpjJMWBchgvmTIu5+qrfWP/+As5Ne9BpDowebr8xcTRGIQFe0JjrSs9FZlY/56UJ/+N4DhLk9J0ptjDOlnZ/Z5I2GHZISU0H+IH3erZ3qLgM5BHK0lt53MlM0CwNoE3Rar65hBxae52SOAV64hLTEjsh0hZ0x9/2VNQoDv7Z1bRVFL6adk8ZcfuXQT7pKqHWpMeGYpo+jLfUuFCYoOVrlzL40Ua3uAeUdfo1YCFN0qzxJGoM+B9espVSQfV6nvyu3qbawF4vdfArwmGBCJwy6hhXcDeFDdhrWuVzxWuC/ditnp7czqEvdRaEHmOTKOMV1u3kv7NdCOtIisC3SQ2Y1l/NPVgrPtRE+wrIzXBJEawmfL1gpIPOKHAlCJd0F47Eg06w7Fi1qed0J2dwFhbFFUvI=
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(426003)(70586007)(336012)(2906002)(81166007)(47076005)(186003)(31696002)(26005)(2616005)(5660300002)(82310400003)(31686004)(82960400001)(86362001)(4001150100001)(356005)(16576012)(70206006)(16526019)(83380400001)(8676002)(8936002)(316002)(508600001)(36906005)(15650500001)(36756003)(36860700001)(53546011)(110136005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 19:55:01.9188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54433984-f86e-43a4-ac94-08d997f1554c
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: PU1APC01FT060.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR03MB3735
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mario

On 2021-10-22 14:16, Mario Limonciello wrote:
> Allow other drivers to react to determine current active profile
> and react to platform profile changes.
> 
> Drivers wishing to utilize this should register for notification
> at module load and unregister when unloading.
> 
> Notifications will come in the form of a notifier call.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c  | 44 +++++++++++++++++++++++++++-----
>   include/linux/platform_profile.h | 11 ++++++++
>   2 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index dd2fbf38e414..964e0c9bf70d 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -21,6 +21,25 @@ static const char * const profile_names[] = {
>   	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
>   };
>   static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
> +static BLOCKING_NOTIFIER_HEAD(platform_profile_chain_head);
> +
> +int platform_profile_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&platform_profile_chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_register_notifier);
> +
> +int platform_profile_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&platform_profile_chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_unregister_notifier);
> +
> +void platform_profile_call_notifier(unsigned long action, void *data)
> +{
> +	blocking_notifier_call_chain(&platform_profile_chain_head, action, data);
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_call_notifier);
>   
>   static ssize_t platform_profile_choices_show(struct device *dev,
>   					struct device_attribute *attr,
> @@ -49,11 +68,8 @@ static ssize_t platform_profile_choices_show(struct device *dev,
>   	return len;
>   }
>   
> -static ssize_t platform_profile_show(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> +int platform_profile_get(enum platform_profile_option *profile)
>   {
> -	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
>   	int err;
>   
>   	err = mutex_lock_interruptible(&profile_lock);
> @@ -65,15 +81,28 @@ static ssize_t platform_profile_show(struct device *dev,
>   		return -ENODEV;
>   	}
>   
> -	err = cur_profile->profile_get(cur_profile, &profile);
> +	err = cur_profile->profile_get(cur_profile, profile);
>   	mutex_unlock(&profile_lock);
>   	if (err)
>   		return err;
>   
>   	/* Check that profile is valid index */
> -	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
> +	if (WARN_ON((*profile < 0) || (*profile >= ARRAY_SIZE(profile_names))))
>   		return -EIO;
>   
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_profile_get);
> +
> +static ssize_t platform_profile_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
> +	int ret = platform_profile_get(&profile);
> +
> +	if (ret)
> +		return ret;
>   	return sysfs_emit(buf, "%s\n", profile_names[profile]);
>   }
>   
> @@ -130,9 +159,12 @@ void platform_profile_notify(void)
>   	if (!cur_profile)
>   		return;
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +	platform_profile_call_notifier(PLATFORM_PROFILE_CHANGED, NULL);
> +
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_notify);
>   
> +
>   int platform_profile_register(struct platform_profile_handler *pprof)
>   {
>   	int err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index e5cbb6841f3a..390d95d47e07 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -11,6 +11,8 @@
>   
>   #include <linux/bitops.h>
>   
> +struct notifier_block;
> +
>   /*
>    * If more options are added please update profile_names array in
>    * platform_profile.c and sysfs-platform_profile documentation.
> @@ -37,5 +39,14 @@ struct platform_profile_handler {
>   int platform_profile_register(struct platform_profile_handler *pprof);
>   int platform_profile_remove(void);
>   void platform_profile_notify(void);
> +int platform_profile_get(enum platform_profile_option *profile);
> +
> +int platform_profile_register_notifier(struct notifier_block *nb);
> +int platform_profile_unregister_notifier(struct notifier_block *nb);
> +void platform_profile_call_notifier(unsigned long action, void *data);
> +
> +enum platform_profile_notifier_actions {
> +	PLATFORM_PROFILE_CHANGED,
> +};
>   
>   #endif  /*_PLATFORM_PROFILE_H_*/
> 
I'd not come across the blocking_notifier implementation so good to 
learn about that :) Thanks!

I was just wondering as alternative: When your driver registers it also 
gets the current state; and notify would use the data field to give the 
new state - instead of needing another callback. It might save some back 
and forth.

Not sure if it makes things simpler or not on your side (maybe reduce 
likelihood of race conditions)?

Thanks
Mark
