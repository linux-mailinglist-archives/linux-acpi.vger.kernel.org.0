Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7C51867BB
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Mar 2020 10:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgCPJVC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Mar 2020 05:21:02 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:26370 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730025AbgCPJVC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2020 05:21:02 -0400
X-IronPort-AV: E=Sophos;i="5.70,559,1574092800"; 
   d="scan'208";a="86396064"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Mar 2020 17:20:55 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 0E81D4CE6D88;
        Mon, 16 Mar 2020 17:10:51 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 16 Mar 2020 17:20:51 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: Re: [RFC PATCH 1/2] x86/acpi: Improve code readablity of early madt
 processing
To:     Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>
References: <20200123014144.19155-1-caoj.fnst@cn.fujitsu.com>
 <20200123014144.19155-2-caoj.fnst@cn.fujitsu.com>
 <20200224132152.GB29318@zn.tnic>
 <8b19ed2f-2470-c522-cc47-f615c615be20@cn.fujitsu.com>
Message-ID: <553ef3e0-0270-5631-b7fe-7fa1d48a5dc1@cn.fujitsu.com>
Date:   Mon, 16 Mar 2020 17:20:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8b19ed2f-2470-c522-cc47-f615c615be20@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 0E81D4CE6D88.A0A6B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello BP,

  Does the explanation make sense to you?
  BTW, also test it on i386, boots fine.

-- 
Sincerely,
Cao jin

On 2/25/20 3:02 PM, Cao jin wrote:
> On 2/24/20 9:21 PM, Borislav Petkov wrote:
>> On Thu, Jan 23, 2020 at 09:41:43AM +0800, Cao jin wrote:
>>> Current processing logic is confusing.
>>>
>>> Return value of early_acpi_parse_madt_lapic_addr_ovr() indicates error(< 0),
>>> parsed entry number(>= 0).
>>
>> You mean, the count of table entries parsed successfully?
> 
> Yes, 0 for no override sub-table.
> 
>>
>>> So, it makes no sense to initialize acpi_lapic & smp_found_config
>>> seeing no override entry, instead, initialize them seeing MADT.
>>
>> Err, that logical conclusion is not really clear to me - pls try
>> again with more detail. I kinda see what you mean by looking at
>> acpi_process_madt() but before I commit a change like that, I better
>> have the warm and fuzzy feeling that it is correct and properly
>> explained in its commit message.
>>
> 
> My understanding of early_acpi_process_madt(): mainly for getting APIC
> register base address(acpi_lapic_addr) from MADT, then process it via
> register_lapic_address().  acpi_lapic_addr could be got from one of
> following 2 places:
> 
>   1. MADT header (32-bit address, always exist)
>   2. MADT sub-table: Local APIC Address Override (64-bit address,
>      optional, high priority and use it if present)
> 
> So the making-sense logic to me goes like:
> 
>   1. get (32-bit) acpi_lapic_addr from MADT header.
>   2. check if there is MADT override structure & get 64-bit
>      acpi_lapic_addr if present.
>   3. register_lapic_address(acpi_lapic_addr);
> 
> Then, it looks weird to me putting register_lapic_address() into
> early_acpi_parse_madt_lapic_addr_ovr(), the result is not wrong, but the
> code logic is hard for newbie. (these 2 functions both does more than
> its name tells, register_lapic_address() also get boot cpu APIC ID &
> version.)
> 
> Variable acpi_lapic and its counterpart smp_found_config from MPS
> indicate whether it is SMP system, right? The following code:
> 
> 
> 	error = early_acpi_parse_madt_lapic_addr_ovr();
> 	if (!error) {
> 		acpi_lapic = 1;
> 		smp_found_config = 1;
> 	}
> 
> means setting them when there is no override sub-table, so why can't
> moving the setting operation out? Another issue: if there *is* override
> sub-table, don't set those two?
> 




