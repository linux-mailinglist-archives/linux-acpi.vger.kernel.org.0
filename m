Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC730D0D7
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 02:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhBCBcB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 20:32:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12008 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhBCBbx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 20:31:53 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DVkcx2bXJzjJ7V;
        Wed,  3 Feb 2021 09:29:53 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Feb 2021 09:31:09 +0800
Subject: Re: [PATCH v2 1/5] ACPI: AC: Clean up printing messages
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
 <5584914.5WsbVgmIkf@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <2b40c1c6-85f8-92dd-7f97-819a6366a333@huawei.com>
Date:   Wed, 3 Feb 2021 09:31:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5584914.5WsbVgmIkf@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 2021/2/3 2:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
> in ac.c with acpi_handle_debug() and acpi_handle_info() calls,
> respectively, which among other things causes the excessive log
> level of the messages previously printed via ACPI_EXCEPTION() to
> be more adequate.
> 
> Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
> used any more, drop the no longer needed ACPI_AC_COMPONENT definition
> from the headers and update the documentation accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Changelog update
> 
> ---
>   Documentation/firmware-guide/acpi/debug.rst |    1 -
>   drivers/acpi/ac.c                           |   12 +++++-------
>   drivers/acpi/sysfs.c                        |    1 -
>   include/acpi/acpi_drivers.h                 |    1 -
>   4 files changed, 5 insertions(+), 10 deletions(-)
> 
> Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
> ===================================================================
> --- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
> +++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
> @@ -52,7 +52,6 @@ shows the supported mask values, current
>       ACPI_CA_DISASSEMBLER            0x00000800
>       ACPI_COMPILER                   0x00001000
>       ACPI_TOOLS                      0x00002000
> -    ACPI_AC_COMPONENT               0x00020000
>       ACPI_BATTERY_COMPONENT          0x00040000
>       ACPI_BUTTON_COMPONENT           0x00080000
>       ACPI_SBS_COMPONENT              0x00100000
> Index: linux-pm/drivers/acpi/ac.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ac.c
> +++ linux-pm/drivers/acpi/ac.c

In this file, printk() is still using, how about convert them
all into pr_*? I think patch on top your or update this patch
are both OK.

Thanks
Hanjun
