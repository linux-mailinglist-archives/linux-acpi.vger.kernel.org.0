Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C04371716
	for <lists+linux-acpi@lfdr.de>; Mon,  3 May 2021 16:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhECOwi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 May 2021 10:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhECOwi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 May 2021 10:52:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6563560240;
        Mon,  3 May 2021 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620053504;
        bh=cAMx8xccIx/V2gUXG4vJowPRwN2qrbNSxvfP+zdKpIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFaWzOacmLj42ePR3fnRpTjIUKuTa4A9h1huKH6R73bu8EX+uVfmQded0zCy7mGK+
         ddZPHQ/LKJMExycUrqEWvNRBH1fHeJevCLtNg2xtQ6iy2G9KG2plrSTGrgVin4EVwh
         HPx5zFiMtl+fS2BAWTGvC2jFcpEKa5O9KcVbgzhU=
Date:   Mon, 3 May 2021 16:51:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Langsdorf <mlangsdo@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Revert "ACPI: custom_method: fix memory leaks"
Message-ID: <YJAN/nwldJKwTV/V@kroah.com>
References: <20210502172326.2060025-1-keescook@chromium.org>
 <0fefece0-f8a1-6ee1-114f-0a2bb412b986@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fefece0-f8a1-6ee1-114f-0a2bb412b986@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 03, 2021 at 08:17:14AM -0500, Mark Langsdorf wrote:
> In 5/2/21 12:23 PM, Kees Cook wrote:
> > This reverts commit 03d1571d9513369c17e6848476763ebbd10ec2cb.
> > 
> > While /sys/kernel/debug/acpi/custom_method is already a privileged-only
> > API providing proxied arbitrary write access to kernel memory[1][2],
> > with existing race conditions[3] in buffer allocation and use that could
> > lead to memory leaks and use-after-free conditions, the above commit
> > appears to accidentally make the use-after-free conditions even easier
> > to accomplish. ("buf" is a global variable and prior kfree()s would set
> > buf back to NULL.)
> > 
> > This entire interface needs to be reworked (if not entirely removed).
> > 
> > [1] https://lore.kernel.org/lkml/20110222193250.GA23913@outflux.net/
> > [2] https://lore.kernel.org/lkml/201906221659.B618D83@keescook/
> > [3] https://lore.kernel.org/lkml/20170109231323.GA89642@beast/
> > 
> > Cc: Wenwen Wang <wenwen@cs.uga.edu>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> I have two patches submitted to linux-acpi to fix the most obvious bugs in
> the current driver.  I don't think that just reverting this patch in its
> entirety is a good solution: it still leaves the buf allocated in -EINVAL,
> as well as the weird case where a not fully consumed buffer can be
> reallocated without being freed on a subsequent call.
> 
> https://lore.kernel.org/linux-acpi/20210427185434.34885-1-mlangsdo@redhat.com/
> 
> https://lore.kernel.org/linux-acpi/20210423152818.97077-1-mlangsdo@redhat.com/
> 
> I support rewriting this driver in its entirety, but reverting one bad patch
> to leave it in a different buggy state is less than ideal.

It's buggy now, and root-only, so it's a low bar at the moment :)

Do those commits really fix the issues?  Is this debugfs code even
needed at all or can it just be dropped?

thanks,

greg k-h
