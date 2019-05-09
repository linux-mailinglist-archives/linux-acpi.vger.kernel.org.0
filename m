Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3195A1851B
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2019 08:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfEIGIv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 May 2019 02:08:51 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:41426 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfEIGIu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 May 2019 02:08:50 -0400
Received: by mail-qt1-f179.google.com with SMTP id c13so1210936qtn.8
        for <linux-acpi@vger.kernel.org>; Wed, 08 May 2019 23:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTW3b11tOzQl45dBo/UpkA2mKZfeZ/ETko9FvJUDZg8=;
        b=Z3AHiYe/Pl8HFXLwAU81fKt6hr7uxvNZcJsRT8n8yH04WYHvnBA73F+qJ2mHArAEEM
         C9TFGs+k8WOFE4T4tBSCUZxEl1vReTcgGe8KZHHFbHl5loQrEQmORA8TdIOIhlTCJ+fB
         esrysFnXKsUvD3RJdetAikLtyzSTCzHjlwGkTSo1Y8kJp3ZUYxIoRyPP8aV8A3dXLqcZ
         g77NqK/AUNZ2YqkgOrDh/tcrulDGJTDAivxOdQpKVEWV3OIRRYcCR/keLVhrQm4trZt5
         lz5wRlNyWllIZz3rYq00crYyoytxt6NcmZ8wnIZAotqj4qr6nYeGv9KS77THk7snzbIo
         8Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTW3b11tOzQl45dBo/UpkA2mKZfeZ/ETko9FvJUDZg8=;
        b=eX156A1RdvtLORxBlq3ucPr8/tHB91qIkbXMqM3X2zMHoBBU0rMf52ae+Dr098uaQ/
         oIUNq2Dh+yJ0+P2ZLd/nNr4Gg3O/tQfU5Luf4Ylvu1uSBlK2mskaYOxmPQTvcDFfMvR3
         voGOu53XOifoUfLeYi4gLIGEaI7tQwgEW99NR8uguGdQZ4U+3JS1GimA1JC3qzEBF9+Q
         er88WVbUlC1gZkSTBku//KUvdppP8MUunRC50++EAeoq2bERUw5ZlBFiymPeJlyl3ayr
         mrxUcXKeNXFvkCibADLdBnclIuubu0ZyCUys5n5iSriV+XvfjY26N6Y6ABBO43H8eJFo
         rtng==
X-Gm-Message-State: APjAAAXuLKAYCNqSYmfgedMZnip4Yp0PReyROLOk3BcRECr17JKvVvtP
        iNx5U9XGTstXwPdxjajflJgM8qzDMNluWX5iHMjK0w==
X-Google-Smtp-Source: APXvYqyCcUcHfEI7Sx75neiypn76eCAVOp3moRVUYPAOK57VhxZ7GdJtRNbBRTVi2B408l2xOwrBJpfdVPD2R8dpenU=
X-Received: by 2002:a0c:9899:: with SMTP id f25mr1962232qvd.82.1557382129895;
 Wed, 08 May 2019 23:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <d6ee51cc-eb0f-2bb9-fef9-f8b4bf849076@gmail.com> <CAHp75VfMXAyUpWTrEHnv1NcQcHch+RHehWYTjk6KMTbXbtppPg@mail.gmail.com>
In-Reply-To: <CAHp75VfMXAyUpWTrEHnv1NcQcHch+RHehWYTjk6KMTbXbtppPg@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 9 May 2019 14:08:38 +0800
Message-ID: <CAD8Lp46tCfi3ZCmmXZv3-ZDbon+6P8qC4GPR9Bt3uFFr=Sn4Cw@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] platform/x86: asus-wmi: Improve DSTS WMI method
 ID detection
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> > -#define ASUS_WMI_METHODID_DSTS         0x53544344 /* Device STatuS */
> > -#define ASUS_WMI_METHODID_DSTS2                0x53545344 /* Device STatuS #2*/
>
> > +#define ASUS_WMI_METHODID_DSTS         0x53544344 /* Device STatuS (DCTS) */
>
> It's not clear from the description what 'C' stands for.
> Is there any specification which describes the difference and actual
> abbreviations?

The (recent) spec I have here doesn't mention 0x53544344 (DCTS).
However the spec changelog does mention that EEEPC stuff was removed
from the spec a while ago.
The spec does mention 0x53545344 (DSTS), labelled as "Get device status".

For clarity I think the constants could be renamed as
ASUS_WMI_METHODID_DCTS and ASUS_WMI_METHODID_DSTS.

Daniel
