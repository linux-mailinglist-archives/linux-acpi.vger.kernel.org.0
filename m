Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A601343B9B0
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 20:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhJZSim (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 14:38:42 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.115]:27137 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhJZSil (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 14:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1635273377; i=@lenovo.com;
        bh=ALoJFPVAOf3K43x7pmlN2eij7WGHmwJ7sEBSmEBjlxo=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=0lucFLz5BoPtbddBKkJbN87JJgU+M1rkWrQiKOmpmIollZFZx8iuImsyco1uIiIGE
         jTdnaZl6HLh/rbhhLy7dlUfyZoCXcPCexPUT2bwKI7YA3a5fVJyyLGoEkzfGb7BO9Z
         /3Y/ax6n2Ic6kl0EYcEPrjMm3+Jley6hv+jdQJqN9gdicc9rqEPuimzE+vpG9r7Bu+
         oZn50TLeboVG5ce2Fk9PUbwO3Aci1RmB03FO1lCopnGpDNympDVUIbJMIjd8exfmc2
         r0Ksp7pxTku8rILDSrE50zgTLEEVc9dID9RwUsNODoq4zilNKslratCtTQHM9DF1bn
         fOvartYdULugA==
Received: from [100.112.134.244] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-west-2.aws.symcld.net id 52/51-24874-0AA48716; Tue, 26 Oct 2021 18:36:16 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRWlGSWpSXmKPExsWSoV9rpLvAqyL
  R4PVrGYs3x6czWSzf189osXj9MkaLzx2TWSxW73nBbHHm9CVWBzaP1kt/2TzmnQz0eL/vKpvH
  lqvtLB6fN8kFsEaxZuYl5VcksGZcX/WQueCqasWnFxPZGhgbFLoYuTgYBZYyS2y4P50dwlnEK
  rGw/RkLhNPGJLFt3h0wR0hgLpPEyyVz2SGcw0wSN9Z3M4M4EgI3GSXmdy5ig8h0Mkrs3voDyp
  nEJLFrwwZWCOcJo8TkllaoaY8YJfbcWMHYxcjJwStgK9F58zgbiM0ioCrxe0EHE0RcUOLkzCc
  sILaoQLhEx9N1rCC2sECyxKT9zWC9zALiEreezGcCGSoisJxR4v7dE0BFHECJTIlXq8F6hQQK
  JJ4vvA5mswloS2zZ8gtsF6eAncSXq91sEHMsJBa/OcgOYctLbH87hxmiV1niV/95MFtCQEHi9
  LZdrBB2gkTPv0dsELakxLWbF9ghbFmJo2fnsEDYvhJ7n55jhLC1JD7PuABVnyNxsv0jVL2axI
  cte5knMOrNQvLyLCSvzUJy3iwk5y1gZFnFaJFUlJmeUZKbmJmja2hgoGtoaKRraGysa2RorJd
  YpZukV1qsW55aXKJrpJdYXqxXXJmbnJOil5dasokRmL5SClqv7mCc8+aD3iFGSQ4mJVFeaaeK
  RCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvO3uQDnBotT01Iq0zBxgKoVJS3DwKInwdrgCpXmLC
  xJzizPTIVKnGC05Jrycu4iZo+nDEiC568mpxcxCLHn5ealS4rwf7YEaBEAaMkrz4MbB0v0lRl
  kpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8hZ5AU3gy80rgtr4COogJ6CBmJbCDShIRUlINTD6
  izyefW/vkzd+3Vcn31OJ3/24SMxadYMfawHUvp7Sj9cUqg9/BtixvX7p/fXBnUvGLtbOu91R+
  mLH24CQNPovolzZ3A69Mvq2tvm2WqvOEaxOqmvoF7jh+8tVdFf2d9/aEmwVH392vqc4S6BHPc
  X33dGZ+1a+99ns3hEh+TBHMmbDm/WtGrYm+r489Psv7tiaa5S7D1FYvyUnVLzeY9HNwlnDceO
  jvKXT42ZPNE9N9o2V5pHodQ1damFeXKIst+3Eq8nrYKxZZjwP/Hrc9jL9bwch0aZKgXaNuq9I
  pKe4/Wg2Ft6ydcgLnzHM0uBz5R7n77IGvG6JzE9ZlfOX/dylxv4NH5HUW86XH/3wviFJiKc5I
  NNRiLipOBACAIB/XcgQAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-4.tower-355.messagelabs.com!1635273375!222976!1
X-Originating-IP: [104.47.125.50]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15124 invoked from network); 26 Oct 2021 18:36:16 -0000
Received: from mail-sg2apc01lp2050.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.125.50)
  by server-4.tower-355.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Oct 2021 18:36:16 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li6DhhEF+1S5MDChC2sveovAiBg90B235zdFUIGEUmbGLUqMmUbCArn2ULn9XyFnGs+KOUMsuVl3Nl0IENs4GEYI04qxtEwhond3rJYK/I3pwaApYg3iQOxfcFLFNjzdo0achBSO4TZdCPrRRCXmXfEM6WQYiqgv4/c+BZEGgl/TrlBMaqujLyM4/2nSRdWXjgUh1e5LdGiRnUtbY8FXIHfNRGhamM2/uQyJHNi6T+JNTy/qQlP1uIpys2fxpxsmku0r9pCdRJCa1YoF5Efn4PlJlZ9hxWVGidZlQM3u++oxDDzPyIvTQ3YQgoiIeT7DAOs0d0NhRj/TIfb6hv7Nxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALoJFPVAOf3K43x7pmlN2eij7WGHmwJ7sEBSmEBjlxo=;
 b=P/t/ptgHoi9BkohEgKUBE5I5BAOSMi/cScZWgoBcQgn9nV7oszAr6sZj/G8aZF1nyNbOMmBHrgXX2NM4W8VFIAPR5ijWKG2Ekq7gTf8ikli4dfX1gNs+2+9nkA45YTgyTG7LBakLcNWKKuoDDPCHz+jQH34PAy2KOjhlK52C7G9SQwmFr/U5i1ozDSjtpM/eAFUwqoZe+n5USVSyUk4mBVbHNZpceMpfan8KzYoK7v0F7QTi/Wp/y4OBXwMLXqzfyI135FradqRoLQNkXlx2l5luJ1ue0VL8XV0alwW+EpGcRalSnJ1xqQU2FYzk+qwbjuVvIZTX9WVUAOiBRSb2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.6) smtp.rcpttodomain=amd.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from HK2PR02CA0166.apcprd02.prod.outlook.com (2603:1096:201:1f::26)
 by SG2PR03MB4992.apcprd03.prod.outlook.com (2603:1096:4:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.10; Tue, 26 Oct
 2021 18:36:14 +0000
Received: from HK2APC01FT063.eop-APC01.prod.protection.outlook.com
 (2603:1096:201:1f:cafe::26) by HK2PR02CA0166.outlook.office365.com
 (2603:1096:201:1f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 26 Oct 2021 18:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; amd.com; dkim=none (message not
 signed) header.d=none;amd.com; dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.6 as permitted sender)
Received: from mail.lenovo.com (104.232.225.6) by
 HK2APC01FT063.mail.protection.outlook.com (10.152.249.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 18:36:13 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.12; Tue, 26 Oct
 2021 14:36:10 -0400
Received: from [10.38.56.137] (10.38.56.137) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2242.12; Tue, 26 Oct
 2021 14:36:09 -0400
Message-ID: <9a4ef81f-a064-31c0-d52a-42f79b12191f@lenovo.com>
Date:   Tue, 26 Oct 2021 14:36:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [External] [PATCH v3 3/3] ACPI: platform_profile: Add support for
 notification chains
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <20211026180535.9096-1-mario.limonciello@amd.com>
 <20211026180535.9096-4-mario.limonciello@amd.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <20211026180535.9096-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.56.137]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7513b3b-be67-465b-160f-08d998af7d49
X-MS-TrafficTypeDiagnostic: SG2PR03MB4992:
X-Microsoft-Antispam-PRVS: <SG2PR03MB4992B8A7A29D2D80A744AD12C5849@SG2PR03MB4992.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yh19/tJD9kUoRKPp479hHZohocC+dpGSGLXUu1Ya2lXz9t2J7VytLSHq0xQ+9TlFx/hyNJL85lKrb7T74Jg2jzWlA8zlxIWRYOfhvmlfnM9niZO8SwAKC1HdYIiRVln3OaFDssXhm7OzWPXUBnf44VpDxcyTzY+ZmHIKae7eGrMxRhIyT8BkH1OlRwQkSa0Aizs/lINMJQpfeooSV5XTN+XL7vArV0HhqJKDDkXTmIFOrvEZTstNaQQs+1OaAeB+1ObU27l9+ChuddGKd1L0TvFo6Zhy4BSlniCAJbJpCLOnsV1N1JoWaEwjRy8h7JOHl+j0v9bvh9IDGh+ngBEUyS4kwJJgyuLz6AlZYM0lHtrhXB6t0yFaxwHBnrOwvv/PiFh/RVUWMFrcXlFzvUrKMjRBCUw+j+Pv/nkjNWvKRL0mr3hip/cuaZSlKw44mdeP1nwbBiLvgwrTURHWgtdZ2UrNByX+tpE3t60YA6kLCMFfbUnwMK9i5IHv7GiVAQYm2quFUoSe4DbzB8ClfgR5Wm1up7LZtH4Op7x34qe1qFHnGVt/ylA/kgxN6oI0zi0IaI5yN60gUBP2IdRTdemipgC94HLaGCLCNnnm+hXcSqSmpBoXWhoMMNhO4l2qJDT48PRERdzf5fN7iU4TC4T1NDxCCWrAQLdI2LwrXBGDmGnZMkTRZ4BF7Dxz33N4wTwNYWadxlPRyO7UZghjMwaMt0v+pUeE8xm5Szk6PsUVfjzspM7op7m7SszI4yoWBjndceywSXZvw6DPauqsfGy099UGlyNPtZt404vPmQXc8+Y=
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70206006)(36906005)(336012)(508600001)(70586007)(82960400001)(26005)(86362001)(31686004)(54906003)(316002)(31696002)(110136005)(16576012)(81166007)(356005)(4001150100001)(8676002)(8936002)(15650500001)(53546011)(83380400001)(426003)(82310400003)(47076005)(36860700001)(4326008)(16526019)(5660300002)(186003)(2906002)(36756003)(2616005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 18:36:13.3473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7513b3b-be67-465b-160f-08d998af7d49
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT063.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB4992
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks Mario,

Patch series looks good. One minor suggestion below.

Mark

On 2021-10-26 14:05, Mario Limonciello wrote:
> Allow other drivers to initialize relative to current active
> profile and react to platform profile changes.
> 
> Drivers wishing to utilize this should register for notification
> at module load and unregister when unloading.
> 
> Notifications will come in the from a notifier call.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c  | 48 ++++++++++++++++++++++++++++----
>   include/linux/platform_profile.h | 10 +++++++
>   2 files changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index d418462ab791..225247efa55f 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -21,6 +21,24 @@ static const char * const profile_names[] = {
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
> +static void platform_profile_call_notifier(unsigned long action, void *data)
> +{
> +	blocking_notifier_call_chain(&platform_profile_chain_head, action, data);
> +}
>   
>   static ssize_t platform_profile_choices_show(struct device *dev,
>   					struct device_attribute *attr,
> @@ -49,11 +67,8 @@ static ssize_t platform_profile_choices_show(struct device *dev,
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
> @@ -65,15 +80,28 @@ static ssize_t platform_profile_show(struct device *dev,
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
> @@ -130,9 +158,17 @@ static const struct attribute_group platform_profile_group = {
>   
>   void platform_profile_notify(void)
>   {
> +	enum platform_profile_option profile;
> +	int ret;
> +
>   	if (!cur_profile)
>   		return;
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +	ret = platform_profile_get(&profile);
> +	if (ret)
> +		return;

As no return value to function then simplify to:
	if (platform_profile_get(&profile))
		return;

> +	platform_profile_call_notifier(PLATFORM_PROFILE_CHANGED, &profile);
> +
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_notify);
>   
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index e5cbb6841f3a..05ba3403509a 100644
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
> @@ -37,5 +39,13 @@ struct platform_profile_handler {
>   int platform_profile_register(struct platform_profile_handler *pprof);
>   int platform_profile_remove(void);
>   void platform_profile_notify(void);
> +int platform_profile_get(enum platform_profile_option *profile);
> +
> +int platform_profile_register_notifier(struct notifier_block *nb);
> +int platform_profile_unregister_notifier(struct notifier_block *nb);
> +
> +enum platform_profile_notifier_actions {
> +	PLATFORM_PROFILE_CHANGED,
> +};
>   
>   #endif  /*_PLATFORM_PROFILE_H_*/
> 

