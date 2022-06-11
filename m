Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DB754715F
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Jun 2022 04:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349011AbiFKCd1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Jun 2022 22:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349039AbiFKCdY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jun 2022 22:33:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1261C6B01A
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jun 2022 19:33:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w27so1005815edl.7
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jun 2022 19:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgKkPquDB/3ylB22sdoq44O3nuMRqOGPmfYPJEM3DpI=;
        b=JsXVqmPM/FghNi+FuyecZKJimRfQRZRaZMN7LbU4AElduixKN8TVkmhpZTWnrsGkbZ
         5LwE/p8/n+cIXvQ1YTcLTi0yyURcD/DMLBUnB+eqSpwlWIAygkMHM4b3P17Zp5erCg7D
         knTgcyr8j5ARmG7z3CGlckVUGoumxDAZyb+n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgKkPquDB/3ylB22sdoq44O3nuMRqOGPmfYPJEM3DpI=;
        b=sl5YDS7zutkZR6KNvo+ttpNkvgHUeN4xieARiDBf1DbMFeIXASlPAivyuT8//tH5UO
         C29dFRdQHnm7vOY7auQp7kPtN9pLkfZSJ5p4xpCv3oQCYMb8GVqvgKP+rqRUYNq8Xf14
         9W3aPblwL7dY28R6OlL74YCvOrsPfgM/DNC05yAAxlp1NcDv5XwwrdDCpUJZbbJOUUKu
         gQ/HtIL4yWx/yR+E9NQYS6yzigSoR9Q1qiprCrPDi3xwCOpfZxf/6ZRmdHd+UiqVOq0X
         OIerqDraaUEkZImL69cIgOrLTfrf6cWq471VLOHgnxDRX8w6gNB6nmXca7oBk+LOmSIp
         NDkA==
X-Gm-Message-State: AOAM532KDYzBPVN4K40Gx+Q7M4X1zPLlimsVo4SOYVhh3pLUfpv0NXiG
        tJCSggiiZSxag3A9UFZrn/dWMyEoFmxqp4AaHL7C6w==
X-Google-Smtp-Source: ABdhPJzFbgEeXrjhdaEFlL5CPKYiFgrRM2XGTpISMDDKOxh3YJg+nd70yb1Qcu1fnLsZwhWAweXqTRUn04uTYMjQVNU=
X-Received: by 2002:aa7:c604:0:b0:42d:cffb:f4dc with SMTP id
 h4-20020aa7c604000000b0042dcffbf4dcmr55022482edq.270.1654914796079; Fri, 10
 Jun 2022 19:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org> <20220608144517.444659212@infradead.org>
 <YqG6URbihTNCk9YR@alley> <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net>
 <CA+_sPaoJGrXhNPCs2dKf2J7u07y1xYrRFZBUtkKwzK9GqcHSuQ@mail.gmail.com> <YqHvXFdIJfvUDI6e@alley>
In-Reply-To: <YqHvXFdIJfvUDI6e@alley>
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
Date:   Sat, 11 Jun 2022 11:33:05 +0900
Message-ID: <CA+_sPaq1ez7jah0bibAdeA__Yp92K_VA7E-NZ9knoUmOW9itJg@mail.gmail.com>
Subject: Re: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk,
        ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, bcain@quicinc.com,
        chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
        sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com,
        boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com,
        rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org,
        john.ogness@linutronix.de, paulmck@kernel.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-xtensa@linux-xtensa.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 9, 2022 at 10:02 PM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2022-06-09 20:30:58, Sergey Senozhatsky wrote:
> > My emails are getting rejected... Let me try web-interface
>
> Bad day for mail sending. I have problems as well ;-)

For me the problem is still there and apparently it's an "too many
recipients" error.

> > I'm somewhat curious whether we can actually remove that trace event.
>
> Good question.
>
> Well, I think that it might be useful. It allows to see trace and
> printk messages together.

Fair enough. Seems that back in 2011 people were pretty happy with it
https://lore.kernel.org/all/1322161388.5366.54.camel@jlt3.sipsolutions.net/T/#m7bf6416f469119372191f22a6ecf653c5f7331d2

but... reportedly, one of the folks who Ack-ed it (*cough cough*
PeterZ) has never used it.

> It was ugly when it was in the console code. The new location
> in vprintk_store() allows to have it even "correctly" sorted
> (timestamp) against other tracing messages.

That's true.
