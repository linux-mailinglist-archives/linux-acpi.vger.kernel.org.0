Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3660E3A88D1
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jun 2021 20:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhFOSvA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Jun 2021 14:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhFOSu7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jun 2021 14:50:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2271C061767
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 11:48:54 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n12so12189727pgs.13
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0JM4+VLgeYRBpYPu+DbbsTsMP4gd2M6j0wYVzMmmmqc=;
        b=CSPS9dQljg7NwD37B6BvNQO/fek6+ZCZqpqvB/2NgoHreGc9IxF807VzPPjNsTTMZ1
         MkcCeOQCkoZpZAEW4Kt2CyXmURSyk7htgofRr/2TMGzCxO2Z5x4qevLGIoLsKA4eXGWM
         jyC5Vx7fOAMRhxYTlRySNa4VVkktWQZteqN6YzO1cn83NMDPWGLvND92FWPvLk8W7dz2
         7YDHQPch9tLmUjyeLxEDs6blnVi7WlDqH0ryS6XVdi/+MGdFfNOa6N+xD0xSOllPtzeM
         D7N+lUOwTUNhcq6CPMD52wILETPrB/h15+ULmur/W5UYROHJtvBz/qoU7kkuzTb9xIYN
         9ODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JM4+VLgeYRBpYPu+DbbsTsMP4gd2M6j0wYVzMmmmqc=;
        b=K7jo91zfdOGC0pdXge8aqpRh36sSkWlvs+X2TFhuFCilKamQA9cVtDzPRi5Zln6nsf
         Tuja13eXwgPXBOMXcr+m/EFBypPo560zL/NXjV3Zj55OyeqicllyItSUelFom2fqc7ka
         e/8bRj7GPRkMOk+bN8xbOE/iZFgOoU+NOG+aeyyJUk/mDys750FINZeFeKfMkkK3d3zO
         rxtyEpRVQT8HNlNk9r7wjhdFsTvOZxKQMMsmqOMWthsWmkk+N3OxCPGlElox+bQhS3Zo
         40mlQEyfRvsCorkZgDZk5ONS8WH7EfAjJ6bXdRFbfX1qLqYVyriwHt7+jBME4Xrr++Hb
         mCaw==
X-Gm-Message-State: AOAM531JTuZV8CSD1xcDL7PTvPSNPjLLvBCpBARHpDJkTdbAQqDU75bm
        w9mEj79NisqLWppF0c7yRaM3UoPPOd0tWZ2pHrGvgAzfYMFS0w==
X-Google-Smtp-Source: ABdhPJycwq+B9IxmHnICIpoOUfF1orYvkEQ0wRNmtPF5XtdiP82GcZBxac+AuSAuanQSbs1E+zB/vxPPtLvBfkDCzqQ=
X-Received: by 2002:a62:8647:0:b029:2c4:b8d6:843 with SMTP id
 x68-20020a6286470000b02902c4b8d60843mr5627105pfd.71.1623782934196; Tue, 15
 Jun 2021 11:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623705308.git.alison.schofield@intel.com> <0246fe923945ba2b8d885f45279d7d3956c46950.1623705308.git.alison.schofield@intel.com>
In-Reply-To: <0246fe923945ba2b8d885f45279d7d3956c46950.1623705308.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Jun 2021 11:48:43 -0700
Message-ID: <CAPcyv4houyD9PGG4PKiO7OiHkKEZD81=tVSzr_PTShHBzx956A@mail.gmail.com>
Subject: Re: [PATCH 2/2] cxl/acpi: Use the ACPI CFMWS to create static decoder objects
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[ add linu-acpi for variable length array question below ]


On Mon, Jun 14, 2021 at 3:57 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> The ACPI CXL Early Discovery Table (CEDT) includes a list of CXL memory
> resources in CXL Fixed Memory Window Structures (CFMWS). Retrieve each
> CFMWS in the CEDT and add a cxl_decoder object to the root port (root0)
> for each memory resource.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/acpi.c | 106 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 16f60bc6801f..ac4b3e37e294 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -8,8 +8,112 @@
>  #include <linux/pci.h>
>  #include "cxl.h"
>
> +/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> +#define CFMWS_INTERLEAVE_WAYS(x)       (1 << (x)->interleave_ways)
> +#define CFMWS_INTERLEAVE_GRANULARITY(x)        ((x)->granularity + 8)
> +
> +/*
> + * CFMWS Restrictions mapped to CXL Decoder Flags
> + * Restrictions defined in CXL 2.0 ECN CEDT CFMWS
> + * Decoder Flags defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register
> + */
> +#define CFMWS_TO_DECODE_TYPE2(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) << 2)
> +#define CFMWS_TO_DECODE_TYPE3(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) << 2)
> +#define CFMWS_TO_DECODE_RAM(x)   ((x & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) >> 2)
> +#define CFMWS_TO_DECODE_PMEM(x)         ((x & ACPI_CEDT_CFMWS_RESTRICT_PMEM) >> 2)
> +#define CFMWS_TO_DECODE_FIXED(x) (x & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
> +
> +#define CFMWS_TO_DECODER_FLAGS(x) (CFMWS_TO_DECODE_TYPE2(x) | \
> +                                  CFMWS_TO_DECODE_TYPE3(x) | \
> +                                  CFMWS_TO_DECODE_RAM(x)   | \
> +                                  CFMWS_TO_DECODE_PMEM(x)  | \
> +                                  CFMWS_TO_DECODE_FIXED(x))

I don't understand the approach taken above. It seems to assume that
the CXL_DECODER_F_* values are fixed. Those flag values are arbitrary
and mutable. There is no guarantee that today's CXL_DECODER_F_* values
match tomorrow's so I'd rather not have 2 places to check when / if
that happens.

> +
>  static struct acpi_table_header *cedt_table;
>
> +static int cxl_acpi_cfmws_verify(struct device *dev,
> +                                struct acpi_cedt_cfmws *cfmws)
> +{
> +       int expected_len;
> +
> +       if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
> +               dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");

I expect the user will want to know more about which decode range is
not being registered. So, for all of these error messages please print
out the entry, at least the base and end address.

> +               return -EINVAL;
> +       }
> +
> +       if (!IS_ALIGNED(cfmws->base_hpa, SZ_256M)) {
> +               dev_err(dev, "CFMWS Base HPA not 256MB aligned\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!IS_ALIGNED(cfmws->window_size, SZ_256M)) {
> +               dev_err(dev, "CFMWS Window Size not 256MB aligned\n");
> +               return -EINVAL;
> +       }
> +
> +       expected_len = struct_size((cfmws), interleave_targets,
> +                                  CFMWS_INTERLEAVE_WAYS(cfmws));

Oh interesting, I was about to say "unfortunately struct_size() can't
be used", becuase I thought ACPICA could not support variable length
array. It turns out 'struct acpi_cedt_cfmws' got away with this. Not
sure if that is going to change in the future, but it's a positive
sign otherwise.

> +
> +       if (expected_len != cfmws->header.length) {
> +               dev_err(dev, "CFMWS interleave ways and targets mismatch\n");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static void cxl_add_cfmws_decoders(struct device *dev,
> +                                  struct cxl_port *root_port)
> +{
> +       struct acpi_cedt_cfmws *cfmws;
> +       struct cxl_decoder *cxld;
> +       acpi_size len, cur = 0;
> +       void *cedt_base;
> +       int rc;
> +
> +       len = cedt_table->length - sizeof(*cedt_table);
> +       cedt_base = cedt_table + 1;
> +
> +       while (cur < len) {
> +               struct acpi_cedt_header *c = cedt_base + cur;
> +
> +               if (c->type != ACPI_CEDT_TYPE_CFMWS) {
> +                       cur += c->length;
> +                       continue;
> +               }
> +
> +               cfmws = cedt_base + cur;
> +
> +               if (cfmws->header.length < sizeof(*cfmws)) {
> +                       dev_err(dev, "Invalid CFMWS header length %u\n",
> +                               cfmws->header.length);
> +                       dev_err(dev, "Failed to add decoders\n");
> +                       return;
> +               }
> +
> +               rc = cxl_acpi_cfmws_verify(dev, cfmws);
> +               if (rc) {
> +                       cur += c->length;
> +                       continue;
> +               }
> +
> +               cxld = devm_cxl_add_decoder(dev, root_port,
> +                               CFMWS_INTERLEAVE_WAYS(cfmws),
> +                               cfmws->base_hpa, cfmws->window_size,
> +                               CFMWS_INTERLEAVE_WAYS(cfmws),
> +                               CFMWS_INTERLEAVE_GRANULARITY(cfmws),
> +                               CXL_DECODER_EXPANDER,
> +                               CFMWS_TO_DECODER_FLAGS(cfmws->restrictions));
> +
> +               if (IS_ERR(cxld))
> +                       dev_err(dev, "Failed to add decoder\n");

This would be another place to print out the CFMWS entry so that the
user has some record of which address range is offline.

> +               else
> +                       dev_dbg(dev, "add: %s\n", dev_name(&cxld->dev));
> +
> +               cur += c->length;
> +       }
> +}
> +
>  static struct acpi_cedt_chbs *cxl_acpi_match_chbs(struct device *dev, u32 uid)
>  {
>         struct acpi_cedt_chbs *chbs, *chbs_match = NULL;
> @@ -251,6 +355,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>         if (rc)
>                 goto out;
>
> +       cxl_add_cfmws_decoders(host, root_port);
> +
>         /*
>          * Root level scanned with host-bridge as dports, now scan host-bridges
>          * for their role as CXL uports to their CXL-capable PCIe Root Ports.
> --
> 2.26.2
>
