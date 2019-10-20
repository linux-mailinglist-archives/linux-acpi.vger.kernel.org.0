Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6731BDE13C
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2019 01:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfJTXfJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 20 Oct 2019 19:35:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34296 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfJTXfJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Oct 2019 19:35:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id m19so9497171otp.1;
        Sun, 20 Oct 2019 16:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1/IHN/ve/UVAvkgwgytXM/n+jeqbbwYBnVAoJItoZs=;
        b=OY9xX51liZztwZvFnjW+MtZt8VYC44BkGvpG/qygoRhefC56DONYKty+LJK1LvCkkB
         8dS+u3yJlKDHaej81VHv9HbkfyMZsE7rYUiQUUHSpeROsFrcnwAppF9DDtqik76bfWot
         /WwbFpPULAkrZirrILeH/lX7INFKfIucUIMi/tW1GZ4785JHWECS8Oa8EYSA+COEsmg9
         Mn+fUJ/3YkjmzE2mvjC9YoLjG+2n3ovP+4RUQoZ/PBO9pPjV8IZ3b1rJnl+K76M2tNtK
         n+DVvwENgw6ffBh4eFXxubWJTQ4KyTqrmC+hAQBAvryexQb2eXJMyuATxDcvGsrcVHQZ
         jvow==
X-Gm-Message-State: APjAAAXTF+81/YKjBRvQ2Gou50MnPTd6vK2QjJUWCI0nQ47cRPSEA+21
        a9x+NR5/3eBORsoQqvaosrADQDX9WQEKoUO8ZX8=
X-Google-Smtp-Source: APXvYqyuOzu9MZlBlyPAZ1+sMzYtlHZqQtbfvDQ/pZzcle5REH+v+AVjOknrXhmJX1pYgksatO3r38jMIOd9qPCFG+k=
X-Received: by 2002:a9d:664:: with SMTP id 91mr9655425otn.189.1571614507410;
 Sun, 20 Oct 2019 16:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191018123534.GA6549@mwanda>
In-Reply-To: <20191018123534.GA6549@mwanda>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Oct 2019 01:34:56 +0200
Message-ID: <CAJZ5v0jeoJrrn56VqRSoY-Mc9rp04tWYbTCsQugZV=vXQk0nNg@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: unlock on error in scrub_show()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 18, 2019 at 2:38 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We change the locking in this function and forgot to update this error
> path so we are accidentally still holding the "dev->lockdep_mutex".
>
> Fixes: 87a30e1f05d7 ("driver-core, libnvdimm: Let device subsystems add local lockdep coverage")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 1413324982f0..14e68f202f81 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1322,7 +1322,7 @@ static ssize_t scrub_show(struct device *dev,
>         nfit_device_lock(dev);
>         nd_desc = dev_get_drvdata(dev);
>         if (!nd_desc) {
> -               device_unlock(dev);
> +               nfit_device_unlock(dev);
>                 return rc;
>         }
>         acpi_desc = to_acpi_desc(nd_desc);
> --

Applying as a fix for 5.4, thanks!

@Dan W: Please let me know if you'd rather take it yourself.
