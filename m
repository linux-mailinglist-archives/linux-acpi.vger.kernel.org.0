Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84A0671A4
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2019 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfGLOt1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jul 2019 10:49:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46103 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfGLOt1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jul 2019 10:49:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id c73so4399061pfb.13
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jul 2019 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jBnw+bj5T3Oj46YKg63m75/M9E4pXCF4gtk0jQxRSXU=;
        b=KOp/FTLlbPVrmtrESx26ciK+CMNvbkeSL4QP0Lj6JLKzSMGH7LcPtUDIBGFMz4xNBR
         HjyGCYh4oX95P+F+GW4vHbwJmHhtIANe/76JHUmqTCLEJnEQqDVcsDR2QKmjjip7dp/y
         Fs5wmHPUnwEv4E5Xcjpll4PYPsaq5Jw19jQ5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jBnw+bj5T3Oj46YKg63m75/M9E4pXCF4gtk0jQxRSXU=;
        b=Yug7cZJFyXiJMHacrGHZ5LNT4rLCCHfWfMZgG0ntCTGpzG3SYk2fKkMRIzPmVdhfuk
         OIsT4NmBiHDyGDIJUBpecg6MCo/PCP+JNl3d4NMDietcKDbt8FU6ddinnf5vkKrvrAlk
         wYHup2k5GNHez7TjWfU0Y8ptF0Dor0dOh8C27BjUqzf9asg1oC1C4ljgzcNrbdp2hJng
         jAHItIMdL9ZD30r5Kk5ykUq3wv6Em0w+R5PNYf11nOqv4d3XXnzerZspdQbfcXDVKXOZ
         fwAVDHd/iW/w0PAEnfc8i5ARF6mMSXDkR2mlmAim4tBVEy/NaGGko6CabIGIANWfPsPd
         Ex+w==
X-Gm-Message-State: APjAAAWG5r1KBKpyuk4m3rLppd0L/nl2uI5ogFekphdpdwZRIsF6rHli
        Wf5zVmE8RUHjR0AolFH4gEg=
X-Google-Smtp-Source: APXvYqy6jBLSnDZta2GtS/zN+m3PUtaVacX1IRd1BaAhWjyV06geRNBslZ66J2GoeWCO1s2L6yvsyA==
X-Received: by 2002:a17:90a:1904:: with SMTP id 4mr12585583pjg.116.1562942966736;
        Fri, 12 Jul 2019 07:49:26 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r1sm7928157pgv.70.2019.07.12.07.49.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 07:49:25 -0700 (PDT)
Date:   Fri, 12 Jul 2019 10:49:24 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH v1 1/6] rcu: Add support for consolidated-RCU reader
 checking
Message-ID: <20190712144924.GA235410@google.com>
References: <20190711234401.220336-1-joel@joelfernandes.org>
 <20190711234401.220336-2-joel@joelfernandes.org>
 <20190712110142.GS3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712110142.GS3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 12, 2019 at 01:01:42PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 11, 2019 at 07:43:56PM -0400, Joel Fernandes (Google) wrote:
> > This patch adds support for checking RCU reader sections in list
> > traversal macros. Optionally, if the list macro is called under SRCU or
> > other lock/mutex protection, then appropriate lockdep expressions can be
> > passed to make the checks pass.
> > 
> > Existing list_for_each_entry_rcu() invocations don't need to pass the
> > optional fourth argument (cond) unless they are under some non-RCU
> > protection and needs to make lockdep check pass.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  include/linux/rculist.h  | 29 ++++++++++++++++++++++++-----
> >  include/linux/rcupdate.h |  7 +++++++
> >  kernel/rcu/Kconfig.debug | 11 +++++++++++
> >  kernel/rcu/update.c      | 26 ++++++++++++++++++++++++++
> >  4 files changed, 68 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > index e91ec9ddcd30..78c15ec6b2c9 100644
> > --- a/include/linux/rculist.h
> > +++ b/include/linux/rculist.h
> > @@ -40,6 +40,23 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
> >   */
> >  #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
> >  
> > +/*
> > + * Check during list traversal that we are within an RCU reader
> > + */
> > +
> > +#define SIXTH_ARG(a1, a2, a3, a4, a5, a6, ...) a6
> > +#define COUNT_VARGS(...) SIXTH_ARG(dummy, ## __VA_ARGS__, 4, 3, 2, 1, 0)
> 
> You don't seem to actually use it in this patch; also linux/kernel.h has
> COUNT_ARGS().

Yes, I replied after sending patches that I fixed this. I will remove them.


thanks,

 - Joel



