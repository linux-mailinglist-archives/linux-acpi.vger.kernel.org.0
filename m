Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27A636D623
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 13:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbhD1LL4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 07:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236133AbhD1LL4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Apr 2021 07:11:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD90D613EA;
        Wed, 28 Apr 2021 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619608271;
        bh=hnhbeMRNrfdexByAWOu0ymTVODGJ3Vpny6pEPUE72Q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmLZjNNm+NRafkDEEp1/7GPULhsN9IuKhUO6mZMRZnaAP4N4L/uM6KBVXLLmeb4ul
         dImi1Y4DyG42cFDYwL+nNqYw+O19fZswoJ64Im96UZzn2wmvNfw/OMqfvAy6nRLbWL
         jg2grzy4Xk2CFVHNpmycBwr/qX1iW1Jw9/Pb/65A=
Date:   Wed, 28 Apr 2021 13:11:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anupama K Patil <anupamakpatil123@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Leon Romanovsky <leon@kernel.org>,
        B K Karthik <bkkarthik@pesu.pes.edu>,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] MAINTAINERS: mark isapnp as obsolete
Message-ID: <YIlCzOl/rkYeOWVW@kroah.com>
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
> Signed-off-by: Anupama K Patil <anupamakpatil123@gmail.com>

Has the maintainer said this is unsupported?

That's who you should take suggestions from :)

thanks,

greg k-h
