Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED644494B7
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 00:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfFQWB6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jun 2019 18:01:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39461 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfFQWB5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jun 2019 18:01:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so8480587otq.6
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jun 2019 15:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2PE7TOFccYt/EkA/7nc8NvN2+5v+roqzU7q5XwI6eA=;
        b=uChUdWARJq+0gWRdeWBM7H6GJ811KmdnXKttKI8Ui7DC9xVu2Isb3csleh8x7UWUv1
         43h5kr7oP10aepP1OmIRciOiY3UlaWXhiTZzuZgsjlIGyak5dVeznNok1xhFlUdcieOp
         7BQSgcfu1KdQO4NA1xXsz+v31JxCvT7vsIGAINjA9QnySUV1mCaVtJr/TmbyoXp9qznW
         IVxRBH7T6Dto//2D3kHW9bSzaB4qfji8xI952/YWuHVrsZqz6djq5FqPYg9Y4xrxW83B
         LtQrcVXj3Z3/XQC8Q1xjeSbxo/PSwHo4hvfbOm0jvDx/WSJyjKthzPJQFZwMhIWDcBMz
         LCVA==
X-Gm-Message-State: APjAAAUXcXSA6ialZ5AASz2bdv3L9/0ypsjHZj+4X9v38nS2/4GZq2f0
        Z20B2HYWEL5AjvmTVuhNelzmJdn3OWaIWSbIWHk=
X-Google-Smtp-Source: APXvYqwGGsw+ZQ+t2RcJlypM1e1rJbQQYtbUOEIDDzhSXlIRjPQ+mdTdLenVn40Qqc+ORNJn0Zk+xZahjBPnyMaKR/k=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr37515822oto.118.1560808917168;
 Mon, 17 Jun 2019 15:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <1560769335-62944-1-git-send-email-guohanjun@huawei.com>
 <CAJZ5v0jyi-ZkcDU=+GJm5LxMGX36ce=a_j169A_7Ph2AG8_C+w@mail.gmail.com> <20190617173449.4vhgdvllwxo24ovj@willie-the-truck>
In-Reply-To: <20190617173449.4vhgdvllwxo24ovj@willie-the-truck>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Jun 2019 00:01:45 +0200
Message-ID: <CAJZ5v0gKWAWRTBmFh+9Pdwc85p4B571w2qia7T6BgF5B6s_KcA@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update my email address
To:     Will Deacon <will@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 17, 2019 at 7:34 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 01:11:40PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 17, 2019 at 1:04 PM Hanjun Guo <guohanjun@huawei.com> wrote:
> > >
> > > The @linaro.org address is not working and bonucing, so update the
> > > references.
> > >
> > > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> >
> > How do you want this to go it, via ARM or ACPI?
>
> I've already got a MAINTAINERS update queued to send out later this week, so
> I can easily pick this up if you're ok with it?

Sure, please do!

Thanks!
