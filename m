Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7824B41B11C
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Sep 2021 15:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbhI1NuO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 28 Sep 2021 09:50:14 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:46839 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbhI1NuN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2021 09:50:13 -0400
Received: by mail-oo1-f50.google.com with SMTP id l8-20020a4ae2c8000000b002b5ec765d9fso306635oot.13;
        Tue, 28 Sep 2021 06:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yI0t52vDjp3qPZNaDmO9lPl1ra/Vt/GghnssMztBk0k=;
        b=lAsmBK5QSPoAkC6EEEuOvJne1FQsxp4stJPhK7+pwTlHfZmemycTWDi4XDJMmebb6t
         oPb0DGQRXV2kIpMdQCwVl3gPPTXU7lYIt5sqDIRU2yGhGY0zkNH5l48+h3PIJyjLk3Rr
         ezwld6qSYFmAuddJgok/ujQwQZYY1MEMtHZjaie6O8DnVm3OxYfNLCA24ogcL8t12Ngv
         bQt6mm8UoTM6CEjoNowj/EDUA9X08zrIjY4QDw0fwqqylXbi7Chhpj9BeasrmTHf2Z0y
         3yjZFiY0lgLgSrGzXaBw06JOsgSOwTC28VpsTu477CH1H2KtyfQM3q85DktSzUuoLrbS
         Me+A==
X-Gm-Message-State: AOAM533+RQwnW0mqihWoDgTGJTUHAy04uUc9iNCH1iLesf5ZubyML9Ou
        c+OvrE0kselM3n3E4WSjTQkp8cNik/A0w/rTOY0=
X-Google-Smtp-Source: ABdhPJz2L0c4GWXxf1fUD52FhFTKwodEJWuxfNI9xDupslgZmo/KnLSAfIcTinulPIyrxhYqdvWFxutCWCWv1HAY8pw=
X-Received: by 2002:a4a:df0b:: with SMTP id i11mr4991937oou.30.1632836913969;
 Tue, 28 Sep 2021 06:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210922133116.102-1-richard.gong@amd.com> <CAJZ5v0jpOzNS5TFdJNXdxa_p2D_5QQMwwRcSMe8JmjOaTjR8gg@mail.gmail.com>
 <3b26b179-69ba-64a2-807e-8d7609fbeb6e@amd.com>
In-Reply-To: <3b26b179-69ba-64a2-807e-8d7609fbeb6e@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Sep 2021 15:48:23 +0200
Message-ID: <CAJZ5v0g+VcGz65s=iu4fzWmkHS7Z0Dx9tMpDgFZ46f3U4jRkoQ@mail.gmail.com>
Subject: Re: [PATCHv1] ACPI: processor idle: Allow playing dead in C3 state
To:     "Gong, Richard" <richard.gong@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lijo.lazar@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 28, 2021 at 3:00 PM Gong, Richard <richard.gong@amd.com> wrote:
>
> Hi Rafael,
>
> On 9/24/2021 11:31 AM, Rafael J. Wysocki wrote:
> > On Wed, Sep 22, 2021 at 3:31 PM Richard Gong <richard.gong@amd.com> wrote:
> >> When some cores are disabled on AMD platforms, the system will no longer
> >> be able to enter suspend-to-idle s0ix.
> >>
> >> Update to allow playing dead in C3 state so that the CPUs can enter the
> >> deepest state on AMD platforms.
> >>
> >> BugLink: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1708&amp;data=04%7C01%7Crichard.gong%40amd.com%7Ca5c0db9ce02b4cd0864f08d97f78d33f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637680980065602427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=dIO5PDjpncLFIt0aGaTrKJHYIkJm8A4YByGn1%2FsHrtM%3D&amp;reserved=0
> >> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> >> Signed-off-by: Richard Gong <richard.gong@amd.com>
> >> ---
> >>   drivers/acpi/processor_idle.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> >> index f37fba9e5ba0..61d5a72d218e 100644
> >> --- a/drivers/acpi/processor_idle.c
> >> +++ b/drivers/acpi/processor_idle.c
> >> @@ -789,7 +789,8 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
> >>                  state->enter = acpi_idle_enter;
> >>
> >>                  state->flags = 0;
> >> -               if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2) {
> >> +               if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2
> >> +                       || cx->type == ACPI_STATE_C3) {
> >>                          state->enter_dead = acpi_idle_play_dead;
> >>                          drv->safe_state_index = count;
> >>                  }
> >> --
> > Tentatively applied as 5.16 material, but have you done any research
> > on why this restriction has been there in the first place?
>
> Yes, we need this change to align with the updated firmware on AMD
> platforms.

Well, it wouldn't be necessary to change the code otherwise.

Still, without the patch it is not allowed to play dead in deep idle
states (C3 type) and do you know why?

Or IOW how likely is this change to break anything on legacy platforms?
