Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0AB0FF588
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Nov 2019 21:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfKPUpf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Nov 2019 15:45:35 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:36064 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfKPUpf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Nov 2019 15:45:35 -0500
Received: by mail-ot1-f47.google.com with SMTP id f10so11103953oto.3
        for <linux-acpi@vger.kernel.org>; Sat, 16 Nov 2019 12:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dZwnfQgOqTIKiwRnj4r9Zker73mZIhEC1hZOmrCLBY=;
        b=P2n5ewmAguqGNxt28KAgF0903BwywKKX71aXiOgk8/c0eldQ2jXd+vpyikAxMbFuwa
         cgkfCGt55N4UizeGQE740p+dLfFqfdvMTxR8RHHcY9B2xt9htdDU4c8Dan1gWbNj1K1j
         Q/78fhEUiImeG9rQ84yjekUFxTYhA5QfSQNDe7znRxL5wBVhdZEgLeo3vpJbpqPlZ0Yu
         VD2gAunlUhaLDpT65i+5Sx5ZVmbUNRXT9B29hH09QeA91wpG0f+RsdYtzZL+dZSCy6XV
         e06bX98qpXzWtB8hrOTk6z5yzcy4QqR0E7/mPnGv9s2FGHqwB8LRMVq4Aq64tRu5C77C
         TVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dZwnfQgOqTIKiwRnj4r9Zker73mZIhEC1hZOmrCLBY=;
        b=SGCzBM+MHK02d8hxKCVvL4nNpgt2fsdZF/sDkKmUP6i2XBIkjPDuR/GXj8zJtk9eEt
         O1ZQEdWwRAYFWvj0MOKB6quqRShxt3AB0LL6MT8ieb/Xf46cC7W1rxQlOtrjL86q871g
         6iSIRyI7rHfuGf9JnIIROCLyGnwWRvLPaNUZZh5dAZjClH+GosaY8+EnpkEE7MdMbO4m
         04ZOi9PGFj5es+YvtpGYRWWeB3y9BbgvfWbFWroXJv2QBNeG3DxMqgTjXFezmRLy0acd
         Dhe6IZIOqEtBjeTgwxD5FnpJMLSjs3HN7uwdgsX/HKfhTLX2+K5U+QtujTeSt3eZ2UkG
         iSmA==
X-Gm-Message-State: APjAAAXm/cBGr52j27DyS26Dt1cs+EVZ8vpS6up6+27yNaWXazQuPKPr
        BiH7EY1KmyuRv1um2eUWLggZ2u8NqzikXWOsj2ZT0g==
X-Google-Smtp-Source: APXvYqw/01RAS5kPKwQvBvbyIGf6pNqFTax9GSBdKiLyr9qfJ555nkMjEqS9rdk3Ii2GR4w3V4jwlChgzmNvsgnybsY=
X-Received: by 2002:a9d:30c8:: with SMTP id r8mr17204216otg.363.1573937133999;
 Sat, 16 Nov 2019 12:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20191004114330.104746-1-Jonathan.Cameron@huawei.com>
 <20191004114330.104746-2-Jonathan.Cameron@huawei.com> <CAPcyv4jZG-5s6NsS-_-oNG45y0Qb1mVD_s8cCGqLYtzvHqEo+Q@mail.gmail.com>
 <20191113094742.00000dc4@huawei.com> <77b6a6e8-9d44-1e1c-3bf0-a8d04833598d@intel.com>
 <20191113174845.000009d3@huawei.com> <CAPcyv4g5xUBp871+T26+se8WH9154g7V81qsToYAbXAALMuhKQ@mail.gmail.com>
 <20191114112504.00005b61@huawei.com>
In-Reply-To: <20191114112504.00005b61@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 16 Nov 2019 12:45:23 -0800
Message-ID: <CAPcyv4jrXvPOvoBCW8H42_og1wJ_t9_=5N4C7-OugYyNzdqBLA@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] ACPI: Support Generic Initiator only domains
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Tao Xu <tao3.xu@intel.com>, Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, Keith Busch <keith.busch@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linuxarm <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 14, 2019 at 3:27 AM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
[..]
> Hi Dan,
>
> Agreed that it makes sense to expand how we describe these cases a bit.
> To make sure I've understood correctly let me paraphrase what you
> are proposing (and tweak it a bit ;)
>
> Assuming for this purpose we don't put GIs in CPU nodes as that makes
> for really fiddly explanation. In reality the code will need to handle
> that.
>
> 1) Leave access0 as it currently is with this series - so continue to
>    not distinguish between CPU nodes and Generic Initator containing ones?

Yes, but with the caveat that I think 2) also needs to be part of the
series before it goes upstream. I.e. don't regress the amount of
default information just because a generic initiator is present.

> 2) Add access 1 which is effectively access0 ignoring Generic Initiators?

Effectively yes, but I'd say it differently. Always display the access
class for the local initiator as defined by the HMAT as access0, but
also include the "local" cpu node.

> My feeling is that any existing users of access0 are definitely not going
> to be expecting generic initiators, so we might want to do this the other
> way around. access0 is only CPUs and memory, access1 is including
> generic initiators.  If there are no GIs don't expose access1 at all?

There are no consumers of the information that I know of, so I do not
see the risk of regression.

> For now we could simply block the GI visibility in access0 and deal
> with access1 as a separate series.  I suspect we will get push back
> as there are no known users of our new access1 so it may take a while
> to prove utility and get it accepted.

The problem is that HMAT gives an unequivocal answer for "local"
because it lists it in the table explicitly. Everything else is a
subjective determination from parsing the performance data and picking
a metric. If access0 is a GI, then let sysfs just reflect that truth.
