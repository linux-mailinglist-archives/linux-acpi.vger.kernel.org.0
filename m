Return-Path: <linux-acpi+bounces-13033-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B063FA888B7
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 18:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E140E1899649
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7E9284661;
	Mon, 14 Apr 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIhDQlgt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FDA2820AF;
	Mon, 14 Apr 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648786; cv=none; b=s81YuoolsKfikhuH39fdCLp6vxZn/LlKxoh5og9z1KO4jGKzMX76L0pBWHoPqijgP+QhMZEhgzS48y0Yt5TVibvF60/IC/ItKV6t4RAcMY6Uhhb2hnUcmP5xQwIN+GyJyL2DoozghHX6ix74xxoSKriAxDqpdM/x5OJR0f/9sU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648786; c=relaxed/simple;
	bh=/BWM72Gw+JlRPZjFofHf/m4rh6XTqLR0FpiqT9E7JXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLMLRd4t69L6RuRVW/3bwn4qZfdNX8qZeqBkTD3wYqN9YWQCKBtNvjltV/Si24U1v4NLVWHK5Og7pmRB6PRJmjtkC34e3NWK6FDfe1bRB3wdaZF4SvX6vtG4VS21M3mfSIleNc72iWsfJ+GN7GyyxPOXIEII1jF8bVFhI8n6+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIhDQlgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD380C4AF0B;
	Mon, 14 Apr 2025 16:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744648785;
	bh=/BWM72Gw+JlRPZjFofHf/m4rh6XTqLR0FpiqT9E7JXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pIhDQlgtTWFB7bHqfdhjg8c/BKAVWzlsXOfOH88JBByrpAoosqZl5wNi66OC8qNT5
	 Z8HbGJkqBouhlCF7PfBguLoxnON4c1zdRsiO1Z+khios1/Vkb9eZPVk4naqH0m8eb/
	 A13rPuoujijqf4WVLFci2+Gh96RnlAg/8CbNYIMU5tfhNI/USMdIxe9c1BWfSCDtiP
	 T2ZzIaZgd+6ALlpTLhJGSZIgNPK7Ucp+cuuAF+cctITz3q4bhsyu3LpV7Ln6QABd0N
	 mg+ytigeThMyZDNF6XPTiausy1GKOTzd8pqqMAMbbQJrl43cl/fnlNWzxGiDUliQrq
	 nAbIPwUjFI/sQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c764f2c223so1621534fac.0;
        Mon, 14 Apr 2025 09:39:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBxFGXBETpr5uM5VuogHwwiirMsm1AbKMN5G3z+OneJCXCbZmigLKbUeFBP1u2DnpjPHoKLqy/LgnrACIk@vger.kernel.org, AJvYcCXbdLLoAPfVr5Vg4L+cxxuCHBZwQP4xstHhGNg55ybaObIsOyQ0ZNt+YnCtU7LC+Z1n6h2Q2JS8aBCN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw65Yd6yQA8WlkbmsYJxqaDjrcgF2v8oYILuCUkPIH6F5hHqgkV
	J7WVHbojgydPjnme+7/HRHMsPEqeEvUFkanfF262twq9yKIMceXwP7LxQLqTLmCT+5xEYnjZnLn
	rpblO3ccra4tVHEPuRek5SXCPvXQ=
X-Google-Smtp-Source: AGHT+IHX6hhnTAkYMSBhO8VaJe1f0kRee/X1S3jntSDwIix4P2GuvFzvWTo1WMiFCMJfYdN672Ib5rpPKSxaDrAL0SQ=
X-Received: by 2002:a05:6871:7a8b:b0:2c1:650b:fc86 with SMTP id
 586e51a60fabf-2d0d5c2ef03mr7397787fac.1.1744648785093; Mon, 14 Apr 2025
 09:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161644.30400-1-listout@listout.xyz> <kjxkqexdkyesepwtyjsp2uuo73r65msvhl7ccxt77wv722gw3j@7ekim6v5clrh>
In-Reply-To: <kjxkqexdkyesepwtyjsp2uuo73r65msvhl7ccxt77wv722gw3j@7ekim6v5clrh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 14 Apr 2025 18:39:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hxDG=1E=nKGKU9JGWweVRC8CkWRxDvDGBe5XG492oyTg@mail.gmail.com>
X-Gm-Features: ATxdqUEHNyNEsGsDYB9CFtNLI4jjm0kSv94frfyuSV26yb8b2AE-ahwGIC6aZRU
Message-ID: <CAJZ5v0hxDG=1E=nKGKU9JGWweVRC8CkWRxDvDGBe5XG492oyTg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: Fix building with GCC 15
To: Brahmajit <brahmajit.xyz@gmail.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 6:25=E2=80=AFPM Brahmajit <brahmajit.xyz@gmail.com>=
 wrote:
>
> On 14.04.2025 21:46, Brahmajit Das wrote:
> > Since the Linux kernel initializes many non-C-string char arrays with
> > literals. While it would be possible to convert initializers from:
> >    { "BOOP", ... }
> > to something like:
> >    { { 'B', 'O', 'O', 'P' }, ... }
> > that is annoying.
> > Making -Wunterminated-string-initialization stay silent about char
> > arrays marked with nonstring would be much better.
> >
> > Without the __attribute__((nonstring)) we would get the following build
> > error:
> >
> > ...
> > drivers/acpi/acpica/acpredef.h:903:11: error: initializer-string for ar=
ray of =E2=80=98char=E2=80=99 truncates NUL terminator but destination lack=
s =E2=80=98nonstring=E2=80=99 attribute (5 chars into 4 available) [-Werror=
=3Dunterminated-string-initialization]
> >   903 |         {{"_S3D", METHOD_0ARGS,
> >       |           ^~~~~~
> > drivers/acpi/acpica/acpredef.h:906:11: error: initializer-string for ar=
ray of =E2=80=98char=E2=80=99 truncates NUL terminator but destination lack=
s =E2=80=98nonstring=E2=80=99 attribute (5 chars into 4 available) [-Werror=
=3Dunterminated-string-initialization]
> >   906 |         {{"_S4D", METHOD_0ARGS,
> >       |           ^~~~~~
> >
> > and,
> >
> > ...
> > drivers/acpi/acpica/nsrepair2.c:115:10: error: initializer-string for a=
rray of =E2=80=98char=E2=80=99 truncates NUL terminator but destination lac=
ks =E2=80=98nonstring=E2=80=99 attribute (5 chars into 4 available) [-Werro=
r=3Dunterminated-string-initialization]
> >   115 |         {"_ALR", acpi_ns_repair_ALR},
> >       |          ^~~~~~
> > drivers/acpi/acpica/nsrepair2.c:116:10: error: initializer-string for a=
rray of =E2=80=98char=E2=80=99 truncates NUL terminator but destination lac=
ks =E2=80=98nonstring=E2=80=99 attribute (5 chars into 4 available) [-Werro=
r=3Dunterminated-string-initialization]
> >   116 |         {"_CID", acpi_ns_repair_CID},
> > ...
> >
> > Upstream GCC has added this commit
> > 622968990beee7499e951590258363545b4a3b57[0][1] which silences warning
> > about truncating NUL char when initializing nonstring arrays.
> >
> > [0]: https://gcc.gnu.org/cgit/gcc/commit/?id=3D622968990beee7499e951590=
258363545b4a3b57
> > [1]: https://gcc.gnu.org/cgit/gcc/commit/?id=3Dafb46540d3921e96c4cd7ba8=
fa2c8b0901759455
> >
> > Thanks to Jakub Jelinek <jakub@gcc.gnu.org> for the gcc patch.
> >
> > Signed-off-by: Brahmajit Das <listout@listout.xyz>
> > ---
> >  drivers/acpi/acpica/aclocal.h   |  4 ++--
> >  drivers/acpi/acpica/nsrepair2.c |  2 +-
> >  drivers/acpi/tables.c           | 28 +++++++++++++++-------------
> >  include/acpi/actbl.h            |  3 ++-
> >  4 files changed, 20 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/acloca=
l.h
> > index 6f4fe47c955b..d2cda1b35e59 100644
> > --- a/drivers/acpi/acpica/aclocal.h
> > +++ b/drivers/acpi/acpica/aclocal.h
> > @@ -293,7 +293,7 @@ acpi_status (*acpi_internal_method) (struct acpi_wa=
lk_state * walk_state);
> >   * expected_return_btypes - Allowed type(s) for the return value
> >   */
> >  struct acpi_name_info {
> > -     char name[ACPI_NAMESEG_SIZE];
> > +     char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));
> >       u16 argument_list;
> >       u8 expected_btypes;
> >  };
> > @@ -370,7 +370,7 @@ typedef acpi_status (*acpi_object_converter) (struc=
t acpi_namespace_node *
> >                                             converted_object);
> >
> >  struct acpi_simple_repair_info {
> > -     char name[ACPI_NAMESEG_SIZE];
> > +     char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));
> >       u32 unexpected_btypes;
> >       u32 package_index;
> >       acpi_object_converter object_converter;
> > diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsre=
pair2.c
> > index 1bb7b71f07f1..a28b1fa2b1ea 100644
> > --- a/drivers/acpi/acpica/nsrepair2.c
> > +++ b/drivers/acpi/acpica/nsrepair2.c
> > @@ -25,7 +25,7 @@ acpi_status (*acpi_repair_function) (struct acpi_eval=
uate_info * info,
> >                                    return_object_ptr);
> >
> >  typedef struct acpi_repair_info {
> > -     char name[ACPI_NAMESEG_SIZE];
> > +     char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));
> >       acpi_repair_function repair_function;
> >
> >  } acpi_repair_info;
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index 2295abbecd14..27104cbb48b5 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -396,19 +396,21 @@ static u8 __init acpi_table_checksum(u8 *buffer, =
u32 length)
> >  }
> >
> >  /* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
> > -static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst =3D {
> > -     ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
> > -     ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
> > -     ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,
> > -     ACPI_SIG_ASF,  ACPI_SIG_BOOT, ACPI_SIG_DBGP, ACPI_SIG_DMAR,
> > -     ACPI_SIG_HPET, ACPI_SIG_IBFT, ACPI_SIG_IVRS, ACPI_SIG_MCFG,
> > -     ACPI_SIG_MCHI, ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI,
> > -     ACPI_SIG_TCPA, ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT,
> > -     ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
> > -     ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
> > -     ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> > -     ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
> > -     ACPI_SIG_NBFT };
> > +static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst
> > +     __attribute__((nonstring)) =3D {
> > +             ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECD=
T,
> > +             ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MAD=
T,
> > +             ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRA=
T,
> > +             ACPI_SIG_ASF,  ACPI_SIG_BOOT, ACPI_SIG_DBGP, ACPI_SIG_DMA=
R,
> > +             ACPI_SIG_HPET, ACPI_SIG_IBFT, ACPI_SIG_IVRS, ACPI_SIG_MCF=
G,
> > +             ACPI_SIG_MCHI, ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPM=
I,
> > +             ACPI_SIG_TCPA, ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDA=
T,
> > +             ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FAD=
T,
> > +             ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSD=
T,
> > +             ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPT=
T,
> > +             ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGD=
I,
> > +             ACPI_SIG_NBFT
> > +     };
> >
> >  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
> >
> > diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
> > index 451f6276da49..88ba1b978053 100644
> > --- a/include/acpi/actbl.h
> > +++ b/include/acpi/actbl.h
> > @@ -66,7 +66,8 @@
> >   *********************************************************************=
*********/
> >
> >  struct acpi_table_header {
> > -     char signature[ACPI_NAMESEG_SIZE];      /* ASCII table signature =
*/
> > +     char signature[ACPI_NAMESEG_SIZE]
> > +             __attribute__((nonstring)); /* ASCII table signature */
> >       u32 length;             /* Length of table in bytes, including th=
is header */
> >       u8 revision;            /* ACPI Specification minor version numbe=
r */
> >       u8 checksum;            /* To make sum of entire table =3D=3D 0 *=
/
> > --
> > 2.49.0
> >
>
> Do I need to send the acpica part to GitHub first?

No, this problem will be taken care of differently.

Thanks!

