Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ECB2B1309
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 01:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgKMAJQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 19:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKMAJQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 19:09:16 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F33C0613D1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 16:09:16 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id g11so3637055pll.13
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2020 16:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2DHsDoriK54ucih8d4V/3kj6D7gH+qZ0YXsshl+T4v0=;
        b=CzElBqwWilQwhy6JBOgUZY6M7XqXa+yl5U9ZdhZoZR5NE6dY1ajkPehr8X+pOXYAsB
         W+qtHA8cHgfnCfGC5b0vsesszBUj/ZRlpOePuIKM90t5ASEVVK1DRJ1ICWtloJOvICMq
         usqzCvJfTuiDZJukhpZ5gsW9TRqWGf/thsBmg2/Na8WQwKG+NEO91ez8QqBQRP2aF/Wp
         NYMNHSCacOq+lrriq1DJ5U+kcZEXHACqUqSQocro4I1nC90Zo2AD49qMTlIYbzojzmvP
         WSyZd2wc/iBq1qC7WLZeNeApaqajj5o+Dtt+g6iMXLiAaemt0Yb3j2gMaRwj0tXuzqKd
         Ivfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2DHsDoriK54ucih8d4V/3kj6D7gH+qZ0YXsshl+T4v0=;
        b=jUD7ul1wmE3VdURTWtaYPnb3+oUkcroLLSDUFU2UBzZLGG9DlibZromhLFMpWUQXV3
         CG8IbFik+J+W9T/NAJk+oL2poABn5AofLpDmO+mXC8oxxBlqfHJlO1walZvizzggthBS
         hp8weljFI4GbwYoA1Zlm4Am0MIZjYzQr/XvOMVE/ts4XaVKQy5uBdAJul4NqQ6Ksk1Nh
         yshiKBG9YgbvU98xcnDjk8BPIjMaQihRqXHlRmltYv7btWd10C+S8iZ56M/gMcCs39Gc
         e01yWPoR3Ya4BvWDISAG6deQnZENBAaJPuDwIMQldgAZBOpwmQkC45ciDH4o5gghC07o
         mYnw==
X-Gm-Message-State: AOAM532vxJjIAMCPXVE7vFOSu0s/HHDkvfcbevD7GpGcdQpng92Rrwkx
        X5fIxzh84T8+p/fzCYbAdfb4LDNK+y8YLvcISsP7mg==
X-Google-Smtp-Source: ABdhPJyZjo0cz+beY9g0VqJ59VUwS4NabDi36DB+VIb4/zk37mZeh2ChUQXkriQmeZwGU0Ph4EVBf9U9zcPnnnaLysk=
X-Received: by 2002:a17:902:760c:b029:d6:efa5:4cdd with SMTP id
 k12-20020a170902760cb02900d6efa54cddmr1571407pll.56.1605226154891; Thu, 12
 Nov 2020 16:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20201111021131.822867-1-ndesaulniers@google.com>
 <BYAPR11MB3256E0C1DCB4F01D18DF709F87E80@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdk2U5+DcXYyMoBAhyaa67EukhB6QMEUbRPcOF7P3Sz21w@mail.gmail.com>
 <BYAPR11MB3256C9711620932685C368F887E70@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com> <BYAPR11MB3256BEF30840D4AB440A359C87E70@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3256BEF30840D4AB440A359C87E70@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Nov 2020 16:09:03 -0800
Message-ID: <CAKwvOdnYpmf=ydFVWSqVkWeUpn+M2v9PfdQd71T3oqQ9_1WQaQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
To:     "Moore, Robert" <robert.moore@intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Thu, Nov 12, 2020 at 1:48 PM Moore, Robert <robert.moore@intel.com> wrot=
e:
>
>
>
> -----Original Message-----
> From: Nick Desaulniers <ndesaulniers@google.com>
> Sent: Thursday, November 12, 2020 11:31 AM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wys=
ocki@intel.com>; Gustavo A . R . Silva <gustavoars@kernel.org>; clang-built=
-linux@googlegroups.com; Len Brown <lenb@kernel.org>; linux-acpi@vger.kerne=
l.org; devel@acpica.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
>
> On Thu, Nov 12, 2020 at 7:13 AM Moore, Robert <robert.moore@intel.com> wr=
ote:
> >
> >
> >
> > -----Original Message-----
> > From: Nick Desaulniers <ndesaulniers@google.com>
> > Sent: Wednesday, November 11, 2020 10:48 AM
> > To: Moore, Robert <robert.moore@intel.com>
> > Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>; Gustavo A . R . Silva
> > <gustavoars@kernel.org>; clang-built-linux@googlegroups.com; Len Brown
> > <lenb@kernel.org>; linux-acpi@vger.kernel.org; devel@acpica.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
> >
> > On Wed, Nov 11, 2020 at 7:15 AM Moore, Robert <robert.moore@intel.com> =
wrote:
> > >
> > > Yes, but: isn't the "fallthrough" keyword compiler-specific? That is =
the problem for us.
> >
> > It's not a keyword.
> >
> > It's a preprocessor macro that expands to
> > __attribute__((__fallthrough__)) for compilers that support it.  For co=
mpilers that do not, it expands to nothing.  Both GCC 7+ and Clang support =
this attribute.  Which other compilers that support -Wimplicit-fallthrough =
do you care to support?
> >
> > We need to support MSVC 2017 -- which apparently does not support this.
>
> In which case, the macro is not expanded to a compiler attribute the comp=
iler doesn't support.  Please see also its definition in include/linux/comp=
iler_attributes.h.
>
> From what I can tell, MSVC does not warn on implicit fallthrough, so ther=
e's no corresponding attribute (or comment) to disable the warning in MSVC.
>
> That doesn't mean this code is not portable to MSVC; a macro that expands=
 to nothing should not be a problem.
>
> Based on
> https://docs.microsoft.com/en-us/cpp/code-quality/c26819?view=3Dmsvc-160
> https://developercommunity.visualstudio.com/idea/423975/issue-compiler-wa=
rning-when-using-implicit-fallthr.html
> it sounds like MSVC 2019 will be able to warn, for C++ mode, which will r=
ely on the C++ style attribute to annotate intentional fallthrough.
>
> Can you confirm how this does not work for MSVC 2017?
>
> 1>c:\acpica\source\components\utilities\utdelete.c(270): warning C4013: '=
__attribute__' undefined; assuming extern returning int
> 1>c:\acpica\source\components\utilities\utdelete.c(270): error C2065: '__=
fallthrough__': undeclared identifier
> 1>c:\acpica\source\components\utilities\utdelete.c(272): error C2143: syn=
tax error: missing ';' before 'case'

Thank you for the explicit diagnostics observed.  Something fishy is
going on though, https://godbolt.org/z/Gbxbxa is how I expect MSVC to
handle include/linux/compiler_attributes.h.

The C preprocessor should make it such that MSVC never sees
`__attribute__` or `__fallthrough__`; that it does begs the question.
That would seem to imply that `#if __has_attribute(__fallthrough__)`
somehow evaluates to true on MSVC, but my godbolt link shows it does
not.

Could the upstream ACPICA project be #define'ing something that could
be altering this? (Or not #define'ing something?)

Worst case, we could do as Joe Perches suggested and disable
-Wfallthrough for drivers/acpi/acpica/.

>
> > > Bob
> > >
> > >
> > > -----Original Message-----
> > > From: ndesaulniers via sendgmr
> > > <ndesaulniers@ndesaulniers1.mtv.corp.google.com> On Behalf Of Nick
> > > Desaulniers
> > > Sent: Tuesday, November 10, 2020 6:12 PM
> > > To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> > > <erik.kaneda@intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki@intel.com>; Gustavo A . R . Silva
> > > <gustavoars@kernel.org>
> > > Cc: clang-built-linux@googlegroups.com; Nick Desaulniers
> > > <ndesaulniers@google.com>; Len Brown <lenb@kernel.org>;
> > > linux-acpi@vger.kernel.org; devel@acpica.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: [PATCH] ACPICA: fix -Wfallthrough
> > >
> > > The "fallthrough" pseudo-keyword was added as a portable way to denot=
e intentional fallthrough. This code seemed to be using a mix of fallthroug=
h comments that GCC recognizes, and some kind of lint marker.
> > > I'm guessing that linter hasn't been run in a while from the mixed us=
e of the marker vs comments.
> > >
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  drivers/acpi/acpica/dscontrol.c | 3 +--
> > >  drivers/acpi/acpica/dswexec.c   | 4 +---
> > >  drivers/acpi/acpica/dswload.c   | 3 +--
> > >  drivers/acpi/acpica/dswload2.c  | 3 +--
> > >  drivers/acpi/acpica/exfldio.c   | 3 +--
> > >  drivers/acpi/acpica/exresop.c   | 5 ++---
> > >  drivers/acpi/acpica/exstore.c   | 6 ++----
> > >  drivers/acpi/acpica/hwgpe.c     | 3 +--
> > >  drivers/acpi/acpica/utdelete.c  | 3 +--
> > >  drivers/acpi/acpica/utprint.c   | 2 +-
> > >  10 files changed, 12 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/acpi/acpica/dscontrol.c
> > > b/drivers/acpi/acpica/dscontrol.c index 4b5b6e859f62..1e75e5fbfd19
> > > 100644
> > > --- a/drivers/acpi/acpica/dscontrol.c
> > > +++ b/drivers/acpi/acpica/dscontrol.c
> > > @@ -61,8 +61,7 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_stat=
e *walk_state,
> > >                                 break;
> > >                         }
> > >                 }
> > > -
> > > -               /*lint -fallthrough */
> > > +               fallthrough;
> > >
> > >         case AML_IF_OP:
> > >                 /*
> > > diff --git a/drivers/acpi/acpica/dswexec.c
> > > b/drivers/acpi/acpica/dswexec.c index 1d4f8c81028c..e8c32d4fe55f
> > > 100644
> > > --- a/drivers/acpi/acpica/dswexec.c
> > > +++ b/drivers/acpi/acpica/dswexec.c
> > > @@ -597,9 +597,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_=
state *walk_state)
> > >                                 if (ACPI_FAILURE(status)) {
> > >                                         break;
> > >                                 }
> > > -
> > > -                               /* Fall through */
> > > -                               /*lint -fallthrough */
> > > +                               fallthrough;
> > >
> > >                         case AML_INT_EVAL_SUBTREE_OP:
> > >
> > > diff --git a/drivers/acpi/acpica/dswload.c
> > > b/drivers/acpi/acpica/dswload.c index 27069325b6de..afc663c3742d
> > > 100644
> > > --- a/drivers/acpi/acpica/dswload.c
> > > +++ b/drivers/acpi/acpica/dswload.c
> > > @@ -223,8 +223,7 @@ acpi_ds_load1_begin_op(struct acpi_walk_state *wa=
lk_state,
> > >                              parse_flags & ACPI_PARSE_MODULE_LEVEL)) =
{
> > >                                 break;
> > >                         }
> > > -
> > > -                       /*lint -fallthrough */
> > > +                       fallthrough;
> > >
> > >                 default:
> > >
> > > diff --git a/drivers/acpi/acpica/dswload2.c
> > > b/drivers/acpi/acpica/dswload2.c index edadbe146506..1b794b6ba072
> > > 100644
> > > --- a/drivers/acpi/acpica/dswload2.c
> > > +++ b/drivers/acpi/acpica/dswload2.c
> > > @@ -213,8 +213,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *wa=
lk_state,
> > >                              parse_flags & ACPI_PARSE_MODULE_LEVEL)) =
{
> > >                                 break;
> > >                         }
> > > -
> > > -                       /*lint -fallthrough */
> > > +                       fallthrough;
> > >
> > >                 default:
> > >
> > > diff --git a/drivers/acpi/acpica/exfldio.c
> > > b/drivers/acpi/acpica/exfldio.c index ade35ff1c7ba..9d1cabe0fed9
> > > 100644
> > > --- a/drivers/acpi/acpica/exfldio.c
> > > +++ b/drivers/acpi/acpica/exfldio.c
> > > @@ -433,8 +433,7 @@ acpi_ex_field_datum_io(union acpi_operand_object =
*obj_desc,
> > >                  * Now that the Bank has been selected, fall through =
to the
> > >                  * region_field case and write the datum to the Opera=
tion Region
> > >                  */
> > > -
> > > -               /*lint -fallthrough */
> > > +               fallthrough;
> > >
> > >         case ACPI_TYPE_LOCAL_REGION_FIELD:
> > >                 /*
> > > diff --git a/drivers/acpi/acpica/exresop.c
> > > b/drivers/acpi/acpica/exresop.c index 4d1b22971d58..df48faa9a551
> > > 100644
> > > --- a/drivers/acpi/acpica/exresop.c
> > > +++ b/drivers/acpi/acpica/exresop.c
> > > @@ -197,8 +197,7 @@ acpi_ex_resolve_operands(u16 opcode,
> > >                                 case ACPI_REFCLASS_DEBUG:
> > >
> > >                                         target_op =3D AML_DEBUG_OP;
> > > -
> > > -                                       /*lint -fallthrough */
> > > +                                       fallthrough;
> > >
> > >                                 case ACPI_REFCLASS_ARG:
> > >                                 case ACPI_REFCLASS_LOCAL:
> > > @@ -264,7 +263,7 @@ acpi_ex_resolve_operands(u16 opcode,
> > >                          * Else not a string - fall through to the no=
rmal Reference
> > >                          * case below
> > >                          */
> > > -                       /*lint -fallthrough */
> > > +                       fallthrough;
> > >
> > >                 case ARGI_REFERENCE:    /* References: */
> > >                 case ARGI_INTEGER_REF:
> > > diff --git a/drivers/acpi/acpica/exstore.c
> > > b/drivers/acpi/acpica/exstore.c index 3adc0a29d890..2067baa7c120
> > > 100644
> > > --- a/drivers/acpi/acpica/exstore.c
> > > +++ b/drivers/acpi/acpica/exstore.c
> > > @@ -95,8 +95,7 @@ acpi_ex_store(union acpi_operand_object *source_des=
c,
> > >                 if (dest_desc->common.flags & AOPOBJ_AML_CONSTANT) {
> > >                         return_ACPI_STATUS(AE_OK);
> > >                 }
> > > -
> > > -               /*lint -fallthrough */
> > > +               fallthrough;
> > >
> > >         default:
> > >
> > > @@ -421,8 +420,7 @@ acpi_ex_store_object_to_node(union acpi_operand_o=
bject *source_desc,
> > >                                 }
> > >                                 break;
> > >                         }
> > > -
> > > -                       /* Fallthrough */
> > > +                       fallthrough;
> > >
> > >                 case ACPI_TYPE_DEVICE:
> > >                 case ACPI_TYPE_EVENT:
> > > diff --git a/drivers/acpi/acpica/hwgpe.c
> > > b/drivers/acpi/acpica/hwgpe.c index b13a4ed5bc63..fbfad80c8a53
> > > 100644
> > > --- a/drivers/acpi/acpica/hwgpe.c
> > > +++ b/drivers/acpi/acpica/hwgpe.c
> > > @@ -166,8 +166,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *g=
pe_event_info, u32 action)
> > >                 if (!(register_bit & gpe_register_info->enable_mask))=
 {
> > >                         return (AE_BAD_PARAMETER);
> > >                 }
> > > -
> > > -               /*lint -fallthrough */
> > > +               fallthrough;
> > >
> > >         case ACPI_GPE_ENABLE:
> > >
> > > diff --git a/drivers/acpi/acpica/utdelete.c
> > > b/drivers/acpi/acpica/utdelete.c index 4c0d4e434196..8076e7947585
> > > 100644
> > > --- a/drivers/acpi/acpica/utdelete.c
> > > +++ b/drivers/acpi/acpica/utdelete.c
> > > @@ -111,8 +111,7 @@ static void acpi_ut_delete_internal_obj(union acp=
i_operand_object *object)
> > >                         (void)acpi_ev_delete_gpe_block(object->device=
.
> > >                                                        gpe_block);
> > >                 }
> > > -
> > > -               /*lint -fallthrough */
> > > +               fallthrough;
> > >
> > >         case ACPI_TYPE_PROCESSOR:
> > >         case ACPI_TYPE_THERMAL:
> > > diff --git a/drivers/acpi/acpica/utprint.c
> > > b/drivers/acpi/acpica/utprint.c index 681c11f4af4e..f7e43baf5ff2
> > > 100644
> > > --- a/drivers/acpi/acpica/utprint.c
> > > +++ b/drivers/acpi/acpica/utprint.c
> > > @@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const=
 char *format, va_list args)
> > >                 case 'X':
> > >
> > >                         type |=3D ACPI_FORMAT_UPPER;
> > > -                       /* FALLTHROUGH */
> > > +                       fallthrough;
> > >
> > >                 case 'x':
> > >
> > > --
> > > 2.29.2.222.g5d2a92d10f8-goog
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
