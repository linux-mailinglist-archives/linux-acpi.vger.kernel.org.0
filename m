Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552B314C163
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 21:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgA1UGf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 15:06:35 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38725 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgA1UGf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jan 2020 15:06:35 -0500
Received: by mail-il1-f193.google.com with SMTP id f5so11871617ilq.5
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jan 2020 12:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18eMNLfWeTpjQI4b5ZYrk3XYyWX7tif+KJnemAbz9Dg=;
        b=e9NHPQxg8TyI9cf2QCmIh7v2zDsT4l/DdNfuGEiAW6PdtqC/cGN5+nDdPi+scGy8P7
         FBh7DCSbuVbLyy8gmc2fPo2C/SLhYW5c5NZTnNyIJOEQ8QMifNBcTLtd/yjX5FIfaWJH
         Gg4n8wNnfCJPoEEjkKUXOg4IAaICJhyTL2vNwM53gwWRHTO8I75oJ8eEeMUvSRDxqq1V
         zQ8T+KL0tvJnFFbWK1Enqmme4hdxOMjEdkAGKSm0LFeYHEpKmn95jU289EoYZJumExga
         ql/CbZWEdrsk/TgDwAR4IgdImKuJtg09a8CjpXhNzQOiLNKBvi8GUfV9KXSkX417Udo/
         dFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18eMNLfWeTpjQI4b5ZYrk3XYyWX7tif+KJnemAbz9Dg=;
        b=ViqWiX/oQSCqKymb7DfOq3Zw5GKPKMQ6vTmOeqavpgv2UGdKsWnw/Ebmazrtr4ZwXS
         S/NcLjqF6vUBsfMYXx5Q/bkUQlvVnLyMMRHWPKYBZ1fibIokGM6vS7Fl1voYY4c9cket
         TlAFT34l5k+PS6hpij3hlZ63xL9oaip15vcSRHweSaxi3Ufq5CvrX5WCkeN4PVqec22c
         HM/cuNZ7ONON3nxtzbKje1DGiCeZHpMvSKsxaCuMcZ5JDbpnjCC9ihAXtJbTup5psq5j
         QFvZ4MMZRGphDQrIs6+cEFesW80rO4iTTzf/vSDEJ+FiuJUvUQ9/DHaC9xvDuQoDm4WE
         x8Wg==
X-Gm-Message-State: APjAAAWMpgTsFMzeRqs2mkERpy93lrK4gDs3qOyqFj2bwQ6/l68GUb+B
        mJLW2K5X3NkUCke9fF0fgTr9lVSlG7K9yNaJtTMYhQ==
X-Google-Smtp-Source: APXvYqxy0fzH/avztxInoqB+8YhlTTkLEIRn1GEV9oB36rzB8eGeslSXkYuBGEBDvMzMnZeO86HexjRrQg2MzrrNkpE=
X-Received: by 2002:a92:ba8d:: with SMTP id t13mr21343880ill.207.1580241993195;
 Tue, 28 Jan 2020 12:06:33 -0800 (PST)
MIME-Version: 1.0
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
 <CAOesGMiCVSvL8H+haLoz=xyiX1CxBSRL_pbCgx-DLhN+5xRn9g@mail.gmail.com> <4c6462e3-e368-bd9f-260f-e8351c85bcc2@huawei.com>
In-Reply-To: <4c6462e3-e368-bd9f-260f-e8351c85bcc2@huawei.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 28 Jan 2020 12:06:21 -0800
Message-ID: <CAOesGMjrC=b781LLU-Btp1b9uKTiMXj8tF3rjK_Wy6Q4iaR+Rw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jeremy.linton@arm.com,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 28, 2020 at 10:22 AM John Garry <john.garry@huawei.com> wrote:
>
> On 28/01/2020 17:51, Olof Johansson wrote:
> > Hi,
> >
> > On Tue, Jan 28, 2020 at 3:18 AM John Garry <john.garry@huawei.com> wrote:
> >>
>
> Hi Olof,
>
> >> Add a generic driver for platforms which populate their ACPI PPTT
> >> processor package ID Type Structure according to suggestion in the ACPI
> >> spec - see ACPI 6.2, section 5.2.29.3 ID structure Type 2.
> >>
> >> The soc_id is from member LEVEL_2_ID.
> >>
> >> For this, we need to use a whitelist of platforms which are known to
> >> populate the structure as suggested.
> >>
> >> For now, only the vendor and soc_id fields are exposed.
> >>
> >> Signed-off-by: John Garry <john.garry@huawei.com>
> >> ---
> >>   drivers/soc/Makefile       |   1 +
> >>   drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 103 insertions(+)
> >>   create mode 100644 drivers/soc/acpi_generic.c
> >>
> >> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> >> index 8b49d782a1ab..2a59a30a22cd 100644
> >> --- a/drivers/soc/Makefile
> >> +++ b/drivers/soc/Makefile
> >> @@ -3,6 +3,7 @@
> >>   # Makefile for the Linux Kernel SOC specific device drivers.
> >>   #
> >>
> >> +obj-$(CONFIG_ACPI_PPTT)                += acpi_generic.o
> >>   obj-$(CONFIG_ARCH_ACTIONS)     += actions/
> >>   obj-$(CONFIG_SOC_ASPEED)       += aspeed/
> >>   obj-$(CONFIG_ARCH_AT91)                += atmel/
> >
> > Based on everything I've seen so far, this should go under drivers/acpi instead.
>
> soc drivers seem to live in drivers/soc (non-arm32, anyway), so I
> decided on this location. But drivers/acpi would also seem reasonable now.

We don't want drivers/soc to be too much of a catch-all -- it is meant
for some of the glue pieces that don't have good homes elsewhere.
Unfortunately, the slope is slippery and we've already gone down it a
bit, but I think we can fairly clearly declare that this kind of
cross-soc material is likely not the right home for it -- especially
when drivers/acpi is a good fit in this case.

> >> diff --git a/drivers/soc/acpi_generic.c b/drivers/soc/acpi_generic.c
> >> new file mode 100644
> >> index 000000000000..34a1f5f8e063
> >> --- /dev/null
> >> +++ b/drivers/soc/acpi_generic.c
> >> @@ -0,0 +1,102 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) John Garry, john.garry@huawei.com
> >> + */
> >> +
> >> +#define pr_fmt(fmt) "SOC ACPI GENERIC: " fmt
> >> +
> >> +#include <linux/acpi.h>
> >> +#include <linux/sys_soc.h>
> >> +
> >> +/*
> >> + * Known platforms that fill in PPTT package ID structures according to
> >> + * ACPI spec examples, that being:
> >> + * - Custom driver attribute is in ID Type Structure VENDOR_ID member
> >> + * - SoC id is in ID Type Structure LEVEL_2_ID member
> >> + *    See ACPI SPEC 6.2 Table 5-154 for PPTT ID Type Structure
> >> + */
> >> +static struct acpi_platform_list plat_list[] = {
> >> +       {"HISI  ", "HIP08   ", 0, ACPI_SIG_PPTT, all_versions},
> >> +       { } /* End */
> >> +};
> >
> > As others have said, this will become a mess over time, and will
> > require changes for every new platform. Which, unfortunately, is
> > exactly what ACPI is supposed to provide relief from by making
> > standardized platforms... standardized.
> >
>
> Right, and I think that it can be dropped. As discussed with Sudeep, I
> was concerned how this PPTT ID structure could be interpreted, and had a
> whitelist as a conservative approach.

[...]

> >
> > Hmm, this doesn't look like much of a driver to me. This looks like
> > the export of an attribute to userspace, and should probably be done
> > by ACPI core instead of creating an empty driver for it.
>
> OK, but I'm thinking that having a soc driver can be useful as it is
> common to DT, and so userspace only has to check a single location. And
> the soc driver can also cover multiple-chip systems without have to
> reinvent that code for ACPI core. And it saves adding a new ABI.

While having a single location could be convenient, the actual data
read/written would be different (I'm guessing).

We also already have a supposed standard way of figuring out what SoC
we're on (toplevel compatible for the DT). So no matter what, I think
userspace will need to handle two ways of probing this.


-Olof
