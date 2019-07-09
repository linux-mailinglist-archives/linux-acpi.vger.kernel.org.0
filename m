Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E7632CB
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2019 10:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfGIIS4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Jul 2019 04:18:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44779 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGIIS4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jul 2019 04:18:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so19017882otl.11;
        Tue, 09 Jul 2019 01:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbzistLccCjhRUbVguErBlGFRjJHeoe5cXWmH1bR0NI=;
        b=qy9/17YQq2oH39jVwUWi2mtoA+fK35CiCphlgRCaOCWHQUegmjK9qBcu4ZoiDq9qWl
         IEtvvymIRjxDIrFTLnWzgE9esBH9R5TpqjBKymVI1kXcjvz7lkiNKKuyUIR89ngq2CCu
         Wo0dFf7mkKlURTcJkPozj3463gg/hp95Ww+Smaj+32HinCKX4HT2XH2op50pTwTQcnlp
         cqGFsRSvITIwnqmwkyG+7P1/mYUjoTn/P2ErdEGdzCc2WdqfS7uj+WolsjXZTlwBswZG
         ryeo+mvwDhUi1jwWExYQu9sgpMtS4LJze2CVtXObu7gS0xkp1zy+Cr7Wak1XDjlwV1fq
         biIw==
X-Gm-Message-State: APjAAAWWdP5IyPx6Vvty+sKfi52XJKNRq4yjYJwNpVJ7JMVKqmsv2HoT
        BFX4Wuw035t5bE4uimTzHcRGCKQyPwBDGuz9d1U=
X-Google-Smtp-Source: APXvYqxEEyCFSpF7JA4EpZYh/eKtKlRvpiQwISy5x0/RiximZPGzhceoUn4kcqYIYlIjwB8Rje3GQ2fLOegT458kOsU=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr16536792otn.266.1562660335425;
 Tue, 09 Jul 2019 01:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com> <20190705095800.43534-9-mika.westerberg@linux.intel.com>
In-Reply-To: <20190705095800.43534-9-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Jul 2019 10:18:44 +0200
Message-ID: <CAJZ5v0g1JKQxw=Rr-BYE6hgcbBXat24tK8s78k+ghmBhr=avLg@mail.gmail.com>
Subject: Re: [PATCH 8/8] ACPI / property: Add two new Thunderbolt property
 GUIDs to the list
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 5, 2019 at 11:58 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Ice Lake Thunderbolt controller includes two new device property
> compatible properties that we need to be able to extract in the driver
> so add them to the growing array of GUIDs.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/property.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index da3ced297f19..07cbacbab861 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -39,6 +39,12 @@ static const guid_t prp_guids[] = {
>         /* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
>         GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
>                   0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
> +       /* TBT GUID for IMR_VALID: c44d002f-69f9-4e7d-a904-a7baabdf43f7 */

I'd prefer Thunderbolt to be spelled in full here (and below).

LGTM otherwise.

> +       GUID_INIT(0xc44d002f, 0x69f9, 0x4e7d,
> +                 0xa9, 0x04, 0xa7, 0xba, 0xab, 0xdf, 0x43, 0xf7),
> +       /* TBT GUID for WAKE_SUPPORTED: 6c501103-c189-4296-ba72-9bf5a26ebe5d */
> +       GUID_INIT(0x6c501103, 0xc189, 0x4296,
> +                 0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
>  };
>
>  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> --
> 2.20.1
>
