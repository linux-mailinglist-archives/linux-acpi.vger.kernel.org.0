Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019B755EE11
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 21:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiF1Trv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jun 2022 15:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiF1Trb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2022 15:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E4BD3BA7C
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2022 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656445390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yEJ7wX3mlb+qJJftnxsjyjo/a0SZp0zhUCATVsqsu2w=;
        b=ARUsW1T8If3ux2X46E3WFsw14sBNp5flXkwyJ2IAJFI/KLIBUYDE4KQ1AlaVt9fMRWAT5K
        o7iiIeTGAXe9ef2agZf2QoikoarlTitmalUG5Ch4LgT8T4HCuVTxQ4oNQvFPjcfjR4OhCg
        +GuoYvzDbQc0bwnEJj54LTxgTjvYyZE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-5qiFOENRPbSlMFClERKCgg-1; Tue, 28 Jun 2022 15:42:41 -0400
X-MC-Unique: 5qiFOENRPbSlMFClERKCgg-1
Received: by mail-ej1-f69.google.com with SMTP id k7-20020a1709062a4700b006fe92440164so4092988eje.23
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2022 12:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yEJ7wX3mlb+qJJftnxsjyjo/a0SZp0zhUCATVsqsu2w=;
        b=Y042TcFRyLVMiZLorXiLQa1uwHnZEnMEmW/Rak9QBaBedMgCMEaR5irOg4lM9ejxFl
         dCFvIVDgh5BXh+uFkSHIQokL3bRky9VgTJ5MwYxDp6ZC27Svt3wXYEL9e5cts70vAEKM
         +ipFGzjrWV2y9uf2IR5Mg+WhxTllr6NZ6NGLGeGzVD7kw6RfUEGKFdR4X/u6Nr1jQn/7
         F1JAO45YkABXcQ72hqL3pXv1SmxrSYHOAWpuspcCvfAWk6o2u6S1jIEnwPP6byg6VTk/
         yK+zqXDKPeqGqGq5+7hO3M6f9K2OAee5NhGyIVCi1dIIhTMB9iRZR1UmEXyUzsSR9yv6
         0uiw==
X-Gm-Message-State: AJIora8buIoMBvOluZDYMDIdO3uq0IQ8Cb6r8edifIVV+67kjD6zPtfe
        M9FDIgW3rfeuJLIrRZlwc0h50fh1Cnzi0CPSjXyUV/mXM2Hf/9EewyHgWAEuu/aXyLa13gDDxeN
        Sk86Ot1OOiyVTbbKbiVOpkw==
X-Received: by 2002:a17:907:961c:b0:726:9f09:6b3c with SMTP id gb28-20020a170907961c00b007269f096b3cmr13347503ejc.711.1656445360544;
        Tue, 28 Jun 2022 12:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uL7+hWd8Y249uZFTMLQIm8lIEAncGNuW27bdYHW4ZsCU9kVXc4eHbNCUXIPA/Ib3/CAzP7Lg==
X-Received: by 2002:a17:907:961c:b0:726:9f09:6b3c with SMTP id gb28-20020a170907961c00b007269f096b3cmr13347473ejc.711.1656445360242;
        Tue, 28 Jun 2022 12:42:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id cf11-20020a0564020b8b00b00437ae26e728sm1825490edb.3.2022.06.28.12.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 12:42:39 -0700 (PDT)
Message-ID: <8e49499d-9648-9e87-4024-4fd67830c6d0@redhat.com>
Date:   Tue, 28 Jun 2022 21:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC 4/4] ACPI: fix ECDT EC probe ordering issues
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?Q?Johannes_Pen=c3=9fel?= <johannespenssel@posteo.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
References: <20220615195643.12608-1-hdegoede@redhat.com>
 <20220615195643.12608-5-hdegoede@redhat.com>
 <CAJZ5v0iCmNuqL0-12XOAcFb1t-Ueadn+BOZ=C=QWULXh4UdOKw@mail.gmail.com>
 <eaa10b85-17fe-fd4b-8230-1caf92ffcd34@redhat.com>
 <CAJZ5v0g=8ZDCFnZH_j4BkpjLGPaEn1SQPq7+7=A0SBp8we+cHg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0g=8ZDCFnZH_j4BkpjLGPaEn1SQPq7+7=A0SBp8we+cHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/28/22 21:15, Rafael J. Wysocki wrote:
> On Mon, Jun 27, 2022 at 5:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 6/27/22 16:21, Rafael J. Wysocki wrote:
>>> First off, thanks for taking care of this issue!
>>
>> You're welcome.
>>
>>> On Wed, Jun 15, 2022 at 9:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> ACPI-2.0 says that the EC OpRegion handler must be available immediately
>>>> (like the standard default OpRegion handlers). So acpi_bus_init() calls
>>>> acpi_ec_ecdt_probe(), which calls acpi_install_address_space_handler() to
>>>> install the EC's OpRegion handler, early on.
>>>
>>> I think that the key question is what Windows does in this respect.
>>>
>>> I honestly don't think that it uses an allowlist to early call _INI
>>> for a few specific devices.
>>
>> Right, I guess that windows does things more hierarchicallly first
>> calling \._INI then \._SB._INI and then calling other _INI-s around
>> the time it enters there parts of the ACPI device hierarchy.
>>
>> I have the feeling that Windows e.g. has the root PCI bridge fully
>> setup before even parsing any ACPI objects under it.
> 
> Which means that if the EC object is under PCI0, it will not evaluate
> its _REG before enumerating the PCI bus.

Ack, assuming that my hunch of Windows behavior is correct.

>> This is quite different from how Linux (or ACPICa for that manner)
>> works. So ATM I believe that the fixed list of object paths to
>> call _INI on early is the best we can do.
> 
> Well, ACPICA follows the spec quite literally in that respect (and the
> spec says that _INI should be evaluated "at the table load time"
> IIRC).

<offtopic for the EC issue, sorry (but stronly related)>

I did notice one interesting thing while working on this, ACPICA
has drivers/acpi/acpica/nsinit.c: acpi_ns_initialize_objects()
which calls _INI for *all* objects and it also has:
drivers/acpi/acpica/utxfinit.c: acpi_initialize_objects():

#ifdef ACPI_OBSOLETE_BEHAVIOR
        /*
         * 05/2019: Removed, initialization now happens at both object
         * creation and table load time
         */

        /*
         * Initialize the objects that remain uninitialized. This
         * runs the executable AML that may be part of the
         * declaration of these objects: operation_regions, buffer_fields,
         * bank_fields, Buffers, and Packages.
         */
        if (!(flags & ACPI_NO_OBJECT_INIT)) {
                status = acpi_ns_initialize_objects();
                if (ACPI_FAILURE(status)) {
                        return_ACPI_STATUS(status);
                }
        }
#endif

Which means that at some point in time it used to indeed call
_INI on all objects early on. But now this no longer happens
and instead acpi_initialize_objects() ends up in acpi_ns_initialize_devices()
which does:

1. Run \._INI
2. Run \_SB._INI
3. Run _REG for all SystemIO / SystemMemory / PCI_Config handlers
4. Run _INI for all other objects

And I believe that this is causing similar issues as the EC issue
we are discussing here in some cases. Specifically the earlier
mentioned touchpad issue:

"""
On a "Lenovo Thinkbook 14-ILL" \\_SB_.PCI0.I2C0._REG gets
evaluated before \_SB.PCI0._INI and that _REG contains:

    If ((OSYS == 0x07DF))
    {
	...
        LNUX = Zero
        TPID = 0x4E
    }
    else
    {
        LNUX = One
        TPID = 0xBB
    }

And then later on the TPID value gets used to decide for which of multiple
devices describing the touchpad _STA should return 0xF and the one which
gets enabled by TPID=0xBB is broken, causing to the touchpad to not work:
https://bugzilla.redhat.com/show_bug.cgi?id=1842039
"""

The difference between the EC problem and this one is that the troublesome
code in the EC _REG handler is inside a:

                If (((Arg0 == 0x03) && (Arg1 == One)))
                {
                }

block, so any non EmbeddedController OpRegion _REG calls are not an issue.

Where as in the "Lenovo Thinkbook 14-ILL" touchpad case the troublesome
_REG looks like this (simplified):

            Method (_REG, 2, NotSerialized)  // _REG: Region Availability
            {
                If ((TPID != Zero))
                {
                    Return (Zero)
                }

                If ((OSYS == 0x07DF))
                {
                    TPID = <one we want>
                }
                Else
                {
                    TPID = <wrong-one>
                }

                Return (Zero)
            }

So it only checks OSYS the first time it runs (when TPID == 0)
and the above mentioned steps 1-4 done by acpi_ns_initialize_devices()
runs this _REG too early. The reasons why this runs too early is
because the  \_SB_.PCI0.I2C0 device which this is the _REG method for
also uses a PCI_Config OpRegion, so the early _REG calls done
by acpi_ns_initialize_devices() will run this _REG.

So even if we fix the EC issue by having the EC code call _REG later
for the EC object we still have this issue wrt general _REG vs _INI
ordering, any suggestions welcome. Otherwise I will likely still try
to get patches 1 + 2 from this series upstream to fix this.

Or maybe we need to just make acpi_ns_initialize_devices() call
all _INI methods before calling any _REG methods? That does somehow
feel right, but I'm not sure how well it will work in practice.

</semi-offtopic>

>>>> This not only installs the OpRegion handler, but also calls the EC's
>>>> _REG method. The _REG method call is a problem because it may rely on
>>>> initialization done by the _INI methods of one of the PCI / _SB root devs,
>>>> see for example: https://bugzilla.kernel.org/show_bug.cgi?id=214899 .
>>>>
>>>> This _REG depends on _INI problem can be fixed by calling the new ACPICA
>>>> acpi_early_initialize_objects() function before acpi_ec_ecdt_probe().
>>>>
>>>> But on some boards (e.g. Lenovo X1C8) the root devices _INI method
>>>> relies on the EC OpRegion so executing the _INI methods before
>>>> registering the EC OpRegion handler leads to errors there.
>>>>
>>>> To allow fixing this the ACPICA code now allows to do the OpRegion handler
>>>> installation early on (without calling _REG) and to do the EC's _REG
>>>> execution later on as a separate step.
>>>>
>>>> This commit uses this new ACPICA functions to fix the EC probe ordering
>>>> by changing the acpi_bus_init() initialization order to this:
>>>>
>>>> 1. acpi_load_tables()
>>>> 2. acpi_ec_ecdt_probe()
>>>>    This now calls acpi_install_address_space_handler(ACPI_NO_EXEC__REG)
>>>>    which installs the OpRegion handler without executing _REG
>>>
>>> I'm not sure if installing an opregion without evaluating _REG for it
>>> is particularly useful.
>>
>> We already do this for the SystemMemory / SystemIO and PCI_Config OpRegions.
>> The handlers for these get installed from acpi_enable_subsystem()
>> and their _REG functions get called later from acpi_initialize_objects().
>>
>> This patch basically makes the EmbeddedControl OpRegion behave the
>> same and according to the current code:
> 
> I think that the evaluation of _REG can be deferred in this case.
> 
>>
>>         /*
>>          * ACPI 2.0 requires the EC driver to be loaded and work before the EC
>>          * device is found in the namespace.
>>          *
>>          * This is accomplished by looking for the ECDT table and getting the EC
>>          * parameters out of that.
>>          *
>>          * Do that before calling acpi_initialize_objects() which may trigger EC
>>          * address space accesses.
>>          */
>>         acpi_ec_ecdt_probe();
>>
>> This is mandated by ACPI-2.0 which also seems to match my analysis
>> of this problem where on e.g. my Lenovo X1 carbon gen 8
>> the \_SB.PCI0._INI method uses an EmbeddedControl OpRegion without
>> any _REG related checks.
>>> No AML should use it before _REG is evaluated anyway.
>>
>> See above, ACPI 2.x seems to allow this, like how it allows it
>> for SystemIO / SystemMemory / PCI_Config. This seems to be the
>> whole reason why there is a separate table describing the EC
>> (the ECDT) so that the EC can be made available before any parsing
>> of the DSDT has been done.
>>
>> So we need to have the OpRegion available before running the
>> "early" _INI methods. And because of _REG relying on the OSYS
>> GVNS variable in some cases, which gets set from _INI on the
>> PCI root bridge, that means running _REG after running
>> (some) _INI methods.
> 
> OK, so at least on some systems the EC address space will be accessed
> regardless of the _REG for it.
> 
>>>> 3. acpi_enable_subsystem()
>>>> 4. acpi_early_initialize_objects()
>>>>    This calls the _INI method of the PCI and _SB root devices
>>>
>>> So this is a change in behavior that will affect every system using
>>> ACPI on the planet, not just the ones where the problem at hand is
>>> present.  This appears to be somewhat risky to me.
>>
>> The ACPICA code already calls \.INI and \_SB._INI at the start of
>> acpi_initialize_objects(), before evalutating any _REG methods,
>> so this call in itself is no a change.
>>
>> Except that \_SB.PCI0._INI and \_SB.PC0._INI are now also
>> run early (patch 2/4).
>>>> 5. acpi_ec_ecdt_exec_reg();
>>>>    This executes the EC's _REG now that the root devices _INI has run
>>
>> This is the actual change moving the calling of _REG for the EC to after
>> the running of the "early" _INI calls.
>>
>>>> 6. acpi_initialize_objects(ACPI_NO_EARLY_DEVICE_INIT)
>>>>
>>>> This allows the EC's _REG method to depend on e.g. the \OSYS global/GVNS
>>>> variable often set by a root-device's _INI method, while at the same time
>>>> allowing these _INI methods to access EmbeddedController OpRegions.
>>>
>>> I'm wondering if it is possible to change the ordering of
>>> acpi_ec_ecdt_probe() or the part of it that installs the oprtegion
>>> handler to be called later?
>>
>> Note splitting the install vs _REG calling of OpRegion handlers
>> requires ACPICA changes (patch 3/4).
>>
>> Assuming those changes are in place then we could delay calling
>> of _REG also until the actual acpi-ec driver binds. This would
>> put it a lot later in the init sequence though. So that would
>> be much more of a change to the ordering then done in this
>> RFC series.
>>
>> I did consider this and I do think it makes sense to only call
>> _REG once we actually have fully setup the ACPI device for
>> the EC (rather then just parsed the ECDT as we do now), but
>> it is a big change.
> 
> That's what I would like to do here.
> 
>> This would also put the _REG late enough that the _INI
>> setting the OSYS variable has already run, avoiding
>> the need for the "early" _INI calls from the EC _REG
>> evaluation pov (1).
>>
>> If we go this route then acpi_bus_init() would not need any
>> changes. In this case the changes would be:
>>
>> 1. Change  acpi_ec_ecdt_probe(); to only install the
>> OpRegion handler and not call _REG
>>
>> 2. Call _REG from acpi_ec_add() before it calls
>> acpi_dev_clear_dependencies(device);
>>
>> If you think that is better I can implement this and ask
>> the reporter of:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=214899
>>
>> to give this new approach a test run.
> 
> Yes, please.

Ok, will do. Not sure when I will get around to this though.

Regards,

Hans

