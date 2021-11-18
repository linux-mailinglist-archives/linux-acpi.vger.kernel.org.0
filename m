Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE55E456500
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 22:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhKRV0G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 16:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhKRV0F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 16:26:05 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E96C061574
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 13:23:05 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 193so7939826qkh.10
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 13:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbEqPpMmH/jo3sC5t1YIUZHFlHK6tHs7NNoFxBee6V8=;
        b=kpcACWTwv9HdmrPIiGX4tEMc9ylj6kYKBFQXhG+mO51q9W5EF89vaU+hrh85a0gE5R
         UsxEckOQpjG0LQxt8g5uftAxDutwZX8jawdGS8mYaapsMufVNaHMJ3oF8y+yCcNWwP5/
         iyF+SlS59h55Yn/QDWpySpUid76iWK1moXg7VC0ZsIFUAfv4ETqdMTm4D82vbuy1rhXc
         lWEZHL8UkWm2YrxNKQ7PdwqmdrG2d3b3B9DtLPbBm8+Do+gwCpifciJGEgmXwuOX7D68
         Sw8YvYut2jtSfK0Wwsl9SRZGch7AkAfGJc//FMElzNE8O1LZTxzMcln9iEKJLcM3TLsY
         dcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbEqPpMmH/jo3sC5t1YIUZHFlHK6tHs7NNoFxBee6V8=;
        b=qi2OmARFiHv3gkvV/ZQblHLm+6HNOGHZRhS9yXkfJM1HV0nUcWzgRZaGerNlM8qNuy
         p/IxXyURWz3wsH+e2MnPW2JOrcQVeHK8XlXBa/eVXCHOyxV1wtUB+q8p8r7tu5sFKZ3u
         EwNECLmUExkg3mYhEBLkU5xQ4x2igIZ+Rbok701fqItjENqxJI0gzB+fiuDBj8Bt0TM5
         Fh+mAQccvvERCHqh+qsgFR/QDXLiejAcTbPJaD3I8G/ouA3RvGkg2x8ylfsxcjcTthW3
         y+OxCxh8ccZzpSHMKovVWsjnNJmI2eK4MFuGF3vOXWPghNAcSN3DAs/krohuyIkJT9QL
         ApYg==
X-Gm-Message-State: AOAM531mKVJSq7VmnRYzI18NcN2m4fI87vQ+kJpaePoW3g80zTJo+RZz
        Yp9aSAlkmsg4WHZ9ScKAx2NrPlPV0WxxM5liLApI3I+M+Nc=
X-Google-Smtp-Source: ABdhPJw1OaeuWelU8HRhPqmtrcAgM/4/uTFfdxapL69bnnHI3cCS8o4TFoIiOxFMsovgvxERayWbFWdO5memf031e9Q=
X-Received: by 2002:a05:620a:2808:: with SMTP id f8mr23272937qkp.214.1637270584338;
 Thu, 18 Nov 2021 13:23:04 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtYVGpvTHBwH6LErQqmEvOZFaKtR2xgFWNcbfTXUau2pQ@mail.gmail.com>
 <CAJZ5v0hCYE7_eHtnfA3Vn1PFS=Dqk5=dwdbaD_k+nusJucFaCQ@mail.gmail.com>
 <CAA85sZuSGh9pQwvHio6NkNoahQjpjCxoPAhp3MOc-aGeWjDHXg@mail.gmail.com>
 <CAJZ5v0gvEbW9aVTp+yL22fbGrhX2h667g1kGE3phxEN03e_JtA@mail.gmail.com>
 <CAA85sZsFNoQfQo0ZR79Vzw4f-o7WaxgBQ_2RhyCBMxcNkmrCeg@mail.gmail.com>
 <CAA85sZs-mgx2UqJZ8LHqmwYFr6EoVs=rM-wnStT=T0b+q9pdVQ@mail.gmail.com> <CAJZ5v0gs8vCU+fiveOjg8DJ7ys1MD-KdDm1=gjf5k2+9Qi_F_A@mail.gmail.com>
In-Reply-To: <CAJZ5v0gs8vCU+fiveOjg8DJ7ys1MD-KdDm1=gjf5k2+9Qi_F_A@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 18 Nov 2021 22:22:53 +0100
Message-ID: <CAA85sZtYgKbk8We1_L_QoQ8XVMSU=yc9pr6O8=LrDzkbiWJiig@mail.gmail.com>
Subject: Re: HP Elitebook 840 G5 - acpi failure
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

So this turns out to be a bit of a problem...

If i do:
make modules_install
make install

It generates a 900MB+ initrd that doesn't fit - and without it i can't
get it to boot properly..
I don't know what ubuntu does with mkinitrdfs but it seems quite
excessive. Also, the kernel still seems to crash (doesn't respond to
capslock) and it doesn't seem to like dyndbg="file power.c p+" - it
said something about p+ being wrong

(Company laptop, lvm, crypted fs and all that fun stuff... :/)

On Thu, Nov 18, 2021 at 2:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 18, 2021 at 2:41 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > So, hard to capture, crashes faster with minimal output:
> > https://photos.app.goo.gl/9p56395EdhNBuikQA
> >
> > First time i didn't even see the oops at all...
>
> The dynamic debug output is still not present.
>
> Please apply the attached patch (you may need to adjust it for 5.15 -
> the idea is to comment out the execution of _ON and _OFF) and boot
> with the dyndbg in power.c enabled.
>
> It should not crash this time, so you should be able to collect full
> dmesg and send it (as an attachment, please).
