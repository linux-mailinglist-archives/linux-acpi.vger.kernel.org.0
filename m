Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224F670E034
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 17:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjEWPR1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 23 May 2023 11:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbjEWPRB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 11:17:01 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D3DFA;
        Tue, 23 May 2023 08:16:34 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-50a20bfe366so2162a12.0;
        Tue, 23 May 2023 08:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684854977; x=1687446977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4Wb7wuPqvry+zeJ2PAJLiwi3jUcq9Ijwecu6TMuBm8=;
        b=Nqzxo+WexDdQa7VGluzDVajBqjn2e110/ok4gT8SrmLFbLowqUCGBtJnwQyy82X5b4
         O5o8y7J6c2Bk/VjvGK6xBLmyip5+cIg6BuYQRX7YtXLOcK5R7gKVT94FPn1wGfKfs24W
         LpXQrMSUmIhC6oSg3+v52+/ocm9aP6oDu2+XaZjcwHdar8eXp6ot5vKiSRCaCHEe1J6Y
         yEu7tjSHsVoBXaSqo6AB5FO+yWLBwLKFlAh95f5Nv+3L/Ed+Vv1qLRA/CMmAOXfuxOmg
         +/Z2/BsbbxrWSgntndQpXEkPY38rzPh7gnCvSs9d/q0goj3ghbhyEaXRk9P4RZ4f0eTr
         AFBg==
X-Gm-Message-State: AC+VfDydTEoLfW3RcPMp0/jyD/qolBWNsoHnPZevbM3K0yHPQHBdjTJ9
        f9GXnIkTWQn488RUMxmSbG6cM/5MpsCHk+hMSXs=
X-Google-Smtp-Source: ACHHUZ6/y7y5BnyR2SH7+prg2h7KGX//jipc7sinxyD1VkQb/MHW2dQGyP3AAX5MkmI/eG+UnXF265A9eFAY47ZhN0s=
X-Received: by 2002:a17:906:2253:b0:965:d0b1:b72f with SMTP id
 19-20020a170906225300b00965d0b1b72fmr13368545ejr.1.1684854976839; Tue, 23 May
 2023 08:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443479457.2966470.18010229834586488037.stgit@djiang5-mobl3>
 <646bf98890561_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <CAJZ5v0gaZK8vit53AuGEXhh5EkxOoB8xGO5vP8Gh9KC17j8mqw@mail.gmail.com> <5a81e0f1-4cdf-dae9-4b4d-f2a49f2a8ff5@intel.com>
In-Reply-To: <5a81e0f1-4cdf-dae9-4b4d-f2a49f2a8ff5@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 17:16:05 +0200
Message-ID: <CAJZ5v0jAryLSsjs7QUOA3HHmf+fk6hH3t+Q=UuQudkn8qO0WKA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] acpi: fix misnamed define for CDAT DSMAS
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        Len Brown <lenb@kernel.org>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 23, 2023 at 4:55 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
>
> On 5/23/23 03:46, Rafael J. Wysocki wrote:
> > On Tue, May 23, 2023 at 1:24 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >> Dave Jiang wrote:
> >>> ACPI_CEDT_DSMAS_NON_VOLATILE should be defined as
> >>> ACPI_CDAT_DSMAS_NON_VOLATILE. Fix misspelled define.
> >>>
> >>> Cc: Rafael J. Wysocki <rafael@kernel.org>
> >>> Cc: Len Brown <lenb@kernel.org>
> >>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >>>
> >>> ---
> >>> See https://github.com/acpica/acpica/pull/874
> >>> Merged
> >>> ---
> >>>   include/acpi/actbl1.h |    2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> >>> index 81b9e794424d..15df363b9144 100644
> >>> --- a/include/acpi/actbl1.h
> >>> +++ b/include/acpi/actbl1.h
> >>> @@ -356,7 +356,7 @@ struct acpi_cdat_dsmas {
> >>>
> >>>   /* Flags for subtable above */
> >>>
> >>> -#define ACPI_CEDT_DSMAS_NON_VOLATILE        (1 << 2)
> >>> +#define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
> >> This needs to come in through an ACPICA update. If that is going to happen
> >> this cycle, great, if not then I would handle it as a merge fixup after
> >> the fact. I.e. just live with the misspelling to keep this patch set
> >> ACPICA unencumbered, unless Rafael has different thoughts.
> > You can also submit an upstream ACPICA pull request with this change
> > and resend the patch with a Link tag pointing to that PR.  Then we'll
> > decide how to handle it.
>
> That's been done and merged. I'll include the Link tag in the next rev.

If it's merged, then the Linux patch can be applied without waiting
for an ACPICA release (which should take place in the near future
anyway).
