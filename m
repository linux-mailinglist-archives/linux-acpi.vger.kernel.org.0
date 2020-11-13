Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D97D2B1703
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 09:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKMIOO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 03:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgKMION (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2020 03:14:13 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FC9C0613D1;
        Fri, 13 Nov 2020 00:14:13 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id k65so7945844ybk.5;
        Fri, 13 Nov 2020 00:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGuhm4DDjXM82cBc9tqmhMIUTIMqD4s7kPGRRYpiNzs=;
        b=c8RAUBDE+Ue238rSIJCCf0RauNJZQw6t3/5DlvGEEH6NFjNfN6fDHyp9CBtDsYFTQp
         h+OLaJ/8g4gqbVfYSggv/SBfuai8Cfx82NszN51c9Tgk+P0WZq60m6WPGnZqmXa/GC9L
         rwhuRIAjOKV0PkuMAXcluJJ8dScjXuEuvlEs3srm4rqF95lylht9Vc3oh7XxZc2iuCH+
         3cjvXWK6rRX0Baheu7alF6T2Shg03TcMANdty6950EO31MV1tlMdLl8EX5qCHzcMfcy5
         qb5ELBGIGLznYjyfjpo6/sbmy5FTt1zxBbMgpI+vTpe9ALQxcBB5KysZe3husQrmiZKh
         /48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGuhm4DDjXM82cBc9tqmhMIUTIMqD4s7kPGRRYpiNzs=;
        b=L3alAlm2ZMXHWH94R9vapSuWSSbH0EVuWoRRnG7DfXJQS+092kDEjhfapgI6p5hnrB
         kD86Ckh81/PZVxjkpTORrrVQRfwExNuZknXwXHrNGJdKWa1Y0mltOv4z+UjwU7Ai4vUa
         1LguiHFjQcwV8svNRnSS/XR39gnv5jCsJW5Ylpw/22eFM4vKyfZtLFxTGxTeJ7bTMRCI
         i1FDe1WIqfrRBlLu1i9oImKX5hQCm7l3F26gsZ4NLLibX9NPoijjMuIIKstEzUQ4AZTK
         2EN7g+OmerNKWV2hWtVDiV/NyO8cM1A/SEaQf5NkKwLsLn/UFnqSwk/3DmOqnop3wQYm
         oKBw==
X-Gm-Message-State: AOAM53239Fx963sN2NODmUR9dlOEvmkPZK47eHYhpJBqeE9na4nF+8an
        w2m8Wz7Fm7OqFBJkQbeP9c0p1JEMy3dCEE7DlIk=
X-Google-Smtp-Source: ABdhPJy8TyFXL7XZ3U447iEAI04X21uq6utlKB5gB8S8IpKtxbhOpTXbu1mpRzeii2G3o/I1H6GKbLOZAAC73Np2vPM=
X-Received: by 2002:a25:338b:: with SMTP id z133mr1271346ybz.33.1605255252936;
 Fri, 13 Nov 2020 00:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20201111021131.822867-1-ndesaulniers@google.com>
 <BYAPR11MB3256E0C1DCB4F01D18DF709F87E80@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdk2U5+DcXYyMoBAhyaa67EukhB6QMEUbRPcOF7P3Sz21w@mail.gmail.com>
 <BYAPR11MB3256C9711620932685C368F887E70@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdnu07S8ZtGVe0eVFP=6hLSRa58EtDYOJUK_zGWFaqUboA@mail.gmail.com>
 <BYAPR11MB3256BEF30840D4AB440A359C87E70@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOdnYpmf=ydFVWSqVkWeUpn+M2v9PfdQd71T3oqQ9_1WQaQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnYpmf=ydFVWSqVkWeUpn+M2v9PfdQd71T3oqQ9_1WQaQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 13 Nov 2020 09:14:01 +0100
Message-ID: <CANiq72k13K_zA5aH5hameoe4TSf2o5cA294bA4UEZG0M6S3DXQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Moore, Robert" <robert.moore@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 13, 2020 at 1:09 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Thank you for the explicit diagnostics observed.  Something fishy is
> going on though, https://godbolt.org/z/Gbxbxa is how I expect MSVC to
> handle include/linux/compiler_attributes.h.
>
> The C preprocessor should make it such that MSVC never sees
> `__attribute__` or `__fallthrough__`; that it does begs the question.
> That would seem to imply that `#if __has_attribute(__fallthrough__)`
> somehow evaluates to true on MSVC, but my godbolt link shows it does
> not.
>
> Could the upstream ACPICA project be #define'ing something that could
> be altering this? (Or not #define'ing something?)
>
> Worst case, we could do as Joe Perches suggested and disable
> -Wfallthrough for drivers/acpi/acpica/.

I agree, something is fishy. MSVC has several flags for conformance
and extensions support, including two full C preprocessors in newer
versions; which means we might be missing something, but I don't see
how the code in compiler_attributes.h could be confusing MSVC even in
older non-conforming versions.

Cheers,
Miguel
