Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF998127011
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2019 22:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLSVzz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Dec 2019 16:55:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41089 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLSVzz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Dec 2019 16:55:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so9028941otc.8;
        Thu, 19 Dec 2019 13:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d03R/kmuCBmV/O/m4doi+GKuVJGMnL1NHkn5dxGgulA=;
        b=UrJUYS2iV5nvzGDCXl9MI1fHk4ievbLypDbwNd1LesZuCDeWnKFYaj3KOtATDtK9rs
         VmuJcDfKY6NDnfO2LMUm2PBloxuyuSn+xwxzoUQLM+o7hgz+RsdyfN53JB64nWeuivcm
         86VPHc40/9zV47nvikkrR/O/gkxxLRDSNs30kQUy2AefMCG5BhOQ7rJbBe99MJ34cyOj
         yPEvo4vZ+CdfG/3eaCvSSUDXaPzU3h5QNPXoNkYxu178pn77B+QNNexO6w/nlqZ9pypf
         ivCBmqGQE6RPj+/GDcQiBFsO6ILCpz6fyk+tMM0oT0+PQEN1l3moYKsl1f7pN/7hlJAq
         hnAA==
X-Gm-Message-State: APjAAAWi3fWf4rfFt6zibdI7sJtzNjsDcbCs2A5LqNh/9j1ILJTJtG2f
        EhlBNgpHB+E2x+jC8ShwImCS4dPTX4+sMkT1K2g=
X-Google-Smtp-Source: APXvYqzgNoPXwVQSIOtO1XEfK4O6xWvptw4DKq0uYoQQ4c3hnPphPejIv8usqLOvXML9lFdYb6da7kq/QrXxD/Wx5lo=
X-Received: by 2002:a9d:62c7:: with SMTP id z7mr5826334otk.189.1576792554339;
 Thu, 19 Dec 2019 13:55:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576520244.git.gayatri.kammela@intel.com>
 <CAJZ5v0g2UHJcnczekgegX6_7kzHrmXNS_e3KRCC2d4LQ1+RceA@mail.gmail.com> <MWHPR11MB1278E9E06FBB5847444B11F3F2510@MWHPR11MB1278.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1278E9E06FBB5847444B11F3F2510@MWHPR11MB1278.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Dec 2019 22:55:43 +0100
Message-ID: <CAJZ5v0ji2f7XsR2__t5Fw8Vi1hB2XXHbp-LCZABN29yQ4VOyKw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] drivers: Add Tiger Lake hardware IDs to support ACPI,
To:     "Kammela, Gayatri" <gayatri.kammela@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Alex Hung <alex.hung@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 16, 2019 at 10:57 PM Kammela, Gayatri
<gayatri.kammela@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Monday, December 16, 2019 1:36 PM
> > To: Kammela, Gayatri <gayatri.kammela@intel.com>
> > Cc: Linux PM <linux-pm@vger.kernel.org>; Platform Driver <platform-driver-
> > x86@vger.kernel.org>; Alex Hung <alex.hung@canonical.com>; ACPI Devel
> > Maling List <linux-acpi@vger.kernel.org>; Len Brown <lenb@kernel.org>;
> > Rafael J. Wysocki <rjw@rjwysocki.net>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>; Amit
> > Kucheria <amit.kucheria@verdurent.com>; Prestopine, Charles D
> > <charles.d.prestopine@intel.com>; Darren Hart <dvhart@infradead.org>;
> > Rafael J . Wysocki <rafael@kernel.org>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Zhang, Rui <rui.zhang@intel.com>;
> > Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
> > Subject: Re: [PATCH v3 0/5] drivers: Add Tiger Lake hardware IDs to support
> > ACPI,
> >
> > On Mon, Dec 16, 2019 at 7:33 PM Gayatri Kammela
> > <gayatri.kammela@intel.com> wrote:
> > >
> > > Hi,
> > >
> > > Tiger Lake supports devices whose hardware IDs are changed for various
> > > drivers. Hence, add the new hardware IDs.
> > >
> > > Patch 1: Add Tiger Lake support to DPTF driver Patch 2: Add Tiger Lake
> > > support to fan driver Patch 3: Add Tiger Lake support to device_pm
> > > Patch 4: Add Tiger Lake support to Intel's HID driver Patch 5: Add
> > > Tiger Lake support to thermal driver
> >
> > I'm going to apply the whole series (for 5.6) if nobody has any issues with
> > that.
> >
> > Thanks!
>
> Thank you Rafael!

So applying as 5.6 material with rewritten subjects and changelogs and
with patches [2/5] and [3/5] folded together.

Thanks!
