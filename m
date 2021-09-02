Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E046C3FE7E0
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 04:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbhIBC6Z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Sep 2021 22:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhIBC6Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Sep 2021 22:58:25 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D306C061757
        for <linux-acpi@vger.kernel.org>; Wed,  1 Sep 2021 19:57:27 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z18so948317ybg.8
        for <linux-acpi@vger.kernel.org>; Wed, 01 Sep 2021 19:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97bosaOR47TSvOBHg1mtJxPWJ+WtXwoG6aaniF3GCjg=;
        b=EP77MXEjIeo0g3Jyrx6Gx1gON2t0Bdje9gVoQyT91G5uuqDnnSgvA6WZr9MW8SOV6k
         MVQTDF0K1iTe1K+Hm8RzDEBhy58YNn+BLPgu7E4woPkbvXoj2/KlZTKSqpaT+j98wYVE
         Il2YQQAJGH7fOMQB+Q6ifkPmgOw621SAl0nuuuV+g1vkZXpzb2WcMrH++sdXq0UMU8aD
         s0PMncgFyUtwGwH0tAPRjNCc9GH4brxD4fTsnBTVLuNFBcDV3Bb/hngGWIJChugExis8
         pHGca5k1W4mg0Ry4tjeRpsdguS9S9bfvGX8mFgjZy1gwa5GXBRJY+MU1b4miNVqmLhm1
         QwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97bosaOR47TSvOBHg1mtJxPWJ+WtXwoG6aaniF3GCjg=;
        b=d29VbefsQBji+dl2rYdvQYfMWxjlZgPS/p9cKF2eHWN8ujBrtJBYGLum5w0Fi7TqXh
         ZQDj/8aUjo+/f4l5PCOPKwCBmLQO+O0D/dPCYboCsYyil4CZOTbxUAqDUoJOXTQGa6i9
         YHvtay2b+tyX61XHv1RrUzofQ5Kyt+25dcn4I4+Wdn6mx9+JCRmBMNjou5G8g0egIwjS
         UMHMkKOxc+PkYrTqCEz6RNTmPw1wAuvQ+YtEHnHDsl3Zk1LaRgW6KPs8tECgHpeb2G6h
         JW0QZmMpUxvfV9wfLZmafP0aXbfF9TnjKijIdABwRvk208c2cG8Cz98Xt6jEeaQx7sha
         nwIA==
X-Gm-Message-State: AOAM530hyeWqFngxZdrv64g7FQT730c0z+C8G9vxWIoZR686vrSEsIqG
        /zy1k4rWlsqRgfvwWObkiW5eNm+9jXOaxT/jwejWcw==
X-Google-Smtp-Source: ABdhPJz/eqWmkNu6JsP6j13DHJHCb1FgSwoKWuV+H62/OsmvzdUWGrstQ7zzYU2YDzZVdxEcsQcurXwTHOINPNLeRYk=
X-Received: by 2002:a25:804:: with SMTP id 4mr1340662ybi.346.1630551446791;
 Wed, 01 Sep 2021 19:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210902025528.1017391-1-saravanak@google.com>
In-Reply-To: <20210902025528.1017391-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Sep 2021 19:56:51 -0700
Message-ID: <CAGETcx9N34RyrdKDR8dQ7ECyz7ZXBx-Ft16t033NjTiU8p=Y0g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Ulf reported an issue[1] with fw_devlink. This
 series tries to fix that issue.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Oops, forgot to use a proper subject. Sorry.

-Saravana

On Wed, Sep 1, 2021 at 7:55 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Ulf, mind testing this?
>
> Thanks,
> Saravana
> [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>
> Saravana Kannan (2):
>   driver core: Add support for FWNODE_FLAG_NEVER_PROBES
>   of: platform: Mark bus devices nodes with FWNODE_FLAG_NEVER_PROBES
>
>  drivers/base/core.c    |  8 ++++++++
>  drivers/of/platform.c  | 16 ++++++++++++++++
>  include/linux/fwnode.h |  8 +++++---
>  3 files changed, 29 insertions(+), 3 deletions(-)
>
> --
> 2.33.0.259.gc128427fd7-goog
>
