Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1883515240F
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2020 01:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBEAYL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Feb 2020 19:24:11 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48353 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgBEAYL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Feb 2020 19:24:11 -0500
X-Originating-IP: 92.243.9.8
Received: from localhost (joshtriplett.org [92.243.9.8])
        (Authenticated sender: josh@joshtriplett.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 565F140004;
        Wed,  5 Feb 2020 00:24:07 +0000 (UTC)
Date:   Tue, 4 Feb 2020 16:24:07 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] acpi: button: Provide option for power button to
 directly signal init
Message-ID: <20200205002406.GC2968@localhost>
References: <20200111022145.GA166025@localhost>
 <CAJZ5v0hF2YDVHcvqx_4TaEzuqBKppVG7gZ4nXm_peF75Cfbzmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hF2YDVHcvqx_4TaEzuqBKppVG7gZ4nXm_peF75Cfbzmg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 30, 2020 at 10:07:09PM +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 11, 2020 at 3:21 AM Josh Triplett <josh@joshtriplett.org> wrote:
> >
> > Virtual machines and containers often use an ACPI power button event to
> > tell the machine to shut down gracefully.
> >
> > Provide an optional, extremely lightweight way to handle this event by
> > signaling init directly, rather than running a separate daemon (such as
> > acpid or systemd-logind) that adds to startup time and VM image
> > complexity.
> 
> Well, I'm not convinced.

I would be happy to talk through other possible options.

> Even though the patch looks straightforward, the approach really is
> quite not so conceptually and honestly it looks like a band-aid.

I'm not sure what makes it conceptually non-straightforward. I'll freely
admit that it isn't *elegant*. But it also seems inelegant to me to need
to start and run an entire userspace daemon to watch for a key, or to
add such logic into a domain-specific workload's setup and event loop.

I'm entirely open to changing the approach. The goal I'm aiming for is
to allow cloud systems and VMs that signal shutdown via an ACPI power
button to run a more minimal userspace.

> Also I'm not quite sure why the ACPI button driver is the target of
> this and not the input layer, for instance.

I don't have any objections to putting this in another part of the
stack, but input in particular seems like it would potentially affect
the normal event-processing path.

- Josh Triplett
