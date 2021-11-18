Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29AB455C59
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 14:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhKRNMn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 08:12:43 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:45982 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhKRNMn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 08:12:43 -0500
Received: by mail-ot1-f46.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso10782468otf.12
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 05:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joVx7JP5RgW3mMLGhFsuJikuUO383MxtLdRWo/gTHCM=;
        b=xMaVndr5EYMIuw92UmjWopW0M6S0oeFeFXdYChNVXeXkX5KVA4yzW2Ar1M/gE/JIqR
         q+PyHQJxGqLKEaXWCaqUNZ9hJytO0tsIIIOlEZqW/uUheMTHYeDZrACkZYdvhwcnLi9q
         007N3c2z5Zkia+CVhepXcO0bYQ6jds6bHfAjZ4KB6eLXuRN9Pq1Q37ph++9iXQOKP8Co
         sitbLWRgfwnyih44nfB+xEyuOwDo2us/iejapoZHnXEFbsaQ/ChlZMi2fVV+9m+5NhN+
         KI7vqLQdpXz38ZbFIaGRidgRCrdnohD1ifrxRdBTKlacWIYToBfHfq4O69MuWQi2iKl2
         h7ng==
X-Gm-Message-State: AOAM53268kBSDIM593CQGCitBKv4eJuy67rpduc93NemF+sCWMCCqceq
        q7Q13Y2Ob6nJnQ882D8PL/kX6kULLFq+foxzKWI=
X-Google-Smtp-Source: ABdhPJwjYdB2OT8x+spOJeFfo2NwB3q8I/nTdKtFZ24oQ/1KFWe6KKZGUEu4W/PcELvGZY9W025fbTfBXbettetPGGk=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr21085509otu.254.1637240983095;
 Thu, 18 Nov 2021 05:09:43 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtYVGpvTHBwH6LErQqmEvOZFaKtR2xgFWNcbfTXUau2pQ@mail.gmail.com>
In-Reply-To: <CAA85sZtYVGpvTHBwH6LErQqmEvOZFaKtR2xgFWNcbfTXUau2pQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Nov 2021 14:09:32 +0100
Message-ID: <CAJZ5v0hCYE7_eHtnfA3Vn1PFS=Dqk5=dwdbaD_k+nusJucFaCQ@mail.gmail.com>
Subject: Re: HP Elitebook 840 G5 - acpi failure
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 18, 2021 at 1:43 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> Hi,
>
> I started updating kernels to 5.14 a while ago and the laptop kept
> deadlocking, it's my work laptop so it's quite locked down wrt bios
> and bios updates....
>
> But, i have since tried with 5.15.2 and it still crashes...
>
> So the little testing i have is:
> acpi=off -> works
> acpi=ht -> *boom*

This need not mean that ACPI is the source of the problem, though.

> 5.13.x did work however and i know there was updates wrt to acpi in 5.14
>
> Older kernel oops can be found here:
> https://photos.app.goo.gl/ZygV5Ja39C7cQCR39

But the Oops is indeed related to ACPI.  It looks like the AML
interpreter is crashing when trying to execute the _OFF method of a
power resource.

> I'd basically just want to know what kind of information can I provide
> to help you to find and fix this issue?

Would you be able to collect a trace with dynamic debug in
drivers/acpi/power.c enabled, that is, add dyndbg="file power.c p+" to
the kernel command line before booting and capture an oops then?
