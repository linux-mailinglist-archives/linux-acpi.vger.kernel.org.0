Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2517A30D178
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 03:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhBCCYc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 21:24:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12011 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhBCCYb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 21:24:31 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DVlnf5Y6dzjHhK;
        Wed,  3 Feb 2021 10:22:30 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Feb 2021 10:23:48 +0800
Subject: Re: [PATCH v2 5/5] ACPI: thermal: Clean up printing messages
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
 <2382444.QC0lEobvty@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <ff12cdcc-721f-bd84-7cd6-70960368a656@huawei.com>
Date:   Wed, 3 Feb 2021 10:23:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2382444.QC0lEobvty@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/2/3 2:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() instances in thermal.c with
> acpi_handle_debug() calls and modify the ACPI_THERMAL_TRIPS_EXCEPTION()
> macro in there to use acpi_handle_info() internally,  which among other
> things causes the excessive log level of the messages printed by it to
> be more adequate.
> 
> Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
> used any more from thermal.c, drop the no longer needed
> ACPI_THERMAL_COMPONENT definition from the headers and update the
> documentation accordingly.
> 
> While at it, add a pr_fmt() definition to thermal.c, drop the PREFIX
> definition from there and replace some pr_warn() calls with pr_info()
> or acpi_handle_info() to reduce the excessive log level and (in the
> latter case) facilitate easier identification of the message source.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Changelog update

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
