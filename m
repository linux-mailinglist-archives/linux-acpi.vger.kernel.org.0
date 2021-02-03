Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B0930D155
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 03:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhBCCRB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 21:17:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12010 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhBCCQ7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 21:16:59 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DVlcy6tvKzjJ8L;
        Wed,  3 Feb 2021 10:14:58 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Feb 2021 10:16:16 +0800
Subject: Re: [PATCH v2 4/5] ACPI: video: Clean up printing messages
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
 <14420740.AtFQDP28HA@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <9fe936a0-0293-74af-2168-5530f7732d07@huawei.com>
Date:   Wed, 3 Feb 2021 10:16:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <14420740.AtFQDP28HA@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/2/3 2:18, Rafael J. Wysocki wrote:
[...]
> Also make one unrelated janitorial change to fix up white space and
> use ACPI_FAILURE() instead of negating ACPI_SUCCESS().

[...]

>   	status = acpi_evaluate_object(video->device->handle, "_DOD", NULL, &buffer);
>   	if (!ACPI_SUCCESS(status)) {

if (ACPI_FAILURE(status))

> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _DOD"));
> +		acpi_handle_info(video->device->handle,
> +				 "_DOD evaluation failed: %s\n",
> +				 acpi_format_exception(status));


Thanks
Hanjun
