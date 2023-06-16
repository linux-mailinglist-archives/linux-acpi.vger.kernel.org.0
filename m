Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9571732B28
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jun 2023 11:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbjFPJLP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jun 2023 05:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344892AbjFPJKi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jun 2023 05:10:38 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CA84226
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jun 2023 02:09:17 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-43f4167d2b5so162680137.2
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jun 2023 02:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686906556; x=1689498556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AV3ZtPJBZL0WfMRwAHbBXb9JyUQlYU2aDfkGkK4GxeM=;
        b=J4uPShd2TmNiqE7+9BgoXBhgurdP8tS8ZKPiUMuegu2ZjrueviMWEf9XgteyLckeaS
         BnUJ6P83EBCpdT+yisBC7i9o9BsKBdCY4oOnSbGAS4o7+Hm1WUfeTkwByPu8cbd/mwVk
         x3NqL4AfpGBmDIJYGkt/iDZLH4fcbCWa6Op7zo9suZQKExfdausPLNDXvcByI8Wl6XbV
         Bl9J0AZ4PmayVcmJDv8B8Pr/7OrsIdYYLsVDvk80JGs/LnnT3KuIbPzTkhWJ002sH8Ny
         gWYvGG1a496Bg5/qsOAybQLK6L9zRIFcqemwSBJrH9wQYvRlpXUiqe9tadHM8/uA17Ep
         C3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686906556; x=1689498556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AV3ZtPJBZL0WfMRwAHbBXb9JyUQlYU2aDfkGkK4GxeM=;
        b=QMay7C86qDWF8LL5Hn+H0ksiYy8s0lm7KjUqWd+G1hqUGjOjYzZmG+5kwkOIFhB+JJ
         qCJjLyZ4HJFRDd1N2NcQXvA1SnVMwgJjomSqY/AMrzXP2QpJ6sRulhiQJ3pBRpZpxsLx
         c9j5OUhEGECwAauPfSYfNL+lnLR999bDT4zVB9ym5GSx76NEjgrlM55uaCAOx9mrMn5L
         j8uEEVGWJbCEHWeVuas2AZgSgUWsKUAdEfj37NHBJhfR+TW1mFSr2NCx+71cAG8r/85R
         p+xHuQjE4QLJhUzN8o6bSmt3wtOUod61XLqX2v6Szo6TiqKzSgp/v0bMnLWLYRunrzNh
         hyHw==
X-Gm-Message-State: AC+VfDwl9qiPyoUDbTaxFKRjB+m8ky0axCsxX2pPa6EyvWlEdupagE3b
        zwWKmWkU0r7p6UDg/Y7LqH5730Rf03tl0oZcSxoCXA==
X-Google-Smtp-Source: ACHHUZ7kqcUseSELHedqy89cjsjeAsc5SW5/5yfXaYeGGHZrQYpawpCNDfyiHXU5oNxtDiVcFfTWQ5E4fIdIvQN4sGA=
X-Received: by 2002:a67:fc4d:0:b0:43f:5d2f:b878 with SMTP id
 p13-20020a67fc4d000000b0043f5d2fb878mr1398900vsq.17.1686906556338; Fri, 16
 Jun 2023 02:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230315215027.30685-1-asmaa@nvidia.com> <20230315215027.30685-2-asmaa@nvidia.com>
In-Reply-To: <20230315215027.30685-2-asmaa@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 16 Jun 2023 11:09:05 +0200
Message-ID: <CAMRc=MeFn+oMt8s=_-inYTEMX3EfG0XPkGF0XX1QTECM=JOacg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] gpio: mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 15, 2023 at 10:50=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:
>
> Add support for the BlueField-3 SoC GPIO driver.
> This driver configures and handles GPIO interrupts. It also enables a use=
r
> to manipulate certain GPIO pins via libgpiod tools or other kernel driver=
s.
> The usables pins are defined via the "gpio-reserved-ranges" property.
>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---

Applied, thanks!

Bart
