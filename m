Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385312B0E13
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 20:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKLTa6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 14:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKLTa6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 14:30:58 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24A5C0613D1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 11:30:57 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id h6so5060322pgk.4
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 11:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bYqHpM6AIuFjCSL/QQBim4EdBYJZxV5g7YmL9Sjc9fA=;
        b=eio7XsSC4Mj7lBnz2+7Sw/c9maHH5Jg9J1Qo1bW46Iq8BKvwLnKIZd9VVogNPUgaDw
         fGFWJ8FI4xEYxmHqla6NcPa2BFmntXLwJTP8z41uWYLfKx9e5728e80VqirLJjo+dp06
         ekGFrXnAAOKkMSaPTzkrf2T7pN6rLB5BAVjVeWv1vLjRadrKyiqPxZ3tdw6s3nroKj4F
         INROR9JIsPxebkKo9KJTlDY5r1zn6HD3zsscWfo6F8JfC5zvuu112b3R6TCAnRVH8Tki
         7iPsq3J1+Xt685vIzVE88C+3G5eGDfDHqmoEiRNLhyArXEuNMxaGrYSo+NPaseh8i5iP
         exsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bYqHpM6AIuFjCSL/QQBim4EdBYJZxV5g7YmL9Sjc9fA=;
        b=VN2j30lSbFjWU1nXtkHxFhzaPHJ9aGx7GjhzOJ9nvcHN2qkJnvMw3oo45W6En7Q9QD
         i99jFea9mm3A1ZdDmSG7DVunV3Uah0IXlCGyuB4RpQ4oCtPwdduyByyCEgpZ3AVYE8Mc
         SQBHw/zUUcGoLnbg1PTCcsBqGFkBdJDzyBWE5563r9jAPPIcc4Itq27eQ6vcT2XtvJ+Z
         BJ3iqalKskBIO+kCT13O4WKpgfLgb7eESy1ZIoutBuC5EZgBmy0d2liElPUS55x+IvjD
         PlFl91NlbTN1KOcA8F/0oG6jUOYiuIDU5gJvZFd8fGbk/oGa9DdEeN+AnL/CXM14me9Y
         W01A==
X-Gm-Message-State: AOAM5334WiSCfmQxdrzR7Pvq+e+eeBQupZLhcFdhS4yYRU1qKC6hBK7P
        eMhLnuz0igrdxXKXY4BgobixUzRR0U8yxVdR37VNEQ==
X-Google-Smtp-Source: ABdhPJy76Anx6Wx/lPgUBJpUVx6wL66ZgyVVKz+tSqKj1d8XCMuKDfz2X2D3FpRf0NPoT2GkhndXpzezNVpSYms4+Mc=
X-Received: by 2002:a17:90b:110b:: with SMTP id gi11mr741001pjb.25.1605209457325;
 Thu, 12 Nov 2020 11:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20201111021131.822867-1-ndesaulniers@google.com>
 <BYAPR11MB3256E0C1DCB4F01D18DF709F87E80@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdk2U5+DcXYyMoBAhyaa67EukhB6QMEUbRPcOF7P3Sz21w@mail.gmail.com> <BYAPR11MB3256C9711620932685C368F887E70@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3256C9711620932685C368F887E70@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Nov 2020 11:30:45 -0800
Message-ID: <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 7:13 AM Moore, Robert <robert.moore@intel.com> wrot=
e:
>
>
>
> -----Original Message-----
> From: Nick Desaulniers <ndesaulniers@google.com>
> Sent: Wednesday, November 11, 2020 10:48 AM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wys=
ocki@intel.com>; Gustavo A . R . Silva <gustavoars@kernel.org>; clang-built=
-linux@googlegroups.com; Len Brown <lenb@kernel.org>; linux-acpi@vger.kerne=
l.org; devel@acpica.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
>
> On Wed, Nov 11, 2020 at 7:15 AM Moore, Robert <robert.moore@intel.com> wr=
ote:
> >
> > Yes, but: isn't the "fallthrough" keyword compiler-specific? That is th=
e problem for us.
>
> It's not a keyword.
>
> It's a preprocessor macro that expands to
> __attribute__((__fallthrough__)) for compilers that support it.  For comp=
ilers that do not, it expands to nothing.  Both GCC 7+ and Clang support th=
is attribute.  Which other compilers that support -Wimplicit-fallthrough do=
 you care to support?
>
> We need to support MSVC 2017 -- which apparently does not support this.

In which case, the macro is not expanded to a compiler attribute the
compiler doesn't support.  Please see also its definition in
include/linux/compiler_attributes.h.

From what I can tell, MSVC does not warn on implicit fallthrough, so
there's no corresponding attribute (or comment) to disable the warning
in MSVC.

That doesn't mean this code is not portable to MSVC; a macro that
expands to nothing should not be a problem.

Based on
https://docs.microsoft.com/en-us/cpp/code-quality/c26819?view=3Dmsvc-160
https://developercommunity.visualstudio.com/idea/423975/issue-compiler-warn=
ing-when-using-implicit-fallthr.html
it sounds like MSVC 2019 will be able to warn, for C++ mode, which
will rely on the C++ style attribute to annotate intentional
fallthrough.

Can you confirm how this does not work for MSVC 2017?

> > Bob
> >
> >
> > -----Original Message-----
> > From: ndesaulniers via sendgmr
> > <ndesaulniers@ndesaulniers1.mtv.corp.google.com> On Behalf Of Nick
> > Desaulniers
> > Sent: Tuesday, November 10, 2020 6:12 PM
> > To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> > <erik.kaneda@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>; Gustavo A . R . Silva
> > <gustavoars@kernel.org>
> > Cc: clang-built-linux@googlegroups.com; Nick Desaulniers
> > <ndesaulniers@google.com>; Len Brown <lenb@kernel.org>;
> > linux-acpi@vger.kernel.org; devel@acpica.org;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH] ACPICA: fix -Wfallthrough
> >
> > The "fallthrough" pseudo-keyword was added as a portable way to denote =
intentional fallthrough. This code seemed to be using a mix of fallthrough =
comments that GCC recognizes, and some kind of lint marker.
> > I'm guessing that linter hasn't been run in a while from the mixed use =
of the marker vs comments.
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  drivers/acpi/acpica/dscontrol.c | 3 +--
> >  drivers/acpi/acpica/dswexec.c   | 4 +---
> >  drivers/acpi/acpica/dswload.c   | 3 +--
> >  drivers/acpi/acpica/dswload2.c  | 3 +--
> >  drivers/acpi/acpica/exfldio.c   | 3 +--
> >  drivers/acpi/acpica/exresop.c   | 5 ++---
> >  drivers/acpi/acpica/exstore.c   | 6 ++----
> >  drivers/acpi/acpica/hwgpe.c     | 3 +--
> >  drivers/acpi/acpica/utdelete.c  | 3 +--
> >  drivers/acpi/acpica/utprint.c   | 2 +-
> >  10 files changed, 12 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/dscontrol.c
> > b/drivers/acpi/acpica/dscontrol.c index 4b5b6e859f62..1e75e5fbfd19
> > 100644
> > --- a/drivers/acpi/acpica/dscontrol.c
> > +++ b/drivers/acpi/acpica/dscontrol.c
> > @@ -61,8 +61,7 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state =
*walk_state,
> >                                 break;
> >                         }
> >                 }
> > -
> > -               /*lint -fallthrough */
> > +               fallthrough;
> >
> >         case AML_IF_OP:
> >                 /*
> > diff --git a/drivers/acpi/acpica/dswexec.c
> > b/drivers/acpi/acpica/dswexec.c index 1d4f8c81028c..e8c32d4fe55f
> > 100644
> > --- a/drivers/acpi/acpica/dswexec.c
> > +++ b/drivers/acpi/acpica/dswexec.c
> > @@ -597,9 +597,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_st=
ate *walk_state)
> >                                 if (ACPI_FAILURE(status)) {
> >                                         break;
> >                                 }
> > -
> > -                               /* Fall through */
> > -                               /*lint -fallthrough */
> > +                               fallthrough;
> >
> >                         case AML_INT_EVAL_SUBTREE_OP:
> >
> > diff --git a/drivers/acpi/acpica/dswload.c
> > b/drivers/acpi/acpica/dswload.c index 27069325b6de..afc663c3742d
> > 100644
> > --- a/drivers/acpi/acpica/dswload.c
> > +++ b/drivers/acpi/acpica/dswload.c
> > @@ -223,8 +223,7 @@ acpi_ds_load1_begin_op(struct acpi_walk_state *walk=
_state,
> >                              parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
> >                                 break;
> >                         }
> > -
> > -                       /*lint -fallthrough */
> > +                       fallthrough;
> >
> >                 default:
> >
> > diff --git a/drivers/acpi/acpica/dswload2.c
> > b/drivers/acpi/acpica/dswload2.c index edadbe146506..1b794b6ba072
> > 100644
> > --- a/drivers/acpi/acpica/dswload2.c
> > +++ b/drivers/acpi/acpica/dswload2.c
> > @@ -213,8 +213,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk=
_state,
> >                              parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
> >                                 break;
> >                         }
> > -
> > -                       /*lint -fallthrough */
> > +                       fallthrough;
> >
> >                 default:
> >
> > diff --git a/drivers/acpi/acpica/exfldio.c
> > b/drivers/acpi/acpica/exfldio.c index ade35ff1c7ba..9d1cabe0fed9
> > 100644
> > --- a/drivers/acpi/acpica/exfldio.c
> > +++ b/drivers/acpi/acpica/exfldio.c
> > @@ -433,8 +433,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *o=
bj_desc,
> >                  * Now that the Bank has been selected, fall through to=
 the
> >                  * region_field case and write the datum to the Operati=
on Region
> >                  */
> > -
> > -               /*lint -fallthrough */
> > +               fallthrough;
> >
> >         case ACPI_TYPE_LOCAL_REGION_FIELD:
> >                 /*
> > diff --git a/drivers/acpi/acpica/exresop.c
> > b/drivers/acpi/acpica/exresop.c index 4d1b22971d58..df48faa9a551
> > 100644
> > --- a/drivers/acpi/acpica/exresop.c
> > +++ b/drivers/acpi/acpica/exresop.c
> > @@ -197,8 +197,7 @@ acpi_ex_resolve_operands(u16 opcode,
> >                                 case ACPI_REFCLASS_DEBUG:
> >
> >                                         target_op =3D AML_DEBUG_OP;
> > -
> > -                                       /*lint -fallthrough */
> > +                                       fallthrough;
> >
> >                                 case ACPI_REFCLASS_ARG:
> >                                 case ACPI_REFCLASS_LOCAL:
> > @@ -264,7 +263,7 @@ acpi_ex_resolve_operands(u16 opcode,
> >                          * Else not a string - fall through to the norm=
al Reference
> >                          * case below
> >                          */
> > -                       /*lint -fallthrough */
> > +                       fallthrough;
> >
> >                 case ARGI_REFERENCE:    /* References: */
> >                 case ARGI_INTEGER_REF:
> > diff --git a/drivers/acpi/acpica/exstore.c
> > b/drivers/acpi/acpica/exstore.c index 3adc0a29d890..2067baa7c120
> > 100644
> > --- a/drivers/acpi/acpica/exstore.c
> > +++ b/drivers/acpi/acpica/exstore.c
> > @@ -95,8 +95,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
> >                 if (dest_desc->common.flags & AOPOBJ_AML_CONSTANT) {
> >                         return_ACPI_STATUS(AE_OK);
> >                 }
> > -
> > -               /*lint -fallthrough */
> > +               fallthrough;
> >
> >         default:
> >
> > @@ -421,8 +420,7 @@ acpi_ex_store_object_to_node(union acpi_operand_obj=
ect *source_desc,
> >                                 }
> >                                 break;
> >                         }
> > -
> > -                       /* Fallthrough */
> > +                       fallthrough;
> >
> >                 case ACPI_TYPE_DEVICE:
> >                 case ACPI_TYPE_EVENT:
> > diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
> > index b13a4ed5bc63..fbfad80c8a53 100644
> > --- a/drivers/acpi/acpica/hwgpe.c
> > +++ b/drivers/acpi/acpica/hwgpe.c
> > @@ -166,8 +166,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe=
_event_info, u32 action)
> >                 if (!(register_bit & gpe_register_info->enable_mask)) {
> >                         return (AE_BAD_PARAMETER);
> >                 }
> > -
> > -               /*lint -fallthrough */
> > +               fallthrough;
> >
> >         case ACPI_GPE_ENABLE:
> >
> > diff --git a/drivers/acpi/acpica/utdelete.c
> > b/drivers/acpi/acpica/utdelete.c index 4c0d4e434196..8076e7947585
> > 100644
> > --- a/drivers/acpi/acpica/utdelete.c
> > +++ b/drivers/acpi/acpica/utdelete.c
> > @@ -111,8 +111,7 @@ static void acpi_ut_delete_internal_obj(union acpi_=
operand_object *object)
> >                         (void)acpi_ev_delete_gpe_block(object->device.
> >                                                        gpe_block);
> >                 }
> > -
> > -               /*lint -fallthrough */
> > +               fallthrough;
> >
> >         case ACPI_TYPE_PROCESSOR:
> >         case ACPI_TYPE_THERMAL:
> > diff --git a/drivers/acpi/acpica/utprint.c
> > b/drivers/acpi/acpica/utprint.c index 681c11f4af4e..f7e43baf5ff2
> > 100644
> > --- a/drivers/acpi/acpica/utprint.c
> > +++ b/drivers/acpi/acpica/utprint.c
> > @@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const c=
har *format, va_list args)
> >                 case 'X':
> >
> >                         type |=3D ACPI_FORMAT_UPPER;
> > -                       /* FALLTHROUGH */
> > +                       fallthrough;
> >
> >                 case 'x':
> >
> > --
> > 2.29.2.222.g5d2a92d10f8-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
