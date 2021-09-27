Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB68419D1C
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Sep 2021 19:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbhI0Rmg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Sep 2021 13:42:36 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46704 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbhI0Rm2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Sep 2021 13:42:28 -0400
Received: by mail-ot1-f48.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so23394528ota.13;
        Mon, 27 Sep 2021 10:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReDnciwg/+ZMGoshRJwdAfBnyqdW0VDe0TXow0FXcLA=;
        b=Nn0Y8CfNIZ4rHdbEiG258aUKeyQHbmR3Ulkguv+bR1QFwVTyI9AssHZPEDiD4JlD1O
         JMyjqJdnCJq8DTCZOUoGcsxL/1UJQeiIiB4BafsEyyX45WlHQbBVzR7mqnQWifelZ5a2
         FzJyMFNJQ2+dH3U9swuo0u9+YhHWSdneDB3ZPXAh/yj0MaLKJdCj3lL/UI6qFlvKM1u4
         SYcO5eAhrh5h5CKnLaOISV+Hh6SU59ipgYCM4qtL1nLu4Y6JeT7AJxpDc7cThcn94fY0
         7v1D7ZJFczX4hP4ESl5V2+L1Lklctb0Us/cPBI9suB9Eg86mqwN0vl++11nKPiOaAnv6
         9Wng==
X-Gm-Message-State: AOAM533XoGSFt3iDZI7II8nteGKu/ysCkokUPhJzYzO2SKESTOTvNoNk
        U48SRKAh4IdA4FJmOl7VLBnNaROCMeOpDiruHfA=
X-Google-Smtp-Source: ABdhPJxEMr3EWbQ/5Dsh68KL6ft07WTkBOMoAPRbne7cEb0ROD9G9YbWkoJTxsIMmSVXJBGY5N4Gza+nRRT7T3kmHLE=
X-Received: by 2002:a05:6830:82b:: with SMTP id t11mr1078813ots.319.1632764450212;
 Mon, 27 Sep 2021 10:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631802162.git.yu.c.chen@intel.com> <90d270c031401430445cb2c4ba1b9b0c265cf9d4.1631802163.git.yu.c.chen@intel.com>
 <YUoBSRrAyaHOCNHb@kroah.com> <20210922090442.GA16963@chenyu5-mobl1>
 <YUry6tzScXMD007X@kroah.com> <20210922163321.GA31068@chenyu5-mobl1> <YUtnuW22MH97p7+G@kroah.com>
In-Reply-To: <YUtnuW22MH97p7+G@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Sep 2021 19:40:39 +0200
Message-ID: <CAJZ5v0gDHA34a+4pO7Pb8=wc7FPiMvDj9k7WrO0Cc8mcMNzMxg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 22, 2021 at 7:28 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 23, 2021 at 12:33:21AM +0800, Chen Yu wrote:
> > On Wed, Sep 22, 2021 at 11:10:02AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Sep 22, 2021 at 05:04:42PM +0800, Chen Yu wrote:
> > > > Hi Greg,
> > > > On Tue, Sep 21, 2021 at 05:59:05PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Sep 17, 2021 at 12:02:18AM +0800, Chen Yu wrote:
> > > > > > Introduce the pfru_update driver which can be used for Platform Firmware
> > > > > > Runtime code injection and driver update. The user is expected to provide
> > > > > > the update firmware in the form of capsule file, and pass it to the driver
> > > > > > via ioctl. Then the driver would hand this capsule file to the Platform
> > > > > > Firmware Runtime Update via the ACPI device _DSM method. At last the low
> > > > > > level Management Mode would do the firmware update.
> > > > > >
> > > > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > >
> > > > > Where is the userspace code that uses this ioctl and has tested it out
> > > > > to verify it works properly?  A link to that in the changelog would be
> > > > > great to have.
> > > > >
> > > > The patch [5/5] is a self testing tool to test the whole feature. I'll send a
> > > > new version and Cc you too.
> > >
> > > That tests it, but does not answer the question of who will actually use
> > > this.  What userspace tool needs this new api?
> > >
> > One end user is the cloud user.
>
> What exactly do you mean by "cloud user"?
>
> > Currently there is no dedicated userspace tool developed to use this
> > feature AFAIK.
>
> Wonderful, then it is not needed to be added to the kernel :)
>
> > It was expected that the end users
> > could refer to the self test tool to customize their tools. I'm not sure if
> > this is the proper way to propose the feature, may I have your suggestion on
> > this, should I create a separate git repository for this tool, or put it in
> > tools/selftestings as it is now?
>
> No, do not add this to the kernel unless you have a real need and user
> for this.
>
>
> > > > > > +static struct miscdevice pfru_misc_dev = {
> > > > > > +     .minor = MISC_DYNAMIC_MINOR,
> > > > > > +     .name = "pfru_update",
> > > > > > +     .nodename = "pfru/update",
> > > > >
> > > > > Why is this in a subdirectory?  What requires this?  Why not just
> > > > > "pfru"?
> > > > >
> > > > The pfru directory might be reused for pfru_telemetry device, whose driver
> > > > is in 4/5 patch, I'll Cc you with the whole patch set in next version.
> > >
> > > "might be" is not a valid reason.  Why does this simple driver deserve a
> > > whole /dev/ subdirectory?
> > >
> > There are pfru_update and pfru_telemetry in the patch, and there is plan to
> > add a pfru_prm device in the future, which stands for "Platform Runtime Mechanism".
> > I'll move them to /dev/ in next version.
>
> That is a very generic name for a very platform specific and arch
> specific interface.  As this is an ACPI interface, why not use that name
> prefix?

It is not supposed to be either arch-specific or platform-specific.
The spec is hosted by the UEFI Forum and it is fairly generic IIUC.
In principle, it could be used to update any kind of platform firmware
possible to update without system restart.

That said, the I/F to the platform firmware is based on ACPI methods,
so "acpi_" would be a reasonable prefix choice.
