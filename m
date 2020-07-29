Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F51D231E74
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jul 2020 14:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgG2MVu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Jul 2020 08:21:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38667 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgG2MVt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2020 08:21:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id q9so1673696oth.5;
        Wed, 29 Jul 2020 05:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mnnHyWC547JExbWvUCq+tIdDHLBBpQ7TBTnFeNVHVU=;
        b=rdYPEDlxp8xnPw215JCbUuZA7U17EG1Cstj+6GFHejHjCyACjqtfpC4x9zaRleLg6T
         nsdJb/82cr/mbblLRwz15lRbpIT2z3AzSC6Odf/BfF1OhoJlR3NHhZkerID7drp57YD/
         MSGr8qGQuo4M28MMlKiuceeoeostV+Nw7o2GGJOJWhzgZbBwFeONaXlK4dhE9VJZSjjZ
         yAVs9Abbf0+gZC5Cb/qNc91iQKhA3VLEJtsj8hEuBccrkXtieEd7OGGrzFbFi84B6LoI
         StJBp9sDZWCLddvjDEoWhQl7DKltKZW9u1ZKMCIxK3NK+9fuCt6c6/ZJc8ORMP/13yac
         aTKA==
X-Gm-Message-State: AOAM532e2/T+R+IN53M/P/E75iPsI0j/XcVv1ORzb20dF0sVJpjaK671
        qdZEvgbNcUopNbUG8Le1pgnYccZsZ27XbdoQjTE=
X-Google-Smtp-Source: ABdhPJwuvKQsPSVhOzwdYxBYA7KiJ/wJpm+ub0Wy7vHkExajp6uOO58dSKNk4G5BNIH2CvVx7N1UP9PNTCbrk72CpIw=
X-Received: by 2002:a05:6830:1e5c:: with SMTP id e28mr9763613otj.118.1596025308833;
 Wed, 29 Jul 2020 05:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0jb87PnwVXKuvgFeP=c-BGstc4YmANGpbOOnXi-b1oL8w@mail.gmail.com> <25cb1c0c35d2ea2aa233c1db726abd86dadc54c0.camel@intel.com>
In-Reply-To: <25cb1c0c35d2ea2aa233c1db726abd86dadc54c0.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jul 2020 14:21:35 +0200
Message-ID: <CAJZ5v0h3=xkSjZ3tWjK3NEJjtBw5KpfNOrHJ1yQ8nXpSG=SBBg@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation support
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Pavel Machek <pavel@ucw.cz>, Ira Weiny <ira.weiny@intel.com>,
        Len Brown <len.brown@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 29, 2020 at 3:35 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> On Mon, 2020-07-27 at 14:37 +0200, Rafael J. Wysocki wrote:
> > On Tue, Jul 21, 2020 at 12:24 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > Abstract platform specific mechanics for nvdimm firmware activation
> > > behind a handful of generic ops. At the bus level ->activate_state()
> > > indicates the unified state (idle, busy, armed) of all DIMMs on the bus,
> > > and ->capability() indicates the system state expectations for activate.
> > > At the DIMM level ->activate_state() indicates the per-DIMM state,
> > > ->activate_result() indicates the outcome of the last activation
> > > attempt, and ->arm() attempts to transition the DIMM from 'idle' to
> > > 'armed'.
> > >
> > > A new hibernate_quiet_exec() facility is added to support firmware
> > > activation in an OS defined system quiesce state. It leverages the fact
> > > that the hibernate-freeze state wants to assert that a memory
> > > hibernation snapshot can be taken. This is in contrast to a platform
> > > firmware defined quiesce state that may forcefully quiet the memory
> > > controller independent of whether an individual device-driver properly
> > > supports hibernate-freeze.
> > >
> > > The libnvdimm sysfs interface is extended to support detection of a
> > > firmware activate capability. The mechanism supports enumeration and
> > > triggering of firmware activate, optionally in the
> > > hibernate_quiet_exec() context.
> > >
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > [rafael: hibernate_quiet_exec() proposal]
> > > Co-developed-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >
> > IMO it's better to change this to
> >
> > Co-developed-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > and please to add
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > to it as per the development process documentation.
>
> Thanks Rafael, I've fixed this up in the branch I've prepared for the pull
> request:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/log/?h=libnvdimm-for-next

LGTM, thanks!
