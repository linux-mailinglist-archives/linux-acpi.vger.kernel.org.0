Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8457CEB2
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jul 2022 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiGUPO5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jul 2022 11:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGUPO5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jul 2022 11:14:57 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283987B359
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jul 2022 08:14:56 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-31e1ecea074so20487397b3.8
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jul 2022 08:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfdmD61lk9cCTrzpyE3aykMysUZbdv2fKAgxoTbG2fQ=;
        b=IEmTbYenDxKBYjmEGjnNm8jw3Cc4XRvt+qqTdchfWKzlY5GRImkZGaI587+xOIs7bz
         mnKWqj60GALVmEQQXn0OXnfa4VYNVxK+QjG2tAZHkYizf7MypVfyIPx875eU0CIlh+kg
         tkh2mex0wZJyXUzkd4fEdOsL/Dk9zmnzFmERiK/hi1K0aOuMFJlzUvzHYSHkbydjPd1t
         zDg/AVAEb2odXw+oc7vB0RShqBn/NkLkwPI3Z7TZmDrX7QSvA6NpNMLzo9iANi6mgp21
         dMvLB+bX9nOH2g6MzMxRKTTnYb21pF5Qp3SKiBNIYbpYugLzEUmCjluBY72XNtSrHZ/W
         Kn6A==
X-Gm-Message-State: AJIora9rGNMlSynruHAV8RdOmrtQNZMatlR6l3vyWCXBdgAIRNLz5wJm
        rwASHlNRNVUQn4G/qt7agr6xFEp7CGlfN5Oc3dc=
X-Google-Smtp-Source: AGRyM1sLPW8Qi0lP8VpmGfuNta9SnhXGsXEtzrOtco8QDOhOeHaWhy/5IjQSdMSAbHftU8LfAIO2STDQh1hO551P+Ko=
X-Received: by 2002:a0d:df09:0:b0:31e:78f8:32d0 with SMTP id
 i9-20020a0ddf09000000b0031e78f832d0mr5508195ywe.19.1658416495383; Thu, 21 Jul
 2022 08:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
 <20220711112606.3050368-8-sakari.ailus@linux.intel.com> <CAJZ5v0gQuGYjH=twZKcy0FmsK6vVyboN0ubOXZqHVVNfyuP1PQ@mail.gmail.com>
 <YtJwD/BspZxoJySJ@paasikivi.fi.intel.com>
In-Reply-To: <YtJwD/BspZxoJySJ@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jul 2022 17:14:44 +0200
Message-ID: <CAJZ5v0h5-JyES4_kWCFf9EAhqa+VKZGobST2zX0+Z1PsWB0H3Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] ACPI: property: Add support for parsing buffer
 property UUID
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Sat, Jul 16, 2022 at 10:00 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> Thanks for the review.
>
> On Fri, Jul 15, 2022 at 07:59:21PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jul 11, 2022 at 1:24 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Add support for newly added buffer property UUID, as defined in the DSD
> > > guide.
> >
> > A link to the DSD guide and a more specific reference to the relevant
> > part of it (eg. section number) would be handy.
>
> That would be 3.3
> <URL:https://github.com/UEFI/DSD-Guide/blob/main/src/dsd-guide.adoc#buffer-data-extension-uuid>.
>
> I'll add that for v5.

The rest of the patches in the series look fine to me, so please just
send an update of this one.
