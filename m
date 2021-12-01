Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336574650C0
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Dec 2021 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbhLAPH0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Dec 2021 10:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350291AbhLAPHV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Dec 2021 10:07:21 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15105C061757
        for <linux-acpi@vger.kernel.org>; Wed,  1 Dec 2021 07:04:00 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id m25so24219253qtq.13
        for <linux-acpi@vger.kernel.org>; Wed, 01 Dec 2021 07:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfLIjTWdzQuWMciFM+vlNCVFv2mU72+tidkb+VNT+HA=;
        b=dXJe2QN5FrsCg6BxEVluZedIGDeAvEen7sggSDl6VzQSj84nPpzPeSEnmY0xbMAfkM
         m7SJanAT3vLPUUcmhzszCy3r9vxY4ckg149NLEDi6H4TuoCcY8tktwOasV4YtSEUMnDx
         Fh20JuEH3GElyOC1Ki3ZZd9FO6CFoG5AOLHtnQJ3puyqfCw5IV02hDF+ZnwUwUqeanus
         mVeYoud15oDKpJfE5VxS/jMCJ3sYZ8qOkrSiAoH4Ctp/FxcHvtXRfp6JW7dwcLtr488G
         Jolx9sISd++YnjrGVrOvzXot2mdJniEwTsFNo2/MSl31c+SHshCxdHKLJLSXLHdc4vBr
         5I6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfLIjTWdzQuWMciFM+vlNCVFv2mU72+tidkb+VNT+HA=;
        b=n9tT6b4Y9koK/M0I4fmr7tAEB32yG5sElUg7sdzzr+0/ze5HdcblX4/tuhYWgSa7PJ
         O7c9016RstKUIXV0IxvlLfVkux5orZ3R+Jr5Nr5nRe+9+oESyU2wQnp38zbFzsKc/5d6
         uaOly5X+myLC27jDMLhC71MRsewnz+OcUnScOBH9I3U6I946z2+iMlKameHd8VrB8ysN
         iYqa57HCfbCqpynwHvhpfxAvDLuZ56TNWRfvp49ymEPBSOWZ+oKzj/ygPV5ymLOjOKNd
         sJ8EQIwqlCavaEj52WEwvY3m6/H9+fDt5DjqPfySR2BugXyNV5b71kzpk6BLnhXzEpSc
         4Y6Q==
X-Gm-Message-State: AOAM53363wEwmQ6eOms2hLJmyjEZlNeDza9ChLTc1TUShuc/41A0kw7Y
        adU4HLUkDLfsV1XoKmRUb8JFzYHFRrxbyBf0+8M=
X-Google-Smtp-Source: ABdhPJz96Ibf7zmayQPAOFAAaHRrKzWRynrUo3ea7UXbd/9t7rcJ5G/HmLR1OoMvuG4D7xR2KVrJg48VanFGGiW968M=
X-Received: by 2002:ac8:5dc6:: with SMTP id e6mr7412392qtx.597.1638371039068;
 Wed, 01 Dec 2021 07:03:59 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtYVGpvTHBwH6LErQqmEvOZFaKtR2xgFWNcbfTXUau2pQ@mail.gmail.com>
 <CAJZ5v0hCYE7_eHtnfA3Vn1PFS=Dqk5=dwdbaD_k+nusJucFaCQ@mail.gmail.com>
 <CAA85sZuSGh9pQwvHio6NkNoahQjpjCxoPAhp3MOc-aGeWjDHXg@mail.gmail.com>
 <CAJZ5v0gvEbW9aVTp+yL22fbGrhX2h667g1kGE3phxEN03e_JtA@mail.gmail.com>
 <CAA85sZsFNoQfQo0ZR79Vzw4f-o7WaxgBQ_2RhyCBMxcNkmrCeg@mail.gmail.com>
 <CAA85sZs-mgx2UqJZ8LHqmwYFr6EoVs=rM-wnStT=T0b+q9pdVQ@mail.gmail.com>
 <CAJZ5v0gs8vCU+fiveOjg8DJ7ys1MD-KdDm1=gjf5k2+9Qi_F_A@mail.gmail.com>
 <CAA85sZtYgKbk8We1_L_QoQ8XVMSU=yc9pr6O8=LrDzkbiWJiig@mail.gmail.com> <CAA85sZuLF_BVVb9ShiUk5cno6V17MdAg5qhgdDgnAVuoYqD+Hw@mail.gmail.com>
In-Reply-To: <CAA85sZuLF_BVVb9ShiUk5cno6V17MdAg5qhgdDgnAVuoYqD+Hw@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 1 Dec 2021 16:03:48 +0100
Message-ID: <CAA85sZsLLDAQ7Nk83iZNMSsE3X1fqri39C6Uwx+SWWn5Tw1i8w@mail.gmail.com>
Subject: Re: HP Elitebook 840 G5 - acpi failure
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 19, 2021 at 11:49 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Thu, Nov 18, 2021 at 10:22 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > So this turns out to be a bit of a problem...
> >
> > If i do:
> > make modules_install
> > make install
> >
> > It generates a 900MB+ initrd that doesn't fit - and without it i can't
> > get it to boot properly..
> > I don't know what ubuntu does with mkinitrdfs but it seems quite
> > excessive. Also, the kernel still seems to crash (doesn't respond to
> > capslock) and it doesn't seem to like dyndbg="file power.c p+" - it
> > said something about p+ being wrong
> >
> > (Company laptop, lvm, crypted fs and all that fun stuff... :/)
>
> So, got the initrd down so that it just about fits, here is the dmesg
>
> Also, the kernel seems to switch the quotation marks around...

Anything else you need, I did do a new capture with 5.15.6 but it
doesn't seem to be different in the output. Perhaps some proper
logging?
