Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D733BA370
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhGBRDR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 13:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBRDR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jul 2021 13:03:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A90C061762
        for <linux-acpi@vger.kernel.org>; Fri,  2 Jul 2021 10:00:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so6427138pjo.3
        for <linux-acpi@vger.kernel.org>; Fri, 02 Jul 2021 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQvuII/Lvg26i/Ja3NIhtg54RlXLShl7GtVaD637Qdk=;
        b=VnxpbNoBJYuzdpsZvkT5uLhWb0wZW3E3GD6ne8vKkS/p3mXDEnKDTOjGRGxa7rcX9X
         vNr3TUWYUCVFPMjwbOcFz+PMklaLNImixbUu9y5zkdQm0FlkGsFwCIEcvYTZw11VD/me
         FHCNLKPkChxKk7qbJDvL/pwAZLIZNuMkkYiyiE/qscxaLlHHlCuQZ3fWkQSvzkgDiko1
         /ZGf6M3sSqlKbcI9ZU7tjdwVlRMT0NMmoDo7h7Jt/h3wfzyZmLRLi469rRtYc7MCASVH
         6apRbq20+fBiRcLrPSiHp1w/pig9JeDYbe9/gKOR3E1EmpGF16RYBF1dktI8xkhp63Fx
         DvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQvuII/Lvg26i/Ja3NIhtg54RlXLShl7GtVaD637Qdk=;
        b=duJM9eRIE+LzSfp7MYSVoFdPp6aAzQLrvVjmicrFFB9nDR7AZMjE6wAbAGJdmW+8ar
         AOGOCasmKyRVSsMvfugBr3hx3lQYaTLqnBgy3KGjMuU5c6ZGOvUS6B9EtSzJc6ty6y4Y
         bkZQ1jPmEfNCg/elDj/H99LQJ5QekveRB/ZB6Jh3B7WoqRQV2YaxUTeKJPNu/vd3sjEM
         5jZ89eRp326SJgEUdXlLLA7XIA63zFYG991D7XjcWFv8Nz7kxI0r7VkiB8MXBfdE5bXM
         2jFHQJmxbOHMqhPRcs/y3G/wEYPlCzBVK77u6WNyPxchQHAW+7eks8unTJURup3ImgE7
         yHIA==
X-Gm-Message-State: AOAM532+YvaHizzMfDktDf2X3Pr20MKl43wWanzDvLPDfse1ZB2ZgLC7
        czTL/ZbiHspf96Ts5LQj2c5wAIx4xCnzxxThCcSqwb0Vc7o=
X-Google-Smtp-Source: ABdhPJwv6+CPgGPZthPxGRGnU2PnWBPr1wEbZ9v6TwA0/PQbef0IF1Tgowh8SYeq7AJ+c0sfdFbuikZQ83B6lV1SNXQ=
X-Received: by 2002:a17:90a:af90:: with SMTP id w16mr674748pjq.129.1625245244698;
 Fri, 02 Jul 2021 10:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210702165052.81750-1-hdegoede@redhat.com> <CAHp75VfWN1wt4bA4hVefOGiHA44-h3qEMt_A0=96k2Wq4=_WVg@mail.gmail.com>
 <0e8c71a2-6b64-fec2-c307-a8a530bdead7@redhat.com>
In-Reply-To: <0e8c71a2-6b64-fec2-c307-a8a530bdead7@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Jul 2021 20:00:06 +0300
Message-ID: <CAHp75Ve9+r4LCuU2zf1jm7tGhOYeL+dRY=q6biW76QjwkWjn1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI / PMIC: XPower: optimize I2C-bus accesses
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 2, 2021 at 7:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 7/2/21 6:54 PM, Andy Shevchenko wrote:
> > On Fri, Jul 2, 2021 at 7:50 PM Hans de Goede <hdegoede@redhat.com> wrote:

...

> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Thank you for the review.
>
> Is your Reviewed-by for just this patch, or for the series ?

I have not seen a cover letter (is there one?), so by default (i.e. if
not told otherwise) it applies only to this patch.

-- 
With Best Regards,
Andy Shevchenko
