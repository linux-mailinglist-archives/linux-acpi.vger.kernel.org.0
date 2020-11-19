Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7702B89FA
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 03:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbgKSCGm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Nov 2020 21:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgKSCGm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2020 21:06:42 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CC0C0613D4
        for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2020 18:06:42 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id q7so2102540qvt.12
        for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2020 18:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccKfW56H4PWGLSjC0LsiNJcR0/vxH+yLXhxLYv0fM10=;
        b=rDU5+I6pfV/cpFPoCHYruTKxc1OUpArWLHBTpwX44EnsntWdNP7pLL/ebBoZsoVGbY
         GyztbDlk2ndtd0rZMuLsmToFvj8GlD22ytPS6vj0lUmZzKsMBJmtQtkDkgX6dSgJy4WS
         xuLb/McJwAMWVFy49HaLh43LP4vJsl+12KJR4uOPU77WJ7+I5lzrIyPfoKtYBwuot25v
         NsSO+Sobt2TJqCTfzPXEXOxcpUHp9wIuVbBzCDm/yA6mG+rHPriYmof9pH6e8F2g3N3S
         wymqm+Og5mCuxNOU9X7ZohZ0mPgRSMnjnsvcovxrsUGR2Q1yxgwujG+wfwT4EDxIjqPo
         WoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccKfW56H4PWGLSjC0LsiNJcR0/vxH+yLXhxLYv0fM10=;
        b=KwPg6EVRcZYd2b1TBCqQv2y94CpKbE9MmdrlJ1YYKsP83+jEt/nJQ7ASJWfXtxQs4q
         JU4FJoJ4zXdhNUgBZkDUDGWuxdHDqPAUITrYESoTojqN768B8cPH54bCIyxonPJIYIoR
         NADwlNHwqy5r2K9L7rIHNKGlXKq69Wv4K+yQc6L0wEPUwvRvMhpBQZ90iV8iH47KFvr0
         pmrWU/fR6uMIU1IOROCJEQs6CVW+cptngAZQO+fbBsLGGBI+jUs4NG1vaKyAFiUs1tgm
         62i9TRrg9S5uGYTJui1EExgj0vhgBfBahFQrJODe/ISErQUpqU5kEKWWB5J7RwcBgFpn
         mWNw==
X-Gm-Message-State: AOAM5308Y1hdapg3B5eL1Lzx5cxVij20oO3CEkDtnPzVt1fCMh9r3FJR
        kCeKFLTX7k36QVcK20EWKWK6bLTMDHjjzDdbRcyEGA==
X-Google-Smtp-Source: ABdhPJydAOOGYkEH//Rv4uY6EQ0za+qOAE0menANWzPkoy7vb2aGs+AHfwWpmp2vsHVsLEFb3E3oYqrsw6jHynE16DU=
X-Received: by 2002:a0c:e8c8:: with SMTP id m8mr8228752qvo.41.1605751601185;
 Wed, 18 Nov 2020 18:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20201118084117.1937-1-thunder.leizhen@huawei.com>
 <9b8310ed-e93f-e708-eefa-520701e6d044@huawei.com> <CAPcyv4hc0bw=+HQ-Zj0AWfB2-xMEEC--64zNxBkyapkiQRVVdg@mail.gmail.com>
 <390a0fb5-5feb-527c-b90e-1c7b6ea65d5f@huawei.com>
In-Reply-To: <390a0fb5-5feb-527c-b90e-1c7b6ea65d5f@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Nov 2020 18:06:30 -0800
Message-ID: <CAPcyv4h0To2N1QrofE6qddeuQPBH3Umh9e+emBv-Nej4gS4V+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI/nfit: correct the badrange to be reported in nfit_handle_mce()
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 18, 2020 at 5:53 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/11/19 3:16, Dan Williams wrote:
> > On Wed, Nov 18, 2020 at 12:55 AM Leizhen (ThunderTown)
> > <thunder.leizhen@huawei.com> wrote:
> >>
> >>
> >>
> >> On 2020/11/18 16:41, Zhen Lei wrote:
> >>> The badrange to be reported should always cover mce->addr.
> >> Maybe I should change this description to:
> >> Make sure the badrange to be reported can always cover mce->addr.
> >
> > Yes, I like that better. Can you also say a bit more about how you
> > found this bug? As far as I can see this looks like -stable material.
>
> I found it when I was learning the code. I'm looking at it carefully.

Ok, good eye.

The impact of this one is somewhat mitigated by the fact that errors
are expanded to 512 byte blast radius, and error consumption maps 4k
around errors. I suspect few are trying to use the badblock list to do
fine grained recovery so this bug went unnoticed.
