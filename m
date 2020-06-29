Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C38120E074
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jun 2020 23:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389672AbgF2UqT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Jun 2020 16:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389592AbgF2UqS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jun 2020 16:46:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B71C061755
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2020 13:46:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n26so4253776ejx.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2020 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=048/aux/uWIN5e9D0xFyVGaUP4nryXDLfPyRWaH72Ek=;
        b=zD6ga5emxtpmlIRAVfIT7c+0qmIa0JmJoiG9wTiBB3xtmmIy4qLmkRaMU4kRXvIQIa
         E83S8YIz7Tm0zhdu5czEB7Hln5/zBfAUh5P3RXjn5dpGJjPvlpteL/5yHDA4MrunZty8
         SERNEQQciNzdZGDaWJlKmCkPqtQVKg6u1W+ITBhcA6VIARJxNSIYoOBIhTb6FYMn1Wfz
         3h+U76ciDZZ+skAq1/OiIChJFBHAsTQFdkshuLB8hKyKewfGtGmRnNutNjYbPtDaaIfa
         Rs1pLnKujXyjWtD10YwTIaIE2NUaTA/V7kGdHd6AtMopwEmEJMRacTA40mLgLoY1u2lC
         qlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=048/aux/uWIN5e9D0xFyVGaUP4nryXDLfPyRWaH72Ek=;
        b=Awa2UyiGbbN30yo70rsuA7s4KS6BtkZlPvcfnMNSzEOpsbiCmEXUmRsbA0MZA2gB/a
         LBs1YBBMaUZg5DPth8CPlqgveSSUj1xPjV8og7EXJUPxJVLp4nn1vqUoG3mW0x3ryBsu
         19WjbATufHAd3FnRDLBj+/UQBvtf2lgomcxZW6HbFwc/vgjIgoTh3eDTPO/gh65KKkCn
         WyQsLSbgljqIMxX5nRu2QGp4MeL0wU9DTeUjnpUFcKXopjZ8XxTQCuQ9zrD7ZFMOEERL
         2B8Zp6NqMR7E7SfWF5XLRm+WyvQQkb6N8Dl53cd2ENbEwgw1icLNeOsGUgdIf5pitao4
         YuCg==
X-Gm-Message-State: AOAM530bjEmthlAYG2aGd7TZwKpLxLXpYnGJn38gFsG+L9rHx+NC8EgB
        GU665CR2bwiAOqaQLQVWfo3FfBd+8cy1ycnFElfvGg==
X-Google-Smtp-Source: ABdhPJxzX+kvJW1oBz/LQoASVcNYo3f670EC1zMCzFjhu4hr60/3iDTMlcp5vk8mgfPRkD9fqyFOWjpkBHEw5m0Eu48=
X-Received: by 2002:a17:906:da0f:: with SMTP id fi15mr15169748ejb.237.1593463574870;
 Mon, 29 Jun 2020 13:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <2788992.3K7huLjdjL@kreacher>
 <CAPcyv4hXkzpTr3bif7zyVx5EqoWTwLgYrt87Aj2=gVMo+jtUyg@mail.gmail.com> <CAJZ5v0h4Hj4ax1mmMJn3z3VGtVWkoXzO0kOQ7CYnFKJV2cUGzw@mail.gmail.com>
In-Reply-To: <CAJZ5v0h4Hj4ax1mmMJn3z3VGtVWkoXzO0kOQ7CYnFKJV2cUGzw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Jun 2020 13:46:03 -0700
Message-ID: <CAPcyv4iZA6hHH=sh=CZPJ-6skJfeuAVRVAuMeTdD5LYVPRrTqQ@mail.gmail.com>
Subject: Re: [RFT][PATCH v3 0/4] ACPI: ACPICA / OSL: Avoid unmapping ACPI
 memory inside of the AML interpreter
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jun 28, 2020 at 10:09 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jun 26, 2020 at 8:41 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Jun 26, 2020 at 10:34 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > Hi All,
> > >
> > > On Monday, June 22, 2020 3:50:42 PM CEST Rafael J. Wysocki wrote:
> > > > Hi All,
> > > >
> > > > This series is to address the problem with RCU synchronization occurring,
> > > > possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
> > > > when the namespace and interpreter mutexes are held.
> > > >
> > > > Like I said before, I had decided to change the approach used in the previous
> > > > iteration of this series and to allow the unmap operations carried out by
> > > > acpi_ex_system_memory_space_handler() to be deferred in the first place,
> > > > which is done in patches [1-2/4].
> > >
> > > In the meantime I realized that calling syncrhonize_rcu_expedited() under the
> > > "tables" mutex within ACPICA is not quite a good idea too and that there is no
> > > reason for any users of acpi_os_unmap_memory() in the tree to use the "sync"
> > > variant of unmapping.
> > >
> > > So, unless I'm missing something, acpi_os_unmap_memory() can be changed to
> > > always defer the final unmapping and the only ACPICA change needed to support
> > > that is the addition of the acpi_os_release_unused_mappings() call to get rid
> > > of the unused mappings when leaving the interpreter (module the extra call in
> > > the debug code for consistency).
> > >
> > > So patches [1-2/4] have been changed accordingly.
> > >
> > > > However, it turns out that the "fast-path" mapping is still useful on top of
> > > > the above to reduce the number of ioremap-iounmap cycles for the same address
> > > > range and so it is introduced by patches [3-4/4].
> > >
> > > Patches [3-4/4] still do what they did, but they have been simplified a bit
> > > after rebasing on top of the new [1-2/4].
> > >
> > > The below information is still valid, but it applies to the v3, of course.
> > >
> > > > For details, please refer to the patch changelogs.
> > > >
> > > > The series is available from the git branch at
> > > >
> > > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > > >  acpica-osl
> > > >
> > > > for easier testing.
> > >
> > > Also the series have been tested locally.
> >
> > Ok, I'm still trying to get the original reporter to confirm this
> > reduces the execution time for ASL routines with a lot of OpRegion
> > touches. Shall I rebuild that test kernel with these changes, or are
> > the results from the original RFT still interesting?
>
> I'm mostly interested in the results with the v3 applied.
>

Ok, I just got feedback on v2 and it still showed the 30 minute
execution time where 7 minutes was achieved previously.

> Also it would be good to check the impact of the first two patches
> alone relative to all four.

I'll start with the full set and see if they can also support the
"first 2" experiment.
