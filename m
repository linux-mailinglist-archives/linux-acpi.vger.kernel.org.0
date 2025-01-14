Return-Path: <linux-acpi+bounces-10634-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D2A10DAD
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 18:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205C83A3E2E
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB25F1FA8C2;
	Tue, 14 Jan 2025 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLugVW1Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827B51FA854;
	Tue, 14 Jan 2025 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875567; cv=none; b=JONXXVXHH40i1pk94afT2cKfmFNjkl046tz+fd7WH9pmoJMtiKZq1805zr4r4kDSVwhzQMYa23lC5NVyEnUaBs6sti89A+Mpv5wyrUrceNqw0kjKZUpViT/IEvjz6JkfcMsd4L2j/DOV1j6c8AsvKwG1V7KAVCrJgAAyBZ+OKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875567; c=relaxed/simple;
	bh=9wJTjBqDHUsAMhhAXCCWV+3+FTPslEg2UFS4qXHzwuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3EAE+fcGYJc9HRiABrB3Hl6NQeLPnFs9/W/jYQRkvtHiYTolpULootY+eqZp2gfYN72r9RirdgdkTy/6qdbYPEVslkzOrqG3qTjkxROHbRBmWJQxfFHiWaEsFzaiIL4ePlUXPWOk/P7oRK66t+qICHa3cRZf7u+KLg57lu3/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLugVW1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CD0C4CEE3;
	Tue, 14 Jan 2025 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736875567;
	bh=9wJTjBqDHUsAMhhAXCCWV+3+FTPslEg2UFS4qXHzwuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fLugVW1QYuWvSUznJaFyEUrb3cO1vFsY3HmmWJmXex2SsXGpFC8rabxz442zx23Lo
	 qpR7hCUqVEz/eWHKo5vfRi8T78cZJFByY0mc5Ov4eUUSZ9t3ti6M3uj3EFjZXBztZa
	 6CbsQIn2Vl/UeCi3QAVEe8ztJ2OjCpVd9Cf6iJQJticsxTbo8QXOTm64YHGPrtjuZU
	 HGpSzW5cJa99Yk98qabBral7S1IX3RFiPvAPxLhgXl76n0SKKzQ8XyaOM9hiJ5tRlD
	 ge/IhtXYOAqSsLmFT4xw6tXjxL9dfEDmS1PXRyNXoWOXCHljSPoOnc7P/HQqRoi2iu
	 0J2r95G4eBRog==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ebb2d8dac4so2983073b6e.0;
        Tue, 14 Jan 2025 09:26:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6svph1LSOXnhtq4gDwjVS0AXyhLq47el4xFQSO/GxjJLJuHFa+GkmuUFbHip+8VJRbVs/P1SQk/Zv@vger.kernel.org, AJvYcCXR2ue9HCRlVIWbHqT1mqQSgd9J5o59L9mH/1E57cKr0Msdyk9ewrNBz+ZJzKNrLMtPhysPFoY/NdTzkn4n@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0kD9tNhHwbCdqc8pf57Sf6QoXNbPUmADs7gPgT5aVCLJ2nDL
	EnO9gG4HvLCq0CGAfmISkqJxVcsuH4yGfjdMvAet2MijsG5TXfwgi6dAWeD9W4IETzBGX/7Lgzp
	9O5coCFGZzdHozifx111K3GQ/gYM=
X-Google-Smtp-Source: AGHT+IFgHKPQdycNUn/VN/xwF9PssJwplC9aaQkQ9yLHU/J/FYv4RFn7Tywq8wO8txUDRXribYs7+GTwll0UyOcflHw=
X-Received: by 2002:a05:6808:3206:b0:3f0:5b8f:b7db with SMTP id
 5614622812f47-3f05b8fc029mr9039880b6e.5.1736875566618; Tue, 14 Jan 2025
 09:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107161923.3387552-1-rrichter@amd.com> <20250108151037.GA1221136@yaz-khff2.amd.com>
 <Z3-2TWSdt2vFzUll@rric.localdomain> <20250110144757.GA1641025@yaz-khff2.amd.com>
In-Reply-To: <20250110144757.GA1641025@yaz-khff2.amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 18:25:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iTD3SZRCkQHf7yo33WxtJZopfgW9t5=RuoQ-p+Ttrfaw@mail.gmail.com>
X-Gm-Features: AbW1kvaFntxOMyBA_DZ0Tk1O2oldau2qE7H10cdMbINcSMFZOO87WDzVYMQZMfU
Message-ID: <CAJZ5v0iTD3SZRCkQHf7yo33WxtJZopfgW9t5=RuoQ-p+Ttrfaw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PRM: Fix missing guid_t declaration in linux/prmt.h
To: Yazen Ghannam <yazen.ghannam@amd.com>, Robert Richter <rrichter@amd.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Allen <john.allen@amd.com>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 3:48=E2=80=AFPM Yazen Ghannam <yazen.ghannam@amd.co=
m> wrote:
>
> On Thu, Jan 09, 2025 at 12:43:09PM +0100, Robert Richter wrote:
> > Yazen,
> >
> > On 08.01.25 10:10:37, Yazen Ghannam wrote:
> > > On Tue, Jan 07, 2025 at 05:19:22PM +0100, Robert Richter wrote:
> > > > Seen the following build error:
> > > >
> > > >  ./include/linux/prmt.h:5:27: error: unknown type name =E2=80=98gui=
d_t=E2=80=99
> > > >      5 | int acpi_call_prm_handler(guid_t handler_guid, void *param=
_buffer);
> > > >        |                           ^~~~~~
> > > >
> > > > The include file uses guid_t but it is not declared. Include
> > > > linux/uuid.h to fix this.
> > > >
> > > > Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
> > > > Cc: John Allen <john.allen@amd.com>
> > > > Cc: Borislav Petkov (AMD) <bp@alien8.de>
> > > > Signed-off-by: Robert Richter <rrichter@amd.com>
>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Applied as 6.14 material, thanks!

> > > > ---
> > > >  include/linux/prmt.h | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/include/linux/prmt.h b/include/linux/prmt.h
> > > > index 9c094294403f..c53ab287e932 100644
> > > > --- a/include/linux/prmt.h
> > > > +++ b/include/linux/prmt.h
> > > > @@ -1,5 +1,7 @@
> > > >  /* SPDX-License-Identifier: GPL-2.0-only */
> > > >
> > > > +#include <linux/uuid.h>
> > > > +
> > > >  #ifdef CONFIG_ACPI_PRMT
> > > >  void init_prmt(void);
> > > >  int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)=
;
> > > > --
> > >
> > > Hi Robert,
> > >
> > > This looks correct. But can you please share how you've encountered t=
he
> > > issue?
> >
> > sure, I have used it here:
> >
> >  https://lore.kernel.org/all/20250107141015.3367194-26-rrichter@amd.com=
/
> >
> > I just included linux/prmt.h to get the declaration of
> > acpi_call_prm_handler() without anything else. I assume other users of
> > linux/prmt.h indirectly include linux/uuid.h with some other include
> > file.
> >
>
> Thanks Robert. This reminded me of a rule, but it took me a bit to find
> it again.
>
> Documentation/process/submit-checklist.rst -> "Review your code" #1
>
> I wonder: is there a script, coccinelle test, or something that will
> catch this in case we forget?
>
> Thanks,
> Yazen

