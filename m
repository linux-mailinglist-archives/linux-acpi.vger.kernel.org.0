Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88750196047
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 22:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgC0VOP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 17:14:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40828 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgC0VOO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2020 17:14:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so9039410lfe.7
        for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2020 14:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XaIaaULbP3McQWHg8W+/o/1CYRBruKdNlh+486HcGCM=;
        b=qX+gRLGFRJd3ElguqkNQqQ1OshtdqoG0XuATUd/h5tKBo00u2f17T9Fniq6VztFhqv
         saK8XXwTdBDTw9Cai55RTVxGBbsQ1YaMMD9pR6C+3d7CQxZVvXty2cMgo7goryl4exdy
         gCWeipbiUZ22ewiuX1E80s2NFUlT7pLNwPPCqaD4QTD4q+PVBOUkJ99HRl440D6LiGfm
         MbX1iGfpZc4Xownq6lyJp6r7CNz7TxynKrN5ZMzW2BzMcDVIfKFPHpNX/lzeNO+SCP9N
         OIPVSonZ873YmQ+LfN+slXRRpdBgCd6YKyChvDWPgHWNFugDmv1vf8PSrtyLLtrgYPCc
         UnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XaIaaULbP3McQWHg8W+/o/1CYRBruKdNlh+486HcGCM=;
        b=LHvE4NY2Ge9h/hcxTxGBp7Q+qz/LGzV9ywXa+3+m7BTJQBA46XPq8HBK7MMN/dZuls
         scZjYQlvSjfOYsnEDZ4aiwACXaJfrjRc92Ka39WFFoi1yT2RUG3asdSNgRazRPacqiaQ
         AAWIU9q8lk53HxoHDRjbJKA6/5NbXIEM1YixI3MFYkZHaH+pJMe2An5AJbMOf6KLbifH
         r5fNO703B/ZZ6tBmAV+75f0sRES0zQ2FwIMGHWDZ0AndwPIrRTB3qFJSX7GCGHl1QG2+
         1PPdWddfKOJhl2lF1WQGP0/s2Vh++Sfg3Iu/TZwUgkT98rgzsFLjYp3XXAZAA/3PC1mZ
         wiIw==
X-Gm-Message-State: AGi0PuYYatfOIebCVZvE6wKcMyqf+uEuMUjp/no6jhHulwEFmFKB9PXe
        fI2FrbblNOwuUHaxZjVa1CEFkJ1CO3/Rxdoz5YxlSg==
X-Google-Smtp-Source: APiQypInNZ8StO0YG491G0Qh82LO28Kdxjyb+vEZxtIJy87j+WsFkKeAnw2pshXxgw6Ns3g/B8D5t4FRjpOdDRr5uuU=
X-Received: by 2002:a05:6512:6c4:: with SMTP id u4mr757685lff.89.1585343650678;
 Fri, 27 Mar 2020 14:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200325103956.109284-1-hdegoede@redhat.com>
In-Reply-To: <20200325103956.109284-1-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Mar 2020 22:13:59 +0100
Message-ID: <CACRpkdavyR7FRGMZFHZUvRhm9PL-X4SQQszN4HQn-+qpAhJnHw@mail.gmail.com>
Subject: Re: [PATCH 0/1 resend] gpiolib: acpi: Add missing __init(const)
 markers to initcall-s
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 25, 2020 at 11:40 AM Hans de Goede <hdegoede@redhat.com> wrote:

> I know it has not been that long ago since I send this out, but still
> I have the feeling this one seems to have fallen through the cracks?
>
> It has already been Acked by Mika, so if you can queue it up in
> linux-gpio/for-next that would be great.

It requires the fixes I just sent to Torvalds to be applied first.
I simply need that stuff to be upstream before I can apply this.
That is why it is deferred.

Sometimes it happens that random fixes are dependent on
critical fixes, then the critical fixes need to land upstream before
the random fix can be applied, this is one of those cases.

Yours,
Linus Walleij
