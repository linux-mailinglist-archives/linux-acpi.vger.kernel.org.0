Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2639464E201
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Dec 2022 20:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiLOTxD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Dec 2022 14:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLOTxD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Dec 2022 14:53:03 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE56532E6
        for <linux-acpi@vger.kernel.org>; Thu, 15 Dec 2022 11:53:01 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id g14so47561ljh.10
        for <linux-acpi@vger.kernel.org>; Thu, 15 Dec 2022 11:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7WnaZc2bs26QE2S1hFU0wWVtk2SkMXSSpzkb6FSS1RI=;
        b=aGblDN6+LiroAi5Ce2HI0sla+sv/MZ0o1VnWUgJkTxIOUl93xZYtZDnsd8zl1DABm2
         OfhiFJBPHg9RSV8cw+9sGyvjAUzHb9igov4etIG+PT6jB8if72VmeESBXHF3IHsiLc5M
         b2CmaXYJsYqhGPOOzKvG2srf3DxtCyWSKXn2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WnaZc2bs26QE2S1hFU0wWVtk2SkMXSSpzkb6FSS1RI=;
        b=6PyhsSIqEpKWPZ2z61tQWGD3SNBkK/t00lpmsoblYMsx2RIETz2j/BvjtT2J2yTxQs
         o84cgKlGeie+FIn12Gt1tbNFxwjluMVtHD1EUDT2gVlN5XFn0ypt+n9q8SVY6yesZ7f4
         /0Eq7iXxikXewlmvgCyQQsbC4PbDXdkEsAE67CcMsNTM7vZN9f8NX5HbHSHP1agm1w6x
         lPZjIR2PAtVYeU4OsLvl16WJwuLgWnLt44rcJOYyhz7n6s7hM1sVX2qYiB4XyBMso45a
         3klcvcbruNB0Ui8nP06b8rgwrl9GJCRWnvki4OQK7nun6KnIrWNZam2+BvjivNOb/m50
         HKRw==
X-Gm-Message-State: ANoB5pmV1oY6lIIeuOdnIBEUj/6tzg5KqqRiBOcdZgQOXsVpGb3FUYCe
        WcEHkMwoo/zfpyXeayZFCOp9OPijh65LbIJGM3Hgvw==
X-Google-Smtp-Source: AA0mqf4FW9H2CtluhofbPQJiA6xZ7ZdK14RZtc7ewZw8cqvcl+H7LOmqZe+1wc0FJ8tx6X3g9uIC6DD8PJrYGi5UrrE=
X-Received: by 2002:a05:651c:124c:b0:279:f45e:ccd6 with SMTP id
 h12-20020a05651c124c00b00279f45eccd6mr7839328ljh.483.1671133979884; Thu, 15
 Dec 2022 11:52:59 -0800 (PST)
MIME-Version: 1.0
References: <20221214233106.69b2c01b@gandalf.local.home> <Y5trUep9IvCv1Uwy@google.com>
 <20221215141146.6ceb7cf2@gandalf.local.home>
In-Reply-To: <20221215141146.6ceb7cf2@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 15 Dec 2022 14:52:48 -0500
Message-ID: <CAEXW_YQLtK=4LMJ+LHPVWU0wbV-027HJoCEKTjZvBZ6krrn6vw@mail.gmail.com>
Subject: Re: [RFC][PATCH] ACPI: tracing: Have ACPI debug go to tracing ring buffer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 15, 2022 at 2:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 15 Dec 2022 18:45:37 +0000
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > Wouldn't it be better to also check trace_acpi_print_enabled() here in the
> > else if() condition, along with IS_ENABLED()? That way if the CONFIG is
> > enabled but the tracepoint is not enabled, at least the messages will go to
> > dmesg instead of skipped.
>
> I really don't want that. This was purposely done to be mutually exclusive.
> The reason I added this in the first place, is because too much enabled
> will render the system useless if printk() is used.
>
> After boot up, if I had enabled all debug events and then I were to disable
> the acpi tracepoint, it will likely render the system useless again if it
> were to switch over to printk.

Ok, sure. I see where you were going. So you want no debugging
messages at all if the trace event is disabled. That's fine with me. I
would also add a note about the need to enable the specific trace
event, in the Kconfig message and/or the Documentation. Otherwise, you
might get someone say, "hey I enabled the CONFIG option but I see
nothing in the trace buffer".

Another approach could be to always enable the trace event by default,
if the CONFIG is turned on. Or do a printk() telling the user about
the event to enable, so they know why their trace buffer is empty.

Up to you and the ACPI maintainers. ;-)

thanks,

 - Joel
