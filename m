Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC62ABABF7
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Sep 2019 00:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfIVW3V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 22 Sep 2019 18:29:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41240 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfIVW3U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Sep 2019 18:29:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so11838011wrw.8;
        Sun, 22 Sep 2019 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9F/+/m59W3Dcig0n0hbTlhgv2402meDrVVrsrjXeJKw=;
        b=CzA6rUVQzQuRmiGW/YjIwozCjvGCOHLdNL5i5iEYLdhUc7lGGrFaSeJIXSBerLbFdM
         9iAaZr0TCMQCQ8nuUzho7il+2IhMIMJrS4D4oZzNGUjBgPx7U1D2Ds4ELZ9rhoL2f35W
         DnCkQ6TUDXbNP1vJIrMOeEYnr1mPsRTCcxmHmZXztOSEmi0Hf1fLT0XtKXrXblnXaXND
         h4UEKs1UeRL0eamP9ftN8JkT6+lJDy6hDXe9o7RY3AspaX09fH8RnOSaSbuSjItaaWeF
         /Cin3FasCqlFphbmO7kj4gZ6bbde+r2oE73bPXG5CBIDUvR0+Mj1VwcUE9y0ikcqfWdX
         7weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9F/+/m59W3Dcig0n0hbTlhgv2402meDrVVrsrjXeJKw=;
        b=GoU0j6P2afCTCEh5xXXrpA5ogtxjHRNk/Smi2Z6lPaOWw3BN0MI87J8JHNt5HICyJb
         slSGLKJdo6PatJONaSQ1iIb6AOL1ab5dHn1m7LNMRtaS5Z/pCZSib7S2Gc3y1YK2YtXn
         jENQtUYDffnKfGnEChEkScSGZQBDiIVWtwnvztsiOcJayo1h6ooshKnLw1/AomOadZTh
         N7ukG5jEoaYeFFun5iaPGrNnZ4Duj0XJa0qqkhZ1zPtrOxBALqSH2zKENORWclgCP8A7
         lrXYsAUJBkDRqF2ZVbk/qLP82ydv7uJSsXUL4G0tB/TUhxQAVxpy6VECuA1mOzLfEDK9
         uvkQ==
X-Gm-Message-State: APjAAAXBK2YHhUyoR6bix4mRnsQw4iEGtDKZM8cm8kzfedXmPq7MM35m
        2ONBSq8S2x2cF1Xo1Nru29IErXH+
X-Google-Smtp-Source: APXvYqz803890ifCAZk3zmRNKNz51yt4V6yZulA5FDFsi8VDPkNULWIzAdGIBSzq2/cUEe4aYmufiw==
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr7608305wru.12.1569191357572;
        Sun, 22 Sep 2019 15:29:17 -0700 (PDT)
Received: from [192.168.2.202] (pD9EA35A6.dip0.t-ipconnect.de. [217.234.53.166])
        by smtp.gmail.com with ESMTPSA id c10sm15870791wrf.58.2019.09.22.15.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 15:29:16 -0700 (PDT)
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
 <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <4c2cc8b7-8541-0912-3162-399777dc8dd2@gmail.com>
Date:   Mon, 23 Sep 2019 00:29:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

On 9/20/19 5:00 PM, Hans de Goede wrote:
> So as promised I've given this patch a try, unfortunately it breaks
> existing users of ACPI serdev device instantation.
> 
> After adding this patch "ls /sys/bus/serial/devices" is empty,
> where as before it gives:
> 
> [root@dhcp-45-50 ~]# ls -l /sys/bus/serial/devices/
> total 0
> lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0 -> ../../../devices/pci0000:00/8086228A:00/serial0
> lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0-0 -> ../../../devices/pci0000:00/8086228A:00/serial0/serial0-0
> 
> And since the serdev is missing bluetooth does not work.

Thanks to some testing by Hans, it turns out that the reason for this is
that acpi_walk_resources fails with AE_AML_INVALID_RESOURCE_TYPE for a
specific device. If anyone is interested, the _CRS of the device in
question is

     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
     {
         Name (NAM, Buffer (0x14)
         {
             "\\_SB.PCI0.SDHB.BRC1"
         })
         Name (SPB, Buffer (0x0C)
         {
             /* 0000 */  0x8E, 0x1D, 0x00, 0x01, 0x00, 0xC0, 0x02, 0x00,
             /* 0008 */  0x00, 0x01, 0x00, 0x00
         })
         Name (END, ResourceTemplate ()
         {
         })
         Concatenate (SPB, NAM, Local0)
         Concatenate (Local0, END, Local1)
         Return (Local1)
     }

To solve this, I propose ignoring errors that occur when evaluating the
_CRS method. Note that with the previously discussed change for v2,
where we will only look at the first device in _CRS, we should be able
to handle errors from the actual serdev device allocation separately
(and only ignore AML evaluation errors).

Further, I think it might also make sense to move the status and
already-enumerated checks out of acpi_serdev_register_device to before
looking at _CRS. On one hand, this might save us from unnecessarily
checking the _CRS on devices that are not present, but on the other
hand, moving the status check may cause more AML code execution, as we'd
be checking the status of every device, even if it doesn't have a _CRS.
Maybe a better solution would be something like: Check if device has
already been enumerated, then check for _CRS presence, then for
status/device-presence, and finally look at _CRS contents and
potentially allocate serdev client?

Regards,

Maximilian
