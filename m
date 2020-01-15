Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3BA13D063
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2020 23:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgAOW5l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jan 2020 17:57:41 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43184 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgAOW5l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2020 17:57:41 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so17133088oif.10
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jan 2020 14:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24XvumcpOl5bT3Pc+H+NhK0bdkQpI/x1Lo76Lf4P2FU=;
        b=f4xDAPfxBD3hsnNFR5SLDmBiwbgfPCArR5j4zyYhpzWLwMwm6ibMBHKqZd7+TvjfrH
         ly3QEPvmAjFO6OSbIJN4YWMOIfSP8kVCuulJjaN0xzVF4ObDzxmTKe4bDLpw8yUAEUxE
         rVMZRUX9D6hP9A5K1cHtmQ9XN9P3b4DKarwdNtgVCrjiyv+iF3kiqlmEXT1O1gNcS8Hj
         iQYsH3LNMyQzCj84gyIRTwZa7lCk+C7oBSJIa7ewH0hlJOdPQfzKhwyh8RhPc3TsIDF5
         w3XHCNtz6jnG4hgdVH8qeyEELxtovBALQxXmPu2qdFgXeBSB/Wlm43lZpZz78e7mfT/V
         1otw==
X-Gm-Message-State: APjAAAU7G50AApfVCQhf4XsFRmvM6gMYYb8IFeVlltkrGnWYqY/MnbBD
        7CT9FXlGX2KbAe5a0j1mUHYgAkEmJ1q9gr4l46R4pg==
X-Google-Smtp-Source: APXvYqxchy/IMyAABB+wBAJNx+FzZ+xScX+xBTPwtIOjWajfrpE/l/49pky6+0je8sJUnYfpK6XdSV+2kZt0SesHP8c=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr1925770oiy.110.1579129060553;
 Wed, 15 Jan 2020 14:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20191101212319.1FFC440EB1@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <5749186.Fh4Yg0zt7g@kreacher> <20200102223919.GA22256@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <2310267.gkPY8ABrMH@kreacher> <20200115185832.GA31684@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
In-Reply-To: <20200115185832.GA31684@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jan 2020 23:57:27 +0100
Message-ID: <CAJZ5v0ijf5gEBXiMvbp-tas7=HwrDSi3BpLEVYHY458su5EUiQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
To:     Anchal Agarwal <anchalag@amazon.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Singh, Balbir" <sblbir@amazon.com>, fllinden@amazon.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 15, 2020 at 7:58 PM Anchal Agarwal <anchalag@amazon.com> wrote:
>
> On Wed, Jan 15, 2020 at 11:24:47AM +0100, Rafael J. Wysocki wrote:
> > On Thursday, January 2, 2020 11:39:19 PM CET Anchal Agarwal wrote:
> > > On Thu, Dec 12, 2019 at 11:10:32PM +0100, Rafael J. Wysocki wrote:
> > > > On Monday, October 29, 2018 6:52:16 PM CET Anchal Agarwal wrote:
> > > > > Currently we do not see sleep_enable bit set after guest resumes
> > > > > from hibernation. Hibernation is triggered in guest on receiving
> > > > > a sleep trigger from the hypervisor(S4 state). We see that power
> > > > > button is enabled on wake up from S4 state however sleep button
> > > > > isn't.
> > > >
> > > > I'm not against this change in principle, although it may change behavior
> > > > in a somewhat unexpected way on some systems.
> > > >
> > > Apologies for late response, I was out on vacation.
> > > Can you please elaborate more on that?
> >
> > See below.
> >
> > > > > This causes subsequent invocation of sleep state to fail
> > > > > in the guest.
> > > >
> > > > However, can you explain this in a bit more detail?
> > > >
> > > I can explain this for my particular case, however, any code path going
> > > through acpi_hw_legacy_wake path will not have sleep button enabled. Why
> > > is only power button event enabled and not sleep here?
> >
> > Good question and related to the potentially unexpected behavior part.
> >
> > Presumably, on some systems the sleep button could not be enabled
> > automatically as it triggered another suspend right away after that.
> >
> > That's speculation, though.
> >
> > > In my case, I am using sleep button event to generate S4 state
> > > which causes guest VM running on xen to hibernate.
> >
> > Usually, however, the sleep button is used to trigger transitions into S3
> > (or suspend-to-idle on systems that support it).
> >
> > > I have found
> > > in my debugging process that after first resume when kernel goes
> > > through this code path, sleep button event is not enabled and
> > > when hypervisor try to generate sci interrupt, its not received in
> > > the guest since this path does not enable sleep event.
> >
> > OK
> >
> > So the patch can be applied AFAICS, but if it is reported to cause problems to
> > happen, it will need to be reverted.
> >
> > Please resend the patch with a proper CC list (including Bob, Erik, the ACPICA
> > devel list etc).
> >
> > Thanks!
> Sure can I add your Reviewed-by or Acked-by?

I'll be applying this eventually anyway, so why?
