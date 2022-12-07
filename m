Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40D1645FFE
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Dec 2022 18:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLGRTt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 12:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLGRTp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 12:19:45 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A896C218E
        for <linux-acpi@vger.kernel.org>; Wed,  7 Dec 2022 09:19:44 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id a16so1542177qtw.10
        for <linux-acpi@vger.kernel.org>; Wed, 07 Dec 2022 09:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYNj3MB1kq6JFwJ0LXu8hhQsXuA+NdUunfhzA6v6axI=;
        b=YOEpzfNIx7ALH05iMd4ZK0yDELZdHkfa3Wld2tOnV+pCbMlgzahHRxhHHy+xAVtS9x
         nqBSCN2y3XQ+/c3JUbMamPuU8tbHlyMKM+YYyV0lXz7hrfWUCw0FJrPSV7YsFeZR0HJ1
         /ZEZm/XSuCBApwuLgaqyW8L1B6NrR1dOd+oEtjGsJpgM5MoyvVtU2dp1HREw1Rcjzayz
         9sQSzylDLsgSJIIFE91rYZt8Q6gaQfr2mE5/tC7+MWohSgfO6PUZaSkDlELwCpz7n2jA
         ds28bDRUCcW5Q2poWq/2nk+n6Z4l7By/9VyiBER2DR5W8P/OEHKlbhd9+vMDD0hMJC4X
         8abg==
X-Gm-Message-State: ANoB5pk34PB+wHoc5CoFFHQ9GEWgXDoBKO4I2TGCcsg+0aGsQHDaBJTm
        LcjYwtgAq9cwa7TqApdQx42Oa589uwFlViCLo+w3guPk
X-Google-Smtp-Source: AA0mqf4UG57YJjIUn8SXL1y4m6aswLwVvzeX3RPB23zEdcL8Fj4iadaidgQTDu/b1LPSY+Fook4V4CcCCHv1fJtLUEc=
X-Received: by 2002:ac8:7dcb:0:b0:3a6:8dd0:4712 with SMTP id
 c11-20020ac87dcb000000b003a68dd04712mr28734317qte.411.1670433583652; Wed, 07
 Dec 2022 09:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20221206205234.606073-1-Benjamin.Cheatham@amd.com>
 <SJ1PR11MB608313CBF490328F8C431796FC1B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <8f9feb3e-4c32-5c16-558c-7693cc277992@amd.com> <SJ1PR11MB6083C4960BC481DE9BEF2BB7FC1B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083C4960BC481DE9BEF2BB7FC1B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Dec 2022 18:19:32 +0100
Message-ID: <CAJZ5v0jLdOXtTQx_PF=_QGRTcQjUAU=ZNzaQkDJ7O8bABhF1cw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ACPI, APEI, EINJ: Add new CXL Error Types
To:     "Luck, Tony" <tony.luck@intel.com>,
        Ben Cheatham <benjamin.cheatham@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 6, 2022 at 10:37 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> Hi Ben,
>
> > The last patch I mentioned leaving out added support for injecting CXL
> > errors, but I don't have access to a machine that I can test it with at
> > the moment so it'll probably have to wait.
>
> Parts 1 & 2 of your series can be applied now (as nice cleanups).
>
> But part 3 would just be confusing to users without the matching patch
> to add CXL injection support.
>
> I.e. a user might
>
> # cat /sys/kernel/debug/apei/einj/available_error_type
>
> and see:
>
> 0x00001000      CXL.cache Protocol Correctable
>
> But:
>
> # echo 0x1000 > /sys/kernel/debug/apei/einj/error_type
>
> wouldn't do anything useful (may do weird stuff since the driver
> doesn't appear to validate the "type" ... would be great if you fixed
> that while you are digging around in this code :-).
>
> So I'm happy to offer up a "Reviewed-by: Tony Luck <tony.luck@intel.com>"
> for all three parts. I just think that part 3 should not be applied until the
> rest of the code to go with it is ready.

I agree, so I've done accordingly.

Patches [1-2/3] have been applied as 6.2 material (with very minor
subject adjustments) and Ben please resend patch [3/3] when sending
the other material mentioned above (and please feel free to add the
tag from Tony to it when doing that).
