Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1598244C20
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Aug 2020 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHNP3F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Aug 2020 11:29:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32910 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgHNP3E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2020 11:29:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id t7so7876482otp.0;
        Fri, 14 Aug 2020 08:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBVBMvKKxks/kGkJ4ndBszEEsQk9CsCHA7aFPfw0OnY=;
        b=ZiGghja38wB46vjSAhPbNDcDO67HuzxVsxaTnxsqrwYqpappI5vA74zYA8elDpnbHO
         b6eolEASrnyrgCDCS+7HKZQtyNuFJQPEk0ITo5flWZb0FaE6R9qTkC+hIDScY7ODWr+V
         Rtp7UVzhzmQOd0ZcdfTXEdIoCe/H5/m46pGNNci3+xQtZ4SU4R4lNeOCSFyUGCs/os9c
         PYOraUS+bKHElG91GQF9qbMLfJDyZeymRRxyzNgvohqJL1GJ4bc9Ua1OT4xUNJ2u5qAV
         4DeBr/p5w+s8t95VpFb5i9v8DDm4bFy1euWoKMt9loO+x83L4JVoY3k2aZ6/xhZeSVPP
         4QCQ==
X-Gm-Message-State: AOAM533fuZLW30hpxtL7P76Y1ruhROffX6yKCpvyiPPeIfu3gG2ouafR
        qUOwRU61GgZjfshUY77aq62JKG5akJZgQiCrBbg=
X-Google-Smtp-Source: ABdhPJz1T4tJ8ofzUGM0XQjCNBZ6PvK5Zq6i4UC8Y+eAkenmq/nx3KmnaWGeq6j/7fuAaFaAt8U6C3Dv5bPtU6dw8Nw=
X-Received: by 2002:a05:6830:1c74:: with SMTP id s20mr2165582otg.167.1597418944007;
 Fri, 14 Aug 2020 08:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <1597286952-5706-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1597286952-5706-1-git-send-email-wangqing@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Aug 2020 17:28:52 +0200
Message-ID: <CAJZ5v0h=UmD33X_i80X3ww7nC=xQL7V8XaoNq2XvU_XcdQGfZQ@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: Use kobj_to_dev() instead
To:     Wang Qing <wangqing@vivo.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 13, 2020 at 4:54 AM Wang Qing <wangqing@vivo.com> wrote:
>
> Use kobj_to_dev() instead of container_of()
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>

LGTM

Dan, any objections?

> ---
>  drivers/acpi/nfit/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index fa4500f..3bb350b
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1382,7 +1382,7 @@ static bool ars_supported(struct nvdimm_bus *nvdimm_bus)
>
>  static umode_t nfit_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
>
>         if (a == &dev_attr_scrub.attr && !ars_supported(nvdimm_bus))
> @@ -1667,7 +1667,7 @@ static struct attribute *acpi_nfit_dimm_attributes[] = {
>  static umode_t acpi_nfit_dimm_attr_visible(struct kobject *kobj,
>                 struct attribute *a, int n)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct nvdimm *nvdimm = to_nvdimm(dev);
>         struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>
> --
> 2.7.4
>
