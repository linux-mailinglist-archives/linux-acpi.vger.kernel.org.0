Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38348276BED
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgIXIbJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 04:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgIXIbJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2020 04:31:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CB1C0613CE;
        Thu, 24 Sep 2020 01:31:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f1so1270152plo.13;
        Thu, 24 Sep 2020 01:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVI88Ab0ORn7n0SaJ8glbDknDRZ2U53PHQjSfMHEPWQ=;
        b=QsP1udv4sC1wPywLdkSvUzX8PPWRzMDOEm8ry73Pb7GpZ8K9jlE4hyOM4y5HVNn0BV
         JyYRDWIMWhtgt8j6QIGCcO6s9oUzSBDeBvmlolD1Dd3umqcjuKiVoDJ35+QL7D6I8XOz
         p9t562M/QHZj39mRxdt21hU/sEGIgLhtM7hmu8NGx/pEPuF2rwTd95EyPgvqXUQpc9+8
         GgGCVxwT8jFuznoRBUEvq1pvgMZndVYksUrt6D/Py2bj0dwTXXTWa9Vg4hoItFYhcyiR
         28xdtlMtzKApWtiL7J+JmDCqx295rF7hxVX9rrhx2/uyT/BcSGqw/nekWHPCGeZiHHah
         fh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVI88Ab0ORn7n0SaJ8glbDknDRZ2U53PHQjSfMHEPWQ=;
        b=dvvs+UH6+8cmFZJmWsPEAKdqgUXekO6ItnG0d5YY0lLSIrqIhF1ACE7KXupdHHIkYG
         ahff3zvschwUK8GApR7t3WD86BnEzmr8LW7E28/RU8Y/aCtsnjfXNIuFjeY5TFigvp+v
         FHE+0yPuofp/rggN4W3HpvkOEpHkbSlTlCQ+m9AoDIoCLBqIil9qHAjOKKEGuw1HVa50
         l3D9dGhIHrVXVY1JgZsAwu0HzPdX95F0V+kaSwp19z15kNmaPonnJKtD56lmSMBQFiSc
         11BWRGjl8PHwSAo14N0J7xeTkRalX1NfOqpGCaaBKKFcGoUkdU4wxO0yVQDF+7LJW/I+
         VPAw==
X-Gm-Message-State: AOAM533tJfR6IcCE4/U8iezbOUFqErKQerkhc/VdxKF27hCZVPTSUKZp
        yEPeyL3YmcGi7fHr7Xg+lU8r/TyVMn1Msr+RjIo=
X-Google-Smtp-Source: ABdhPJxY/SFBzi1/e1CZgyq3kKnpbcADTlsz9mk4MTd6CKSbIGdJxuUP64RnGNYQ+VHTNfV/Ob34qfdZ9vvWJ62IaC0=
X-Received: by 2002:a17:90b:fc4:: with SMTP id gd4mr3015493pjb.129.1600936268874;
 Thu, 24 Sep 2020 01:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200923151511.3842150-1-luzmaximilian@gmail.com> <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
In-Reply-To: <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Sep 2020 11:30:52 +0300
Message-ID: <CAHp75Vfp86h38Rd-VEgER7ASADdmz5ymAkuHvD0Q6WPDqZBqHw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 23, 2020 at 6:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> >
> > Hello,
> >
> > The Surface System Aggregator Module (we'll refer to it as Surface
> > Aggregator or SAM below) is an embedded controller (EC) found on various
> > Microsoft Surface devices. Specifically, all 4th and later generation
> > Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
> > exception of the Surface Go series and the Surface Duo. Notably, it
> > seems like this EC can also be found on the ARM-based Surface Pro X [1].
>
> I think this should go to drivers/platform/x86 or drivers/platform/surface/
> along with other laptop vendor specific code rather than drivers/misc/.

+1 here. drivers/platform/surface is a good place to start.
And you may begin with moving a few Surface drivers out of PDx86 to
the new folder.

-- 
With Best Regards,
Andy Shevchenko
