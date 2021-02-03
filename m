Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8335530D0F6
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 02:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhBCBpc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 20:45:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12070 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhBCBpb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 20:45:31 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DVkw61qYpzMTjG;
        Wed,  3 Feb 2021 09:43:02 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Feb 2021 09:44:38 +0800
Subject: Re: [PATCH v2 2/5] ACPI: battery: Clean up printing messages
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Joe Perches" <joe@perches.com>
References: <2367702.B5bJTmGzJm@kreacher> <1991501.dpTHplkurC@kreacher>
 <3131826.iYOCbf7Byd@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <48dbbf06-a897-5c1e-c42a-f6d9b4df16b1@huawei.com>
Date:   Wed, 3 Feb 2021 09:44:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3131826.iYOCbf7Byd@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/2/3 2:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
> in battery.c with acpi_handle_debug() and acpi_handle_info() calls,
> respectively, which among other things causes the excessive log
> level of the messages previously printed via ACPI_EXCEPTION() to
> be more adequate.
> 
> Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
> used any more, drop the no longer needed ACPI_BATTERY_COMPONENT
> definition from the headers and update the documentation accordingly.
> 
> While at it, update the pr_fmt() definition and drop the unneeded
> PREFIX sybmbol definition from battery.c.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Changelog update
> 
> ---
>   Documentation/firmware-guide/acpi/debug.rst |    1
>   drivers/acpi/battery.c                      |   29 ++++++++++++++--------------
>   drivers/acpi/sysfs.c                        |    1
>   include/acpi/acpi_drivers.h                 |    1
>   4 files changed, 15 insertions(+), 17 deletions(-)
> 
> Index: linux-pm/drivers/acpi/battery.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/battery.c
> +++ linux-pm/drivers/acpi/battery.c
> @@ -8,7 +8,7 @@
>    *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
>    */
>   
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#define pr_fmt(fmt) "ACPI: battery: " fmt
>   
[...]
>   
> -	pr_info(PREFIX "%s Slot [%s] (battery %s)\n",
> +	pr_info("%s Slot [%s] (battery %s)\n",
>   		ACPI_BATTERY_DEVICE_NAME, acpi_device_bid(device),
>   		device->status.battery_present ? "present" : "absent");

Will print:
ACPI: battery: Battery Slot ...

How about:
ACPI: battery: Slot ...

>   
> @@ -1282,7 +1283,7 @@ static void __init acpi_battery_init_asy
>   	if (battery_check_pmic) {
>   		for (i = 0; i < ARRAY_SIZE(acpi_battery_blacklist); i++)
>   			if (acpi_dev_present(acpi_battery_blacklist[i], "1", -1)) {
> -				pr_info(PREFIX ACPI_BATTERY_DEVICE_NAME
> +				pr_info(ACPI_BATTERY_DEVICE_NAME
>   					": found native %s PMIC, not loading\n",
>   					acpi_battery_blacklist[i]);

Will print:
ACPI: battery: Battery: found native...

will be better for
ACPI: battery: found native

So I think we can remove ACPI_BATTERY_DEVICE_NAME in pr_info()

Thanks
Hanjun
