Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E00036D6C4
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 13:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhD1Lt0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 07:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhD1Lt0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Apr 2021 07:49:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9835A61411;
        Wed, 28 Apr 2021 11:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619610521;
        bh=eBw+v8qdF9EFaRJNBcW866wo/wCSyzy8xZ4b4KlX2xU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eUvLjB0g4QzJVVNov0KY0cSv9XrVfQlizCKhvvpvPwU25Azy7Cwy8RxwUso9rEfFl
         5QnuQ4clb/F/nU22yi1V37jgb207UbdQmP5bMZZeJx7rX8esapEU7tUQDdYl+ccEAm
         2yb4FvVmiRHXLMg0ARsF5d2K3dWcTZtYX9MW/MB4KFUDfm2q+7iNdAPWLHWLenIQSv
         ulwAZCThlwp4uoYR9GgkAugykSpvGKLTJqLSXggNKkCk1bOmMzz9+fTzyY5buzkFoH
         U4PGPR14cf2KPdsgGtl+1406eKRdUu/anUy46hm4tLMb00GPeWzQkIqbeylmUYpbkR
         4zBpxJ+84xzvw==
Date:   Wed, 28 Apr 2021 14:48:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anupama K Patil <anupamakpatil123@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, B K Karthik <bkkarthik@pesu.pes.edu>,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] MAINTAINERS: mark isapnp as obsolete
Message-ID: <YIlLk00Wzd6Lf660@unreal>
References: <20210428110536.edy74gsobkgtd6al@ubuntu>
 <YIlCzOl/rkYeOWVW@kroah.com>
 <20210428114057.tlc53ie7crvkqqhj@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428114057.tlc53ie7crvkqqhj@ubuntu>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 28, 2021 at 05:10:57PM +0530, Anupama K Patil wrote:
> On 21/04/28 01:11PM, Greg KH wrote:
> > On Wed, Apr 28, 2021 at 04:35:36PM +0530, Anupama K Patil wrote:
> > > isapnp code is very old and according to this link
> > > https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications
> > > from Wikipedia, even Windows Vista disabled ISA PnP by default.
> > > 
> > > This change is in follow up to
> > > https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#u
> > > and https://lore.kernel.org/lkml/20210424194301.jmsqpycvsm7izbk3@ubuntu/T/#u
> > > 
> > > Suggested-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > > Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> > 
> > Has the maintainer said this is unsupported?
> > 
> > That's who you should take suggestions from :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> Leon said he thinks it is unsupported (I've also cc'd him). So, I've sent this patch
> to get the feedback from the maintainer.

Leon said something different.
https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#m6c837180c8d6496d5bcbb8526e274c4239844be0
------
> If changes to ISA code aren't welcomed, should these be marked obsolete in the MAINTIANERS file?

I think so, but think that "Odd Fixes" better describes that Rafael wrote.
------

> 
> Thanks,
> Anupama
