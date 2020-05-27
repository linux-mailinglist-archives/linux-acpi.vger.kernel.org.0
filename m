Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4341E4C4B
	for <lists+linux-acpi@lfdr.de>; Wed, 27 May 2020 19:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgE0Rqf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 May 2020 13:46:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39044 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE0Rqf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2020 13:46:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id d7so226018ote.6
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2020 10:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQbLHTo4crsvMnRjC344nlt//ak/qzoSH3shsybm79A=;
        b=Dg9NW69JHPlqMC24PWv3eEDr36zl+2Gd+yfiDZ/o54ChZXgHBzETyK4zXtyC5MpWd5
         Jg6jFW/8OI4F/PhOlqN+Gv+609z7g6ahjEWafMX4wgZYJLOe5JNmKqv8eqacuC6j4rZ8
         IuO1vJkGsZt7atoE7TQM3yPCZJERgma4tfVGpsQV2ZK6qQDqAFRVZTDeSxQMgubl/pXA
         zpPzCOrW1pKOkNWwrFvJpXmaGGllesmwqDmIH2uWZscKde3j5jJisUCmWCM9rbBAux9K
         7kzU1UYxYTqlOh90WW48u/tf4AfzB302S/iQ6hXg5WWL43CA3acz+9wfUjCpHno4oAI+
         imVg==
X-Gm-Message-State: AOAM531fU7qfz2JXrbZAF8DcQD+9/FGaNtibsS2Y1fzjH60k1fNtI6K8
        TvSEoaipE4JTtbmZ3OVn7Xg2AljQg82c8AOHEKg=
X-Google-Smtp-Source: ABdhPJwtOFPCtxbCCIWLWrOpkgQeHxHU6mkLk9gL7x5stU7v4LLANlnMV2B/eSqo4pPrjAGPo8cYVRXRGDKWlmoolw4=
X-Received: by 2002:a9d:6c0f:: with SMTP id f15mr5284988otq.118.1590601594497;
 Wed, 27 May 2020 10:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <1696561.dScFM4BVNv@c100> <CAJZ5v0hAYRb9gZ8s=bZQ1NQrm5uUk5eLhLMwj2+pR2Apmd+WfA@mail.gmail.com>
 <5786623.y7pTLF2AKN@c100>
In-Reply-To: <5786623.y7pTLF2AKN@c100>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 May 2020 19:46:23 +0200
Message-ID: <CAJZ5v0hJ4o3nkJOUFEkvRBekWjm2YXfL1UOUBy2RK3VepMOdFg@mail.gmail.com>
Subject: Re: Remove last acpi procfs dirs after being marked deprecated for a decade
To:     Thomas Renninger <trenn@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 27, 2020 at 6:07 PM Thomas Renninger <trenn@suse.de> wrote:
>
> Am Mittwoch, 27. Mai 2020, 17:49:09 CEST schrieb Rafael J. Wysocki:
> > On Wed, May 27, 2020 at 5:33 PM Thomas Renninger <trenn@suse.de> wrote:
> > > Kernel development should not be hindered anymore by this absolutely
> > > outdated stuff.
> >
> > Well, this is a bit vague.
> >
> > I'm not against making this change, but why do it now?  Is there
> > anything in particular that cannot be done without it?
>
> Because of the deprecated message being shown on laptops booting with
> the option enabled. I got a bugreport about it recently.
>
> I could not please check_patch to properly include this commit id
> (recon the double quotes in the title):
>
> e63f6e28dda6de3de2392ddca321e211fd860925
> Date:   Mon Jul 7 01:13:46 2014 +0200
>
>     Revert "ACPI / AC: Remove AC's proc directory."
>
>     Revert commit ab0fd674d6ce (ACPI / AC: Remove AC's proc directory.),
>     because some old tools (e.g. kpowersave from kde 3.5.10) are still
>     using /proc/acpi/ac_adapter.
>
>     Fixes: ab0fd674d6ce (ACPI / AC: Remove AC's proc directory.)
>
>
> kpowersave was written by myself and I can say for sure, that this stuff
> is more than outdated.

Fair enough, but I'd rather stage it for 5.9 to give it a full cycle
of baking in linux-next.

Thanks!
