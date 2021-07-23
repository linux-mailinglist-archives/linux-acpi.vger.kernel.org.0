Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9BC3D3C74
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jul 2021 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhGWOtx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Jul 2021 10:49:53 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43748 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbhGWOts (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jul 2021 10:49:48 -0400
Received: by mail-ot1-f51.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso2366308otb.10
        for <linux-acpi@vger.kernel.org>; Fri, 23 Jul 2021 08:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbOOWwU51XdSBD1siV3tYF3b4su7sRMoyn27R3JYbM8=;
        b=hxkrzAbMEUCp1K4pUnQ8xPFeQjZKGP9OE5P1EsK0TXOpayc4V57JxT9OD276SV5Jzc
         Kcl+UAwFl+vNWOWfLhmtt9W9mRPNbf+OMJFmhurY+Q4qZTXSDMqUB6gFJItwrsr+OAmd
         wnJOlBKae7R7MEDxncAApNo0cQH6LC1yetQEQ4jszB8+hZ8G1KKhhgmO/F30nzkyA5T0
         iGWWXdsqF8tne8svX6EuGxQel9wKbjFC4wBiJwq0R9y0BRXbcoydzE5QEl4sNG8pgwFS
         DS3B+JzXz3C2smVOwxNTa1wTlavR2msou11/fkxAUDXfSNktXHsRK9k43nSrwzbG1/hT
         HcjQ==
X-Gm-Message-State: AOAM533Lr2q++yfLwnvvj0jn7Z1uNFzYvVEF9+qBR1AP8987mxEmaweN
        2/mGhXoD2hnV8iLXjAQ/P6KX3Uep+EGqg/MoCnI=
X-Google-Smtp-Source: ABdhPJxGnMZOFyAdTbi9JrPJRliGxMT3djSnHrxY2b+6IVBgMLVbK2yrAh+oTt5cOVRNfiUG7r1h2A0OA9rELCb46z0=
X-Received: by 2002:a9d:5c8b:: with SMTP id a11mr3640896oti.206.1627054220754;
 Fri, 23 Jul 2021 08:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210718041138.4739-1-mario.limonciello@amd.com>
 <CAJZ5v0iOV-E2V=XvLDmwPXpBEsywe2me58LbX2PxuJdDUCG7Qw@mail.gmail.com> <ceb36e73-0014-704c-d0b2-fc7c2a0def46@amd.com>
In-Reply-To: <ceb36e73-0014-704c-d0b2-fc7c2a0def46@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Jul 2021 17:30:09 +0200
Message-ID: <CAJZ5v0hmy6ffr44kFASfR2EmEWEKK1yJ8fE0rqRbEJfQgmQziQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Add support for upcoming AMD uPEP HID AMDI007
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 19, 2021 at 3:35 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 7/19/2021 07:09, Rafael J. Wysocki wrote:
> > On Sun, Jul 18, 2021 at 6:11 AM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> AMD systems with uPEP HID AMDI007 should be using revision 2 and
> >> the AMD method.
> >>
> >> CC: stable@kernel.org # v5.14
> >
> > Well, what do you mean?
> >
> > 5.14 is still under development.
>
> I didn't want to presume the timing or target that you would accept
> this.  If it's still viable for 5.14, then yes that would be preferable.
> Can you just remove that line from commit message?

I've applied it as 5.14-rc material with a Fixes tag pointing to
commit 8fbd6c15ea0a "ACPI: PM: Adjust behavior for field problems on
AMD systems".

Thanks!


> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/acpi/x86/s2idle.c | 10 ++++++++--
> >>   1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> >> index 1c507804fb10..fbdbef0ab552 100644
> >> --- a/drivers/acpi/x86/s2idle.c
> >> +++ b/drivers/acpi/x86/s2idle.c
> >> @@ -378,19 +378,25 @@ static int lps0_device_attach(struct acpi_device *adev,
> >>                   * AMDI0006:
> >>                   * - should use rev_id 0x0
> >>                   * - function mask = 0x3: Should use Microsoft method
> >> +                * AMDI0007:
> >> +                * - Should use rev_id 0x2
> >> +                * - Should only use AMD method
> >>                   */
> >>                  const char *hid = acpi_device_hid(adev);
> >> -               rev_id = 0;
> >> +               rev_id = strcmp(hid, "AMDI0007") ? 0 : 2;
> >>                  lps0_dsm_func_mask = validate_dsm(adev->handle,
> >>                                          ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
> >>                  lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
> >> -                                       ACPI_LPS0_DSM_UUID_MICROSOFT, rev_id,
> >> +                                       ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
> >>                                          &lps0_dsm_guid_microsoft);
> >>                  if (lps0_dsm_func_mask > 0x3 && (!strcmp(hid, "AMD0004") ||
> >>                                                   !strcmp(hid, "AMDI0005"))) {
> >>                          lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
> >>                          acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
> >>                                            ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
> >> +               } else if (lps0_dsm_func_mask_microsoft > 0 && !strcmp(hid, "AMDI0007")) {
> >> +                       lps0_dsm_func_mask_microsoft = -EINVAL;
> >> +                       acpi_handle_debug(adev->handle, "_DSM Using AMD method\n");
> >>                  }
> >>          } else {
> >>                  rev_id = 1;
> >> --
> >> 2.25.1
> >>
>
