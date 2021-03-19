Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0434254E
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 19:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCSSyF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 14:54:05 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:44630 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSSxw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 14:53:52 -0400
Received: by mail-ot1-f44.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso9473219oti.11;
        Fri, 19 Mar 2021 11:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSfZo+OL3h9++SEiG+mrCiK5ZCq1/nFoZ4zdT/1Zs7s=;
        b=CgyvLQ6fNWMcEw0Ne+D80YpoJly9pDDvIXIIplq4G78do7wxEqvLHyPupXNAVh1mZ5
         2uWondAYGdp5yAasStyQLGzl0aMAOSpS00fx0T8Tm5jhYGUZD9tCnsvdtUuX0YwgWfhH
         XHVX0b3pbxsOgsTVeYT5Eg8tyXpskXsT4ceT334Ukw8naUe5KLDU5qLcIkTDCwq3dMeC
         gcqrBoV+6yhOsnpjrnPgkvflUTqEIqe5+hopeE4+mOHTh+BKeBy2Tfn1hXkjVyK/6LLR
         gbopxp+edf6nKoiGkfYUwW/ZhQdiamPiVqS+7CIDwNGiV64SZA4Adfv+t7yeZxAcG0fk
         nX1Q==
X-Gm-Message-State: AOAM5331mxH5Iy4FQx/c/rmzR6hWHBtVWqrQb+94LV0YqpaNS0kKeoBh
        PLLV80i5KSXED9hLKJzcNwwIbqD84UWCsIVomsQ=
X-Google-Smtp-Source: ABdhPJyZpXjIAhejBCf9YSSjkZjx3d0dP0mxrMGqTl4H3x513BdYGHBulfFLdWRauiFZmL6DmpxqD38oqWNFpKYAUMY=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr2266158otf.206.1616180031721;
 Fri, 19 Mar 2021 11:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210312032430.13664-1-chris.chiu@canonical.com>
 <20210313102545.GB11435@duo.ucw.cz> <CAJZ5v0g7pEMA-QTonuVgMVmFCcHwnTtYYCaw7mVertPfhHNt8w@mail.gmail.com>
 <20210319184828.GA5022@amd>
In-Reply-To: <20210319184828.GA5022@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 19:53:40 +0100
Message-ID: <CAJZ5v0ihOVEFvcLLPmXGQ7aj91+BLpJQm12HE=pLpHKbDv-9jA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add missing callback back for Sony VPCEH3U1E
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, chris.chiu@canonical.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 19, 2021 at 7:48 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2021-03-19 17:44:32, Rafael J. Wysocki wrote:
> > On Sat, Mar 13, 2021 at 11:27 AM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > On Fri 2021-03-12 11:24:30, chris.chiu@canonical.com wrote:
> > > > From: Chris Chiu <chris.chiu@canonical.com>
> > > >
> > > > The .callback of the quirk for Sony VPCEH3U1E was unintetionally
> > > > removed by the commit 25417185e9b5 ("ACPI: video: Add DMI quirk
> > > > for GIGABYTE GB-BXBT-2807"). Add it back to make sure the quirk
> > > > for Sony VPCEH3U1E works as expected.
> > > >
> > > > Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> > > > Reported-by: Pavel Machek <pavel@ucw.cz>
> > >
> > > Thanks for doing this.
> > >
> > > Reviewed-by: Pavel Machek (CIP) <pavel@denx.de>
> >
> > Applied as 5.12-rc5 material, thanks!
>
> Commit 25417185e9b5 made it into stable, so this one should be Cc:
> stable as well. Sorry for noticing that late.

Well, do you know which -stable series it went into?

I've added a "Cc: stable" tag to this one, but it most likely doesn't
cover all of them.
