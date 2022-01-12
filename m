Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF448CE46
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jan 2022 23:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiALWRx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jan 2022 17:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiALWRw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2022 17:17:52 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DE5C061751
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jan 2022 14:17:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i5so15593925edf.9
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jan 2022 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=33k6EULhqoNT8C0bFRWhcDpVds5mWskVOlY+a5+29m0=;
        b=edicIIiBYeE6G3fKcn01uvbuwVX17f1qsKRd+UMXLLUpMyuRUytxbOFWiiyrvHz0t7
         ZaJu/fyNRdfj5YuoOCSScaZAQYJHfLzDgbhn0voVNPhDkeoXr5zr+JidXvd5I/ywN/KG
         5REI/zDAkl902/WsfVMPBTu9Vq8rFNiRC9OyT3OCgLCmOAvJaHTt1WqwwPNcPbOIw/ID
         EWU3FyzEzsJ1mealQzp1vIvhh1PBv8xDsRMoEIRAchQn7CSR2ekkGPKrJnHRuJKHbNjR
         ippIMCh31Z//sbGCqe+HKcK2zmVlN9bJI8e02Gr2t0zveNEWqxV9LdrwTB0IJ89Stxzp
         AhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=33k6EULhqoNT8C0bFRWhcDpVds5mWskVOlY+a5+29m0=;
        b=52a5Cu8/L0QKIZt6EGu9F6aFmfhAdddrUqnk1w9X5a2at3jHEHRYl8EGHtadC1AxDa
         L9KTZPtKMgCFKxLNU0g8EmmCZ5if0e1IzMNssly2uKT1Xa3odFc1CO15XY9uIO5/5ue3
         lsuaOc/4Y7qNAjzkl313Rq5RaprFCOHSCAX1Yoa3iu/8kpzWfCede5tQ24zCkcET7LyO
         z7eP71yQqmksxNhOAR6LLeWimDG1sK4IxGuVLkzdBFchZ9BmATfDh4St7MP5Lvg+Du2F
         V2rrJXhTVXxbjY9sXgKKsuzrTY68t9lr8nl87D+Hksir8TjpXxcMzdwU0z2wWSlTe/hr
         nKxg==
X-Gm-Message-State: AOAM532b83IX2gdTogTr+s5FAjncfWajD7cu0O+ngG1wXKUo5hOjGFE8
        wmBBGLRFiAeIsiUJD9CxjqpDbJ5z4krdCDKgG4BDiw==
X-Google-Smtp-Source: ABdhPJytuYsrVpHkmi+Y4Nlpxkm0BfAiwaQC5e6gL4rxweFaNLe8LQGEn7HkQgcNZAkp606q/X23E3EtT2KW5QNLwuU=
X-Received: by 2002:a05:6402:848:: with SMTP id b8mr1519247edz.79.1642025869621;
 Wed, 12 Jan 2022 14:17:49 -0800 (PST)
MIME-Version: 1.0
References: <CAAJ9+9fq1=EcOaSoo3oD_5QjYNAv6PPDjKS+gC9o7XDp2p1XpQ@mail.gmail.com>
In-Reply-To: <CAAJ9+9fq1=EcOaSoo3oD_5QjYNAv6PPDjKS+gC9o7XDp2p1XpQ@mail.gmail.com>
From:   Zayd Qumsieh <zaydq@rivosinc.com>
Date:   Wed, 12 Jan 2022 14:16:18 -0800
Message-ID: <CAAJ9+9ct3+N0LyH+9N03ZQYUZnF23LFAyWFcnNK4bD7SvaohrQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] cxl/mem: Add CDAT table reading from DOE
To:     jonathan.cameron@huawei.com
Cc:     alison.schofield@intel.com, ben.widawsky@intel.com,
        cbrowy@avery-design.com, dan.j.williams@intel.com,
        f.fangjian@huawei.com, helgaas@kernel.org, ira.weiny@intel.com,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, vishal.l.verma@intel.com,
        Dylan Reid <dylan@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello all,

Due to issues with vger.kernel.org marking HTML emails as spam, I'll
be resending the email in plain text:



Hello all, First off, thanks for your work on implementing PCI Data
Object Exchange in QEMU and Linux.

1. Are these patches still being worked on? If not, I=E2=80=99ll try to get
them rebased and finished.

2. Are there any notes not mentioned in the emails you feel are
important to know about?

3. I'm particularly interested in the testing framework - the emails
mention that a lot of testing has been done through QEMU but how can I
carry out these tests on my own? What tools did you use?

Thanks,

Zayd
