Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC95675B530
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jul 2023 19:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjGTRFS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 20 Jul 2023 13:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGTRFR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2023 13:05:17 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49950119
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jul 2023 10:05:16 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b951a1a03bso3336821fa.0
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jul 2023 10:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689872714; x=1690477514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOCOtJMaLxWvXY+b/WEe6iz7/ROVGwSFcbRG70Sn7AU=;
        b=Z2+huMjBtwpNQiCL+ofcVR/OCh/OmK4Aek2CCK2+OBB33ACAb0aelhtOcu07WFFbFR
         JKLt2HxTuVVhJbbnw9pKdhKbEmIwJoLJXzHTHQxauRpfsjVN+B0uc/On1HrNN/9qba+w
         ivCMjY5L+NmjxgmfUotKduaeMlZSumrSdGmPxsKzvSSnemdlUrrKyNmw6zzxLiFaglEX
         E5OHW4hBrgdpBVCmWvDEeHb9UpXa3XMp1ZzzLPDNAol/GZ1SqBMIn+sUgZpJlhU8TE6n
         ftREtQtlbdM1Wiv7GEJtzVfpqEbTd2AYnVqygyy5CnmOTrt5F4VSs1ML1yGU8YESnxHP
         HJDQ==
X-Gm-Message-State: ABy/qLYbP7j0UoqW58EWR1RoX97WVro6/HSsz+ydfCXlkeAGLRoebceH
        wcepHVlHEG3vE+mzibiCDQ/pVvs4ZvaNAmiKEqM=
X-Google-Smtp-Source: APBJJlFf97CQAAEef/8WsUxqBCTK0uCjDEOWlhIrzA2bAGALLAD20W5OGPXZKcJu0K8i2tv189YS1CltJcOAmVAkzZM=
X-Received: by 2002:a2e:a5c9:0:b0:2b9:4bc3:c367 with SMTP id
 n9-20020a2ea5c9000000b002b94bc3c367mr3016577ljp.5.1689872714130; Thu, 20 Jul
 2023 10:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230717150047.15196-1-cezary.rojewski@intel.com>
 <20230717150047.15196-3-cezary.rojewski@intel.com> <4af468ff-6b87-962d-8629-52bb7d9ee340@intel.com>
 <ZLgDDB7vH/4FaI06@smile.fi.intel.com> <820d5447-a491-f052-a1f1-939fc9c283bf@intel.com>
 <CAJZ5v0gZLwJF78JZG4-ETEyr=_X41ude5ebuM+GE1xHhS_0PYA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gZLwJF78JZG4-ETEyr=_X41ude5ebuM+GE1xHhS_0PYA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jul 2023 19:05:03 +0200
Message-ID: <CAJZ5v0goKBLxQO6hJq8Gpj-JEb9D1YuXHWyzwyr9YV4iEBteig@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ACPI: NHLT: Introduce acpi_gbl_NHLT
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     linux-acpi@vger.kernel.org, robert.moore@intel.com,
        pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 20, 2023 at 7:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jul 20, 2023 at 11:15 AM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:
> >
> > On 2023-07-19 5:36 PM, Andy Shevchenko wrote:
> > > On Wed, Jul 19, 2023 at 04:47:31PM +0200, Cezary Rojewski wrote:
> > >> On 2023-07-17 5:00 PM, Cezary Rojewski wrote:
> >
> > ...
> >
> > >>> +++ b/drivers/acpi/nhlt.c
> > >>> @@ -0,0 +1,13 @@
> > >>> +// SPDX-License-Identifier: GPL-2.0-only
> > >>> +//
> > >>> +// Copyright(c) 2023 Intel Corporation. All rights reserved.
> > >>> +//
> > >>> +// Authors: Cezary Rojewski <cezary.rojewski@intel.com>
> > >>> +//          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
> > >>> +//
> > >>> +
> > >>> +#include <linux/export.h>
> > >>> +#include <acpi/nhlt.h>
> > >>> +
> > >>> +struct acpi_table_nhlt *acpi_gbl_NHLT;
> > >>> +EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);
> > >>
> > >> This approach generates a problem with undefined symbol "acpi_gbl_NHLT" when
> > >> ACPI_NHLT is disabled. As nhlt.c is not built when said kconfig is disabled,
> > >> symbol is never defined.
> > >>
> > >> Proposed solution - modify drivers/acpi/tables.c with:
> > >>
> > >> +#include <acpi/nhlt.h>
> > >> +
> > >> +struct acpi_table_nhlt *acpi_gbl_NHLT;

No capitals in variable names, please.

> > >> +EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);
> > >>
> > >> as tables.c is always built the symbol is always there.
> > >> The only other option I see is:
> > >>
> > >> -obj-$(CONFIG_ACPI_NHLT)     += nhlt.o
> > >> +obj-y                               += nhlt.o
> > >>
> > >> and modifying nhlt.c so it's essentially split in half with:
> > >> #if IS_ENABLED(CONFIG_ACPI_NHLT)
> > >>
> > >> but such solutions stinks. I prefer the first approach.
> > >> What to you find guys?
> > >
> > > I leave this to Rafael as it's his territory.
> >
> > Rafael, which option do you prefer?
> >
> > Regardless of IKP and my CI returning success on compilation tests,
> > clearly there is a problem when CONFIG_ACPI_NHLT.
>
> Putting the definition of acpi_gbl_NHLT into tables.c would be fine
> with me, but in any case, because it is an exported symbol, it needs a
> description in a kerneldoc comment.

That said, you can also do something like this in a header file:

#ifdef CONFIG_ACPI_NHLT
extern struct acpi_table_nhlt *acpi_gbl_nhlt;
#else
#define acpi_gbl_nhlt    NULL
#endif

and require the acpi_gbl_nhlt users to include it.
