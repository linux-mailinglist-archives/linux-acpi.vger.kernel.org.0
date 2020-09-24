Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43525277567
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 17:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgIXPc5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 11:32:57 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43938 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgIXPcs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2020 11:32:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id i17so4040073oig.10;
        Thu, 24 Sep 2020 08:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P23WTnX7J0orLd7NlQt3f+ZbjZvXRzDMrC3Fd2GLoKk=;
        b=N0Nza/BdN+bC4mKtKWFclWrKkk+/rR8UFurT4LWWzuv8iORHC5TfAN8EVijj3IDlAb
         Ii0I/6HlzqkpI+RkyaDuzCcstRO4jBnhIgkIe4f/lJKtKhzJlKmvqfIOirgf2Jfn9W6h
         hjfVTq9CsmO5r+9xZMnWZ9dnjNFz4NZrLNHADQ7xrvLTSzw4nT98Muj2mEDCtQ0PIud6
         6xFsXRzu2PYGZzmQ17vouVTIklR75hKuIg/AL7PttKen7RbMFvEUV8ecoTGuqagv4lQ0
         /f6Ok/CvEPsV+fqKNnPUf9UsuuXnNY189TrPEPpprNiykW3bcOV0hORr1Na8wHJp6J3s
         uRGw==
X-Gm-Message-State: AOAM532HCJeB9iBqWD7ppcsAsEil8w6ywKL7Eu4+UgR089l87WafrHyu
        O4s2zjYVQ7OMuM7u3k2eE9DwBdIQ1J4Lt1i3B5s=
X-Google-Smtp-Source: ABdhPJzMLCBbJ0WFPI7Z3JLQmUU26VA+GnT7EPMgPhi4RFKQSQG3Sr5op/Tenf0QRSiGD2MHjOa0UKJgNLH+/EKRQ04=
X-Received: by 2002:aca:df84:: with SMTP id w126mr2906529oig.103.1600961567060;
 Thu, 24 Sep 2020 08:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <9e2c6cccabc96fe1e5304e2fa2dfdad28ca5ac9c.1600816121.git.skhan@linuxfoundation.org>
 <CAJZ5v0iS2wpvvJGLsEJSSdCJ0tf4DmJ9fQWVU3PzFuMB7Zbkjw@mail.gmail.com> <3cc1e840-6525-e125-499a-03b9c86c0243@linuxfoundation.org>
In-Reply-To: <3cc1e840-6525-e125-499a-03b9c86c0243@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Sep 2020 17:32:36 +0200
Message-ID: <CAJZ5v0h7QhLRs6hb1ges2bsFyvRPL1b4dSm=YM4J631agowkiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 05/11] drivers/acpi: convert seqno counter_atomic
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 24, 2020 at 5:08 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 9/24/20 5:13 AM, Rafael J. Wysocki wrote:
> > On Wed, Sep 23, 2020 at 3:44 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>
> >> counter_atomic is introduced to be used when a variable is used as
> >> a simple counter and doesn't guard object lifetimes. This clearly
> >> differentiates atomic_t usages that guard object lifetimes.
> >>
> >> counter_atomic variables will wrap around to 0 when it overflows and
> >> should not be used to guard resource lifetimes, device usage and
> >> open counts that control state changes, and pm states.
> >>
> >> seqno is a sequence number counter for logging. This counter gets
> >> incremented. Unsure if there is a chance of this overflowing. It
> >> doesn't look like overflowing causes any problems since it is used
> >> to tag the log messages and nothing more.
> >>
> >> Convert it to use counter_atomic.
> >>
> >> This conversion doesn't change the oveflow wrap around behavior.
>
> I see typo here. Will fix it.
>
> >>
> >> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> >
> > Both this change and the next patch are fine by me.
> >
>
> Thanks Rafael. Okay to add your Acked-by?

Sure.

Thanks!
