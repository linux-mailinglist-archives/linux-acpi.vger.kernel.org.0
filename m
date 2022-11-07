Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029BD61FDAB
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Nov 2022 19:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiKGShF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Nov 2022 13:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiKGSg3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Nov 2022 13:36:29 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C882714D
        for <linux-acpi@vger.kernel.org>; Mon,  7 Nov 2022 10:36:22 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 4so11901731pli.0
        for <linux-acpi@vger.kernel.org>; Mon, 07 Nov 2022 10:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/yoRrsDL4rjZUsiXxqy6NkYQLHd5ebMM1o8RAy5KU7k=;
        b=Esfsrl296DK0gl8bWsolF/ZyGX0HPlftAEWIoja/4VX/5Q6Kcx1dlwnI5YXcw55HQP
         RXXZ9jJcIW+a7KYCQyZ9OE8qexU2K0Rz/STr7a0eVefP+Uhg6arVNVzfK17vesBxIsZf
         9xVhEy4I+4Gm4qroCe+CNKqgak+NCJAvddY8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yoRrsDL4rjZUsiXxqy6NkYQLHd5ebMM1o8RAy5KU7k=;
        b=HEW0sE6iapEeJd+Em1OMDCywwtt8AKgmzIuc5P4XFsuYID1wkhOdKKXJvg8VTfQ7pk
         Nw3mu6Jzh0PRPk4d1hEVFtIHhcyst307X12dhGaRnrjU2zjgz/Nw/YMmauY4OkKluvXk
         KA197APJXiejdIYDlXtWLalHzPyB/PqdX1PAyUovqTSw1dYxk7SzFSmFV7G0ec05pQwp
         Nj6YG/5CNI3PFpplF7xfyFwtbFrGXGUc6gE5V8tnUai58L52C+8kmIQeo/Uo3rSuMDJk
         gsDwjKP++eT43Tc0LlSfYjmVwNAiBznQg94YMzzxzTpHkk/1braLko6YQsprRi4s+1Sr
         JQLA==
X-Gm-Message-State: ACrzQf3owAvA0d6JhSW5qDoGs340VayeOLCDJKHrdxl4HbB0EbhoWuDY
        biI068ki8qMdNx4rFEzDrTAoDDG+8wqe6A==
X-Google-Smtp-Source: AMsMyM5WrxdahpdRgxoamXKPt2qClJ9I6U48+cDCJSolm/EEj3NnsM6TTaWD47FJhYQy/BqAb5FVQw==
X-Received: by 2002:a17:90a:8d15:b0:216:df8f:3de with SMTP id c21-20020a17090a8d1500b00216df8f03demr20702418pjo.80.1667846181494;
        Mon, 07 Nov 2022 10:36:21 -0800 (PST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com. [209.85.215.178])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7973a000000b0056da2ad6503sm4837294pfg.39.2022.11.07.10.36.19
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 10:36:19 -0800 (PST)
Received: by mail-pg1-f178.google.com with SMTP id s196so11220408pgs.3
        for <linux-acpi@vger.kernel.org>; Mon, 07 Nov 2022 10:36:19 -0800 (PST)
X-Received: by 2002:aa7:8d17:0:b0:560:485a:e242 with SMTP id
 j23-20020aa78d17000000b00560485ae242mr51617419pfe.31.1667846178911; Mon, 07
 Nov 2022 10:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
 <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com>
 <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
 <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
 <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com>
 <YzYowYJpRTImmg4m@google.com> <CAJZ5v0i+QYcMuqsK9y6qy9qzJdUp503Sidr1e4V_ROyumLKCsw@mail.gmail.com>
 <YzcqdTxLMF5028yz@smile.fi.intel.com> <YzcthIfnpi8E6XVk@google.com>
 <CAJZ5v0iKXWBGYPmmg9__g3oHK2GhY+xFMnSA6c5KctOv2kTfNQ@mail.gmail.com> <CAHQZ30D0NmVytkmiVYYZdGMEOChsO93hYRrG6SNbFiRO4S=YGA@mail.gmail.com>
In-Reply-To: <CAHQZ30D0NmVytkmiVYYZdGMEOChsO93hYRrG6SNbFiRO4S=YGA@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 7 Nov 2022 11:36:07 -0700
X-Gmail-Original-Message-ID: <CAHQZ30D-vBHQG9tDXy_upKHzfFMA9ttUT72K4hqKNS+CtEek3w@mail.gmail.com>
Message-ID: <CAHQZ30D-vBHQG9tDXy_upKHzfFMA9ttUT72K4hqKNS+CtEek3w@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
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
        llvm@lists.linux.dev, Alexis Savery <asavery@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 17, 2022 at 8:53 AM Raul Rangel <rrangel@chromium.org> wrote:
>
> On Sat, Oct 15, 2022 at 10:56 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Sep 30, 2022 at 7:55 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Fri, Sep 30, 2022 at 08:42:13PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Sep 30, 2022 at 07:13:37PM +0200, Rafael J. Wysocki wrote:
> > > > > On Fri, Sep 30, 2022 at 1:22 AM Dmitry Torokhov
> > > > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > ...
> > > >
> > > > > I think that patches [5-8/13] from this series are significant
> > > > > framework changes, so it would make sense to route them via the ACPI
> > > > > tree.
> > > > >
> > > > > If this is fine with everybody, I will queue them up for merging into
> > > > > 6.1 (probably in the second half of the upcoming merge window).
> > > >
> > > > I believe it's fine from GPIO ACPI perspective (there shouldn't be conflict,
> > > > but if you wish you always may take this PR [1] to your tree (it's already in
> > > > GPIO tree pending v6.1), it may be considered as immutable tag.
> > > >
> > > > [1]: https://lore.kernel.org/linux-gpio/Yym%2Fj+Y9MBOIhWtK@black.fi.intel.com/
> > >
> > > Yeah, having an immutable branch hanging off 6.0-rcN would be awesome -
> > > I could pull it and this would avoid any potential conflicts later.
> >
> > This material is in the mainline now, but the branch is still there in
> > case you need it:
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  acpi-wakeup
> >
> > It won't be necessary any more after 6.1-rc1 is out, though, I suppose.
>

>
> Awesome, thanks for merging in the ACPI patches!

Dmitry,
 What are the next steps to getting the I2C patches landed? Should I
push out a new series that's rebased on 6.1-rc1?
