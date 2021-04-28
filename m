Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C654236D756
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhD1MbM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 08:31:12 -0400
Received: from mail1.perex.cz ([77.48.224.245]:57374 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232569AbhD1MbL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Apr 2021 08:31:11 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 0401CA003F;
        Wed, 28 Apr 2021 14:30:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 0401CA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1619613024; bh=YWEISeRM4UBax5S8lMOST4XvaXkUT5rzuNDl05TS+BY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YyK4ZOSn/yoZwRuXvj8Uq51Ln8y8L4PRvWUzvaFM0/ykRp8QjYxGcR7+MFO5ROee2
         DNbCsS5rQx078QHFIg4MbL3l/mfbHJwnrwFpzEBobUn7fWrvnzbwZRiLNce/2kMBFI
         nSmnXvqrDuTa3rEcq82O4/wRnXsuFEI1/+dBj7rM=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed, 28 Apr 2021 14:30:14 +0200 (CEST)
Subject: Re: [PATCH] drivers: pnp: proc.c: Handle errors while attaching
 devices
To:     Leon Romanovsky <leon@kernel.org>
Cc:     bkkarthik <bkkarthik@pesu.pes.edu>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        kernelnewbies@kernelnewbies.org
References: <20210424194301.jmsqpycvsm7izbk3@ubuntu> <YIZJwkux0ghJ8k9d@unreal>
 <20210426175031.w26ovnffjiow346h@burgerking>
 <59a5d631-6658-2034-06c4-467520b5b9f7@perex.cz> <YIlTY8p4kpkORPfl@unreal>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <19e8bd56-e24d-551e-9de2-57675541ee3f@perex.cz>
Date:   Wed, 28 Apr 2021 14:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YIlTY8p4kpkORPfl@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dne 28. 04. 21 v 14:21 Leon Romanovsky napsal(a):
> On Wed, Apr 28, 2021 at 02:04:49PM +0200, Jaroslav Kysela wrote:
>> Dne 26. 04. 21 v 19:50 bkkarthik napsal(a):
>>> On 21/04/26 08:04AM, Leon Romanovsky wrote:
>>>> On Sun, Apr 25, 2021 at 01:13:01AM +0530, Anupama K Patil wrote:
>>>>> isapnp_proc_init() does not look at the return value from
>>>>> isapnp_proc_attach_device(). Check for this return value in
>>>>> isapnp_proc_detach_device().
>>>>>
>>>>> Cleanup in isapnp_proc_detach_device and
>>>>> isapnp_proc_detach_bus() for cleanup.
>>>>>
>>>>> Changed sprintf() to the kernel-space function scnprintf() as it returns
>>>>> the actual number of bytes written.
>>>>>
>>>>> Removed unnecessary variables de, e of type 'struct proc_dir_entry' to
>>>>> save memory.
>>>>
>>>> What exactly do you fix for such an old code?
>>>
>>> I was not aware that this code is so old. This fix was made after checkpatch reported assignment inside an if-statement.
>>> Please ignore this patch if th change is not necessary as the code is probably not being used anywhere :)
>>>
>>> Maybe the code has to be marked as obsolete in the MAINTAINERS file to prevent patches being sent?
>>>
>>>>
>>>>>
>>>>> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>> Co-developed-by: B K Karthik <bkkarthik@pesu.pes.edu>
>>>>> Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
>>>>> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
>>>>> ---
>>>>>  drivers/pnp/isapnp/proc.c | 40 +++++++++++++++++++++++++++++----------
>>>>>  1 file changed, 30 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
>>>>> index 785a796430fa..46ebc24175b7 100644
>>>>> --- a/drivers/pnp/isapnp/proc.c
>>>>> +++ b/drivers/pnp/isapnp/proc.c
>>>>> @@ -54,34 +54,54 @@ static const struct proc_ops isapnp_proc_bus_proc_ops = {
>>>>>  	.proc_read	= isapnp_proc_bus_read,
>>>>>  };
>>>>>  
>>>>> +static int isapnp_proc_detach_device(struct pnp_dev *dev)
>>>>> +{
>>>>> +	proc_remove(dev->procent);
>>>>> +	dev->procent = NULL;
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int isapnp_proc_detach_bus(struct pnp_card *bus)
>>>>> +{
>>>>> +	proc_remove(bus->procdir);
>>>>> +	return 0;
>>>>> +}
>>>>
>>>> Please don't add one line functions that are called only once and have
>>>> return value that no one care about it.
>>>
>>> These were only intended for a clean-up job, the idea of this function came from how PCI handles procfs.
>>> Maybe those should be changed?
>>
>> Which code you refer? I see:
>>
>>        for_each_pci_dev(dev)
>>                 pci_proc_attach_device(dev);
> 
> He talks about isapnp_proc_detach_*() functions.

But only this patch introduced those functions. The pci_proc_init() code does
not call pci_proc_detach_*() functions and ignores the allocation errors, too.
I don't think that this cleanup code is required.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
