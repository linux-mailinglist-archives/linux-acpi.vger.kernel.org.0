Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA54130D11E
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 02:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhBCB4q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 20:56:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12009 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhBCB4q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 20:56:46 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DVl9d6GdbzjHrd;
        Wed,  3 Feb 2021 09:54:45 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Feb 2021 09:56:02 +0800
Subject: Re: [PATCH v2 3/5] ACPI: button: Clean up printing messages
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
 <1735040.lGk2htMl04@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <87d81a42-205d-ec4e-c308-f2a96f56f96c@huawei.com>
Date:   Wed, 3 Feb 2021 09:56:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1735040.lGk2htMl04@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/2/3 2:17, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() instance in button.c with an
> acpi_handle_debug() call, drop the _COMPONENT and ACPI_MODULE_NAME()
> definitions that are not used any more, drop the no longer needed
> ACPI_BUTTON_COMPONENT definition from the headers and update the
> documentation accordingly.
> 
> While at it, replace the direct printk() invocations with pr_info()
> (that changes the excessive log level for some of them too) and drop
> the unneeded PREFIX sybmbol definition from battery.c.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
