Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A9136ED5A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Apr 2021 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbhD2P0X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Apr 2021 11:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240745AbhD2P0K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Apr 2021 11:26:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34BD361447;
        Thu, 29 Apr 2021 15:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619709923;
        bh=p+fCHqF6Kr3SZXaDZH/j99EDdm9CtEPVxq6zsJ4PJq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KI+1EKW3KQ/bqo6C+Whqlvd4heTGn+OO3AXeBRa0ILC/SkbK04+Se/RtjJpZfOUg8
         J/2C6gp/mzRgDU/bRKM80GLJvka3CFOQ/FA4A9R8CdoogZkz9FNb6FNgPuqd3bZKtt
         HUxHp9zwh+nblSjne24qJJ+kF/lLMa5Djree8xtE=
Date:   Thu, 29 Apr 2021 17:25:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anupama K Patil <anupamakpatil123@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Leon Romanovsky <leon@kernel.org>,
        B K Karthik <bkkarthik@pesu.pes.edu>,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] MAINTAINERS: mark isapnp as obsolete
Message-ID: <YIrP4TI2T18aH5NG@kroah.com>
References: <20210428110536.edy74gsobkgtd6al@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428110536.edy74gsobkgtd6al@ubuntu>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 28, 2021 at 04:35:36PM +0530, Anupama K Patil wrote:
> isapnp code is very old and according to this link
> https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications
> from Wikipedia, even Windows Vista disabled ISA PnP by default.
> 
> This change is in follow up to
> https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#u
> and https://lore.kernel.org/lkml/20210424194301.jmsqpycvsm7izbk3@ubuntu/T/#u
> 
> Suggested-by: B K Karthik <bkkarthik@pesu.pes.edu>

This person should not have suggested this, sorry if you were lead
astray.  The maintainer is in charge of this type of thing, it's a bit
rude to try to "force" someone's hand by doing this.  Be careful.

thanks,

greg k-h
