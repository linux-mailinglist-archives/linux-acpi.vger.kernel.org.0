Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A1375B521
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jul 2023 19:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGTRBX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 20 Jul 2023 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTRBX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2023 13:01:23 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CF592
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jul 2023 10:01:22 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b73261babdso2578771fa.1
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jul 2023 10:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689872480; x=1690477280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebhwNJbIbALMrfX588e88qbH6JInlrg63Oaz3o5iM1s=;
        b=DIsI1xCOKqZ7k6D6CfWiP8n145zr2w4COXNwRobG4hzrlcisFP2FoYE+rw44Pmhn5R
         A2l1Du9kLx6Ig5lqTA9kRVAIkdeIjM48Ck7F6mTDMDBH0qacitIJxYCh7NbolNdjcwx5
         gL4cG/6m68sE/KKMylJpyj7ChBLVuVu4GOmeSBPMvTm8qwz9pv1BY6/fEmCDgYYXkEcf
         aR6vLJtXPREQb9Oded2nRiaGZfxf1yDoocB5xLgBlp7/55E09XZcDuTxtGozLdR12i0f
         JCSWLCjpi4qjEtGuUre26Cakxwm973nddwJLNkyFstpVby8L7VQmJdn80BVxYfgEvUhS
         YmXQ==
X-Gm-Message-State: ABy/qLbtPn6xv8EAy9P/R0FxvxTH08W9lyN5GWc8XfFQPQllJzZD7zWs
        YdGOuon0ZEP+i8WZTzYMtEp0kVUual4raAGvoiE=
X-Google-Smtp-Source: APBJJlHDYybhSWyVDxp+p6GHbP6AI9OdT0ghICax8LDG2fFEu4JoB00TtRgdeCDiAecJ2Vg2w5LL8/kQPAo5sKGOpK4=
X-Received: by 2002:a05:651c:150c:b0:2b7:3f71:b98d with SMTP id
 e12-20020a05651c150c00b002b73f71b98dmr2785024ljf.0.1689872480103; Thu, 20 Jul
 2023 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230717150047.15196-1-cezary.rojewski@intel.com>
 <20230717150047.15196-3-cezary.rojewski@intel.com> <4af468ff-6b87-962d-8629-52bb7d9ee340@intel.com>
 <ZLgDDB7vH/4FaI06@smile.fi.intel.com> <820d5447-a491-f052-a1f1-939fc9c283bf@intel.com>
In-Reply-To: <820d5447-a491-f052-a1f1-939fc9c283bf@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jul 2023 19:01:08 +0200
Message-ID: <CAJZ5v0gZLwJF78JZG4-ETEyr=_X41ude5ebuM+GE1xHhS_0PYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ACPI: NHLT: Introduce acpi_gbl_NHLT
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, robert.moore@intel.com,
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

On Thu, Jul 20, 2023 at 11:15 AM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2023-07-19 5:36 PM, Andy Shevchenko wrote:
> > On Wed, Jul 19, 2023 at 04:47:31PM +0200, Cezary Rojewski wrote:
> >> On 2023-07-17 5:00 PM, Cezary Rojewski wrote:
>
> ...
>
> >>> +++ b/drivers/acpi/nhlt.c
> >>> @@ -0,0 +1,13 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +//
> >>> +// Copyright(c) 2023 Intel Corporation. All rights reserved.
> >>> +//
> >>> +// Authors: Cezary Rojewski <cezary.rojewski@intel.com>
> >>> +//          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
> >>> +//
> >>> +
> >>> +#include <linux/export.h>
> >>> +#include <acpi/nhlt.h>
> >>> +
> >>> +struct acpi_table_nhlt *acpi_gbl_NHLT;
> >>> +EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);
> >>
> >> This approach generates a problem with undefined symbol "acpi_gbl_NHLT" when
> >> ACPI_NHLT is disabled. As nhlt.c is not built when said kconfig is disabled,
> >> symbol is never defined.
> >>
> >> Proposed solution - modify drivers/acpi/tables.c with:
> >>
> >> +#include <acpi/nhlt.h>
> >> +
> >> +struct acpi_table_nhlt *acpi_gbl_NHLT;
> >> +EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);
> >>
> >> as tables.c is always built the symbol is always there.
> >> The only other option I see is:
> >>
> >> -obj-$(CONFIG_ACPI_NHLT)     += nhlt.o
> >> +obj-y                               += nhlt.o
> >>
> >> and modifying nhlt.c so it's essentially split in half with:
> >> #if IS_ENABLED(CONFIG_ACPI_NHLT)
> >>
> >> but such solutions stinks. I prefer the first approach.
> >> What to you find guys?
> >
> > I leave this to Rafael as it's his territory.
>
> Rafael, which option do you prefer?
>
> Regardless of IKP and my CI returning success on compilation tests,
> clearly there is a problem when CONFIG_ACPI_NHLT.

Putting the definition of acpi_gbl_NHLT into tables.c would be fine
with me, but in any case, because it is an exported symbol, it needs a
description in a kerneldoc comment.
