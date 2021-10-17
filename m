Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6416F430666
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Oct 2021 06:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhJQEJG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Oct 2021 00:09:06 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37642 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229536AbhJQEJG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 17 Oct 2021 00:09:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UsNvnO5_1634443613;
Received: from B-J4ZXMD6R-0327.local(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0UsNvnO5_1634443613)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 17 Oct 2021 12:06:55 +0800
Subject: Re: [PATCH] ACPI, APEI, EINJ: Relax platform response timeout to 1
 second.
To:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc:     "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
References: <20211015033817.16719-1-xueshuai@linux.alibaba.com>
 <4d492cef3640414d85ecfdb602ad6fa0@intel.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Message-ID: <869f0c92-0800-b24e-9de8-d8c9cb6972a7@linux.alibaba.com>
Date:   Sun, 17 Oct 2021 12:06:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4d492cef3640414d85ecfdb602ad6fa0@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Tony,

Thank you for your reply.

> Spinning for 1ms was maybe ok. Spinning for up to 1s seems like a bad idea.
>
> This code is executed inside a mutex ... so maybe it is safe to sleep instead of spin?

May the email Subject misled you. This code do NOT spin for 1 sec. The period of the
spinning depends on the SPIN_UNIT.

> -#define SPIN_UNIT		100			/* 100ns */
> -/* Firmware should respond within 1 milliseconds */
> -#define FIRMWARE_TIMEOUT	(1 * NSEC_PER_MSEC)
> +#define SPIN_UNIT		100			/* 100us */
> +/* Firmware should respond within 1 seconds */
> +#define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)

The period was 100 ns and changed to 100 us now. In my opinion, spinning for 100 ns or 100 us is OK :)

The timeout_default is set with FIRMWARE_TIMEOUT (1 sec) by default. If the platform do not
respond within timeout_default after multiple spins, the OSPM will print a warning message to
dmesg.

Regards,
Shuai


On 2021/10/15 PM11:37, Luck, Tony wrote:
>> We observe that the waiting time for DDR error injection is about 10 ms
>> and that for PCIe error injection is about 500 ms in Arm platfrom.
>>
>> In this patch, we relax the response timeout to 1 second and allow user to
>> pass the time out value as a argument.
> 
> Spinning for 1ms was maybe ok. Spinning for up to 1s seems like a bad idea.
> 
> This code is executed inside a mutex ... so maybe it is safe to sleep instead of spin?
> 
> -Tony
> 
