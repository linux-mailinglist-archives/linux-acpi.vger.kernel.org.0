Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB1770DAB0
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 12:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbjEWKjQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 23 May 2023 06:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjEWKjP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 06:39:15 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13ABFD;
        Tue, 23 May 2023 03:39:13 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-50d897af77bso805651a12.1;
        Tue, 23 May 2023 03:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684838352; x=1687430352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+d4XqP+lXAv6/+w79rOhyj2ltYvsV9fXvdBfWn6vX0=;
        b=BaRlFHXLyjp4kWyvWmFASkUjtIqjGSuSKbK8tn5OHSJLS9nzmdPrY6FCWWA4sCeokt
         zmlLEczZC8NE79VQMHOn7sixVI8G6XhWHpiazhLqXX+jcixVTAZ8LPoaXuAnw+f5BMbb
         pJOFwCEX4PvaNXitwOAA7ahxFNJCHmwO36a+KwMDTVKxtsSb9TqXtGeBczccoxL4oNss
         RKKKQBV5PHHa/GZfdu6Ij1qAtMQJb2jPOeXsYRPMwTjtvjJxksJ0UQGEoHfgpSI5OezQ
         Qa09DyjYoblqrx90x2bExdCINsb9Z+lBsCpj6Jp/WoHzAIlTxldCKTf5rPolwV2LM+J3
         XyoA==
X-Gm-Message-State: AC+VfDwH+sH0Po8g15NaW7THicHz5sjjdWG+SFfhsIarqH2wu7eGGfWq
        7gJ6yRiwL/0vcIDehw2QY9ojGB4eaWTZnbvgS1Q=
X-Google-Smtp-Source: ACHHUZ60NrJjLrMdWZ8Yh+fC0rWY//2DCpfPeNKXxnUljB7qcllIN4c8xwlpLgxRInx1ODBVz+HSShXTg7st81ZXwvg=
X-Received: by 2002:a05:6402:190e:b0:50d:9ba4:52df with SMTP id
 e14-20020a056402190e00b0050d9ba452dfmr18508445edz.3.1684838352123; Tue, 23
 May 2023 03:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443478260.2966470.6881416930240756285.stgit@djiang5-mobl3>
 <646bdf21b9329_33fb329410@dwillia2-xfh.jf.intel.com.notmuch>
 <19907ea8-85bf-6e31-0798-ef8a1e4b842a@intel.com> <646bebd5ebaac_33fb3294df@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <646bebd5ebaac_33fb3294df@dwillia2-xfh.jf.intel.com.notmuch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 12:38:59 +0200
Message-ID: <CAJZ5v0jipbtTNnsA0-o5ozOk8ZgWnOg34m34a9pPenTyRLj=6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] acpi: Move common tables helper functions to
 common lib
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
        linux-cxl@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 23, 2023 at 12:25 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Dave Jiang wrote:
> >
> > On 5/22/23 14:31, Dan Williams wrote:
> > > Dave Jiang wrote:
> > >> Some of the routines in ACPI tables.c can be shared with parsing CDAT.
> > > s,ACPI tables.c,driver/acpi/tables.c,
> > >
> > >> However, CDAT is used by CXL and can exist on platforms that do not use
> > >> ACPI.
> > > Clarify that CDAT is not an ACPI table:
> > >
> > > CDAT is a device-provided data structure that is formatted similar to a
> > > platform-provided ACPI table.
> > >
> > >> Split out the common routine from ACPI to accomodate platforms that
> > >> do not support ACPI. The common routines can be built outside of ACPI if
> > >> ACPI_TABLES_LIB is selected.
> > > Might be just me but I get confused where this is indicating "ACPI" the
> > > platform vs "CONFIG_ACPI" the code. How about just:
> > >
> > > Refactor the table parsing routines in driver/acpi/tables.c into helpers
> > > that can be shared with the CXL driver even in the CONFIG_ACPI=n case.
> > >
> > >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > >> ---
> > >>   drivers/Makefile          |    2
> > >>   drivers/acpi/Kconfig      |    4 +
> > >>   drivers/acpi/Makefile     |    3 +
> > >>   drivers/acpi/tables.c     |  173 ----------------------------------------
> > >>   drivers/acpi/tables_lib.c |  194 +++++++++++++++++++++++++++++++++++++++++++++
> > >>   include/linux/acpi.h      |   63 +++++++++------
> > >>   6 files changed, 241 insertions(+), 198 deletions(-)
> > >>   create mode 100644 drivers/acpi/tables_lib.c
> > > Conversion looks ok to me. Even though the cover letter said "Hi Rafael,
> > > Please consider these for 6.5 merge window" my expectation is to take
> > > these through CXL with ACPI acks.
> >
> > I thought you wanted Rafael to take the ACPI patches. But going to the
> > CXL tree works.
>
> Ultimately up to Rafael. Either need a stable ACPI tree baseline to base
> the CDAT work upon, or take this all through CXL.

AFAIAC, it can go in via the CXL tree, but see below.

> >
> > >
> > > One question below:
> > >
> > >> diff --git a/drivers/Makefile b/drivers/Makefile
> > >> index 20b118dca999..1824797f7dfe 100644
> > >> --- a/drivers/Makefile
> > >> +++ b/drivers/Makefile
> > >> @@ -31,7 +31,7 @@ obj-y                            += idle/
> > >>   # IPMI must come before ACPI in order to provide IPMI opregion support
> > >>   obj-y                            += char/ipmi/
> > >>
> > >> -obj-$(CONFIG_ACPI)                += acpi/
> > >> +obj-y                             += acpi/
> > >>
> > >>   # PnP must come after ACPI since it will eventually need to check if acpi
> > >>   # was used and do nothing if so
> > >> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > >> index ccbeab9500ec..ce74a20dc42f 100644
> > >> --- a/drivers/acpi/Kconfig
> > >> +++ b/drivers/acpi/Kconfig
> > >> @@ -6,12 +6,16 @@
> > >>   config ARCH_SUPPORTS_ACPI
> > >>    bool
> > >>
> > >> +config ACPI_TABLES_LIB
> > >> +  bool
> > >> +
> > >>   menuconfig ACPI
> > >>    bool "ACPI (Advanced Configuration and Power Interface) Support"
> > >>    depends on ARCH_SUPPORTS_ACPI
> > >>    select PNP
> > >>    select NLS
> > >>    select CRC32
> > >> +  select ACPI_TABLES_LIB
> > >>    default y if X86
> > >>    help
> > >>      Advanced Configuration and Power Interface (ACPI) support for
> > >> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > >> index feb36c0b9446..4558e2876823 100644
> > >> --- a/drivers/acpi/Makefile
> > >> +++ b/drivers/acpi/Makefile
> > >> @@ -13,6 +13,9 @@ tables.o: $(src)/../../include/$(CONFIG_ACPI_CUSTOM_DSDT_FILE) ;
> > >>
> > >>   endif
> > >>
> > >> +obj-$(CONFIG_ACPI_TABLES_LIB)     += acpi_tables_lib.o
> > >> +acpi_tables_lib-y := tables_lib.o
> > > Why is a separate object name needed?
> >
> > Not all code in tables.c will be shared. There are ACPI table parsing
> > specific code in tables.c that CXL does not care about. Or do you mean
> > just do
> >
> > obj-$(CONFIG_ACPI_TABLES_LIB) += tables_lib.o
>
> Yes, this.

First, this depends on what is there in tables_lib.c.  IMV it should
not contain stuff that is not needed for CDAT parsing.

Second, I'm not sure if drivers/acpi/ is the most appropriate location
for it, maybe lib/ would be less confusing?
