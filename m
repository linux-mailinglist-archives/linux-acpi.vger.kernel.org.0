Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE193BB9C9
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jul 2021 11:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhGEJGQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jul 2021 05:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhGEJGQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jul 2021 05:06:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915DEC061760
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jul 2021 02:03:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k17so5049935edq.2
        for <linux-acpi@vger.kernel.org>; Mon, 05 Jul 2021 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4IBVSwu5GomtKJRSCgsvXFvZd61ehj48dOdrbBGoQkI=;
        b=Iw5UyVuiT7T2SjC4qNDSYnI2kvyQmEgiMDvaIdmuIuqETt1QQCvJA5r5rxTfpJe1GH
         1lK8SJKtFd7YyWAtkd1dEAyNAFXAxzLdld41BB1cS86zdvOGAHLf6vKd/BPnEmGD7RN1
         VtgaOmY6t3uC7HeKGgj5QHAV2Kc9sPZi0M37HzU9u5wBMDxrpRvTZqwQQB2YMK9qGkN/
         Q7+Yopjedy+ZecY784XOCGp1hTeAT2tITcjMEStG4HLtHr0YV+gmKa0tOE5VJLT08LLk
         Itb2EnnzJcMDVwrJ19moKF/SzTzxeUZeT7OBojPRl9+qxP16o9xEsKV9USwrKm8SvXH5
         MmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IBVSwu5GomtKJRSCgsvXFvZd61ehj48dOdrbBGoQkI=;
        b=MGYXljmHaSA7ogu+aWqgwyHeCC/4QLIVDTDAVEbKtTlY2b+P+T8k75VA82Ytv+tfAU
         g+UTagDdpOuSFcwEb5BMyJ0CLnO4iYRNCKKkrBbxLXU1d2/txmh3aqIxuyf+F0oXfi4S
         bgDpv/mQZpS5n3KiNT018vAal0kORIGe+hIz4T+osEwaOeAUX/YOagGswBcTbVCTKh50
         rS7SV2wlQNgDQ1RMPXLN5zEQ7yU4h+WwSqW9RDl/e2uJAwudOmZUg12vqPkfZwOygFh6
         5i3CL6b3o68/qsY3aQrfN+MoOh1bUBN9eHC/5HuAgQXxYH5arYohMPv7k7e7jBggGNZz
         p2qg==
X-Gm-Message-State: AOAM530yG2HqJCmq7LQzrXE5TGx/mylYSXmoSuXGhqyHCprgvEdDjR6p
        a5wG0Zah0LqB3aU6ugTITIcEz1rrw4bqMhNrsfKLCw==
X-Google-Smtp-Source: ABdhPJzI4o7DR7HHYlcIPJSNkB3+ccsaO+zAIBEfCuedleNNnkuXHg5/ZOBvalxkeIrnb/TgJCGHyTDQdp8E53c5Ccg=
X-Received: by 2002:aa7:cf93:: with SMTP id z19mr12462002edx.214.1625475817209;
 Mon, 05 Jul 2021 02:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <YL43SrZ8N8H+ZHE9@black.fi.intel.com> <YMdw6WdEQdGATBNJ@smile.fi.intel.com>
In-Reply-To: <YMdw6WdEQdGATBNJ@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 5 Jul 2021 11:03:26 +0200
Message-ID: <CAMRc=MfphPFqCaBRG6jLUFUwOB3_HTA73WXoCBg5S9GagTDeaw@mail.gmail.com>
Subject: Re: [GIT PULL] intel-gpio for 5.14-1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Linux GPIO <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 14, 2021 at 5:09 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jun 07, 2021 at 06:12:10PM +0300, Andy Shevchenko wrote:
> > Hi Linux GPIO and TWIMC maintainers,
> >
> > This is GPIO material for v5.14 cycle. It contains some stuff that other
> > subsystems may take due to dependencies. Consider this tag immutable.
>
> Bart, any comments on this? Can you, please, pull?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Hi Andy,

I was looking for you PR for this cycle and couldn't find it in my
inbox. Somehow this went into spam. I'll make sure your email never
goes to spam again. Sorry. I'm seeing Hand pulled it, is that right?

Hans: did you take the entire thing?

Bart
