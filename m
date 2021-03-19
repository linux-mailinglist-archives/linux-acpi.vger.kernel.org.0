Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247403421F8
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 17:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhCSQdk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 12:33:40 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39849 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCSQdk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 12:33:40 -0400
Received: by mail-ot1-f48.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so9097740ote.6;
        Fri, 19 Mar 2021 09:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTTDsfCnwE/UlPHmkrKO/4B15PlJYD/cBG8z+cd3Hsk=;
        b=TT7MFQvPLnOpLfBktvLKnYs8PpUxE0BUgYTXQBrXC3SyUOLOWJiZR0dBANCFwTHQjh
         i1R11AEWNxcj3Xvd5v/PwM6IyrahMfzUDfg2MKZviqjUqTOkv5yyT9XrpVtmuDWsuJ9I
         krgunmIYAmgCcbbIJlKOvsS7mxjOHRmh0OBCtNjvHcvG5tdn0LTyzyFYxj6lNr3h296h
         X9fkn8SvtYmucVvPuuHRFLHQqfirIudfiM613rtwKFDlgs32pcZSc0DcLpieFuRqzG8G
         L7Wicly8nLVvBO2nhVzjGPxXP+OPCFR7wYgNgpLTk4o7C/RCQavMBOPXxgMZTCk4jx25
         MnHA==
X-Gm-Message-State: AOAM530AULA0otPFcUHFV5c4MbggQZoysMcqGExa7IGo2sh9RgPYT0UM
        pXzDMdQeCdtfxC1aZgCoPAp8DCY71KBakDbmOm/x7bU/
X-Google-Smtp-Source: ABdhPJxo9ibekhIRsbHdobKGANRCDgumEJVtclwVzMhodcUzqa2UlJxFCB96TnGrkRDDy55qB+LRwsmA3hIWWOM2wzU=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr1828711otf.206.1616171619493;
 Fri, 19 Mar 2021 09:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210317050641.4158096-1-unixbhaskar@gmail.com> <859a36ad-f9c6-942d-770e-e9e0306d34e4@infradead.org>
In-Reply-To: <859a36ad-f9c6-942d-770e-e9e0306d34e4@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 17:33:28 +0100
Message-ID: <CAJZ5v0j8x2FF6rEuZFUaokzPigPpxD6u0Cu2JK7Au3mj5d=93w@mail.gmail.com>
Subject: Re: [PATCH] include: acpi: A typo fix in the file cppc_acpi.h
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 17, 2021 at 6:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 3/16/21 10:06 PM, Bhaskar Chowdhury wrote:
> >
> > s/folowing/following/
> >
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> > ---
> >  include/acpi/cppc_acpi.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> > index c7fc4524e151..d174721bab33 100644
> > --- a/include/acpi/cppc_acpi.h
> > +++ b/include/acpi/cppc_acpi.h
> > @@ -31,7 +31,7 @@
> >  #define      CMD_READ 0
> >  #define      CMD_WRITE 1
> >
> > -/* Each register has the folowing format. */
> > +/* Each register has the following format. */
> >  struct cpc_reg {
> >       u8 descriptor;
> >       u16 length;
> > --

Applied as 5.13 material with a minor edit in the subject, thanks!
