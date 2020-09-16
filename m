Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6612B26C9A7
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 21:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgIPTPq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 15:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbgIPRiM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2020 13:38:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DEDC0698E3;
        Wed, 16 Sep 2020 09:04:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c3e006cd2bace0261b86c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:3e00:6cd2:bace:261:b86c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 23A1C1EC032C;
        Wed, 16 Sep 2020 18:01:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600272069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xHyjNCg9lyL8r3f8F9ATmWfKCsYChSlI1Pfif6iFPgA=;
        b=YglrM89FW96ZdscfcpIc7PJUAzHf8KLJeLwFasyY7mR4eGsWBg3AmwbPaylIK784zyrGoP
        VDbi7LE51V41yu/JeCNR+Bv24K6u3MQI4HvlJhzVgdHagO4N7dUXtpxAd+kWgb4gI1ITU8
        A2o1oRRyWy5DXd7ZWWzctwFx7uS43OU=
Date:   Wed, 16 Sep 2020 18:01:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     peterz@infradead.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [RFC][PATCH 1/4] acpi: Use CPUIDLE_FLAG_TIMER_STOP
Message-ID: <20200916160103.GL2643@zn.tnic>
References: <20200915103157.345404192@infradead.org>
 <20200915103806.280265587@infradead.org>
 <CAJZ5v0jD-Lv5WAKHd9KN8sPozN4DeA-sQ4pXZTHNSZ4XS=as3A@mail.gmail.com>
 <20200916154212.GE1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200916154212.GE1362448@hirez.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 16, 2020 at 05:42:12PM +0200, peterz@infradead.org wrote:
> On Tue, Sep 15, 2020 at 06:26:52PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Sep 15, 2020 at 12:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Make acpi_processor_idle use the common broadcast code, there's no
> > > reason not to. This also removes some RCU usage after
> > > rcu_idle_enter().
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > The whole series looks good to me, so please feel free to add
> > 
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > to all of the four patches.
> > 
> > Alternatively, please let me know if you want me to take the patches.
> 
> Feel free to take them. All the prerequisite borkage is in linus' tree
> already.

You can add:

Reported-by: Borislav Petkov <bp@suse.de>

for this one and for this whole series:

Tested-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
