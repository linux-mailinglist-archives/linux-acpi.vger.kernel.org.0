Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFFA32F98
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2019 14:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfFCM2z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Jun 2019 08:28:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43277 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfFCM2y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jun 2019 08:28:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so2406509ljv.10
        for <linux-acpi@vger.kernel.org>; Mon, 03 Jun 2019 05:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WvqHOC4rVKX462WwE0yHSlmBZF1YO9aROqbvN/HfH6Y=;
        b=PYGUZK+GV8eTc/sc1/LJV2/FRh6sJ3eQVXqtHpM1WdCHjxWxGcJHVX6no/5nw7UnO6
         DV0yDj/ec3TxqyDkkmaBhVAS4R0g44dxp9/lCrwxqbNfRaWzZra8qYmAc+YZXjsgn2FX
         UGutllvZNq/hEvDPh7uqahFLrpIWsFBdileHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WvqHOC4rVKX462WwE0yHSlmBZF1YO9aROqbvN/HfH6Y=;
        b=gFMEO2JPk72uIIcsZErqHJrwLILh8xnpACER3aOEibhg7yTDegUlkizLvSO0IJcgOG
         9fihvYeEkrr+7yVGwPIdpA8HBiB+sr+1WNCGvg8jFWAOMn9LdeFMuMEHS56cAZdwqMEW
         NN46ueam8jKrsQLOi28G4Ox1HuKi7dAYIN9ghWByrhb5euawSRRa4JQjJ/v8584SLMyD
         tfYnrUwpxkowyAo/yGiJlzJq6AltSEr70d4o5wDKH7NP0lodLIWJB0JXdNKT4v06eACi
         QdOXCOSXVt6PDQvSgp08+tn0eJKpRQQE9bN0CIiD5/jF9H4v6wwj5NEHTplykE75/YhD
         C2Pw==
X-Gm-Message-State: APjAAAVkn+SZLXYsKa6SxYTlIurd+gB4So4NBPYqV8xadRNV5v5KXZzS
        9ytafWFSXGEyuLlIjXc8wwjsd8YwRun38xr72QHpCw==
X-Google-Smtp-Source: APXvYqzHzzga29JITONK+bAJt2s0MgC0PRTzbGVoOX6cnbI/p9OIDGMPiEXt3Q9ji63k1yr8CtUni9paU765sGDmFMs=
X-Received: by 2002:a2e:9742:: with SMTP id f2mr13977662ljj.184.1559564932484;
 Mon, 03 Jun 2019 05:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190601222738.6856-1-joel@joelfernandes.org> <20190601222738.6856-3-joel@joelfernandes.org>
 <20190602070014.GA543@amd> <CAEXW_YT3t4Hb6wKsjXPGng+YbA5rhNRa7OSdZwdN4AKGfVkX3g@mail.gmail.com>
 <CAEXW_YSM2wwah2Q7LKmUO1Dp7GG62ciQA1nZ7GLw3m6cyuXXTw@mail.gmail.com> <20190603064212.GA7400@amd>
In-Reply-To: <20190603064212.GA7400@amd>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 3 Jun 2019 08:28:41 -0400
Message-ID: <CAEXW_YSz8SNQCTnJj_86uJvRX3LFEQ6xJX-UV07HGwwA7oLwvg@mail.gmail.com>
Subject: Re: [RFC 2/6] ipv4: add lockdep condition to fix for_each_entry
To:     Pavel Machek <pavel@denx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neil Brown <neilb@suse.com>, netdev <netdev@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zilstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 3, 2019 at 2:42 AM Pavel Machek <pavel@denx.de> wrote:
>
> On Sun 2019-06-02 08:24:35, Joel Fernandes wrote:
> > On Sun, Jun 2, 2019 at 8:20 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Sun, Jun 2, 2019 at 3:00 AM Pavel Machek <pavel@denx.de> wrote:
> > > >
> > > > On Sat 2019-06-01 18:27:34, Joel Fernandes (Google) wrote:
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >
> > > > This really needs to be merged to previous patch, you can't break
> > > > compilation in middle of series...
> > > >
> > > > Or probably you need hlist_for_each_entry_rcu_lockdep() macro with
> > > > additional argument, and switch users to it.
> > >
> > > Good point. I can also just add a temporary transition macro, and then
> > > remove it in the last patch. That way no new macro is needed.
> >
> > Actually, no. There is no compilation break so I did not follow what
> > you mean. The fourth argument to the hlist_for_each_entry_rcu is
> > optional. The only thing that happens is new lockdep warnings will
> > arise which later parts of the series fix by passing in that fourth
> > argument.
>
> Sorry, I missed that subtlety. Might be worth it enabling the lockdep
> warning last in the series...

Good idea, will do! Thanks.
