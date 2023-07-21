Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5512C75C3C2
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 11:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGUJyC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 21 Jul 2023 05:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjGUJxs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 05:53:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE34448D
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 02:52:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99b49e51f62so53416566b.1
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 02:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689933079; x=1690537879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9U1rhaBjK3fpWL/NQXP48tZBv8vEzVJXpHQWGZP6QTQ=;
        b=DAbhO1MI+zxcUQ/0jvRzR5x7ZP+oS5GsewxYmziTL1G8ZoXgy1/KDElgY4NwIavIAH
         IWS/uKWIscRSW6AKc0IFUmG90gYbcA6jzrlAQBvEzKo8OhqkgnOI8SFlbg0ru6EpVrC0
         FcLlyQ3BqRROIyAslYup4FTU3TxdOh6AWKf+fYnlQBNAKtgx2X04oj1QLXu5eKqjik6e
         gl/WE0urlYkXm5GaFr1WHXsTzsobQGIcgq7PAc6EafczMxQTh8L/77nbxe9wI/lI2oGA
         eqBZaWuIUvA8ZGM0ewx/XKuRK7HioIxl/MBXiyyqf6IaPD9KlUopxWWHYVmhil02CMtF
         GIQA==
X-Gm-Message-State: ABy/qLaJVTu/Qr4k9c5QTBmNTTqayYsS0yGwU7T2buJBcKW6bqnn9PVH
        scf0b3V4rWIXMNyeBq8iCQmMVE5GVer/ZvsVbw4=
X-Google-Smtp-Source: APBJJlG9gzfr6/EwSG3lmAk7dsX0mp7y016BWFI9a9b+DbpkZro3oF/0Wf++uqpQsy2R+cE6oTIPvVFo17T/bhIE2KU=
X-Received: by 2002:a17:906:73d3:b0:993:d5e7:80f6 with SMTP id
 n19-20020a17090673d300b00993d5e780f6mr1067077ejl.5.1689933079350; Fri, 21 Jul
 2023 02:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230717150047.15196-1-cezary.rojewski@intel.com>
 <20230717150047.15196-3-cezary.rojewski@intel.com> <4af468ff-6b87-962d-8629-52bb7d9ee340@intel.com>
 <ZLgDDB7vH/4FaI06@smile.fi.intel.com> <820d5447-a491-f052-a1f1-939fc9c283bf@intel.com>
 <CAJZ5v0gZLwJF78JZG4-ETEyr=_X41ude5ebuM+GE1xHhS_0PYA@mail.gmail.com>
 <CAJZ5v0goKBLxQO6hJq8Gpj-JEb9D1YuXHWyzwyr9YV4iEBteig@mail.gmail.com> <df2bd70b-c480-27fe-5806-8d96b0713358@intel.com>
In-Reply-To: <df2bd70b-c480-27fe-5806-8d96b0713358@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Jul 2023 11:51:07 +0200
Message-ID: <CAJZ5v0jk=a=sFff-05kuyDKcv8E3mDhZzyzPtw8OVcNAY8McUw@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 21, 2023 at 11:49 AM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2023-07-20 7:05 PM, Rafael J. Wysocki wrote:
> > On Thu, Jul 20, 2023 at 7:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>
> >> On Thu, Jul 20, 2023 at 11:15 AM Cezary Rojewski
> >> <cezary.rojewski@intel.com> wrote:
>
> ...
>
> >>>>> This approach generates a problem with undefined symbol "acpi_gbl_NHLT" when
> >>>>> ACPI_NHLT is disabled. As nhlt.c is not built when said kconfig is disabled,
> >>>>> symbol is never defined.
> >>>>>
> >>>>> Proposed solution - modify drivers/acpi/tables.c with:
> >>>>>
> >>>>> +#include <acpi/nhlt.h>
> >>>>> +
> >>>>> +struct acpi_table_nhlt *acpi_gbl_NHLT;
> >
> > No capitals in variable names, please.
>
> acpi_gbl_NHLT follows the path set by acpi_gbl_DSDT, _FADT and others.
> Why would NHLT be an exception? Is this because it's not defined under
> ACPICA?

Yes, it is.  ACPICA has its own rules, sort of.
