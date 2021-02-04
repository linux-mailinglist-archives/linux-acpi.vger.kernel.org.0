Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C475A30E95B
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 02:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhBDBTQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 20:19:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11676 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbhBDBTP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 20:19:15 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DWLHS38MGzlDhN;
        Thu,  4 Feb 2021 09:16:52 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 09:18:29 +0800
Subject: Re: [PATCH v3 2/5] ACPI: battery: Clean up printing messages
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
 <1961054.9MKZ8ejxOh@kreacher> <1731128.lCOlkKr4QW@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <056c6a20-4957-e112-6a8f-62fe39247e56@huawei.com>
Date:   Thu, 4 Feb 2021 09:18:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1731128.lCOlkKr4QW@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/2/4 2:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
> in battery.c with acpi_handle_debug() and acpi_handle_info() calls,
> respectively, which among other things causes the excessive log
> level of the messages previously printed via ACPI_EXCEPTION() to
> be increased.
> 
> Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
> used any more, drop the no longer needed ACPI_BATTERY_COMPONENT
> definition from the headers and update the documentation accordingly.
> 
> While at it, update the pr_fmt() definition and drop the unneeded
> PREFIX sybmbol definition from battery.c.  Also adapt the existing
> pr_info() calls to the new pr_fmt() definition.
> 
> Signed-off-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
