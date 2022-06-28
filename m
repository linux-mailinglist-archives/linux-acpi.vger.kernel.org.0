Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958D655EDC2
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 21:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiF1TQX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jun 2022 15:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiF1TQC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2022 15:16:02 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15FF24F00
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2022 12:15:46 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-31780ad7535so127144277b3.8
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2022 12:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bo/1QPtvNMQu6BY9HwIS12i/gVghHGJeoj1Epg9MjXY=;
        b=hxchxlS8fN+KxrNXVy3mOYK/jyCp5+rl9x8lKgh8Hbyuq+uhwciSU1YlUWmhJmK5Vd
         C11v2toL3ipYxh7U306OCGvGcjui7lJLJF7BPJToAeq0lBGVTcvDviNY4I5FS9u0/ET0
         Hu/bJYOGo/5XqGNsaDdW4706pWGcPfqQJnGEQn0Taes1OVUKJkSddJ/ngtDWJCO+c7PG
         ByR7ohUM1AExwNFOaV7JRTC7yTcxk+D651BH52fK+EqBKBKLaD4lkR9qv/7JrTI9mpve
         +L05lawrfL7zbkh9MkOGWPDYQ3XY6CTbeuNhcTbBmLoYRRjZTVLs/kZhdEQAQYAd/fj+
         7Y9A==
X-Gm-Message-State: AJIora9c5TpVtiVoKWzXUMM24zkNc4ogZKJxFEOe3sQh0kN33EJ0/r9y
        DxVatSnjF5gHnHRFAi7wc495u1RFXYjif0ENDDg=
X-Google-Smtp-Source: AGRyM1vTdQgZL223LhdSKnh0PLjHW9BvLbPs1LgjD8Tk6LTFF2aincs6dCJwo8exneshn4jzZ08Zp5n9QldRVMjh5do=
X-Received: by 2002:a81:68d7:0:b0:318:11df:a40d with SMTP id
 d206-20020a8168d7000000b0031811dfa40dmr23611007ywc.196.1656443745812; Tue, 28
 Jun 2022 12:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220615195643.12608-1-hdegoede@redhat.com> <20220615195643.12608-5-hdegoede@redhat.com>
 <CAJZ5v0iCmNuqL0-12XOAcFb1t-Ueadn+BOZ=C=QWULXh4UdOKw@mail.gmail.com> <eaa10b85-17fe-fd4b-8230-1caf92ffcd34@redhat.com>
In-Reply-To: <eaa10b85-17fe-fd4b-8230-1caf92ffcd34@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Jun 2022 21:15:34 +0200
Message-ID: <CAJZ5v0g=8ZDCFnZH_j4BkpjLGPaEn1SQPq7+7=A0SBp8we+cHg@mail.gmail.com>
Subject: Re: [RFC 4/4] ACPI: fix ECDT EC probe ordering issues
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?Q?Johannes_Pen=C3=9Fel?= <johannespenssel@posteo.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 27, 2022 at 5:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 6/27/22 16:21, Rafael J. Wysocki wrote:
> > First off, thanks for taking care of this issue!
>
> You're welcome.
>
> > On Wed, Jun 15, 2022 at 9:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> ACPI-2.0 says that the EC OpRegion handler must be available immediately
> >> (like the standard default OpRegion handlers). So acpi_bus_init() calls
> >> acpi_ec_ecdt_probe(), which calls acpi_install_address_space_handler() to
> >> install the EC's OpRegion handler, early on.
> >
> > I think that the key question is what Windows does in this respect.
> >
> > I honestly don't think that it uses an allowlist to early call _INI
> > for a few specific devices.
>
> Right, I guess that windows does things more hierarchicallly first
> calling \._INI then \._SB._INI and then calling other _INI-s around
> the time it enters there parts of the ACPI device hierarchy.
>
> I have the feeling that Windows e.g. has the root PCI bridge fully
> setup before even parsing any ACPI objects under it.

Which means that if the EC object is under PCI0, it will not evaluate
its _REG before enumerating the PCI bus.

> This is quite different from how Linux (or ACPICa for that manner)
> works. So ATM I believe that the fixed list of object paths to
> call _INI on early is the best we can do.

Well, ACPICA follows the spec quite literally in that respect (and the
spec says that _INI should be evaluated "at the table load time"
IIRC).

> >
> >> This not only installs the OpRegion handler, but also calls the EC's
> >> _REG method. The _REG method call is a problem because it may rely on
> >> initialization done by the _INI methods of one of the PCI / _SB root devs,
> >> see for example: https://bugzilla.kernel.org/show_bug.cgi?id=214899 .
> >>
> >> This _REG depends on _INI problem can be fixed by calling the new ACPICA
> >> acpi_early_initialize_objects() function before acpi_ec_ecdt_probe().
> >>
> >> But on some boards (e.g. Lenovo X1C8) the root devices _INI method
> >> relies on the EC OpRegion so executing the _INI methods before
> >> registering the EC OpRegion handler leads to errors there.
> >>
> >> To allow fixing this the ACPICA code now allows to do the OpRegion handler
> >> installation early on (without calling _REG) and to do the EC's _REG
> >> execution later on as a separate step.
> >>
> >> This commit uses this new ACPICA functions to fix the EC probe ordering
> >> by changing the acpi_bus_init() initialization order to this:
> >>
> >> 1. acpi_load_tables()
> >> 2. acpi_ec_ecdt_probe()
> >>    This now calls acpi_install_address_space_handler(ACPI_NO_EXEC__REG)
> >>    which installs the OpRegion handler without executing _REG
> >
> > I'm not sure if installing an opregion without evaluating _REG for it
> > is particularly useful.
>
> We already do this for the SystemMemory / SystemIO and PCI_Config OpRegions.
> The handlers for these get installed from acpi_enable_subsystem()
> and their _REG functions get called later from acpi_initialize_objects().
>
> This patch basically makes the EmbeddedControl OpRegion behave the
> same and according to the current code:

I think that the evaluation of _REG can be deferred in this case.

>
>         /*
>          * ACPI 2.0 requires the EC driver to be loaded and work before the EC
>          * device is found in the namespace.
>          *
>          * This is accomplished by looking for the ECDT table and getting the EC
>          * parameters out of that.
>          *
>          * Do that before calling acpi_initialize_objects() which may trigger EC
>          * address space accesses.
>          */
>         acpi_ec_ecdt_probe();
>
> This is mandated by ACPI-2.0 which also seems to match my analysis
> of this problem where on e.g. my Lenovo X1 carbon gen 8
> the \_SB.PCI0._INI method uses an EmbeddedControl OpRegion without
> any _REG related checks.
> > No AML should use it before _REG is evaluated anyway.
>
> See above, ACPI 2.x seems to allow this, like how it allows it
> for SystemIO / SystemMemory / PCI_Config. This seems to be the
> whole reason why there is a separate table describing the EC
> (the ECDT) so that the EC can be made available before any parsing
> of the DSDT has been done.
>
> So we need to have the OpRegion available before running the
> "early" _INI methods. And because of _REG relying on the OSYS
> GVNS variable in some cases, which gets set from _INI on the
> PCI root bridge, that means running _REG after running
> (some) _INI methods.

OK, so at least on some systems the EC address space will be accessed
regardless of the _REG for it.

> >> 3. acpi_enable_subsystem()
> >> 4. acpi_early_initialize_objects()
> >>    This calls the _INI method of the PCI and _SB root devices
> >
> > So this is a change in behavior that will affect every system using
> > ACPI on the planet, not just the ones where the problem at hand is
> > present.  This appears to be somewhat risky to me.
>
> The ACPICA code already calls \.INI and \_SB._INI at the start of
> acpi_initialize_objects(), before evalutating any _REG methods,
> so this call in itself is no a change.
>
> Except that \_SB.PCI0._INI and \_SB.PC0._INI are now also
> run early (patch 2/4).
> >> 5. acpi_ec_ecdt_exec_reg();
> >>    This executes the EC's _REG now that the root devices _INI has run
>
> This is the actual change moving the calling of _REG for the EC to after
> the running of the "early" _INI calls.
>
> >> 6. acpi_initialize_objects(ACPI_NO_EARLY_DEVICE_INIT)
> >>
> >> This allows the EC's _REG method to depend on e.g. the \OSYS global/GVNS
> >> variable often set by a root-device's _INI method, while at the same time
> >> allowing these _INI methods to access EmbeddedController OpRegions.
> >
> > I'm wondering if it is possible to change the ordering of
> > acpi_ec_ecdt_probe() or the part of it that installs the oprtegion
> > handler to be called later?
>
> Note splitting the install vs _REG calling of OpRegion handlers
> requires ACPICA changes (patch 3/4).
>
> Assuming those changes are in place then we could delay calling
> of _REG also until the actual acpi-ec driver binds. This would
> put it a lot later in the init sequence though. So that would
> be much more of a change to the ordering then done in this
> RFC series.
>
> I did consider this and I do think it makes sense to only call
> _REG once we actually have fully setup the ACPI device for
> the EC (rather then just parsed the ECDT as we do now), but
> it is a big change.

That's what I would like to do here.

> This would also put the _REG late enough that the _INI
> setting the OSYS variable has already run, avoiding
> the need for the "early" _INI calls from the EC _REG
> evaluation pov (1).
>
> If we go this route then acpi_bus_init() would not need any
> changes. In this case the changes would be:
>
> 1. Change  acpi_ec_ecdt_probe(); to only install the
> OpRegion handler and not call _REG
>
> 2. Call _REG from acpi_ec_add() before it calls
> acpi_dev_clear_dependencies(device);
>
> If you think that is better I can implement this and ask
> the reporter of:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=214899
>
> to give this new approach a test run.

Yes, please.
