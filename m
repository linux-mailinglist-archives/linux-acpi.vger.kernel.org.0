Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81FD1CD388
	for <lists+linux-acpi@lfdr.de>; Mon, 11 May 2020 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEKIK6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 May 2020 04:10:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbgEKIK5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 May 2020 04:10:57 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 51297F5A4D869474EB47;
        Mon, 11 May 2020 16:10:56 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 11 May 2020
 16:10:53 +0800
Subject: Re: [ARM64 ACPI] different CPU L3 cache size reported by /sys/device/
 and dmidecode
To:     Aaron Chou <zhoubb.aaron@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>
References: <CAMpQs4JoyZcHQLahh4w8OaowQ1y3pkTCTYvDn+dkVNOQ4zDpHQ@mail.gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <b010dd7d-6045-6ad0-4484-72ce85fc7716@huawei.com>
Date:   Mon, 11 May 2020 16:10:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAMpQs4JoyZcHQLahh4w8OaowQ1y3pkTCTYvDn+dkVNOQ4zDpHQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Aaron,

On 2020/5/11 15:30, Aaron Chou wrote:
> In the system, I can get the L3 cache size from two or more ways.
> 
> Firstly, I can get it from the kernel interface, such as the `lscpu` command.
> Also, I can cat the file `/sys/devices/system/cpu/cpu3/cache/index3/size`.
> 
> The way above can give me the L3 cache size is 32768K.
> 
> Now if I use the `dmidecode -t cache` command, I get the L3 cache size
> is 24576K.
> 
> And the real size of the L3 cache is 24576K.
> 
> Why is it? who can explain it to me?

Seems the cache information from SMBIOS table and ACPI PPTT
table is inconsistent, which the SMBIOS table reports 24576K
for L3 cache, but 32768K in the PPTT table. You can verify
that by dumping the ACPI PPTT table and the SMBIOS table.

Thanks
Hanjun

