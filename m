Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78DE437997
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 17:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhJVPIY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 11:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbhJVPIV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Oct 2021 11:08:21 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7734DC061764;
        Fri, 22 Oct 2021 08:06:03 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b188so5735966iof.8;
        Fri, 22 Oct 2021 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVVsTDUrtPi9axG7J2CY7suNlJkonFS3kBGptu3oqok=;
        b=C+cQsZYJlGFoVA4oVmtk98n2U50j/6jqYzO5QRE3aq2vpW6e5sxSYGm7JbSbtWcDja
         HzTbvDZjqC+5mWTM7a8OcQBICkofjoH9mHyBcAk1JLx5n+IeQmcP2dJfzqjdwZrGq4g9
         rNIiCWIUmTlNKk4DZf06wCZ8Xz3jhDUWsyIINPgDAO/PkopJSscOfnNUzwE+6MCsuXW0
         AgWmFPeplYMLQzMSuZtwx7bcuFjHJyIKUQ7fBuW+IFLQucFoOysfxh4gynjpF+c2TtCi
         JD4tM1GiW3xTEJQgOtZ9Kau2KH47cMcF756zcVfFj0EmDYLMliK+2f6YXUmUOw4MR3E9
         qzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVVsTDUrtPi9axG7J2CY7suNlJkonFS3kBGptu3oqok=;
        b=Gs2t9ZuCB9FjaRpoF3uJm3ARVAWG2ZeuWaECCKydxctPxQAZHbFyYEdDWu68Pi6BeX
         n2Ht9TFJKOBl2PMR7nnhc5FNQXc6Nax3sIdF6EEpp/Cak1lWjLPWOFUI1v5DO+R8fiG1
         bmY+970DWhK6+hspKCDbrN4NKqU9N572lYbf30sL19TdEX3cgrTfM0JrFL/ktwUGyW0e
         0N/8BKskshShibVGqDqmd9veX1WiFaiERUF9g2RUnJyoCsC6ZGD8vrIwN459ZvCDY/rx
         nJLfeKsLShS4b+gR20m/B1XlVjUu7NQjG+lT3v1W+v8aE4/pyWShdaO143ldfldyh4dL
         4KWw==
X-Gm-Message-State: AOAM532/Bx6fTtsKvXgCmkEAgPtfBj1hhiMhURjs8xL6B0KIWLf/FbrQ
        A9RJzNdANl2Xa1gHPsZu1xdiYSdmkEr4mIyECFA=
X-Google-Smtp-Source: ABdhPJy3ZIiQi/5sWqfx1QyzFhNnOkXgVWti4Dkxq2GC7Ba1VEdpWMx4zRepm6UINJvzFoio9JarONE+xtBgJqexSKw=
X-Received: by 2002:a05:6602:15cc:: with SMTP id f12mr88635iow.33.1634915162804;
 Fri, 22 Oct 2021 08:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210917133357.1911092-1-sudeep.holla@arm.com>
 <20211011100949.4ck26vos5apts45e@bogus> <20211021165439.2cgyjjm5bwb6ydbv@bogus>
In-Reply-To: <20211021165439.2cgyjjm5bwb6ydbv@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 22 Oct 2021 10:05:52 -0500
Message-ID: <CABb+yY1xtjnstr432VLk+geuycKWq0BxAoCL7-eN+9wvVZ=t2Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] mailbox: pcc: Add support for PCCT extended PCC subspaces
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 21, 2021 at 11:54 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Jassi,
>
> Gentle ping!
>
I'll pick them.

thanks.
