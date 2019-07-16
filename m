Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F586AEB8
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 20:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbfGPSfV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 14:35:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38095 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPSfV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 14:35:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so10546647plb.5
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jul 2019 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qAKhev+MhcsyOVuReyPGPlfwr6RAqsm8KLJC/p+tBWo=;
        b=BtxFNZrJ1lxuLHdz4p0cb5NpRBas4oMeXYrSpaXChm3f5inh99nI5E+MdCjO+0SvFN
         Ry8bf1i9hikIL8m72cMNN8wnWLsm9KfRlPPMZ5RjfBcQEkIc6IujCMbAsuy+mISYcuee
         Qr4kYdcFcd5XUHZrH7KXQ8HM3/IMx446SBoQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qAKhev+MhcsyOVuReyPGPlfwr6RAqsm8KLJC/p+tBWo=;
        b=awERIROkxiYFs5YQ3jt2PazKHlb5SpgSII/wAVtvKNBJd+Y4Ce5uKK6dAQfDVLWL+i
         euHu/lk+GYUZfociwZdpSOU99TAepcOUKWnFON4tRka89rYWtWEa2NI9S57g3GYmaf97
         WECoNm/Kf6PaTFzTyJ7Gi9wHwlCGqKLNNQ2Gic7mFnFnMAVPz69y2/J/HjvfwYewCNPQ
         5Y9bHeisORKzpPLkvbmIyUFcyPg72R+eUQk2xct3tLvc9DJb8d+RVBXuAowK696Zc56A
         HKmhxABKlsUy3phKoeRGfJ17CDS3Fza0VjpGyce9uzIpnsCyUuFDJ7RAgUW9JtT987qy
         jUrQ==
X-Gm-Message-State: APjAAAX05OfyAxgkqVPoljQDZJqtwdcohhEb5yCU2ciXWNyw7b79azvc
        zZGWCNNeFbUly2R9TKA6BuI=
X-Google-Smtp-Source: APXvYqyfCs9+aKdxQJQ7pxXZdVPAjoPO3h0r2nncpS7RMorjmeD2xnNucSDVGhLwrY66fVK+0eWNvA==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr38238048pls.9.1563302119843;
        Tue, 16 Jul 2019 11:35:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a15sm16618398pgw.3.2019.07.16.11.35.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 11:35:19 -0700 (PDT)
Date:   Tue, 16 Jul 2019 14:35:17 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        peterz@infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH v2 2/9] rcu: Add support for consolidated-RCU reader
 checking
Message-ID: <20190716183517.GA129705@google.com>
References: <20190712170024.111093-1-joel@joelfernandes.org>
 <20190712170024.111093-3-joel@joelfernandes.org>
 <20190716182237.GA22819@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716182237.GA22819@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 16, 2019 at 11:22:37AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 12, 2019 at 01:00:17PM -0400, Joel Fernandes (Google) wrote:
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
> 
> If you fold in the checks for extra parameters, I will take this
> one and also 1/9.

I folded the checks in and also threw in the rcu-sync with Oleg's ack:

Could you pull into /dev branch?

git pull https://github.com/joelagnel/linux-kernel.git list-first-three
(Based on your dev branch)

