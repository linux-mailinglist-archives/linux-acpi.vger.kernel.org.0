Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CAB523BCC
	for <lists+linux-acpi@lfdr.de>; Wed, 11 May 2022 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345744AbiEKRo1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 May 2022 13:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243097AbiEKRo0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 May 2022 13:44:26 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3EA223869
        for <linux-acpi@vger.kernel.org>; Wed, 11 May 2022 10:44:25 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2ec42eae76bso29689227b3.10
        for <linux-acpi@vger.kernel.org>; Wed, 11 May 2022 10:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYO0eStuRLjV2sFmlQvei+Ej0CS+PciF6/aYUPCh3Cg=;
        b=UlSyJMPASIJZz3o0+zwSnESx8carcjN26B41Ullma5DdcbHTug1rGjaGiDHJKz14kg
         b7SaKsxieMZuYcnhwjqsX97wzcB1doZ2hdhQH1VJZdcHrjc/LaoF13eedTmb2Yxl73Ax
         KZvp6SJKgkpRpmVwLVJMTcmgw9x8B+zIekEzspIXw+p5a53aBEC6ZBVMx31XmeH7N8Qi
         LcbVe89eeoNoIXRIa8nzt89OlwKzxL7QnIssjp8tVrPro5OAmCAvgVlx/7Ns/3gb3ItN
         F2BfFu7yncGzY81fk8wJ+TRiOs+bYqvTIgBH+RsJ0QSlkd+WXiQyhb/2SMajhqDLwSb6
         HIug==
X-Gm-Message-State: AOAM531s6uF9TgRtGTI8+nTugmtd8YWckWw+BXCZsmwWL1jRSJVnvTf/
        2aP643LIYq22P7fAOnjpXbrxacXjni2CRlGV7Lk=
X-Google-Smtp-Source: ABdhPJy8HAm/mb8xqKBbC05PVGoOVAwNAUfX1KXXC/xVRVBvOr25x5sOUAQf8nu//s8h314y8MbBdTzYYrBkQB/kamU=
X-Received: by 2002:a0d:e645:0:b0:2f4:dbd6:261e with SMTP id
 p66-20020a0de645000000b002f4dbd6261emr26394012ywe.7.1652291065116; Wed, 11
 May 2022 10:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220511171754.avfrrqg6eihku55s@bsd-mbp.dhcp.thefacebook.com>
 <CAJZ5v0jHDNBqCfmgyLUOs7yUZaEjQ96m5HVZKHP3x7_uamH5zQ@mail.gmail.com> <7A00774E-13F2-4FB4-9979-D7827C92F5B8@gmail.com>
In-Reply-To: <7A00774E-13F2-4FB4-9979-D7827C92F5B8@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 19:44:14 +0200
Message-ID: <CAJZ5v0hSJExYtxEZuw-+ZUf1YoZesOtS+x9UbdoBNXtTKPiYxg@mail.gmail.com>
Subject: Re: [PATCH] : Revert "ACPI: Remove side effect of partly creating a
 node in acpi_get_node()"
To:     Jonathan Lemon <jonathan.lemon@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Len Brown <lenb@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 11, 2022 at 7:42 PM Jonathan Lemon <jonathan.lemon@gmail.com> wrote:
>
> On 11 May 2022, at 10:33, Rafael J. Wysocki wrote:
>
> > On Wed, May 11, 2022 at 7:24 PM Jonathan Lemon <jonathan.lemon@gmail.com> wrote:
> >>
> >> This reverts commit a62d07e0006a3a3ce77041ca07f3c488ec880790.
> >>
> >> The change calls pxm_to_node(), which ends up returning -1
> >> (NUMA_NO_NODE) on some systems for the pci bus, as opposed
> >> to the prior call to acpi_map_pxm_to_node(), which returns 0.
> >>
> >> The default numa node is then inherited by all pci devices, and is
> >> visible in /sys/bus/pci/devices/*/numa_node
> >>
> >> The prior behavior shows:
> >>  # cat /sys/bus/pci/devices/*/numa_node | sort | uniq -c
> >>      122 0
> >>
> >> While the new behavior has:
> >>  # cat /sys/bus/pci/devices/*/numa_node | sort | uniq -c
> >>        1 0
> >>      121 -1
> >>
> >> While arguably NUMA_NO_NODE is correct on single-socket systems which
> >> have only one numa domain, this breaks scripts that attempt to read the
> >> NIC numa_node and pass that to numactl in order to pin memory allocation
> >> when running applications (like iperf).  E.g.:
> >>
> >>   # numactl -p -1 iperf3
> >>   libnuma: Warning: node argument -1 is out of range
> >>   <-1> is invalid
> >>
> >> Reverting this change restores the prior behavior.
> >
> > Well, that's not a recent commit and it fixed a real and serious issue.
> >
> > Isn't there a way to fix this other than reverting it?
>
> The userspace behavior changed - is there another way to fix things
> so that a valid numa_node is returned?

Well, that's my question.
