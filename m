Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82012ED125
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbhAGNsw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:48:52 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:34719 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbhAGNsw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:48:52 -0500
Received: by mail-ot1-f50.google.com with SMTP id a109so6314199otc.1;
        Thu, 07 Jan 2021 05:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxOc7uHglOoDfD1fFSW1c40P0G5PgpxQwefSb6uXKX0=;
        b=UGg5UZQVM3Gi3eSa+RqFiRAjA0wgmqpMLEiRDydpJ1RDflXwLZTe41E2UkIeTwCi8e
         xTrZ9uLl0rb+hJGJGiyyDurN1MJuVrfDxKVeUMgL1i2y63VoPCg4PE4ef1LBFnxSSF3U
         KEgWVHF5BhQUtFEJuM5qqtUFjhdH3KIx84gCt8fprQEoXB3UY5Vs8FSHjSb06rhjDYoh
         b9Wy02YPn/wLDG7kB5WCaNITGOdyQPEd11LC4vqys5+cxrk7RHKLLlOhDJhqqWiy8OW5
         tyuCh0Py8IC0wcd08cPbp/JXQY2drkeYFwYYb3aKFHHgsR6DSq3j9rbEnGIIESoUj0XL
         UiAQ==
X-Gm-Message-State: AOAM530XbL94yaYQbqD8Hy3dTrXjXu+SYS5llrkPc7EzL2Sm39GPoQof
        4WSSDUOU+wtyARYkZxWZEPHXm6Pe/ppBf6kV5xE=
X-Google-Smtp-Source: ABdhPJyeJqQC2tPO8m/QCgSqmxuUOkbOdB4YBKAgAsShfPvmNBRfDYkobds4iz78u9E8W5YARno4ZTrC0ocfJuWSqzs=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr6538983ota.260.1610027290930;
 Thu, 07 Jan 2021 05:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20201218040826.57203-1-decui@microsoft.com> <MW2PR2101MB1052E61BEB80F14896EEFA79D7DF9@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <MW2PR2101MB181943C255A86A11E5402E50BFD19@MW2PR2101MB1819.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB181943C255A86A11E5402E50BFD19@MW2PR2101MB1819.namprd21.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jan 2021 14:47:34 +0100
Message-ID: <CAJZ5v0gXW0oEmduxZEc0BZWxfQd=+jh_r88OZAHmwCW=GFNBGg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by buffer overflow
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 5, 2021 at 11:02 PM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Michael Kelley <mikelley@microsoft.com>
> > Sent: Tuesday, December 22, 2020 5:56 AM
> > From: Dexuan Cui
> > Sent: Thursday, December 17, 2020
> > 8:08 PM
> > >
> > > Linux VM on Hyper-V crashes with the latest mainline:
> > > ...
> > > --- a/drivers/acpi/scan.c
> > > +++ b/drivers/acpi/scan.c
> > > @@ -674,7 +674,8 @@ int acpi_device_add(struct acpi_device *device,
> > >     }
> > >     if (!found) {
> > >             acpi_device_bus_id = new_bus_id;
> > > -           strcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device));
> > > +           strlcpy(acpi_device_bus_id->bus_id, acpi_device_hid(device),
> > > +                   sizeof(acpi_device_bus_id->bus_id));
> > >             acpi_device_bus_id->instance_no = 0;
> > >             list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
> > >     }
> >
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>
> Hi, ACPI maintainers,
> Would you please take a look at the small fix? Currently the mainline Linux
> kernel, running in a VM on Hyper-V, has been broken for almost 3 weeks,
> i.e. the VM always panics when it boots.

The root cause is a VM issue AFAICS, though.

> The patch has already had Michael's Reviewed-by.
>
> BTW, the patch should have a stable tag:
> Cc: <stable@vger.kernel.org>
>
> Or, do you want the patch to go through the Hyper-V tree?
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-fixes
>
> The small patch is unlikely to cause a merge conflict, and it only affects
> Linux VMs on Hyper-V so far.

It doesn't look like the right fix to me, though.

The problem appears to be that the string coming from _HID is too long
(which is a spec violation).  The patch truncates it to match the
length of the target buffer, but that is not particularly useful.

It would be better to use something like kstrdup_const() to initialize
acpi_device_bus_id->bus_id IMV.
