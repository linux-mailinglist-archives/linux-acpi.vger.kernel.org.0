Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440A839DAC1
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhFGLLW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 07:11:22 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46599 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhFGLLW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 07:11:22 -0400
Received: by mail-ot1-f44.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso16253172otl.13;
        Mon, 07 Jun 2021 04:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbDcy9y8OIgNQragObdLQCq4MNRQ/MHsqkFFiU3S5GQ=;
        b=aqgZIThzCIcEQf1IdUJAbqKVsQE3xdM02JXmQW25KP+wQJm0M5fg/3qX2ckdwqkkZh
         P0Zc9tD6bsmJi38bK4KZohGNer0LCPdTSMg7/gKTC6usOa3e5WYagiy3VLymIORdHZiN
         xwn6K9eBhKREFPjQ0c8ZbRqM0c+I+DZe+dTeSb1dgorA46Sxh3EyeIh6YAv2ztv3/gZW
         dPtPf3YwW96DT6ksxAwDBJQqrspO1qnpPDpHPBdTrR6WxtJbao6r88kyvB2WnuoJmazS
         EFQdm5S1CPCR6iNRJ0NoiCI0coe/H2VyRlDcKzTw/qwFJXyg86BBStbpd16LTX/7Yr3I
         MJ4Q==
X-Gm-Message-State: AOAM533UQIdxy8kVrVie0a08BqZX0n4VuIR1KEXsLz6moNgTeZKzhfEk
        FnnPwEWVwnqXe5f5JOoKrDJ/hKoHy5hsO2NGwlIpfhgI
X-Google-Smtp-Source: ABdhPJw/9aALilbNzbdeqgGawhgflIxAZCKim0wrnH4HcjOJSGOjlh0zVSH5V2Y7LVn7iwLDvZg4yLWe9TXCt163KiI=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr13144368otg.260.1623064157883;
 Mon, 07 Jun 2021 04:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210604170500.46875-1-kyle.meyer@hpe.com> <20210607032550.qdnl2sxnny42rtwa@vireshk-i7>
 <s5h35tuf8qd.wl-tiwai@suse.de> <20210607072637.b5mwcalab7y2vikx@vireshk-i7>
In-Reply-To: <20210607072637.b5mwcalab7y2vikx@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 13:09:00 +0200
Message-ID: <CAJZ5v0jgH64Kbi12+tYbq384z5qEOKB68VELwtq28oiF1DjxkA@mail.gmail.com>
Subject: Re: [PATCH] acpi-cpufreq: Skip cleanup if initialization didn't occur
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Kyle Meyer <kyle.meyer@hpe.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 7, 2021 at 9:26 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 07-06-21, 09:13, Takashi Iwai wrote:
> > The missing key information is that it's a fix for the recent change
> > for 5.14, i.e.
> > Fixes: c1d6d2fd2f64 ("cpufreq: acpi-cpufreq: Skip initialization if cpufreq driver is present")
> >
> > The change made the module left even if it exits before registering
> > the cpufreq driver object.
>
> The original patch looks buggy to me, I was never able to review it :(
>
> I have replied on the original thread instead.

Well, thanks, but that confused me a bit.

Given the above, I'm going to drop the original patch.

Kyle, please reconsider this approach.
