Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B9536D70D
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 14:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhD1MNm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 08:13:42 -0400
Received: from mail1.perex.cz ([77.48.224.245]:56502 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhD1MNl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Apr 2021 08:13:41 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Apr 2021 08:13:40 EDT
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id BEDDDA0040;
        Wed, 28 Apr 2021 14:12:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz BEDDDA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1619611974; bh=E7fI2iK4OLn302MecYw4bgPCutXkNrdZfiQ/p9Bs2EQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=MTel574VKtUTT7xuzz+YjBoFIh1Pfni2/5qKyHpKz2jLEpf263CrlNBtDJKvWeDMY
         VzC0wlz9l7vqdLDZVKipnMmQOQqQAq3weFWFRfhprPGgy0215oj7TpiEcVqCaGKBsO
         SS4f4FDGadFMigu+n4AJBIBFEVut8NIa5XeYpNxU=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed, 28 Apr 2021 14:12:44 +0200 (CEST)
Subject: Re: [PATCH] drivers: pnp: proc.c: Removed unnecessary varibles
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam <developer@arusty.dev>, bkkarthik@pesu.pes.edu,
        gregkh@linuxfoundation.org, kernelnewbies@kernelnewbies.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210422180322.7wlyg63kv3n2k6id@ubuntu>
 <ea09f455-a00f-a13d-29d8-e3f9790dba56@linuxfoundation.org>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <7526f0a3-b8bb-f751-50f9-4e71316178e0@perex.cz>
Date:   Wed, 28 Apr 2021 14:12:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ea09f455-a00f-a13d-29d8-e3f9790dba56@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dne 23. 04. 21 v 23:08 Shuah Khan napsal(a):
> On 4/22/21 12:03 PM, Anupama K Patil wrote:
>> de, e are two variables of the type 'struct proc_dir_entry'
>> which can be removed to save memory. This also fixes a coding style
>> issue reported by checkpatch where we are suggested to make assignment
>> outside the if statement.
>>
> 
> Sounds like a reasonable change.
> 
>> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
>> ---
>>   drivers/pnp/isapnp/proc.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
>> index 785a796430fa..1ae458c02656 100644
>> --- a/drivers/pnp/isapnp/proc.c
>> +++ b/drivers/pnp/isapnp/proc.c
>> @@ -57,21 +57,20 @@ static const struct proc_ops isapnp_proc_bus_proc_ops = {
>>   static int isapnp_proc_attach_device(struct pnp_dev *dev)
>>   {
>>   	struct pnp_card *bus = dev->card;
>> -	struct proc_dir_entry *de, *e;
>>   	char name[16];
>>   
>> -	if (!(de = bus->procdir)) {
>> +	if (!bus->procdir) {
>>   		sprintf(name, "%02x", bus->number);
> 
> It would make sense to change this to scnprintf()

The name is 16 bytes, so sprintf is safe here.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
