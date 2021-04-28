Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5543A36D77E
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 14:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhD1MiA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 08:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbhD1MiA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 08:38:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C83C061574
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2021 05:37:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b14-20020a17090a6e0eb0290155c7f6a356so1981636pjk.0
        for <linux-acpi@vger.kernel.org>; Wed, 28 Apr 2021 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ARRtmav88LSZoCwmnUD6wYSwb7zXRvqm2Rfbvm63Co=;
        b=igvWqquW/p1mUnPsEEJHoKUHwvAA1Jr/Pu6wCtI6RwsxfJS/ZRbgv3wXQqJ7exU/1d
         Uklhp/aMi9h8BRiYA9WYceDLU5GPziuHoJRmMU6bkOjbrjoJi0d05nWXJeOdio0+5mrl
         soM4+tmlKnww6Oz1xfrJ7zfiiRnvRXhBuAbJqPSLusKOCnnR/WP4wUguy0YDvxPhJGmC
         2C0+c3Tn3iDiEvhV4e8LzdVRc7N1AiR8IzpZouxu1hv3QL8K2pWHXZj0bGOJND625QYb
         i0IDwC6SEmbX/yQSAnNl3CEk1W+PeS9Ngxf6VuznrD92fotVx14rOB2l/F8AwyWNgObz
         HtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ARRtmav88LSZoCwmnUD6wYSwb7zXRvqm2Rfbvm63Co=;
        b=qwVMBvSOUjMKD5AMDnlzaixSO7/J7A34AWSNt9VgX9prhVNGetnVzlYYjGAFCtfdxd
         b1j70porOemU0kNCbZXCA9M9seUhp/ypmaPNdfUK0oOdY5VeofrM0SWToyNdFqPbaZ4b
         6t5PZ45Dq8KJbsOa9G698xgJXWROtbmVJB30c/WKgQJoh2RSyrfz4nA6LEvVg9iEABYN
         gUELV5R4bf+l88VzPXl6AHDAoP+Rt95lXKwl4erhSrUAemSNgXKAy/wROd8O6M7cV/g7
         NuZcXyJ2QL/IcXXgErNXyQRDRyxDHWH2QncrydHAUmtBtwBFOyrOdYiJVNrv2tj/urT6
         FHPg==
X-Gm-Message-State: AOAM531CYadPZAJ+v8eqbt6yWmAlAudaoNtwatnngKYSJWoFw5TKGhTv
        zA9hLwKQyTGEWrLlKDijr+OMTQ==
X-Google-Smtp-Source: ABdhPJwxD0V11fzKlK9LEYltKzLMpxvMXlPXv3v5dK3ikG8RJ5EaVzb9JO+4R5M/bTtEUOL6+gQCOw==
X-Received: by 2002:a17:90a:634a:: with SMTP id v10mr1739093pjs.33.1619613435199;
        Wed, 28 Apr 2021 05:37:15 -0700 (PDT)
Received: from localhost ([2406:7400:73:8968:d957:fdf:9d7:1a08])
        by smtp.gmail.com with ESMTPSA id l21sm5028377pfc.114.2021.04.28.05.37.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 05:37:14 -0700 (PDT)
Date:   Wed, 28 Apr 2021 18:07:09 +0530
From:   bkkarthik <bkkarthik@pesu.pes.edu>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Handle errors while attaching
 devices
Message-ID: <20210428123709.dbciscrm5qjr3bxa@burgerking>
References: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
 <YIZJwkux0ghJ8k9d@unreal>
 <20210426175031.w26ovnffjiow346h@burgerking>
 <59a5d631-6658-2034-06c4-467520b5b9f7@perex.cz>
 <YIlTY8p4kpkORPfl@unreal>
 <19e8bd56-e24d-551e-9de2-57675541ee3f@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e8bd56-e24d-551e-9de2-57675541ee3f@perex.cz>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21/04/28 02:30PM, Jaroslav Kysela wrote:
> Dne 28. 04. 21 v 14:21 Leon Romanovsky napsal(a):
> > On Wed, Apr 28, 2021 at 02:04:49PM +0200, Jaroslav Kysela wrote:
> >> Dne 26. 04. 21 v 19:50 bkkarthik napsal(a):
> >>> On 21/04/26 08:04AM, Leon Romanovsky wrote:
> >>>> On Sun, Apr 25, 2021 at 01:13:01AM +0530, Anupama K Patil wrote:
> >>>>> isapnp_proc_init() does not look at the return value from
> >>>>> isapnp_proc_attach_device(). Check for this return value in
> >>>>> isapnp_proc_detach_device().
> >>>>>
> >>>>> Cleanup in isapnp_proc_detach_device and
> >>>>> isapnp_proc_detach_bus() for cleanup.
> >>>>>
> >>>>> Changed sprintf() to the kernel-space function scnprintf() as it returns
> >>>>> the actual number of bytes written.
> >>>>>
> >>>>> Removed unnecessary variables de, e of type 'struct proc_dir_entry' to
> >>>>> save memory.
> >>>>
> >>>> What exactly do you fix for such an old code?
> >>>
> >>> I was not aware that this code is so old. This fix was made after checkpatch reported assignment inside an if-statement.
> >>> Please ignore this patch if th change is not necessary as the code is probably not being used anywhere :)
> >>>
> >>> Maybe the code has to be marked as obsolete in the MAINTAINERS file to prevent patches being sent?
> >>>
> >>>>
> >>>>>
> >>>>> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> >>>>> Co-developed-by: B K Karthik <bkkarthik@pesu.pes.edu>
> >>>>> Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> >>>>> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> >>>>> ---
> >>>>>  drivers/pnp/isapnp/proc.c | 40 +++++++++++++++++++++++++++++----------
> >>>>>  1 file changed, 30 insertions(+), 10 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
> >>>>> index 785a796430fa..46ebc24175b7 100644
> >>>>> --- a/drivers/pnp/isapnp/proc.c
> >>>>> +++ b/drivers/pnp/isapnp/proc.c
> >>>>> @@ -54,34 +54,54 @@ static const struct proc_ops isapnp_proc_bus_proc_ops = {
> >>>>>  	.proc_read	= isapnp_proc_bus_read,
> >>>>>  };
> >>>>>  
> >>>>> +static int isapnp_proc_detach_device(struct pnp_dev *dev)
> >>>>> +{
> >>>>> +	proc_remove(dev->procent);
> >>>>> +	dev->procent = NULL;
> >>>>> +	return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static int isapnp_proc_detach_bus(struct pnp_card *bus)
> >>>>> +{
> >>>>> +	proc_remove(bus->procdir);
> >>>>> +	return 0;
> >>>>> +}
> >>>>
> >>>> Please don't add one line functions that are called only once and have
> >>>> return value that no one care about it.
> >>>
> >>> These were only intended for a clean-up job, the idea of this function came from how PCI handles procfs.
> >>> Maybe those should be changed?
> >>
> >> Which code you refer? I see:
> >>
> >>        for_each_pci_dev(dev)
> >>                 pci_proc_attach_device(dev);
> > 
> > He talks about isapnp_proc_detach_*() functions.
> 
> But only this patch introduced those functions. The pci_proc_init() code does
> not call pci_proc_detach_*() functions and ignores the allocation errors, too.

The changes in this patch make isapnp_proc_init() look at the return value of isapnp_proc_attach_device() and call isapnp_proc_detach_device() if that returns an error code.

> I don't think that this cleanup code is required.

Oh okay!

karthik

> 
> 					Jaroslav
> 
> -- 
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
