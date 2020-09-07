Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5663025F72F
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 12:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgIGKDH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 06:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgIGKDF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2020 06:03:05 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3B0C061755
        for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2020 03:03:04 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n13so12170223edo.10
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2020 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eu0tVdC2SapQmxPGnrOiQAZ5HG6pSAsS9H4UlH7DET8=;
        b=ugGVMJW5RJbLvOkkPTzMtesjDjGP+0VKjWNbvyeyw2RAMXE6OInFtbSWjFRmI2mEZS
         Qsd8ZTpoPGy21huaFxq7lp3WRwdQ2JfnmeqB9iOMeg5qjFXrc5D3naTXSyS3YuGEFwBm
         oRbHf7veaLO0JOYUz/DRU9qgAEXENey2/qrOyy7qen1h8LeM1btTG83H6yE/8QPWql7s
         PzxcpQ97iEe6gy1nn1Kp/keE93njE+5j0WNLrCc2AomoVHBqeHFuwlm8+z6haucaxF0Z
         72HZWjDalObdCuk9FIuI/j7BVINn0EVKCXAj8MCKTFXVU4ebqr3a2n1HRESpqbxbLXcv
         oUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eu0tVdC2SapQmxPGnrOiQAZ5HG6pSAsS9H4UlH7DET8=;
        b=NX3gbWIEAGm9VdMDF8FH5ti+t4b4GsPyZqVkGEnQR7trN0/XCnY6fSxwV9ynGAcqvN
         EDvzVd2HlyclfI5WUCY4UvMQK+v3PXI1s0ZtQa7UkcsCuH1/1qR2n1+LpypQ2jrkLtHH
         XH7tPdSRTVXKUbs+T4uE8XOhgLc55bRRpATY0O/hWcBdioQexWI92jaK1U7LfGIjw2Ny
         IX99zt/D4E3XFfBnUWp6StvPI5uKRU0DaiTdekt561bQZER47JQ7ylyQ8nfKWofxrcU2
         7zF+4VTtObPtK4hOq8nzQMp/g+LcCg4CNUHNNdbbo1soL3FuZi7R/7Uad/CKFqPXZy8Z
         fBtw==
X-Gm-Message-State: AOAM5322xfqa3EnU5/kE3m7hsmVjdogiQ7mtT1kgRqN5+ZLqyS9yohYh
        mTZUmxkJyKs/8z+YdTQuobfXNn5eJoolPUo5GZfpzQ==
X-Google-Smtp-Source: ABdhPJyHe8iRM84KrK6dTuGNdpxVVoq6lwssCgqCJnFgT/lL4ex/fl0tLxkqjF/9CuLd6Vxm+bMEsR7nsnt/D2ZfdeU=
X-Received: by 2002:a50:d809:: with SMTP id o9mr20387639edj.12.1599472983149;
 Mon, 07 Sep 2020 03:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-4-brgl@bgdev.pl>
 <20200904163517.GW1891694@smile.fi.intel.com>
In-Reply-To: <20200904163517.GW1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Sep 2020 12:02:52 +0200
Message-ID: <CAMpxmJWQsgV5WZrdPW3UUOVTEy1L6Y_rb7ThQK1QTRinmHSqWA@mail.gmail.com>
Subject: Re: [PATCH 03/23] lib: uaccess: provide getline_from_user()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 4, 2020 at 6:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2020 at 05:45:27PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Provide a uaccess helper that allows callers to copy a single line from
> > user memory. This is useful for debugfs write callbacks.
>
> Doesn't mm/util.c provides us something like this?
> strndup_user()?
>

Yes, there's both strndup_user() as well as strncpy_from_user(). The
problem is that they rely on the strings being NULL-terminated. This
is not guaranteed for debugfs file_operations write callbacks. We need
some helper that takes the minimum of bytes provided by userspace and
the buffer size and figure out how many bytes to actually copy IMO.

Bart
