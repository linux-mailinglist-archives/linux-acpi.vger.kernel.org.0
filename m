Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7D334AF8D
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Mar 2021 20:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhCZTtB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Mar 2021 15:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCZTs6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Mar 2021 15:48:58 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB3BC0613AA;
        Fri, 26 Mar 2021 12:48:57 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g15so6448410qkl.4;
        Fri, 26 Mar 2021 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=NCmMhjaLh59mi9V5qdM1QgyKr6eET2x+9GpY7eBdWq4=;
        b=YE04xwQMn4fijA+he7HK05MhLDIvf7no7jRjVoe+5qyt/98MFhGbeFyaR26SHfD9y6
         tu5dktDguJM6mCAy1shkPSj0XXWkAx5+e/MtXsiNWdFYI3icgWtByO+npeKYLDYzHw0b
         0LyxVQpsakoGrz+bKJDkNpsMmIhbanAx4Hv/WW4O7j15wwfHauVzha5F7TgJeeFRNBLV
         uStkX625QkiiWuVdZavIsTzkUHra470bihn4ZSjctMqX/llN73xHQ9xeQQnlkDfUdNrQ
         unonxSb36X73kMeor/Flgzvawl/Rfyms1BGIIapXTv7ot1jFffL4QhdsHUK6qbPDPCsH
         PLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=NCmMhjaLh59mi9V5qdM1QgyKr6eET2x+9GpY7eBdWq4=;
        b=AgooAPsG2xjR0bBlUQWufUAgq6Q7jhWKVJ9BdqlWpsQ6yNgAgh9aR74S5YUeD/Tg77
         LxuGlI2xzPTxCcF/VcABgXJDtDnTLN/wujeLlmLw/MPKBolUd/tGEzpjWjLeCJwfvi+r
         2Oq7Z4Bd110086HO24W9Lrp824pKk7sEchBtvU2jPYtyf628qbbGKWn2NnZ2HoLOQvJY
         QclOetG2jYldYsjIurb/ELAn3Tt/dGFJcuai8IDG0IuoBkQG50H3cgfbMhX1v/7kGQ/9
         Xxi+hvbjSMexhy2DbxoVbKIPa+Gh5sTuHTKnbT4diZ3jBEGdweyqv9KTkKp+4l1JCnaA
         rc7w==
X-Gm-Message-State: AOAM531f3g8wcqAMUx1JmP7nmDTkgdNmAwJMX9AYbQB2SlQ1DDLoSU7M
        KruUqCdigj369ATALg3C9Kk=
X-Google-Smtp-Source: ABdhPJyndUebQ8+zESMN+cDg6ihAJCmKC5eXdnFBVeoWoNy/jZfGHIgIMrInKdn9r5m1XEnfaXHs6Q==
X-Received: by 2002:ae9:f444:: with SMTP id z4mr14850230qkl.226.1616788137009;
        Fri, 26 Mar 2021 12:48:57 -0700 (PDT)
Received: from Gentoo ([156.146.58.30])
        by smtp.gmail.com with ESMTPSA id h13sm6314999qtn.26.2021.03.26.12.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:48:56 -0700 (PDT)
Date:   Sat, 27 Mar 2021 01:18:46 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH] ACPICA: Fix a typo
Message-ID: <YF46nvV3yhZ/D1M6@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
References: <20210326001922.4767-1-unixbhaskar@gmail.com>
 <BYAPR11MB325648858A1C06D2E80DF7AE87619@BYAPR11MB3256.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AiiDn/YTYdXoeQja"
Content-Disposition: inline
In-Reply-To: <BYAPR11MB325648858A1C06D2E80DF7AE87619@BYAPR11MB3256.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--AiiDn/YTYdXoeQja
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:56 Fri 26 Mar 2021, Moore, Robert wrote:
>Please make a pull request for this on our github.
>Thanks,
>Bob
>

A pull request for this trivial spelling fix? Kindly be reasonable , it is
just a single spelling fix, had it been many ,the suggestion could stand.

Kindly, also , let me know aren't we  applying patches from the ML , or is
there some specific rule for this project. I might be missing the basic stuff.

Thanks,
Bhaskar
>
>-----Original Message-----
>From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>Sent: Thursday, March 25, 2021 5:19 PM
>To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; lenb@kernel.org; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
>Cc: rdunlap@infradead.org; Bhaskar Chowdhury <unixbhaskar@gmail.com>
>Subject: [PATCH] ACPICA: Fix a typo
>
>
>s/optimzation/optimization/
>
>Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>---
> include/acpi/acoutput.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h index 1538a6853822..1b4c45815695 100644
>--- a/include/acpi/acoutput.h
>+++ b/include/acpi/acoutput.h
>@@ -362,7 +362,7 @@
>  *
>  * A less-safe version of the macros is provided for optional use if the
>  * compiler uses excessive CPU stack (for example, this may happen in the
>- * debug case if code optimzation is disabled.)
>+ * debug case if code optimization is disabled.)
>  */
>
> /* Exit trace helper macro */
>--
>2.26.2
>

--AiiDn/YTYdXoeQja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBeOpoACgkQsjqdtxFL
KRXL7gf+MfqbOjPijQzMXYkFlkKCk/tShTeR3XG1JkAdeHac9T+dw+5jfkrpiihj
AqyO2JV++rtfcA3/fdltt5uqd3QX3wmk03Cvi5UajzBIRb4XYLUb6e6U9/mFXzU2
bWbczuVyzZlxyz6SaAaZFXTeAIIjIe+J+EfzQqgjdacc7tAhZ0yIOnZcf2uiuLh0
22lsfF6/Np9SAcDKIqzrwhBRwu+7i4MdsPLxrRGMzNO8IIdkpTdpM31lUJWjg25B
mdOoK9cQz6LA8sNxT7A7zRjY9fFxzo/s5a4NU1cnsq76xsMWNscmrykACaqXdeer
0OlB4i+ajSDg/ZmWeXgb4dGDLbypNg==
=gZPH
-----END PGP SIGNATURE-----

--AiiDn/YTYdXoeQja--
