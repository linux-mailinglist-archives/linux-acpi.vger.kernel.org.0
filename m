Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42B270DACC
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjEWKqk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 23 May 2023 06:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbjEWKqj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 06:46:39 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFD8133;
        Tue, 23 May 2023 03:46:32 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-94ea38c90ccso89857866b.1;
        Tue, 23 May 2023 03:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684838791; x=1687430791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I22ot7qUpBCf9D/QaCKwQ8wq5IkIiCXJxXCY8CP6v0M=;
        b=UNiqBEo0kU7pmeVowZ+10bFdxBDZAhr3W37Y4+U/uhXI8zQZvNEmhJg1/RyBaIILmn
         Y+wRiSN6Vc+/YDWREsv1e1Gdg3VY9cO/jB4qC3uvGo8AnZfWVw+U34mUX7IctjT5ArPg
         QdEbVyBwWdpbJJRTc88wPs+KKqGaZ6igeN3HB3n0M75mBDCe9fn32RDNlnt/mKi0jg2J
         UciheBUpDZH4MYhugtrANnVBq54BpPNI+NWaFU3sRqErYT4Q8WxquhyTxq8QYCcR13hL
         PUWj2tZ0dVLW6ulaT5cwUKeoGlQp6Ruw3oG85lzxr4Cv5Dw5M2dgRmw10aLb2IwOvRJ8
         AVjA==
X-Gm-Message-State: AC+VfDz7fAlZaSliXA1AdTBeyGm6ztO/tts3ceU7d01W3e2iX34oxhgP
        R7YTsALqPTjc3hL2hckCDcpG33RZJdi/V8diyNyv8VYr
X-Google-Smtp-Source: ACHHUZ7DCndnqr1nK6UXcEjzPYJE1YuOZwO8q9EhhYwueKX0NnzHSvIuadoLcMvodjeC3+eQSj9uPcixMUr0KgOB8eE=
X-Received: by 2002:a17:906:72d4:b0:96f:da08:d451 with SMTP id
 m20-20020a17090672d400b0096fda08d451mr5675715ejl.6.1684838790526; Tue, 23 May
 2023 03:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443479457.2966470.18010229834586488037.stgit@djiang5-mobl3> <646bf98890561_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <646bf98890561_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 12:46:18 +0200
Message-ID: <CAJZ5v0gaZK8vit53AuGEXhh5EkxOoB8xGO5vP8Gh9KC17j8mqw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] acpi: fix misnamed define for CDAT DSMAS
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
        linux-cxl@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 23, 2023 at 1:24 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Dave Jiang wrote:
> > ACPI_CEDT_DSMAS_NON_VOLATILE should be defined as
> > ACPI_CDAT_DSMAS_NON_VOLATILE. Fix misspelled define.
> >
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >
> > ---
> > See https://github.com/acpica/acpica/pull/874
> > Merged
> > ---
> >  include/acpi/actbl1.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > index 81b9e794424d..15df363b9144 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
> > @@ -356,7 +356,7 @@ struct acpi_cdat_dsmas {
> >
> >  /* Flags for subtable above */
> >
> > -#define ACPI_CEDT_DSMAS_NON_VOLATILE        (1 << 2)
> > +#define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
>
> This needs to come in through an ACPICA update. If that is going to happen
> this cycle, great, if not then I would handle it as a merge fixup after
> the fact. I.e. just live with the misspelling to keep this patch set
> ACPICA unencumbered, unless Rafael has different thoughts.

You can also submit an upstream ACPICA pull request with this change
and resend the patch with a Link tag pointing to that PR.  Then we'll
decide how to handle it.
