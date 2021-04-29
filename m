Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC47E36ED9F
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Apr 2021 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhD2PtG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Apr 2021 11:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbhD2PtD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Apr 2021 11:49:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B1FC06138C
        for <linux-acpi@vger.kernel.org>; Thu, 29 Apr 2021 08:48:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so81989pjb.4
        for <linux-acpi@vger.kernel.org>; Thu, 29 Apr 2021 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D4F+wo9iH0mt9UWTRjPeCJ8BBxETi2fl88I2WsDRfN4=;
        b=2C0SbTU/Tq/QYnadPog1MB9i7StPlUxXscyoNeLtxVVz9zAA9AA2ipM6pvS89y2yjG
         NlxM/tfMAtHKTKAKa22B9qr6F/SKzdS5RGrmOWAzsoed2c4FEEwMnRh8gapJlXS3/GPA
         AH9ndB7lgvN+UnSU0mpUaCwFgMtWjzPa0zM2aaZXfeILR5ZRh9qxv0X6RYdYDx+oHVhL
         P0MWluNNkX8Iw9Hl7g8LDdKvFM5kXkeGp/GRDZfZFz+SKNckf+6iqFiN5MrM9G8W96wp
         XcD2XE3/mUVq01WUqP/VT0T0yZrRYXAB9czTxeLbvy7ESVYYO3dp0Y7Yb5qYKxdDNr8o
         0Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D4F+wo9iH0mt9UWTRjPeCJ8BBxETi2fl88I2WsDRfN4=;
        b=icTXB0jXRnaWlnaNmDqmFXfqUgULTF7GKDkdfQHm/YL6gwxv+Y+EOmWVtdPuWOhN35
         s8a5n0wmYgeCwxUxy6OVuo7xy5kpxKho0kRh4kfbe2s5kCgjHL9h4vdN1/oxPMpsYGYF
         +QaL5ZMkcpHCv3AnwiSHLGtlYmsTh6vYVnS7HkPSyo+JTUcdphb9eUObdGT3HtCDhYRm
         YAO4RRNVCUZni4+lQOncK9ftBcwok2G/yaBusW2e5nRDyujyRlk/isbdKDlR9Nhi+rcv
         48JVaBaMc03jQfoYE47M7JGkY8nv9BlPqmLybvek4A9+eJXXRSJe4T0Ft0EUEE2fWYFF
         7WLQ==
X-Gm-Message-State: AOAM533IM9FZIbW6HdWUhGUSl7shWC0GYZG6etIjL0pP0aJ6MC/mk2aW
        +dE+a5JNpdTay13XeLI0R7oNsA==
X-Google-Smtp-Source: ABdhPJzkyNDAEJgLQXBmtqs9eWxmOdsjWnc93NAtJ7wa9BcT2lCIrOrlfV5/iAEAdr/To26qXeLtXQ==
X-Received: by 2002:a17:902:ea8b:b029:ed:3b25:15f7 with SMTP id x11-20020a170902ea8bb02900ed3b2515f7mr238488plb.62.1619711294344;
        Thu, 29 Apr 2021 08:48:14 -0700 (PDT)
Received: from localhost ([2406:7400:73:e1e3:c171:cfac:f6dd:2a24])
        by smtp.gmail.com with ESMTPSA id k17sm2851467pfa.68.2021.04.29.08.48.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Apr 2021 08:48:13 -0700 (PDT)
Date:   Thu, 29 Apr 2021 21:18:08 +0530
From:   B K Karthik <bkkarthik@pesu.pes.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Anupama K Patil <anupamakpatil123@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Leon Romanovsky <leon@kernel.org>,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] MAINTAINERS: mark isapnp as obsolete
Message-ID: <20210429154808.wm4vnozzub3umrp2@burgerking>
References: <20210428110536.edy74gsobkgtd6al@ubuntu>
 <YIrP4TI2T18aH5NG@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wqdaotscv33wsied"
Content-Disposition: inline
In-Reply-To: <YIrP4TI2T18aH5NG@kroah.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--wqdaotscv33wsied
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21/04/29 05:25PM, Greg KH wrote:
> On Wed, Apr 28, 2021 at 04:35:36PM +0530, Anupama K Patil wrote:
> > isapnp code is very old and according to this link
> > https://en.wikipedia.org/wiki/Legacy_Plug_and_Play#Specifications
> > from Wikipedia, even Windows Vista disabled ISA PnP by default.
> >=20
> > This change is in follow up to
> > https://lore.kernel.org/lkml/20210422180322.7wlyg63kv3n2k6id@ubuntu/T/#u
> > and https://lore.kernel.org/lkml/20210424194301.jmsqpycvsm7izbk3@ubuntu=
/T/#u
> >=20
> > Suggested-by: B K Karthik <bkkarthik@pesu.pes.edu>
>=20
> This person should not have suggested this, sorry if you were lead
> astray.  The maintainer is in charge of this type of thing, it's a bit
> rude to try to "force" someone's hand by doing this.  Be careful.

Yes I shouldn't have suggested this change. Sorry for that!
I won't make such a mistake again.

Sorry for wasting your valuable time to everyone cc'ed in this thread.

Karthik

--wqdaotscv33wsied
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEIRwfsurAmIAiSNrGB1QtCt0juC0FAmCK1TgACgkQB1QtCt0j
uC3Nsgv+MD3sv523LR/KwkWZH3AGzVZ+laQHEXa6oVKWjeR+jCVCUu2sWnarEKbZ
n0nTWFkcxyFWVcmy/hHAXXiC0wHlfyEW5x37m1Yyuw9Gjjoohi95vvjyXPeXFHNg
zrem7v304ePz6CJ8hQPx49WeZeg5AoFtRvBKSGzFpfc2Uyiy4YDT63tNQbyRMlVE
gc2aPuwpa53R87p9pxtmcxZli1p3OxTpDLnkPefQvjQXc6U4eFLcUd7ZNFgXAy5i
45t5+mXh3Na7okawEa4ksN9BXsaqet+eJoq88J7vl1zNCXDv8GgHfd76NO0tr6Qo
iLtawjWqFREe22sSQFhUitCQg6OUCOFLHPWNaOO1VjBnFKsmlKSbCT3QcuL+6JFG
GBSHmVhBkP4f4ctNjquTEGh47h9H9sIxuDSc/F/tCOw7uB4mABiEyCs9SZGQMzRc
VedHlmX02ezRwcRjNa0OXhF1Z9e3GNaOwe5La9DppYQwZ10veCtc13vMWqj5CrR9
+7bGSTTW
=jJZu
-----END PGP SIGNATURE-----

--wqdaotscv33wsied--
