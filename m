Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF9228BE32
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Oct 2020 18:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403884AbgJLQmw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Oct 2020 12:42:52 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:41526 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390257AbgJLQmw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Oct 2020 12:42:52 -0400
Received: by mail-oo1-f67.google.com with SMTP id o184so602871ooo.8;
        Mon, 12 Oct 2020 09:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7U2QovlXoAUmOW3ls2XQIumCSQJr3uUb2npc8xY5T4=;
        b=I0FiJlRMrDLPRMevZKtJMDfUjNclXjL6vZZ/1WJcCEc8ipFan/uNR+KlFo1iCq1SSp
         fIVtWjOpmDHlooqUOd3awTmKli5kf9fhtn7Plq2Vv3Wkswpexay6UgfOTzCmp6cMWhXZ
         qt3co693TganlI2WkPC7d/+M5Tz+gd+OPn6GWqrNrE25A1UoKCLF0FV10ReDKdUuTd82
         5klFR4EQkm3pHUkBLI70nG05J8m1SNz2HsPHsA3WSl0HQHQj+v2bqBHYDlZNMXzO1JDE
         13Vv2KNMXKJeAXTqayUbbDpMsA5uHnEU/Xxg89rswswqB5sZ+qMtkq61k88nM4z3PL+O
         sgSA==
X-Gm-Message-State: AOAM5318N3HxkiQ6c5qp8Giq4smN8K2SarJsOSho3Clh6Jk2gA3y74vR
        cyEX7GaWlfeZaLSA7M6l32JcnsI89mg9UfDFdkM=
X-Google-Smtp-Source: ABdhPJzpl9k9CPunKp7hPHiVc1Wk3vDvRo2pGsL5isaQKjvj7VGy8tOKpBZhot1+oXSGCjF961IFri2MTy+iHC+PRxY=
X-Received: by 2002:a4a:d44:: with SMTP id 65mr19170928oob.44.1602520970989;
 Mon, 12 Oct 2020 09:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201003131938.9426-1-hdegoede@redhat.com> <20201003131938.9426-2-hdegoede@redhat.com>
 <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <85a36eb58cb9774f1907582dfc75295ed847200c.camel@hadess.net>
 <DM6PR19MB26364E6AA2F51981F592CE58FA0A0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <c73ffad8fd6bff8ff20d91930b097bff82be1c8f.camel@hadess.net> <DM6PR19MB2636B067186B08B744EA2163FA0A0@DM6PR19MB2636.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB2636B067186B08B744EA2163FA0A0@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Oct 2020 18:42:39 +0200
Message-ID: <CAJZ5v0jBJBTTb3qBGH0UWOAfvY24gWqJQA=MahnhaTdMu-w0Bw@mail.gmail.com>
Subject: Re: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 7, 2020 at 8:41 PM Limonciello, Mario
<Mario.Limonciello@dell.com> wrote:
>
> > On Wed, 2020-10-07 at 15:58 +0000, Limonciello, Mario wrote:
> > >
> > > > On Mon, 2020-10-05 at 12:58 +0000, Limonciello, Mario wrote:
> > > > > > On modern systems CPU/GPU/... performance is often dynamically
> > > > > > configurable
> > > > > > in the form of e.g. variable clock-speeds and TPD. The
> > > > > > performance
> > > > > > is often
> > > > > > automatically adjusted to the load by some automatic-mechanism
> > > > > > (which may
> > > > > > very well live outside the kernel).
> > > > > >
> > > > > > These auto performance-adjustment mechanisms often can be
> > > > > > configured with
> > > > > > one of several performance-profiles, with either a bias towards
> > > > > > low-power
> > > > > > consumption (and cool and quiet) or towards performance (and
> > > > > > higher
> > > > > > power
> > > > > > consumption and thermals).
> > > > > >
> > > > > > Introduce a new performance_profile class/sysfs API which
> > > > > > offers a
> > > > > > generic
> > > > > > API for selecting the performance-profile of these automatic-
> > > > > > mechanisms.
> > > > > >
> > > > >
> > > > > If introducing an API for this - let me ask the question, why
> > > > > even let each
> > > > > driver offer a class interface and userspace need to change
> > > > > "each" driver's
> > > > > performance setting?
> > > > >
> > > > > I would think that you could just offer something kernel-wide
> > > > > like
> > > > > /sys/power/performance-profile
> > > > >
> > > > > Userspace can read and write to a single file.  All drivers can
> > > > > get notified
> > > > > on this sysfs file changing.
> > > > >
> > > > > The systems that react in firmware (such as the two that prompted
> > > > > this discussion) can change at that time.  It leaves the
> > > > > possibility for a
> > > > > more open kernel implementation that can do the same thing though
> > > > > too by
> > > > > directly modifying device registers instead of ACPI devices.
> > > >
> > > > The problem, as I've mentioned in previous discussions we had about
> > > > this, is that, as you've seen in replies to this mail, this would
> > > > suddenly be making the kernel apply policy.
> > > >
> > > > There's going to be pushback as soon as policy is enacted in the
> > > > kernel, and you take away the different knobs for individual
> > > > components
> > > > (or you can control them centrally as well as individually). As
> > > > much as
> > > > I hate the quantity of knobs[1], I don't think that trying to
> > > > reduce
> > > > the number of knobs in the kernel is a good use of our time, and
> > > > easier
> > > > to enact, coordinated with design targets, in user-space.
> > > >
> > > > Unless you can think of a way to implement this kernel wide setting
> > > > without adding one more exponent on the number of possibilities for
> > > > the
> > > > testing matrix, I'll +1 Hans' original API.
> > > >
> > > Actually I offered two proposals in my reply.  So are you NAKing
> > > both?
> >
> > No, this is only about the first portion of the email, which I quoted.
> > And I'm not NAK'ing it, but I don't see how it can work without being
> > antithetical to what kernel "users" expect, or what the folks consuming
> > those interfaces (presumably us both) would expect to be able to test
> > and maintain.
> >
>
> (Just so others are aware, Bastien and I had a previous discussion on this topic
> that he alluded to here: https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/issues/1)
>
> In general I agree that we shouldn't be offering 100's of knobs to change
> things and protect users from themselves where possible.
>
> Whether the decisions are made in the kernel or in userspace you still have a matrix once
> you're letting someone change 2 different kernel devices that offer policy.  I'd argue it's
> actually worse if you let userspace change it though.
>
> Let's go back to the my GPU and platform example and lets say both offer the new knob here
> for both.  Userspace software such as your PPD picks performance.  Both the platform device
> and GPU device get changed, hopefully no conflicts.
> Then user decides no, I don't want my GPU in performance mode, I only want my platform.
> So they change the knob for the GPU manually, and now you have a new config in your matrix.
>
> However if you left it to a single kernel knob, both GPU and platform get moved together and
> you don't have these extra configs in your matrix anymore.
>
> The other point I mentioned, that platform might also do something to GPU via a sideband and
> you race, you can solve it with kernel too by modifying the ordering the kernel handles it.
>
> Userspace however, you give two knobs and now you have to worry about them getting it right
> and supporting them doing them in the wrong order.
>
> > > The other one suggested to use the same firmware attributes class
> > > being
> > > introduced by the new Dell driver (
> > > https://patchwork.kernel.org/patch/11818343/)
> > > since this is actually a knob to a specific firmware setting.
> >
> > This seemed to me like an implementation detail (eg. the same metadata
> > is being exported, but in a different way), and I don't feel strongly
> > about it either way.
>
> OK thanks.

IMV there are two choices here:  One is between exposing the low-level
interfaces verbatim to user space and wrapping them up into a certain
"translation" layer allowing user space to use a unified interface (I
think that is what everybody wants) and the other  boils down to how
the unified interface between the kernel and user space will look
like.

Personally, I think that something line /sys/power/profile allowing
drivers (and other kernel entities) to register callbacks might work
(as stated in my last reply to Hans).

Cheers!
