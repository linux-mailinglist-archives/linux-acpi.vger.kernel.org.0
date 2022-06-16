Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1DE54DDF9
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jun 2022 11:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiFPJNc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Jun 2022 05:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiFPJNb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jun 2022 05:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F3273615A
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jun 2022 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655370809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjxqF8XhPNY9Cacma+OuPDOpyh4WUSq9xd/w2DyGIWQ=;
        b=bG5ben3HouaDy9CIppKOSTRe2JR9gjBV32wrVpHXqZmGH3I9Eih58suMxCkM6i0JoIMxMf
        YssAo30o48g8gtjqtF094ln0x2HeoHb6ZFZJ1Xy4b+NI6EQsDrGwt7ZiqmpljR+EGBk27U
        pzMJlZEn2Xrzpy7AUwzPNkY/0n6IZpw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-qRvZHEFIMSWP6F5FDpCxgA-1; Thu, 16 Jun 2022 05:13:26 -0400
X-MC-Unique: qRvZHEFIMSWP6F5FDpCxgA-1
Received: by mail-ed1-f69.google.com with SMTP id y4-20020aa7ccc4000000b0042df06d83bcso817641edt.22
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jun 2022 02:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GjxqF8XhPNY9Cacma+OuPDOpyh4WUSq9xd/w2DyGIWQ=;
        b=H3t7rZlyvI7C5AWXi27qBQT6rAWDz8xSov/2f8XY5OyROSIPMCSpzJy632JdM7dDKb
         lpiNDg++wBp/8XbJyAiFGqnPLLC9QDfzWVHtjVpLUFOtP2REgVzuD3DiwjaisvsFjc9F
         fMmWVBuurlDYUPdqtFqq8TIUff62h7vBrysAnq479QRvD18C7w93wSb7NcDz4gnyFSSs
         XJ1BVRqcEvfLdmtXvB0SGgYvldakUoNBhFVQabmOjT9v4pCZ9am/9K48VlKZgBT7FcM7
         mV+/f0gZhTjQ5X9L0glIQt/FWVw5OeBhUH1jsmSPh8bXVRBK1G4mfLCTK8nAXCoyOCJx
         Qw6Q==
X-Gm-Message-State: AJIora92ciaQzLlKMu3t9mR4eJSIu1hi0olyMWOEBBPODD/jnQ7z+dV4
        83v7n0QJNeRw+7iii+3hi1u0awdhTyrJSexowtJ4zDkHcmWKd1GctbBln8Eblu2Q67JfsKTsKJ8
        m8lgUVmFvwP8qA3HL4RShPA==
X-Received: by 2002:a05:6402:26cf:b0:431:5d99:2142 with SMTP id x15-20020a05640226cf00b004315d992142mr5199813edd.242.1655370805088;
        Thu, 16 Jun 2022 02:13:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uti+tDHRVeMRbvV+0iB/EnJpvsL+bchFui4BwiVBgBmVqNdyryc3/GqS7mPd+IEtL3AM6TGw==
X-Received: by 2002:a05:6402:26cf:b0:431:5d99:2142 with SMTP id x15-20020a05640226cf00b004315d992142mr5199790edd.242.1655370804874;
        Thu, 16 Jun 2022 02:13:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id j4-20020a50ed04000000b004318ba244dcsm1359035eds.10.2022.06.16.02.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 02:13:24 -0700 (PDT)
Message-ID: <e1647dae-cde2-868d-458d-ffe969203566@redhat.com>
Date:   Thu, 16 Jun 2022 11:13:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC 2/4] ACPICA: Add \_SB.PC00, \SB.PCI0 to
 acpi_ns_early_initialize_devices()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?Q?Johannes_Pen=c3=9fel?= <johannespenssel@posteo.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
References: <20220615195643.12608-1-hdegoede@redhat.com>
 <20220615195643.12608-3-hdegoede@redhat.com>
 <CAHp75VcPEw93_3dZvKCadnAqrJCVvdVcKh+DodgBC68xkmJ7VQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VcPEw93_3dZvKCadnAqrJCVvdVcKh+DodgBC68xkmJ7VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/15/22 23:31, Andy Shevchenko wrote:
> On Wed, Jun 15, 2022 at 9:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Since ACPICA commit f005ee6b90d1 / Linux commit 2d3349de8072
>> ("ACPICA: Namespace: Reorder \_SB._INI to make sure it is evaluated
>> before _REG evaluations") acpi_initialize_objects() calls \_SB._INI
>> before executing _REG OpRegion methods, because the _REG methods may
>> rely on initialization done by this _INI method.
>>
>> In many DSDTs the \_SB.PC00._INI / \_SB.PCI0._INI methods set an OSYS
>> global variable based on _OSI evaluations.
>>
>> In some cases there are _REG methods which depend on the OSYS value and
>> before this change ACPICA would run these _REG methods before running
>> _SB.PC00._INI / \_SB.PCI0._INI causing issues.
>>
>> 2 examples of problems caused by running _REG methods before these
>> _INI methods are:
>>
>> 1. on a "Lenovo IdeaPad 5 15ITL05" \_SB.PC00.LPCB.EC0._REG gets
>> evaluated before \_SB.PC00._INI and that _REG contains:
>>
>>     If ((OSYS == 0x07DF))
>>     {
>>         Local0 = 0x06
>>     }
>>
>>     If ((Acquire (LFCM, 0xA000) == Zero))
>>     {
>>         OSTY = Local0
>>         ...
>>
>> With OSTY being a SystemMemory OpRegion field, due to the _INI running
>> too late, Local0 stays at 0. Causing OSTY to be set to 0 instead of 6,
>> which causes the brightness up/down keys to not work:
>> https://bugzilla.kernel.org/show_bug.cgi?id=214899
>>
>> 2. On a "Lenovo Thinkbook 14-ILL" \\_SB_.PCI0.I2C0._REG gets
>> evaluated before \_SB.PCI0._INI and that _REG contains:
>>
>>     If ((OSYS == 0x07DF))
>>     {
>>         ...
>>         LNUX = Zero
>>         TPID = 0x4E
>>     }
>>     else
>>     {
>>         LNUX = One
>>         TPID = 0xBB
>>     }
>>
>> And then later on the TPID value gets used to decide for which of multiple
>> devices describing the touchpad _STA should return 0xF and the one which
>> gets enabled by TPID=0xBB is broken, causing to the touchpad to not work:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1842039
>>
>> Fix these issues by adding \_SB.PC00._INI / \_SB.PCI0._INI to the list of
>> _INI methods to run early (before executing _REG methods).
> 
> ...
> 
>> -       char path[ACPI_PATH_SEGMENT_LENGTH + 2];
>> +       char path[ACPI_PATH_SEGMENT_LENGTH * 2 + 2];
> 
> Strictly speaking this should be, IIUC,
> 
> 1 + ACPI_PATH_SEGMENT_LENGTH + ACPI_NAMESEG_SIZE + 1
> 
> \\ + path segment length (with a separator) + name + \0
> 
> That said, it seems the original code adds 1 unneeded byte.

Right I already knew I needed the " * 2" when writing the
original code, so I decided to do things this way for KISS
reasons.

> Perhaps a comment in the code?

I've added a comment to my local version now.

After this thread has had some more time to gather feedback
I will turn the ACPICA patches into a acpica github pull-req
with the comment added.

(or if necessary rework the entire series)

Regards,

Hans

