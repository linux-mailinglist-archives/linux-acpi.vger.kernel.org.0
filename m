Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC655DD78
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 15:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiF0PDl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jun 2022 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiF0PDk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2022 11:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 457BF165BF
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2022 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656342218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5uTgr5rYhhsck2/YytYT6nERnDyrlPU7/cr7To8gQM=;
        b=VsUhP5EVapphA2E950scvPeFMDtevp6yyAOPcFDWsb8TzW0N4ZOFMfpdRa7rvqkg21C6fW
        w03DmcYFjgDRcA8QC2mA80M7OQMSSwAnw9o3Hk9815AFdhLkB91A9awLYRJMtYpnm9sliF
        JbrBVajlIp0d5CUazVPsOCV07FgUujo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-0nhV7TsLPTycsqk24x96WA-1; Mon, 27 Jun 2022 11:03:37 -0400
X-MC-Unique: 0nhV7TsLPTycsqk24x96WA-1
Received: by mail-ed1-f70.google.com with SMTP id z17-20020a05640235d100b0043762b1e1e3so5926139edc.21
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2022 08:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c5uTgr5rYhhsck2/YytYT6nERnDyrlPU7/cr7To8gQM=;
        b=VWGcMOOYwXRMyFvw8NF6YSYg/GH2Nnpz8sg0vKWPzDrFZRuB/U+kedYLiEqjiED2pV
         IHT3YgujtWW3wdfQYqji1Ye79C96KhAH9uHBbcde3gP+uJiMzAJAuw01KzW5HBFykv1H
         pzMQC9fAuJlJPQFE1qbpFEcmkt7L+6Hhwv2v9K0r27/rr7GGoM5dridrwQVol9fkFbav
         anrB/IxJg0BbVbyjQc48zWPHIN501nECG6jXZpBbMGeEAXwget6vfoM1iXo1rx8k+z5s
         3ARXeFXOjOQTKNVM4/w2u53iDqZDrB3sFxtPDPwXdRRuDg+RfuCywIz7udVyxWUcSmhF
         9meQ==
X-Gm-Message-State: AJIora8qaqRGygOaZ5HG+A0/kmMAexisXXva2a0ND46JecnsLhyoFDiR
        X6SqLMsak8fkUJVTHp5Jzt/xBAhsr0N5ooWNnIDU8m5Zq2r5D72zUJ7ubr0ATECwXByADtIIZWw
        JXimdCg/KtQNEBPjqTIH0Lw==
X-Received: by 2002:a05:6402:3546:b0:437:6806:8db4 with SMTP id f6-20020a056402354600b0043768068db4mr16631632edd.48.1656342215784;
        Mon, 27 Jun 2022 08:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uoDKHolsV4ygNsLJSASVCbvkuKLAyzc2yc/ExAtobmF7n4AOco+a7Schvwgi7iwom8z8CHRw==
X-Received: by 2002:a05:6402:3546:b0:437:6806:8db4 with SMTP id f6-20020a056402354600b0043768068db4mr16631582edd.48.1656342215409;
        Mon, 27 Jun 2022 08:03:35 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709062a4b00b00726abf9a32bsm964472eje.138.2022.06.27.08.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 08:03:34 -0700 (PDT)
Message-ID: <eaa10b85-17fe-fd4b-8230-1caf92ffcd34@redhat.com>
Date:   Mon, 27 Jun 2022 17:03:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0iCmNuqL0-12XOAcFb1t-Ueadn+BOZ=C=QWULXh4UdOKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/27/22 16:21, Rafael J. Wysocki wrote:
> First off, thanks for taking care of this issue!

You're welcome.

> On Wed, Jun 15, 2022 at 9:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> ACPI-2.0 says that the EC OpRegion handler must be available immediately
>> (like the standard default OpRegion handlers). So acpi_bus_init() calls
>> acpi_ec_ecdt_probe(), which calls acpi_install_address_space_handler() to
>> install the EC's OpRegion handler, early on.
> 
> I think that the key question is what Windows does in this respect.
> 
> I honestly don't think that it uses an allowlist to early call _INI
> for a few specific devices.

Right, I guess that windows does things more hierarchicallly first
calling \._INI then \._SB._INI and then calling other _INI-s around
the time it enters there parts of the ACPI device hierarchy.

I have the feeling that Windows e.g. has the root PCI bridge fully
setup before even parsing any ACPI objects under it.

This is quite different from how Linux (or ACPICa for that manner)
works. So ATM I believe that the fixed list of object paths to
call _INI on early is the best we can do.

> 
>> This not only installs the OpRegion handler, but also calls the EC's
>> _REG method. The _REG method call is a problem because it may rely on
>> initialization done by the _INI methods of one of the PCI / _SB root devs,
>> see for example: https://bugzilla.kernel.org/show_bug.cgi?id=214899 .
>>
>> This _REG depends on _INI problem can be fixed by calling the new ACPICA
>> acpi_early_initialize_objects() function before acpi_ec_ecdt_probe().
>>
>> But on some boards (e.g. Lenovo X1C8) the root devices _INI method
>> relies on the EC OpRegion so executing the _INI methods before
>> registering the EC OpRegion handler leads to errors there.
>>
>> To allow fixing this the ACPICA code now allows to do the OpRegion handler
>> installation early on (without calling _REG) and to do the EC's _REG
>> execution later on as a separate step.
>>
>> This commit uses this new ACPICA functions to fix the EC probe ordering
>> by changing the acpi_bus_init() initialization order to this:
>>
>> 1. acpi_load_tables()
>> 2. acpi_ec_ecdt_probe()
>>    This now calls acpi_install_address_space_handler(ACPI_NO_EXEC__REG)
>>    which installs the OpRegion handler without executing _REG
> 
> I'm not sure if installing an opregion without evaluating _REG for it
> is particularly useful.

We already do this for the SystemMemory / SystemIO and PCI_Config OpRegions.
The handlers for these get installed from acpi_enable_subsystem()
and their _REG functions get called later from acpi_initialize_objects().

This patch basically makes the EmbeddedControl OpRegion behave the
same and according to the current code:


        /*
         * ACPI 2.0 requires the EC driver to be loaded and work before the EC
         * device is found in the namespace.
         *
         * This is accomplished by looking for the ECDT table and getting the EC
         * parameters out of that.
         *
         * Do that before calling acpi_initialize_objects() which may trigger EC
         * address space accesses.
         */
        acpi_ec_ecdt_probe();

This is mandated by ACPI-2.0 which also seems to match my analysis
of this problem where on e.g. my Lenovo X1 carbon gen 8
the \_SB.PCI0._INI method uses an EmbeddedControl OpRegion without
any _REG related checks.
> No AML should use it before _REG is evaluated anyway.

See above, ACPI 2.x seems to allow this, like how it allows it
for SystemIO / SystemMemory / PCI_Config. This seems to be the
whole reason why there is a separate table describing the EC
(the ECDT) so that the EC can be made available before any parsing
of the DSDT has been done.

So we need to have the OpRegion available before running the
"early" _INI methods. And because of _REG relying on the OSYS
GVNS variable in some cases, which gets set from _INI on the
PCI root bridge, that means running _REG after running
(some) _INI methods.

>> 3. acpi_enable_subsystem()
>> 4. acpi_early_initialize_objects()
>>    This calls the _INI method of the PCI and _SB root devices
> 
> So this is a change in behavior that will affect every system using
> ACPI on the planet, not just the ones where the problem at hand is
> present.  This appears to be somewhat risky to me.

The ACPICA code already calls \.INI and \_SB._INI at the start of
acpi_initialize_objects(), before evalutating any _REG methods,
so this call in itself is no a change.

Except that \_SB.PCI0._INI and \_SB.PC0._INI are now also
run early (patch 2/4).
>> 5. acpi_ec_ecdt_exec_reg();
>>    This executes the EC's _REG now that the root devices _INI has run

This is the actual change moving the calling of _REG for the EC to after
the running of the "early" _INI calls.

>> 6. acpi_initialize_objects(ACPI_NO_EARLY_DEVICE_INIT)
>>
>> This allows the EC's _REG method to depend on e.g. the \OSYS global/GVNS
>> variable often set by a root-device's _INI method, while at the same time
>> allowing these _INI methods to access EmbeddedController OpRegions.
> 
> I'm wondering if it is possible to change the ordering of
> acpi_ec_ecdt_probe() or the part of it that installs the oprtegion
> handler to be called later?

Note splitting the install vs _REG calling of OpRegion handlers
requires ACPICA changes (patch 3/4).

Assuming those changes are in place then we could delay calling
of _REG also until the actual acpi-ec driver binds. This would
put it a lot later in the init sequence though. So that would
be much more of a change to the ordering then done in this
RFC series.

I did consider this and I do think it makes sense to only call
_REG once we actually have fully setup the ACPI device for
the EC (rather then just parsed the ECDT as we do now), but
it is a big change.

This would also put the _REG late enough that the _INI
setting the OSYS variable has already run, avoiding
the need for the "early" _INI calls from the EC _REG
evaluation pov (1).

If we go this route then acpi_bus_init() would not need any
changes. In this case the changes would be:

1. Change  acpi_ec_ecdt_probe(); to only install the
OpRegion handler and not call _REG

2. Call _REG from acpi_ec_add() before it calls
acpi_dev_clear_dependencies(device);

If you think that is better I can implement this and ask
the reporter of:

https://bugzilla.kernel.org/show_bug.cgi?id=214899

to give this new approach a test run.


Regards,

Hans




1) Note there also is another issue wrt _REG running vs _INI
setting OSYS which is not EC related at all. Quoting from
the commit msg of patch 2/4:

"""2. On a "Lenovo Thinkbook 14-ILL" \\_SB_.PCI0.I2C0._REG gets
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

I believe that fixing this still requires running the PCI root bridge's
_INI method before calling _REG functions (on devices under that bridge
in the ACPI device hierarchy).

We can analyse this issue seperately and fixing this is likely isolated
to just ACPICA changes.









> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/bus.c      | 19 ++++++++++++++++++-
>>  drivers/acpi/ec.c       | 38 ++++++++++++++++++++++++++++----------
>>  drivers/acpi/internal.h |  1 +
>>  3 files changed, 47 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 86fa61a21826..fe5c46da5265 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1303,7 +1303,24 @@ static int __init acpi_bus_init(void)
>>                 goto error1;
>>         }
>>
>> -       status = acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
>> +       /*
>> +        * This usually sets an OSYS global variable based on _OSI checks,
>> +        * and the EC's _REG method may rely on this OSYS variable, so do
>> +        * this before acpi_ec_ecdt_exec_reg().
>> +        */
>> +       status = acpi_early_initialize_objects();
>> +       if (ACPI_FAILURE(status)) {
>> +               pr_err("Unable to do early ACPI objects initialization\n");
>> +               goto error1;
>> +       }
>> +
>> +       acpi_ec_ecdt_exec_reg();
>> +
>> +       /*
>> +        * ACPI_NO_EARLY_DEVICE_INIT to avoid ACPICA calling
>> +        * acpi_early_initialize_objects() a second time.
>> +        */
>> +       status = acpi_initialize_objects(ACPI_NO_EARLY_DEVICE_INIT);
>>         if (ACPI_FAILURE(status)) {
>>                 pr_err("Unable to initialize ACPI objects\n");
>>                 goto error1;
>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index a1b871a418f8..cd86e68d6b98 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -1459,6 +1459,7 @@ static bool install_gpio_irq_event_handler(struct acpi_ec *ec)
>>   * ec_install_handlers - Install service callbacks and register query methods.
>>   * @ec: Target EC.
>>   * @device: ACPI device object corresponding to @ec.
>> + * @flags: Flags to pass to acpi_install_address_space_handler()
>>   *
>>   * Install a handler for the EC address space type unless it has been installed
>>   * already.  If @device is not NULL, also look for EC query methods in the
>> @@ -1471,7 +1472,7 @@ static bool install_gpio_irq_event_handler(struct acpi_ec *ec)
>>   * -EPROBE_DEFER if GPIO IRQ acquisition needs to be deferred,
>>   * or 0 (success) otherwise.
>>   */
>> -static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
>> +static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device, u32 flags)
>>  {
>>         acpi_status status;
>>
>> @@ -1479,10 +1480,10 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
>>
>>         if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>>                 acpi_ec_enter_noirq(ec);
>> -               status = acpi_install_address_space_handler(ec->handle,
>> -                                                           ACPI_ADR_SPACE_EC,
>> -                                                           &acpi_ec_space_handler,
>> -                                                           NULL, ec);
>> +               status = acpi_install_address_space_handler_flags(ec->handle,
>> +                                                                 ACPI_ADR_SPACE_EC,
>> +                                                                 &acpi_ec_space_handler,
>> +                                                                 NULL, ec, flags);
>>                 if (ACPI_FAILURE(status)) {
>>                         acpi_ec_stop(ec, false);
>>                         return -ENODEV;
>> @@ -1575,11 +1576,11 @@ static void ec_remove_handlers(struct acpi_ec *ec)
>>         }
>>  }
>>
>> -static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device)
>> +static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device, u32 flags)
>>  {
>>         int ret;
>>
>> -       ret = ec_install_handlers(ec, device);
>> +       ret = ec_install_handlers(ec, device, flags);
>>         if (ret)
>>                 return ret;
>>
>> @@ -1641,7 +1642,7 @@ static int acpi_ec_add(struct acpi_device *device)
>>                 }
>>         }
>>
>> -       ret = acpi_ec_setup(ec, device);
>> +       ret = acpi_ec_setup(ec, device, 0);
>>         if (ret)
>>                 goto err;
>>
>> @@ -1761,7 +1762,7 @@ void __init acpi_ec_dsdt_probe(void)
>>          * At this point, the GPE is not fully initialized, so do not to
>>          * handle the events.
>>          */
>> -       ret = acpi_ec_setup(ec, NULL);
>> +       ret = acpi_ec_setup(ec, NULL, 0);
>>         if (ret) {
>>                 acpi_ec_free(ec);
>>                 return;
>> @@ -1973,7 +1974,7 @@ void __init acpi_ec_ecdt_probe(void)
>>          * At this point, the namespace is not initialized, so do not find
>>          * the namespace objects, or handle the events.
>>          */
>> -       ret = acpi_ec_setup(ec, NULL);
>> +       ret = acpi_ec_setup(ec, NULL, ACPI_NO_EXEC__REG);
>>         if (ret) {
>>                 acpi_ec_free(ec);
>>                 goto out;
>> @@ -1988,6 +1989,23 @@ void __init acpi_ec_ecdt_probe(void)
>>         acpi_put_table((struct acpi_table_header *)ecdt_ptr);
>>  }
>>
>> +void __init acpi_ec_ecdt_exec_reg(void)
>> +{
>> +       if (!boot_ec || !boot_ec_is_ecdt)
>> +               return;
>> +
>> +       /*
>> +        * Second call, first call is done in acpi_ec_ecdt_probe(), pass
>> +        * ACPI_NO_INSTALL_SPACE_HANDLER so as to only exec _REG now that
>> +        * the namespace has been setup.
>> +        */
>> +       acpi_install_address_space_handler_flags(boot_ec->handle,
>> +                                                ACPI_ADR_SPACE_EC,
>> +                                                &acpi_ec_space_handler, NULL,
>> +                                                boot_ec,
>> +                                                ACPI_NO_INSTALL_SPACE_HANDLER);
>> +}
>> +
>>  #ifdef CONFIG_PM_SLEEP
>>  static int acpi_ec_suspend(struct device *dev)
>>  {
>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>> index 628bf8f18130..14dce6830e01 100644
>> --- a/drivers/acpi/internal.h
>> +++ b/drivers/acpi/internal.h
>> @@ -203,6 +203,7 @@ typedef int (*acpi_ec_query_func) (void *data);
>>
>>  void acpi_ec_init(void);
>>  void acpi_ec_ecdt_probe(void);
>> +void acpi_ec_ecdt_exec_reg(void);
>>  void acpi_ec_dsdt_probe(void);
>>  void acpi_ec_block_transactions(void);
>>  void acpi_ec_unblock_transactions(void);
>> --
>> 2.36.0
>>
> 

