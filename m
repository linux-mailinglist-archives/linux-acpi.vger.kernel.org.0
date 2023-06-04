Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012E8721874
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Jun 2023 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjFDQJe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Sun, 4 Jun 2023 12:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDQJd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jun 2023 12:09:33 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1541DB3;
        Sun,  4 Jun 2023 09:09:32 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-94ea38c90ccso72930266b.1;
        Sun, 04 Jun 2023 09:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685894970; x=1688486970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF9X4I63I2PmSlQXak66EM9u+G4hRGXTYT1CsoyXv8A=;
        b=EoPoWHveMWJ9veG0LIcIcOdiQrJIwjwzgkZVyc61N/GJBUkYrNk0H1f9nBCsifUeEM
         NYjhyZLcXD6M3GYMZm5wvVR9PFEcN4cJf9sh5hKza+INsn7onxP8uIrUuYu6z7AqJMZD
         3hTXFLnfHyBWjRTymjvyhiRNRKBveuLkBw9dIJNdKEFbhTJhAAtqPjXVkJ9bQe+wypB4
         rmQSGJyiv4wDilPg4csTlul9iwnPimZBWVobD4NQb9OiLsfmvKrF4EI0Mtiseme/R0HX
         qQMu+tBRS2UtmE6Zv+BNzxdZzjaLM8OvQq6tgcrPU9u7wj50jkCSX1VgOBnM0hRtxSkf
         JQ6w==
X-Gm-Message-State: AC+VfDzgOm1nEJcN/APyu07DHKD9Zs+50tqDTFBVX/7J9en2F6+5uktB
        iCxor252QB8J/rEmakLYEgkefYCSIj1a4KUEPMU=
X-Google-Smtp-Source: ACHHUZ7uxNj+HwBGMoaJ4vShM+UlBmIsfu/kadNWj3tfFDYjns2iSrQRTc5TzB5cbg+jY6IMuR0GX2/+tX42EvcvCNU=
X-Received: by 2002:a17:906:145:b0:94a:5f0d:d9d6 with SMTP id
 5-20020a170906014500b0094a5f0dd9d6mr14762463ejh.4.1685894970362; Sun, 04 Jun
 2023 09:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
In-Reply-To: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 4 Jun 2023 18:09:19 +0200
Message-ID: <CAJZ5v0gbSN5K1Q_Afsr9T3WGadg6zphGsz6ATavmiXVmRMPWcw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] acpi: Add CDAT parsing support to ACPI tables code
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
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

On Thu, Jun 1, 2023 at 11:31 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> v3:
> - Move common code to lib/fw_table.c
> v2:
> - Split out with CONFIG_ACPI_TABLES_LIB to be independent
> - Fixed 0-day issues
> - Change CDAT releveant names to prefix with cdat/CDAT instead of
>   acpi/ACPI. (Jonathan)
> - Make table_header a union with cdat table header instead of
>   'acpi_table_header'. (Jonathan)
> - Removed ACPI_SIG_CDAT, already defined.
>
> Hi Rafael,
> Please consider ack these patches. Dan can take these through the CXL tree. After
> attempting to rename the cxl_ prefixes of functions and non ACPICA data structures
> to something more common, it seems that significant amount of ACPI code would be
> touched for the rename. For this series I left it alone in order to have the minimal
> changes to ACPI code.
>
> I've broken out the "cxl: Add support for QTG ID retrieval for CXL subsystem" [1]
> series in order to make it more manageable. Here's the first part of the ACPI
> changes. These changes are added to allow reuse of ACPI tables code to parse
> the CDAT tables. While CDAT is not part of ACPI, the table structures are similar
> to ACPI layouts that the code can be reused with some small modifications.
>
> However, in order to be properly utilized by CXL users, the tables code needs
> to be refactored out to be independent of ACPI. For example, a PPC BE host may
> have CXL and does not have ACPI support. But it will have CDAT to read from
> devices and switches. I have created CONFIG_ACPI_TABLES_LIB in order to allow
> the common code to be independent. 0-day seems to be happy now for all the
> different configs and archs.
>
> 1/4: Split out the common code from drivers/acpi/tables.c to lib/fw_table.c
> 2/4: Add CDAT support
> 3,4/4: These two are minor patches that has ACPICA impact. Has been merged into
>        the ACPICA git repo [3].
>
> The whole series is at [2] for convenience.
>
> [1]: https://lore.kernel.org/linux-cxl/168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3/T/#t
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg
> [3]: https://github.com/acpica/acpica/pull/874
>
> ---
>
> Dave Jiang (4):
>       acpi: Move common tables helper functions to common lib
>       lib/firmware_table: tables: Add CDAT table parsing support
>       acpi: fix misnamed define for CDAT DSMAS
>       acpi: Add defines for CDAT SSLBIS
>
>
>  drivers/acpi/Kconfig     |   1 +
>  drivers/acpi/tables.c    | 178 +----------------------------
>  include/acpi/actbl1.h    |   5 +-
>  include/linux/acpi.h     |  22 +---
>  include/linux/fw_table.h |  52 +++++++++
>  lib/Kconfig              |   3 +
>  lib/Makefile             |   2 +
>  lib/fw_table.c           | 236 +++++++++++++++++++++++++++++++++++++++
>  8 files changed, 302 insertions(+), 197 deletions(-)
>  create mode 100644 include/linux/fw_table.h
>  create mode 100644 lib/fw_table.c
>
> --

I think that this series can go in via the CXL tree and I'm expecting
ACPICA to make a new release including the counterparts of patches
[3-4/4] shortly.

Please feel free to add

Acled-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the series.

Thanks!
