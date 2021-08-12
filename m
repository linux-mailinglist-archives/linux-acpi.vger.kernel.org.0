Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3B93EAC36
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Aug 2021 23:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhHLVHa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Aug 2021 17:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbhHLVH2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Aug 2021 17:07:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1153BC0617A8
        for <linux-acpi@vger.kernel.org>; Thu, 12 Aug 2021 14:07:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g13so15839573lfj.12
        for <linux-acpi@vger.kernel.org>; Thu, 12 Aug 2021 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PC9qkv0bT5Q6RXEYPNOhipMKAifPwXWAHn4hf32awA=;
        b=vYBXkKzxA1EduNxnfN1Numn+ttQQ0nz3qIeVUko6iVKC/NjsgH83Zru6BhgsImsWIQ
         8wfmTu1KPc4fLXq5wLA+Z6wIoMIlghED7eGC8Snq2SaAQcKmfzs+4GsQoa+jVCEC5Tie
         C3NOi/XrUgdJIujw5fQY7Ma7EhVidMLYQDELAw1hTUvKEO1CEAkhocKD53L7/qW433kV
         zHR+1kCbSp+kCN00MD+oxygnC/SqGCTYsLkJ9gUjT+0K2yCPCDuBjlli6z97la/+jDR3
         PzK5ZH8iaw/f7OwfQR550zGdcRYr47BJe+D6TEkPpUG36wtjIvX3sAefJo6q1BZaBJob
         5gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PC9qkv0bT5Q6RXEYPNOhipMKAifPwXWAHn4hf32awA=;
        b=J/BZ8DgxSi0SAflZLdOeXsYo3LgTN79jwtKUfLx0kva5RA+ixaNxFzhlJ4VVQYRTN4
         9WgdWnl3Rl4hzSLH11ToC3Ir+U54+x8XKlCt7wHqAQ5EZcwDyFb9RvNXroXj58IXcLvJ
         2Uh9ZXn0w0IzGEnb3p9vOsCw02a2wJkD4AKEuDcnOok228zfsxLsIZjWfgTVQ8SJ1uFA
         XuyI8RC3B0RzcF3b0hpLhIa2/AHOGs7Dgt+2X3PqXpAzfjgFMRcXdCN66YrvvXLej7Dd
         xbpDFeQDXLDvEUw5su9uHemuPDbd2+DcdVpKEB18dKkMegIfzKsezzRycojfH8HYHfj5
         vkEg==
X-Gm-Message-State: AOAM531XcsjFNRWvILmDpbl6i7YWSEsn3ttxTIdl+alVN2QuG8TbmkfK
        fQqCkoSBKKcobD9MkbroB85ZG4Xm0RL2eFTY6p7B4A==
X-Google-Smtp-Source: ABdhPJxG7tjf/3lJu727KTAlDk9tbnswuGrxJU9a2UtDAP01GNjfL1zAJjqiqNFgL0ryBoEgKoxD0oLgMGot3sehaiU=
X-Received: by 2002:a05:6512:32a3:: with SMTP id q3mr3709067lfe.157.1628802421338;
 Thu, 12 Aug 2021 14:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <YRUskkALrPLa2cSf@smile.fi.intel.com>
In-Reply-To: <YRUskkALrPLa2cSf@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Aug 2021 23:06:49 +0200
Message-ID: <CACRpkdbAw=+x9vJL7TiqyA+M8J9CA2go+hjuP0EUzzkEZikbbg@mail.gmail.com>
Subject: Re: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux GPIO <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Thompson <davthompson@nvidia.com>,
        Asmaa Mnebhi <asmaa@nvidia.com>,
        Liming Sun <limings@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 12, 2021 at 4:13 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> From time to time I do grep kernel for ACPI_RESOURCE_TYPE_GPIO usage.
> Recently the drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_gpio.c
> caught my eye.

Thanks for doing this Andy, I wonder if there are other GPIO things we
should be looking out for.

Yours,
Linus Walleij
