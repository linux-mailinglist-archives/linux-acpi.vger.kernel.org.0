Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58CC5EFF43
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Sep 2022 23:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiI2V1s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Sep 2022 17:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiI2V1f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2022 17:27:35 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADB9146FB5
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 14:27:33 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v4so2523627pgi.10
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hVuUBdHRNun2PF1xzmThnbMizdtrsxsLtgkxiMk9ltY=;
        b=W+2EuiiJpqD/S2h8tV/F6pXSQKY+JUj+Vneixxc62ca+jIwCSRL0WQWdUXYadGg80b
         Y1OwBqrTPzS1SR00oFZx0dsVjbzSdVSMoDQCcx7C5dbUvFQxq/SMsLCcM79OLEM4Y7uD
         JZwZF1e6iquZYjlkdPOzpWGIvlJgtu+wY6SsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVuUBdHRNun2PF1xzmThnbMizdtrsxsLtgkxiMk9ltY=;
        b=7OeAhy72kMJ6CnXrCYKBLBWnsjT4MKOzIdkkmg3MY0D/LezuJ926/1IKr8atpt4RxC
         FITg4ZvMoqGkroOmAhppyLN2AXCIMz1S0k0fY1Ab3w/WVP+B63M9m5QOP6GdPOWsZYgB
         dTyj9dbeM+CGHsfpfJXLVo5kF70oKx+aJld+MkXeOVM7Lj8Aox6hWhp7OkitMUo0Uzj9
         0UAWVrxyQdnbnmco/0VYqITj7p4vCJPljfmr3R7+3qKchBOTd9ym7LKPHAzLrZFN2ANR
         QMp4lQJHv4A7TvMVT/sbY3lTiFCfGBcshBkvVb89+7PRBwMSxe/7gbEY1zn7SagsAv3N
         1buw==
X-Gm-Message-State: ACrzQf2PfhmvKBAUFcaEX5brYIS+TK0658UMvyEK/UOI+0GfdyEPEOCY
        uQOluESt8fHks5AzYjC6BHa3vOfKb1zRZA==
X-Google-Smtp-Source: AMsMyM5O+bbI8y6dXKDTT3btfQFqvkuYgASXYF1ixJhhj3FgfVPBQuHq8G+xv5RrYcCTYzUIFtE6fA==
X-Received: by 2002:a63:a18:0:b0:43b:e1c8:fdae with SMTP id 24-20020a630a18000000b0043be1c8fdaemr4500779pgk.163.1664486853191;
        Thu, 29 Sep 2022 14:27:33 -0700 (PDT)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com. [209.85.210.176])
        by smtp.gmail.com with ESMTPSA id p8-20020a635b08000000b0043bed49f31fsm388191pgb.8.2022.09.29.14.27.32
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 14:27:32 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id b23so2531622pfp.9
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 14:27:32 -0700 (PDT)
X-Received: by 2002:a63:ff1b:0:b0:43c:e4ee:e5e0 with SMTP id
 k27-20020a63ff1b000000b0043ce4eee5e0mr4439543pgi.540.1664486423681; Thu, 29
 Sep 2022 14:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
 <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com>
 <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com> <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Thu, 29 Sep 2022 15:20:12 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com>
Message-ID: <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Terry Bowman <terry.bowman@amd.com>, Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 29, 2022 at 1:38 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Sep 29, 2022 at 9:27 PM Raul Rangel <rrangel@chromium.org> wrote:
> >
> > On Thu, Sep 29, 2022 at 1:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Sep 29, 2022 at 6:19 PM Raul E Rangel <rrangel@chromium.org> wrote:
> > > >
> > > > ACPI IRQ/Interrupt resources contain a bit that describes if the
> > > > interrupt should wake the system. This change exposes that bit via
> > > > a new IORESOURCE_IRQ_WAKECAPABLE flag. Drivers should check this flag
> > >
> > > I would call this IORESOURCE_IRQ_WAKE which is (a) simpler and easier
> > > to read and (b) it sort of matches the "wakeirq" naming convention.
> >
> > It was Dmitry who originally suggested the name. I personally like the
> > CAPABLE in the name. It makes it clear that it's capable of acting as
> > a wake source, not to be confused with being enabled as a wake source.
>
> Well, so be it then.
>
> As I said elsewhere, I can apply this patch too if that's useful at this point.
>

We just need to make sure the ACPI patches 5-8 land before the i2c
patches 9-13. The i2c patches 1-4 can land before or after the ACPI
changes. I'm not sure how things get coordinated across subsystems.

> > >
> > > This is not a big deal if you insist on this name and for a good
> > > reason, but just something I would do differently.
> > >
> > > The patch LGTM otherwise.
> > >
