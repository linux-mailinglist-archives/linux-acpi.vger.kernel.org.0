Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF07A371FC4
	for <lists+linux-acpi@lfdr.de>; Mon,  3 May 2021 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhECSgr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 May 2021 14:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhECSgq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 May 2021 14:36:46 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A6FC061761
        for <linux-acpi@vger.kernel.org>; Mon,  3 May 2021 11:35:53 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id y30so4289816pgl.7
        for <linux-acpi@vger.kernel.org>; Mon, 03 May 2021 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HxkYrK3zW8etQ6PavENL/qB+P2FEj6XtVcSQW8y4HEM=;
        b=XQ6WDjz+frkLf8fxTaVGb2OA9y3p4t8ocHwkPgkWTfruNYYw3Hx4X9VY2WtAkpcwl0
         +jYdaCFS0euQgPwLdfA9E7NaVd4x/HAXVRykLngV3rOjAVW6fiAo4ukcAnH8uUWgv/ot
         hcA5wUkf5QQy0odr3Y7nxZM68CtqLhzQLm5To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HxkYrK3zW8etQ6PavENL/qB+P2FEj6XtVcSQW8y4HEM=;
        b=SEjEPPsBa/D0qDG7w8DRnWibDbMB5ftDUvEaWjLBYd880QHlb/vnGvIvtfXZf3r4v4
         iBjJqIDRkQb2hWSA6Od2sIAbbndSeZtnGbM8zp3LF55Rj9tSq3yogvPx7knNuT05uYjb
         WCPNcAGgF1ymPLsJ32jS/AzYTtBH6OftttPaG20UpbY5v+KCHnX9ORP9NlJ2zlHQM9mH
         wFQmQ+2vARh88+B3Y9A30Wf3M8KkBBzJNtkrMOaWxHUK6nQ48J0TwChqcahDytzr5pY7
         CEZAl399aDKF9rB3MBX4rHQu6bbNKkxj5mxdpiwZXwbo/U26lxEAzo4NL2eOpk3CszxJ
         XD/A==
X-Gm-Message-State: AOAM532SV4qRnyq2TA4+IwRLxnN+Ci3hQ8lCaE7lKjsTu+9JOgG40Q5p
        9zcxZyRvuhI1mow4eYLhar1ZKRuJNzVOhQ==
X-Google-Smtp-Source: ABdhPJxnPMU6N16yM5pqUnVfmEQkDrOnx4CcthbHsM/Cg4Di10L9lud2wbf1i+PuRFuXzvcEzHVWTw==
X-Received: by 2002:a63:1214:: with SMTP id h20mr19466340pgl.207.1620066952679;
        Mon, 03 May 2021 11:35:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mg11sm9973114pjb.24.2021.05.03.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 11:35:51 -0700 (PDT)
Date:   Mon, 3 May 2021 11:35:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Langsdorf <mlangsdo@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Revert "ACPI: custom_method: fix memory leaks"
Message-ID: <202105031134.A0E51D73@keescook>
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

Thanks for working on that! It'd be nice if there was a lock held for
the duration of the "open", then all the concurrency races would go
away. But, I haven't spent a lot of time looking since it's root-only
and already blocked by lockdown, etc.

-- 
Kees Cook
