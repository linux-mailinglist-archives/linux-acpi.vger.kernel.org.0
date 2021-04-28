Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBD436D727
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 14:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhD1MVj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 08:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233738AbhD1MVj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Apr 2021 08:21:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 794C461418;
        Wed, 28 Apr 2021 12:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619612454;
        bh=46NOAPukfKiOsVS2b8yCpV5HcgSzuZTzoL1lJfcFngc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJKwLeFOFCD1Vw3ws46O8gaXMgFTodXh5NX+F6pwKv7PTlM7V8smIihxGv7wYpwzi
         n8CiftQxXObFAJDepRwqh0S+DEgYZuTGHtTttol1QNPVzahOElHwL0Nu6qVSjN2KoY
         vATkOXChhXb0PSa1ZXiaxc7oJTizb7IAtNWNeQqmKH4AZcMgCen4iH9Vf8gK8COIgy
         5RIDB7Zz2Nj2wDxPXdUAE+Pvr2sTZ4EaclMXYP/H75JWtCnKcC136TNunVfzNL8dhG
         RIn3F/0+GgzlbDpbMd49FFyFHnhB7yFyf4X1tBtvjG+e4rXWHKhE3XgQ1eZC45caEW
         750G0gwAD0NMg==
Date:   Wed, 28 Apr 2021 15:20:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anupama K Patil <anupamakpatil123@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, B K Karthik <bkkarthik@pesu.pes.edu>,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] MAINTAINERS: mark isapnp as obsolete
Message-ID: <YIlTH8nMkAs6pb4w@unreal>
References: <20210428110536.edy74gsobkgtd6al@ubuntu>
 <YIlCzOl/rkYeOWVW@kroah.com>
 <20210428114057.tlc53ie7crvkqqhj@ubuntu>
 <YIlLk00Wzd6Lf660@unreal>
 <20210428121329.o4jlx76klmzlzl5n@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428121329.o4jlx76klmzlzl5n@ubuntu>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 28, 2021 at 05:43:29PM +0530, Anupama K Patil wrote:
> On 21/04/28 02:48PM, Leon Romanovsky wrote:
> > On Wed, Apr 28, 2021 at 05:10:57PM +0530, Anupama K Patil wrote:
> > > On 21/04/28 01:11PM, Greg KH wrote:
> > > > On Wed, Apr 28, 2021 at 04:35:36PM +0530, Anupama K Patil wrote:
> > > > > isapnp code is very old and according to this link
> > > > > https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications
> > > > > from Wikipedia, even Windows Vista disabled ISA PnP by default.
> > > > > 
> > > > > This change is in follow up to
> > > > > https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#u
> > > > > and https://lore.kernel.org/lkml/20210424194301.jmsqpycvsm7izbk3@ubuntu/T/#u
> > > > > 
> > > > > Suggested-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > > > > Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> > > > 
> > > > Has the maintainer said this is unsupported?
> > > > 
> > > > That's who you should take suggestions from :)
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Leon said he thinks it is unsupported (I've also cc'd him). So, I've sent this patch
> > > to get the feedback from the maintainer.
> > 
> > Leon said something different.
> > https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#m6c837180c8d6496d5bcbb8526e274c4239844be0
> > ------
> > > If changes to ISA code aren't welcomed, should these be marked obsolete in the MAINTIANERS file?
> > 
> > I think so, but think that "Odd Fixes" better describes that Rafael wrote.
> > ------
> Sorry about that! but does checkpatch tell people not to send patches if it's 'Odd fixes'?

I don't think so, but people should check MAINTIANERS file before they
send patches and it has an explanation what "Odd fixes" means.

> Should I wait for the maintainer's reply before doing anything else?

Yes, please

> > 
> > > 
> > > Thanks,
> > > Anupama
