Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506CE36D764
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhD1Mc7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 08:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbhD1Mc7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 08:32:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C7BC06138A
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2021 05:32:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v20so5458068plo.10
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2021 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RZo2ZbsDF3I7eJOt7pfSgud0DHldyzOYjG9PuO957Xw=;
        b=n/3cvziESfUknebBFFomXk7UTKWS9CTPZuwFaIL+OhIKmXP9XQtIkNz4RsMoRyOw/4
         sS/qIjTv9hGxnzZL1EJKmSx5BLwTcj1oSLizk8n5GeVeddqGnrf4t4xk2KqIKcdIjifH
         dtVWIOyThum/0892qf3yQYinkZ2fV98beV5GYtRGXfdKOSzBJPQDrs7B74NsV0eeL2wF
         8k19MDgNYFnrK9y7zkC9fRKs6OiLwJmfqDZf/SoZ//e+3Q/Q6s/kaIlYcvrDW7whKiIl
         O2f+jppSGYU2ELOBu5NGFRO6iljE+dRGzMCmmoaQiAihI4d66q9ddaEUYu6i9dYgcG8A
         zbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RZo2ZbsDF3I7eJOt7pfSgud0DHldyzOYjG9PuO957Xw=;
        b=cav0+Rp84xrw4frOIXN49i3dRm6O+DoNsXK0CDX2wBYyT5WUOMJvXlNSj7ket1CFSM
         5DCQ3BHakMgL/aaqwskLMnQXn8MmXAIxDDV+F3/6VEHnn6sMOvh6FWvwia3ZJZdrEHnk
         U/FwtTGL9/QZIMEZtCh5jGzz5uj8hb8QjPukOzExKXi63P7DPjSaqF2NhA0vxXKNNLo1
         aYeeJNIzizPN/K/ysBFKr3BlP1P8ui/gFASHtJEAzJU3w0Yu2CWqcDTK3rm1QTPol8Wr
         3OafwdzVqaF3sgyC4yrYhrMaslTe6FouAABBjadze7nr231GxUOYTndglF2JKMoe5mh1
         UJJg==
X-Gm-Message-State: AOAM533HtFxyi4zDzBkk3QGGTHgJG5PnGdxY2dN5hjtRkgk3T17FE5ZE
        5TyFljCyAstyNEh50KIRz+dPzHA24oVnEReN
X-Google-Smtp-Source: ABdhPJxqAqPDfY/PlLghdMi/t3kDJRzxX8vy8NlCQ6KBAFVn5i/9Buxm+sRtJUWl6SsDqOgqIrLtCw==
X-Received: by 2002:a17:90b:2393:: with SMTP id mr19mr3705964pjb.24.1619613132623;
        Wed, 28 Apr 2021 05:32:12 -0700 (PDT)
Received: from localhost ([2406:7400:73:8968:d957:fdf:9d7:1a08])
        by smtp.gmail.com with ESMTPSA id b25sm5198520pfd.7.2021.04.28.05.32.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 05:32:12 -0700 (PDT)
Date:   Wed, 28 Apr 2021 18:02:05 +0530
From:   B K Karthik <bkkarthik@pesu.pes.edu>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] MAINTAINERS: mark isapnp as obsolete
Message-ID: <20210428123205.nkxunwubdogjyvmq@burgerking>
References: <20210428110536.edy74gsobkgtd6al@ubuntu>
 <YIlCzOl/rkYeOWVW@kroah.com>
 <56ea648f-3742-6dd6-9deb-5f1ba441905f@perex.cz>
 <YIlT0KKfT6QaE8mz@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIlT0KKfT6QaE8mz@unreal>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21/04/28 03:23PM, Leon Romanovsky wrote:
> On Wed, Apr 28, 2021 at 02:17:00PM +0200, Jaroslav Kysela wrote:
> > Dne 28. 04. 21 v 13:11 Greg KH napsal(a):
> > > On Wed, Apr 28, 2021 at 04:35:36PM +0530, Anupama K Patil wrote:
> > >> isapnp code is very old and according to this link
> > >> https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications
> > >> from Wikipedia, even Windows Vista disabled ISA PnP by default.
> > >>
> > >> This change is in follow up to
> > >> https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#u
> > >> and https://lore.kernel.org/lkml/20210424194301.jmsqpycvsm7izbk3@ubuntu/T/#u
> > >>
> > >> Suggested-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > >> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> > > 
> > > Has the maintainer said this is unsupported?
> > 
> > I've no idea, if there're any users at the time, but there are many drivers
> > which depend on this code.
> 
> IMHO, this is exactly "Odd fixes" - code not really dead, but not really
> alive too.

Okay! Does this have to come around as a v2 with 'Odd Fixes' instead of obsolete?
Or should that be a separate patch?

Or should we just wait for the maintainer's reply?
Sorry i'm a little confused.

thanks,

karthik

> 
> Thanks
> 
> > 
> > I'll try to reply to patch threads.
> > 
> > 						Jaroslav
> > 
> > -- 
> > Jaroslav Kysela <perex@perex.cz>
> > Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
