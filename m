Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6FF53664E
	for <lists+linux-acpi@lfdr.de>; Fri, 27 May 2022 19:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiE0REz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 May 2022 13:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238777AbiE0REy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2022 13:04:54 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371E013B8F6
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2022 10:04:53 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-300beab2b76so53339867b3.13
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2022 10:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNC0sIAFLdQmuOQpWWIkOKLwmWZ75Migx+TS3Iesk1M=;
        b=MeFqWVlQAzvKRexumXQFBIfqHIay37fxmx/S7uUxc7VTeWvu892m+ts2hnOmi+l2sf
         sqoBDh2YKvd+VIv87wIF/EuQErv1xFWGGBmf3EsK6sl/QzlCxWSKE8nIPibZjWrE0D9D
         TV/WPs72Q5iHrz0ZrA1boVTuDCgmR7yZHtrDtDk1MYBWuJrQuhyXLzjQWQRhvKRlFFkK
         K8KKNHsFYv1pdg0huhpzfQTI6RFPNJ9qGnwVRU2wogbNdMLt6yqvw8zfsZFk5AL2FkRp
         kyrmLtSYO2ZZxJxXQ/6Ske7JHjlB01MNp0d+9/rNbDMsTDiYm6vNbXfK1Nhi3NMZA53B
         kJJw==
X-Gm-Message-State: AOAM530mQ94qAyokKlNfnLJKkolWvB5mxXOcR+ga5Qa4y+S+wzBv6Nrm
        +sAne0Z6t996JEmCBv8rHt6nYVS9Cui1JH0PtHY=
X-Google-Smtp-Source: ABdhPJx2VOJyKIsgZepMXTz/Ua+amv+am9BzBOk/N4O6vMrx5XqBfVdTFQk8uU8Ispw25WY5oUD2h2dBSrslF7OOY3A=
X-Received: by 2002:a81:7013:0:b0:30b:f17b:5e88 with SMTP id
 l19-20020a817013000000b0030bf17b5e88mr613251ywc.7.1653671092487; Fri, 27 May
 2022 10:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-3-sakari.ailus@linux.intel.com> <CAJZ5v0jrFQk2aH78Fg=W+6KAzhony3yZ+NjYy8ki5atKoaPwLw@mail.gmail.com>
 <YpCTjhncY4fhDjMq@paasikivi.fi.intel.com>
In-Reply-To: <YpCTjhncY4fhDjMq@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 May 2022 19:04:39 +0200
Message-ID: <CAJZ5v0jM3rayEkAT21aReau+n-mZsNzVeQjH0wS5c1F+s5OgsQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] ACPI: property: Tie data nodes to acpi handles
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

On Fri, May 27, 2022 at 11:02 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Thu, May 26, 2022 at 09:19:17PM +0200, Rafael J. Wysocki wrote:
> > > +static int acpi_tie_nondev_subnodes(struct acpi_device_data *data)
> > > +{
> > > +       struct acpi_data_node *dn;
> > > +
> > > +       list_for_each_entry(dn, &data->subnodes, sibling) {
> > > +               acpi_status status;
> > > +               int ret;
> > > +
> > > +               status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
> > > +               if (ACPI_FAILURE(status)) {
> > > +                       acpi_handle_err(dn->handle, "Can't tag data node\n");
> > > +                       return 0;
> > > +               }
> > > +
> > > +               ret = acpi_tie_nondev_subnodes(&dn->data);
> > > +               if (ret)
> > > +                       return ret;
> >
> > Is it actually possible that this returns anything different from 0?
>
> acpi_attach_data() involves allocating memory and resolving a reference.
> Both can fail.

Yes, they can, but the value returned by acpi_attach_data() is
effectively ignored above (except for printing the error message,
which BTW could be "info" and provide more information).

I don't see how acpi_tie_nondev_subnodes() can produce a nonzero return value.
