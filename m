Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C2583371
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jul 2022 21:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiG0TWj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jul 2022 15:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbiG0TWH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jul 2022 15:22:07 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D940D100
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jul 2022 12:20:27 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31e47ac84daso186084557b3.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jul 2022 12:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AwV9cATFx07k0j5j4oIf3q0NoMKCu+SteSjLLRPK8O4=;
        b=jQLZwgiAIGP0INn1Ofa87fgAQWbwCCAZBdRrjm49Ki6AZC0z2CjyfSqyoeKDGM/tUu
         g47pJ4sf/sTVlF9lyq/CZiijHiGTZgJwVa+GCzRYY+ncaNUpxN68wCu7MBEsPcYqqfmx
         zJ78FHfQR0bSGRpY56uJBGe9/SGv5ugT9c82HnE48pIksfcoI8LwKOw/dcvKOqK7EBnn
         lyoTrYTwQPOg3aZC9VwW7qOWqhg6qcYCQokobYvSjMAFtc7uOb/3w2UvDLE1+7DrzUy5
         DIMo7dVcbAaehSklke2dB7sK7KSTG7zIhUAqHitV2+BcEl/AzLLRq6Yh/3nQmmuBHTiM
         v5Yg==
X-Gm-Message-State: AJIora92Qwg45Ca1779zHC37exeKvsprgTYD8OEhvtG0QMZ8hlzIKBak
        WmFScixDe0YRWcyQn4CGaA3Cee4+H5SKZ7Z3/CY1V1aW
X-Google-Smtp-Source: AGRyM1v7L9UpLKnhFZnlsPZjH93q/LS9gRfXlLl7Cec2uloXTXFSRgOF2nnEG6MxjSWoEXGZc2F24q//mO9jUb61zZI=
X-Received: by 2002:a81:78c6:0:b0:31e:848b:6e2 with SMTP id
 t189-20020a8178c6000000b0031e848b06e2mr20765630ywc.301.1658949626349; Wed, 27
 Jul 2022 12:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jul 2022 21:20:15 +0200
Message-ID: <CAJZ5v0jKOMn3=8XxpD_X5Z2JjyAknpGa-7rVhNZY2gnfAmX76w@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] [PATCH v3 0/8] ACPI: Buffer property and reference
 as string support
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 11, 2022 at 1:24 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hello everyone,
>
> This set adds support for _DSD buffer properties (specified by DSD Guide
> <URL:https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.md>) as well as
> support for references as strings. Reference property type was previously
> supported for device objects only, whereas string references enable
> referencing also _DSD sub-node objects --- also included in the set.
>
> The ACPICA patch has been submitted to upstream but not merged yet.
>
> This set currently prepares for data node string reference support and
> does not add it anymore.
>
> since v3:
>
> - Use bool return type for acpi_tie_nondev_subnodes. Return false on
>   failure.
>
> - Print ACPI buffer parsing error references as %*pE (was %s).
>
> - Unwrap a few lines (i.e. non-functional changes).
>
> - Declare local variables for acpi_copy_property_array_uint().
>
> - Clean up buffer size check in acpi_data_prop_read(), add break at the
>   end of the default case.
>
> since v2:
>
> - Use C99 _Generic() in patch unifying reading integer arrays.
>
> since v1:
>
> - Drop the ACPICA, data node child list initialisation and data node
>   string reference patches.
>
> Sakari Ailus (8):
>   ACPI: property: Return type of acpi_add_nondev_subnodes() should be
>     bool
>   ACPI: property: Tie data nodes to acpi handles
>   ACPI: property: Use acpi_object_type consistently in property ref
>     parsing
>   ACPI: property: Move property ref argument parsing into a new function
>   ACPI: property: Switch node property referencing from ifs to a switch
>   ACPI: property: Unify integer value reading functions
>   ACPI: property: Add support for parsing buffer property UUID
>   ACPI: property: Read buffer properties as integers
>
>  drivers/acpi/property.c | 465 +++++++++++++++++++++++++++-------------
>  include/acpi/acpi_bus.h |   3 +-
>  include/linux/acpi.h    |   2 +-
>  3 files changed, 318 insertions(+), 152 deletions(-)
>
> --

The series (including the update of patch [7/8]) has been applied as
5.20 material, thanks!
