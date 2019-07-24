Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B540673010
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2019 15:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGXNkI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Jul 2019 09:40:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35773 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfGXNkI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jul 2019 09:40:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so33792418qke.2
        for <linux-acpi@vger.kernel.org>; Wed, 24 Jul 2019 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5XZ9K/SwxKdddKyC7k0SqQ29rr6lzsU+b9jBDeXxEMs=;
        b=GFq+S6tSW8wwIf68Zbp/TAZ8HwcvghPgo5lr601U6nGjYYLU4vUEoK8MiMlLTogQeQ
         aqQwsqTVuzqYmqBLXu+koBwO1c914nYOScc6gEaaKY/yZT3LkLOc/GEqr96Sod+QEDg2
         PW7wUg7bT8yYKBnB6bAM3cLanp5IODh+LnSokpOEak5aND0qZJrhkFKk1rdUOshFHDRG
         DYbNeLQV4cuix1guUVumwX3vX+OrmHjY+Ff+tbP3heoLVLaEtVYLiDwSkjP80XfZLnGL
         wDQWGxbQrMbozIzW+SP/iXxGwMlld9WyuaEf1kef6lM292fuY5ToZdDvi8lOJvAWlR9j
         1OJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5XZ9K/SwxKdddKyC7k0SqQ29rr6lzsU+b9jBDeXxEMs=;
        b=es048qSJrXdwPS2+gZyWgDz6Sdf7CV/IwysJaapECmN9YLJ/rzTdMsLvFILMdufJ1o
         WzSpgjIAiYMJIq58ZC+6Z+40RX924Y2MsVllBGDN1r1Y4Hctw4lKY2foIKPOSfTWE2qT
         ZYgEKBMWcnEdB5wKtPHoWWTcEwnxqRB7+caW3LRutMfw3PELY16R+6ycpBWBOuly0sCH
         UokFnFoKVy9ckK7LB4pdL+Z5Mxok8gz1sq0XL1YLvHJ1Ds/LEl6Waubi5P1gQdjt2H+K
         mdQyR5p2Pri2F0n0mZM7ntgfZwWyZt3Eo/nd5DaLJBWSN4t57jn7UydEaayv2l+Nxiq2
         15Lw==
X-Gm-Message-State: APjAAAU+upTfY+nfzC1R9myFlrwbpY2pxu06tTHu1lVW8tHPzXBfguCy
        o0dxof1EmeqmMCP7Ra7ToRPyrw==
X-Google-Smtp-Source: APXvYqzUVvLNfaBc8+WcDpyR5QEO2g6mbdd9uJSw4aZ3wmPrlXd92pON1JtRJLfphbEp7hMfagnfXw==
X-Received: by 2002:a37:484a:: with SMTP id v71mr53222506qka.29.1563975607570;
        Wed, 24 Jul 2019 06:40:07 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f133sm22561094qke.62.2019.07.24.06.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 06:40:06 -0700 (PDT)
Message-ID: <1563975605.11067.8.camel@lca.pw>
Subject: Re: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings
From:   Qian Cai <cai@lca.pw>
To:     "Moore, Robert" <robert.moore@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "jkim@freebsd.org" <jkim@freebsd.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Jul 2019 09:40:05 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661869@ORSMSX110.amr.corp.intel.com>
References: <20190717033807.1207-1-cai@lca.pw>
         <CAKwvOdmPX2DsUawcA0SzaFacjz==ACcfD8yDsbaS4eP4Es=Wzw@mail.gmail.com>
         <73A4565B-837B-4E13-8B72-63F69BF408E7@lca.pw>
         <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661869@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2019-07-23 at 20:49 +0000, Moore, Robert wrote:
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > ---
> > > include/acpi/actypes.h | 4 ++--
> > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index 
> > > ad6892a24015..25b4a32da177 100644
> > > --- a/include/acpi/actypes.h
> > > +++ b/include/acpi/actypes.h
> > > @@ -500,13 +500,13 @@ typedef u64 acpi_integer;
> > > 
> > > #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
> > > #define ACPI_CAST_INDIRECT_PTR(t, p)    ((t **) (acpi_uintptr_t) (p))
> > > -#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR
> > > (u8, (a)) + (acpi_size)(b)))
> > > +#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (a) +
> > > (acpi_size)(b))
> 
> We have some questions concerning this change. If (a) is not cast to a u8, the
> addition will be in whatever units are appropriate for (a) i.e., the type of
> (a). However, we want ACPI_ADD_PTR (And ACPI_SUB_PTR) to simply perform a byte
> addition or subtraction - thus the cast to u8. I believe that is the original
> thinking behind the macros.

I posted a v2 a while ago, and should clear this concern.

> 
> > > #define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR
> > > (u8, (a)) - (acpi_size)(b)))
> > > #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8,
> > > (a)) - ACPI_CAST_PTR (u8, (b))))
> > > 
> > > /* Pointer/Integer type conversions */
> > > 
> > > -#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0,
> > > (acpi_size) (i))
> > > +#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, 0,
> > > (acpi_size) (i))
> > 
> > IIUC, these are adding `i` to NULL (or (void*)0)? X + 0 == X ?
> > --
> > Thanks,
> > ~Nick Desaulniers
> 
> 
