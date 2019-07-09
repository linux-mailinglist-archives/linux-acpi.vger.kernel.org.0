Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A851631BC
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2019 09:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfGIHUL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Jul 2019 03:20:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37667 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGIHUL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jul 2019 03:20:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id s20so18916164otp.4
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jul 2019 00:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jN2HTBbGVnb2PEAaaQgYC49W0HWjdbr8AlkujX6bfm4=;
        b=iTIoYWN7wZNdxtwQDFZycc6bxdVDsSuifooM24YsJ6daAFD01PPkqON5Z77l26RuYl
         UmdZTH+kq1/8FqNfPehv3dMn4VvQDYm6Y4YrXALVJp/2oqVge0RF2Xfj0u+BtW5CMLdU
         0b3BAUgxx9iKMqTg6lXBV2tlX4XgpCgmcwgKZytrcu2OLE90SiLWBX9+HUttIH40X3iQ
         9q1KT0Vm9b6WvypFg/uekwdRVEh6SFf6DsWJy/DfajwIsyZQ6OxITv+pxHPZhfqXyy1X
         H9Mk4iCuxpmIWbp7vrexHAjJAyCEx61oWn697AXstOwJUiHeDFe7LlcS9V829oAOylVU
         JCBg==
X-Gm-Message-State: APjAAAXNIKtaQ2Ig8vb6VdH2QA44YpOtzjWZYS7QDx4g2mSuqoB+FRKd
        4rSIpGUXAh47/lDVjtd+Cqv7L211diudfBLlXDU=
X-Google-Smtp-Source: APXvYqxE7Rzx/ReyPW+HyS+6YOcssLdrIsl9ixHsPj57iPeLp8P8putvByylsYNjEpte51ZzGGHNNy/7tsynQP7KbCQ=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr17152013oto.167.1562656810767;
 Tue, 09 Jul 2019 00:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190628181457.6609-1-jeremy.linton@arm.com> <20190628181457.6609-2-jeremy.linton@arm.com>
 <CAJZ5v0jh0+WU5fpd9enq0UHrHzh+0Sgv-xoRiJM3jgu9dQFvdw@mail.gmail.com>
 <1745d9ee-a4e0-9a6f-138c-c0d5b42b5281@arm.com> <CAJZ5v0jM5VEuYuY7RdeXYs0S04uRYq5_01fKSBKOouS5DgBhww@mail.gmail.com>
 <3882f986-54b6-ce7c-5e52-9ad6159b7e6f@arm.com>
In-Reply-To: <3882f986-54b6-ce7c-5e52-9ad6159b7e6f@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Jul 2019 09:19:59 +0200
Message-ID: <CAJZ5v0gvFApZ1+CsKtGbqZgt+nA64Wywq6PBXELbPXSDsD2WZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 4, 2019 at 4:41 AM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Hi,
>
> On 7/3/19 4:57 PM, Rafael J. Wysocki wrote:
> > On Wed, Jul 3, 2019 at 5:11 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
> >>
> >> Hi,
> >>
> >> Thanks for taking a look at this.
> >>
> >> On 7/3/19 4:24 AM, Rafael J. Wysocki wrote:
> >>> On Fri, Jun 28, 2019 at 8:15 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
> >>>>
> >>>> ACPI 6.3 adds a flag to the CPU node to indicate whether
> >>>> the given PE is a thread. Add a function to return that
> >>>> information for a given linux logical CPU.
> >>>>
> >>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >>>> ---
> >>>>    drivers/acpi/pptt.c  | 62 +++++++++++++++++++++++++++++++++++++++++++-
> >>>>    include/linux/acpi.h |  5 ++++
> >>>>    2 files changed, 66 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> >>>> index b72e6afaa8fb..bb6196422fad 100644
> >>>> --- a/drivers/acpi/pptt.c
> >>>> +++ b/drivers/acpi/pptt.c
> >>>> @@ -517,6 +517,52 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
> >>>>           return retval;
> >>>>    }
> >>>>
> >>>> +/**
> >>>> + * check_acpi_cpu_flag() - Determine if CPU node has a flag set
> >>>> + * @cpu: Kernel logical CPU number
> >>>> + * @rev: The PPTT revision defining the flag
> >>>> + * @flag: The flag itself
> >>>> + *
> >>>> + * Check the node representing a CPU for a given flag.
> >>>> + *
> >>>> + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found or
> >>>> + *        the table revision isn't new enough.
> >>>> + *        1, any passed flag set
> >>>> + *        0, flag unset
> >>>> + */
> >>>> +static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
> >>>
> >>> Why not bool?
> >>
> >> At least for the thread flag we need the three states so that we can
> >> fall back to the CPU's description of itself on machines without ACPI
> >> 6.3 tables.
> >>
> >> The ThunderX2 is threaded and without a firmware update a change like
> >> this will break it.
> >
> > Fair enough.
> >
> >>>
> >>>> +{
> >>>> +       struct acpi_table_header *table;
> >>>> +       acpi_status status;
> >>>> +       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> >>>> +       struct acpi_pptt_processor *cpu_node = NULL;
> >>>> +       int ret = -ENOENT;
> >>>> +       static int saved_pptt_rev = -1;
> >>>> +
> >>>> +       /* Cache the PPTT revision to avoid repeat table get/put on failure */
> >>>
> >>> This is a rather questionable optimization.
> >>>
> >>> Does the extra table get/put really matter?
> >>
> >> AFAIK, Probably not.
> >
> > Then why to optimize it?
>
> There was some discussion in the v2 review thread about all the get/put
> operations which only existed to return failure for each core in the
> machine.
>
> https://www.spinics.net/lists/arm-kernel/msg735948.html
>
> I guess I should drop it, until we have some proof that there is a problem.

Yes, please.
