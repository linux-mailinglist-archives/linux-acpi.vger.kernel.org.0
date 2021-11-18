Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C03455C76
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 14:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhKRNUr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 08:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhKRNUq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 08:20:46 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B86CC061570
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 05:17:46 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id bk22so6220978qkb.6
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 05:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5peOjlEi8Xo/UHQKoZ4/B5ESQqqlJ1g5QKzX4/4bHbs=;
        b=Vro+dpKEzed/teUV7t+z+AnLYPE5VfzzIWvUTcYwZtH0gCZR0yA5ly7odRizRxp7Sv
         QkFVVefp+ZVq0iZMLmwyDjLdl6n1aYM2/qHDbgK6zCYP/rmdo5fILZtSuwxK7eZNTHwR
         1fd1Tnaq+oiotAXSWcY2f7CS1Z46GNGE50inreJO/mT/n27ax2NShJjWQ2NA3wvth4ID
         Warkh6Uu3O1njWMySSao0b09h+1hwxWvQrQ1XYH9auhC5VPLVYGk9cR0MNmCrb0Xe9Pq
         lfCmFPw4JFvhbQ8SadbCp//yZ3P4kFzn4AhLzaE5YJ2MKjzT+3kc17x9gF/Es6QbQ7Es
         k4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5peOjlEi8Xo/UHQKoZ4/B5ESQqqlJ1g5QKzX4/4bHbs=;
        b=YM+ekPCG2RstYu5nUidvIVkU461SydSfF/C79jzEh+uZw9Z4zHfj1QP16xjlhzt2Ke
         KYQVPwsxdqn5RwsHuJbokSSh+A+opXxQpk9S2JRhdv33ptuKui/J5NLhCmEuwbuo5wcc
         bAAmMEQO5yFvOQ3b/CVlle5fPpftHaWaWkxL4q69zeT1Zn2D3O5MaczW/TaqUas88XFj
         DuIVu7vqtJtKbFYcY/QHjhr6U6g5xi9jOoi521ejeYGkWhGTUeYPSqrCt0GYkYMZxv1n
         /lMipnzPVTDcKCMydCNtohmJ9/G452rKm6U8fg6yqqW8/IhQZmT57bigPSnjUtCB3FaL
         tjQA==
X-Gm-Message-State: AOAM530shpxJs9tJKpThzJ7iuS9r5hjaunmtsipMW7Do68PtgzdRdkCZ
        rvlZNY6uRmX4nfUA4ERihmuflvsIaMwbQi9h5FqiJLzsItaR4A==
X-Google-Smtp-Source: ABdhPJy7dqWKSwjmNuDpb3CDFyb4Bn/rgYS6KQd/kuX1zRplfQJsdNEjC38k4VXCm9eQUKwoZKmqruHx3xkBJPQjC6A=
X-Received: by 2002:a05:620a:94d:: with SMTP id w13mr20981943qkw.419.1637241465675;
 Thu, 18 Nov 2021 05:17:45 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtYVGpvTHBwH6LErQqmEvOZFaKtR2xgFWNcbfTXUau2pQ@mail.gmail.com>
 <CAJZ5v0hCYE7_eHtnfA3Vn1PFS=Dqk5=dwdbaD_k+nusJucFaCQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hCYE7_eHtnfA3Vn1PFS=Dqk5=dwdbaD_k+nusJucFaCQ@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 18 Nov 2021 14:17:34 +0100
Message-ID: <CAA85sZuSGh9pQwvHio6NkNoahQjpjCxoPAhp3MOc-aGeWjDHXg@mail.gmail.com>
Subject: Re: HP Elitebook 840 G5 - acpi failure
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 18, 2021 at 2:09 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Nov 18, 2021 at 1:43 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> >
> > Hi,
> >
> > I started updating kernels to 5.14 a while ago and the laptop kept
> > deadlocking, it's my work laptop so it's quite locked down wrt bios
> > and bios updates....
> >
> > But, i have since tried with 5.15.2 and it still crashes...
> >
> > So the little testing i have is:
> > acpi=off -> works
> > acpi=ht -> *boom*
>
> This need not mean that ACPI is the source of the problem, though.
>
> > 5.13.x did work however and i know there was updates wrt to acpi in 5.14
> >
> > Older kernel oops can be found here:
> > https://photos.app.goo.gl/ZygV5Ja39C7cQCR39
>
> But the Oops is indeed related to ACPI.  It looks like the AML
> interpreter is crashing when trying to execute the _OFF method of a
> power resource.
>
> > I'd basically just want to know what kind of information can I provide
> > to help you to find and fix this issue?
>
> Would you be able to collect a trace with dynamic debug in
> drivers/acpi/power.c enabled, that is, add dyndbg="file power.c p+" to
> the kernel command line before booting and capture an oops then?

Done, it seems like it's crashing mid screen refresh or so though,
hope it's useful

https://photos.app.goo.gl/kzgDv8EV75sq6FYf7

I could also dump all the acpi data, if that helps
