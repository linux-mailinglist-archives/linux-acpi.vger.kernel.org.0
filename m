Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5134175796
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 10:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCBJrD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 04:47:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37090 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727543AbgCBJrD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2020 04:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583142422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xMIqGq0tmEuuWD9+M+D+t1F1wORPhrl0ly3x5s1ae8=;
        b=IM3KurK0/14O3wepOxsjzaWy0sHHRTuCWqnFtFTuTAe5AUfGjhmO3gf2wdmHJGwMavDZdf
        Re4g4VOpm/DK9bTtBgDsTOKwQk3v9AzztzC0RZghvNjJ3TEdrQjspOCe4JD9dZgLWYtwGX
        4NcB5l1D6rSo8NmFSLNIeFRYTqdeXr0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-WWPUfFT7PEuI8aXUUvMcmw-1; Mon, 02 Mar 2020 04:47:00 -0500
X-MC-Unique: WWPUfFT7PEuI8aXUUvMcmw-1
Received: by mail-wr1-f71.google.com with SMTP id p11so5546243wrn.10
        for <linux-acpi@vger.kernel.org>; Mon, 02 Mar 2020 01:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7xMIqGq0tmEuuWD9+M+D+t1F1wORPhrl0ly3x5s1ae8=;
        b=PvJ0iIXN6gFqHDLT1g1MepwJ/JRwiRbFQ3J6HhaB4c3AxOGLmnuyQvxljRhxVB2xPz
         BL2Jcaw+1w+jM40MNNzsZTgFxg/3zTH87Jwmzapqx1iDij8pMB5VY+szX2XD3GyhPkWl
         LHygX7CKCnb4u7WJZxyskkEGfiLtrhQPkNMBLU/dTrrqF6m74hZwvC7ctypQqzBLjn3A
         jeI3uIYj8F6BlvlY05cziDWUgL/eGOMWO/hVh1Lt3thlEGzOyce++mdk7u5TWgDDEMXA
         X1+jYglTxNvmQyW5y33j9r6H2I7rat1UtrhmydEF3Bhpml70G98aS1C4vOccG9QyZuJH
         npmQ==
X-Gm-Message-State: ANhLgQ2HGPyL488aW5GR5vLeVn3/hxy6i1cGDdks1PnTHf0QnvjEYgMl
        FClONa34j1z1s5MvheaTigZQNsWf3u9zrly7r2NG0zpXScVOK5NDEgkRC3q4mzP3l9pO9T0UJUr
        L6c+56Z/QmS/IfbgcyuATdQ==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr2621203wmg.154.1583142419219;
        Mon, 02 Mar 2020 01:46:59 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuMX7qlu9du9wOCjDyVFC9IGEZy6ZjpRts0Jw9S7ERwzzs9hAEsQos336zobdeQ3jdKcMb1mA==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr2621188wmg.154.1583142418983;
        Mon, 02 Mar 2020 01:46:58 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id f16sm17965573wrx.25.2020.03.02.01.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 01:46:58 -0800 (PST)
Subject: Re: [PATCH resend 2/3] gpiolib: acpi: Rename honor_wakeup option to
 ignore_wake, add extra quirk
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20200225102753.8351-1-hdegoede@redhat.com>
 <20200225102753.8351-3-hdegoede@redhat.com>
 <20200225105437.GG10400@smile.fi.intel.com>
 <e0c39a89-bcac-4315-d764-5853eb77537d@redhat.com>
 <20200225123425.GK10400@smile.fi.intel.com>
 <20200225125700.GL10400@smile.fi.intel.com>
 <44cc5510-571c-21c4-1855-f3141f72eaa3@redhat.com>
 <ac38ee83-5edf-2ee0-8cec-a0b4367054a8@redhat.com>
 <20200302093038.GN1224808@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c187c90b-fe02-8dee-c37c-80d06feba566@redhat.com>
Date:   Mon, 2 Mar 2020 10:46:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302093038.GN1224808@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/2/20 10:30 AM, Andy Shevchenko wrote:
> On Sat, Feb 29, 2020 at 09:57:52PM +0100, Hans de Goede wrote:
>> On 2/28/20 12:22 PM, Hans de Goede wrote:
>>> On 2/25/20 1:57 PM, Andy Shevchenko wrote:
>>>> On Tue, Feb 25, 2020 at 02:34:25PM +0200, Andy Shevchenko wrote:
>>>>> On Tue, Feb 25, 2020 at 12:26:04PM +0100, Hans de Goede wrote:
>>>>
>>>>> Let's do it as a list of pairs, but in slightly different format (I see some
>>>>> potential to derive a generic parser, based on users described in
>>>>> Documentation/admin-guide/kernel-parameters.txt), i.e.
>>>>>
>>>>>      ignore_wake=pin:controller[,pin:controller[,...]]
>>>>
>>>> Another possible format
>>>>
>>>>      ignore_wake=controller@pin[;controller@pin[;...]]
>>>
>>> I like this one, the other one with the pin first feels wrong, the pin is
>>> part of the controller, not the other way around.
>>>
>>> I will rework the patch series to use the ignore_wake=controller@pin format.
>>
>> Just a quick note. I've changed the separator from ; to , for some reason
>> grub, at least as used in Fedora with Fedora's grub2 BLS (boot loader spec)
>> implementation does not like it when there is a ; in the kernel commandline.
> 
> Hmm... I think it would be harder then to have less possible formats in the
> command line. Do you really need right now several pins to be listed?

Yes, the existing quirk for the HP X2 10 with Cherry Trail SoC + TI PMIC,
which currently ignores wakeups on all pins needs to ignore wakeup on 2 pins.

> If it's about testing, perhaps we may do it with other means.

Well it is possible to pass the ; by putting quotes around it, so we could
go with the ; if you insist, but it really makes life harder for

>> I will also send an email about this to Fedora grub maintainer, but for
>> now it is easiest to just avoid the problem.
> 
> It's definitely bug in Grub due to existing kernel users with such format.
> It means Grub is unable to support kernel command line in full.

So I discussed this with the Fedora Grub maintainer, he says the problem
exists in upstream grub2 too, grub2 uses a shell like command syntax
both in its config file and in interactive mode, so if you do e.g.:

linux /boot/vmlinuz root=/dev/sda1 gpiolib_acpi.ignore_wake=INT33FF:01@0;INT0002:00@2

Then grub will see the INT0002:00@2 as a new separate commaond, this should
work:

linux /boot/vmlinuz root=/dev/sda1 gpiolib_acpi.ignore_wake="INT33FF:01@0;INT0002:00@2"

But the recommended way to edit the cmdline is by editing /etc/default/grub and
then re-running grub2-mkconfig, which clears the quotes unless we escape them
and since grub2-mkconfig is shell script inside shell script inside shell script
I don't even want to think about how many times I need to escape the quotes.

TL;DR: Using ; in kernel commandline options makes life much harder for users
and as such is something which we should try to avoid.

I appreciate that you are trying to come up with a format for the option which
looks like existing options and I like the @ use, but using ; really is not a
good example to follow and IMHO that (not a good example / idea) trumps keeping
the syntax identical to an existing option.

Regards,

Hans



