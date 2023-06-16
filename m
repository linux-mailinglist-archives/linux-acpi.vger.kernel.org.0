Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6D27337CA
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jun 2023 19:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjFPR60 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 16 Jun 2023 13:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjFPR6Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jun 2023 13:58:25 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F712D50;
        Fri, 16 Jun 2023 10:58:23 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-31125a0a7daso137792f8f.1;
        Fri, 16 Jun 2023 10:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686938302; x=1689530302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYPyIyhdF5I4EchW0F0yJFWG0aRH9eXy2KPSWUbZywM=;
        b=f1f+Qx0LjG3Z4FqfFw0AO8jvj7JnAk4INIrWejcly5d//oiOkxH6kS1rnp+D7wbrhq
         We+matXjCggE15EBFMjfXFCA0sXgSigXJ4/ZQD0MO7BBcD/47lCdTuymgMtj6NchmHVl
         CnWHMYrm01k9Z9LCBW8+0S1AnX3PQm0Nf9IFxR344V8sHaTS/9hfaLYVmwyapp1A8J/p
         +4mZFG1cbk0LUOjHLTjg7+zHBWp/0OUryGD+454YOUPg+y4m47Rbi/LA9mZhR0+wmLc6
         vSMWlLW21zrRvurC3x6fEoCmECis+CLGeNyLqs5dxevPJqWTOw2adPy6YV0mYQPLOJHE
         khjg==
X-Gm-Message-State: AC+VfDxqFYRszGwLoW/Hv7iP9j3rmQxold8GLYwTjKxOnhBg1mL2b1f3
        YcyKVFYZkvKBXxsPfe13/FKpMM1uU+hrz8n0vnPKiknT
X-Google-Smtp-Source: ACHHUZ4k+oO7OxsNsM6kqMmHh1IyXjRB5UPtkVQDIsnQNrkTw97cmgJDjCRQrVHk80mVB56YXiGnFo7mvC0S8e29Uj4=
X-Received: by 2002:adf:ed83:0:b0:311:1a93:71ad with SMTP id
 c3-20020adfed83000000b003111a9371admr1864035wro.3.1686938302321; Fri, 16 Jun
 2023 10:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
In-Reply-To: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jun 2023 19:58:11 +0200
Message-ID: <CAJZ5v0h_HMAoAj3v0MLEt3pK2Kz8VQOKuc2hweUAyLheyqUQ1Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] acpi: numa: add target support for generic port to
 HMAT parsing
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de
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

On Thu, Jun 15, 2023 at 11:23 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> v3:
> - Break out ACPI_SRAT_DEVICE_HANDLE_SIZE define. Merged into ACPICA repo.
> - Break out code in hmat_parse_locality() to improve readability. (Jonathan)
> - Drop continue after setting gen target access data. (Jonathan)
> v2:
> - Add check for memory type for setting GENPORT access data. (Jonathan)
> - NODE_ACCESS_CLASS_GENPORT to NODE_ACCESS_CLASS_GENPORT_SINK
> - Change strncmp() to memcmp() for device handle compare
>
> Hi Rafael,
> Please consider acking this series.

Sure.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> Dan will take it through his CXL tree.

Works for me!

> This is the second set of ACPI changes that's part of the "cxl: Add support for
> QTG ID retrieval for CXL subsystem" [1]. It has dependency on the patch [2]
> that was sent to you and GregKH and Greg has ack'd. But it's independent of the
> first set of ACPI changes [3]. The series adds support to store the device handle
> from the SRAT Generic Port Affinity Structure in correlation with a proximity
> domain. And later on the HMAT is parsed and the performance data is stored
> associated with the proximity domain. A helper function is added to allow the CXL
> driver to retrieve the performance data that matches with the device handle later
> on. The full series of CXL code is at this git repo [4] for usage reference.
>
>
> [1]: https://lore.kernel.org/linux-cxl/168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3/T/#t
> [2]: https://lore.kernel.org/lkml/168332248685.2190392.1983307884583782116.stgit@djiang5-mobl3/
> [3]: https://lore.kernel.org/linux-acpi/168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3/T/#t
> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg
>
> ---
>
> Dave Jiang (6):
>       acpi: numa: Create enum for memory_target access coordinates indexing
>       ACPICA: Add a define for size of acpi_srat_generic_affinity DeviceHandle
>       acpi: numa: Add genport target allocation to the HMAT parsing
>       acpi: Break out nesting for hmat_parse_locality()
>       acpi: numa: Add setting of generic port system locality attributes
>       acpi: numa: Add helper function to retrieve the performance attributes
>
>
>  drivers/acpi/numa/hmat.c | 151 +++++++++++++++++++++++++++++++++------
>  include/acpi/actbl3.h    |   4 +-
>  include/linux/acpi.h     |  12 ++++
>  3 files changed, 144 insertions(+), 23 deletions(-)
>
> --
>
