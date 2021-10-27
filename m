Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78F943CB4F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 15:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbhJ0N7w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 09:59:52 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:37554 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbhJ0N7r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 09:59:47 -0400
Received: by mail-ot1-f53.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso3710753otl.4;
        Wed, 27 Oct 2021 06:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fO1NsYoqquWavhhPez9iXdiBzVVhq3qe2AnYOdL9njE=;
        b=DrJEwuoVKp0iNYCrLiVkouc825l25nKP1hWNriVLoLrH7NRFkQqNi0lVYKllSywHJk
         8AQHgv/rZOx2knGJ1R8qkJqMkt9NOvwhA08FNAD3+/c0Vb5h+QjWEwvna1A9AriwiCJ9
         52LQIK7swk+e26wcaNlDqDjCgkHsHa+MCMUBq3dF/C40g0LKdz88MWVqh+PNhwqQD9Tl
         ybh7gUddYg7KwqwwsE/DCntLxOE/cKiztqWbICQyavxNSvOEZc1zSYomRfau3iSB7P+d
         Gp7TOF4CDZno52pU4yNhi715LwHJRLsz5UpgLZXWYGy+QMm0N1oM/T8sUzIl9V9B8GaD
         6nug==
X-Gm-Message-State: AOAM530VhHp03Q+PcJx65joTR2TX0g9MrANawXHtbkH7Txdjck8iXYY4
        m/3i/rp2zFaNC5hRqxLG1dExppQft+Lukq97ZZ0=
X-Google-Smtp-Source: ABdhPJzwJDLtuwcrgtBQMzntR9J9isrSyX23tOmLKtXRoUepvR/pUmcctdhoVyyhfcB5cpijnd4AEN7FgbVq6xmA2jI=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr24460454otd.16.1635343041776;
 Wed, 27 Oct 2021 06:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211026190835.10697-1-mario.limonciello@amd.com> <2ef89421-a783-e1b2-0a31-1f2be5343e22@redhat.com>
In-Reply-To: <2ef89421-a783-e1b2-0a31-1f2be5343e22@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Oct 2021 15:57:10 +0200
Message-ID: <CAJZ5v0j-OCekKM1vv3m5JGAMKKcyC2O8hy3ZHESj+Zdx2GRagQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Let other drivers react to platform profile changes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 3:51 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Mario,
>
> On 10/26/21 21:08, Mario Limonciello wrote:
> > Currently only one driver can register as a handler for a platform profile.
> >
> > This limitation means that if multiple drivers want to react to platform
> > profile changes that they will need to directly interact with individual
> > drivers.
> >
> > Instead introduce a notification flow that drivers can register for event
> > changes.  The idea is that any driver that wants to can:
> > 1. read the current profile
> > 2. set up initial values
> > 3. register for changes
> > 4. react to changes
> >
> > Changes from v3->v4:
> >  * Simplify platform_profile_notify
> >    - No need to check cur_profile as platform_profile_get does it
> >    - No need to track ret as it's unused
> > Changes from v2->v3:
> >  * Add patches to avoid collisions in hp-wmi and asus-wmi symbols
>
> We typically do not merge new in-kernel API without at least one
> consumer of that in-kernel API.
>
> I can take patches 1 + 2 now as prep work for the future,
> but I would expect Rafael to only want to take patch 3/3 if
> you post a new series which also includes at least one consumer
> for the functionality added by 3/3.
>
> That will also make it a lot easier to review 3/3 / to consider
> other means to reach the same goal.
> Rafael, do you concur?

Yes, I do.

Thanks!
