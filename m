Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8BC3062F7
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 19:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbhA0SEZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 13:04:25 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:45880 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344299AbhA0SEB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2021 13:04:01 -0500
Received: by mail-ot1-f48.google.com with SMTP id n42so2549831ota.12;
        Wed, 27 Jan 2021 10:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=na56r5/ZVqp5Nhf6XImJXM3SxezwPgSuPKrOAxP7Kco=;
        b=Oh1AYwvmkbArMHBJTcBa6GSN8/A33bRs4wyI1V+1TXuaPQbUqudTFt8aF3do0LI2xh
         fd4LFbESw3GoJNu5H07rjjSKHUlTqaqPaCoE+VraGK4/yG9+zQCpKmOs+YKwoLJnkUzu
         3nj2F+BdTFvYSGkwW1qcZ+kQLu6gNmxuT9utzZxaI3vLNUBMguWYmL/F3cODzmuTVAzW
         E3Bm1gwCjDPmhRqbEj448yP+tyvecUSCzxR3C1whwKo/RDupA5r46DL20JAltKkz7P0K
         V22Kmgt6f5WFvRMlYNMPGJvwcWlkCVgGSNadGQA9LjCk2UoGct3/sRZ3jNevMzovlNTG
         1N9g==
X-Gm-Message-State: AOAM532X8LTvq2mZjuN6qi0WRlSt7gLu34OBy54P5Af/SX94wZZ7xr5f
        dN+o1aCW7zmbAa52mEXOyNaHs/uor97znkkSaBs=
X-Google-Smtp-Source: ABdhPJxFNZ4AHZCkeLCOY8sLPsT6XMxq26TlW/hMVSs1D8DPaURtRbicVqID5HkUaw9AS3fMgeU5PIy45pc2+yCdQmo=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr8736288ote.321.1611770600093;
 Wed, 27 Jan 2021 10:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20210126163201.1433505-1-terry.bowman@amd.com> <20210126164454.GD6514@zn.tnic>
In-Reply-To: <20210126164454.GD6514@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jan 2021 19:03:08 +0100
Message-ID: <CAJZ5v0ion650GwNKG_8kiAduP9jgz1WrvHN3QiDWNfMkFH+70Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / APEI: Add is_generic_error() to identify GHES sources
To:     Borislav Petkov <bp@alien8.de>, Terry Bowman <terry.bowman@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jon.grimm@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 11:48 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jan 26, 2021 at 10:32:01AM -0600, Terry Bowman wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > Refactor duplicated GHES identity logic into is_generic_error().
> >
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > Reviewed-by: Robert Richter <rrichter@amd.com>
> > Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > ---
> > Changes in v2:
> >   - Rename is_ghes_type() to is_generic_error()
> >   - Add co-developed-by
> >
> >  drivers/acpi/apei/hest.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> > index 6e980fe16772..f220bb00e91b 100644
> > --- a/drivers/acpi/apei/hest.c
> > +++ b/drivers/acpi/apei/hest.c
> > @@ -49,6 +49,12 @@ static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
> >       [ACPI_HEST_TYPE_IA32_DEFERRED_CHECK] = -1,
> >  };
> >
> > +static inline bool is_generic_error(struct acpi_hest_header *hest_hdr)
> > +{
> > +     return hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR ||
> > +            hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
> > +}
> > +
> >  static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
> >  {
> >       u16 hest_type = hest_hdr->type;
> > @@ -141,8 +147,7 @@ static int __init hest_parse_ghes_count(struct acpi_hest_header *hest_hdr, void
> >  {
> >       int *count = data;
> >
> > -     if (hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR ||
> > -         hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> > +     if (is_generic_error(hest_hdr))
> >               (*count)++;
> >       return 0;
> >  }
> > @@ -153,9 +158,7 @@ static int __init hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
> >       struct ghes_arr *ghes_arr = data;
> >       int rc, i;
> >
> > -     if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
> > -         hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> > +     if (!is_generic_error(hest_hdr))
> >               return 0;
> >
> >       if (!((struct acpi_hest_generic *)hest_hdr)->enabled)
> > --
>
> Acked-by: Borislav Petkov <bp@suse.de>

Applied as 5.12 material, thanks!
