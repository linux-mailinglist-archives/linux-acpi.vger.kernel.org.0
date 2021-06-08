Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758D039F4D3
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 13:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFHLXA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 07:23:00 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:33599 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhFHLXA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 07:23:00 -0400
Received: by mail-oi1-f181.google.com with SMTP id t140so15924893oih.0
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 04:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kRxbCWG2OXZOSOQYjN+wij24NaIQIZS7qE5IBc04fg=;
        b=TcBi62i7p9Lh95OlbZxLoI27DWb5tUGWx+1bRnvmyt3g7EVFXkwzsdLgUeGrccvjCM
         7BcZX0qpYREPT96rIsDtLu3IZEwVPgibHERv7eYIs7JC6XNenDVnd5jn1zPPFOkqMpyY
         DC/qilcIWz/9pDVh0wwhxJpYEgMajHV0/gy+1B+tXwgjayoJXpcDCHvS11cb7PJ/WLvA
         jkOyL8t3a466JWtN65rar8U6cdwJRjLEpwWrTT3vTdtxbn94nrdkD4fk4QfVR667Z5bl
         DH3zBDqkcTeK1kXfPSuWUtS0mor2THkcO3izglz5S+rKOmsLad8Rj7oJCqmN0d0dc9tm
         gK3A==
X-Gm-Message-State: AOAM5338kxKCv5Hl6C4tx2ivaeqfPB5q+UQAZZm9cb2NQP+KCJgjyRFS
        5z2plKicl0oqAPLk7gqMipHaWs9izOo59r5JJS8=
X-Google-Smtp-Source: ABdhPJzj+2qh6aoDiTJMWsDt+F99NabZ7WwOKqMPzK2YQB8EtAKcx+tMAiNZbi4uFRLXKo/sM5gmy+NMfihYiFhThGY=
X-Received: by 2002:aca:1910:: with SMTP id l16mr2324517oii.69.1623151254329;
 Tue, 08 Jun 2021 04:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210607173156.5548-1-mario.limonciello@amd.com> <20210608053546.GA14116@lst.de>
In-Reply-To: <20210608053546.GA14116@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jun 2021 13:20:43 +0200
Message-ID: <CAJZ5v0gMgwJ9kq_mo_dYoTUAqQzhXmrgp9wnY4TRPU1pJp=TyQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] ACPI: Move check for _DSD StorageD3Enable property
 to acpi
To:     Christoph Hellwig <hch@lst.de>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        rrangel@chromium.org, David Box <david.e.box@linux.intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal-bakulchandra.Shah@amd.com,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Prike Liang <prike.liang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 8, 2021 at 7:35 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 07, 2021 at 12:31:55PM -0500, Mario Limonciello wrote:
> > +/**
> > + * acpi_storage_d3 - Check if a storage device should use D3.

Let's be specific about what D3 means here in the first place and
that's D3hot AFAICS.

And the comment should be something like "Check whether or not to use
D3hot in the suspend path".

> > + * @dev: Device to check
> > + *
> > + * Returns %true if @dev should be put into D3 when the ->suspend method is
> > + * called, else %false.  The name of this function is somewhat misleading
> > + * as it has nothing to do with storage except for the name of the ACPI
> > + * property.  On some platforms resume will not work if this hint is ignored.

I would write it this way:

"Return %true if the platform firmware wants @dev to be programmed
into D3hot in the suspend path, or %false when there is no specific
preference. On some platforms, if this hint is ignored, @dev may
remain unresponsive after suspending the platform as a whole."

And I'm not sure if it is necessary to mention "storage" in this comment at all.

> > + *
> > + */
>
> I still do not like this comment.  There is nothing about only using this
> for storage devices.  It is specific to a PCIe slot, and if I plug
> something that is not a storage device into it the same restrictions
> still apply.

Originally, it was about storage devices IIUC (and that's why the
property name is what it is).

IIRC PCIe link management was broken in some NVMe drives and putting
them into D3hot would allow the link to go down later and it would
never go up again.  So you-know-who decided to avoid using D3hot for
all NVMe drives and they were generally characterized as "storage".
Alas, that turned out to break other things depending on the devices
being put into D3hot (like PS_ON) so the property was invented to
allow OEMs to mark the configurations including the devices that
actually worked (and Linux was/is on the receiving end). And
originally the property applied to the endpoint device under the root
port it was present for (my personal opinion about this doesn't really
matter, so let me avoid wasting time on expressing it).

Now, it evidently has been re-purposed to mark PCIe root ports that
require devices under them to be put into D3hot in the suspend path
(and it now means any device under the root port with this property,
at least in some cases).

> Also no need for the empty-ish line at the end.

Right.
