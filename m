Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719A52D4745
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Dec 2020 17:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgLIQ5T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Dec 2020 11:57:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45637 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbgLIQ5T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2020 11:57:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id f132so2389170oib.12
        for <linux-acpi@vger.kernel.org>; Wed, 09 Dec 2020 08:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITYKyNTkuhQhHKayg0QUjBH2M3v+HiQizWCKa6FLWVI=;
        b=RpF8HhweRMqRlq+qNtO2kqo+F1qMpGKomMM5R0iwa/g6uZ07k24WpnKeLCsyIw6bZd
         xT6PSboElFwYTYoP4ewBvpWKJBc++pvrzNvSJPIRMrnfAQyvLe/qs81L8VZd0WfxgdSw
         ktdDJAjnRxilU6EkOYKCcUAVX/ebzV90xN8fQEK9f8aUfzfeyanzqPY5nJmVsI2kBGlx
         zO/1HS79ciGf9w6mup7fa44jMzPARIeIzkR70GeTJInbwVeX/+nCCdlYFAQ0VTOG40CQ
         12E10WOanInsGH7/VjJ5l44JHAG3wxLJEnkouWVMWP0WgnBvcnmEHfUMjvLDHdaZTENs
         N9hQ==
X-Gm-Message-State: AOAM530R7O5tc/p8R/UGFEk32hQ4nml8iNt7vCqvTHWPYWMeO7LOiUqj
        w9dB63hbDTjbjtUcAiZYAWSgU1IFe5jaOSRmMU1FJt6c3Kg=
X-Google-Smtp-Source: ABdhPJyed99E2pri3ppcsVwmy6OZVurXOAxTtYYfahQ/wG3XAECVzAaREz2Ds2nhMzMTMoYj7y9VC/NP+79iTXHVPYI=
X-Received: by 2002:aca:5197:: with SMTP id f145mr2450702oib.71.1607532998271;
 Wed, 09 Dec 2020 08:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20201204075041.44339-1-hui.wang@canonical.com>
 <CAJZ5v0jnVoo_heYUAfbt4t6xFAOqq+dGus1LCZP_-5Q8o8cpQQ@mail.gmail.com>
 <27211ea4-a691-ae96-4fed-6bb8f214963d@canonical.com> <CAJZ5v0gx4u9mWKxbe4kX2YRZsWFRt-x3DGTJMS2npRiyq2aCNQ@mail.gmail.com>
 <545a824f-090f-549f-94d9-193cce4b0e4e@canonical.com>
In-Reply-To: <545a824f-090f-549f-94d9-193cce4b0e4e@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Dec 2020 17:56:27 +0100
Message-ID: <CAJZ5v0jzi2_ME3b1wgoXeogJewB7O7EO+p2s_j7SnO8edrkWXw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / bus: skip the primary physical pnp device in companion_match
To:     Hui Wang <hui.wang@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 9, 2020 at 4:08 AM Hui Wang <hui.wang@canonical.com> wrote:
>
>
> On 12/8/20 10:01 PM, Rafael J. Wysocki wrote:
> > On Tue, Dec 8, 2020 at 3:02 AM Hui Wang <hui.wang@canonical.com> wrote:
> >>
> >> On 12/7/20 9:11 PM, Rafael J. Wysocki wrote:
> >>> On Fri, Dec 4, 2020 at 8:51 AM Hui Wang <hui.wang@canonical.com> wrote:
> > [cut]
> >
> >>> Would dropping the device ID in question from acpi_pnp_device_ids[]
> >>> make the problem go away?
> >>>
> >>> If so, why don't you do just that?
> >> Yes, if remove "WACFXXX" from acpi_pnp_device_ids[], could fix this
> >> issue. I planned to do so, but I found the pnp_driver in the
> >> drivers/tty/serial/8250/8250_pnp.c still handle this ID, maybe it could
> >> introduce regression on old machines if removing it.
> > Well, "WACFXXX" is not a proper device ID, it is a wild card possibly
> > matching too many devices.
> >
> > What device ID specifically is used in the ACPI tables for the device
> > in question?
>
> It is "WACF2200", how about the change as below, is it safe to say the
> length of a pnp device id is 7?
>
> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> index 4ed755a963aa..1e828378238c 100644
> --- a/drivers/acpi/acpi_pnp.c
> +++ b/drivers/acpi/acpi_pnp.c
> @@ -336,6 +336,10 @@ static bool acpi_pnp_match(const char *idstr, const
> struct acpi_device_id **matc
>   {
>          const struct acpi_device_id *devid;
>
> +       /* Expect the pnp device id has CCCdddd format (C character, d
> digital) */
> +       if (strlen(idstr) != 7)
> +               return false;
> +
>          for (devid = acpi_pnp_device_ids; devid->id[0]; devid++)
>                  if (matching_id(idstr, (char *)devid->id)) {
>                          if (matchid)

Alternatively, matching_id() can be updated to compare the length
(which arguably it should be doing).
