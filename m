Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039762D821D
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Dec 2020 23:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406918AbgLKWbP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Dec 2020 17:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406943AbgLKWbN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2020 17:31:13 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50E6C0613CF
        for <linux-acpi@vger.kernel.org>; Fri, 11 Dec 2020 14:30:32 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id l14so9489788ybq.3
        for <linux-acpi@vger.kernel.org>; Fri, 11 Dec 2020 14:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DP4u3vyOK1sWRkeFBHWzyC0Qo+Tg4a0hdWg9PLXt3LI=;
        b=dQ+wUD6qOEbwif75TWsTM+enWTSOPm3SNDSssvHnd0zoAJo1h7QfGOOoD9syKnkLVl
         C27SrGgxPVqok7to50/jRSkqMmigLyVJ20yuhqtreHsjd9pPRkV7fJG3ksl1tlEBU0qv
         72q2WYPDiMk3NFLxaHWu0hykAN8QuyjAWDOVTrTGBZa27IZf4OWtQOFJpkaGcqmTkpum
         u+COznp6nvTukB//0hKmDAim1qAaV7Lr7QpNlnZXCjXm54type681d1kg/EjrrGwXUea
         ZxxlI/o2703XOzBWDWdewwdgCimXj/sCvoilcoN/rQp7Nrb0SYX6WNuQO+8BGsQeCbv7
         yXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DP4u3vyOK1sWRkeFBHWzyC0Qo+Tg4a0hdWg9PLXt3LI=;
        b=Y9KFbVE8Tno8M0vF3EPuEaVAKHOpiyWB3/k59etll/yuLSAiMJd5DMcNkWMqAPNnS9
         Nf6G/eU+QMyv7LExtAKt/A7Ceo0Ngh1nSxZUarhqN6r4OTqewd/W12XuB/H3z+ufPTP3
         Yk3CG3Ooxevw+pMASzokW2BoDsW+lOEmSewmXH9FW8y0vroCAfjFbJRRmqyLn9zYJH13
         N9LkEea3SyXGtLppOtOtQsuMUPAOGxFKHFwc6y3cKUyWsRQnjiCTXKrtdtnVn3yCCHeH
         46RVabr5bhsha/7pgcXkfuxkmFC4VVUYlkUXHLLe++1T99S3JYrmtH4g3E6GDM0N56p2
         LlMw==
X-Gm-Message-State: AOAM532Bz8itIK/iyuf21fuBGOEvY/2XGt+9WDXOMGwx5VJkirtsJ/NT
        3JBeQ3UGq9UrSRdVEdGAdJEZE7xidqub4INzuSZD9w==
X-Google-Smtp-Source: ABdhPJwi1KxiLbsYZDLOGSqH5Ut1oteRY1ce66tvlhetU1GnU1dasj0j9yrAzoEUGAb6ZstqFJ/R8Ja8XFgNVbOXVFA=
X-Received: by 2002:a5b:b49:: with SMTP id b9mr20504737ybr.310.1607725831810;
 Fri, 11 Dec 2020 14:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com> <20201121020232.908850-17-saravanak@google.com>
 <02e7047071f0b54b046ac472adeeb3fafabc643c.camel@redhat.com>
 <788ee1c7-0ea2-33ec-658e-50707f7515a6@arm.com> <CAGETcx-MsNyWWT=s1H6hDK+=QvibBLQrT9rM51y5bkomV_+G6g@mail.gmail.com>
 <813b3fbd80ad4dfee7ff8517d4829a1f@kernel.org> <CAGETcx_hPVv1iTt6q3gLmBN=q+_O6vTwxeS5Nj55Smm3FNk24Q@mail.gmail.com>
 <caf7719771210fb91565d105bd9c7e4b@kernel.org>
In-Reply-To: <caf7719771210fb91565d105bd9c7e4b@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 11 Dec 2020 14:29:55 -0800
Message-ID: <CAGETcx8Fjr-0S5kjUxYytncgQ9ZtMoeey_P680R6RPFk7-haZQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] driver core: Refactor fw_devlink feature
To:     Marc Zyngier <maz@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Qian Cai <qcai@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 11, 2020 at 11:07 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-12-11 18:20, Saravana Kannan wrote:
>
> > Lol, my only contribution to the patch will be the commit text. I'll
> > send them with reported-by, suggested-by and tested-by if no one less
> > beats me to it.
>
> Teamwork!
>
>          M.

Forgot to CC most of the folks/lists here, but patch has been sent.

https://lore.kernel.org/lkml/20201211202629.2164655-1-saravanak@google.com/

-Saravana
