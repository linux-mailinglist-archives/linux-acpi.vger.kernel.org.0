Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43743545441
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jun 2022 20:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiFISi5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jun 2022 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiFISiz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jun 2022 14:38:55 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7793C703F9
        for <linux-acpi@vger.kernel.org>; Thu,  9 Jun 2022 11:38:55 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id y188so13757783ybe.11
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jun 2022 11:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2K8VGsodomKXKKxX7r0t2IzDV1/XigAAo+oNDkBiYgQ=;
        b=mUS5WgH43ltQDAN2xJR9moWFy9UG6VDt5JeGcKTuTTSQjiINn6ob4/4Cvt3pLwo/qg
         NNbqaP4Whcnpudvb4bScSYIcETjoMlKv8+xbQ660V6rr38EnV1ZsAGtc4ndXCD3LiHpv
         ydqfqGEhGbbCvOMdxIuHLXjmzjKndP8LQuM4h0VFpIYHIVNEJ++bdrCv0YtaCFtHf/C3
         KkxcoDHa8ACQ/BcdZbXQhP4MTtS1brl86Wekekb1ujlp58lq345abFyxNVbF9b+3LKk5
         UlWW82TG2brgo7BQXlZqQc8KKLmOpJh9ubYRx2ivZL5R6WQl3c0fZ3Ipub8sBZ1RZjSx
         N9HA==
X-Gm-Message-State: AOAM530gnn0332piebSFzthT8MTF4a9SRp+QTVvyXgCnQf420c4oPNKn
        dOzWYybl8czoJ3+igv469RN/s/ah9BARCcZpNe4=
X-Google-Smtp-Source: ABdhPJz3gQVCgNRUku6BtiMY1w/wk+Kdo3gPxjoGWKDbCbj2O5/JWUJ8Q7tImiM42gGdrMM/W1qcJYH0FpNKr44dtt4=
X-Received: by 2002:a25:d98b:0:b0:65c:9dc9:7a8f with SMTP id
 q133-20020a25d98b000000b0065c9dc97a8fmr39802782ybg.622.1654799934735; Thu, 09
 Jun 2022 11:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jun 2022 20:38:43 +0200
Message-ID: <CAJZ5v0i6sSp-R20ShB6ac0BqzxT9kB+hae8GB=c+m0i2V-i8wQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] ACPI: Buffer property and reference as string support
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 25, 2022 at 3:01 PM Sakari Ailus
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
>  drivers/acpi/property.c | 462 +++++++++++++++++++++++++++-------------
>  include/acpi/acpi_bus.h |   3 +-
>  include/linux/acpi.h    |   2 +-
>  3 files changed, 315 insertions(+), 152 deletions(-)
>
> --

FYI, I'm expecting a v4 of this series to be sent.
