Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2556E1C5766
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgEENuU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 May 2020 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728512AbgEENuU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2020 09:50:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AAAC061A0F;
        Tue,  5 May 2020 06:50:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so2396389wmc.0;
        Tue, 05 May 2020 06:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aZ0Qk3lr7qtEXdcvAALeI6LX4V+/Z6o4WYTfNR+yDHc=;
        b=js1IjRE218jK/P3YrCihXZZGDDxGRorwxOaxRkiApPP2ZO+K0c50XZAG3/q81hSy60
         tIdG7xSc2ujEDXRnoS7wy3yAPbAQdMNDiK1OAjAIX84JRb1qSnHWM/NbgFdkJHt7jtxr
         xctZBXXuK43htEVsipypnZbKMDdVguUC+Rzzz+CTYNkt8jOH3xnSkth7lmsn3SqlYQ4/
         +KliZFePE+e31YW5UByMzFJ6UBiK1oUzWJ/I2c4kjDnmdUAkToXIhz4lb57iHGC8dn5Y
         G7SxYdLiJ6abLftTR/v8wPndwfv8Tdc7YIK0xJ+YEZXr9z3AeSsBXXKXH39kk0z8p63i
         WTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZ0Qk3lr7qtEXdcvAALeI6LX4V+/Z6o4WYTfNR+yDHc=;
        b=Fz9aJ3DNxnq+YdqSIlsDPDXzAl/QCJ5pDwwyBMcF2pieJnGUn/XQzgAuyNZkYy+QSp
         cA6AUtTmp9MOBTfI2pClYtMT/Fh1tvT0M3zNxoJ6M4j6nn+TR+NTYBiNqkb7vA/Yqmi4
         hEc6O4MV2HXoyuK+651nBmzNhAsEj+FQaBr13ogKIjSYHfMmmdVumSU7zwhyorBLExcB
         f42nmc+Pbmoh0iMVwZKH3z5y8xZyr54BBlK5svBLjwlizMtQft0NviFTbLT184NqYf0J
         q9PnirXH11L1QyOs5BBmvteLbvH8cura3QhPb/eyWwFC742fCG8NtBzpdq9MhrDvuOR2
         Hxtg==
X-Gm-Message-State: AGi0PuYsfOhInaq8nK330BuNHtGrczZV2rvR6QNSyhyLgez/QYDUVFC7
        jBwKNfu6UzQeivful2ziiJfiB9lY
X-Google-Smtp-Source: APiQypKAT3yV8prJyFdi1XTuypc5++ACcuzgdJgmdbjZjkart5eR37gxpUCMWy0oQv9ZuJTJEN3vnQ==
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr3561075wma.26.1588686617456;
        Tue, 05 May 2020 06:50:17 -0700 (PDT)
Received: from [192.168.2.202] (pD9E5A5BE.dip0.t-ipconnect.de. [217.229.165.190])
        by smtp.gmail.com with ESMTPSA id p7sm3532619wrf.31.2020.05.05.06.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 06:50:16 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: 5.6 regression caused by "ACPICA: Dispatcher: always generate
 buffer objects for ASL create_field() operator"
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Mattia Dongili <malattia@linux.it>,
        William Bader <williambader@hotmail.com>,
        Dominik Mierzejewski <dominik@greysector.net>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <49f20a91-9362-6249-d413-1461258d56a9@redhat.com>
Message-ID: <11795a75-70de-5fcc-878f-14a0381947ea@gmail.com>
Date:   Tue, 5 May 2020 15:50:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <49f20a91-9362-6249-d413-1461258d56a9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/5/20 2:55 PM, Hans de Goede wrote:
> Hi All,
> 
> Commit 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
> objects for ASL create_field() operator") has dropped the
> automatic conversion of small buffers into integers.
> 
> But some drivers relied on this automatic conversion, these
> drivers have checks like this:
> 
>          if (object->type != ACPI_TYPE_INTEGER) {
>                  pr_warn("Invalid acpi_object: expected 0x%x got 0x%x\n",
>                                  ACPI_TYPE_INTEGER, object->type);
>                  kfree(object);
>                  return -EINVAL;
>          }
> 
> This specific bit comes from the sony-laptop (platform/x86) code,
> the ACPICA change has broken this code, causing systems using this
> driver to hang on resume from suspend.
> 
> We have multiple bug-reports open for this already:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=207491
> https://bugzilla.redhat.com/show_bug.cgi?id=1829096
> https://bugzilla.redhat.com/show_bug.cgi?id=1830150
> 
> Mattia Dongili, the sony-laptop driver has already submitted
> a fix for this upstream, adjusting the sony-laptop driver
> to deal with the returned object type now being a BUFFER.
> 
> The goal of this email is to:
> 
> 1. Make everyone involved aware of this breakage as we
> may see similar breakage elsewhere.
> 
> 2. Discuss if we should maybe revert the ACPICA change.
> 
> If you are reading this then 1. has been accomplished :)
> 
> Which leaves us with 2. I'm tending towards keeping the
> change, since it seems the right thing to do and dealing
> with the fallout. But since there is fallout we should
> also at least consider reverting the ACPICA change.
> 
> So ACPI maintainers what is you take on this ?
> 
> Regards,
> 
> Hans

Hi,

I'd like to advise against reverting the commit. Quite honestly, I don't
think reverting the commit is a good idea. This will break things for
devices that assume Microsoft-like AML interpreter behavior _inside_ the
DSDT. Such as the MS Surface devices for example, which, as stated in the
commit message, depend on the type being Buffer via a check on
ObjectType(...). There is no fix for those devices other than a)
accepting MS behavior in ACPICA, b) introducing a quirk in ACPICA which
switches between behaviors on a device basis, or c) patching the DSDT of
those devices specifically for Linux.

I'd also argue that since this is MS behavior, this is the behavior that
almost all consumer electronics devices with ACPI will expect. Case in
point, the DSDT of one of the affected Sony laptops, which contains the
following code:

         CreateField (SNBF, Zero, 0x20, SNBD)
         CreateWordField (SNBF, 0x02, CPW0)
         CreateWordField (SNBF, 0x04, CPW1)
         CreateWordField (SNBF, Zero, RCW0)
         CreateWordField (SNBF, 0x02, RCW1)

They explicitly create a Buffer field of 32 bits via CreateField and not
a 32 bit Integer field via CreateDWordField. I'd argue that if they
wanted this field to be an Integer, CreateDWordField would be the
straight-forward approach.

Unfortunately, I also don't see a way to identify all affected calls to
ACPI functions automatically or easily, as this requires to look at the
DSDTs and the code behind those calls. If you have DSDTs, here's a way
to identify if that particular DSDT/driver combo is affected:

If a call to an ACPI function expects an Integer and the ACPI function
returns a field created with CreateField(...) and the field is smaller
than 64 bits (on 64bit machines), then this call is affected.

The only semi-reasonable way, as far as I can see, to identify this on a
broad scale is to get this information out to the respective maintainers
of drivers with apci_evaluate_{integer,object,dsm,..?} calls and ask them
to check those calls against DSDTs. Also maybe help them by introducing a
function which does Buffer-to-Integer conversion.

Regards,
Maximilian


