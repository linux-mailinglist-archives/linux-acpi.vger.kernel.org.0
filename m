Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE3026CB4D
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 22:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgIPUZS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 16:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgIPR1i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2020 13:27:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC803C061A31;
        Wed, 16 Sep 2020 10:27:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w7so4391897pfi.4;
        Wed, 16 Sep 2020 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bO4fdTifCbsbsP2IhleoA3vXtN6f7O4IH+1Jq/pjP2k=;
        b=mO3hFUu0GImd1goVrECVXRGIa0A8Nm7b9YstEMyUy8lPWHap5IhmPgzQdgHDmKtbN+
         QHsTFedtEIZGDZjqTUgKubnI1I2KfPECFPWoaEMQNE/lbDf2AMyaEbqmTeUS6i0Z/6sX
         oq0KJ5zBXXuKr4u7PE48vB+5DyAvA6MExJuy5wZgqzFpvIeP9K5iRUM+Frq8ThmToIpq
         eD1pYVlgnptoaIslvMaWfGHaLUDvVokcjwvyGUBJoOBWeJHbHRNblVXVmRLkcEf4ZRrf
         qqZ9fuRkK6kRhglgrUp9jB0BZ0p0lm/mhSl8JWxGW9sDlJwJktME3bKWZQfVW+ZQBLhQ
         fbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bO4fdTifCbsbsP2IhleoA3vXtN6f7O4IH+1Jq/pjP2k=;
        b=ZHQN1q6cGrxRCllzwweBFQt2x09SfaiPODivx/EBdzczwue9tRgGs3k7/gz/QIeeck
         nAA8pj6z0j2Gh7DuEqaGrYTYADV/nvD/+j/ioRFJol/X5UMRUGZTvS4Ei7m1dRnsrRhq
         bghbYfC+APCUX0YTDhPtETaUKoyV7UrvapwNHpS8cq8760FPR3PxyOt5SqrfgsANOxlX
         ynNLH3LtMK4RFxWh62EDP2AQQBAQEIs0KMcH+nuaEG6hr55EQ+JTYeX0sZDjAe4EpKzi
         nFozUnln0h73/sXW+v+075RtIEnV9FEqP6PvqsPkz0W463OV81UJfB1eTK784DfMcWUE
         WqEQ==
X-Gm-Message-State: AOAM5321uTAKKy/uAJ5So0nx9pdcMDPJXi/8UvaFtfkoitfUmlgmy9Hx
        c9r+LGMHiX+KR393HlNmoXLWE8BKA21oL9H6AKs=
X-Google-Smtp-Source: ABdhPJyTOQigECECSyGp9bnw5Ai8y2TsU/ceVs5PMCCP/LIJ3wf9n8JCo7zbCa78DwkerSAMOsFtSmCXxvdlMB0zy74=
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr18735528pgj.74.1600277235025;
 Wed, 16 Sep 2020 10:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200910211520.1490626-1-luzmaximilian@gmail.com> <EMZQgUl1xLN4o0hV9ZkCD563O85SuOYB5kNFZ5_hlxLQXbJCXpQfrM2afyFIr28h31tXMxD1mxE4DkA5Wy60A0Z2mDnstwF17tEdnX4IRas=@protonmail.com>
In-Reply-To: <EMZQgUl1xLN4o0hV9ZkCD563O85SuOYB5kNFZ5_hlxLQXbJCXpQfrM2afyFIr28h31tXMxD1mxE4DkA5Wy60A0Z2mDnstwF17tEdnX4IRas=@protonmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Sep 2020 20:26:56 +0300
Message-ID: <CAHp75Ve8jaYsecsQjuojrihyoVsYr7G011drmXN7q9yzt_tMnQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: Add Driver to set up lid GPEs on MS
 Surface device
To:     =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 16, 2020 at 2:58 AM Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.=
com> wrote:

...

> > +             dev_err(dev, "failed to set GPE wake mask: %d\n", status)=
;
>
> I'm not sure if it's technically safe to print acpi_status with the %d fo=
rmat
> specifier since 'acpi_status' is defined as 'u32' at the moment.
>  func("%lu", (unsigned long) status)
> would be safer.

Please, no explicit castings for printf(). In 99% cases it means that
something is not being used correctly.





--=20
With Best Regards,
Andy Shevchenko
