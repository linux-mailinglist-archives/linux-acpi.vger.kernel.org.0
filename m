Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169875E01A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 10:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfGCIow (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 04:44:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32863 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfGCIov (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 04:44:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id y17so1190784lfe.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jul 2019 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3liKSolgNOTE0GO6IdqkLmeCAukfMd1RtJ82seDneCg=;
        b=TmUaRfQcHU6KZT/cQUt6QOxeQIOmubJNjMDOl7pLw+/8d0f81LQdh16APBrRJD1ll8
         3KrYOintkQSt0/NllvbDH3Rgv1zD9W4R3xpsuAmYrRvdHqEIyys0WFSEGAeGt1XPt9Xq
         O10SRFgV4U3cyP+1an1xbtinGQAcwi8x0rF+HQGukVdUw7vXh4lgY3tTB6Nb1FJJu7Dp
         RWi9aI+fTsmz+Ix/vo5gxCWIlpvoWPfBYIHRIhQcggpQxKJQL23xSe/OQ3RccWFEzOWP
         R67JQTELtNjHwZiE4RRJpC1ZMay7TqxCankYT6ZwbfotxHeA4ii+oOG5IiCejkyBbzr4
         Ki6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3liKSolgNOTE0GO6IdqkLmeCAukfMd1RtJ82seDneCg=;
        b=Nhm9Ym/BcIF8fwSk8UHLKfNmrujp3eAuxFBNVqBd4hWV5FWNIZHLTqgjbvQNEp+MJO
         PeTh/6LRSQdZC96jygUohb9lYV+s1+nz92RGzi8NTALEaTrU8eQGKkGa1AFsYYvT0kyB
         9wf8oXhgssFsgUDURmnwNNbVP+DJ7LCAc3cH28gQX3QlFwVtWw/w0JS5nrQ03BX2lrfg
         KWsQVa5u74DrxDMsb1U86wLJ9D2AC7LICZRk7JQpcVZDdl/9DZbH4U0XshlM4nZzWL+/
         Xn80XsCN/GoTgHVzGSAW3aeGKS4vY3mWlHzj7A+39G8SSXrfmNCK7WEkwuER147e87+j
         +5WA==
X-Gm-Message-State: APjAAAXXfghgcN0PnjNWx9TTb20wHfTxhFqCfmpZN/4L8t2CU4LOA8rU
        j9rEguV9illC7CtD1MglEcVrwNpJnaRdTGzz/yimqg==
X-Google-Smtp-Source: APXvYqxWRQ/VeThlBgH3MQ4LJT9QQxmtwYkQ5a+vzEcAovmaaXojX+Uogeaf6aYaQIvSxuRtNJKs/sN3ZEYWfOppjeA=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr2537391lfu.141.1562143489851;
 Wed, 03 Jul 2019 01:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561724493.git.mchehab+samsung@kernel.org> <1ecff14ec37c0c434f003d93c4b86b1cd3dac834.1561724493.git.mchehab+samsung@kernel.org>
In-Reply-To: <1ecff14ec37c0c434f003d93c4b86b1cd3dac834.1561724493.git.mchehab+samsung@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Jul 2019 10:44:38 +0200
Message-ID: <CACRpkdbBA612W0x6Y-dwe3E4dhH2ospmn+m2YJ8Sh_Um6XGYhA@mail.gmail.com>
Subject: Re: [PATCH 39/39] docs: gpio: add sysfs interface to the admin-guide
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 28, 2019 at 2:30 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:

> While this is stated as obsoleted, the sysfs interface described
> there is still valid, and belongs to the admin-guide.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

This doesn't apply to my tree because of dependencies in the
index so I guess it's best if you merge it:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
