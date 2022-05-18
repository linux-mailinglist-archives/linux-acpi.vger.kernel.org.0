Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C797952C306
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 21:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbiERTHo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 15:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241746AbiERTHn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 15:07:43 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021728020C
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 12:07:43 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2fee010f509so34646527b3.11
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 12:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rsonr79aoLXv3P0Sf/fz4PoARHK5y59EB020pLGUI6k=;
        b=BTHxfx+75KeKqMtfiZ+qedZmC1tiY6mGsBhmYqcl9hIOJfcgqWYF/MOAxq4AQmQZ62
         UKlmTfO8VG1CSgtTGXF6yphkKMGns20JvP0+D2PY2LpxEg55lv5tVJYxUSiGS9yMoRPN
         G/cOOHheCbi3VF+q9KwxS50dL8vGF5Evi3Igo176cbmwgIMQ2zxfpj25uw+O1zfgX+hG
         QqsMVty7OmuGnOSzkJfnblLFmhVZQilx8dTw5dZJnHhCVSxC270PSibgY+2FOSsSX/iq
         eOndN2O/TRUStdmlEha0JKpAyatrYrWk+vTZzmUExlUdivY+n36db19LSi0EUCXDh5PN
         e8UA==
X-Gm-Message-State: AOAM530TfIQZkX/Lkkwvn+G9Pl5pSJD3MMxyQBgidA+N6RbUZsJllvlI
        LW3Wg7+scaffv8ctLNVa86ET+d1GPtr1Sn+UqLU=
X-Google-Smtp-Source: ABdhPJy6CBw7fHdOG0Y/DcM46A3xKz0J0LTqfe+unFX4GdsBpECs1B8v/x4TusbqgTcrL4UlHbLqHeyihrIvt+6LqVQ=
X-Received: by 2002:a0d:c442:0:b0:2fe:beab:1fef with SMTP id
 g63-20020a0dc442000000b002febeab1fefmr986913ywd.196.1652900862298; Wed, 18
 May 2022 12:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
 <20220506130025.984026-3-sakari.ailus@linux.intel.com> <CAJZ5v0ip==ZYopb3sJvyrNpErpa1gGaJLk+OfLgff3x2tH98Og@mail.gmail.com>
 <YoUbUQkjKATrgf6n@paasikivi.fi.intel.com>
In-Reply-To: <YoUbUQkjKATrgf6n@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 May 2022 21:07:31 +0200
Message-ID: <CAJZ5v0jvzHbD6fxNKYJ75eCc3A008fDTf8kA4nP5FK5EvuTS-w@mail.gmail.com>
Subject: Re: [PATCH 02/11] ACPI: acpica: Constify pathname argument for acpi_get_handle()
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Wed, May 18, 2022 at 6:14 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Tue, May 17, 2022 at 06:21:44PM +0200, Rafael J. Wysocki wrote:
> > On Fri, May 6, 2022 at 2:58 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > acpi_get_handle() uses the pathname argument to find a handle related to
> > > that pathname but it does not need to modify it. Make it const, in order
> > > to be able to pass const pathname to it.
> > >
> > > Cc: "Moore, Robert" <robert.moore@intel.com>
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >
> > Which patches in the rest of the series depend on this one?
>
> "ACPI: property: Parse data node string references in properties", i.e.
> patch 8 in this set.

So I think I can apply the rest of the series, except for patch 8 and
patch 7 (as per the previous discussion) for the upcoming merge
window.

Would that work?
