Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5B436D732
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 14:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhD1MYf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 08:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235101AbhD1MYf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Apr 2021 08:24:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E478961419;
        Wed, 28 Apr 2021 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619612630;
        bh=p9Kd6pCjKL+8rnTghEg/ifXMEKIat2wt8Ogg5ebxXsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=etMY8GPoDbYWYsAHjLgJkDKXuI9C/KBaPE9lNixpdJ2xp10u5W3L10ufSlL536HQ6
         NfPU1wZ9F47quP4y87MdDnRGjo2afdgz3VlqCASjfWNxINC0IhDth/TmJ7ATHyO4/6
         XP1mt/SonLuHiSYbQ4sJu/q0eLPNZ6zbJcRafgKx34yNloU2gdcjBxxgUINaTT3XQk
         IeTFEoISviYME4CHpm2eqhSuxJy9EgmyVlz7gFM0QwbpqwmbQOIw2lriY6jO1iZSwV
         iEUItv33gCeGLfALSaxzko8uT7mur5te5FmWzJs/QhtzsnVnYbTsU4i3GxwTG/jzf4
         wHZrP2jg7ALYg==
Date:   Wed, 28 Apr 2021 15:23:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, B K Karthik <bkkarthik@pesu.pes.edu>,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] MAINTAINERS: mark isapnp as obsolete
Message-ID: <YIlT0KKfT6QaE8mz@unreal>
References: <20210428110536.edy74gsobkgtd6al@ubuntu>
 <YIlCzOl/rkYeOWVW@kroah.com>
 <56ea648f-3742-6dd6-9deb-5f1ba441905f@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ea648f-3742-6dd6-9deb-5f1ba441905f@perex.cz>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 28, 2021 at 02:17:00PM +0200, Jaroslav Kysela wrote:
> Dne 28. 04. 21 v 13:11 Greg KH napsal(a):
> > On Wed, Apr 28, 2021 at 04:35:36PM +0530, Anupama K Patil wrote:
> >> isapnp code is very old and according to this link
> >> https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications
> >> from Wikipedia, even Windows Vista disabled ISA PnP by default.
> >>
> >> This change is in follow up to
> >> https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#u
> >> and https://lore.kernel.org/lkml/20210424194301.jmsqpycvsm7izbk3@ubuntu/T/#u
> >>
> >> Suggested-by: B K Karthik <bkkarthik@pesu.pes.edu>
> >> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>
> > 
> > Has the maintainer said this is unsupported?
> 
> I've no idea, if there're any users at the time, but there are many drivers
> which depend on this code.

IMHO, this is exactly "Odd fixes" - code not really dead, but not really
alive too.

Thanks

> 
> I'll try to reply to patch threads.
> 
> 						Jaroslav
> 
> -- 
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
