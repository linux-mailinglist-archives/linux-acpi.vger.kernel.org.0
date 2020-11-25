Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DDB2C472D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 19:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbgKYSBe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 13:01:34 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40348 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732313AbgKYSBd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 13:01:33 -0500
Received: by mail-oi1-f195.google.com with SMTP id a130so3765613oif.7;
        Wed, 25 Nov 2020 10:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMaHq0oIUbpdceNa2KvX326FnLqaz6u4HCFyXq3ixaE=;
        b=uBrNcPMO63SNsx1SWwfo8UBpqWcNKrtWOO7SYJqF5zzzF6YAaG7vo6vvgJes3GikeM
         Nqpc88OF/w3/BTzW2AlEjc3MWxvJO1rmAMQ8PXXOnB+NnwU80i18xelUBK/dpksRLKy6
         73pMVyIuRrpeUOz551pX7ujAJPOwm7bpW1Q71yqitc+++yDDlWBbfpvBuIxGvcz9fASk
         9heCeYI0b2aMBLJk6BbdIfJx+8l1MKB1CPIaVg+ELJCJwhR8MHWnSUvNB4cpztImd03+
         TyzWGXo9B9wZcoQ1z+tGBva0r5gXmH3QK64g+OATCL6msxaR0sYJrPERh/Rq8lb2++Xf
         FeHQ==
X-Gm-Message-State: AOAM532Oq5NTgYeN/kTptvoBS5AnFLE/SnKWbLz1Uz9XvsxecT4AfDR9
        GbtjeMLo7eHFfXUiZZO2Y1zmtlm9mK+FhkYKp8n2VrIf
X-Google-Smtp-Source: ABdhPJzJsTsSY2qHnQvnfowgzWeqDlWG1plHmDqqpqVSqwR8MW/cmknHFJoWUzrtE7xmqYts3EQmmebxdIMaeMylhLs=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr3019149oib.69.1606327286219;
 Wed, 25 Nov 2020 10:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20201125161626.66180-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201125161626.66180-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Nov 2020 19:01:15 +0100
Message-ID: <CAJZ5v0hzC25Qi61aDw0PNz6JpOwjFjGbqPyp8ozvypw4sewMRg@mail.gmail.com>
Subject: Re: [PATCH v2] resource: provide meaningful MODULE_LICENSE() in test suite
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 25, 2020 at 5:17 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> modpost complains that module has no licence provided.
> Provide it via meaningful MODULE_LICENSE().
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: resent with linux-acpi@ included
>  kernel/resource_kunit.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
> index 9fdbca8426f1..58ab9f914602 100644
> --- a/kernel/resource_kunit.c
> +++ b/kernel/resource_kunit.c
> @@ -148,3 +148,5 @@ static struct kunit_suite resource_test_suite = {
>         .test_cases = resource_test_cases,
>  };
>  kunit_test_suite(resource_test_suite);
> +
> +MODULE_LICENSE("GPL");
> --

Applied, thanks!
