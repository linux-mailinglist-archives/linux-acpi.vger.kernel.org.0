Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E04262D7F
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Sep 2020 12:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgIIK6e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Sep 2020 06:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgIIK6V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2020 06:58:21 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB09C061755
        for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2020 03:58:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e23so2898297eja.3
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2020 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu65HGw7lD3rRilEx9VGlqvryu5AO8PpY3vy5bDHdp4=;
        b=mZGcdKZt8qCyIVy8y24txARqimWW+2gYMnqdXTiD5UAlSCAt+BHUHixKl4PFE1zgTU
         eLMeDFiCHpKz/ZIqAZPTuO4ZRz8fbu43K+AXAnUbzFJ4LbXuCK4fhWuZw0iQD+SDxweH
         upyX2G3PA6KMABVK2FRR3xD3kxhfS7B7ZHxPHea5+k6+5gHF3VFqvanO7IBNqtxdJTiJ
         zvXImRz1GeSPhtp+lrUW5Cp6mLBaFv2gMU9sGUl59W7JcmYMx33240ioJl26+8VHfQ60
         mFmmI9CD0GGDcTNaNGR5+VvfbW6YbRBZEL4D2uEWQyPmgtC2tl0cDk06I9MWvExXeMiq
         La0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu65HGw7lD3rRilEx9VGlqvryu5AO8PpY3vy5bDHdp4=;
        b=Mxu+UsNQfrHazvxKIKYSri6nIEW9H0uWyYTvB3a+LsUakwlO/HqcuGKhx32LVO52Ya
         uaBbXwbJ0H2whzW35YW//842eHrjD1sEG7HVvDyo3HHP44mTScDqdEuIppNtKtp17NjN
         NZsiq4gVHqqrYhqmbX3zhYretOBFYrXGha1O7zqx4ZaDojbDkm2FTz5u2s/g51sT8ITu
         tZ8VeVVOYyKwXkFOt7BOmzzS4iSxIYodO3FkugEVNB3Hm8qccySsQb2NmkWJI7weL7mF
         HNXK+RddrZcWc5JR4Bte8X841E1jxypx5ZjelRl9I3cvJQ1rbJtQ414p6hocDG3uj/ud
         IucQ==
X-Gm-Message-State: AOAM530n250tSWKs2TdPRYpLmY8kudwwI3YdrLFuz4jhSqhYD5GzMqFN
        HiVPy/i29jgfVZN01DJIEXnnQ1GW81xbxmiahCq/WQ==
X-Google-Smtp-Source: ABdhPJzVrHGzQqV0LHArkKovVyu9MjaO3CeazQ+IrJy6Yj2B0/g6jByCwi3w6+KE/Fs6Ph4rtOC6BBunPbai0tsoNE0=
X-Received: by 2002:a17:906:e4f:: with SMTP id q15mr3170587eji.155.1599649098390;
 Wed, 09 Sep 2020 03:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200909085426.19862-1-brgl@bgdev.pl> <20200909103440.GM1891694@smile.fi.intel.com>
In-Reply-To: <20200909103440.GM1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 9 Sep 2020 12:58:07 +0200
Message-ID: <CAMpxmJXsxqG1aJWp7Jwj9k1wiWJoPgWug2hUqCc+rZPoRwgojw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpiolib: generalize GPIO line names property
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 9, 2020 at 12:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Sep 09, 2020 at 10:54:23AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > I initially sent this as part of the gpio-mockup overhaul but since
> > these patches are indepentent and the work on gpio-mockup may become
> > more complicated - I'm sending these separately.
> >
> > The only change is adding additional property helpers to count strings
> > in array.
>
> Seems it lost my tag for patch 1/3, but in any case now I'm good with it
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>

I removed your tag from patch 1 because I changed the name of the helpers.

Bartosz
