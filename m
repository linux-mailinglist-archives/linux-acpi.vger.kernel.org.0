Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1432E70DAC4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 12:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjEWKoJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 23 May 2023 06:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjEWKoI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 06:44:08 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D51FD;
        Tue, 23 May 2023 03:44:07 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-96f44435d92so101718566b.0;
        Tue, 23 May 2023 03:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684838645; x=1687430645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cfm/I8yYuZ6qXjBK2xplMTOQZN+PhYua7KL9hZXBpX0=;
        b=hC6M/B0/aO5BogEm0YaSNezw/uLzQIXm62OKUjCibdoFYr6l0cqOExGVa7Qh4yIJ2K
         YaZZ+BgQMDvguVLT3V0O27uBigYeoL3mzombNAPtkeXi8mH3RQ5z9oI0MKwEiFZ+AIUV
         5Mfy3K+TkE0kk8DW2mgF0fR8QLtOOCYygaw4LxRNQLmwY7DsCmNvt1SpW+qyroCRi0ht
         MoqG2YFXZqoBpZy1R2VqYCfzafIfWoYSZ1aJ0RdBdkL+nR0zxpEmLWx0rmA1Hjy0aq+z
         hzYKBT8VlrZxkkBIVhhiPgqB+QxoAzadrPsjYojvoOnSFBN7dK6EHzrHXOEHUVUBT+ga
         3DBg==
X-Gm-Message-State: AC+VfDx6FBld/9ZN1vaY4mbE/j65Lf1C8UkOX9hMBGtbgxHP/KxVUX8X
        MM5pEpMEZt1RIgPKLurBpPtougVPAq0hqPWHX24=
X-Google-Smtp-Source: ACHHUZ6ZDB1vpvHhXifep9fBd+kqKLI8NXg5epCVtwaHbBzVFFdcGJCDFylfVmgE7hTyOyXt7SInLCU+BXrjDlcsQ0E=
X-Received: by 2002:a17:906:d3:b0:94f:66af:b1f7 with SMTP id
 19-20020a17090600d300b0094f66afb1f7mr11834819eji.1.1684838645332; Tue, 23 May
 2023 03:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443478863.2966470.17477171378435115702.stgit@djiang5-mobl3> <646bf6f826ec8_33fb329437@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <646bf6f826ec8_33fb329437@dwillia2-xfh.jf.intel.com.notmuch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 12:43:53 +0200
Message-ID: <CAJZ5v0j93WsjQFcgkeYL_AscEY-QE0GQWBB3oeDUxaNVN0ORzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] acpi: tables: Add CDAT table parsing support
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
        linux-cxl@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
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

On Tue, May 23, 2023 at 1:13 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Dave Jiang wrote:
> > The CDAT table is very similar to ACPI tables when it comes to sub-table
> > and entry structures. The helper functions can be also used to parse the
> > CDAT table. Add support to the helper functions to deal with an external
> > CDAT table, and also handle the endieness since CDAT can be processed by a
> > BE host. Export a function cdat_table_parse() for CXL driver to parse
> > a CDAT table.
> >
> > In order to minimize ACPICA code changes, __force is being utilized to deal
> > with the case of a big endien (BE) host parsing a CDAT. All CDAT data
> > structure variables are being force casted to __leX as appropriate.
> >
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >
> > ---
> > v2:
> > - Make acpi_table_header and acpi_table_cdat a union. (Jonathan)
> > - Use local var to make acpi_table_get_length() more readable. (Jonathan)
> > - Remove ACPI_SIG_CDAT define, already defined.
> > ---
> >  drivers/acpi/tables.c     |    5 +++-
> >  drivers/acpi/tables_lib.c |   52 ++++++++++++++++++++++++++++++++++++++++++---
> >  include/linux/acpi.h      |   22 +++++++++++++++++--
> >  3 files changed, 72 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index cfc76efd8788..f7e1ea192576 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -241,8 +241,9 @@ int __init_or_acpilib acpi_table_parse_entries_array(
> >               return -ENODEV;
> >       }
> >
> > -     count = acpi_parse_entries_array(id, table_size, table_header,
> > -                     proc, proc_num, max_entries);
> > +     count = acpi_parse_entries_array(id, table_size,
> > +                                      (union table_header *)table_header,
>
> I think the force cast can be cleaned up, more below...
>
> > +                                      proc, proc_num, max_entries);
> >
> >       acpi_put_table(table_header);
> >       return count;
> [..]
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 57ffba91bfb5..4a5b40463048 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -22,11 +22,17 @@
> >  #include <acpi/acpi.h>
> >
> >  /* Table Handlers */
> > +union table_header {
> > +     struct acpi_table_header acpi;
> > +     struct acpi_table_cdat cdat;
> > +};
>
> 'table_header' seems too generic a name for a type in a header file
> included as widely as acpi.h. How about 'union acpi_parse_header'?
>
> Moreover I think the type-casting when calling the helpers might look
> better with explicit type-punning showing the conversion from ACPI and
> CDAT callers into the common parser. Something like the following folded
> on top (only compile tested):
>
> -- >8 --
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index f7e1ea192576..ef31232fdcfb 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -219,7 +219,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
>         char *id, unsigned long table_size, struct acpi_subtable_proc *proc,
>         int proc_num, unsigned int max_entries)
>  {
> -       struct acpi_table_header *table_header = NULL;
> +       union acpi_convert_header hdr;
>         int count;
>         u32 instance = 0;
>
> @@ -235,17 +235,16 @@ int __init_or_acpilib acpi_table_parse_entries_array(
>         if (!strncmp(id, ACPI_SIG_MADT, 4))
>                 instance = acpi_apic_instance;
>
> -       acpi_get_table(id, instance, &table_header);
> -       if (!table_header) {
> +       acpi_get_table(id, instance, &hdr.acpi);
> +       if (!hdr.acpi) {
>                 pr_debug("%4.4s not present\n", id);
>                 return -ENODEV;
>         }
>
> -       count = acpi_parse_entries_array(id, table_size,
> -                                        (union table_header *)table_header,
> -                                        proc, proc_num, max_entries);
> +       count = acpi_parse_entries_array(id, table_size, hdr.parse, proc,
> +                                        proc_num, max_entries);
>
> -       acpi_put_table(table_header);
> +       acpi_put_table(hdr.acpi);
>         return count;
>  }
>
> diff --git a/drivers/acpi/tables_lib.c b/drivers/acpi/tables_lib.c
> index 71e2fb1735e5..bd886900762a 100644
> --- a/drivers/acpi/tables_lib.c
> +++ b/drivers/acpi/tables_lib.c
> @@ -105,7 +105,7 @@ static enum acpi_subtable_type acpi_get_subtable_type(char *id)
>  }
>
>  static unsigned long acpi_table_get_length(enum acpi_subtable_type type,
> -                                          union table_header *hdr)
> +                                          union acpi_parse_header *hdr)

If this is going to be common library code, I'm wondering how much of
"acpi" needs to be there in the names.
