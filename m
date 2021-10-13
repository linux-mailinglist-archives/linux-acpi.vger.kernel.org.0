Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0427942C77F
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 19:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhJMRYA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Oct 2021 13:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhJMRYA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Oct 2021 13:24:00 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC52CC061570
        for <linux-acpi@vger.kernel.org>; Wed, 13 Oct 2021 10:21:56 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v195so8332407ybb.0
        for <linux-acpi@vger.kernel.org>; Wed, 13 Oct 2021 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yf2lvnswxZG12HrbiFNmFCi5hHNaSndx6XO9Nz3lj8c=;
        b=V7nr+D7wCnJEBfynTZO0PhEqS6UapnKxJOJkguZY+vMmdaQ17lCEEmzCLFyxylxuyz
         a20RweKYaPoaYuA1MMvZCOznohi1jI7zxG05ktw5kneqReGiFYT+e+yPHqWgjiT1o/qO
         FRnLV+4XByB9YvRGvdjH2kuvJmcQpkcjXJR23BApUtB1KwqTIq4ANjMn3j4viFgdhNk7
         Qsg6YxK3Bh2bx1T+lY8uhMoHhBr3K6XnHxjuTj6dimgkh+mDa3PPrunhZtNpP4iiM6e2
         F668m0e0rC9v/2s4rulsoEJOa2XeS39UdYrilj15pL3DFtRi+2wuCZ0/85QNsmcfQKpe
         apcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yf2lvnswxZG12HrbiFNmFCi5hHNaSndx6XO9Nz3lj8c=;
        b=kLMaurabXfn8T2Fbe6cOOvzSsWp9tjZuWlhWzcJHI5dPOzrZFFZFL3k6v+mtwYYWgZ
         s5hG6xVRPh2j77mLBALDiEl8eEUGOFe6wk7el1cx/ggib95H+FI4qyigVOC46aCXHemA
         HgDvGQTV8Q5Q/TqpE8N+um0H+zY9moRVGgzoI0e9QHegACfCd2/KB3AP01etiL960Hhw
         JaHIO116b7nBlkRkmlbjXzHryaRc+VJnYg30+/G4jDc5Og20Mo1KZS3Pjcf53pxJPZ3I
         mk4OVjQ7YreVAr07D98un5LjjKeYGOWTe0i1fjdp3PW5geqfEf2vRoQEfpEkFeFjVyXb
         XNtA==
X-Gm-Message-State: AOAM5313YECOG3yIeOvtXy2jys3er35ppiQ+XAxcTKVAEt1IoayXNwnq
        O3LwX/lsu5OjVUtCDejJfl4rNxDNR+ck/Rbw09QoQA==
X-Google-Smtp-Source: ABdhPJwnnMUc+Wua5vM0/raYMLpof8dp6c0NLJvcYQJ3SrpJn+DquLRh0Sa9lrkrSBiQf7zwIZQ3o77FRAQ2JAVDhOg=
X-Received: by 2002:a5b:783:: with SMTP id b3mr704817ybq.328.1634145715727;
 Wed, 13 Oct 2021 10:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211013143707.80222-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211013143707.80222-1-andriy.shevchenko@linux.intel.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 13 Oct 2021 10:21:19 -0700
Message-ID: <CAGETcx_mNWumqmYzytvKG+FvPLA=DWokbbtFv=EGet41G6cQeQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Add missed header in fwnode.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 13, 2021 at 7:37 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When adding some stuff to the header file we must not rely on
> implicit dependencies that are happen by luck or bugs in other
> headers. Hence fwnode.h needs to use bits.h directly.
>
> Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana

> ---
>  include/linux/fwnode.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 9f4ad719bfe3..3a532ba66f6c 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -11,6 +11,7 @@
>
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/bits.h>
>  #include <linux/err.h>
>
>  struct fwnode_operations;
> --
> 2.33.0
>
