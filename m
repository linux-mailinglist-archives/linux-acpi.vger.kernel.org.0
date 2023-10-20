Return-Path: <linux-acpi+bounces-821-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1927D15E3
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 20:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658972825D4
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0C2230E
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA661E530;
	Fri, 20 Oct 2023 17:52:07 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE00D7A;
	Fri, 20 Oct 2023 10:51:58 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5841a3ffd50so167160eaf.1;
        Fri, 20 Oct 2023 10:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824317; x=1698429117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YTvVJcQz2c1GSUauUHzJC51/1wS22ypJSmFjh/ul+A=;
        b=pV+joKVnwC7rr/jmVfPm0NTU/03K9SC1Ovr0FdV4FzEml3gZ8HarGbsR/n7kboptXq
         pW1JhS1imFfVdfbOKl8Dr4PNdj5ZYY9sIor8bS9NPLHp/bBXaiNksNgrzDwqkmnp8Sm2
         vCRcmNjL+Du9ToL1GuvCbjt8BrRUJUfB2a9KunLHIg2R2DHZPS104xLQZFhZ0ZPF+vWx
         W0gwolC4aNyRLQ2qGWNQjkFzQ8iVEHANy3LYekprFNbasgE0BIJUVtb10S2mOuXSxFbn
         4x0ruBqipxy4JvGQVLc5lCubtYTZqjHNIDar0Hd1vkxaQpdHf8HYWcfHcMJAvyTZ//Co
         a1xA==
X-Gm-Message-State: AOJu0YyEj59qDIUPziLfsyGfpLGqxVhR2bJC9hi9a1ElS9cns9u2Bmdt
	CI57U+vWfApsBaM2KnradfBDJ+fXwJrjxIimvTY=
X-Google-Smtp-Source: AGHT+IEszQZZSTEk4fRBQBlPR0nCE91NhJrcZhXhisZSY+ocod2wYCitAATOlitSwaZkgWDcDqw7KcqAfgRHLVcpvZg=
X-Received: by 2002:a4a:c44b:0:b0:584:1080:f0a5 with SMTP id
 h11-20020a4ac44b000000b005841080f0a5mr2776194ooq.1.1697824317392; Fri, 20 Oct
 2023 10:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019-strncpy-drivers-pnp-pnpbios-rsparser-c-v1-1-e47d93b52e3e@google.com>
 <202310191637.9EBDCC364@keescook>
In-Reply-To: <202310191637.9EBDCC364@keescook>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Oct 2023 19:51:46 +0200
Message-ID: <CAJZ5v0i9pfVCGVE1s0J082C8FKvNVv+Kng2MwryfSuy+6PC4eg@mail.gmail.com>
Subject: Re: [PATCH] PNP: replace deprecated strncpy with memcpy
To: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 2:31=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Oct 19, 2023 at 11:28:32PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous
> > interfaces.
> >
> > After having precisely calculated the lengths and ensuring we don't
> > overflow the buffer, this really decays to just a memcpy. Let's not use
> > a C string api as it makes the intention of the code confusing.
>
> This is another case where we're building a C string from a byte array.
>
> > It'd be nice to use strscpy() in this case (as we clearly want
> > NUL-termination) because it'd clean up the code a bit. However, I don't
> > quite know enough about what is going on here to justify a drop-in
> > replacement -- too much bit magic and why (PNP_NAME_LEN - 2)? I'm afrai=
d
> > using strscpy() may result in copying too many or too few bytes into ou=
r
> > dev->name buffer resulting in different behavior. At least using
> > memcpy() we can ensure the behavior is exactly the same.
> >
> > Side note:
> > NUL-padding is not required because insert_device() calls
> > pnpbios_parse_data_stream() with a zero-allocated `dev`:
> > 299 |  static int __init insert_device(struct pnp_bios_node *node) {
> > ...
> > 312 |  dev =3D pnp_alloc_dev(&pnpbios_protocol, node->handle, id);
> > ...
> > 316 |  pnpbios_parse_data_stream(dev, node);
> >
> > then pnpbios_parse_data_stream() calls pnpbios_parse_compatible_ids().
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> tl;dr:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> My ramblings below...
>
> > ---
> > Note: build-tested only.
> >
> > Found with: $ rg "strncpy\("
> > ---
> >  drivers/pnp/pnpbios/rsparser.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pnp/pnpbios/rsparser.c b/drivers/pnp/pnpbios/rspar=
ser.c
> > index 2f31b212b1a5..70af7821d3fa 100644
> > --- a/drivers/pnp/pnpbios/rsparser.c
> > +++ b/drivers/pnp/pnpbios/rsparser.c
> > @@ -454,8 +454,8 @@ static unsigned char *pnpbios_parse_compatible_ids(=
unsigned char *p,
> >               switch (tag) {
>
> So we've got a fixed-sized C string as a destination:
>
> struct pnp_dev {
>         ...
>         char name[PNP_NAME_LEN];        /* contains a human-readable name=
 */
>
> include/linux/pnp.h:#define PNP_NAME_LEN                50
>
> And a funky "source length" calculation, which appears to be effectively
> a u16 (it's either the low 3 bits of a u8, or a full u16);
>
>         int len ...
>
>                 /* determine the type of tag */
>                 if (p[0] & LARGE_TAG) { /* large tag */
>                         len =3D (p[2] << 8) | p[1];
>                         tag =3D p[0];
>                 } else {        /* small tag */
>                         len =3D p[0] & 0x07;
>                         tag =3D ((p[0] >> 3) & 0x0f);
>                 }
>
> The old code was doing:
>
>                 case LARGE_TAG_ANSISTR:
>                         strncpy(dev->name, p + 3,
>                                 len >=3D PNP_NAME_LEN ? PNP_NAME_LEN - 2 =
: len);
>                         dev->name[len >=3D
>                                   PNP_NAME_LEN ? PNP_NAME_LEN - 1 : len] =
=3D '\0';
>                         break;
>
> The two conditionals are not the same -- the first is -2, the latter is
> -1, but only when len >=3D PNP_NAME_LEN. This smells like a bug? For the
> len >=3D PNP_NAME_LEN case, it will copy 48 bytes and then write a %NUL t=
o
> index 49 (byte 50). ... ... source byte 49 is ignored for no reason I
> can see.
>
> Regardless, the point is to copy no more than min(len, PNP_NAME_LEN - 1)
> from "p + 3" to not overflow dev->name, and leaving it %NUL terminated.
>
> So, I think what you have is identical behavior, and likely still
> contains the 1 byte short bug, which I think is fine to keep as-is since
> it's been like this forever and it's PNP...

And so applied as 6.7 material, thanks!

