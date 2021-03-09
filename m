Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39C0332C5E
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 17:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhCIQlh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 11:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhCIQlO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2021 11:41:14 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6384CC06174A;
        Tue,  9 Mar 2021 08:41:14 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n9so8182256pgi.7;
        Tue, 09 Mar 2021 08:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9w9armafDUBK5NoKB1+EVQ/HgT2OaGmEDCQKvuRthT8=;
        b=rT0PG1glqZMgjBbM/qJdxLPs1QVsSh/3fGOrD/fmUJtBDPMuhe/86Ox/1KWHNulI+/
         hqZ6DAWdpkj1qWmYSn3rcqQt5yplYv2EpFTO/wZW7VFAtodCObpWHnC/v9Y+jxy3P6ac
         XwLEMtvVOK1gLYl1Olr8E46SUx6akpZ7lxcI1sw+x9jy6xcahHmL43akGY++fbDCD3l6
         7yRU5Ow7tRuBkeNYeSuzImlZSGoaglMo4utU9fm51mSLiAjJVBS/MNfTkh07kBSeTmyJ
         abosnxrDsAsPx9X/KzDObd+92QtAOXYQ3Vsa8fAQEsWZr5zcmv5Yfdgr9yGWRE+a5o10
         VbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9w9armafDUBK5NoKB1+EVQ/HgT2OaGmEDCQKvuRthT8=;
        b=EbCyxtbUN5O4+8kWsnLRwR/EcqehR6O2JNTsH3O/D9JLdi51cUlxg/vXUB57c+y5HB
         Qg76n4vLG5fe7/gAkUywXUMPF1R2Jw2lOgdED6eqzs0A/c6lVS7PBlv0y5881CLRKEY2
         i/v5f+dsrbX8f5ektjXPw4SwIq38FhmU0Gl0+icIlcNwbqIhVKT521Jj6cGT14dVelmO
         Xd6JOsfn4TQof6bTQu13CP/sfQbQ8PIWZYm8JajbPYHMMtXZwNML1+Yzh6SzbBW330Es
         Y7X8gnABGA+xnBPBdZJwrIAZ5tkw4fe14ZoxkqSxrPOM/qNgw+qeS6MTuJBFrKxy94ci
         rUlQ==
X-Gm-Message-State: AOAM532Jkx8QPpYcP8++cU+xU5jNTeBHDbJZ23PlywVTZlQTnJqn2qnM
        Kvky3ntH9osJDDQvNpo8NzLehZEXYnIIUJu9Y/o=
X-Google-Smtp-Source: ABdhPJxhPfwcYUHrxmRw1vliEm20Q1K4Ft9kTiR2vaXYlaqx9DdfEwFv3exQSJuZNgADW1jYEN/dqjW3mKx1Etmie9Q=
X-Received: by 2002:a63:ce15:: with SMTP id y21mr26062604pgf.4.1615308073908;
 Tue, 09 Mar 2021 08:41:13 -0800 (PST)
MIME-Version: 1.0
References: <20210308194535.66394-1-andriy.shevchenko@linux.intel.com>
 <20210308194535.66394-2-andriy.shevchenko@linux.intel.com> <CACRpkdZO7TPcz6p8Gfavqd1SboCt7ZXwFa4+4TuWNTZuoXZqgg@mail.gmail.com>
In-Reply-To: <CACRpkdZO7TPcz6p8Gfavqd1SboCt7ZXwFa4+4TuWNTZuoXZqgg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 18:40:57 +0200
Message-ID: <CAHp75Vcjz7-QUYCAiss_WOb9vK_he8bFH51685wAhoo-=BYBEQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] irqdomain: Introduce irq_domain_create_simple() API
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 9, 2021 at 6:36 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Mar 8, 2021 at 8:45 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>
> > Linus Walleij pointed out that ird_domain_add_simple() gained
> > additional functionality and can't be anymore replaced with
> > a simple conditional. In preparation to upgrade GPIO library
> > to use fwnode, introduce irq_domain_create_simple() API which is
> > functional equivalent to the existing irq_domain_add_simple(),
> > but takes a pointer to the struct fwnode_handle as a parameter.
> >
> > While at it, amend documentation to mention irq_domain_create_*()
> > functions where it makes sense.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Marc Zyngier <maz@kernel.org>
>
> Excellent work Andy!

Thanks!

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> I suggest Bartosz just apply this with the rest to the GPIO tree.

Yes, that's the idea.

-- 
With Best Regards,
Andy Shevchenko
