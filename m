Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19C35F7797
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Oct 2022 13:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJGLnB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Oct 2022 07:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJGLnA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Oct 2022 07:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8D5C5890
        for <linux-acpi@vger.kernel.org>; Fri,  7 Oct 2022 04:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665142977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rNRWMsdlB09G8q22G7H4np9bkBmZxE1tcc1yXWNcoy4=;
        b=WEdGwbqlFIgzqVTBeu2Si6ACLrgSfU1T+iBcGjMqIKyeJR44N+wt9i5/o4u2VPQXLQvptn
        GQVZMQxOg4jLSIsxnIR7rziSfiUl6HPTalt+Ly5Z3lAlYrWefbIlr81UMOo+FegOe4N55k
        VWNnEdrpCSsUH+FjDgH7Xlhb9wxBVSQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-EAT86ywcOhWSMyggc3mOag-1; Fri, 07 Oct 2022 07:42:56 -0400
X-MC-Unique: EAT86ywcOhWSMyggc3mOag-1
Received: by mail-ej1-f71.google.com with SMTP id nb9-20020a1709071c8900b0078d858f15c1so528779ejc.1
        for <linux-acpi@vger.kernel.org>; Fri, 07 Oct 2022 04:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNRWMsdlB09G8q22G7H4np9bkBmZxE1tcc1yXWNcoy4=;
        b=2FW2YsR+dZPeIGkz6T4bPcheeJKDw20Le3G/NVcNVGHuXyggJF3qPffsoh5fBwTJzC
         bxxFvHFJHbLK5MHBImHJ22aBT8YofXSxSbd+gbwE5Wz3TG1Ps3n6A5I0obipe5O2Th9G
         Lo5JtagsKp5bX0tuad2+4veHuxrAyyLPtc8m5cCIkSc3IkiXcJdyHxbvTXZmY2hED95L
         zIawBKFLQvpcCj6pv7RJbiQ48CfPNb/U74gj4xGiFrEY6g8EdAJjXH6N1hMr47HSqLty
         KUSYGNG+sHaK/QEDDawKg8K67uN0JCbZ0pQtSegmDdc+1acDIkudJL6GMw+n4/7oF9fv
         JwKw==
X-Gm-Message-State: ACrzQf06jcP2R0Zvl3yaFustSKSTzMEmTIt/UWQixZXFWQHSSu7MrTxh
        UIMTrvQT1RtNEae7ilM1K2/b6R1Z+zVFb3SayjKloi7EKwh9GP4V8QqZdjdrBTUEdZ/9uL0U8vj
        C4He5Bq4FgmS9LZBE2je/OQ==
X-Received: by 2002:a17:906:c153:b0:787:abca:d9fa with SMTP id dp19-20020a170906c15300b00787abcad9famr3698337ejc.768.1665142974979;
        Fri, 07 Oct 2022 04:42:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7fEwNSYxdtihyEDwJ9JGET0ibR+FpRUxE2IoZ8/beXZhoD4Z29oXWEspdUf6G0dHqdiKIcSQ==
X-Received: by 2002:a17:906:c153:b0:787:abca:d9fa with SMTP id dp19-20020a170906c15300b00787abcad9famr3698320ejc.768.1665142974656;
        Fri, 07 Oct 2022 04:42:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7c6c2000000b004587f9d3ce8sm1294023eds.56.2022.10.07.04.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 04:42:54 -0700 (PDT)
Message-ID: <5179a1cb-6ff4-2e4c-b1cb-cec53c2f41aa@redhat.com>
Date:   Fri, 7 Oct 2022 13:42:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC v2 0/2] Quickstart buttons driver and Toshiba Z830
Content-Language: en-US, nl
To:     Arvid Norlander <lkml@vorpal.se>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
References: <20220922182424.934340-1-lkml@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220922182424.934340-1-lkml@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/22/22 20:24, Arvid Norlander wrote:
> Hi,
> 
> This is version 2 of this patch series, incorporating the various feedback
> on the first version. However, there are some remaining issues that makes
> me keep this marked RFC:
> 1. I tried to get rid of the memory allocation in quickstart_acpi_ghid (as
>    suggested by Barnabás Pőcze), but I could not get that working. I'm not
>    sure why I did wrong, but I kept getting ACPI errors indicating a buffer
>    overflow. I would appreciate knowing how to allocate the buffer on stack
>    properly in this case. The memory leak is at least fixed on the error
>    path though.

It can be quite hard to predict how large an object ACPI methods will
return. Even if you get it right for your laptop model it may fail
on other models. So using ACPI_ALLOCATE_BUFFER here (which I assume this
is about) is absolutely fine, I would even say it is a good idea :)

> 2. The open question mentioned in the original cover letter remains
>    undiscussed. I would still like some feedback on those points as well.
> 
> The original cover letter follows:
> 
> In the following patch series I implement support for three buttons on
> the Toshiba Satellite/Portege Z830 (same laptop, different markets).
> 
> These buttons work via a PNP0C32 ACPI device. Hans de Goede pointed out
> an old and flawed attempt to implement this as a staging driver.
> 
> With that staging driver as a starting point I have now implemented proper
> support. I believe I have fixed the flaws with the original staging driver.
> As it required almost a complete rewrite I have decided to present it as a
> new driver instead of starting with a revert commit to restore the old
> driver and then apply fixes on top.
> 
> The specification for PNP0C32 devices exists as a Microsoft specification.
> It was previously available on their web site, but seems to have been taken
> down during the last month. I had a local copy and I have uploaded it to
> archive.org. It is available here for anyone interested (including a
> conversion of the docx to PDF):
> 
> https://archive.org/details/microsoft-acpi-dirapplaunch
> 
> The old emails about support for these buttons can be found at:
> https://marc.info/?l=linux-acpi&m=120550727131007
> https://lkml.org/lkml/2010/5/28/327
> 
> Table of contents:
> 1. Summary of standard
> 2. Issues
> 2.1. Issue 1: Wake support
> 2.2. Issue 2: Button identification
> 2.3. Issue 3: GHID: 64-bit values?
> 2.4. Issue 4: MAINTAINERS?
> 3. User space API
> 3.1. Input device
> 3.2. Sysfs file: button_id (Read only)
> 3.3. Sysfs file: wakeup_cause (Read write)
> 4. HCI_HOTKEY_EVENT register (toshiba_acpi)
> 
> 
> 1. Summary of standard
> ======================
> 
> Here is a brief high level summary of the standard for PNP0C32. See
> https://archive.org/details/microsoft-acpi-dirapplaunch for the full
> standard.
> 
> PNP0C32 devices are "Direct Application Launch" buttons. The idea is that
> they should work while the laptop is in various sleep modes (or even off).
> The Z830 does not support waking from any sleep mode using these buttons,
> it only supports them while it is awake.
> 
> Each PNP0C32 device represents a single button. Their meaning is completely
> vendor defined. On Windows you can either:
> * Make them launch an application when pressed (defined in the registry)
> * Or an application can subscribe to specific Window messages to get
>   notified when they are pressed (this is how they are used by the Toshiba
>   software).
> 
> 2. Issues
> =========
> Unfortunately there are a few issues where I would like some input.
> 
> On top of that I'm sure there are lots of issues as I'm fairly new to
> kernel programming!
> 
> 2.1. Issue 1: Wake support
> --------------------------
> This is untested as the Toshiba Z830 that I have simply does not support
> this part in the firmware. I left the old behaviour in and only adapted it
> slightly.
> 
> The driver adds a sysfs file "wakeup_cause" to each PNP0C32 device
> (inspired by old approach) that would read "true" after causing the wakeup.
> It would be up to user space query this and reset the value to false.
> This is basically what the old staging driver did, only moved from an
> (un-needed) platform driver to each ACPI driver.
> 
> As I cannot test it (the Z830 does not support the wakeup part of the spec)
> I'm more inclined to just drop this feature, especially if the current
> approach is suboptimal. It would then be up to someone else to implement
> this in the future.

Hmm, since you have already written / ported the wakeup_cause code
I would prefer to retain it.

You could add a module_param (boolean, default off) to enable this using
a is_visible callback which returns 0 as mode when the boolean is not set
(thus hiding the wakeup_cause sysfs attribute).
Then people can easily test this on other models and if it turns out to
be useful (and works as is) then we can drop the parameter and just
always enable this.

That is not the prettiest of solutions, but this way we atleast preserve
the work/functionality from the staging driver.


> 2.2. Issue 2: Button identification
> -----------------------------------
> There is NO generic way to know what the buttons are "supposed" to do.
> Each button has a vendor defined ID (an 8-, 16- or 32-bit unsigned integer).
> This ID can be read with the GHID ACPI method.
> 
> As such I map all these to KEY_UNKNOWN. Then suitable hwdb entries can be
> created for udev that remap these to some sort of meaningful values.
> 
> Here is an example hwdb file I created for my laptop:
> $ cat /etc/udev/hwdb.d/quickstart.hwdb 
> evdev:name:Quickstart Button 1:dmi:bvn*:bvr*:bd*:svnTOSHIBA:pn*Z830:*
>  KEYBOARD_KEY_01=prog1
> 
> evdev:name:Quickstart Button 2:dmi:bvn*:bvr*:bd*:svnTOSHIBA:pn*Z830:*
>  KEYBOARD_KEY_01=prog2
> 
> evdev:name:Quickstart Button 3:dmi:bvn*:bvr*:bd*:svnTOSHIBA:pn*Z830:*
>  KEYBOARD_KEY_01=touchpad_toggle
> 
> As can be seen I always use the scancode 1 here. Would it be better to use
> the ID from GHID instead? This can be an arbitrary 32-bit value.

I think it would make sense to use the ID from GHID here, yes, then you
could simplify your hwdb entry to:

evdev:name:Quickstart Button *:dmi:bvn*:bvr*:bd*:svnTOSHIBA:pn*Z830:*
  KEYBOARD_KEY_xxxx=prog1
  KEYBOARD_KEY_xxxx=prog2
  KEYBOARD_KEY_xxxx=touchpad_toggle

This also looks a bit nicer then needing one entry per button.

Note that if you do this you need to generate the sparse-keymap
on the fly for it to contain the GHID scancode. Userspace can
only modify mappings for scancodes which are present in the
sparse-keymap.

> Note also that prog1 and prog2 are poor approximations of the real buttons.
> In reality the buttons are "Eco mode" and "Open Windows Mobility center on
> screen about switching to projection mode". However Linux seem to lack
> suitable key definitions for these.

Using prog1 / prog2 is fine here. Although I think if you look at all the possible
keycodes you may find closer matches. E.g. you could use battery / KEY_BATTERY for
Eco mode and maybe KEY_SWITCHVIDEOMODE for the "switching to projection mode" key.

> 2.3. Issue 3: GHID: 64-bit values?
> ----------------------------------
> The old staging driver had support for GHID returning a 64-bit value. It is
> not clear to me why, as it is not mentioned in the specification. I could
> not find anything when reading the old emails either. As such, I'm unsure
> if I should drop it. The variable this gets stored to is just 32-bit
> anyway.
> 
> If we decide to use GHID for scancode (see "Issue 2"), 64-bit values
> might be a problem, as the scan code field is only 32 bits.

I think replacing the 64 bit code with a warning that 64 bit values
are not supported is going to be the best thing to do if you chose
to use the GHID as keycode.


> 2.4. Issue 4: MAINTAINERS?
> --------------------------
> I got this from checkpatch.pl:
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
> I'm not sure? Advice would be welcome.

If you plan to be available for maintenance / review of this driver
going forward; then yes please add a MAINTAINERS entry and also consider
adding your name + email to the MAINTAINERS entry for the toshiba_acpi
driver.

> 3. User space API
> =================
> Currently the user space API is as a sparse keymap input device, plus two
> unique sysfs files. Discussion on this is welcome!
> 
> 3.1. Input device
> -----------------
> The device produces KEY_UNKNOWN events when the button is pressed, with
> the scan code 1. We could change the scan code to the button ID reported
> by ACPI via GHID. See also "Issue 2" and "Issue 3" above.

I think defaulting to KEY_UNKNOWN here is fine and otherwise this is
fine too. 

> 3.2. Sysfs file: button_id (Read only)
> --------------------------
> This file can be read to get the button ID as reported by GHID. It is
> returned in human readable ASCII with a trailing newline.

You could drop this if you generate the scancode from the GHID since then
it will be duplicate info with the scancode. OR if you prefer you may
keep it. I have a slight preference for dropping it, but your choice.

> 3.3. Sysfs file: wakeup_cause (Read write)
> -----------------------------
> Will return "true\n" when read after the button was the wakeup cause.
> This is latched until user space writes "false" to the file.
> 
> See also "Issue 1" above. If this is not a suitable interface I'm inclined
> to just drop the wakeup handling entirely.

See my answer above.

> 4. HCI_HOTKEY_EVENT register (toshiba_acpi)
> ============================
> To enable quickstart hotkeys, the HCI_HOTKEY_EVENT (0x1e) register needs
> to be set correctly by toshiba_acpi. toshiba_acpi currently sets this to
> HCI_HOTKEY_ENABLE (0x9) on the Z830. This is not suitable.
> 
> * Windows drivers reads the register then sets it to 0x5. Presumably there
>   is some logic going on there.
> * HCI_GET on HCI_HOTKEY_EVENT returns 0xf before first call to set it when
>   booting Linux on this laptop.
> * From my testing any value between 1 and 7 (inclusive) gives the correct
>   behaviour for the quickstart buttons. However, for normal hotkeys to work
>   in toshiba_acpi, only values with the least significant bit set work.
> 
> Toshiba_acpi already detects some laptops using SCI_KBD_FUNCTION_KEYS. That
> call is not supported on this laptop (return status TOS_NOT_SUPPORTED).
> 
> It is not clear to me how to detect when to use the 0x5 value. In the
> attached patch I use a quirk table to enable this. There may be a better
> way to do it.

Extending the existing quirk table for this is fine, I don't see any
other way to easily do this.

Thank you for your work on this!

Regards,

Hans





> 
> Note! This series is based off the review-hans branch.
> 
> Best regards,
> Arvid Norlander
> 
> Arvid Norlander (2):
>   platform/x86: quickstart: Add ACPI quickstart button (PNP0C32) driver
>   platform/x86: toshiba_acpi: Add quirk for buttons on Z830
> 
>  drivers/platform/x86/Kconfig        |  13 ++
>  drivers/platform/x86/Makefile       |   3 +
>  drivers/platform/x86/quickstart.c   | 320 ++++++++++++++++++++++++++++
>  drivers/platform/x86/toshiba_acpi.c |  36 +++-
>  4 files changed, 369 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/platform/x86/quickstart.c
> 

