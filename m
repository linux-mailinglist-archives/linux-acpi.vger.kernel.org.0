Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C856A116847
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2019 09:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfLIIin (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Dec 2019 03:38:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:19761 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbfLIIin (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Dec 2019 03:38:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 00:38:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="237673418"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.115]) ([10.239.197.115])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2019 00:38:39 -0800
Subject: Re: [PATCH] ACPI/HMAT: Fix the parsing of Cache Associativity and
 Write Policy
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael.j.wysocki@intel.com, lenb@kernel.org,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191202070348.32148-1-tao3.xu@intel.com>
 <5cb15538-7097-1aa1-00a1-ce21c086c13b@intel.com>
 <20191209075517.GA691602@kroah.com>
From:   Tao Xu <tao3.xu@intel.com>
Message-ID: <ba82f0ed-16a9-8058-bc2c-560209750f0c@intel.com>
Date:   Mon, 9 Dec 2019 16:38:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191209075517.GA691602@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/9/2019 3:55 PM, Greg KH wrote:
> On Mon, Dec 09, 2019 at 03:43:21PM +0800, Tao Xu wrote:
>> Gentle ping :)
>>
>> On 12/2/2019 3:03 PM, Tao Xu wrote:
>>> In chapter 5.2.27.5, Table 5-147: Field "Cache Attributes" of
>>> ACPI 6.3 spec: 0 is "None", 1 is "Direct Mapped", 2 is "Complex Cache
>>> Indexing" for Cache Associativity; 0 is "None", 1 is "Write Back",
>>> 2 is "Write Through" for Write Policy.
>>>
>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>> ---
>>>    drivers/acpi/numa/hmat.c | 4 ++--
>>>    include/linux/node.h     | 4 ++--
>>>    2 files changed, 4 insertions(+), 4 deletions(-)
> 
> It was the middle of the merge window that just ended a few hours ago.
> Please give maintainers a chance to catch up...
> 

I understand, thanks
