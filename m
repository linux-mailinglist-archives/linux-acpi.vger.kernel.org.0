Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DD71ABA06
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Apr 2020 09:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439374AbgDPHet (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Apr 2020 03:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439350AbgDPHes (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Apr 2020 03:34:48 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1F6C061A10
        for <linux-acpi@vger.kernel.org>; Thu, 16 Apr 2020 00:34:47 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x23so4828087lfq.1
        for <linux-acpi@vger.kernel.org>; Thu, 16 Apr 2020 00:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrt+67omyziFxx3WaLfBQr2iyIgq4drGGzCS11Pkerg=;
        b=mSND34R/NPjH0H/0avQv/GDBtGeBVrz4jiUZ6dKhw825DHjKKCGbhVeb98eNBh/1lP
         42lWNFlMmYMoKFMDcgAS5HYu0ytaxjo2hlH251n2ufZlWDm4zyr9CqoU+evd2rbh55m0
         Bj+/Z9DnPuhSPPX7cfwtO3NuMO0hxhcKs+1slZoPxOAITSw/+bykBUvaYrhXqo5KGg86
         GAnKhe1e8G/lLe1Y9FhUsV1vUBXGC7v2Vi8ELIqu6t4G+ury5THipSvuC5sMbQgKxUBg
         CWZTFGymLDxL79/bVdS7NcoFQHa9ypZTFSwI+ipiJ88bRe1uopT0bJQE2I7RPkxNaCIE
         p54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrt+67omyziFxx3WaLfBQr2iyIgq4drGGzCS11Pkerg=;
        b=ZWHeRFFn1tJnq7qD0jGqEvWn8Cdrzu8O69beBCAQGxXp/GcRwftB23SKWejibkBr0G
         56snzjDNrK1mcQbAljT9pH6FkygS/aFEts5A39E+vS4M4Y72FbS/NtCIhX5Q9XGYpEFM
         6kqXrDaz7MASNhcZvuotLDacftINgqhlpKuzGu59iOECV65n6AA/h1DFrhHpNOhKjEQn
         6cLLz2G80HTFWdgJT6AcMEuIQJhSjQBk9n8SnjuGH7662HxMRnz+hM9uYp04DqW8xqWx
         OJrlwl/mqLko8EX4+BnKKtaVBNhwoJdM/8Xc1y7Y4nWmCuZ+oqT4TVSszZ7kSw9Mbtpm
         H0EA==
X-Gm-Message-State: AGi0Pua3aWrQdyTUwS+7z8e4wQ/YuCn6fwUq6smY3CXTWCcHAXrVT6wi
        zeBjz1OVv0rbQnCWga9r64N+SGGFvLzThzOsuqTwGw==
X-Google-Smtp-Source: APiQypLhh2T+qM89diZg7iMorNOnJb7adMEVgj8G7IAhkT17uvQA0//jXFY3D/uUpCsjMQeXE4oyUGLHirCOJZBUgdk=
X-Received: by 2002:ac2:4a9d:: with SMTP id l29mr4969920lfp.4.1587022486345;
 Thu, 16 Apr 2020 00:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200325103956.109284-1-hdegoede@redhat.com> <20200325103956.109284-2-hdegoede@redhat.com>
In-Reply-To: <20200325103956.109284-2-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 09:34:35 +0200
Message-ID: <CACRpkdYz5224+whjXW_Xmv+usn_kBxuZW6+1Vb0z8RQsYeZ9cA@mail.gmail.com>
Subject: Re: [PATCH resend] gpiolib: acpi: Add missing __init(const) markers
 to initcall-s
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 25, 2020 at 11:40 AM Hans de Goede <hdegoede@redhat.com> wrote:

> The gpiolib ACPI code uses 2 initcall-s and the called function
> (and used DMI table) is missing __init(const) markers.
>
> This commit fixes this freeing up some extra memory once the kernel
> has completed booting.
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied.

Yours,
Linus Walleij
