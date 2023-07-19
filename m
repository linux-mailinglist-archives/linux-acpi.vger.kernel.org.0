Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7DD759A52
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jul 2023 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGSP7U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 19 Jul 2023 11:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGSP7U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jul 2023 11:59:20 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FC6113
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jul 2023 08:59:19 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-98502b12fd4so156346566b.1
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jul 2023 08:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689782358; x=1690387158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8pvRGqRkNJMTBEOxWWjJMX8BsB3gGHz6eZzcM2M8u4=;
        b=FgcCMXHPLhLxa43uGNVa4le6xGmWkqDHj+CHX5qYJtdxeAOb/6SdKU0xmW9mSoh63m
         atCDS6wd3omAesqKKuY2I4h4tLNclApcZBXjEL8/ERbCYnjTkg/5U05Lhtb1Wte36JJw
         zaJ9g2UAp6FkvHDeb3LH+Pp3MejSUyEa82m+LMjBszib0B/TwSbK1Xd0p2eHG87kyaWb
         YgtKtRW0TZCLxgOyoB3FB4mwNINwDPfR+Wi/Tg+H+Qwkyi5lAsEO0Gj53FCbiGFQo9D6
         IbyuW+R/Gg/vwV0NSWqxNaWIO7uP5Ym9eRXSz/D8+zWgNoL8V06s7uhzr2wjjCbIXt+A
         yc0Q==
X-Gm-Message-State: ABy/qLbClzM0543sZzxyMBGMrjYXWRMJlQGLXwf5n5rn/E1nVC8GhIto
        14H1lU0LQ23gYG+CtCv928PZx6k2Seve3zGDXTs=
X-Google-Smtp-Source: APBJJlFFIgKwoFETsyz/pxizCBCJArUyLlCRWAIT2G+DT3QPwhD9Q3UDRMdAnBv36BwxFiwdcVjJzvtn7INZdxGIHAk=
X-Received: by 2002:a17:906:2086:b0:992:387:44d1 with SMTP id
 6-20020a170906208600b00992038744d1mr7943792ejq.7.1689782357841; Wed, 19 Jul
 2023 08:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230717150047.15196-1-cezary.rojewski@intel.com> <199bdc7f-a549-fe70-5a2a-6d0e7d3417aa@intel.com>
In-Reply-To: <199bdc7f-a549-fe70-5a2a-6d0e7d3417aa@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jul 2023 17:59:06 +0200
Message-ID: <CAJZ5v0hSMu22RF2Q=i66azRe67J+tiN2qD-aMOHRsvqMv4nvtQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ACPI: NHLT: Access and query helpers
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     rafael@kernel.org, robert.moore@intel.com,
        pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 19, 2023 at 4:56 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2023-07-17 5:00 PM, Cezary Rojewski wrote:
> > The goal of this patchset is to enhance existing interface of
> > NonHDAudioLinkTable (NHLT), that is, accessing device and format
> > configuration spaces as well as adding query functions for finding
> > specific endpoints and format configurations. Once that is done,
> > existing sound-drivers can move from utilizing sound/hda/intel-nhlt.c
> > to this very code and ultimately the former file can be removed.
>
> Hello Rafael and Robert,
>
> Given recent question from Pierre regarding licensing, I've scanned
> acpi/ tree for SPDXes used and must admit that I'm lost. There is a mix
> of GPL-2.0, GPL-2.0-or-later and dual BSD-3.0-and-GPL-2.0. The preferred
> kernel license is GPL-2.0 but given what's out there I have my doubts
> about acpi tree.
>
> Could you provide your insight on the subject?

All ACPICA is dual BSD-3-Clause or GPL-2.0 and everything outside it
in the kernel should be GPL-2.0 (especially new code), unless you
specifically want to make it dual-license for some reason.
