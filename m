Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38EE43772F
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 14:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhJVMi5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 08:38:57 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45579 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhJVMiz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Oct 2021 08:38:55 -0400
Received: by mail-oi1-f174.google.com with SMTP id z126so4782341oiz.12;
        Fri, 22 Oct 2021 05:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wq+ijz7hkrgAvLrrYeAZpXxYO+s2Ax5t9fMYOLTN/Nw=;
        b=kpn5dG8oOfStWUuVEzJmrxruVxqmXzkMKkZpEAohhAWTQKjp/j8Dw8kV8+UTxZ7pKW
         63djW3SLdu1fCDg/EVFxtK7O9uMMdGTyuWtaK5y1adIVd74slmmezo20RT1bj8t5hOmM
         3SQcnZcpzjDZs4j6y4zPC4o0Hd1YtX2nRQlDztQE2cngBk15xfVK4yMfWbbv9jpeewpW
         I3XBWW/7pZmCKSYDYIrH1OatVueYv4AxjRFxaexqLg9ACmPAJnnbHgH+Ec3LyE1U2xW+
         H92U5GNJmBV1JL12AOsa1GXJvMsAN9wO+EP3uU2H7bc1pEq+n1JncLEnmCyfkjjlYnYd
         8rzg==
X-Gm-Message-State: AOAM532Rw5hghmTpzJwstqOBc32huHfCNDkHx2NmUIz/0AlEy3nwmWqI
        QHXdpmQ+M2mNOVAVI1RlS4XmmsvbtKOjhAQc1B5Be2zh
X-Google-Smtp-Source: ABdhPJzM+YiKjpNohzo9egAZ1k5JoidFckV6+T/fZjiDsXCm0z0lzC35OwgLubhOaffF9Qg0l/Wy1p4MLcDFyU8c9jI=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr9339669oif.154.1634906197810;
 Fri, 22 Oct 2021 05:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211022073910.14398-1-songkai01@inspur.com>
In-Reply-To: <20211022073910.14398-1-songkai01@inspur.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Oct 2021 14:36:26 +0200
Message-ID: <CAJZ5v0ixPr8WN9hdTtqj1S4XakhH9hJSWJSf9EthdyMEScaOhQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: fix return value in register_pcc_channel()
To:     Kai Song <songkai01@inspur.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 22, 2021 at 9:39 AM Kai Song <songkai01@inspur.com> wrote:
>
> It uses IS_ERR to judge the return value of
> pcc_mbox_request_channel().If it is invalid, maybe we should
> use PTR_ERR to get the correct return value.

Either there is a reason to make this change or there isn't.

If there is a reason, then what is it?

> Signed-off-by: Kai Song <songkai01@inspur.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index bd482108310c..0bbb5fa27ce7 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -503,7 +503,7 @@ static int register_pcc_channel(int pcc_ss_idx)
>                 if (IS_ERR(pcc_data[pcc_ss_idx]->pcc_channel)) {
>                         pr_err("Failed to find PCC channel for subspace %d\n",
>                                pcc_ss_idx);
> -                       return -ENODEV;
> +                       return PTR_ERR(pcc_data[pcc_ss_idx]->pcc_channel);
>                 }
>
>                 /*
> --
> 2.27.0
>
