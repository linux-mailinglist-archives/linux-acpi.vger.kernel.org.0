Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF5B15186A
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2020 11:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgBDKFM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Feb 2020 05:05:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726924AbgBDKFM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Feb 2020 05:05:12 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6EDD5DBF4A90F3675139
        for <linux-acpi@vger.kernel.org>; Tue,  4 Feb 2020 18:05:09 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Feb 2020
 18:05:08 +0800
Subject: Re: Note about acpi_get_table_header
To:     Jean Delvare <jdelvare@suse.de>, <linux-acpi@vger.kernel.org>
CC:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20200204101707.30eaa5bb@endymion>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <150c32b4-d00c-5508-b16b-e7856e0cb09a@huawei.com>
Date:   Tue, 4 Feb 2020 18:05:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20200204101707.30eaa5bb@endymion>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/2/4 17:17, Jean Delvare wrote:
> Hello,
> 
> The description block before acpi_get_table_header() in
> drivers/acpi/acpica/tbxface.c includes the following comment:
> 
>  * NOTE:        Caller is responsible in unmapping the header with
>  *              acpi_os_unmap_memory

I'm confused as well when I was reading the code.

> 
> However, looking at the code, it seems that we are already calling
> acpi_os_unmap_memory() internally as appropriate, and we always return
> a copy of the header, not a pointer to it. So I see no reason why the
> caller would ever need to call acpi_os_unmap_memory(). As a matter of
> fact the only current caller of this function does NOT call
> acpi_os_unmap_memory() afterwards.
> 
> So I believe this note is wrong and should be removed?

I think so.

Thanks
Hanjun


