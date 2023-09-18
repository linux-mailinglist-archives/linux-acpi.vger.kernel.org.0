Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF74F7A4D74
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Sep 2023 17:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjIRPuT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Sep 2023 11:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRPuO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 11:50:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5140619A9
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 08:48:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fbd5cd0ceso4113299b3a.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695051887; x=1695656687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wjwnQuWLqBuqHHePcbwE6HOFAODXq0xOeoDZDFFs4M=;
        b=couy5T/RPZvCTHuG5aOhGJPcXlbv3xDbUd82y9k4hG3eEQvLWZB8nuX87yC7dlAoRr
         AVhsDgiswsHhSN9BTXSf1K7JpTeBx0Tz704GQFQkrieQf7xuVEEj0Oa9ismHlrm5Llaf
         PuFey+5sQXlgzsTFywEp1rLQ9Lw7SCP9PaE/4ZSQokul83oo5NVpNarO9uLgUF0ktyZs
         jKDloloUZOIt5JnlEuWCr36xsenpJIFFX7rVhlfTdioe1/pAUQ3ZX9JpcCkPOJjcZidb
         0qNlbmvsmMQBp1E+p86bDbFj064yKxP2yu5wp8FIIjs8R5845N2Hfv5/+TC882/O6tR+
         G6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051887; x=1695656687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wjwnQuWLqBuqHHePcbwE6HOFAODXq0xOeoDZDFFs4M=;
        b=YVje+/b6Q40E9PEfWTGSEuqtarEKEsmJG/Ve4drxoTeeLcIP2PEh7xF3K57CkCcFNf
         08WmmRr/reLA7i4do4DvUgxDrzvbYczkvGjoIWEw3sMpHjTMGT+aUl3Si8xYgZSGsKP0
         3bu/NZXeGWcPD08E34jOo5RKRbRSr62eiBNO85NUJ+wRtlzaYylNKPOFz/mEvOrWcWsT
         C504DLw14J4dnOefY6ljKX/kIgdTmYTFBS179JYgjTFIu3VqiuD6u86qL7DeF089y7zv
         EktYoKGXaiRQklL8Bd8GjhNfDiMWWcEjmkB65QLfzGGJDEzK6LBllje8jdjqzMkPEBQK
         P+dA==
X-Gm-Message-State: AOJu0YwWF4hNs7gJOl+SSDdDW80SMoLAN4r3fpjEs4D/sncT6eZJr6G3
        RQ/H33KnH35MN+nPM1CNVGB/sA==
X-Google-Smtp-Source: AGHT+IFrHyFSpMrYxFd1CzpgiW8cxKrPK+JTGJHwLtMowpSHfFd0XUapTCjUSV1JVLyr13YQgJlfAQ==
X-Received: by 2002:a05:6a00:23c4:b0:68f:a661:d037 with SMTP id g4-20020a056a0023c400b0068fa661d037mr12576625pfc.3.1695051887294;
        Mon, 18 Sep 2023 08:44:47 -0700 (PDT)
Received: from PF2LML5M-SMJ.lan ([103.175.14.91])
        by smtp.gmail.com with ESMTPSA id s12-20020a62e70c000000b0068e4c5a4f3esm7287611pfh.71.2023.09.18.08.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:44:46 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     rafael@kernel.org
Cc:     guojinhui.liam@bytedance.com, gregkh@linuxfoundation.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        lkp@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v6] driver core: platform: set numa_node before platform_device_add()
Date:   Mon, 18 Sep 2023 23:44:41 +0800
Message-Id: <20230918154441.442-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230918134527.252-1-guojinhui.liam@bytedance.com>
References: <20230918134527.252-1-guojinhui.liam@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> On Mon, Sep 18, 2023 at 2:41 PM Jinhui Guo <guojinhui.liam@bytedance.com> wrote:
> >
> > On Mon, 18 Sep 2023 12:30:58 +0200, Rafael J. Wysocki wrote:
> > > On Thu, Sep 14, 2023 at 11:32 PM Jinhui Guo
> > > <guojinhui.liam@bytedance.com> wrote:
> > > >
> > > > platform_add_device()
> > >
> > > According to "git grep" this function is not present in 6.6-rc2.
> > >
> > > If you mean platform_device_add(), please update the patch subject and
> > > changelog accordingly.
> > >
> >
> > This is my mistake, the function name was written wrong.
> > I will fix it in the next patch.
> >
> > > > creates the numa_node attribute of sysfs according
> > > > to whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
> > > > of device before creating numa_node attribute of sysfs.
> > >
> > > It would be good to also say that this needs to be done in
> > > platform_device_register_full(), because that's where the platform
> > > device object is allocated.
> > >
> >
> > Thaks for your suggestion. I will modify my decription soon.
> >
> > > However, what about adding the NUMA node information to pdevinfo?  It
> > > would be more straightforward to handle it then AFAICS.
> > >
> >
> > I have tried three potential solutions to fix the bug:
> > 1. The first one is what the current patch do.
> >
> > 2. Add a new function interface only for acpi_create_platform_device() call.
> >    But the code will be a bit redundant.
> >
> > 3. Add an member "numa_node" in `struct platform_device_info`, just as what
> >    `struct device` done:
> >
> > ```
> > struct platform_device_info {
> >         ...;
> > #ifdef CONFIG_NUMA
> >         int             numa_node;
> > #endif
> > ```
> >
> > But not all the call to platform_device_register_full() would set numa_node,
> > and many of them use ` memset(&pdevinfo, 0, sizeof(pdevinfo));` to initialize
> > `struct platform_device_info`. It could initialize numa_node to zero and
> > result in wrong numa_node information in sysfs.
> 
> Well, platform_device_register_full() need not take that value as the
> numa node number directly.  It may, for example, take the number from
> pdevinfo, subtract 1 from it and use the result of that as the numa
> node number, if not negative.

It's a good idea. I will try to fix the bug in this way.

Thanks,

Jinhui Guo
