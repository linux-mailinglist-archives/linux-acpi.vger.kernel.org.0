Return-Path: <linux-acpi+bounces-17815-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EB8BE477B
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 18:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1861A670A4
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E0032D0F0;
	Thu, 16 Oct 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vL2KWL3t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474332D0EB
	for <linux-acpi@vger.kernel.org>; Thu, 16 Oct 2025 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630965; cv=none; b=mqj+rlcP3ue+EstyFJbtEjXA4EkanuIMMw15TJRZFHNcpcQlxUNDGItC1Ym3Wjz3mVxu5Ahee+IWy+/rNpOHc0mdlmIgh6pv/qP6mp7mlE8cEsXwzSezTgsiLLXzZtD3XxAC+K9QBaAea+3UOkknrl4huFZmX9QTy7QexntXu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630965; c=relaxed/simple;
	bh=rKuQr+3zE0UBXAW6sZvdWRlFubASovKHG2uz0tKSfKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlximbXBPHs/XuIAghpqoglSmD9Hij56QPlDgZo3gHAgSsDM3XS3SKGEpwovMsKNP5unN0oM7AM20I7+uzHGW1G8jpQ+CKtG3rFiqm1xqDHgYvm3L0zLycp6Vgi4ylcBzfl1LbgMSU4eYkBwpkTuA609DUmI7VkeTHTYavseRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vL2KWL3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DC0C19421
	for <linux-acpi@vger.kernel.org>; Thu, 16 Oct 2025 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630964;
	bh=rKuQr+3zE0UBXAW6sZvdWRlFubASovKHG2uz0tKSfKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vL2KWL3tDFGNt2jyuap6PyLZwjg0s4TxW5n4AYsnB6Blf2XZ/Iaw26oxau3qDsmXK
	 05UH2o8m1GzloI36o19u1Pb1QwJ6lqh50ibl3aFtuordO4cV1xi5EiA8UJKWwJz3Uz
	 0b+WSiKpLGtuvUyZ4A3GEg90AH5alF+ki4e6PhnqxeQLhAUvZJpPiTzztZ3XNBg5LS
	 J1/fRUJm5TzhmvMASQSkS3ejFla9fm9THbZyEzS7zANIxUSiFu1CQkeTx8PCsKt9i/
	 ls8LBoZ87mS+WdnVilY/AIEVtKbIOIhQtetPsNyPMihy7YKIMKhGmi4ONKbEcDh0Cu
	 FV7KG3ISuYrPQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-650317ae979so263730eaf.2
        for <linux-acpi@vger.kernel.org>; Thu, 16 Oct 2025 09:09:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/XEDavtm66aBstkLmXQW9CQAGCZrxIguLt8YvMLNISj3ZhZ+SMiLLwTkTM4l/FxeeHBDRAMXJmkPl@vger.kernel.org
X-Gm-Message-State: AOJu0YyUYs6DeeYNus8XK1pYCnNIaykdKQugVMM9U19T8AWy1SL0JIFH
	KpocmidSdoAcNV2cVQll3xV3/J2K86D3n1Hi0TXaslV9kjaazE/piHp3AGXz05vOFpPHPLS0laD
	DCf69R4AwSDl9QMm9Aq0SSfEHoYaAm60=
X-Google-Smtp-Source: AGHT+IF54YUbfKT0mYePoTKCwnxwraZ2JolwrX5idg8J8ydCYBSwqjLZNsqEVNOkrJIZTrh0VcEo1HTnGmAAsmcAPZc=
X-Received: by 2002:a05:6871:820d:b0:315:9f40:2af3 with SMTP id
 586e51a60fabf-3c98d17cda5mr141606fac.33.1760630963886; Thu, 16 Oct 2025
 09:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
 <20251006-wip-atl-prm-v1-1-4a62967fb2b0@amd.com> <20251016160149.GBaPEW7ej4qvOcVfYh@fat_crate.local>
In-Reply-To: <20251016160149.GBaPEW7ej4qvOcVfYh@fat_crate.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Oct 2025 18:09:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gvn21FeMNpJDWOZ0ZH5CZzDt0zEuXjHEpWxHjq9vHqyw@mail.gmail.com>
X-Gm-Features: AS18NWAGg3cRiqRD4IVCBlMYwD3BxTDT4FKkM2L9nMHhZnA1y2Ft50etdSKqdhQ
Message-ID: <CAJZ5v0gvn21FeMNpJDWOZ0ZH5CZzDt0zEuXjHEpWxHjq9vHqyw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: PRM: Add acpi_prm_handler_available()
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>, 
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Avadhut Naik <avadhut.naik@amd.com>, John Allen <john.allen@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 6:02=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Oct 06, 2025 at 03:10:25PM +0000, Yazen Ghannam wrote:
> > Add a helper function to check if a PRM handler/module is present.
> >
> > This can be used during init time by code that depends on a particular
> > handler. If the handler is not present, then the code does not need to
> > be loaded.
> >
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  drivers/acpi/prmt.c  | 6 ++++++
> >  include/linux/prmt.h | 2 ++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> > index 6792d4385eee..7b8b5d2015ec 100644
> > --- a/drivers/acpi/prmt.c
> > +++ b/drivers/acpi/prmt.c
> > @@ -244,6 +244,12 @@ static struct prm_handler_info *find_prm_handler(c=
onst guid_t *guid)
> >       return (struct prm_handler_info *) find_guid_info(guid, GET_HANDL=
ER);
> >  }
> >
> > +bool acpi_prm_handler_available(const guid_t *guid)
> > +{
> > +     return find_prm_handler(guid) && find_prm_module(guid);
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_prm_handler_available);
> > +
> >  /* In-coming PRM commands */
> >
> >  #define PRM_CMD_RUN_SERVICE          0
> > diff --git a/include/linux/prmt.h b/include/linux/prmt.h
> > index c53ab287e932..8cdc987de963 100644
> > --- a/include/linux/prmt.h
> > +++ b/include/linux/prmt.h
> > @@ -4,9 +4,11 @@
> >
> >  #ifdef CONFIG_ACPI_PRMT
> >  void init_prmt(void);
> > +bool acpi_prm_handler_available(const guid_t *handler_guid);
> >  int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
> >  #else
> >  static inline void init_prmt(void) { }
> > +static inline bool acpi_prm_handler_available(const guid_t *handler_gu=
id) { return false; }
> >  static inline int acpi_call_prm_handler(guid_t handler_guid, void *par=
am_buffer)
> >  {
> >       return -EOPNOTSUPP;
> >
> > --
>
> Rafael?

I've seen it.  Are you asking for anything in particular?

