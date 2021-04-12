Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B477135CFC2
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Apr 2021 19:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244729AbhDLRsX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 13:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244664AbhDLRsN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Apr 2021 13:48:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83298C061574;
        Mon, 12 Apr 2021 10:47:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id n38so9680908pfv.2;
        Mon, 12 Apr 2021 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DgnMLW54yYGnPtnA18TLaPuXsRrPLh79PL0NZM2fdPQ=;
        b=Be+gUYKbpdhT4uDF8LSr5fHUGrNeSx+aTJfi1LpNdnx3CA+O0j0yuRFQn5hopywj/z
         4/sCz0bdE96p4OiNSc+Qq3PdmvMPvenv6+tixlU7+FSUPBpx2oHIGFoXDWzGCcf5EQ3D
         pRTZ95C/RkQFIbvAbhEB05EFzU+oB2fSqKwGFBEDoUOtOdxQz28nz6TwQ6PjtvcO1ldI
         APJ9Uy2Y0roe2ZUmJrJ3L/6qgwObttfX1+uzfFm3QY18lDiVxUHXH1OQhOpTpJi+SAjZ
         3pCsjbeeVgdiCtNZ+OlZ7cyG+igkop/b68lhqlD9UO9VzAOmq9OZjiMFtDQU87TOhsbE
         HRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgnMLW54yYGnPtnA18TLaPuXsRrPLh79PL0NZM2fdPQ=;
        b=KluN4/euxfSWqVCnEK05XzZoeBe9VZpalwY+g233FjjJ/uNvl8zJ8/RtThU9pB8+bW
         uUvtRSKt3o86ijcWfDwvCbCySDCVJUR8CcyqT3nZYZNzU6dxQoBPLCWkIovg0yBI0hZZ
         5/N/QENpDYgQu1JKx7+IaQBdZu4RmLJksL1KegIhLFsbKDqlETgcXxQsHWYVhkVIm4Gj
         Dci2O2FRSD+gZ3zzwRZg5P00W9J5aZRALm3PrIQ8fK6rCBx15VVwvdQqPIsCnSO7U/cJ
         wXekrDpiS6YZFxxCy4tAVq0rA7GubE0/+UkKFAOii0ZmgsfgOOAo2RjPYUEQOscC5RM1
         U+Iw==
X-Gm-Message-State: AOAM531VNQr0+8l6a5FU6TGd3x0OmfSqjb/BQxhUgvYjRBkdmCuRVBBU
        EMNGK7KY163rvpypBg0LxCuAkKGjT3szja8PY7A=
X-Google-Smtp-Source: ABdhPJyoSw2Vf91WbKVp/GOwf/dOiztGtKwfq/0OXFArxK89COKnoHklpij+YWCB0SnEzEG8ygf+b+MBcSHwijK7dX4=
X-Received: by 2002:a62:e50f:0:b029:214:8e4a:ae46 with SMTP id
 n15-20020a62e50f0000b02902148e4aae46mr26154827pff.73.1618249674955; Mon, 12
 Apr 2021 10:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210410134718.1942273-1-andy.shevchenko@gmail.com> <CAJZ5v0jQ=UU8FgFFF_ht_v1dZwhp-32wi_QNaZuf6vBaORU41w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jQ=UU8FgFFF_ht_v1dZwhp-32wi_QNaZuf6vBaORU41w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Apr 2021 20:47:38 +0300
Message-ID: <CAHp75VeW7w-tX96B8Gh=E1meTHLzuocqaM2MTLyokc5hETVj7A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: bus: Introduce acpi_dev_get() and reuse it
 in ACPI code
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 12, 2021 at 8:32 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Sat, Apr 10, 2021 at 3:47 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> >  static void get_acpi_device(void *dev)
> >  {
> > -       if (dev)
> > -               get_device(&((struct acpi_device *)dev)->dev);
> > +       acpi_dev_get(dev);
>
> I would do
>
> if (dev)
>     acpi_dev_get(dev);
>
> here.

Hmm... I don't see a point. acpi_dev_get() guaranteed to perform this check.

> >  }


> > +static inline void acpi_dev_get(struct acpi_device *adev)
> > +{
> > +       if (adev)
> > +               get_device(&adev->dev);
>
> And I would drop the adev check from here (because the code calling it
> may be running with wrong assumptions if adev is NULL).  Or it should
> return adev and the caller should be held responsible for checking it
> against NULL (if they care).

But this follows the get_device() / put_device() logic. Personally I
don't think this is a good idea to deviate. Note the
acpi_bus_get_acpi_device() / acpi_bus_put_acpi_device() as well.

> > +}



-- 
With Best Regards,
Andy Shevchenko
