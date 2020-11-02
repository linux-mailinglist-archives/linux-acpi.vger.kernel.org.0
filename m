Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6662A2A33FB
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 20:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgKBTXg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 14:23:36 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42128 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBTXg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Nov 2020 14:23:36 -0500
Received: by mail-oi1-f195.google.com with SMTP id w145so10148159oie.9;
        Mon, 02 Nov 2020 11:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bjso6djKCkIoIMDzF44M52l4m6r2fJogDXlkyFM1eo=;
        b=MkZQytp49GlUsfom/JqX5ZoC0+FnRe+HjUiZRE7BxWc2jQ2JWk54WDKqgW/fXd0B5q
         iEI9yAC/eCGsS7jrY6peMvF/FKLCO7coIBPFVZMa3RRSHY0NTLV6oe/F1QUVwWOjqn08
         Ta23DJFehqce+8ywzYBb6hD1daYU9qxTew/GIWU4vA6CuEEapmGptaz8+Gz0CSwAhSG1
         63ytmIiTQz551nND20su2WJc5sigMHhYU2VbWs6PhIrj5yGAP06rISk3JvqE5fjoK1tI
         WHGIv+ssSq1sg0+s3Z6Yc/0KbkTdPInK3rqPNIgE8Cdy67BmPCtb8ApOsdQmPOuxi2SK
         QWCw==
X-Gm-Message-State: AOAM5319uac045yIeJ6k03tcwXEzWcydLGE6GzEwCz0ogQ29XNgWq24F
        qgIDirtS5SMcqCeBomsRt2tSheugl8E/atuBG1Q=
X-Google-Smtp-Source: ABdhPJyOEGn5zZowlmFsof/U2xiUbQBYRbvNSP+MVLHdymFSr0yUv4s4kc8GtNkaOEXDbraLAJg2cCrRDWAvq2EIxqg=
X-Received: by 2002:a54:478f:: with SMTP id o15mr2952523oic.71.1604345015035;
 Mon, 02 Nov 2020 11:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201030165919.86234-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Nov 2020 20:23:23 +0100
Message-ID: <CAJZ5v0g0c5YX+fWNvPaUkOp7vZTKX-Wy7bLBfHAF+XNm-92QWg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] irqdomain: clean up, add irq_domain_create_legacy()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 30, 2020 at 5:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In order to make users OF-independent provide irq_domain_create_legacy() API.
>
> Last patch is an example of such user. First three patches are little cleanups.
>
> Rafael, can you have a look at this series?

Done.

Feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to all of the patches in it.

Thanks!

> Changelog v2:
> - rebased on top of v5.10-rc1
> - dependency-free (they are in v5.10-rc1)
> - added Ack (Mark)
>
> Andy Shevchenko (5):
>   irqdomain: Remove unused of_device_id forward declaration
>   irqdomain: Add forward declaration of fwnode_handle
>   irqdomain: Replace open coded of_node_to_fwnode()
>   irqdomain: Introduce irq_domain_create_legacy() API
>   regmap: irq: Convert to use fwnode directly
>
>  Documentation/core-api/irq/irq-domain.rst |  6 ++++++
>  drivers/base/regmap/regmap-irq.c          | 11 +++++------
>  include/linux/irqdomain.h                 |  8 +++++++-
>  kernel/irq/irqdomain.c                    | 19 +++++++++++++++----
>  4 files changed, 33 insertions(+), 11 deletions(-)
>
> --
> 2.28.0
>
