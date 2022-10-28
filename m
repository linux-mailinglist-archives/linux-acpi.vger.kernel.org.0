Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A008611A12
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Oct 2022 20:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiJ1SZ3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Oct 2022 14:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1SZ2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Oct 2022 14:25:28 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1657435D
        for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2022 11:25:26 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id k4so1094092qkj.8
        for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2022 11:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQO3gevuQyurHuvPPfbnljg16Dr3s73aLVlIfvXtcEE=;
        b=mBkWEFKKDTt6KigqCCNlh2pWdwlEzb6qE9z3UN7QDD7iCL9s4RCsetKoKcTxt6gUXv
         f1jvF9hjXH5KlC5tJT1zZeM9Uf6X8Wr6XqfqZLn+160GEVXJhjzlOBYJJJ5RE8FlXOzr
         UgwWf8oRSc5KDer1P7+LrXGtwXltBih3mXnow3hEa3Liwt3+F+PcsWrLULvXk3p76Wyl
         5b4I65coFMJWlN+5PQs34og0YC9d1/VMhZ+537V6fOCwEo7CLjv8JpkpCRPRIfUioceH
         lAsWXWjM7bA0RnLUL76U3jHBL7PsFq3bhd8+EKbSpyv63SmafnxOU1UyM83i3Sdy+gIQ
         jcQQ==
X-Gm-Message-State: ACrzQf0Sb1yNkcl1SIr+sb2KztCA7rIv8xz/S1Eub91+ikcGc4MRaRVE
        j8H+PK55bWTuMdl6Z7fXxFM35biao8SXZJTyY2U=
X-Google-Smtp-Source: AMsMyM6cUbm3cHfjL8CoKUhxPIEWD4mH0siHczuaC//Mungc2CDK+eJJKWzq+ggitc+ok1ORixD/9euNCEzLQLoYUW0=
X-Received: by 2002:a37:b1c2:0:b0:6fa:1185:4dbf with SMTP id
 a185-20020a37b1c2000000b006fa11854dbfmr439335qkf.764.1666981525264; Fri, 28
 Oct 2022 11:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <e0f06714-5a49-a4e6-24e6-c4103c820819@alu.unizg.hr>
 <9ef3674afd370050b86a68e44c97e4f0257f1adf.camel@linux.intel.com>
 <bd1f0d2a-d456-92cc-ecca-23e480aea4b1@alu.unizg.hr> <e5d3d561bb3a9c68bc903cfc35c27629a4a9225c.camel@linux.intel.com>
 <d034dbbc-613c-1a5e-df64-d0251453c8eb@alu.unizg.hr> <6c2f47c8-d6b5-074a-4c8f-e9cd04f62ef4@alu.unizg.hr>
 <180b1a4fb9cf78c8905f275e0373e009224d4639.camel@linux.intel.com>
 <78e347e9-c8b1-f228-ca32-0ad6186a6285@alu.unizg.hr> <a4457f46-72c9-f9b0-b87a-cb3dd5cd066f@alu.unizg.hr>
In-Reply-To: <a4457f46-72c9-f9b0-b87a-cb3dd5cd066f@alu.unizg.hr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 20:25:14 +0200
Message-ID: <CAJZ5v0jfHtOXDFUFYj8EOGMT74iWfkQqEW3L2D2dZv6Y1jFSrw@mail.gmail.com>
Subject: Re: BUG: bisected: thermald regression (MEMLEAK) in commit c7ff29763989bd09c433f73fae3c1e1c15d9cda4
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 27, 2022 at 8:20 PM Mirsad Goran Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> Re-sending compressed attachments to fit into the size limit.
>
> On 27. 10. 2022. 20:03, Mirsad Goran Todorovac wrote:
> > P.S.
> >
> > Forgot another useful thing you've mentioned: please find attached the
> > dmesg output.
> >
> > Good luck!

I'm wondering if the problem is reproducible with this patch applied:

https://patchwork.kernel.org/project/linux-acpi/patch/20221019073443.248215-1-chenzhongjin@huawei.com/
