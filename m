Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3854E59FD
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 21:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbiCWUld (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Mar 2022 16:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242660AbiCWUlc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2022 16:41:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CE28BF18
        for <linux-acpi@vger.kernel.org>; Wed, 23 Mar 2022 13:40:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so2693999plg.5
        for <linux-acpi@vger.kernel.org>; Wed, 23 Mar 2022 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=joaiPi82mBm5ydpjd+lSBaTz0Xb4/xDRfIZaQDGqVyI=;
        b=BbVLZa2jS0qTk7ys5RPPQ9Cq3/eIL++KpUJE2ooJuHAwY81hX2hFxen/BzhW2ITBQC
         xzDb97S+s/BwYPL/C1QPEiOYv68gPHxgi/OKqsYYEfZjhzbu4xJVpF6WXm+Y3rw8QX+p
         1C6MY1MJIgK7P/auX21rKnngUv7n2W6Lkp8UYyn6UUO7ZP2XLAIojCdleiE4JxCgRJUI
         OTdJ6M+Vte5DuOB7QBAapim7XGWx0OQBgoDJzcH24TY1jcwJjkkRswW6DRppZdz61NWL
         RyVr6oFYOQT473wNbuXc5RSzz0SlCnlsyZ76OXQ3db6UX1gpIDgvWwywPe7FdbJgv9Co
         +O4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joaiPi82mBm5ydpjd+lSBaTz0Xb4/xDRfIZaQDGqVyI=;
        b=yBVeT1bpQKSlBDS52WU+1Y/19574kMzjU92bfB9QtW26bHpUZumeZM4d9j3PSeEw+w
         xUb1ipn2JjI2JjnS8K5bGrEmYlGB+9aTZp526Y+pr9eOnqaoD+zZUxqifa707Ar7+dBX
         FxJaKZzNJgxXeA3UukUjHIXyRkhfN6+WwSeHjSl5BrwnosF4JVHULqKtGyvWMOWb2+WG
         zEXWJAtwvH+cFtQdDJKRGdraB9czhLVKzOofazD5/X9lk44sxQbhDEKM2eaR15WV7c2J
         8gMqDKhKTqIQwU1h3dIjgyogAhbSp1hdKzaM4tKRYXzLqlV5OHA8GQ3TxDSGm4cJ/XaV
         71FA==
X-Gm-Message-State: AOAM533MFUYVJwP1o/4xNVnj8PPCVKdUYpdrZ4JTY+w56y7uHrIPtJQq
        b6HVZSkE6gO8paVZfVeaoVN/WnGklJYq9b7tUZ6Axw==
X-Google-Smtp-Source: ABdhPJzOvC4uT3Sm8xOvJVvlftlVpR9jhvGsfNcyBHbOyh8PLo56Ig00CJc523O4ahhmY7LAlQF3WTemYE+ZAu/jZUQ=
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr1736190pjg.93.1648068001760; Wed, 23
 Mar 2022 13:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220318213004.2287428-1-vishal.l.verma@intel.com>
 <20220318213004.2287428-2-vishal.l.verma@intel.com> <CAJZ5v0j42Fd4X=GEHDMS6_bxcaT8ncU5vh6+pUjCGhGrD9U0vA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j42Fd4X=GEHDMS6_bxcaT8ncU5vh6+pUjCGhGrD9U0vA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 23 Mar 2022 13:39:54 -0700
Message-ID: <CAPcyv4h4djKTZLmTQsiCsyKUfzBd_KXEfCo9AoRSJasLo+Ac0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 23, 2022 at 12:24 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Mar 18, 2022 at 10:30 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> >
> > From: Dan Williams <dan.j.williams@intel.com>
> >
> > Rather than pass a boolean flag alongside @root to all the helper
> > functions that need to consider PCIe specifics, add is_pcie() and
> > is_cxl() helper functions to check the flavor of @root. This also
> > allows for dynamic fallback to PCIe _OSC in cases where an attempt to
> > use CXL _OXC fails. This can happen on CXL 1.1 platforms that publish
> > ACPI0016 devices to indicate CXL host bridges, but do not publish the
> > optional CXL _OSC method. CXL _OSC is mandatory for CXL 2.0 hosts.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Robert Moore <robert.moore@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > ---
> >  include/acpi/acpi_bus.h |  1 +
> >  drivers/acpi/pci_root.c | 62 +++++++++++++++++++++++++++++++----------
> >  2 files changed, 48 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index ca88c4706f2b..768ef1584055 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -585,6 +585,7 @@ struct acpi_pci_root {
> >         struct acpi_device * device;
> >         struct pci_bus *bus;
> >         u16 segment;
> > +       bool cxl_osc_disable;
> >         struct resource secondary;      /* downstream bus range */
> >
> >         u32 osc_support_set;    /* _OSC state of support bits */
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index b76db99cced3..2d834504096b 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -170,20 +170,47 @@ static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
> >                         ARRAY_SIZE(pci_osc_control_bit));
> >  }
> >
> > -static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
> > +static bool is_pcie(struct acpi_pci_root *root)
> > +{
> > +       return strcmp(acpi_device_hid(root->device), "PNP0A08") == 0;
> > +}
> >
> > -static acpi_status acpi_pci_run_osc(acpi_handle handle,
> > +static bool is_cxl(struct acpi_pci_root *root)
> > +{
> > +       if (root->cxl_osc_disable)
> > +               return false;
> > +       return strcmp(acpi_device_hid(root->device), "ACPI0016") == 0;
>
> One more thing.
>
> This will cause the device ID matching to take place every time
> is_cxl() is called which seems a bit excessive to me (and the same
> applies to the PCIe counterpart).
>
> IMV it would make sense to have a "bridge_type" field instead of
> cxl_osc_disable in acpi_pci_root and use that for all of the checks.
>
> Moreover, IIUC every CXL bridge is also a PCIe one, so the
> "bridge_type" could be say 1 for PCIe and 2 for CXL and checks like
> "bridge_type >= PCIe" would cover both these types then.

Sounds good, I like it.
