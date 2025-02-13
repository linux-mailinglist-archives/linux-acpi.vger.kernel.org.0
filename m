Return-Path: <linux-acpi+bounces-11158-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57364A34EFF
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 21:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4DA3AD7BD
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6301624A063;
	Thu, 13 Feb 2025 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDuERIz0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CEE28A2CB;
	Thu, 13 Feb 2025 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477171; cv=none; b=hCpYgl3dXn/fmzVe5zBdi77Arfnk9Eg/TNXLtZmbnv4n8mn22WyZyG897mTt5GdUD7AX3UiaH+llLLe6xZIfIVpsLBmo7VRxSCTQuw9uVTGdN2H7ScPXGG2MWVBCVs9dsJzOfpSsB1JCencnkUKFy+zUf6nrH4UdXNB+qL+U81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477171; c=relaxed/simple;
	bh=mCN3VpXG6z9LYldh7fp7vpBtvOPbw9KgEfp4VlfW3OA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqDLR49urc4+hfEJEkVaPFKO0hcckyMLpsnxI+006gV+OitSxSAN6qT4e5zcnLJ2rOFSs89NyUiJChr4RColcLEp75l3+tOjCIDTLKeL5+r0661rnRo/+5KSE4+32vwl+xSvPLMBkVzXUdxA+nLGligkT+VFqcGdKdFy9+ythiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDuERIz0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dc5764fc0so1125449f8f.3;
        Thu, 13 Feb 2025 12:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739477168; x=1740081968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFWSKGq/+VeAg/ZFekjDr253EpytQ2orEc7w8CFpmgc=;
        b=BDuERIz0m32OTpo3y4t3RRTOwy4GGuw5L3RFS475FKVJ8CBe1gxNfx5P4Wen38/tWf
         Z90DKhE9PAn6R9pM6VvIxAu9x9G619ywFyQLG9viKxj4yN94wbYK08x1sVwKl0tztqid
         iSo0xYQARrbUmQyXa4siGfIBa8vCUjX2uzw//qL7ww7P2AZvg2MLp1Y+dbqLUL8FO6UJ
         36JnaTJWt4paXVh2PnhgBCzQD8CYKDXQPdFjQTyC8/9wLJlAMIXWduN9rH7hwijAYYTu
         sKKsZYwx/Jef1GVsffWhv7FcmHWwpipZfKQkXDahGkMPSx4ltFOu3Gw7M+vade2z/iG7
         KKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477168; x=1740081968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFWSKGq/+VeAg/ZFekjDr253EpytQ2orEc7w8CFpmgc=;
        b=mC9ObczhPAbO1Ctw11rZH0HhMmT3W5rK6mHIoJDMTijPzzIeIvnnAjKaoCPRDLMyXP
         uG4putOPruMQZ1PaEB5zLAGLUk2o2+gCNcyrrsek3wKlyAhTk+gcwQ/cXFMba4kq44S2
         jQTWL3D2AlOxpt8ForXpLSa0RPuzsmO7WJimHe6D196Ij/zdBTYH8EITv0vGZqcPU0TK
         JHfOjlMCgcjPXtc02zqBZ/QEIIk4vrVmuH2KjEQghD4/pyBffUBlwe7J0EO38ER2ev7P
         qf27FjiZyGyjL6cf8ejIpoJ598ez16nq07V71KFpubhX/vsTX0wf3hyIrGeACVuSc0rQ
         kKzg==
X-Forwarded-Encrypted: i=1; AJvYcCVU19M4KVSbVpUQ8x3o37Q3oNfdi1HV3l5Sv0CVD6VV815FUXeLQ0vuDLl/+QFFr6V5F+zzRuBF5vN9@vger.kernel.org, AJvYcCXfSIJirOcOV9rBUgrzurd9bruuq0MIOsT7Y7aq7X/ShpbiAcVru3HIsggiaruxaPtBlRI/e2HLeP+ZcNBL@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ4EGP9R8NldpDgZViQlNUWJnmfiOTW+FBNd48RaYs2tvd9Xcf
	IgCNWOYFICV4arCdbXsV1XtppqZ1qcoGWAUJNSbTVGDsv66DUBBi18hG5Q==
X-Gm-Gg: ASbGncsfttMFSvlVu4UlxbZXYosnAHKhhVD00OVhGup6Kp/au5I37AbEpneWFTVrL1o
	lCjOc/j9MryeOum7JlI2BZNXK1eE0LQ+jGFKHnPTjMePQI+fpvO2OUpJxF9QeRdFJnwypUougz7
	byEVvjdIJEwsgZscPUHbZNZO/5RoodKdOgokWWuaMF1+jGPvhUdr3PJ8/GnpW9Ki/gBHFrSMufY
	y5nzyP2C0Tpf472URpGEf/l1eKd5oBax2uXZsS00flvX9nFqVBId9zqgsRtG3D+8aPgpD3U5NNJ
	mI7OLx0Rq5MMhIenDLhvPub44uO2WUb6awDZ3hVzwO3aR/7NqnLKBA==
X-Google-Smtp-Source: AGHT+IFIYdPbaTR0oSgEbQKzG6IJzg6Sppl6mAnXLuL2IVvEI9v1TtzODHWsdbE7aHp7Ki3yK/yNfA==
X-Received: by 2002:a5d:5986:0:b0:38f:2230:c0ff with SMTP id ffacd0b85a97d-38f2230c182mr7095382f8f.30.1739477167530;
        Thu, 13 Feb 2025 12:06:07 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618a98cesm25940825e9.37.2025.02.13.12.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:06:06 -0800 (PST)
Date: Thu, 13 Feb 2025 20:06:05 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>, rafael.j.wysocki@intel.com,
 lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ACPI: Fix building with GCC 15
Message-ID: <20250213200605.6e62302a@pumpkin>
In-Reply-To: <CAMj1kXGvgad183WbUHPGduXHEahfoWasued-LdJ+Tkhc=z-9GA@mail.gmail.com>
References: <20250121214219.1455896-1-brahmajit.xyz@gmail.com>
	<CAMj1kXGvgad183WbUHPGduXHEahfoWasued-LdJ+Tkhc=z-9GA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Feb 2025 16:46:56 +0100
Ard Biesheuvel <ardb@kernel.org> wrote:

> On Tue, 21 Jan 2025 at 22:42, Brahmajit Das <brahmajit.xyz@gmail.com> wro=
te:
> >
> > Building with GCC 15 results in the following build error:
> >
> > ...
> >   CC      drivers/acpi/tables.o
> > In file included from ./include/acpi/actbl.h:371,
> >                  from ./include/acpi/acpi.h:26,
> >                  from ./include/linux/acpi.h:26,
> >                  from drivers/acpi/tables.c:19:
> > ./include/acpi/actbl1.h:30:33: error: initializer-string for array of =
=E2=80=98char=E2=80=99 is too long [-Werror=3Dunterminated-string-initializ=
ation]
> >    30 | #define ACPI_SIG_BERT           "BERT"  /* Boot Error Record Ta=
ble */
> >       |                                 ^~~~~~
> > drivers/acpi/tables.c:400:9: note: in expansion of macro =E2=80=98ACPI_=
SIG_BERT=E2=80=99
> >   400 |         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_E=
CDT,
> >       |         ^~~~~~~~~~~~~
> > ./include/acpi/actbl1.h:31:33: error: initializer-string for array of =
=E2=80=98char=E2=80=99 is too long [-Werror=3Dunterminated-string-initializ=
ation]
> >    31 | #define ACPI_SIG_BGRT           "BGRT"  /* Boot Graphics Resour=
ce Table */
> >       |                                 ^~~~~~
> > drivers/acpi/tables.c:400:24: note: in expansion of macro =E2=80=98ACPI=
_SIG_BGRT=E2=80=99
> >   400 |         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_E=
CDT,
> >       |                        ^~~~~~~~~~~~~
> > ./include/acpi/actbl1.h:34:33: error: initializer-string for array of =
=E2=80=98char=E2=80=99 is too long [-Werror=3Dunterminated-string-initializ=
ation]
> >    34 | #define ACPI_SIG_CPEP           "CPEP"  /* Corrected Platform E=
rror Polling table */
> > ...
> >
> > This is due to GCC having enabled
> > -Werror=3Dunterminated-string-initialization[0] by default. To work aro=
und
> > this build time error we're modifying the size of table_sigs from
> > table_sigs[][ACPI_NAMESEG_SIZE] to table_sigs[][ACPI_NAMESEG_SIZE + 1].
> > This ensures space for NUL, thus satisfying GCC.
> >
> > [0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-=
unterminated-string-initialization
> >
> > Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
> > ---
> >  drivers/acpi/tables.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index 9e1b01c35070..5a6524eb79d8 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -396,7 +396,7 @@ static u8 __init acpi_table_checksum(u8 *buffer, u3=
2 length)
> >  }
> >
> >  /* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
> > -static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst =3D {
> > +static const char table_sigs[][ACPI_NAMESEG_SIZE + 1] __initconst =3D {
> >         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
> >         ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
> >         ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT, =20
>=20
> Please add the __nonstring attribute instead.

That doesn't fix initialisers.
There is a gcc bug about it (and a patch)...

	David



