Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D3C3F7BFC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Aug 2021 20:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhHYSDa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Aug 2021 14:03:30 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39753 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhHYSD3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Aug 2021 14:03:29 -0400
Received: by mail-oi1-f172.google.com with SMTP id v2so533567oie.6
        for <linux-acpi@vger.kernel.org>; Wed, 25 Aug 2021 11:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXkNZhdSS2CuEQzD6b6R33x3+ZDLSGMbTQFXwDKOpSc=;
        b=GRmfJMkAdFUILpKQO0wsUcN85SoOeLBzNGxuc0mrTFm0bHtzsJNXk2icFCHXRwUY/z
         EkHjr5z3zAvtWmAk8U96Y+o7J+tBhBoQK/DEU0Vxs3BhtyAMKyI+UvhZwdxFQBg1ekkI
         jsmjP9FvbwXFym8RNQ5/qDn3PAAkot9V4sS6U80/oG5JhD+5YMS58EVKcgkEqtGj9O96
         Tf1cGGWJzUEhx8NnfzPbixpt/JKBvpqDVoQYQBBxgMe7HHfBuRZihJekywq5Wt62xak+
         v5oIg7oIb85yCmNu/WqI1/gU+L/skWN+UZ2qtMQKHaN6Xea4TaxSGADOkUjIUGE31XeV
         dQdQ==
X-Gm-Message-State: AOAM531JDgP+JEe0mWh0mWGt6Aq6ZBRRqwoham+Pq91N6OV+HKGpUDdj
        O2JBFnRkuZLRYd8sh8+Rw0+T+hZdIwMrFvTvLWM=
X-Google-Smtp-Source: ABdhPJwj+rtgPzjceQhDjqYpzpTJOvmPy8qqYegI7qMt5xVM7j4c+Fzd0oNGWuUZyU+r1l2aDrWhp/BX+b27HtZxhmo=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr7841361oie.71.1629914563604;
 Wed, 25 Aug 2021 11:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210819071416.14975-1-adrianhuang0701@gmail.com> <43a0b67b4412c617778a6a30ededd5c042b9a554.camel@intel.com>
In-Reply-To: <43a0b67b4412c617778a6a30ededd5c042b9a554.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Aug 2021 20:02:32 +0200
Message-ID: <CAJZ5v0hsLMwj=T5RdZNg163W9hNECmANBk5FGecuHQ+2TqhN6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: tables: FPDT: Do not print FW_BUG message if
 record types are reserved
To:     Zhang Rui <rui.zhang@intel.com>,
        Adrian Huang <adrianhuang0701@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 19, 2021 at 10:08 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Thu, 2021-08-19 at 15:14 +0800, Adrian Huang wrote:
> > From: Adrian Huang <ahuang12@lenovo.com>
> >
> > In ACPI 6.4 spec, record types "0x0002-0xffff" of FPDT Performance
> > Record
> > Types [1] and record types "0x0003-0xffff" of Runtime Performance
> > Record
> > Types [2] are reserved.
> >
> > Users might be confused with the FW_BUG message, and they think this
> > is the FW issue. Here is the example in a Lenovo box:
> >
> >   ACPI: FPDT 0x00000000A820A000 000044 (v01 LENOVO THINKSYS 00000100
> > 01000013)
> >   ACPI: Reserving FPDT table memory at [mem 0xa820a000-0xa820a043]
> >   ACPI FPDT: [Firmware Bug]: Invalid record 4113 found
> >
> > So, remove the FW_BUG message to avoid confusion since those types
> > are
> > reserved in ACPI 6.4 spec.
> >
> > [1]
> > https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fpdt-performance-record-types-table
> > [2]
> > https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#runtime-performance-record-types-table
> >
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
>
> Acked-by: Zhang Rui <rui.zhang@intel.com>

Applied as 5.15 material, thanks!

> > ---
> >
> > Changes since v2:
> >  * Fix "0x0002-0xFFFF" of FPDT Performance Record Types, per Rui
> >
> >  drivers/acpi/acpi_fpdt.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> > index 4ee2ad234e3d..6922a44b3ce7 100644
> > --- a/drivers/acpi/acpi_fpdt.c
> > +++ b/drivers/acpi/acpi_fpdt.c
> > @@ -220,8 +220,8 @@ static int fpdt_process_subtable(u64 address, u32
> > subtable_type)
> >                       break;
> >
> >               default:
> > -                     pr_err(FW_BUG "Invalid record %d found.\n",
> > record_header->type);
> > -                     return -EINVAL;
> > +                     /* Other types are reserved in ACPI 6.4 spec.
> > */
> > +                     break;
> >               }
> >       }
> >       return 0;
> > @@ -254,8 +254,7 @@ static int __init acpi_init_fpdt(void)
> >                                             subtable->type);
> >                       break;
> >               default:
> > -                     pr_info(FW_BUG "Invalid subtable type %d
> > found.\n",
> > -                            subtable->type);
> > +                     /* Other types are reserved in ACPI 6.4 spec.
> > */
> >                       break;
> >               }
> >               offset += sizeof(*subtable);
>
