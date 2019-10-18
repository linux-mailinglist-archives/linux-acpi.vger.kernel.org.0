Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 109B0DC2EB
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 12:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439275AbfJRKjS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 06:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439166AbfJRKjR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Oct 2019 06:39:17 -0400
Received: from localhost (unknown [209.136.236.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14FC222BD;
        Fri, 18 Oct 2019 10:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571395156;
        bh=fAxq5uZDgA71q0E+EM9KYGGqgdMO/URCOCKYV60akkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BN1+wD0qTRHbnQIaZ8UODya+pY1GZy3Nd9ZrsTsookRPYfazZtby9emFzpMHVT48/
         qIJkZZtvCS8lan184PtgnlkqAg7xufbYFWexLZsaL2PY439SHQlVJVvV7Wun6LwY0f
         lHYYBBJ0moU9cyAc+IG7zfK7+9KD0T6SzgftEyXY=
Date:   Fri, 18 Oct 2019 03:39:15 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serdev: Add ACPI devices by ResourceSource field
Message-ID: <20191018103915.GA1174466@kroah.com>
References: <20190924162226.1493407-1-luzmaximilian@gmail.com>
 <03d11e04-aaad-4851-c7d6-feaf62793670@redhat.com>
 <84883ba0-ec01-9114-5c4a-e468cf85dfec@gmail.com>
 <2257692.4kSTgpFGC2@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2257692.4kSTgpFGC2@kreacher>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 18, 2019 at 12:16:27PM +0200, Rafael J. Wysocki wrote:
> On Thursday, October 10, 2019 3:18:58 PM CEST Maximilian Luz wrote:
> > Hi,
> > 
> > On 10/10/19 12:22 PM, Hans de Goede wrote:
> > > This patch looks good to me and it works on my test hw with serial
> > > attached BT HCI:
> > > 
> > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > > 
> > > Regards,
> > > 
> > > Hans
> > 
> > Awesome, thank you!
> 
> Is anyone taking care of this patch, or should I do that?

It's already in my tty-next branch, so no need for you to do anything :)

thanks,

greg k-h
