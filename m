Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3ED2CC47E
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 19:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgLBSEd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 13:04:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35398 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgLBSEd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 13:04:33 -0500
Date:   Wed, 2 Dec 2020 19:03:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606932231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=69HDRjllqiet1yJkOQfILNR3Yl0QreV5unRuZHTw+Ms=;
        b=IuN+w+oTk58nFLIeVhRUFendcdB7o2FQa+14qO9U7uEEaxd/jmKNFJ2ASoU0WB6jKif84H
        9x9fsIYPWUUtpP/rJE6sR+cu9gU0POCJ+0W6/A0vlAu7J6Cz1nkGetCjQBGTp1XjdZqeoz
        H9uKDQdQDl/aB4vEBEzWAu9zaKshwK27/QbpcLJ0zZFn8KkOERPv23yA6KKvvoGlhdGAr5
        B09Hl0ZUsDIyirpA1kYh3SZ/b9R7MbnqXEnRn37z8ogpTT43AqgVx+4frN6gGTRtIAeO65
        uLRDCgbUrrWEKWoE+IkfxzCd0v4hzppXjVjE2WXaE8/CEENa1TMX4SGPJ+sRxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606932231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=69HDRjllqiet1yJkOQfILNR3Yl0QreV5unRuZHTw+Ms=;
        b=8Bh62S06OE1HY80q3dlD5PvFWvJlABr6HpttWBR2+MgwKFVRMYzgiNig6kyJ2UWZXjzkt+
        nfxyklgOmXMn6dCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Berman <stephen.berman@gmx.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20201202180350.kwmgfzkom7v7bzjg@linutronix.de>
References: <87blkbx1gt.fsf@gmx.net>
 <87imdp5r80.fsf@rub.de>
 <20200811132955.wbt55ns7bu5mxouq@linutronix.de>
 <CAJZ5v0h+n9VCz5=VixVbe_b=ZbTU3D=46stGhE9z7Y7yaUMJzw@mail.gmail.com>
 <20200811152551.dmfw46urecbmeklr@linutronix.de>
 <87ft8tayic.fsf@gmx.net>
 <20200811184902.2fm4eyprmpkfon2j@linutronix.de>
 <20201006214927.4nsqtfji4fdv3oed@linutronix.de>
 <3fc9074b-c153-8446-0289-1e4dfab395eb@intel.com>
 <20201026172057.h5toqoobiyhc4g3g@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201026172057.h5toqoobiyhc4g3g@linutronix.de>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-10-26 18:20:59 [+0100], To Rafael J. Wysocki wrote:
> > > > > Done as Bug 208877.
> > > Rafael, do you have any suggestions?
> > 
> > I've lost track of this sorry.
> > 
> > I have ideas, let me get back to this next week.
> 
> :)

Rafael, any update? If you outline an idea or so then I may be able to
form a patch out of it. Otherwise I have no idea how to fix this - other
than telling the driver to not poll in smaller intervals than
30secs.

> > Cheers!
> 
Sebastian
