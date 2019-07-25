Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907C275075
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2019 16:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390987AbfGYN7n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 09:59:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391013AbfGYN7m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jul 2019 09:59:42 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE0BFC6FEE3286AEA0B4;
        Thu, 25 Jul 2019 21:59:32 +0800 (CST)
Received: from [127.0.0.1] (10.74.184.86) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Jul 2019
 21:59:32 +0800
Subject: Re: [PATCH 1/1] efi: cper: print AER info of PCIe fatal error
To:     James Morse <james.morse@arm.com>
References: <1562898017-27166-1-git-send-email-tanxiaofei@huawei.com>
 <e596aec8-1239-0a46-39cf-e682fada9945@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
        <ying.huang@intel.com>, <ross.lagerwall@citrix.com>,
        <ard.biesheuvel@linaro.org>, <lance.ortiz@hp.com>
From:   tanxiaofei <tanxiaofei@huawei.com>
Message-ID: <5D39B5C1.6040707@huawei.com>
Date:   Thu, 25 Jul 2019 21:59:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <e596aec8-1239-0a46-39cf-e682fada9945@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.184.86]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi James,
Thanks for the review.

On 2019/7/25 20:44, James Morse wrote:
> Hi,
> 
> On 12/07/2019 03:20, Xiaofei Tan wrote:
>> AER info of PCIe fatal error is not printed in the current driver.
>> Because APEI driver will panic directly for fatal error, and can't
>> run to the place of printing AER info.
>>
>> An example log is as following:
>> [ 3157.655028] {763}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 11
>> [ 3157.663610] {763}[Hardware Error]: event severity: fatal
>> [ 3157.663612] {763}[Hardware Error]:  Error 0, type: fatal
>> [ 3157.663614] {763}[Hardware Error]:   section_type: PCIe error
>> [ 3157.680328] {763}[Hardware Error]:   port_type: 0, PCIe end point
>> [ 3157.680329] {763}[Hardware Error]:   version: 4.0
>> [ 3157.680332] {763}[Hardware Error]:   command: 0x0000, status: 0x0010
>> [ 3157.698757] {763}[Hardware Error]:   device_id: 0000:82:00.0
>> [ 3157.698758] {763}[Hardware Error]:   slot: 0
>> [ 3157.698759] {763}[Hardware Error]:   secondary_bus: 0x00
>> [ 3157.698760] {763}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x10fb
>> [ 3157.698761] {763}[Hardware Error]:   class_code: 000002
>> [ 3157.698825] Kernel panic - not syncing: Fatal hardware error!
>>
>> This issue was imported by the patch, '37448adfc7ce ("aerdrv: Move
>> cper_print_aer() call out of interrupt context")'. To fix this issue,
>> this patch adds print of AER info in cper_print_pcie() for fatal error.
>>
>> Here is the example log after this patch applied:
>> [ 7032.893566] {24}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 10
>> [ 7032.901965] {24}[Hardware Error]: event severity: fatal
>> [ 7032.907166] {24}[Hardware Error]:  Error 0, type: fatal
>> [ 7032.912366] {24}[Hardware Error]:   section_type: PCIe error
>> [ 7032.917998] {24}[Hardware Error]:   port_type: 0, PCIe end point
>> [ 7032.923974] {24}[Hardware Error]:   version: 4.0
>> [ 7032.928569] {24}[Hardware Error]:   command: 0x0546, status: 0x4010
>> [ 7032.934806] {24}[Hardware Error]:   device_id: 0000:01:00.0
>> [ 7032.940352] {24}[Hardware Error]:   slot: 0
>> [ 7032.944514] {24}[Hardware Error]:   secondary_bus: 0x00
>> [ 7032.949714] {24}[Hardware Error]:   vendor_id: 0x15b3, device_id: 0x1019
>> [ 7032.956381] {24}[Hardware Error]:   class_code: 000002
>> [ 7032.961495] {24}[Hardware Error]:   aer_uncor_status: 0x00040000, aer_uncor_mask: 0x00000000
>> [ 7032.969891] {24}[Hardware Error]:   aer_uncor_severity: 0x00062010
>> [ 7032.976042] {24}[Hardware Error]:   TLP Header: 000000c0 01010000 00000001 00000000
>> [ 7032.983663] Kernel panic - not syncing: Fatal hardware error!
> 
>> Fixes: 37448adfc7ce ("aerdrv: Move cper_print_aer() call out of
>> interrupt context")
> 
> (Please put this all on one line)
> 

OK.

>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>> index 8fa977c..bf8600d 100644
>> --- a/drivers/firmware/efi/cper.c
>> +++ b/drivers/firmware/efi/cper.c
>> @@ -390,6 +390,19 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
>>  		printk(
>>  	"%s""bridge: secondary_status: 0x%04x, control: 0x%04x\n",
>>  	pfx, pcie->bridge.secondary_status, pcie->bridge.control);
> 
> It may be worth a comment explaining why we only do this for fatal errors. Something like:
> | /* Fatal errors call __ghes_panic() before the AER handler gets to print this */
> 

OK. I will add this comment.

> 
>> +	if (pcie->validation_bits & CPER_PCIE_VALID_AER_INFO &&
>> +	    gdata->error_severity & CPER_SEV_FATAL) {
>> +		struct aer_capability_regs *aer;
>> +
>> +		aer = (struct aer_capability_regs *)pcie->aer_info;
>> +		printk("%saer_uncor_status: 0x%08x, aer_uncor_mask: 0x%08x\n",
> 
> The convention in the rest of the file is for the prefix format string to be separate. i.e:
> | "%s""aer_uncor_status: ..."
> 
> Could it be the same for consistency?
>

That way is not accepted by checkpatch.pl anymore, and was not used in some new commit.
Such as :
printk("%ssection_type: ARM processor error\n", newpfx);
and
printk("%ssection_type: IA32/X64 processor error\n", newpfx);

>> +		       pfx, aer->uncor_status, aer->uncor_mask);
>> +		printk("%saer_uncor_severity: 0x%08x\n",
>> +		       pfx, aer->uncor_severity);
>> +		printk("%sTLP Header: %08x %08x %08x %08x\n", pfx,
>> +		       aer->header_log.dw0, aer->header_log.dw1,
>> +		       aer->header_log.dw2, aer->header_log.dw3);
>> +	}
>>  }
> 
> Regardless,
> Reviewed-by; James Morse <james.morse@arm.com>
> 
> 
> Thanks,
> 
> James
> 
> .
> 

-- 
 thanks
tanxiaofei

