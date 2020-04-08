Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEB31A220D
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Apr 2020 14:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgDHMab (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Apr 2020 08:30:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41670 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgDHMab (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Apr 2020 08:30:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so4501066oia.8
        for <linux-acpi@vger.kernel.org>; Wed, 08 Apr 2020 05:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQpK9ks72bhXc63XjAFmwTmV2lwditIh25ndruA4cyk=;
        b=omkiSxEu1V+K21HlYl4/+Fs/L6c2bJB6rSpYU+mHLZft38Mx3C3EmUWXW8pTNymDx1
         X9OvRgFOYPEKhjnjJ2mxgCh1hfik5zgjfYhXkyDTtYb8jIelznI5i/WuEmqDR1zbif9u
         0iMT8h05JFPy7ToDhUojH+981huFnTO3EXKOZ69GfPAyzzh4m0IbuJ2KExq7wae2crY6
         NIqzBRgVzNrrXy78xP3b9sArYz+BUfK7oqLegXVaXQVs807UMGMwQwuJfhK5ToJbPQTL
         8hQZDTrknLr5Vly75/GpSLbjwdgIqcPXa28J4ja95zKBM9jSWyiVSz3kgo7+ATqtneTk
         WWEg==
X-Gm-Message-State: AGi0Pub36HhgsUJp31I/5iME3RvRpxM3tt9WQsczz3a4l9Dw0T+BxNey
        tgqJVlXIH/Pt6N3qH5zBczbNWwZ/SKO+tK/st8e4ZQ==
X-Google-Smtp-Source: APiQypJ1bPB1QJM1W8VZFRscJG+2BeJyhiCzijWlDopVu9SQS5DlTU79fJ8dZ6jCcf5ulH+JyUA6MheCSnp5jeWNDmQ=
X-Received: by 2002:aca:f07:: with SMTP id 7mr2171898oip.68.1586349030721;
 Wed, 08 Apr 2020 05:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200406140122.21514-1-vilhelm@prytznet.se>
In-Reply-To: <20200406140122.21514-1-vilhelm@prytznet.se>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Apr 2020 14:30:19 +0200
Message-ID: <CAJZ5v0i0nRAC2eitRKia3e59qZAsH+Vxn7aoMxtD3E2OHkzEXA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: firmware-guide: ACPI: fix table in namespace.rst
To:     Vilhelm Prytz <vilhelm@prytznet.se>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 6, 2020 at 4:01 PM Vilhelm Prytz <vilhelm@prytznet.se> wrote:
>
> Fixed the alignment in the ACPI block diagram (RST table) by adding missing spaces
>
> Signed-off-by: Vilhelm Prytz <vilhelm@prytznet.se>
> ---
>  Documentation/firmware-guide/acpi/namespace.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/namespace.rst b/Documentation/firmware-guide/acpi/namespace.rst
> index 3eb763d6656d..6193582a2204 100644
> --- a/Documentation/firmware-guide/acpi/namespace.rst
> +++ b/Documentation/firmware-guide/acpi/namespace.rst
> @@ -56,13 +56,13 @@ are illustrated in the following diagram::
>                    +- - - -+                  |  +-------------------| |
>                    | Entry | - - - - - - - -+ |  | Definition Blocks | |
>                    +- - - -+                | |  +-------------------+ |
> -                                          | |  +- - - - - - - - - -+ |
> -                                          +-|->|       SSDT        | |
> +                                           | |  +- - - - - - - - - -+ |
> +                                           +-|->|       SSDT        | |
>                                               |  +-------------------+ |
>                                               |  | Definition Blocks | |
>                                               |  +- - - - - - - - - -+ |
>                                               +------------------------+
> -                                                         |
> +                                                          |
>                                               OSPM Loading |
>                                                           \|/
>                                                     +----------------+
> --

Applied as 5.7-rc material, thanks!
