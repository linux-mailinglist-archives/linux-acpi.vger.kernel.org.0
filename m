Return-Path: <linux-acpi+bounces-172-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035667AF81A
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 04:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A58DF280C4B
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0B063AC
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 02:30:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA246AC
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 01:47:55 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947639005;
	Tue, 26 Sep 2023 18:47:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40594a6d1ecso11520805e9.1;
        Tue, 26 Sep 2023 18:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695779272; x=1696384072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP9N2gfeiWYXcjxAcn/cQZzNl5uPlV6uaT56umiTjo8=;
        b=mdZBYtkbGXhEIASl9MXbPlNQ4Fh56XGfHyTUP0QwiLyXtvoLaWDMWxHh8VcZJpdy1A
         tmg3iEPLb7Y/NarmpFuCsqo+B34sWqLs/PyDeKub7ZWqFEfTxC9qQOtM+ZLkm485qHZ8
         8Vk2ckW1hM9XJZ4f81NeZV2+YMP0XdbhO5kAAJ8UdYQgwGjjKQgASE7MXTWlAyQFc099
         Mv1PGfBEr3BqkiR5W9dO8Qa6tNwd4fBHfKrgLuJNyJC7CtlfBxQD7qK6T2QAMKhjrr2Z
         j21Ziah7ETDY+EDfNzh1xQfAfuz+YcYGeGRkmQc6JtbD3lTfr5TT7Th0JDz/zZLycdv9
         G2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695779272; x=1696384072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP9N2gfeiWYXcjxAcn/cQZzNl5uPlV6uaT56umiTjo8=;
        b=lCDZEd4+kiIfHUzAgWpF2OzdWi9ktf8lFvn4C18J/iVF2oyWUcqWoyaz4Am2NzktbP
         DWUz4DSlvRCmbeh8hU0ONOqyvt4mgxx/Kg7r0jfQsRSbz05C76LZMHjy/edXoK+3jIVj
         Eg+l24lymIUu5pykLNrhPIkOyHBNpZ/Ip6hjHnFK8+J7JVuHCEvVlcu2lsmGTX9q/X/w
         TcfOIXkDxDrALNVXkKfMLMf4gKrDmbhEUGh060Dhoxk9UtmJhRjuColgT3ZS85CPPfps
         pq1Galr098ruUVoG/Yj+Kfw/VJpVOzFdBhi82+7ANkykY0gDP2b4uFktoDK97rcpzSlL
         i3gg==
X-Gm-Message-State: AOJu0YxqZW/KWqpheJSyiqv3odn45yjfss9t9qxrWHBwKLGs+l4RTpMd
	7/rUOTSCsxdoyunDgkSRZOjW/h9l/mj5mmPNdjDHrrIEgSo=
X-Google-Smtp-Source: AGHT+IEAaKAlOkvmR0LD66XKj8QWzk4M3h/3mWe27gg1G+gi8Qs8/Sv8nOxQdC0XyT/2gKyWkvIM/59GaOUJCyYn1EU=
X-Received: by 2002:adf:e5cf:0:b0:323:2e5d:b7c6 with SMTP id
 a15-20020adfe5cf000000b003232e5db7c6mr329201wrn.0.1695779271781; Tue, 26 Sep
 2023 18:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925214046.1051350-1-anarsoul@gmail.com> <b0786bf5571050397b5075bac7c1e9023bfa5aec.camel@intel.com>
In-Reply-To: <b0786bf5571050397b5075bac7c1e9023bfa5aec.camel@intel.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Tue, 26 Sep 2023 18:47:24 -0700
Message-ID: <CA+E=qVc424VJsqGRR+SZbDmDdtdVmx+Ag6vt_brhZsNv1JTCRw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: FPDT: break out of the loop if record length is zero
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 10:03=E2=80=AFPM Zhang, Rui <rui.zhang@intel.com> w=
rote:
>
> On Mon, 2023-09-25 at 14:40 -0700, Vasily Khoruzhick wrote:
> > Buggy BIOSes may have zero-length records in FPDT, table, as a result
> s/FPDT, table/FPDT table
>
>
> > fpdt_process_subtable() spins in eternal loop.
> >
> > Break out of the loop if record length is zero.
> >
> >
> > Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT
> > table")
> > Cc: stable@vger.kernel.org
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> Is there a bugzilla or something where such a buggy BIOS is reported?

I'm not aware of a bug filed a kernel bugzilla, however I found
mentions of the issue online:
https://forum.proxmox.com/threads/acpi-fpdt-duplicate-resume-performance-re=
cord-found.114530/

> > ---
> >  drivers/acpi/acpi_fpdt.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> > index a2056c4c8cb7..53d8f9601a55 100644
> > --- a/drivers/acpi/acpi_fpdt.c
> > +++ b/drivers/acpi/acpi_fpdt.c
> > @@ -194,6 +194,11 @@ static int fpdt_process_subtable(u64 address,
> > u32 subtable_type)
> >                 record_header =3D (void *)subtable_header + offset;
> >                 offset +=3D record_header->length;
> >
> > +               if (!record_header->length) {
> > +                       pr_info(FW_BUG "Zero-length record
> > found.\n");
> > +                       break;
>
> For cases like this, it implies the FPDT table is far from usable and
> we should stop processing on such platforms.

Here's FPDT dump:

00000000: 4650 4454 4400 0000 018c 414c 4153 4b41  FPDTD.....ALASKA
00000010: 4120 4d20 4920 0000 0920 0701 414d 4920  A M I ... ..AMI
00000020: 1300 0100 0100 1001 0000 0000 30fe 207f  ............0. .
00000030: 0000 0000 0000 1001 0000 0000 54fe 207f  ............T. .
00000040: 0000 0000                                ....

S3PT at 0x7f20fe30:

7F20FE30: 53 33 50 54 24 00 00 00-00 00 00 00 00 00 18 01  *S3PT$..........=
.*
7F20FE40: 00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00  *...............=
.*
7F20FE50: 00 00 00 00

FBPT at 0x7f20fe54:

7F20FE50: xx xx xx xx 46 42 50 54-3C 00 00 00 46 42 50 54  *....FBPT<...FBP=
T*
7F20FE60: 02 00 30 02 00 00 00 00-00 00 00 00 00 00 00 00  *..0............=
.*
7F20FE70: 2A A6 BC 6E 0B 00 00 00-1A 44 41 70 0B 00 00 00  **..n.....DAp...=
.*
7F20FE80: 00 00 00 00 00 00 00 00-00 00 00 00 00 00 00 00  *...............=
.*

It looks like subtables are not usable. S3PT subtable has the first
record with zero len, and FBPT has its signature again instead of the
first record header.

So yeah, I agree that FPDT is not usabled in this case, and it
shouldn't be processed further.

> So, IMO, it is better to
> 1. return an error here rather than break and return 0.
> 2. add the error handling for fpdt_process_subtable() failures.
>
> what do you think?

Agree, I'll implement it in v2.

Regards,
Vasily

