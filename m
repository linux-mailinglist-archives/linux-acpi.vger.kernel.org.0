Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC5237110A
	for <lists+linux-acpi@lfdr.de>; Mon,  3 May 2021 06:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhECE4B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 May 2021 00:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhECEz7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 May 2021 00:55:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11D4E606A5;
        Mon,  3 May 2021 04:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620017696;
        bh=WO3o+LQZ/j0I9gGlRkfelt/09GbJDh2V9r0X25n8eDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufgz+jtlo4hzUgfJzbFK19b+gX6ulwT//TWHl7fRJSarXExjkakJXh67OB+YfcB1q
         X4MsjlzzGtw0kSY0t3WCkM+WDVtE670KHXKwk4c1E4VxA+h3jZf0AtEIC+JeNzrLfX
         dqckQ9fzSbvmkP2EwaT7N0tIUOMmWGKEbXdhPgK0=
Date:   Mon, 3 May 2021 06:54:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Revert "ACPI: custom_method: fix memory leaks"
Message-ID: <YI+CHjLBg/ob6ei4@kroah.com>
References: <20210502172326.2060025-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210502172326.2060025-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, May 02, 2021 at 10:23:26AM -0700, Kees Cook wrote:
> This reverts commit 03d1571d9513369c17e6848476763ebbd10ec2cb.
> 
> While /sys/kernel/debug/acpi/custom_method is already a privileged-only
> API providing proxied arbitrary write access to kernel memory[1][2],
> with existing race conditions[3] in buffer allocation and use that could
> lead to memory leaks and use-after-free conditions, the above commit
> appears to accidentally make the use-after-free conditions even easier
> to accomplish. ("buf" is a global variable and prior kfree()s would set
> buf back to NULL.)
> 
> This entire interface needs to be reworked (if not entirely removed).
> 
> [1] https://lore.kernel.org/lkml/20110222193250.GA23913@outflux.net/
> [2] https://lore.kernel.org/lkml/201906221659.B618D83@keescook/
> [3] https://lore.kernel.org/lkml/20170109231323.GA89642@beast/
> 
> Cc: Wenwen Wang <wenwen@cs.uga.edu>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/acpi/custom_method.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index 7b54dc95d36b..36d95a02cd30 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -53,10 +53,8 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
>  	if ((*ppos > max_size) ||
>  	    (*ppos + count > max_size) ||
>  	    (*ppos + count < count) ||
> -	    (count > uncopied_bytes)) {
> -		kfree(buf);
> +	    (count > uncopied_bytes))
>  		return -EINVAL;
> -	}
>  
>  	if (copy_from_user(buf + (*ppos), user_buf, count)) {
>  		kfree(buf);
> @@ -76,7 +74,6 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
>  		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
>  	}
>  
> -	kfree(buf);
>  	return count;
>  }
>  
> -- 
> 2.25.1
> 

Thanks for the revert, I'll queue it up on my larger "umn.edu reverts"
branch that I'll be sending out for review in a day or so.

greg k-h
