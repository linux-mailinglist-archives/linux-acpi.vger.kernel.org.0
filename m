Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F9E430B98
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Oct 2021 20:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbhJQS43 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Oct 2021 14:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhJQS42 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Oct 2021 14:56:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F4AC06161C;
        Sun, 17 Oct 2021 11:54:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y12so63335512eda.4;
        Sun, 17 Oct 2021 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+zh36+Rf8LA5j9GE3yib+BELqUEujVmIps2lBIxNDQ=;
        b=cLsk47RhHJ5smIpH5tDGZywPoY25oLnvU3zzdLWeyoIFXGwbrg3FHfqV9DVfFOhiGv
         tckUyDMQaTpX1Xtdg18CwukPSmiLAvkI0v5yPv/296TJomoirslFKU+FhOQ8OdTVsd90
         dYHMb9nfb2+qSLKbgxSL/mNbSeoBQoRqPAWQZ+M/hsMKOUWV6UTtnX5JpJb5b4EuGnhx
         9SP2qmraRtutpoKTc5PTl1aH8k/LLKq2sMBJCyh3bCGacE0mr/za2+99Yhqrmj1QjSsg
         eqtHJ2B6JnNeAcKaY3Auo+PQ7zyUtJY8CQ6ZVtKVOQAsYHl5QgqAASJw3A4rje1839ti
         MCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+zh36+Rf8LA5j9GE3yib+BELqUEujVmIps2lBIxNDQ=;
        b=jP82JNE7zU9Qxb4dFGlia7aJmZfNvZSflpHHyYAldwtxtDTGvwhuNMoOgWC+8ur8LX
         ljPLsUgNQ2K3qKc6Yi6d8pEnX4YRuKP7btXBuPzgcJViNqFEVXJ7r6AkwesgWabDpWjd
         pqiu8PVFpUF1JWFHPwCq6GbQttUB6d7Tdy8546oENM6jpCo9Tx/HP//Xi+CgQOzAdzwz
         SQkHiQ0bNRk22vdhcg/QdGqlI/CwlZc0gPYdaciQfQe7PvKJ6x4mw5nAnC61k8DB02ak
         XFJS8St+z5iUTs9H5wlaC3zdmJO59ibjuVuM/SRtaNkGJPi2CoeK2t+dhnkzn1S4dEfh
         JEag==
X-Gm-Message-State: AOAM532jtm3qi5Ad8mPoO4c5LdUKH29MRaUqH6U1R149VvyVdwJ8NhUl
        IFtrcHoo74vdV+1OmgqtHIZptx4ro4xS/VLHHr0=
X-Google-Smtp-Source: ABdhPJxNZ7z3tWSBcsqNYxk3UDyHhnqXZ14WC99ED+wHCbTZ/G70duLkvnW+MBNY8JYeSY0rG190QAXredmfi+hT1qw=
X-Received: by 2002:a50:d987:: with SMTP id w7mr37622877edj.240.1634496857232;
 Sun, 17 Oct 2021 11:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211017161523.43801-1-kitakar@gmail.com>
In-Reply-To: <20211017161523.43801-1-kitakar@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 17 Oct 2021 21:53:41 +0300
Message-ID: <CAHp75Vd8KFCZ0kDSuhbqxGBu66KhcGO9zHPshncB7vZzsHnNDg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] add ccove PMIC i2c address for Microsoft Surface 3
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Oct 17, 2021 at 7:16 PM Tsuchiya Yuto <kitakar@gmail.com> wrote:
>
> Hi all,
>
> Firstly, I'm still not used to Linux patch sending flow. Sorry in advance
> if there is some weirdness :-) but I did my best.
>
> I need to use the function intel_soc_pmic_exec_mipi_pmic_seq_element()
> with atomisp Image Signal Processing driver on Microsoft Surface 3
> (Cherry Trail).
>
> However, it currently fails with the message I added to the commit
> message below. I wondered why. The driver intel_pmic_chtcrc does define
> the i2c address.
>
> It later turned out that the intel_pmic_bytcrc driver is used on surface3
> instead, where the i2c address is not defined. So, I added the address
> with the patch I'm sending as RFC in this mail. It's working well.
>
> The question is that, should Surface 3 (Cherry Trail) really use the
> intel_pmic_bytcrc driver?

I believe Cherry Trail should use the chtcrc driver.

-- 
With Best Regards,
Andy Shevchenko
