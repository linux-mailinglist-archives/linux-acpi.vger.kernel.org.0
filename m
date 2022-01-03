Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD3482FC1
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jan 2022 11:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiACKFj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Jan 2022 05:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiACKFj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jan 2022 05:05:39 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2EEC061761
        for <linux-acpi@vger.kernel.org>; Mon,  3 Jan 2022 02:05:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b13so133863364edd.8
        for <linux-acpi@vger.kernel.org>; Mon, 03 Jan 2022 02:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyqrhqFrOjKgAQ/NgiI6myye+ZTSj+oGpoQCEyxK7I8=;
        b=hh82xL5h3iuQi0w0UWmziHKDei2V7WmW8Q1scEW+3QAUMeU9NQzjI4tQbE7SdjFtf1
         jSJxTC6JXmJC30t8UiD4KSbWgFjgI5vzj/f4kgXCMMF1cXpyBUaEbmKaciHqvMxsbzsA
         s6srxiCjzdc1gKO+ggXM4XDCqtT2PwzGVzkb/jUr2J2ZhWo5kOfS2MJEdIdlgYONwV+r
         8UXM2kZvxf61JNCPztpCEKlCSclwA8LLCiKZq9s5TG2Hj+M4q7kIxpkcgP2mbBpk/j8b
         XueqCMflL2VGG7B2jaKdv/ucS5zBVJXPEWQ01p2ABMjOQzlW4lcBw20nefVTfWSS2F8G
         U11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyqrhqFrOjKgAQ/NgiI6myye+ZTSj+oGpoQCEyxK7I8=;
        b=d6B75+WfmvL1owePLCZhWzVAOCDqOWD5P7gBbW0iDHRfP9fSWs2lEq497zcI70HtTl
         fR5/Ahk7aWFy/w8FhipTx9TcFdSQn+vHtsOmOb+AzYo6+TDexKTWmxoGmsWvAbY7s3xJ
         HVrsFEEn35AyVBJ1jFfQNOdHZb4hRsayWGXaiQLciArpBPtzMBGk+dX8BB70le/tGldv
         o9XhXeHYSjvboxT0jiVn9qvP/TA0QFXt7yYqOQZNuDcCxnAcb8vPALgOp2wm8JqOrbv9
         m+0MKJquPNYoswBbqmAYmV3X8QWessk41EnGfdXE9A7pxkfPfqKdqBOw9grtQPCFHuOR
         xw1Q==
X-Gm-Message-State: AOAM533DGv53pZLb8T9Cstud602DoTaA7nM/mDk6fyqajxi9NG+yvH/I
        m7Ia8YWAnTZu/sJkstBLAqSqe6vzy7e6Hd1h8tX3VQ==
X-Google-Smtp-Source: ABdhPJz0LLpdg5ZlhYjWS1ccr4u0SOQqQpZlRsNizsQSMtlQ61aLAXVlFvutkF5sr+/qADHHxZmu4uWBVmQTZlrVwhI=
X-Received: by 2002:a50:9556:: with SMTP id v22mr43073644eda.69.1641204336956;
 Mon, 03 Jan 2022 02:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20211223103809.12343-1-andriy.shevchenko@linux.intel.com> <20211223103809.12343-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211223103809.12343-2-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 3 Jan 2022 11:05:26 +0100
Message-ID: <CAMRc=MfCu8Z-FLdyz8eAqjj+soARUk3zoL8jDFpe2VyLCd2r5Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: dwapb: Switch to use fwnode instead of of_node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 23, 2021 at 11:38 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it and hence rectify the ACPI
> case which uses software nodes.
>
> Note, in this case it's rather logical fix that doesn't
> affect functionality, thus no backporting required.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart
