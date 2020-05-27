Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4F1E4950
	for <lists+linux-acpi@lfdr.de>; Wed, 27 May 2020 18:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390800AbgE0QHc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 May 2020 12:07:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389648AbgE0QH1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 May 2020 12:07:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 04ABFAF69;
        Wed, 27 May 2020 16:07:28 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: Remove last acpi procfs dirs after being marked deprecated for a decade
Date:   Wed, 27 May 2020 18:07:25 +0200
Message-ID: <5786623.y7pTLF2AKN@c100>
In-Reply-To: <CAJZ5v0hAYRb9gZ8s=bZQ1NQrm5uUk5eLhLMwj2+pR2Apmd+WfA@mail.gmail.com>
References: <1696561.dScFM4BVNv@c100> <CAJZ5v0hAYRb9gZ8s=bZQ1NQrm5uUk5eLhLMwj2+pR2Apmd+WfA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Am Mittwoch, 27. Mai 2020, 17:49:09 CEST schrieb Rafael J. Wysocki:
> On Wed, May 27, 2020 at 5:33 PM Thomas Renninger <trenn@suse.de> wrote:
> > Kernel development should not be hindered anymore by this absolutely
> > outdated stuff.
> 
> Well, this is a bit vague.
> 
> I'm not against making this change, but why do it now?  Is there
> anything in particular that cannot be done without it?

Because of the deprecated message being shown on laptops booting with
the option enabled. I got a bugreport about it recently.

I could not please check_patch to properly include this commit id
(recon the double quotes in the title):

e63f6e28dda6de3de2392ddca321e211fd860925
Date:   Mon Jul 7 01:13:46 2014 +0200

    Revert "ACPI / AC: Remove AC's proc directory."
    
    Revert commit ab0fd674d6ce (ACPI / AC: Remove AC's proc directory.),
    because some old tools (e.g. kpowersave from kde 3.5.10) are still
    using /proc/acpi/ac_adapter.
    
    Fixes: ab0fd674d6ce (ACPI / AC: Remove AC's proc directory.)


kpowersave was written by myself and I can say for sure, that this stuff
is more than outdated.

Thanks,

   Thomas


