Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40937AF17
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 21:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhEKTLA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 15:11:00 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:46060 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhEKTLA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2021 15:11:00 -0400
Received: by mail-oi1-f178.google.com with SMTP id n184so19971441oia.12
        for <linux-acpi@vger.kernel.org>; Tue, 11 May 2021 12:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmkV0A8Zn26Bzk4CqiWDUXewxJ8WCpnxl7YxVmeIKj8=;
        b=dflDShcyRBl6xoz82Xxfe+gOnSfV+NTcZJSPFA9Qv33ru/ZTC3Orr53Gm9RqrF/Wro
         W0mdlfZwafQsVszQEUsAaNyHMJr/0tFX8A+4a82yd2hvvTuRyRfhh3nnQHF1wrVLF1Ko
         V/Hd6oMZxnih8DKH0kG1EhZMQZ2Op6F/S7qZnohwpwwe5YxivjmH89ZQsScZz4f/tjj6
         sPFq+Tnoz4OcqxB2IX8jExDgnvgixc4/osFzLwhqAiJf0LFXLuJxHDzEfw93QO/aTFzX
         vV0894qB8Ec9qtCHqMTQc287xwKvxgOSQJwyoOvMYT31gIYXL8rw2RDHEY9qem5FZiD9
         aJgg==
X-Gm-Message-State: AOAM531LxEEIQ2d6J7Ixa7aG4BpRvRPLr3ruiA/MMEQuEpl+lqRP2Ciu
        g5vxbLCHQOpt1U6reh2U7QjGPGoj1GqQIHmaVhM=
X-Google-Smtp-Source: ABdhPJzSiYLjuFu34cCOSw0qgE/c3COnxriuvp5/PCwXwShPxerXLuHB190kHBnnuXmI6bF+Op0+hKs/T8st0Iwv9N8=
X-Received: by 2002:aca:1815:: with SMTP id h21mr4158839oih.69.1620760193572;
 Tue, 11 May 2021 12:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210511025024.10083-1-mario.limonciello@amd.com>
 <CAJZ5v0jSZ-oR2m15emfWV4s2rCic=t7RAEXd0--yaHPbt820-w@mail.gmail.com>
 <BYAPR12MB26937BC445598D567C964734E2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <CAJZ5v0jRSUV7_MN6Ru0R6tNq11Qe7Swv3Wy4sfZYbrn0H8r-tw@mail.gmail.com>
 <CAJZ5v0i=Zx_LOR1yZ0EkgrH4jy9+j=++kRBOJm_da3_a1=HDTw@mail.gmail.com>
 <BYAPR12MB2693FA7AE60DADDDDE0809FCE2539@BYAPR12MB2693.namprd12.prod.outlook.com>
 <MN2PR12MB44888AB90D99B2A3B4A70961F7539@MN2PR12MB4488.namprd12.prod.outlook.com>
 <BYAPR12MB269399B97D4BBC07B5758CCDE2539@BYAPR12MB2693.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB269399B97D4BBC07B5758CCDE2539@BYAPR12MB2693.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 May 2021 21:09:42 +0200
Message-ID: <CAJZ5v0jznwY0Cs9uKQDx5UASOggTEXUmwUiVUT998jwS0N1AcQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 11, 2021 at 8:57 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> > >
> > > Actually I think the value set in the OEM BIOS for state2 from LPI looks bogus
> > > too.
> > > It should have been 36us.
> > >
> > > @Liang, Prike and @Deucher, Alexander you have some more history on this
> > > than I do.
> >
> > I think they were just bogus, at least in the initial cases where we saw this.
> >
>
> In processor_idle.c target residency is calculated by exit latency multiplied by
> a latency factor parameter (2 by default).  So when these systems have the buggy
> _CST C2 value of 400, that's where the 800 comes from for residency, not _LPI.

Yes, that's right, sorry for the confusion.

My point was mostly whether or not it would be sufficient to swap the
values for the last two states or if some new values needed to be used
and the answer appears to be the latter.

So I don't see any way to address this that would be cleaner than the
quirk mechanism as proposed.
