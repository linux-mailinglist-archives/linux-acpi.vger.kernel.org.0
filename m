Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FEF2B2745
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 22:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgKMVnz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 16:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMVny (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2020 16:43:54 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60813C0617A6
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2020 13:43:54 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c20so8733790pfr.8
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2020 13:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xzz/KwQRjDsEwn0F82j4uBqU0/+UAFnbqZBTV8riyPw=;
        b=gVzDyZsDdbO4xbE7eX+ovLhCz+Yndn4lGreK5fBTrDWQMGzwVyPnSmT0Gx+SxmHiZv
         h5fL0PF/nwmsHmr9ovf8miS+dlXX6ytXG8VLS/4t9MOxc6lbMCnl6Dj8FF8bqJ1OdzfD
         2Dh9/mLuhvO1X7alwVfwae+Ogr5479wuTG1xbGyCDwqzYVQSrovBCc2ZLHHNL8sREN31
         AlpnNQrcxnhz9qPKz9kgZ4rixIIXUTkMtgA4tjsFgaju9ZTQxsrB3yP0B7ZFPXTW9OqV
         3BTcV+gN1GMHxRJQU3g3pX2xd65Q5rJ22s3/ywnB5NKrlaC4pzxI1/ptaTIew7CCCGXS
         KYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xzz/KwQRjDsEwn0F82j4uBqU0/+UAFnbqZBTV8riyPw=;
        b=CvrmCWaIOzi+4tfDflUDIFkr+Bi5SjF9AW7nrARe5JpZqHK9KaPnPbebTs2pS5DN36
         U6kfaQBM3Eu5kW5RYkdK+j4mJA/SZ7Jcox7gp9wk5N9KUE52jYh1g7M3Eqe2k8zmwsQh
         qI36QGGcQvtmV4mDfTndJSUUuuGT+6HU8stX+IMU9zHqLwco7zpm99pPs9E8Pkz4g15M
         baq+AOwt/JDs3ZThBXdBWwjPtW5EWbYT9XHuRfZMIiJ0sHR1LtlzEgkUzn0C44NztSNG
         QiEgL/a9aH+ERGHzNglalyx848+OGlMmV5/fYXiBK0+MlR9VFvPBaIGpM8X+oy5kk9W0
         mgYw==
X-Gm-Message-State: AOAM533/OikFhpVWMnUeinCclgTalcRX4IdKY61M7+sZnK1bYaGA9qcF
        YYugWdbv+FflnH7tinunE1/4ZcL4XTGfr6+nJgyWWA==
X-Google-Smtp-Source: ABdhPJx80BG9zG1bcI2SEmtBLxpgDr9apJuSngNNI4cXYp7YiGXu40Go5RwzRJcbNvkAmtCObsciPVXPJlLuaNo+mms=
X-Received: by 2002:a17:90a:4881:: with SMTP id b1mr5095932pjh.32.1605303833660;
 Fri, 13 Nov 2020 13:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20201111021131.822867-1-ndesaulniers@google.com>
 <BYAPR11MB32568FEEF4CFA1C20296427B87E60@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOd=qDNnOu1oTeEN+chvfJcQSS5dxREo0JQHC=W0zhpYeLw@mail.gmail.com> <BYAPR11MB32564DD5B9D140AFE8C3D1EB87E60@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB32564DD5B9D140AFE8C3D1EB87E60@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 13 Nov 2020 13:43:42 -0800
Message-ID: <CAKwvOd=LVMV1sAyv_B84DMA2LRm_4D6b0OAitKdqZ_hxjEN7PA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 13, 2020 at 1:42 PM Moore, Robert <robert.moore@intel.com> wrot=
e:
>
>
>
> -----Original Message-----
> From: Nick Desaulniers <ndesaulniers@google.com>
> Sent: Friday, November 13, 2020 1:33 PM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wys=
ocki@intel.com>; Gustavo A . R . Silva <gustavoars@kernel.org>; clang-built=
-linux@googlegroups.com; Len Brown <lenb@kernel.org>; linux-acpi@vger.kerne=
l.org; devel@acpica.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
>
> On Fri, Nov 13, 2020 at 1:27 PM Moore, Robert <robert.moore@intel.com> wr=
ote:
> >
> >
> >
> > -----Original Message-----
> > From: ndesaulniers via sendgmr
> > <ndesaulniers@ndesaulniers1.mtv.corp.google.com> On Behalf Of Nick
> > Desaulniers
> > Sent: Tuesday, November 10, 2020 6:12 PM
> > To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> > <erik.kaneda@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>; Gustavo A . R . Silva
> > <gustavoars@kernel.org>
> > Cc: clang-built-linux@googlegroups.com; Nick Desaulniers
> > <ndesaulniers@google.com>; Len Brown <lenb@kernel.org>;
> > linux-acpi@vger.kernel.org; devel@acpica.org;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH] ACPICA: fix -Wfallthrough
> >
> > The "fallthrough" pseudo-keyword was added as a portable way to denote =
intentional fallthrough. This code seemed to be using a mix of fallthrough =
comments that GCC recognizes, and some kind of lint marker.
> > I'm guessing that linter hasn't been run in a while from the mixed use =
of the marker vs comments.
> >
> > /*lint -fallthrough */
> >
> > This is the lint marker
>
> Yes; but from my patch, the hunk modifying
> acpi_ex_store_object_to_node() and vsnprintf() seem to indicate that mayb=
e the linter hasn't been run in a while.
>
> Which linter is that?  I'm curious whether I should leave those be, and w=
hether we're going to have an issue between compilers and linters as to whi=
ch line/order these would need to appear on.
>
> It's an old version of PC-Lint, which we don't use anymore.

Ah, ok, I'll remove them then.

+               ACPI_FALLTHROUGH;
                /*lint -fallthrough */

should work to support both, but I'll just remove it. V2 inbound.
Thanks for the feedback!
--=20
Thanks,
~Nick Desaulniers
