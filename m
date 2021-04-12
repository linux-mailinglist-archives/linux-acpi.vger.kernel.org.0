Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9E535CFCD
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Apr 2021 19:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbhDLRvE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 13:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbhDLRvD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Apr 2021 13:51:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B05C061574;
        Mon, 12 Apr 2021 10:50:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u7so4971990plr.6;
        Mon, 12 Apr 2021 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwbL4QRbaiGgEYe9k+zFEy0jCzquekkCtISTZ5hdDOk=;
        b=j8umMGjAxiKoTM1jGIYYc0gyXOgiKu4CYpr1wk1DcgtdPIZyquXBG0U5EFwdvSWq0b
         8U6WTc8V60qYjr04uCntTJ4IWG78i0EAyvmD/ZWu5Rp3balhYYqEOW6106KfJR25ub1J
         q0pCLszIlRERr+s4MCFkXNCYWHaMjQdloStUeCo8YvRWFz5QfczsbPC9/NkJNizjnKY3
         JmtaRP1qBzIeZKx1u6CE6U/qWcZlhKSBEiogguv5jbF5qUNxHGlzon9u3HE7a3oSrgUH
         pwb++LXl2n1uer6QVhLCDHdSrchS/KFSXu6UnSx/YwI79po3ihueIXPkvriYeu0WgLv6
         TaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwbL4QRbaiGgEYe9k+zFEy0jCzquekkCtISTZ5hdDOk=;
        b=UrXFrxCYuvYFD+wXrRRCPaVErAB/rDWmeWnn9unY20Xo96ByyBtzJIEijt3kBhwAqK
         FLxUy2vsa16Sr7hYfET8wr9xJaBFKQ+yV0vMa1CPFGuLT5mc1S3uJEsk2e//WNtzMBmR
         +c9PzgIkZ9DdoT/8zQCx2Skb1Qz4j9ETaxgtSVO5in46l2YbJJ2H8yz+NkvlHFWCVnfj
         k9if6hGxvABv+6GcARNvgK6pwILpdBBKX7INWCStTXTMcn1di6/dd2/0x3p2zNNjV3Aq
         WPnbh5l5pEavTovZxMPh2F99JgmsxsJSxZxCQrGaz+JWdaX59CYZQOCiR1gxRIHJ/9JR
         vCBA==
X-Gm-Message-State: AOAM531bAcop2BdekNeJ5ouwmTiI8R8hwIKn3SWnv2BseT+/t+zMZgeP
        9OYrXNVwz7QMUFjtUj7V22CGQ/ZqcnCmUaQpeFekxGTJrn0oWg==
X-Google-Smtp-Source: ABdhPJx5QFQezry52L9uci0iZ8P+FSLGeRciIi6In8JMFZOPWAFdCf4ug6Fih6aajEZ6zmM0S3RxpYy0MPNjfVqDTgA=
X-Received: by 2002:a17:90a:156:: with SMTP id z22mr338036pje.181.1618249845121;
 Mon, 12 Apr 2021 10:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210410131304.1858623-1-andy.shevchenko@gmail.com> <CAJZ5v0jJoWnnx7ce82trnzsnBTMEDf1oXwFBDc0RUj-=p7hjLQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jJoWnnx7ce82trnzsnBTMEDf1oXwFBDc0RUj-=p7hjLQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Apr 2021 20:50:28 +0300
Message-ID: <CAHp75Vc3e4FcqKMn3YGGK+sNXLi5UqUL75_GcF-27hyn+iZp9Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: utils: Document for_each_acpi_dev_match() macro
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Daniel Scally <djrscally@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 12, 2021 at 8:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Apr 10, 2021 at 3:29 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > The macro requires to call acpi_dev_put() on each iteration.
> > Due to this it doesn't tolerate sudden disappearence of the devices.

And should be "disappearance" :-)

> >
> > Document all these nuances to prevent users blindly call it without
> > understanding the possible issues.
> >
> > While at it, add the note to the acpi_dev_get_next_match_dev() and
> > advertise acpi_dev_put() instead of put_device() in the whole family
> > of the helper functions.

Thanks for reviewing this, I'll address all in v2.

-- 
With Best Regards,
Andy Shevchenko
