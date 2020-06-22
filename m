Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC6203B54
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jun 2020 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgFVPpt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jun 2020 11:45:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54934 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgFVPpt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2020 11:45:49 -0400
Received: from 89-64-85-91.dynamic.chello.pl (89.64.85.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 19bc9c8f661b8d9f; Mon, 22 Jun 2020 17:45:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Thomas Renninger <trenn@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: Remove last acpi procfs dirs after being marked deprecated for a decade
Date:   Mon, 22 Jun 2020 17:45:46 +0200
Message-ID: <5013960.NG3uzariRI@kreacher>
In-Reply-To: <CAJZ5v0hJ4o3nkJOUFEkvRBekWjm2YXfL1UOUBy2RK3VepMOdFg@mail.gmail.com>
References: <1696561.dScFM4BVNv@c100> <5786623.y7pTLF2AKN@c100> <CAJZ5v0hJ4o3nkJOUFEkvRBekWjm2YXfL1UOUBy2RK3VepMOdFg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, May 27, 2020 7:46:23 PM CEST Rafael J. Wysocki wrote:
> On Wed, May 27, 2020 at 6:07 PM Thomas Renninger <trenn@suse.de> wrote:
> >
> > Am Mittwoch, 27. Mai 2020, 17:49:09 CEST schrieb Rafael J. Wysocki:
> > > On Wed, May 27, 2020 at 5:33 PM Thomas Renninger <trenn@suse.de> wrote:
> > > > Kernel development should not be hindered anymore by this absolutely
> > > > outdated stuff.
> > >
> > > Well, this is a bit vague.
> > >
> > > I'm not against making this change, but why do it now?  Is there
> > > anything in particular that cannot be done without it?
> >
> > Because of the deprecated message being shown on laptops booting with
> > the option enabled. I got a bugreport about it recently.
> >
> > I could not please check_patch to properly include this commit id
> > (recon the double quotes in the title):
> >
> > e63f6e28dda6de3de2392ddca321e211fd860925
> > Date:   Mon Jul 7 01:13:46 2014 +0200
> >
> >     Revert "ACPI / AC: Remove AC's proc directory."
> >
> >     Revert commit ab0fd674d6ce (ACPI / AC: Remove AC's proc directory.),
> >     because some old tools (e.g. kpowersave from kde 3.5.10) are still
> >     using /proc/acpi/ac_adapter.
> >
> >     Fixes: ab0fd674d6ce (ACPI / AC: Remove AC's proc directory.)
> >
> >
> > kpowersave was written by myself and I can say for sure, that this stuff
> > is more than outdated.
> 
> Fair enough, but I'd rather stage it for 5.9 to give it a full cycle
> of baking in linux-next.

And so applied now as 5.9 material, thanks!



