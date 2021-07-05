Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD2F3BBA40
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jul 2021 11:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhGEJiV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jul 2021 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhGEJiU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jul 2021 05:38:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C852C061764;
        Mon,  5 Jul 2021 02:35:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t9so17765264pgn.4;
        Mon, 05 Jul 2021 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JI1vDcb79OBzxhgZoDMvIujAKof+eN/NLW1rPlw4pmM=;
        b=qBq5VDcWzljE05k5YhS7ihzKIetelFMZEICYqqHuCopzO24S7RQFjaS3oAAFkOMs3A
         ywRTsilTi0BTfrE+RRIqZl3SlRfLaMWtjDQkk/KgMTsAJQxeAIw7LHnhbq6pUcEptbh8
         xtq+TN1bw5YMZYJxbHRDcd4/P49A65xYUPj1Tm7F9g+8ngKjIXH5OID4BmKT4q2OSkns
         fC5yqG+13Ta8J+rpV9tw1apLeAkyUUnZC75xIVZsstqQeTvDXQPnEREpgiEg29z9x9a9
         UpAXxqoSg1BXwY6Rvr1oYn+vthf/Ge2hCSADmg+ynV2BQUZhsvsmDpJTs0qRSJzYSq/j
         Eo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JI1vDcb79OBzxhgZoDMvIujAKof+eN/NLW1rPlw4pmM=;
        b=Oa/CcvKy26dOdn05k3I3ggRnOXKKG92sCAEjRy1eNfQ61EGuuLuaRejf0jSmBf6aPb
         icKkM0riN1hv1W4TZalaXkf1kau0qnqP9Islqp7qRmwVEfQFXkZ1qNsojHxTvKQk3tcS
         uJW4/Brg5c/De9sSELAKRIl5ddr6PBFLnaBnns7iQrdy11gvQvbkrNXhM3Yd/hcDy2Lv
         a7FkbN8Epnphiy362NTUyyrqcaKh9QoxTQpLL65f3aayBIUKkfmHOU2i10eJEMGrvaUw
         DYrRC/rGNCipZM5PzBT9LRUOgwpZvauEdSnF05DuU6xrZc9lEQPUoO2hSuNMVZNF5qdL
         J/zA==
X-Gm-Message-State: AOAM5337QAQS9Xl2/9KZamYxiZC0iiJV6Py8PLKnxf8LEb1NAgKZ9oRL
        LjnbNFM7KOcRd/Gv4VrIaTprqYSn/sdgRcUlFV8=
X-Google-Smtp-Source: ABdhPJyxSFNMH1XXOAngvZUVssVrQV2HOw4JGtauaWMmo0k/1k/NlZnzEhTKKvKco6DaIkLMvc6iPeUFwvN6zKOt7KU=
X-Received: by 2002:a05:6a00:158b:b029:319:c68a:8006 with SMTP id
 u11-20020a056a00158bb0290319c68a8006mr11814039pfk.7.1625477742554; Mon, 05
 Jul 2021 02:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <YL43SrZ8N8H+ZHE9@black.fi.intel.com> <YMdw6WdEQdGATBNJ@smile.fi.intel.com>
 <CAMRc=MfphPFqCaBRG6jLUFUwOB3_HTA73WXoCBg5S9GagTDeaw@mail.gmail.com>
 <75eae548-fd62-1be6-498d-9664d9c7deab@redhat.com> <cb18b7d2-8636-feed-e9f8-212ce7aa7eff@redhat.com>
In-Reply-To: <cb18b7d2-8636-feed-e9f8-212ce7aa7eff@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Jul 2021 12:35:04 +0300
Message-ID: <CAHp75Vf+umxDfpZ3_V3PjhsYVnQNQ2D8rvmOf0ko9Z7HmRhNiQ@mail.gmail.com>
Subject: Re: [GIT PULL] intel-gpio for 5.14-1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux GPIO <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 5, 2021 at 12:20 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 7/5/21 11:16 AM, Hans de Goede wrote:

...

> I just noticed that this email is part of the same thread as the
> pull-req which I merged, IOW it is the same pull-req as which ended
> up in your spam folder.
>
> So yes I believe that I took the entire thing.

Yes, that is correct.
Thank you!

-- 
With Best Regards,
Andy Shevchenko
