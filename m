Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1613EF2A6
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2019 02:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfKEB17 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Nov 2019 20:27:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730410AbfKEB17 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Nov 2019 20:27:59 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3DB48F0BE0F5FE0625B8;
        Tue,  5 Nov 2019 09:27:57 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 5 Nov 2019
 09:27:50 +0800
Subject: Re: [PATCH] ACPI/PPTT: fixed some parameter type is not right
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Tian Tao <tiantao6@huawei.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <jonathan.cameron@huawei.com>
CC:     <linuxarm@huawei.com>
References: <1572916055-62477-1-git-send-email-tiantao6@huawei.com>
 <b4c4ba3a-b079-e276-f7bb-b91af7d95a7f@huawei.com>
Message-ID: <86652e9c-0c2a-96e6-cfc4-982431aad355@huawei.com>
Date:   Tue, 5 Nov 2019 09:27:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <b4c4ba3a-b079-e276-f7bb-b91af7d95a7f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/11/5 9:15, Hanjun Guo wrote:
> On 2019/11/5 9:07, Tian Tao wrote:
>> acpi_find_cache_level with level parameter as a signed integer,
>> is called by acpi_find_cache_node where the level parameter is unsigned.
>> This in turn calls acpi_find_cache_level with the level parameter is
>> signed.Make the type consistent as unsigned through all 3 calls.
> 
> I'm not against doing this, but it's not a big deal :)
> 
> Maybe send to upstream to see what's happening, Rafael is a nice guy.

Oh, already sent to upstream, my bad :(

