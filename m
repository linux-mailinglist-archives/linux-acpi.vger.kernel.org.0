Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97CC301849
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Jan 2021 21:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbhAWUMm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Sat, 23 Jan 2021 15:12:42 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39614 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbhAWUM2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Jan 2021 15:12:28 -0500
Received: by mail-ot1-f45.google.com with SMTP id i30so8763247ota.6
        for <linux-acpi@vger.kernel.org>; Sat, 23 Jan 2021 12:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jQxhocxA91sIH2Hl2zGB7Xk97EyjrHZEvCAcN3xczrc=;
        b=OpDnrmNIsgSjKq2tb8lOZ5PmrXtvgakxdvVTtVlxr++7xed9DRCEhvCLOtbmKrsYq9
         PW5h+ekObkX+pXRJOlTFjztYtPUOOeBmCJ0QRiiyJeAOMntkO1qtJU8n0NMni9KODfYH
         YQ5bByRaICR/jKnigNOxyVWgeuU36MdwpyGUNJKyUuxbraZLGcpQY3/7DhldpNW9akyj
         vvhnBNWdIfye1zUHBvMBtzovJ02xyUuP55jtD9evSYkZ2rCNCenA9FYmKjYMghTAqJNj
         n0+LZfMftIe/Ur8HQe3ql0iAiBj7l1NNboiVDSBnaJlozRFZu1keKP8IqSR/s/jSR4VC
         TewQ==
X-Gm-Message-State: AOAM533oxsDwPsOQCPcn2u4vkLS6xdvdEEBbuwLTxyticzSBhWGiV/Jh
        JMTE4KMio/9c7mRZWw6qNZ9mSHTReIT+RdIsMe0=
X-Google-Smtp-Source: ABdhPJzKnuNL2Bga0eMURd7ZzV6MKoCG3AJH2HI6S+4UYcd4OfzQutvSlPSQ0Ram6y8+DDoWW7rabcBrvKkyrzJRgbo=
X-Received: by 2002:a9d:1710:: with SMTP id i16mr7457872ota.260.1611432707264;
 Sat, 23 Jan 2021 12:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20210122002357.370836-4-erik.kaneda@intel.com>
 <20210123152104.GA36465@roeck-us.net> <20210123152520.GA41373@roeck-us.net>
In-Reply-To: <20210123152520.GA41373@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 23 Jan 2021 21:11:35 +0100
Message-ID: <CAJZ5v0hnNqOM=0N2MUo_3YXke3pC5Qv=5mo6bCOmHBC6L6J=Cg@mail.gmail.com>
Subject: Re: [v2,3/9] ACPICA: ACPICA: fix -Wfallthrough
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jan 23, 2021 at 4:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Sat, Jan 23, 2021 at 07:21:04AM -0800, Guenter Roeck wrote:
> > On Thu, Jan 21, 2021 at 04:23:51PM -0800, Erik Kaneda wrote:
> > > From: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > ACPICA commit 4b9135f5774caa796ddf826448811e8e7f08ef2f
> > >
> > > GCC 7.1 gained -Wimplicit-fallthrough to warn on implicit fallthrough,
> > > as well as __attribute__((__fallthrough__)) and comments to explicitly
> > > denote that cases of fallthrough were intentional. Clang also supports
> > > this warning and statement attribute, but not the comment form.
> > >
> > > Robert Moore provides additional context about the lint comments being
> > > removed. They were for "an old version of PC-Lint, which we don't use
> > > anymore." Drop those.
> > >
> > > This will help us enable -Wimplicit-fallthrough throughout the Linux
> > > kernel.
> > >
> > > Suggested-by: Robert Moore <robert.moore@intel.com>
> > > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > >
> > > Link: https://github.com/acpica/acpica/commit/4b9135f5
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > > Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
> >
> > With gcc 6.5 (and presumably each gcc version older than 7.1),
> > this patch results in:
> >
> > drivers/acpi/acpica/dscontrol.c: In function ‘acpi_ds_exec_begin_control_op’:
> > drivers/acpi/acpica/dscontrol.c:65:3: error: ‘ACPI_FALLTHROUGH’ undeclared
> >
> > and similar errors for other files.
> >
>
> Wait, this differs from the patch in -next.
>
> > > +#ifndef ACPI_FALLTHROUGH
> > > +#define ACPI_FALLTHROUGH do {} while(0)
>
> This line is missing in -next.
>
> v2 doesn't say what changed in v2. Is that the change ?

Yes, it is.

It should appear in -next on Monday.
